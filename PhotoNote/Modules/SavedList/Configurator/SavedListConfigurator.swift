//
//  SavedListConfigurator.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 23/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

protocol SavedListConfiguratorProtocol: AnyObject {
    func configure(with viewController: SavedListViewController)
}

class SavedListConfigurator: SavedListConfiguratorProtocol {
    
    func configure(with viewController: SavedListViewController) {
        let router = SavedListRouter()
        let presenter = SavedListPresenter()
        let interactor = SavedListInteractor()
        
        viewController.presenter = presenter
        router.viewController = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = viewController
    }
}
