////
////  payment.swift
////  MCommerce
////
////  Created by Nermeen Mohamed on 23/06/2025.
////
//
//import SwiftUI
//import StripePaymentSheet
//
//struct PaymentView: View {
//    @FocusState var textFieldFocused: Bool
//    @ObservedObject var model = StripePaymentHandler()
//    
//    @State private var enteredNumber = ""
//    var enteredNumberFormatted: Double {
//        return (Double(enteredNumber) ?? 0) / 100
//    }
//    
//    var body: some View {
//        VStack {
//            Text("Enter the amount")
//            ZStack(alignment: .center) {
//                Text("$\(enteredNumberFormatted, specifier: "%.2f")").font(Font.system(size: 30))
//                TextField("", text: $enteredNumber, onEditingChanged: { _ in
//                    model.paymentAmount = Int(enteredNumberFormatted * 100)
//                }, onCommit: {
//                    textFieldFocused = false
//                }).focused($textFieldFocused)
//                    .keyboardType(.numberPad)
//                    .foregroundColor(.clear)
//                    .disableAutocorrection(true)
//                    .accentColor(.clear)
//            }
//            Spacer()
//            
//            if let paymentSheet = model.paymentSheet, !textFieldFocused {
//                PaymentSheet.PaymentButton(
//                    paymentSheet: paymentSheet,
//                    onCompletion: model.onPaymentCompletion
//                ) {
//                    payButton
//                }
//            }
//        }
//        .alert(model.alertText, isPresented: $model.showingAlert) {
//            Button("OK", role: .cancel) { }
//        }
//        .onChange(of: textFieldFocused) {
//            if !textFieldFocused {
//                DispatchQueue.global(qos: .background).sync {
//                    model.updatePaymentSheet()
//                }
//            }
//        }
//        .onAppear {
//            model.preparePaymentSheet()
//        }
//        .padding(.horizontal)
//        .padding(.top, 50)
//        .padding(.bottom)
//        .toolbar {
//            ToolbarItem(placement: .keyboard) {
//                Button("Done") {
//                    textFieldFocused = false
//                }
//            }
//        }
//    }
//    
//    @ViewBuilder
//    var payButton: some View {
//        HStack {
//            Spacer()
//            Text("Pay $\(enteredNumberFormatted, specifier: "%.2f")")
//            Spacer()
//        }
//        .padding()
//        .foregroundColor(.white)
//        .background(
//            RoundedRectangle(cornerRadius: 10, style: .continuous)
//                .fill(.indigo)
//        )
//    }
//}
//
//import StripePaymentSheet
//import SwiftUI
//
//class StripePaymentHandler: ObservableObject {
//    @Published var paymentSheet: PaymentSheet?
//    @Published var showingAlert: Bool = false
//    
//    private let backendtUrl = URL(string: "http://localhost:4242")!
//    private var configuration = PaymentSheet.Configuration()
//    private var clientSecret = ""
//    private var paymentIntentID: String = ""
//    
//    var alertText: String = ""
//    var paymentAmount: Int = 0
//    
//    func preparePaymentSheet() {
//        let url = backendtUrl.appendingPathComponent("prepare-payment-sheet")
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
//            guard let data = data,
//                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
//                  let customerId = json["customer"] as? String,
//                  let customerEphemeralKeySecret = json["ephemeralKey"] as? String,
//                  let clientSecret = json["clientSecret"] as? String,
//                  let paymentIntentID = json["paymentIntentID"] as? String,
//                  let publishableKey = json["publishableKey"] as? String,
//                  let self = self else {
//                return
//            }
//            
//            self.clientSecret = clientSecret
//            self.paymentIntentID = paymentIntentID
//            STPAPIClient.shared.publishableKey = publishableKey
//            
//            configuration.merchantDisplayName = "Example, Inc."
//            configuration.customer = .init(id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
//            configuration.allowsDelayedPaymentMethods = true
//            configuration.applePay = .init(
//              merchantId: "merchant.com.your_app_name",
//              merchantCountryCode: "US"
//            )
//            configuration.returnURL = "your-app://stripe-redirect"
//        })
//        task.resume()
//    }
//    
//    func updatePaymentSheet() {
//        DispatchQueue.main.async {
//           self.paymentSheet = nil
//        }
//        
//        let bodyProperties: [String: Any] = [
//            "paymentIntentID": paymentIntentID,
//            "amount": paymentAmount
//        ]
//        
//        let url = backendtUrl.appendingPathComponent("update-payment-sheet")
//        var request = URLRequest(url: url)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = try? JSONSerialization.data(withJSONObject: bodyProperties)
//        request.httpMethod = "POST"
//        
//        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
//            guard let self = self else {
//                return
//            }
//            DispatchQueue.main.async {
//               self.paymentSheet = PaymentSheet(paymentIntentClientSecret: self.clientSecret, configuration: self.configuration)
//            }
//        })
//        task.resume()
//    }
//    
//    func onPaymentCompletion(result: PaymentSheetResult) {
//        switch result {
//        case .completed:
//            self.alertText = "Payment complete!"
//        case .canceled:
//            self.alertText = "Payment cancelled!"
