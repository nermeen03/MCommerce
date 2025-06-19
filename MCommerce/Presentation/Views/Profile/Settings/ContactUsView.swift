//
//  ContactUsView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import SwiftUI

struct ContactUsView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("We’d love to hear from you!")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("If you have any questions, feedback, or suggestions, feel free to reach out to us.")
                        .font(.body)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Email: shopify@gmail.com", systemImage: "envelope")
                        Label("Phone: +20 123 456 789", systemImage: "phone")
                        Label("Website: www.example.com", systemImage: "globe")
                    }
                    .font(.subheadline)
                }
                .padding()
            }
            .navigationTitle("Contact Us")
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
    ContactUsView()
}
