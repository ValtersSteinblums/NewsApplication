//
//  NewsListView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 01/12/2022.
//

import SwiftUI

struct NewsListView: View {
    @EnvironmentObject var realmManager: RealmManager
    let articles: [Article]
    
    var body: some View {
        List {
            ForEach(articles) { article in
                NewsSingleView(article: article)
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(articles: NewsData.previewNewsData)
            .environmentObject(RealmManager())
    }
}
