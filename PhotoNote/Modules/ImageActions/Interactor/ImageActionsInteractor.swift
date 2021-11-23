//
//  ImageActionsInteractor.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 23/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

import Firebase
import UIKit

protocol ImageActionsInteractorProtocol {
    
    func uploadPhotoInFirebase(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void)
}

class ImageActionsInteractor {
    
}

extension ImageActionsInteractor: ImageActionsInteractorProtocol {

    func uploadPhotoInFirebase(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let idUser = Auth.auth().currentUser?.uid else { return }
        let ref = Storage.storage().reference().child("PhotoNote").child(idUser).child(Date().getString())
        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        ref.putData(imageData, metadata: metaData) { (metaData, error) in
            guard metaData != nil else {
                completion(.failure(error!))
                return
            }
            ref.downloadURL { (url, error) in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(url))
            }
        }
    }
}
