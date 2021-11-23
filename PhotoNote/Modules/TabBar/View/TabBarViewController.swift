//
//  TabBarViewController.swift
//  PhotoNote
//
//  Created by AndreWolfsky on 22/11/2021.
//  Copyright © 2021 Wolfsky. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    var presenter: TabBarPresenterProtocol!
    private let configurator: TabBarConfiguratorProtocol = TabBarConfigurator()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.cheakAuth()
        setupInitialState()
        
    }
}

extension TabBarViewController {

    private func setupInitialState() {
        let arrayBarItems = presenter.configureVCBarItems()
        self.setViewControllers(arrayBarItems, animated: false)
        self.tabBar.tintColor = .blue
        self.tabBar.backgroundColor = .gray
    }
}
