//
//  AuthInteractor.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 22/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

protocol AuthInteractorProtocol {
    
    func showedKeyboard(closure: @escaping (CGRect) -> Void)
    func hidedKeyboard(closure: @escaping (Bool) -> Void)
    func authUser(email: String, password: String, status: @escaping (Bool) -> Void)
    func createUser(email: String, password: String, status: @escaping (Bool) -> Void)
    func singOutUser()
}

class AuthInteractor {
    
}

extension AuthInteractor: AuthInteractorProtocol {
    
    func showedKeyboard(closure: @escaping (CGRect) -> Void) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: nil) { notification in
            guard let userInfo = notification.userInfo else { return }
            let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            closure(kbFrameSize)
        }
        
    }
    
    func hidedKeyboard(closure: @escaping (Bool) -> Void) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: nil) { _ in
            closure(true)
        }
    }
    
    func authUser(email: String, password: String, status: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                status(false)
            }
            if user != nil {
                status(true)
            }
            status(false)
        }
    }
    
    func createUser(email: String, password: String, status: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print ("WE HAVE PROBLEM")
                print (error)
                status(false)
            } else {
                status(true)
            }
        }
    }
    
    func singOutUser() {
        try? Auth.auth().signOut()
        print("user sign out")
    }
    
}
