//
//  Store.swift
//  Store
//
//  Created by 风起兮 on 2021/8/27.
//

import SwiftUI
import AuthenticationServices
import StoreKit

class Model: ObservableObject {
    
    @Published var account: Account?
    
    var hasAccount: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return userCredential != nil && account != nil
        #endif
    }
    
    
    let defaults = UserDefaults(suiteName: "group.example.fruta")
    
    private var userCredential: String? {
        get { defaults?.string(forKey: "UserCredential") }
        set { defaults?.setValue(newValue, forKey: "UserCredential") }
    }
    
    
    func authorizeUser(_ result: Result<ASAuthorization, Error>) {
        guard case .success(let authorization) = result, let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            if case .failure(let error) = result {
                print("Authentication error: \(error.localizedDescription)")
            }
            return
        }
        DispatchQueue.main.async {
            self.userCredential = credential.user
            self.createAccount()
        }
    }
    
    
    func createAccount() {
        guard account == nil else { return }
        account = Account()
//        addOrderToAccount()
    }
}


