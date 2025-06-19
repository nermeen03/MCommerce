//
//  CurrencyPickerView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import SwiftUI

struct CurrencyPickerView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var currencyViewModel: CurrencyViewModel

    var body: some View {
        NavigationStack {
            List(currencyViewModel.availableCurrencies, id: \.self) { currency in
                Button {
                    currencyViewModel.selectCurrency(currency)
                    dismiss()
                } label: {
                    HStack {
                        Text(currency)
                        if currency == currencyViewModel.currentCurrency {
                            Spacer()
                            Image(systemName: "checkmark").foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("Select Currency")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}
