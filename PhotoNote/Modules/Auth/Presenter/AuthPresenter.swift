//
//  AuthPresenter.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 22/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

import UIKit

protocol AuthPresenterProtocol {
    
    func getHeightKeyboard(height: @escaping (CGFloat) -> Void)
    func hidedKeyboard(kbHide: @escaping (Bool) -> Void)
    func authUser(email: String, password: String)
    func createUser(email: String, password: String)
    func singOutUser()
}

class AuthPresenter {
    
    weak var view: AuthViewController!
    var interactor: AuthInteractorProtocol!
    var router: AuthRouterProtocol!
    
}

extension AuthPresenter: AuthPresenterProtocol {
    
    func getHeightKeyboard(height: @escaping (CGFloat) -> Void) {
        interactor.showedKeyboard { kbSize in
            let kbHeight = kbSize.height
            height(kbHeight)
        }
    }
    
    func hidedKeyboard(kbHide: @escaping (Bool) -> Void) {
        interactor.hidedKeyboard { hide in
            kbHide(hide)
        }
    }
    
    func authUser(email: String, password: String) {
        if email.cheakEmailForm(), password != "" {
            interactor.authUser(email: email, password: password) { status in
                if status {
                    print ("User in system")
                }
            }
        }
    }
    
    func createUser(email: String, password: String) {
        if email.cheakEmailForm(), password != "" {
            interactor.createUser(email: email, password: password) { status in
                if status {
                    print ("User created")
                }
            }
        }
    }
    
    func singOutUser() {
        interactor.singOutUser()
    }
}

