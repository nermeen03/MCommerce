//
//  CouponCardView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

import SwiftUI

struct CouponsRowView: View {
    let discountObj = DiscountNodesResponse(
        data: DiscountNodesData(
            discountNodes: DiscountNodes(
                edges: [
                    DiscountEdge(
                        node: DiscountNode(
                            id: "gid://shopify/DiscountNode/1057371001",
                            discount: Discount(
                                __typename: "DiscountAutomaticBasic",
                                title: "10% off orders over $50",
                                status: "ACTIVE",
                                startsAt: "2025-06-01T00:00:00Z",
                                endsAt: "2025-06-30T23:59:59Z",
                                summary: "10% off orders over $50",
                                codes: nil
                            )
                        )
                    ),
                    DiscountEdge(
                        node: DiscountNode(
                            id: "gid://shopify/DiscountNode/1057371002",
                            discount: Discount(
                                __typename: "DiscountCodeBasic",
                                title: "WELCOME10",
                                status: "ACTIVE",
                                startsAt: nil,
                                endsAt: nil,
                                summary: "10% off first order",
                                codes: CodesContainer(
                                    nodes: [
                                        CodeNode(code: "WELCOME10")
                                    ]
                                )
                            )
                        )
                    )
                ]
            )
        )
    )


    var body: some View {
        let data = discountObj.data.discountNodes.edges
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(data) { item in
                    CouponCardView(discount: item.node.discount)
                }
            }
            .padding(.horizontal)
        }
    }
}


#Preview {
    CouponsRowView()
}
