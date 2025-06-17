//
//  FeedView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

import SwiftUI

struct ProductFeedView: View {
    var body: some View {
           VStack {
               Text("Welcome to the Store")
                   .font(.largeTitle)
                   .padding()

               NativeAdViewRepresentable(adUnitID: "ca-app-pub-3940256099942544/3986624511")
                   .frame(height: 150)
                   .cornerRadius(12)
                   .padding()
           }
       }
}
