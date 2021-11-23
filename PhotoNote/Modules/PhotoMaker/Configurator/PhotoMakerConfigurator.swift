//
//  PhotoMakerConfigurator.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 23/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

protocol PhotoMakerConfiguratorProtocol: AnyObject {
    func configure(with viewController: PhotoMakerViewController)
}

class PhotoMakerConfigurator: PhotoMakerConfiguratorProtocol {
    
    func configure(with viewController: PhotoMakerViewController) {
        let router = PhotoMakerRouter()
        let presenter = PhotoMakerPresenter()
        let interactor = PhotoMakerInteractor()
        
        viewController.presenter = presenter
        router.viewController = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = viewController
    }
}
