//
//  ImageActionsPresenter.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 23/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

import UIKit

protocol ImageActionsPresenterProtocol {
    
    func givingData() -> [UIImage]
    func uploadPhotoInFirebase(image: UIImage, liked: Bool)
}

class ImageActionsPresenter {
    
    weak var view: ImageActionsViewController!
    var interactor: ImageActionsInteractorProtocol!
    var router: ImageActionsRouterProtocol!
    var data = UIImage()
    
    init(data: UIImage) {
        self.data = data
    }
}

extension ImageActionsPresenter: ImageActionsPresenterProtocol {
    
    func givingData() -> [UIImage] {
            let image = data
            return [image, image, image, image, image]
    }
    
    func uploadPhotoInFirebase(image: UIImage, liked: Bool) {
        interactor.uploadPhotoInFirebase(image: image) { result in
            print (result)
        }
    }
}
