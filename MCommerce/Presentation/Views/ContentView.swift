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

              //  ApiCalling().callRestApi()
               // ApiCalling().createCustomer()

                //createCustomer()
                getCustomer()

            })
        }
        .padding()
       
      //  HomeView()
//        MainTabView()
    }
}

#Preview {
    ContentView()
}

func createCustomer() {
    let createCustomerMutation = """
    mutation customerCreate($input: CustomerCreateInput!) {
      customerCreate(input: $input) {
        customer {
          id
          email
          firstName
          lastName
        }
        customerUserErrors {
          field
          message
        }
      }
    }
    """

    let variables: [String: Any] = [
        "input": [
            "firstName": "Nermeen",
            "lastName": "Mohamed",
            "email": "flued1949@teleworm.us",
            "phone": "+201232864499",
            "password": "YourSecurePassword",
            "acceptsMarketing": true
        ]
    ]

    ApiCalling().callQueryApi(query: createCustomerMutation, variables: variables)
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

