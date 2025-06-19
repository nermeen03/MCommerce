//
//  AddressViewModel.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation
import FirebaseFirestore

class AddressViewModel : ObservableObject{
    @Published var addressesList: [AddressInfo] = []
    let firestoreUserId = UserDefaultsManager.shared.getUserId()!.replacingOccurrences(of: "/", with: "_")

    func saveToFireStore(address : AddressInfo){
        let db = Firestore.firestore()
        let data: [String: Any] = [
            "address1": address.address1 ?? "Unknown",
            "address2": address.address2 ?? "Unknown",
            "city": address.city ?? "Unknown",
            "country": address.country ?? "Unknown",
            "zip": address.zip ?? "Unknown",
            "phone": address.phone ?? "Unknown",
            "name": address.name ?? "Unknown",
            "type": address.type,
            "default": address.defaultAddress
        ]
        
        db.collection("users").document(firestoreUserId)
            .collection("addresses").document(address.id)
            .setData(data) { error in
                if let error = error {
                    print("Error saving address:", error)
                } else {
                    print("Address saved successfully.")
                }
            }
    }

    func updateFireStore(address : AddressInfo){
        let db = Firestore.firestore()
        
        let data: [String: Any] = [
            "address1": address.address1 ?? "Unknown",
            "address2": address.address2 ?? "Unknown",
            "city": address.city ?? "Unknown",
            "country": address.country ?? "Unknown",
            "zip": address.zip ?? "Unknown",
            "phone": address.phone ?? "Unknown",
            "name": address.name ?? "Unknown",
            "type": address.type,
            "default": address.defaultAddress
        ]
        
        db.collection("users").document(firestoreUserId)
            .collection("addresses").document(address.id)
            .updateData(data) { error in
                if let error = error {
                    print("Error Updating address:", error)
                } else {
                    print("Address updated successfully.")
                }
            }
    }

    func getFromFireStore() {
        let db = Firestore.firestore()
        let addressesRef = db.collection("users").document(firestoreUserId).collection("addresses")
        
        addressesRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching addresses: \(error)")
                self.addressesList = []
                return
            }
            
            let addresses = snapshot?.documents.compactMap { doc -> AddressInfo? in
                let data = doc.data()
                return AddressInfo(
                    defaultAddress: data["default"] as? Bool ?? false,
                    id: doc.documentID,
                    address1: data["address1"] as? String,
                    address2: data["address2"] as? String,
                    city: data["city"] as? String,
                    zip: data["zip"] as? String,
                    country: data["country"] as? String,
                    phone: data["phone"] as? String,
                    name: data["name"] as? String,
                    type: data["type"] as? String ?? "Home"

                )
            } ?? []
            
            self.addressesList = addresses
        }
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
    
    func deleteAddress(at offsets: IndexSet) {
        offsets.forEach { index in
            self.deleteAddressFromFirestore(addressId: self.addressesList[index].id)
        }
        self.addressesList.remove(atOffsets: offsets)
    }
    
    func deleteAddressFromFirestore(addressId: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(firestoreUserId)
            .collection("addresses")
            .document(addressId)
            .delete { error in
                if let error = error {
                    print("Error deleting address: \(error.localizedDescription)")
                } else {
                    print("Address successfully deleted.")
                    self.getFromFireStore()
                }
            }
    }
    
}

class DefaultAddressViewModel : ObservableObject{
    let firestoreUserId = UserDefaultsManager.shared.getUserId()!.replacingOccurrences(of: "/", with: "_")
    @Published var defaultAddress: AddressInfo?
    
    func getDefaultAddress() {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(firestoreUserId)
            .collection("addresses")
            .whereField("default", isEqualTo: true)
            .limit(to: 1)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching default address: \(error)")
                    self.defaultAddress = nil
                    return
                }
                
                guard let document = snapshot?.documents.first else {
                    print("No default address found.")
                    self.defaultAddress = nil
                    return
                }
                
                let data = document.data()
                DispatchQueue.main.async {
                    self.defaultAddress = AddressInfo(
                        defaultAddress: data["default"] as? Bool ?? false,
                        id: document.documentID,
                        address1: data["address1"] as? String,
                        address2: data["address2"] as? String,
                        city: data["city"] as? String,
                        zip: data["zip"] as? String,
                        country: data["country"] as? String,
                        phone: data["phone"] as? String,
                        name: data["name"] as? String,
                        type: data["type"] as? String ?? "Home"
                    )
                }
            }
    }
}

class CurrencyViewModel: ObservableObject {
    @Published var currentCurrency: String = UserDefaultsManager.shared.getCurrency() ?? "EGP"
    
    let availableCurrencies = ["EGP", "USD"]

    func selectCurrency(_ currency: String) {
        UserDefaultsManager.shared.saveCurrency(currency)
        currentCurrency = currency
    }
    func reloadCurrency() {
        currentCurrency = UserDefaultsManager.shared.getCurrency() ?? "EGP"
    }

}


extension CLLocationCoordinate2D: @retroactive Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}
