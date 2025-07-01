//
//  Internet.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 01/07/2025.
//

import SwiftUI
import Connectivity

class ConnectivityManager: ObservableObject {
    private var connectivity: Connectivity?
    static let shared = ConnectivityManager()
    
    @Published var isConnected: Bool = true

    private init() {
        setupConnectivity()
    }
    
    func setupConnectivity() {
        if connectivity == nil {
            connectivity = Connectivity()
            connectivity?.startNotifier()
            
            connectivity?.whenConnected = { [weak self] _ in
                DispatchQueue.main.async {
                    self?.handleConnectivityChange(isConnected: true)
                }
            }
            
            connectivity?.whenDisconnected = { [weak self] _ in
                DispatchQueue.main.async {
                    self?.handleConnectivityChange(isConnected: false)
                }
            }
        }
    }

    func handleConnectivityChange(isConnected: Bool) {
        if self.isConnected != isConnected {
            self.isConnected = isConnected
        }
    }

    func stopConnectivity() {
        connectivity?.stopNotifier()
        connectivity = nil
    }
}
