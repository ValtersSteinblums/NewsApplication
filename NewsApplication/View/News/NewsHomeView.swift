//
//  NewsHomeView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import SwiftUI
import CoreLocation

struct NewsHomeView: View {
    
    @StateObject var newsDataVM: NewsDataViewModel
    @StateObject var currentWeatherVM: CurrentWeatherViewModel
    @EnvironmentObject var realmManager: RealmManager
    @EnvironmentObject var locationManager: LocationManager
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                SimpleWeatherView(currentWeather: currentWeather)
                    .environmentObject(locationManager)
                    .task {
                        if let location = locationManager.location {
                            await loadCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                        }
                    }
                    
                
                Text("Viewing '\(newsDataVM.fetchPickerValues.category.text)' articles, from '\(newsDataVM.fetchPickerValues.country.text)'.")
                    .padding(.horizontal, 10)
                    .font(.subheadline)
                
                
                NewsListView(articles: articles)
                    .task(id: newsDataVM.fetchPickerValues) {
//                        if currentWeather.sys.country != "" {
//                            await loadTaskByLocation(for: currentWeather.sys.country)
//                        } else {
                            await loadTask()
//                        }
                    }

            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func loadTask() async {
        await newsDataVM.loadNews()
    }
    
//    private func loadTaskByLocation(for countryCode: String) async {
//        await newsDataVM.loadNewsByLocation(for: countryCode)
//    }
    
    private func loadCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async {
        await currentWeatherVM.loadCurrentWeather(latitude: latitude, longitude: longitude)
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
            .environmentObject(LocationManager())
    }
}
