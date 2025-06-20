//
//  FavoriteProduct.swift
//  MCommerce
//
//  Created by Jailan Medhat on 20/06/2025.
//
import Foundation
import FirebaseFirestore

struct FavoriteProduct: Codable, Identifiable {
    @DocumentID var id: String? // Firestore document ID (optional)
    let productId: String
    let title: String
    let imageUrl: String
   
}
