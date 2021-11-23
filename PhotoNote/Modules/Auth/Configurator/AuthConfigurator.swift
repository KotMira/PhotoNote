//
//  AuthConfigurator.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 22/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

protocol AuthConfiguratorProtocol: AnyObject {
    func configure(with viewController: AuthViewController)
}

class AuthConfigurator: AuthConfiguratorProtocol {
    
    func configure(with viewController: AuthViewController) {
        let router = AuthRouter()
        let presenter = AuthPresenter()
        let interactor = AuthInteractor()
        
        viewController.presenter = presenter
        router.viewController = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = viewController
    }
}
