//
//  AddressDetailView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import SwiftUI

struct AddressDetailView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var addressViewModel: AddressDetailViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .center) {
                if addressViewModel.address!.defaultAddress {
                    Text("Default")
                        .font(.caption)
                        .padding(4)
                        .background(Color.deepPurple.opacity(0.2))
                        .cornerRadius(6)
                }
                
                Spacer()
                
                Button {
                    coordinator.navigate(to: .addressForm(address: addressViewModel))
                } label: {
                    Text("Edit")
                        .font(.caption)
                        .padding(6)
                        .foregroundStyle(Color.deepPurple)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            Divider()
            Text(addressViewModel.address!.address1)
            Text(addressViewModel.address!.address2)
            
            Text(addressViewModel.address!.city)
            
            Text(addressViewModel.address!.country)
            
            Text("📞 \(addressViewModel.address!.phone)")
            
            Text("Type: \(addressViewModel.address!.type)")
                .foregroundColor(.secondary)
                .font(.footnote)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(radius: 4)
        .padding(.horizontal)
    
    }
}


//#Preview {
//    AddressDetailView(address: AddressInfo(
//        defaultAddress: true,
//        id: UUID().uuidString,
//        address1: "123 Main St",
//        address2: "Apartment 4B",
//        city: "Cairo",
//        country: "Egypt",
//        phone: "0123456789",
//        type: "Home"
//    ))
//}

