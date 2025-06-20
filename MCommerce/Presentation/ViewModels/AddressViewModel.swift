//
//  AddressViewModel.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import Foundation
import MapKit
import CoreLocation
import FirebaseFirestore

class AddressViewModel : ObservableObject{
    
    var addressUseCases : AddressUseCases
    
    @Published var addresses : [AddressInfo] = []
    @Published var isLoading : Bool = false
    
    init(addressUseCases: AddressUseCases) {
        self.addressUseCases = addressUseCases
    }
    
    func deleteAddress(at offsets: IndexSet) {
        for index in offsets {
            let address = addresses[index]
            addressUseCases.deleteAddressFromFirestore(addressId: address.id) { [weak self] result in
                if result {
                    self?.fetchAddresses()
                }
            }
        }
    }
    func deleteAddress(_ address : AddressInfo) {
        addressUseCases.deleteAddressFromFirestore(addressId: address.id) { [weak self] result in
            if result {
                self?.fetchAddresses()
            }
        }
    }
    
    func fetchAddresses(){
        isLoading = true
        addressUseCases.getFromFireStore{[weak self] result in
            self?.addresses = result
            self?.isLoading = false
        }
    }
    
}
    
class AddressFormViewModel : ObservableObject{
    var defaultUseCase : DefaultAddressUseCase
    var mapAddressUseCase : MapAddressUserCase
    var addressUseCases : AddressUseCases
    var addressDetailViewModel : AddressDetailViewModel?
    
    @Published var defaultAddress : Bool = false
    @Published var errorMessage : ValidationError? = nil
    
    init(defaultUseCase: DefaultAddressUseCase, mapAddressUseCase: MapAddressUserCase, addressUseCases: AddressUseCases, addressDetailViewModel:AddressDetailViewModel? = nil) {
        self.defaultUseCase = defaultUseCase
        self.mapAddressUseCase = mapAddressUseCase
        self.addressUseCases = addressUseCases
        self.addressDetailViewModel = addressDetailViewModel
    }
    
    func validateAllFields(phoneNumber:String, address1:String, address2:String) -> String? {
        if let error = Validation.validatePhone(phoneNumber: phoneNumber) {
            errorMessage = ValidationError(message: error)
            return error }
        if let error = Validation.validateAddress1(address1: address1) {
            errorMessage = ValidationError(message: error)
            return error }
        if let error = Validation.validateAddress1(address1: address2) {
            errorMessage = ValidationError(message: error)
            return error }
        errorMessage = nil
        return nil
    }
    

    func saveAddress(address : AddressInfo, update : Bool = false){
            if update {
                addressUseCases.updateFireStore(address: address)
            }else{
                addressUseCases.saveToFireStore(address: address)
            }
    }
    
    func getAddressFromMap(for coordinate: CLLocationCoordinate2D, completion: @escaping (String?, String?, String?, String?) -> Void) {
        mapAddressUseCase.getAddressFromMap(for: coordinate, completion: completion)
    }
    
    func getDefaultAddress(){
        defaultUseCase.getDefaultAddress(completion: {[weak self] result in
           if result != nil {
               self?.defaultAddress = true
            }
        })
    }
}

class AddressDetailViewModel: ObservableObject {
    @Published var address: AddressInfo?

    init(address: AddressInfo?) {
        self.address = address
    }
}

extension AddressDetailViewModel: Equatable {
    static func == (lhs: AddressDetailViewModel, rhs: AddressDetailViewModel) -> Bool {
        lhs.address?.id == rhs.address?.id
    }
}

extension AddressDetailViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(address?.id)
    }
}


struct Validation {
    static func validatePhone(phoneNumber:String) -> String? {
        let trimmed = phoneNumber.trimmingCharacters(in: .whitespaces)
        if trimmed.isEmpty {
            return "Phone number is required."
        }
        if !isValidPhone(trimmed) {
            return "Invalid phone number format."
        }
        return nil
    }

    static func validateAddress1(address1:String) -> String? {
        if address1.trimmingCharacters(in: .whitespaces).isEmpty {
            return "address is required."
        }
        return nil
    }

    private static func isValidPhone(_ phone: String) -> Bool {
        let regex = "^[0-9+()\\s-]{6,15}$"
        return phone.range(of: regex, options: .regularExpression) != nil
    }

}
