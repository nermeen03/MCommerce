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
            if let user = authResult?.user {
                user.sendEmailVerification { error in
                    if let error = error {
                        print("Error sending verification email: \(error.localizedDescription)")
                    } else {
                        print("Verification email sent to \(user.email ?? "")")
                    }
                }
            } else if let error = error {
                print("Registration failed: \(error.localizedDescription)")
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

    var emailCheckTimer: Timer?
    var remainingChecks = 24  // 2 minutes / 5 seconds

    func startEmailVerificationListener(completion : @escaping () -> Void) {
        remainingChecks = 24
        emailCheckTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            self.checkEmailVerificationStatus { isVerified in
                if isVerified {
                    self.emailCheckTimer?.invalidate()
                    self.emailCheckTimer = nil
                    print("✅ Email is verified!")
                    // self.registerToShopify()
                } else {
                    self.remainingChecks -= 1
                    print("⏳ Waiting for email verification... (\(self.remainingChecks) checks left)")
                    
                    if self.remainingChecks <= 0 {
                        self.emailCheckTimer?.invalidate()
                        self.emailCheckTimer = nil
                        print("⛔️ Verification timed out after 2 minutes.")
                        // Optionally notify user to try again
                    }
                }
            }
        }
    }

}
