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
                ApiCalling().createCustomer()
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
