//
//  SafariView.swift
//  MCommerce
//
//  Created by abram on 23/06/2025.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
}

//#Preview {
//    SafariView()
//}
