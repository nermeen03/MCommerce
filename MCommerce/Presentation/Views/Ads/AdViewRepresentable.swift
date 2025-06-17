////
////  ProductAdView.swift
////  MCommerce
////
////  Created by Nermeen Mohamed on 17/06/2025.
////
//
//import SwiftUI
//import GoogleMobileAds
//
//struct NativeAdViewRepresentable: UIViewRepresentable {
//    let adUnitID: String
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIView(context: Context) -> NativeAdView {
//        let nativeAdView = NativeAdView()
//        nativeAdView.translatesAutoresizingMaskIntoConstraints = false
//
//        let headlineLabel = UILabel()
//        headlineLabel.numberOfLines = 2
//        headlineLabel.font = .boldSystemFont(ofSize: 18)
//        nativeAdView.headlineView = headlineLabel
//
//        let bodyLabel = UILabel()
//        bodyLabel.numberOfLines = 3
//        bodyLabel.font = .systemFont(ofSize: 14)
//        nativeAdView.bodyView = bodyLabel
//
//        let callToActionButton = UIButton(type: .system)
//        callToActionButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
//        callToActionButton.backgroundColor = .systemBlue
//        callToActionButton.tintColor = .white
//        callToActionButton.layer.cornerRadius = 6
//        nativeAdView.callToActionView = callToActionButton
//
//        let stack = UIStackView(arrangedSubviews: [headlineLabel, bodyLabel, callToActionButton])
//        stack.axis = .vertical
//        stack.spacing = 8
//        nativeAdView.addSubview(stack)
//
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            stack.topAnchor.constraint(equalTo: nativeAdView.topAnchor, constant: 8),
//            stack.leadingAnchor.constraint(equalTo: nativeAdView.leadingAnchor, constant: 8),
//            stack.trailingAnchor.constraint(equalTo: nativeAdView.trailingAnchor, constant: -8),
//            stack.bottomAnchor.constraint(equalTo: nativeAdView.bottomAnchor, constant: -8),
//        ])
//
//        context.coordinator.loadAd(into: nativeAdView)
//
//        return nativeAdView
//    }
//
//    func updateUIView(_ uiView: NativeAdView, context: Context) {}
//
//    class Coordinator: NSObject, NativeAdLoaderDelegate {
//        var parent: NativeAdViewRepresentable
//        var adLoader: AdLoader!
//
//        init(_ parent: NativeAdViewRepresentable) {
//            self.parent = parent
//            super.init()
//        }
//
//        func loadAd(into view: NativeAdView) {
//            let options = NativeAdViewAdOptions()
//            adLoader = AdLoader(adUnitID: parent.adUnitID,
//                                rootViewController: UIApplication.shared.connectedScenes
//                                    .compactMap { ($0 as? UIWindowScene)?.keyWindow }
//                                    .first?.rootViewController,
//                                adTypes: [.native],
//                                options: [options])
//            adLoader.delegate = self
//            adLoader.load(Request())
//        }
//
//        func adLoader(_ adLoader: AdLoader, didReceive nativeAd: NativeAd) {
//            guard let nativeAdView = adLoader.delegate as? NativeAdView else { return }
//
//            nativeAdView.nativeAd = nativeAd
//            (nativeAdView.headlineView as? UILabel)?.text = nativeAd.headline
//            (nativeAdView.bodyView as? UILabel)?.text = nativeAd.body
//            (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
//
//            nativeAdView.headlineView?.isHidden = nativeAd.headline == nil
//            nativeAdView.bodyView?.isHidden = nativeAd.body == nil
//            nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil
//        }
//
//        func adLoader(_ adLoader: AdLoader, didFailToReceiveAdWithError error: any Error) {
//            print("Failed to load native ad: \(error.localizedDescription)")
//        }
//    }
//}
