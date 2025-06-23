////
////  PaymentView.swift
////  MCommerce
////
////  Created by Nermeen Mohamed on 23/06/2025.
////
//
//import SwiftUI
//import StripePaymentSheet
//import SwiftUI
//
//class StripePaymentHandler: ObservableObject {
//    @Published var paymentSheet: PaymentSheet?
//    
//    private let backendUrl = URL(string: "http://localhost:4242")!
//    private var configuration = PaymentSheet.Configuration()
//    private var clientSecret = ""
//
//    func preparePaymentSheet(amount: Int, completion: @escaping (Bool) -> Void) {
//        let url = backendUrl.appendingPathComponent("create-payment-intent")
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let body = ["amount": amount, "currency": "usd"] as [String : Any]
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
//
//        URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
//            guard let data = data,
//                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
//                  let clientSecret = json["clientSecret"] as? String else {
//                completion(false)
//                return
//            }
//            
//            DispatchQueue.main.async {
//                self?.clientSecret = clientSecret
//                self?.paymentSheet = PaymentSheet(paymentIntentClientSecret: clientSecret, configuration: self!.configuration)
//                completion(true)
//            }
//        }.resume()
//    }
//
//    func presentPaymentSheet() -> some View {
//        PaymentSheet.PaymentButton(
//            paymentSheet: paymentSheet!,
//            onCompletion: onPaymentCompletion
//        ) {
//            Text("Pay")
//                .padding()
//                .background(Color.indigo)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//        }
//        .padding()
//    }
//
//    private func onPaymentCompletion(result: PaymentSheetResult) {
//        switch result {
//        case .completed:
//            print("✅ Payment complete")
//        case .canceled:
//            print("❌ Payment canceled")
//        case .failed(let error):
//            print("❌ Payment failed: \(error.localizedDescription)")
//        }
//    }
//}
