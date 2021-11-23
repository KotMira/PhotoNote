//
//  TabBarConfigurator.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 22/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

protocol TabBarConfiguratorProtocol: AnyObject {
    func configure(with viewController: TabBarViewController)
}

class TabBarConfigurator: TabBarConfiguratorProtocol {
    
    func configure(with viewController: TabBarViewController) {
        let router = TabBarRouter()
        let presenter = TabBarPresenter()
        let interactor = TabBarInteractor()
        
        viewController.presenter = presenter
        router.viewController = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = viewController
    }
}
