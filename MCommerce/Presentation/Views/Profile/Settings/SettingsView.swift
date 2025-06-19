//
//  SettingsView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 18/06/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var coordinator: AppCoordinator

    @StateObject var defaultViewModel = DefaultAddressViewModel()
    @EnvironmentObject var currencyViewModel: CurrencyViewModel
    @State private var showCurrencyPicker = false
    
    var body: some View {
        VStack(alignment: .center, content: {
            Spacer()
            HStack{
                Text("Address").font(.title2)
                Spacer()
                if let address = defaultViewModel.defaultAddress {
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(address.name ?? "No Name")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        Text("\(address.address1 ?? ""), \(address.city ?? "")")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                } else {
                    Text("Unknown")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }.padding().frame(width: UIScreen.main.bounds.width - 40,alignment: .leading)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 4)
                .onTapGesture {
                    coordinator.navigate(to: .addressList)
                }
            HStack{
                Text("Currency").font(.title2)
                Spacer()
                Text(currencyViewModel.currentCurrency)
                    .font(.title2)
                    .foregroundColor(.blue)
            }.padding().frame(width: UIScreen.main.bounds.width - 40,alignment: .leading)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 4)
                .onTapGesture {
                    showCurrencyPicker = true
                }
                .sheet(isPresented: $showCurrencyPicker) {
                    CurrencyPickerView()
                        .presentationDetents([.fraction(0.3)])
                }
            Text("Contact Us").padding()
                .font(.title2)
                .frame(width: UIScreen.main.bounds.width - 40)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 4)
            Text("About Us").padding()
                .font(.title2)
                .frame(width: UIScreen.main.bounds.width - 40)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 4)
            Spacer()
            Button(action: {
                UserDefaultsManager.shared.clearAll()
                coordinator.navigate(to: .welcome)
            }) {
                Text("Logout")
                    .font(.system(size: 30, weight: .heavy))
                    .frame(width: UIScreen.main.bounds.width - 200, height: 70)
                    .foregroundColor(.yellow)
                    .background(Color.blue)
                    .cornerRadius(12)
            }.padding()
        }).onAppear{
            defaultViewModel.getDefaultAddress()
            currencyViewModel.reloadCurrency()
        }
    }
}

#Preview {
    SettingsView()
}
