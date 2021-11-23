//
//  ImageActionsInitializer.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 23/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

import UIKit

class ImageActionsModuleInitializer {

    weak var viewController: ImageActionsViewController!
    let data: UIImage

    init (data: UIImage) {
        self.data = data
        viewController = ImageActionsViewController.storyboardInstance()
        
        let router = ImageActionsRouter()
        let presenter = ImageActionsPresenter(data: data)
        let interactor = ImageActionsInteractor()
        
        viewController.presenter = presenter
        router.viewController = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = viewController
    }

}
