//
//  AddressUseCase.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 20/06/2025.
//

import CoreLocation


struct AddressUseCases {
    
    let addressRepo = AddressFirebaseRepo()
    
    func getFromFireStore(completion : @escaping ([AddressInfo]) -> Void) {
        addressRepo.getFromFireStore(completion: completion)
    }
    func saveToFireStore(address : AddressInfo){
        addressRepo.saveToFireStore(address: address)
    }
    func updateFireStore(address : AddressInfo){
        addressRepo.updateFireStore(address: address)
    }
    func deleteAddressFromFirestore(addressId: String, completion : @escaping (Bool)->Void){
        addressRepo.deleteAddressFromFirestore(addressId: addressId, completion: completion)
    }
    
}

struct MapAddressUserCase{
    let mapAddressRepo = AddressRepo()
    
    func getAddressFromMap(for coordinate: CLLocationCoordinate2D, completion: @escaping (String?, String?, String?, String?) -> Void){
        mapAddressRepo.getAddressFromMap(for: coordinate, completion: completion)
    }
}
extension CLLocationCoordinate2D: @retroactive Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

struct DefaultAddressUseCase {
    let addressRepo = AddressFirebaseRepo()
    func getDefaultAddress(completion : @escaping ((AddressInfo?) -> Void)){
        addressRepo.getDefaultAddress{result in
            completion(result)
        }
    }
}
