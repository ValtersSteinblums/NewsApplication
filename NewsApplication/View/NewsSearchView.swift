//
//  NewsSearchView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import SwiftUI

struct NewsSearchView: View {
    
    @StateObject var newsDataVM = NewsDataViewModel()
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        NavigationStack {
            VStack {
                NewsListView(articles: articles)
                    .overlay(overlayView)
                    .navigationTitle("Search")
            }
            .searchable(text: $newsDataVM.searchQuerry, placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: newsDataVM.searchQuerry) { newValue in
                if newValue.isEmpty {
                    newsDataVM.phase = .empty
                }
            }
            .onSubmit(of: .search) {
                search()
            }
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch newsDataVM.phase {
        case .empty:
            if !newsDataVM.searchQuerry.isEmpty {
                ProgressView()
            } else {
                VStack(spacing: 8) {
                    Spacer()
                    
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                        .font(.system(size: 52))
                    
                    Text("Type your query to search from News API")
                    
                    Spacer()
                }
            }
        case .success(let articles) where articles.isEmpty:
            VStack(spacing: 8) {
                Spacer()
                
                Image(systemName: "magnifyingglass")
                    .imageScale(.large)
                    .font(.system(size: 52))
                
                Text("No search results found.")
                
                Spacer()
            }
        case .failure(let error):
            Text(error.localizedDescription)
        default:
            EmptyView()
        }
    
    }
    
    private var articles: [Article] {
        if case .success(let articles) = newsDataVM.phase {
            return articles
        } else {
            return []
        }
    }
    
    private func search() {
        Task {
            await newsDataVM.searchNews()
        }
    }
}

struct NewsSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NewsSearchView()
            .environmentObject(RealmManager())
    }
}
