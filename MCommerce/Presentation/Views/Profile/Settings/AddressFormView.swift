
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
    
    @ObservedObject var viewModel : AddressFormViewModel

    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .top) {

                    FormField(title: "Phone Number") {
                        TextField("Phone Number", text: $phoneNumber)
                            .keyboardType(.phonePad)
                            .textContentType(.telephoneNumber)
                            .autocapitalization(.none)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                   
                    FormField(title: "Type") {
                        Picker("Type", selection: $selectedType) {
                            ForEach(types, id: \.self) { type in
                                Text(type).foregroundStyle(Color.deepPurple)
                            }
                            .foregroundStyle(Color.deepPurple)
                        }
                        .foregroundStyle(Color.deepPurple)
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: 100,maxHeight: 23)
                    }
                }
                Divider()

                VStack {
                    FormField(title: "Street Address") {
                        TextField("Street Address", text: $address1)
                    }
                    
                    FormField(title: "Apartment, suite, etc.") {
                        TextField("Apartment, suite, etc.", text: $address2)
                    }

                    HStack(spacing: 16) {
                        FormField(title: "City") {
                            Picker("City", selection: $selectedCity) {
                                ForEach(cities, id: \.self) { Text($0) }
                            }
                            .foregroundStyle(Color.deepPurple)
                            .pickerStyle(MenuPickerStyle())
                        }

                        FormField(title: "Country") {
                            Picker("Country", selection: $selectedCountry) {
                                ForEach(countries, id: \.self) { Text($0) }
                            }
                            .foregroundStyle(Color.deepPurple)
                            .pickerStyle(MenuPickerStyle())
                        }
                    }

                    HStack {
                        Divider()
                        Text("or")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.secondary, lineWidth: 1)
                            )
                        Divider()
                    }
                    .frame(maxWidth: .infinity)

                    LocationPickerMap { coordinate in
                        self.selectedCoordinate = coordinate
                        viewModel.getAddressFromMap(for: coordinate) { street, apartment, city, country in
                            address1 = street ?? "Unknown"
                            address2 = apartment ?? "Unknown"

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
                        }
                    }
                    .frame(height: 300)
                }


                Divider()

                VStack(spacing: 20) {
                    Toggle("Set as Default Address", isOn: $isDefault)
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(radius: 2)
//                        .disabled(viewModel.defaultAddress && viewModel.addressDetailViewModel?.address?.defaultAddress != true)
//                        .opacity(viewModel.defaultAddress && viewModel.addressDetailViewModel?.address?.defaultAddress != true ? 0.5 : 1)
//                        .onTapGesture {
//                            if viewModel.defaultAddress && viewModel.addressDetailViewModel?.address?.defaultAddress != true {
//                                showToast = true
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                    showToast = false
//                                }
//                            }
//                        }
//                        .toast(isShowing: $showToast, message: "There is already a default address set.")

                    Button("Save Address") {
                        let validate = viewModel.validateAllFields(phoneNumber: phoneNumber, address1: address1, address2: address2)
                        if validate == nil {
                            let id = viewModel.addressDetailViewModel?.address?.id ?? UUID().uuidString
                            let newAddress = AddressInfo(
                                defaultAddress: isDefault,
                                id: id,
                                address1: address1,
                                address2: address2,
                                city: selectedCity,
                                country: selectedCountry,
                                phone: phoneNumber,
                                type: selectedType
                            )
                            if viewModel.addressDetailViewModel == nil {
                                if viewModel.defaultAddress && viewModel.addressDetailViewModel?.address?.defaultAddress != true && isDefault == true{
                                    viewModel.setError()
                                }else{
                                    viewModel.saveAddress(address: newAddress)
                                    coordinator.goBack()
                                }
                            } else {
                                if viewModel.defaultAddress && viewModel.addressDetailViewModel?.address?.defaultAddress != true && isDefault == true{
                                    viewModel.setError()
                                }else{
                                    viewModel.addressDetailViewModel?.address = newAddress
                                    viewModel.saveAddress(address: newAddress, update: true)
                                    coordinator.goBack()
                                }
                            }
                        }
                    }
                    .font(.system(size: 18, weight: .bold))
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.deepPurple)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
            }
            .padding()
            .onAppear {
                viewModel.getDefaultAddress()
                if let address = viewModel.addressDetailViewModel?.address {
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
        .alert(item: $viewModel.currentAlert) { alert in
            switch alert {
            case .validationError(let message):
                return Alert(
                    title: Text("Validation Error"),
                    message: Text(message),
                    dismissButton: .default(Text("OK"))
                )
            case .changeDefaultAddress:
                return Alert(
                    title: Text("Do you want to change?"),
                    message: Text("There is already a default address set."),
                    primaryButton: .destructive(Text("Change and Save")) {
                        let id = viewModel.addressDetailViewModel?.address?.id ?? UUID().uuidString
                        let newAddress = AddressInfo(
                            defaultAddress: false,
                            id: id,
                            address1: address1,
                            address2: address2,
                            city: selectedCity,
                            country: selectedCountry,
                            phone: phoneNumber,
                            type: selectedType
                        )
                        viewModel.switchDeafult(address: newAddress)
                        coordinator.goBack()
                    },
                    secondaryButton: .cancel(Text("Don't Change and Save")) {
                        let id = viewModel.addressDetailViewModel?.address?.id ?? UUID().uuidString
                        let newAddress = AddressInfo(
                            defaultAddress: false,
                            id: id,
                            address1: address1,
                            address2: address2,
                            city: selectedCity,
                            country: selectedCountry,
                            phone: phoneNumber,
                            type: selectedType
                        )
                        if viewModel.addressDetailViewModel == nil {
                            viewModel.saveAddress(address: newAddress)
                        } else {
                            viewModel.saveAddress(address: newAddress, update: true)
                        }
                        coordinator.goBack()
                    }
                )
            }
        }
    }
    
}
@ViewBuilder
func FormField<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
    VStack(alignment: .leading, spacing: 6) {
        Text(title)
            .font(.subheadline)
            .foregroundColor(.secondary)
        content()
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 2)
    }
}
