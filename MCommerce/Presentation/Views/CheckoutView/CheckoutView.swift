import SwiftUI

struct CheckoutView: View {
    @StateObject var viewModel: CheckoutViewModel
    @ObservedObject var model = StripePaymentHandler()
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var cartVM: CartBadgeVM

    @State private var isReady = false
    @State private var showWaiting = false


    let totalPrice: Double
    let items: [CartItem]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(items) { item in
                    HStack(spacing: 16) {
                        Image(systemName: "cart")
                            .font(.system(size: 40))
                            .frame(width: 60, height: 60)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.title2).fontWeight(.semibold)
                            
                            Text("\("$".symbol)\(item.price.currency) x \(item.quantity ?? 1)")
                                .foregroundColor(.orange)
                                .font(.title3).bold()
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Shipping Address")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    if viewModel.isAddressesLoading {
                        ProgressView()
                    } else if viewModel.addresses.isEmpty {
                        Text("No addresses found.")
                            .padding(.horizontal)
                    } else {
                        VStack {
                            ForEach(viewModel.addresses, id: \.id) { address in
                                Button(action: {
                                    viewModel.selectedAddressId = address.id
                                    if let selectedAddress = viewModel.addresses.first(where: { $0.defaultAddress }) ?? viewModel.addresses.first {
                                        viewModel.selectedAddress = Mapper.toAddress(address: selectedAddress)
                                    }
                                }) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(address.address1)
                                        Text(address.address2)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        Text("Phone: \(address.phone)")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(viewModel.selectedAddressId == address.id ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                                }
                                .padding(.horizontal)
                            }
                        }
                        .onAppear {
                            viewModel.selectedAddressId = viewModel.addresses.first(where: { $0.defaultAddress })?.id ?? viewModel.addresses.first?.id
                            if let selectedAddress = viewModel.addresses.first(where: { $0.defaultAddress }) ?? viewModel.addresses.first {
                                viewModel.selectedAddress = Mapper.toAddress(address: selectedAddress)
                            }
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Payment Method")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    HStack {
                        Button(action: {
                            viewModel.selectedPaymentMethod = .cod
                        }) {
                            Text("Cash on Delivery")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(viewModel.selectedPaymentMethod == .cod ? Color.blue : Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .foregroundColor(viewModel.selectedPaymentMethod == .cod ? .white : .black)
                        }
                        
                        Button(action: {
                            viewModel.selectedPaymentMethod = .stripe
                            model.preparePaymentSheet()
                        }) {
                            Text("Other")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(viewModel.selectedPaymentMethod == .stripe ? Color.blue : Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .foregroundColor(viewModel.selectedPaymentMethod == .stripe ? .white : .black)
                        }
                    }
                    .padding(.horizontal)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Have a coupon?")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    HStack {
                        TextField("Enter coupon code", text: $viewModel.couponCode)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        Button("Apply") {
                            viewModel.applyCoupon(viewModel.couponCode)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    
                    if viewModel.isCouponApplied {
                        Text("Discount is applied!")
                            .foregroundColor(.green)
                            .padding(.horizontal)
                    } else if !viewModel.couponCode.isEmpty {
                        Text("Invalid coupon")
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }
                }
                
                // MARK: - Order Summary
                let subtotal = totalPrice.currency
                let discountAmount = subtotal * viewModel.discountPercentage
                let total = subtotal - discountAmount
                
                VStack(spacing: 12) {
                    HStack {
                        Text("Items Cost")
                        Spacer()
                        Text("\("$".symbol)\(subtotal, specifier: "%.2f")")
                    }
                    HStack {
                        Text("Shipping & Handling")
                        Spacer()
                        Text("Free")
                    }
                    if viewModel.isCouponApplied {
                        HStack {
                            Text("Coupon Discount")
                                .foregroundColor(.green)
                            Spacer()
                            Text("-\("$".symbol)\(discountAmount, specifier: "%.2f")")
                                .foregroundColor(.green)
                        }
                    }
                    Divider()
                    HStack {
                        Text("Order Total")
                            .font(.headline)
                        Spacer()
                        Text("\("$".symbol)\(total, specifier: "%.2f")")
                            .font(.headline)
                    }
                }
                .padding(.horizontal)
                
                Button(action: {
                    showWaiting = true
                    
                    if viewModel.selectedPaymentMethod == .cod {
                        viewModel.placeOrder(items: items)
                    } else {
                        let totalInCents = Int(totalPrice * 100)
                        model.paymentAmount = totalInCents
                        model.updatePaymentSheet()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            if let controller = UIApplication.shared.connectedScenes
                                .compactMap({ $0 as? UIWindowScene })
                                .flatMap({ $0.windows })
                                .first(where: \.isKeyWindow)?.rootViewController {
                                
                                model.presentPaymentSheet(from: controller) { result in
                                    switch result {
                                    case .completed:
                                        viewModel.placeOrder(items: items)
                                    case .canceled:
                                        viewModel.setPaymentError()
                                        showWaiting = false
                                    case .failed:
                                        viewModel.setPaymentError()
                                        showWaiting = false
                                    }
                                }

                            }
                        }
                    }
                }) {
                    Text("Place Order")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(28)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
            .navigationTitle("Checkout")
            .onAppear {
                viewModel.fetchAddresses()
            }
            
            .alert(item: $viewModel.activeAlert) { alert in
                switch alert{
                case .paymentError:
                    return Alert(
                        title: Text("Payment Status"),
                        message: Text(viewModel.alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                case .orderPlaced:
                    return Alert(
                        title: Text("Order Placed"),
                        message: Text(viewModel.alertMessage),
                        dismissButton: .default(Text("OK")) {
                            cartVM.badgeCount = 0
                            showWaiting = false
                            coordinator.goBack()
                        }
                    )
                case .noAddress:
                    return Alert(
                        title: Text("Addresses"),
                        message: Text(viewModel.alertMessage),
                        primaryButton: .default(Text("Add")) {
                            coordinator.navigate(to: .addressForm(address: nil))
                        },
                        secondaryButton: .cancel {
                            coordinator.goBack()
                        }
                    )
                }
            }
            
            .overlay(
                Group {
                    if showWaiting {
                        ZStack {
                            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                            ProgressView("Processing...")
                                .padding()
                                .background(Color.black.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                    }
                }
            )
        }
    }
}

