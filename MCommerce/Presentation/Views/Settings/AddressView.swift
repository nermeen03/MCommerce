import SwiftUI
import MapKit
import CoreLocation


import SwiftUI
import MapKit

struct AddressFormView: View {
    @State private var address1: String = ""
    @State private var address2: String = ""
    @State private var selectedCountry: String = "Egypt"
    @State private var selectedCity: String = "Cairo"
    @State private var zipCode: String = ""
    @State private var phoneNumber: String = ""
    @State private var isDefault: Bool = false
    
    @State private var showMap = false
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    
    @State var countries = ["Egypt"]
    @State var egyptCities = ["Cairo", "Alexandria", "Giza", "Aswan"]
    
    @ObservedObject var viewModel: SettingsViewModel

    
    var body: some View {
        ScrollView {
            VStack(alignment: .center,spacing: 25) {
                Spacer()
                TextField("Street Address", text: $address1)
                    .textFieldStyle(.roundedBorder).font(.title2)
                
                TextField("Apartment, suite, etc.", text: $address2)
                    .textFieldStyle(.roundedBorder).font(.title2)
                
                HStack(spacing: 16) {
                    Picker("Country", selection: $selectedCountry) {
                        ForEach(countries, id: \.self) { country in
                            Text(country)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onAppear {
                        if !countries.contains(selectedCountry) {
                            selectedCity = countries.first ?? ""
                        }
                    }
                    
                    Picker("City", selection: $selectedCity) {
                        ForEach(egyptCities, id: \.self) { city in
                            Text(city)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onAppear {
                        if !egyptCities.contains(selectedCity) {
                            selectedCity = egyptCities.first ?? ""
                        }
                    }
                    
                    Spacer()

                    Button("Map") {
                        showMap = true
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                .sheet(isPresented: $showMap) {
                    LocationPickerMap { coordinate in
                        self.selectedCoordinate = coordinate
                        getAddress(for: coordinate) { city, country in
                            if let city = city {
                                if !egyptCities.contains(city) {
                                    egyptCities.append(city)
                                }
                                selectedCity = city
                            }else{
                                selectedCity = "Unknown"
                            }
                            if let country = country {
                                if !countries.contains(country) {
                                    countries.append(country)
                                }
                                selectedCountry = country
                            }else{
                                selectedCountry = "Unknown"
                            }
                            print(self.selectedCity, self.selectedCountry)
                        }
                        showMap = false
                    }
                }
            
                
                TextField("ZIP Code", text: $zipCode)
                    .keyboardType(.numbersAndPunctuation)
                    .textFieldStyle(.roundedBorder).font(.title2)
                
                TextField("Phone Number", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .textFieldStyle(.roundedBorder).font(.title2)
                
                Toggle("Set as Default Address", isOn: $isDefault)
                    .padding(.vertical)

                Button("Save Address") {
                    let address = AddressInfo(
                        defaultAddress: isDefault,
                        id: UUID().uuidString,
                        address1: address1,
                        address2: address2,
                        city: selectedCity,
                        province: selectedCity,
                        zip: zipCode,
                        country: selectedCountry,
                        phone: phoneNumber
                    )
                    print(address)
                    let addressInput: [String: Any] = [
                        "address1": "123 Example St",
                        "address2": "Apt 4",
                        "city": "Cairo",
                        "province": "Cairo",
                        "zip": "12345",
                        "country": "Egypt",
                        "phone": "+20123456789"
                    ]

                    createCustomerAddress(customerAccessToken: "UserId", address: addressInput) { result in
                        switch result {
                        case .success(let address):
                            print("✅ Address created: \(address)")
                        case .failure(let error):
                            print("❗️ Error creating address:", error.localizedDescription)
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Add Address")
    }
    func getAddress(for coordinate: CLLocationCoordinate2D, completion: @escaping (String?, String?) -> Void) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                completion(nil, nil)
                return
            }
            let city = placemark.locality
            let country = placemark.country
            completion(city, country)
        }
    }
}

struct LocationPickerMap: View {
    var onLocationChosen: (CLLocationCoordinate2D) -> Void

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357),
        span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
    )

    var body: some View {
        VStack {
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, annotationItems: [region.center]) { coordinate in
                MapMarker(coordinate: coordinate, tint: .red)
            }
            .ignoresSafeArea()

            Button("Choose This Location") {
                onLocationChosen(region.center)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding()
        }
    }
}

extension CLLocationCoordinate2D: @retroactive Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

#Preview {
    AddressFormView(viewModel:SettingsViewModel())
}
