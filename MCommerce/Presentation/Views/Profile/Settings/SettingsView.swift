//
//  SettingsView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 18/06/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var coordinator: AppCoordinator

    @State private var showCurrencyPicker = false
    @State private var showAboutUs = false
    @State private var showContactUs = false
    
    @ObservedObject var settingsViewModel : SettingsViewModel
    @EnvironmentObject var currencyViewModel: CurrencyViewModel
    
    var body: some View {
        VStack(alignment: .center, content: {
            Spacer()
            HStack{
                Text("Address").font(.title2)
                Spacer()
                if let address = settingsViewModel.defaultAddress {
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("\(address.address1), \(address.city)")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        Text(address.type)
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
                .onTapGesture {
                    showContactUs = true
                }
                .sheet(isPresented: $showContactUs) {
                    ContactUsView()
                        .presentationDetents([.fraction(0.5)])
                }
            Text("About Us").padding()
                .font(.title2)
                .frame(width: UIScreen.main.bounds.width - 40)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 4)
                .onTapGesture {
                    showAboutUs = true
                }
                .sheet(isPresented: $showAboutUs) {
                    AboutUsView()
                        .presentationDetents([.fraction(0.6)])
                }
            Spacer()
            Button(action: {
                UserDefaultsManager.shared.clearAll()
                coordinator.navigate(to: .welcome)
            }) {
                Text("Logout")
                    .font(.system(size: 22, weight: .bold))
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }.padding()
        }).onAppear{
            settingsViewModel.reloadAllSettings()
        }
    }
}

//#Preview {
//    SettingsView()
//}
