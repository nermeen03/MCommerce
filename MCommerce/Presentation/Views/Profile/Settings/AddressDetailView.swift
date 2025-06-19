//
//  AddressDetailView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import SwiftUI

struct AddressDetailView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @State var address: AddressInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center) {
                Text(address.name ?? "No Name")
                    .font(.title2)
                    .fontWeight(.bold)
                
                if address.defaultAddress {
                    Text("Default")
                        .font(.caption)
                        .padding(4)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(6)
                }
                
                Spacer()
                
                Button {
                    coordinator.navigate(to: .addressForm(address: address))
                } label: {
                    Text("Edit")
                        .font(.caption)
                        .padding(6)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            Divider()
            
            VStack(alignment: .leading, spacing: 4) {
                if let address1 = address.address1, !address1.isEmpty {
                    Text(address1)
                }
                if let address2 = address.address2, !address2.isEmpty {
                    Text(address2)
                }
                
                if let city = address.city {
                    Text(city)
                }
                
                if let zip = address.zip, !zip.isEmpty {
                    Text("ZIP: \(zip)")
                }
                
                if let country = address.country {
                    Text(country)
                }
                
                if let phone = address.phone, !phone.isEmpty {
                    Text("📞 \(phone)")
                }
                
                Text("Type: \(address.type)")
                    .foregroundColor(.secondary)
                    .font(.footnote)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(radius: 4)
        .padding(.horizontal)
        
    }
}


#Preview {
    AddressDetailView(address: AddressInfo(
        defaultAddress: true,
        id: UUID().uuidString,
        address1: "123 Main St",
        address2: "Apartment 4B",
        city: "Cairo",
        zip: "12345",
        country: "Egypt",
        phone: "0123456789",
        name: "Home",
        type: "Home"
    ))
}

