//
//  ImageActionsViewController.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 23/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

import UIKit
import Shuffle_iOS

class ImageActionsViewController: UIViewController {
    
    var presenter: ImageActionsPresenterProtocol!
    let cardStack = SwipeCardStack()
    var array: [UIImage] = []
    var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialState()
    }
}

extension ImageActionsViewController {
    
    func initialState() {
        array = presenter.givingData()
        configureSwipeImage()
        configureLabel()
    }
    
    func configureSwipeImage() {
        cardStack.dataSource = self
        cardStack.delegate = self
        view.addSubview(cardStack)
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        cardStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cardStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cardStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        cardStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
    }
    
    func configureLabel() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 80).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.font = UIFont.systemFont(ofSize: 21)
    }
    
    func changeLabel(with text: String, color: UIColor) {
        label.textColor = color
        label.text = text
    }
    
    func card(fromImage image: UIImage) -> SwipeCard {
        let card = SwipeCard()
        card.swipeDirections = [.left, .right, .down, .up]
        card.content = UIImageView(image: image)
        //        card.setOverlay(UIImageView(image: image), forDirection: .down)
        
        let leftOverlay = UIView()
        leftOverlay.backgroundColor = .green
        
        let rightOverlay = UIView()
        rightOverlay.backgroundColor = .red
        
        let downOverlay = UIView()
        downOverlay.backgroundColor = .black
        
        let upOverlay = UIView()
        upOverlay.backgroundColor = .white
        
        card.setOverlays([.left: leftOverlay, .right: rightOverlay, .down: downOverlay, .up: upOverlay])
        
        return card
    }
    
}

extension ImageActionsViewController: SwipeCardStackDataSource, SwipeCardStackDelegate {
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        return card(fromImage: array[index])
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return array.count
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        switch direction {
        case .down:
            changeLabel(with: "CHANGE", color: .black)
        case .up:
            changeLabel(with: "REPEAT", color: .gray)
        case .left:
            changeLabel(with: "LIKE", color: .green)
//            presenter.saveProductInRealm(image: array[index], liked: true)
            presenter.uploadPhotoInFirebase(image: array[index], liked: true)
        case .right:
            changeLabel(with: "DISLIKE", color: .red)
//            presenter.saveProductInRealm(image: array[index], liked: false)
            presenter.uploadPhotoInFirebase(image: array[index], liked: false)
        }
    }
    
}
