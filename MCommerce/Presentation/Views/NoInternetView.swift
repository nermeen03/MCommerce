//
//  NoInternetView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 01/07/2025.
//

import SwiftUI

struct NoInternetView: View {
    var body: some View {
        VStack {
            Image(systemName: "wifi.exclamationmark")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
                .padding(.bottom, 20)
            
            Text("No Internet Connection")
                .font(.headline)
                .foregroundColor(.red)
                .padding(.bottom, 10)
            
            Text("Please check your internet connection or try again.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
    
    
}
