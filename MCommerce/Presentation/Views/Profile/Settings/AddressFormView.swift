
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
    
    @State private var showMap = false
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    
    @State var countries = ["Egypt"]
    @State var cities = ["Cairo", "Alexandria", "Giza", "Aswan"]
    var types = ["Home","Work","School","Other"]
    
    var viewModel: AddressViewModel
    var address : AddressInfo?

    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .font(.title2)
                
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
                        viewModel.getAddress(for: coordinate) { city, country in
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
                
                TextField("ZIP Code", text: $zipCode)
                    .keyboardType(.numbersAndPunctuation)
                    .textFieldStyle(.roundedBorder)
                    .font(.title2)
                
                Picker("Type", selection: $selectedType) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                Toggle("Set as Default Address", isOn: $isDefault)
                    .padding(.vertical)
                
                Button("Save Address") {
                    let id = self.address != nil ? self.address!.id : UUID().uuidString

                    let address = AddressInfo(
                        defaultAddress: isDefault,
                        id: id,
                        address1: address1,
                        address2: address2,
                        city: selectedCity,
                        zip: zipCode,
                        country: selectedCountry,
                        phone: phoneNumber,
                        name: name,
                        type: selectedType
                    )
                    
                    print(address)
                    if self.address == nil{
                        viewModel.saveToFireStore(address: address)
                    }else{
                        viewModel.updateFireStore(address: address)
                    }
                    coordinator.goBack()
                    
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
            }
            .padding()
            .onAppear {
                if let address = address {
                    name = address.name ?? ""
                    phoneNumber = address.phone ?? ""
                    address1 = address.address1 ?? ""
                    address2 = address.address2 ?? ""
                    selectedCountry = address.country ?? "Egypt"
                    selectedCity = address.city ?? "Cairo"
                    zipCode = address.zip ?? ""
                    isDefault = address.defaultAddress
                    selectedType = address.type
                }
            }
        }
    }
    
}


#Preview {
    AddressFormView(viewModel:AddressViewModel())
}
