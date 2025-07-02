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
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .padding()
                Spacer()
            } else if viewModel.addresses.isEmpty {
                Spacer()
                Image("noImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)

                Text("No Address Found")
                    .font(.largeTitle)
                Spacer()
            } else {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Your Addresses")
                            .font(.headline)
                            .padding(.horizontal)

                        List {
                            ForEach(viewModel.addresses) { address in
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text(address.type)
                                            .font(.headline)
                                        Spacer()
                                        Text(address.phone)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }

                                    HStack(alignment: .top) {
                                        Text(address.address2 + ", " + address.address1)
                                            .font(.subheadline)
                                            .fixedSize(horizontal: false, vertical: true)
                                        Spacer()
                                        Image(systemName: "pencil")
                                            .padding(8)
                                            .background(Color.gray.opacity(0.2))
                                            .clipShape(Circle())
                                            .onTapGesture {
                                                coordinator.navigate(to: .addressForm(
                                                    address: DIContainer.shared.resolveAddressDetailViewModel(address: address)
                                                ))
                                            }
                                    }
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(address.defaultAddress == true ? Color.red : Color.clear, lineWidth: 2)
                                )
                                .shadow(radius: 2)
                                .onTapGesture {
                                    coordinator.navigate(to: .addressDetails(
                                        address: DIContainer.shared.resolveAddressDetailViewModel(address: address)
                                    ))
                                }
                            }
                            .onDelete(perform: { index in
                                showAlert = true
                                indexSetToDelete = index
                            })
                            
                        }
                        .listStyle(.plain)
                        
                    
                }.padding(.top)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Are you sure?"), message: Text("You want to delete this item?"), primaryButton: .destructive(Text("Delete")) {
                        viewModel.deleteAddress(at: indexSetToDelete!)
                    }, secondaryButton: .cancel())
                }
            }

            // Add Address Button
            Button(action: {
                coordinator.navigate(to: .addressForm(address: nil))
            }) {
                Text("Add New Address")
                    .font(.system(size: 18, weight: .bold))
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.deepPurple)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchAddresses()
        }
    }

}

//#Preview {
//    AddressListView(viewModel: AddressViewModel())
//}
