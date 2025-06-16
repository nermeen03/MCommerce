//
//  ContentView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Test", action: {
                createCustomer()
                //getCustomer()
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

func createCustomer(){
    let parameters: [String: Any] = [
            "customer": [
                "first_name": "Nermeen",
                "last_name": "Mohamed",
                "email": "flued1949@teleworm.us",
                "phone": "+201232864490",
                "password": "YourSecurePassword",
                "password_confirmation": "YourSecurePassword",
                "accepts_marketing": true,
                "send_email_welcome": true
            ]
        ]
    ApiCalling().callRestApi(parameters: parameters, json: "customers")
}

func getCustomer(){
    let loginQuery = """
    mutation customerAccessTokenCreate($input: CustomerAccessTokenCreateInput!) {
      customerAccessTokenCreate(input: $input) {
        customerAccessToken {
          accessToken
          expiresAt
        }
        userErrors {
          field
          message
        }
      }
    }
    """

    let variables: [String: Any] = [
        "input": [
            "email": "flued1949@teleworm.us",
            "password": "YourSecurePassword"
        ]
    ]

    ApiCalling().callQueryApi(query: loginQuery, variables: variables)
}
