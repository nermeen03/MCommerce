////
//  payment.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 23/06/2025.
//

import StripePaymentSheet
import SwiftUI

class StripePaymentHandler: ObservableObject {
    @Published var paymentSheet: PaymentSheet?
    @Published var showingAlert: Bool = false
    
    private let backendtUrl = URL(string: "http://localhost:4242")!
    private var configuration = PaymentSheet.Configuration()
    private var clientSecret = ""
    private var paymentIntentID: String = ""
    
    var alertText: String = ""
    var paymentAmount: Int = 0
    
    func preparePaymentSheet() {
        let url = backendtUrl.appendingPathComponent("prepare-payment-sheet")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                  let customerId = json["customer"] as? String,
                  let customerEphemeralKeySecret = json["ephemeralKey"] as? String,
                  let clientSecret = json["clientSecret"] as? String,
                  let paymentIntentID = json["paymentIntentID"] as? String,
                  let publishableKey = json["publishableKey"] as? String,
                  let self = self else {
                return
            }
            
            self.clientSecret = clientSecret
            self.paymentIntentID = paymentIntentID
            STPAPIClient.shared.publishableKey = publishableKey
            
            configuration.merchantDisplayName = "Example, Inc."
            configuration.customer = .init(id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
            configuration.allowsDelayedPaymentMethods = true
            configuration.applePay = .init(
              merchantId: "merchant.com.your_app_name",
              merchantCountryCode: "US"
            )
            configuration.returnURL = "your-app://stripe-redirect"
        })
        task.resume()
    }
    
    func updatePaymentSheet() {
        DispatchQueue.main.async {
           self.paymentSheet = nil
        }
        
        let bodyProperties: [String: Any] = [
            "paymentIntentID": paymentIntentID,
            "amount": paymentAmount
        ]
        
        let url = backendtUrl.appendingPathComponent("update-payment-sheet")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: bodyProperties)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
               self.paymentSheet = PaymentSheet(paymentIntentClientSecret: self.clientSecret, configuration: self.configuration)
            }
        })
        task.resume()
    }
    
    func onPaymentCompletion(result: PaymentSheetResult) {
        switch result {
        case .completed:
            self.alertText = "Payment complete!"
        case .canceled:
            self.alertText = "Payment cancelled!"
        case .failed(let error):
            self.alertText = "Payment failed \(error.localizedDescription)"
        }
        
        showingAlert = true
    }
    
    func presentPaymentSheet(from viewController: UIViewController, onCompletion: @escaping (PaymentSheetResult) -> Void) {
        guard let paymentSheet = self.paymentSheet else {
            print("PaymentSheet not ready")
            return
        }

        paymentSheet.present(from: viewController) { result in
            DispatchQueue.main.async {
                self.onPaymentCompletion(result: result)
                onCompletion(result)
            }
        }
    }

}


