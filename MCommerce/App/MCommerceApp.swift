//
//  MCommerceApp.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

import SwiftUI
import GoogleMobileAds

//@main
//struct MCommerceApp: App {
//    init() {
//        MobileAds.shared.start(completionHandler: nil)
//    }
//    var body: some Scene {
//        WindowGroup {
//            ProductFeedView()
//        }
//    }
//}

@main
struct MCommerceApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ProductFeedView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        MobileAds.shared.start(completionHandler: nil)
        return true
    }
}
