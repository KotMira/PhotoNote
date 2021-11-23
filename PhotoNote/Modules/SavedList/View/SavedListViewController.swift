//
//  SavedListViewController.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 23/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

import UIKit

class SavedListViewController: UIViewController {
    
    var presenter: SavedListPresenterProtocol!
    private let configurator: SavedListConfiguratorProtocol = SavedListConfigurator()
    var collectionView: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        setupInitialState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
}

extension SavedListViewController {
    
    func setupInitialState() {
        presenter.getData { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
        configureCollectionView()
    }
    
    func configureCollectionView() {
        let layout = setupLayout()
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "SavedListCell", bundle: nil), forCellWithReuseIdentifier: "SavedListCell")
        view.addSubview(collectionView)
        collectionView.backgroundColor = .blue
    }
    
    func setupLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = (view.frame.width - 48)/2
        let height = width
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        return layout
    }
}

extension SavedListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = presenter.getDataCount()
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SavedListCell", for: indexPath) as! SavedListCell
        presenter.getImage(for: indexPath.row) { image in
            cell.configureCell(image: image)
        }
        return cell
    }
    
}

