//
//  SettingsView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 18/06/2025.
//

import SwiftUI

struct SettingsView: View {
    
    let currentCurrency = "EGP"
    
    var body: some View {
        VStack(alignment: .center, content: {
            Spacer()
            Text("Address").padding()
                .font(.title2)
                .frame(width: UIScreen.main.bounds.width - 40,alignment: .leading)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 4)
            HStack{
                Text("Currency").font(.title2)
                Spacer()
                Text("\(currentCurrency)").font(.title2)
            }.padding().frame(width: UIScreen.main.bounds.width - 40,alignment: .leading)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 4)
            Text("Contact Us").padding()
                .font(.title2)
                .frame(width: UIScreen.main.bounds.width - 40,alignment: .leading)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 4)
            Text("About Us").padding()
                .font(.title2)
                .frame(width: UIScreen.main.bounds.width - 40,alignment: .leading)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 4)
            Spacer()
            Button(action: {
            }) {
                Text("Logout")
                    .font(.system(size: 30, weight: .heavy))
                    .frame(width: UIScreen.main.bounds.width - 200, height: 70)
                    .foregroundColor(.yellow)
                    .background(Color.blue)
                    .cornerRadius(12)
            }.padding()
        })
    }
}

#Preview {
    SettingsView()
}
