//
//  NewsData.swift
//  NewsApplication
//
//  Created by valters.steinblums on 12/12/2022.
//

import Foundation
//import RealmSwift

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct NewsData: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]?
}

struct Article: Codable, Identifiable {
    
    // id from the response is almost every time as 'null'
    var id: String {url}
    let source: Source
    let title: String
    let url: String
    let publishedAt: Date
    
    let urlToImage: String?
    let description: String?
    
    // computed var's for the optionals
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
    
    var descriptionText: String {
        description ?? ""
    }
    
    // More readable Date text
    var publishInfo: String {
        "\(source.name) · \(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }
}

struct Source: Codable {
    let name: String
}

// preview for the articles
extension NewsData {
    static var previewNewsData: [Article] {
        let previewURL = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: previewURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let response = try? jsonDecoder.decode(NewsData.self, from: data)
        return response?.articles ?? []
    }
}
