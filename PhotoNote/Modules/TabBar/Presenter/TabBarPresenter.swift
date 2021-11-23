//
//  TabBarPresenter.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 22/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

import UIKit

protocol TabBarPresenterProtocol {
    func configureVCBarItems() -> [UINavigationController]
    func cheakAuth()
}

class TabBarPresenter {

    weak var view: TabBarViewController!
    var interactor: TabBarInteractorProtocol!
    var router: TabBarRouterProtocol!

}

extension TabBarPresenter: TabBarPresenterProtocol {
    
   private func generateTabBarItem(vc: UIViewController, title: String, icon: UIImage) -> UINavigationController {
        let navItem = UINavigationController(rootViewController: vc)
        navItem.tabBarItem.title = title
        navItem.tabBarItem.image = icon
        return navItem
    }
    
    func configureVCBarItems() -> [UINavigationController] {
        let photoVC = PhotoMakerViewController.storyboardInstance()
        let savedImageVC = SavedListViewController.storyboardInstance()
        let authVC = AuthViewController.storyboardInstance()
        
        let photoVCBarItem = generateTabBarItem(vc: photoVC, title: "Photo", icon: UIImage(systemName: "camera.viewfinder")!)
        let imageVCBarItem = generateTabBarItem(vc: savedImageVC, title: "Favorite", icon: UIImage(systemName: "star")!)
        let authVCBarItem = generateTabBarItem(vc: authVC, title: "Account", icon: UIImage(systemName: "gear")!)
        
        return [photoVCBarItem, imageVCBarItem, authVCBarItem]
    }

    func cheakAuth() {
        interactor.cheakAuth { [weak self] status in
            guard let self = self else { return }
            if !status {
                self.router.openAuth()
            }
        }
    }
}

