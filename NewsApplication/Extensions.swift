//
//  Extensions.swift
//  NewsApplication
//
//  Created by valters.steinblums on 14/12/2022.
//

import Foundation

// Extension for rounded Double to 0 decimals
extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}
