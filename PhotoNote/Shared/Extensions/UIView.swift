//
//  UIView.swift
//  PhotoNote
//
//  Created by Andre Wolfsky on 22.11.2021.
//

import UIKit

extension UIView {
    
    func constraintToParent(left: CGFloat = 0, right: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0) {
        guard let sv = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([leftAnchor.constraint(equalTo: sv.leftAnchor, constant: left),
                                     rightAnchor.constraint(equalTo: sv.rightAnchor, constant: right),
                                     topAnchor.constraint(equalTo: sv.topAnchor, constant:  top),
                                     bottomAnchor.constraint(equalTo: sv.bottomAnchor, constant: bottom)
                                    ])
    }
    
    func constraintToParentWithHeight(left: CGFloat = 0, right: CGFloat = 0, top: CGFloat = 0, height: CGFloat = 20) {
        guard let sv = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([leftAnchor.constraint(equalTo: sv.leftAnchor, constant: left),
                                     rightAnchor.constraint(equalTo: sv.rightAnchor, constant: right),
                                     topAnchor.constraint(equalTo: sv.topAnchor, constant: top),
                                     heightAnchor.constraint(equalTo: heightAnchor)
                                     ])
    }
    
    func constraintUnderParent(view: UIView, left: CGFloat = 0, right: CGFloat = 0, top: CGFloat = 0, height: CGFloat = 20) {
        guard let sv = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([leftAnchor.constraint(equalTo: sv.leftAnchor, constant: left),
                                     rightAnchor.constraint(equalTo: sv.rightAnchor, constant: right),
                                     topAnchor.constraint(equalTo: view.bottomAnchor, constant:  top),
                                     heightAnchor.constraint(equalTo: heightAnchor)
                                     ])
    }
}
