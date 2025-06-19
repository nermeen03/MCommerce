//
//  AddressListView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import SwiftUI

struct AddressListView: View {
    
    @StateObject var viewModel : AddressViewModel
    @EnvironmentObject var coordinator: AppCoordinator
    @State private var showAlert = false
    @State private var indexSetToDelete: IndexSet?

    var body: some View {
        List {
            ForEach(viewModel.addressesList) { address in
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(address.name ?? "Unknown")
                                .font(.headline)
                            Spacer()
                            Text(address.phone ?? "Unknown")
                                .foregroundColor(.secondary)
                        }
                        if let address1 = address.address1 {
                            Text(address1)
                        }
                        if let address2 = address.address2 {
                            Text(address2)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        coordinator.navigate(to: .addressDetails(address: address))
                    }
                    
                    HStack {
                        Spacer()

                            Image(systemName: "pencil")
                                .padding(8)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle()).onTapGesture {
                                    coordinator.navigate(to: .addressForm(address: address))
                                }.padding(.bottom,-10)
                    }
                }
                .padding(.vertical, 7)
            }.onDelete { indexSet in
                indexSetToDelete = indexSet
                showAlert = true
            }

        }
        .onAppear {
            viewModel.getFromFireStore()
        }
        .alert("Are you sure you want to delete this address?", isPresented: $showAlert) {
            Button("Delete", role: .destructive) {
                if let indexSet = indexSetToDelete {
                    viewModel.deleteAddress(at: indexSet)
                    indexSetToDelete = nil
                }
            }
            Button("Cancel", role: .cancel) {
                indexSetToDelete = nil
            }
        }

        Spacer()

        Button(action: {
            coordinator.navigate(to: .addressForm(address: nil))
        }) {
            Text("Add New Address")
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding(.horizontal)

    }
}

#Preview {
    AddressListView(viewModel: AddressViewModel())
}
