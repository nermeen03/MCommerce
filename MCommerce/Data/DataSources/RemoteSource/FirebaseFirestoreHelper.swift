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
    private let orderCollection = "orders"
    private let cardCollection = "cards"
    private let userCollection = "users"
    let firestoreUserId = UserDefaultsManager.shared.getUserId()!.replacingOccurrences(of: "/", with: "_")
    func addProductToFavorites(product: FavoriteProduct, completion: @escaping (Result<Void, Error>) -> Void) {
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
    

    func addOrderId(orderId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let data: [String: Any] = [
            "createdAt": FieldValue.serverTimestamp()
        ]
        let sanitizedId = orderId.replacingOccurrences(of: "/", with: "_")

        db.collection(userCollection)
            .document(firestoreUserId)
            .collection(orderCollection)
            .document(sanitizedId)
            .setData(data) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }
    func getAllOrderIds(completion: @escaping (Result<[String], Error>) -> Void) {
        print(firestoreUserId)

        db.collection(userCollection)
            .document(firestoreUserId)
            .collection(orderCollection)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let snapshot = snapshot {
                    let orderIds = snapshot.documents.map { $0.documentID.replacingOccurrences(of: "_", with: "/") }
                    print(orderIds)
                    completion(.success(orderIds))
                }
            }
    }
    
    func saveCardId(cardId : String){
        let data: [String: Any] = [
            "createdAt": FieldValue.serverTimestamp()
        ]
        let sanitizedId = cardId.replacingOccurrences(of: "/", with: "_")

        db.collection(userCollection)
            .document(firestoreUserId)
            .collection(cardCollection)
            .document(sanitizedId)
            .setData(data) { error in
                if let error = error {
                    print("error")
                } else {
                    print("success")
                }
            }
    }
    
    func getCardId(completion: @escaping (String?) -> Void) {
        db.collection(userCollection)
            .document(firestoreUserId)
            .collection(cardCollection)
            .getDocuments { (snapshot, error) in
                if error != nil {
                    completion(nil)
                } else if let snapshot = snapshot {
                    let cardId = snapshot.documents.map { $0.documentID.replacingOccurrences(of: "_", with: "/") }
                    completion(cardId[0])
                }
            }
    }
    
    func removeAllCardIds(completion: ((Error?) -> Void)? = nil) {
        db.collection(userCollection)
            .document(firestoreUserId)
            .collection(cardCollection)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion?(error)
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion?(nil)
                    return
                }
                
                let batch = self.db.batch()
                for document in documents {
                    batch.deleteDocument(document.reference)
                }
                
                batch.commit { batchError in
                    completion?(batchError)
                }
            }
    }

}
