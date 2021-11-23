//
//  PhotoMakerRouter.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 23/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

import UIKit

protocol PhotoMakerRouterProtocol {
    func openImageView(image: UIImage)
}

class PhotoMakerRouter {

weak var viewController: PhotoMakerViewController!

}

extension PhotoMakerRouter :PhotoMakerRouterProtocol {

    func openImageView(image: UIImage) {
        guard let vc = ImageActionsModuleInitializer(data: image).viewController else { return }
        viewController.present(vc, animated: true, completion: nil)
    }
}
