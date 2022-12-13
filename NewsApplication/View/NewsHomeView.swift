//
//  NewsHomeView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import SwiftUI

struct NewsHomeView: View {
    
    @StateObject var newsDataVM: NewsDataViewModel
    @StateObject var currentWeatherVM: CurrentWeatherViewModel
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                SimpleWeatherView(currentWeather: currentWeather)
                    .task {
                        await loadCurrentWeather()
                    }
                
                Text("Viewing '\(newsDataVM.fetchPickerValues.category.text)' articles, from '\(newsDataVM.fetchPickerValues.country.text)'.")
                    .padding(.horizontal, 10)
                    .font(.subheadline)
                
                
                NewsListView(articles: articles)
                    .task(id: newsDataVM.fetchPickerValues) {
                        await loadTask()
                    }

            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func loadTask() async {
        await newsDataVM.loadNews()
    }
    
    private func loadCurrentWeather() async {
        await currentWeatherVM.loadCurrentWeather()
    }
    
    private var currentWeather: CurrentWeatherData {
        if case let .success(currentWeather) = currentWeatherVM.phase {
            return currentWeather
        } else {
            return CurrentWeatherData.previewCurrentWeatherData
        }
    }
    
    private var articles: [Article] {
        if case let .success(articles) = newsDataVM.phase {
            return articles
        } else {
            return NewsData.previewNewsData
        }
    }
}

struct NewsHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewsHomeView(newsDataVM: NewsDataViewModel(), currentWeatherVM: CurrentWeatherViewModel())
            .environmentObject(RealmManager())
    }
}
