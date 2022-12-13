//
//  NewsDataViewModel.swift
//  NewsApplication
//
//  Created by valters.steinblums on 12/12/2022.
//

import Foundation

enum NewsDataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}

struct FetchPickerValues: Equatable {
    var category: NewsCategory
    var country: NewsCountry
}

@MainActor
class NewsDataViewModel: ObservableObject {
    
    @Published var phase = NewsDataFetchPhase<[Article]>.empty
    @Published var fetchPickerValues: FetchPickerValues
    @Published var searchQuerry = ""
    private let newsAPI = NewsAPI.shared
    
    init(newsArticles: [Article]? = nil, selectedCategory: NewsCategory = .general, selectedCountry: NewsCountry = .us) {
        if let newsArticles = newsArticles {
            self.phase = .success(newsArticles)
        } else {
            self.phase = .empty
        }
        self.fetchPickerValues = FetchPickerValues(category: selectedCategory, country: selectedCountry)
    }
    
    func searchNews() async {
        let searchQuerry = self.searchQuerry.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        
        if searchQuerry.isEmpty {
            return
        }
        
        do {
            let articles = try await newsAPI.searchNews(from: searchQuerry)
            phase = .success(articles)
        } catch {
            phase = .failure(error)
        }
    }
    
    func loadNews() async {
        phase = .success(NewsData.previewNewsData)
//        phase = .empty
//
//        do {
//            let newsArticles = try await newsAPI.getNews(from: fetchPickerValues.category, country: fetchPickerValues.country)
//            phase = .success(newsArticles)
//        } catch {
//            phase = .failure(error)
//        }
    }
}
