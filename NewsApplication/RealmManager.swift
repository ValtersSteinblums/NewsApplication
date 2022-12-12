//
//  RealmManager.swift
//  NewsApplication
//
//  Created by valters.steinblums on 12/12/2022.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    
    //let article: Article
    
    private(set) var localRealm: Realm?
    @Published var favourites: [NewsFavouritesViewModel] = []
    
    init() {
        openRealm()
        getFavourites()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        } catch {
            print("Error opening Realm:: \(error)")
        }
    }
    
    func addFavourite(from article: Article) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newFavourite = NewsFavouritesViewModel(value: ["id": article.id, "newsTitle": article.title, "newsDescription": article.descriptionText, "newsUrl": article.url, "newsPublishInfo": article.publishInfo, "newsImage": article.urlToImage])
                    localRealm.add(newFavourite)
                    getFavourites()
                    print("Added new favourite to Realm:: \(newFavourite)")
                }
            } catch {
                print("Error adding favourite to Realm:: \(error)")
            }
        }
    }
    
    func getFavourites() {
        if let localRealm = localRealm {
            let allFavourites = localRealm.objects(NewsFavouritesViewModel.self)
            favourites = []
            allFavourites.forEach { favourite in
                favourites.append(favourite)
            }
        }
    }
    
    func removeFavourite(remove articleId: String) {
        if let localRealm = localRealm {
            do {
                let favouriteToDelete = localRealm.objects(NewsFavouritesViewModel.self).filter("id == %@", articleId)
                guard !favouriteToDelete.isEmpty else {return}
                
                try localRealm.write {
                    localRealm.delete(favouriteToDelete)
                    getFavourites()
                    print("Deleted favourite with id:: \(articleId)")
                }
            } catch {
                print("Error deleting favourite:: \(articleId), from Realm:: \(error)")
            }
        }
    }
    
}
