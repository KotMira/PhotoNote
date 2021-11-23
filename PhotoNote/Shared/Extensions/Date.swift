//
//  Date.swift
//  PhotoNote
//
//  Created by Andre Wolfsky on 23.11.2021.
//

import Foundation

extension Date{
    
    func getString() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd-hh:mm:ss"
        let stringDate = df.string(from: self)
        return stringDate
    }
}
