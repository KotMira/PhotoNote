//
//  UIViewController.swift
//  PhotoNote
//
//  Created by Andre Wolfsky on 22.11.2021.
//

import UIKit

extension UIViewController {
    
    static func storyboardInstance() -> Self {
        let storyboard = UIStoryboard.init(name: String(describing: Self.self), bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as! Self
    }
}
