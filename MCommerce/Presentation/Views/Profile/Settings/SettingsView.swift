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
            
            // General Section Title
            HStack {
                Text("General")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal)
            
            // Address Row
            HStack {
                Image(systemName: "person.crop.circle")
                Text("Address")
                    .font(.body)
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
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 40)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 4)
            .onTapGesture {
                coordinator.navigate(to: .addressList)
            }
            
            // Currency Row
            HStack {
                Image(systemName: "dollarsign.circle")
                Text("Currency")
                    .font(.body)
                Spacer()
                Text(currencyViewModel.currentCurrency)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 40)
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
            
            // Preferences Section Title
            HStack {
                Text("Preferences")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 16)
            
            // Contact Us
            HStack {
                Image(systemName: "questionmark.circle")
                Text("Contact Us")
                    .font(.body)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
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
            
            // About Us
            HStack {
                Image(systemName: "info.circle")
                Text("About Us")
                    .font(.body)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
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
            
            // Logout Button
            Button(action: {
                settingsViewModel.currencyViewModel.selectCurrency("USD")
                UserDefaultsManager.shared.clearAll()
                coordinator.navigate(to: .welcome)
            }) {
                HStack {
                    Image(systemName: "arrow.right.square")
                    Text("Logout")
                        .font(.system(size: 22, weight: .bold))
                }
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
        })
        .onAppear {
            settingsViewModel.reloadAllSettings()
        }
    }
}

//#Preview {
//    SettingsView()
//}
