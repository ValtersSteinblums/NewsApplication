//
//  NewsFavouritesViewModel.swift
//  NewsApplication
//
//  Created by valters.steinblums on 12/12/2022.
//

import Foundation
import RealmSwift

class NewsFavouritesViewModel: Object {
    
    @Persisted(primaryKey: true) var id = ""
    @Persisted var newsTitle = ""
    @Persisted var newsDescription = ""
    @Persisted var newsUrl = ""
    @Persisted var newsPublishInfo = ""
    @Persisted var newsImage = ""
    
}
