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
                Text("No Addresses Found")
                    .font(.headline)
                    .padding()
            } else {
                List {
                    ForEach(viewModel.addresses) { address in
                        VStack(alignment: .leading, spacing: 8) {
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(address.type)
                                        .font(.headline)
                                    Spacer()
                                    Text(address.phone)
                                        .foregroundColor(.secondary)
                                }
                                HStack {
                                    Text(address.address2 + ", " + address.address1)
                                        .font(.subheadline)
                                    Spacer()
                                    Image(systemName: "pencil")
                                        .padding(8)
                                        .background(Color.gray.opacity(0.2))
                                        .clipShape(Circle())
                                        .onTapGesture {
                                            coordinator.navigate(to: .addressForm(address: DIContainer.shared.resolveAddressDetailViewModel(address: address)))
                                        }
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                coordinator.navigate(to: .addressDetails(address: DIContainer.shared.resolveAddressDetailViewModel(address: address)))
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
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical, 5)
                    }
                    .onDelete { indexSet in
                        viewModel.deleteAddress(at: indexSet)
                    }
                }.padding()
                .listStyle(PlainListStyle())
            }

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
