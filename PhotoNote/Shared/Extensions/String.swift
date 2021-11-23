//
//  String.swift
//  PhotoNote
//
//  Created by Andre Wolfsky on 23.11.2021.
//

import Foundation

extension String {
    
    func cheakEmailForm() -> Bool {
        if self.contains("@"), self.contains(".") {
            return true
        }
        return false
    }
}
