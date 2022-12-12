//
//  NewsAPI.swift
//  NewsApplication
//
//  Created by valters.steinblums on 12/12/2022.
//

import Foundation

struct NewsAPI {
    
    static let shared = NewsAPI()
    
    private let apiKey = "5ae2470e968e40c99c3819b7d42f7d94"
    private let session = URLSession.shared
    private var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    func getNews(from category: NewsCategory, country: NewsCountry) async throws -> [Article] {
        try await fetchNews(from: generateTopNewsURL(from: category, country: country))
    }
    
    func searchNews(from query: String) async throws -> [Article] {
        try await fetchNews(from: generateSearchURL(from: query))
    }
    
    func fetchNews(from url: URL) async throws -> [Article] {
        
        let (data, response) = try await session.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Bad response")
        }
        
        let decodedData = try jsonDecoder.decode(NewsData.self, from: data)
        return decodedData.articles ?? []
    }
    
    func generateTopNewsURL(from category: NewsCategory, country: NewsCountry) -> URL {
        var url = "https://newsapi.org/v2/top-headlines/?"
        url += "apiKey=\(apiKey)"
        url += "&category=\(category)"
        url += "&country=\(country)"
        return URL(string: url)!
    }
    
    func generateSearchURL(from query: String) -> URL {
        var url = "https://newsapi.org/v2/everything?"
        url += "apiKey=\(apiKey)"
        url += "&q=\(query)"
        return URL(string: url)!
    }
}
