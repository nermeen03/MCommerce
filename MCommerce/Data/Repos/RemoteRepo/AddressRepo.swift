//
//  AddressRepo.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 20/06/2025.
//

import Foundation
import MapKit
import CoreLocation
import FirebaseFirestore


struct AddressFirebaseRepo{
    
    
    func getFromFireStore(completion : @escaping ([AddressInfo]) -> Void){
        guard let firestoreUserId = UserDefaultsManager.shared.getUserId()?.replacingOccurrences(of: "/", with: "_") else{return}
        print(firestoreUserId)
        let db = Firestore.firestore()
        let addressesRef = db.collection("users").document(firestoreUserId).collection("addresses")
        
        addressesRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching addresses: \(error)")
                completion([])
            }
            
            let addresses = snapshot?.documents.compactMap { doc -> AddressInfo? in
                return Mapper.mapToAddress(docId: doc.documentID, from: doc.data())
            } ?? []
            
            completion(addresses)
        }
    }
    
    func saveToFireStore(address : AddressInfo){
        guard let firestoreUserId = UserDefaultsManager.shared.getUserId()?.replacingOccurrences(of: "/", with: "_") else{return}
        let db = Firestore.firestore()
        let data = Mapper.mapToDict(from: address)
        
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
        guard let firestoreUserId = UserDefaultsManager.shared.getUserId()?.replacingOccurrences(of: "/", with: "_") else{return}
        let db = Firestore.firestore()
        
        let data = Mapper.mapToDict(from: address)
        
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
    
    func deleteAddressFromFirestore(addressId: String, completion : @escaping (Bool)->Void){
        guard let firestoreUserId = UserDefaultsManager.shared.getUserId()?.replacingOccurrences(of: "/", with: "_") else{return}
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(firestoreUserId)
            .collection("addresses")
            .document(addressId)
            .delete { error in
                if let error = error {
                    print("Error deleting address: \(error.localizedDescription)")
                    completion(false)
                } else {
                    print("Address successfully deleted.")
                    completion(true)
                    
                }
            }
    }
    
    func getDefaultAddress(completion : @escaping ((AddressInfo?) -> Void)){
        guard let firestoreUserId = UserDefaultsManager.shared.getUserId()?.replacingOccurrences(of: "/", with: "_") else{return}
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(firestoreUserId)
            .collection("addresses")
            .whereField("default", isEqualTo: true)
            .limit(to: 1)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching default address: \(error)")
                    completion(nil)
                }
                
                if let document = snapshot?.documents.first{
                    completion(Mapper.mapToAddress(docId: document.documentID, from: document.data()))
                } else {
                    print("No default address found.")
                    completion(nil)
                }
            
            }
    }
    
}

struct AddressRepo {
    func getAddressFromMap(for coordinate: CLLocationCoordinate2D, completion: @escaping (_ street: String?, _ apartment: String?, _ city: String?, _ country: String?) -> Void) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                completion(nil, nil, nil, nil)
                return
            }
            
            let streetNumber = placemark.subThoroughfare ?? ""     
            let streetName = placemark.thoroughfare ?? ""
            let street = [streetNumber, streetName]
                .filter { !$0.isEmpty }
                .joined(separator: " ")
            let apartment = placemark.subLocality
            let city = placemark.locality
            let country = placemark.country
            
            completion(street.isEmpty ? nil : street, apartment, city, country)
        }
    }

}
