//
//  LazyView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 01/07/2025.
//

import SwiftUI

struct LazyView<Content: View>: View {
    @StateObject var connectivityManager = ConnectivityManager.shared
    private let content: () -> Content
    
    init(content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        Group {
            if !connectivityManager.isConnected {
                NoInternetView()
                    .transition(.opacity)
            }else{
                content()
            }
        }
    }
}
