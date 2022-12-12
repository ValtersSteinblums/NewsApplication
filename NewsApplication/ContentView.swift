//
//  ContentView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 12/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var realmManager = RealmManager()
    @StateObject var newsDataVM = NewsDataViewModel()
    
    var body: some View {
        NewsListView(articles: articles)
            .environmentObject(realmManager)
    }
    
    private var articles: [Article] {
        if case let .success(articles) = newsDataVM.phase {
            return articles
        } else {
            return NewsData.previewNewsData
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
