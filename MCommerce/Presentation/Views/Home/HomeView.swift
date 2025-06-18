//
//  SwiftUIView.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//

import SwiftUI
import Alamofire

struct HomeView: View {
    @EnvironmentObject var coordinator: BrandsCoordinator
    @StateObject private var brandViewModel = DIContainer.shared.makeBrandViewModel()
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    BannerView()
                    BrandsView(viewModel: brandViewModel)
                    RecentlyViewedView()
                }
                .padding()
            }
            //        .padding(.bottom, 60)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 50)
            }
        }.navigationTitle(Text("Home"))
            .padding(.top)

    }
}

#Preview {
    HomeView()
}

func createDiscountCode() {
    guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as? String,
          let storefrontToken = Bundle.main.infoDictionary?["STOREFRONT_API"] as? String,
    let apiKey = Bundle.main.infoDictionary?["API_KEY"], let token = Bundle.main.infoDictionary?["ADMIN_TOKEN"],let key = Bundle.main.infoDictionary?["ADMIN_KEY"]else {
        return
    }
    
    let url = "https://\(apiKey):\(token)\(key)@\(baseURL)/admin/api/2022-01/graphql.json"
    
    let headers: HTTPHeaders = [
        "Content-Type": "application/json",
        "X-Shopify-Storefront-Access-Token": storefrontToken
    ]
    
    let mutation = """
    mutation discountCodeBasicCreate($discount: DiscountCodeBasicInput!) {
      discountCodeBasicCreate(basicCodeDiscount: $discount) {
        codeDiscountNode {
          id
        }
        userErrors {
          field
          message
        }
      }
    }
    """
    
    let variables: [String: Any] = [
        "discount": [
            "title": "Weekend Special",
            "startsAt": "2025-06-21T00:00:00Z",
            "endsAt": "2025-06-22T23:59:59Z",
            "customerSelection": ["all": true],
            "customerGets": [
                "value": ["percentage": 0.25],
                "items": ["all": true]
            ],
            "code": "WEEKEND25"
        ]
    ]


    
    let body: [String: Any] = [
        "query": mutation,
        "variables": variables
    ]
    
    AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
        .validate()
        .responseString { response in
            switch response.result {
            case .success(let responseString):
                print("✅ RAW Response String: \(responseString)")
            case .failure(let error):
                print("❗ Network error: \(error)")
            }
        }

}
