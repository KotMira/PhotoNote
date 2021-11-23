//
//  SavedListPresenter.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 23/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

import UIKit
import Firebase

protocol SavedListPresenterProtocol {
    
    func getData(completion: @escaping () -> Void)
    func getDataCount() -> Int
    func getImage(for index: Int, completion: @escaping (UIImage) -> Void)
}

class SavedListPresenter {
    
    weak var view: SavedListViewController!
    var interactor: SavedListInteractorProtocol!
    var router: SavedListRouterProtocol!
    var arrayImages: [StorageReference] = []

}

extension SavedListPresenter: SavedListPresenterProtocol {
    
    func getData(completion: @escaping () -> Void) {
        interactor.getData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                self.arrayImages = data
                print ("zzz \(self.arrayImages)")
                completion()
            }
        }
    }
    
    func getDataCount() -> Int {
        if arrayImages.isEmpty {
            return 0
        } else {
            return arrayImages.count
        }
    }
    
    func getImage(for index: Int, completion: @escaping (UIImage) -> Void) {
        if !arrayImages.isEmpty {
            let ref = arrayImages[index]
            interactor.getImages(ref: ref) { image in
                completion(image)
            }
        }
    }
}


