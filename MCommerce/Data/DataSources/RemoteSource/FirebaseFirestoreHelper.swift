//
//  FirebaseFirestoreHelper.swift
//  MCommerce
//
//  Created by Jailan Medhat on 20/06/2025.
//

import Foundation
import FirebaseFirestore




class FirebaseFirestoreHelper {
    static let shared = FirebaseFirestoreHelper()
    private init() {}
    private let db = Firestore.firestore()
    private let favCollection = "favorites"
    private let userCollection = "users"
    let firestoreUserId = UserDefaultsManager.shared.getUserId()!.replacingOccurrences(of: "/", with: "_")
    // MARK: - Add Product to Favorites
    func addProductToFavorites(product: FavoriteProduct, completion: @escaping (Result<Void, Error>) -> Void) {
    print("add clciked zzzsjsjjsjjshhshhhssgsssgsgssshshhshshssjsjsbaab")
        do {
        
            let docId = product.productId
            try db.collection(userCollection)
                .document(firestoreUserId).collection(favCollection).document(docId)
                .setData(from: product) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
        } catch {
            completion(.failure(error))
        }
    }
    

    func deleteProductFromFavorites( productId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let docId = productId
        db.collection(userCollection).document(firestoreUserId)
            .collection(favCollection).document(docId).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func getFavorites(f completion: @escaping (Result<[FavoriteProduct], Error>) -> Void) {
        db.collection(userCollection).document(firestoreUserId).collection(favCollection)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    let favorites = snapshot?.documents.compactMap { doc in
                        try? doc.data(as: FavoriteProduct.self)
                    } ?? []
                    completion(.success(favorites))
                }
            }
    }
   

        // Check if product is already in favorites
        func isProductFavorited(productId: String, completion: @escaping (Bool) -> Void) {
           
            
            db.collection(userCollection).document(firestoreUserId).collection(favCollection).document(productId).getDocument { document, error in
                guard let document = document else {
                    return
                        }
             completion(document.exists )
                
            }
        }
    

}
