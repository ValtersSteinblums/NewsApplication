//
//  NewsCountry.swift
//  NewsApplication
//
//  Created by valters.steinblums on 12/12/2022.
//

import Foundation

enum NewsCountry: String, CaseIterable, Identifiable {
    var id: Self {self}
    
    case lv
    case lt
    case ru
    case pl
    case us
    case cz
    case de
    case fr
    case gb
    
    var text: String {
        switch self {
        case .lv:
            return "Latvia"
        case .lt:
            return "Lithuania"
        case .ru:
            return "Russia"
        case .pl:
            return "Poland"
        case .us:
            return "USA"
        case .cz:
            return "Czechia"
        case .de:
            return "Denmark"
        case .fr:
            return "France"
        case .gb:
            return "Great Britain"
        }
    }
}
