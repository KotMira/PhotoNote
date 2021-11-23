//
//  TabBarInteractor.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 22/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

import Firebase

protocol TabBarInteractorProtocol {

    func cheakAuth (statusAuth: @escaping (Bool) -> Void)
}

class TabBarInteractor {

}

extension TabBarInteractor: TabBarInteractorProtocol {

    func cheakAuth (statusAuth: @escaping (Bool) -> Void) {
        Auth.auth().addStateDidChangeListener ({ (auth, user) in
            if user != nil {
                let info = user?.email
                print ("true")
                print (info)
                statusAuth(true)
            } else {
            print("false")
            statusAuth(false)
            }
        })
    }
}
