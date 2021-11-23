//
//  SavedListInteractor.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 23/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

import UIKit
import Firebase

protocol SavedListInteractorProtocol {
    
    func getData(completion: @escaping (Result<[StorageReference], Error>) -> Void)
    func getImages(ref: StorageReference, completion: @escaping (UIImage) -> Void)
}

class SavedListInteractor {
    
}

extension SavedListInteractor: SavedListInteractorProtocol {
    
    func getData(completion: @escaping (Result<[StorageReference], Error>) -> Void) {
        var data: [StorageReference] = []
        guard let idUser = Auth.auth().currentUser?.uid else { return }
        let ref = Storage.storage().reference().child("PhotoNote/\(idUser)")
        ref.listAll { (result, error) in
            if let error = error {
                completion(.failure(error))
            }
            for item in result.items {
                data.append(item)
            }
            completion(.success(data))
        }
    }
    
    func getImages(ref: StorageReference, completion: @escaping (UIImage) -> Void) {
        let ref = ref
        let megabyte = Int64(1 * 1024 * 1024)
        ref.getData(maxSize: megabyte) { (data, error) in
            guard let imageData = data else { return }
            guard let image = UIImage(data: imageData) else { return }
            completion(image)
        }
    }
}
