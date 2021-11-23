//
//  TabBarRouter.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 22/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

protocol TabBarRouterProtocol {

    func openAuth()
}

class TabBarRouter {

weak var viewController: TabBarViewController!

}

extension TabBarRouter :TabBarRouterProtocol {

    func openAuth() {
        let vc = AuthViewController.storyboardInstance()
                viewController.present(vc, animated: true, completion: nil)
    }
}
