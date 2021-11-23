//
//  PhotoMakerPresenter.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 23/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

import UIKit

protocol PhotoMakerPresenterProtocol {

    func openImageActions (image: UIImage)
}

class PhotoMakerPresenter {

    weak var view: PhotoMakerViewController!
    var interactor: PhotoMakerInteractorProtocol!
    var router: PhotoMakerRouterProtocol!

}

extension PhotoMakerPresenter: PhotoMakerPresenterProtocol {
    
    func openImageActions(image: UIImage) {
        router.openImageView(image: image)
    }
    
}
