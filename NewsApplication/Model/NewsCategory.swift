//
//  NewsCategory.swift
//  NewsApplication
//
//  Created by valters.steinblums on 12/12/2022.
//

import Foundation

enum NewsCategory: String, CaseIterable, Identifiable {
    var id: Self {self}
    
    case general
    case business
    case technology
    case entertainment
    case sports
    case science
    case health
    
    var text: String {
        if self == .general {
            return "Top Headlines"
        }
        return rawValue.capitalized
    }
}
