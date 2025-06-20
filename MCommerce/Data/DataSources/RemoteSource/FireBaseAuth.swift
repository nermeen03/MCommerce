//
//  FireBaseAuth.swift
//  MCommerce
//
//  Created by Jailan Medhat on 18/06/2025.
//
import FirebaseCore
import FirebaseAuth
class FireBaseAuthHelper{
  static  let shared =  FireBaseAuthHelper()
    private init() {}


    func registerWithFirebase(email: String, password: String) {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                guard let user = authResult?.user
                else {
                    let error = error
                    print(error?.localizedDescription ?? "")
                   
                    
                    return
//                    print("Registration failed: \(error.localizedDescription)")
                    
                }
                user.sendEmailVerification { error in
                    if let error = error {
                        print("Error sending verification email: \(error.localizedDescription)")
                    } else {
                        print("Verification email sent to \(user.email ?? "")")
                    }
                }
            }
        }

    func checkEmailVerificationStatus(completion: @escaping (Bool) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(false)
            return
        }

        user.reload { error in
            if let error = error {
                print("Error reloading user: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(user.isEmailVerified)
            }
        }
    }



}
