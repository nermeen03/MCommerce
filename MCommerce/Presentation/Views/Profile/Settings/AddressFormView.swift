
import SwiftUI
import MapKit

struct AddressFormView: View {
    @EnvironmentObject var coordinator: AppCoordinator

    @State private var address1: String = ""
    @State private var address2: String = ""
    @State private var selectedCountry: String = "Egypt"
    @State private var selectedCity: String = "Cairo"
    @State private var selectedType: String = "Home"
    @State private var zipCode: String = ""
    @State private var phoneNumber: String = ""
    @State private var name: String = ""
    @State private var isDefault: Bool = false
    @State private var showToast: Bool = false
    
    @State private var showMap = false
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    
    @State var countries = ["Egypt"]
    @State var cities = ["Cairo", "Alexandria", "Giza", "Aswan"]
    var types = ["Home","Work","School","Other"]
    
    @ObservedObject var viewModel : AddressFormViewModel
    
    
//    @State var errorMessage : ValidationError?

    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                
                TextField("Phone Number", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .textFieldStyle(.roundedBorder)
                    .font(.title2)
                
                Divider().padding(.vertical, 5)
                
                VStack(spacing: 12) {
                    TextField("Street Address", text: $address1)
                        .textFieldStyle(.roundedBorder)
                        .font(.title2)
                    
                    TextField("Apartment, suite, etc.", text: $address2)
                        .textFieldStyle(.roundedBorder)
                        .font(.title2)
                }
                
                VStack(spacing: 12) {
                    Picker("Country", selection: $selectedCountry) {
                        ForEach(countries, id: \.self) { country in
                            Text(country)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onAppear {
                        if !countries.contains(selectedCountry) {
                            selectedCountry = countries.first ?? ""
                        }
                    }
                    
                    Picker("City", selection: $selectedCity) {
                        ForEach(cities, id: \.self) { city in
                            Text(city)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onAppear {
                        if !cities.contains(selectedCity) {
                            selectedCity = cities.first ?? ""
                        }
                    }
                    
                    Button("Pick on Map") {
                        showMap = true
                    }
                    .buttonStyle(.borderedProminent)
                }
                .sheet(isPresented: $showMap) {
                    LocationPickerMap { coordinate in
                        self.selectedCoordinate = coordinate
                        viewModel.getAddressFromMap(for: coordinate){ street, apartment, city, country in
                            
                            if let street = street {
                                address1 = street
                            }else{
                                address1 = "Unknown"
                            }
                            
                            if let apartment = apartment {
                                address2 = apartment
                            }else{
                                address2 = "Unknown"
                            }
                            
                            if let city = city {
                                if !cities.contains(city) { cities.append(city) }
                                selectedCity = city
                            } else {
                                selectedCity = "Unknown"
                            }
                            
                            if let country = country {
                                if !countries.contains(country) { countries.append(country) }
                                selectedCountry = country
                            } else {
                                selectedCountry = "Unknown"
                            }
                            print(self.selectedCity, self.selectedCountry)
                        }
                        showMap = false
                    }
                }
                
                Divider().padding(.vertical, 5)

                Picker("Type", selection: $selectedType) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                Toggle("Set as Default Address", isOn: $isDefault)
                    .padding(.vertical)
                    .disabled(viewModel.defaultAddress && viewModel.addressDetailViewModel?.address?.defaultAddress != true)
                    .opacity(viewModel.defaultAddress && viewModel.addressDetailViewModel?.address?.defaultAddress != true ? 0.5 : 1)
                    .onTapGesture {
                        if (viewModel.defaultAddress && viewModel.addressDetailViewModel?.address?.defaultAddress != true ){
                            showToast = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showToast = false
                            }
                        }
                    }.toast(isShowing: $showToast, message: "There is already a default address set.")

                Button("Save Address") {
                    let validate = viewModel.validateAllFields(phoneNumber: phoneNumber, address1: address1, address2: address2)
                    if validate == nil{
                        let id = self.viewModel.addressDetailViewModel != nil ? self.viewModel.addressDetailViewModel?.address!.id : UUID().uuidString
                        
                        let newAddress = AddressInfo(
                            defaultAddress: isDefault,
                            id: id!,
                            address1: address1,
                            address2: address2,
                            city: selectedCity,
                            country: selectedCountry,
                            phone: phoneNumber,
                            type: selectedType
                        )
                        
                        if self.viewModel.addressDetailViewModel == nil{
                            viewModel.saveAddress(address: newAddress)
                        }
                        else{
                            viewModel.addressDetailViewModel?.address = newAddress
                            viewModel.saveAddress(address: newAddress,update: true)
                        }
                        coordinator.goBack()
                    }
                    
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
                .alert(item: $viewModel.errorMessage) { msg in
                    Alert(title: Text("Validation Error"), message: Text(msg.message), dismissButton: .default(Text("OK")))
                }
            }
            .padding()
            .onAppear {
                viewModel.getDefaultAddress()
                if let address = viewModel.addressDetailViewModel?.address! {
                    phoneNumber = address.phone
                    address1 = address.address1
                    address2 = address.address2
                    selectedCountry = address.country
                    selectedCity = address.city
                    isDefault = address.defaultAddress
                    selectedType = address.type
                }
            }
        }
    }
    
}


//#Preview {
//    AddressFormView(defaultAddress: DefaultAddressViewModel(), viewModel:AddressViewModel())
//}
