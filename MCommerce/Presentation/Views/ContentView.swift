//
//  ContentView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var showAd = false
    @State private var adTimer: Timer?
    @State private var repeatAdTimer: Timer?

    var body: some View {
        HomeView()
    }
}



#Preview {
    ContentView()
}

