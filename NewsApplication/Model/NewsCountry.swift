//
//  NewsCountry.swift
//  NewsApplication
//
//  Created by valters.steinblums on 12/12/2022.
//

import Foundation

enum NewsCountry: String, CaseIterable, Identifiable {
    var id: Self {self}
    
    case LV
    case LT
    case RU
    case PL
    case US
    case CZ
    case DE
    case FR
    case GB
    
    var text: String {
        switch self {
        case .LV:
            return "Latvia"
        case .LT:
            return "Lithuania"
        case .RU:
            return "Russia"
        case .PL:
            return "Poland"
        case .US:
            return "USA"
        case .CZ:
            return "Czechia"
        case .DE:
            return "Denmark"
        case .FR:
            return "France"
        case .GB:
            return "Great Britain"
        }
    }
}
