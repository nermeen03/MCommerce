//
//  AboutUsView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import SwiftUI

struct AboutUsView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("About Our App")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("""
                        Welcome to MCommerce!
                        
                        Our mission is to make online shopping simple, fast, and secure for everyone. 
                        This app allows you to explore the best products, enjoy great deals, and have them delivered right to your door.

                        Thank you for choosing us!
                        """)
                        .font(.body)
                }
                .padding()
            }
            .navigationTitle("About Us")
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


#Preview {
    AboutUsView()
}
