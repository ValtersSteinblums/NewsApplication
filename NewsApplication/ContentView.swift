//
//  ContentView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 12/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var realmManager = RealmManager()
    @StateObject var locationManager = LocationManager()
    @StateObject var newsDataVM = NewsDataViewModel()
    @StateObject var currentWeatherVM = CurrentWeatherViewModel()
    
    @State private var selectedTab: Tab = .house
    @State private var isShowingMenu = false
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack {
            if locationManager.location != nil {
                ZStack {
                    VStack {
                        TabView(selection: $selectedTab) {
                            switch selectedTab {
                            case .house:
                                VStack {
                                    NewsHomeView(newsDataVM: newsDataVM, currentWeatherVM: currentWeatherVM)
                                        .environmentObject(realmManager)
                                        .environmentObject(locationManager)
                                }
                            case .heart:
                                NewsFavouritesListView()
                                    .padding(.bottom, 70)
                                    .environmentObject(realmManager)
                            case .magnifyingglass:
                                NewsSearchView()
                                    .environmentObject(realmManager)
                            case .cloud:
                                WeatherView(currentWeatherVM: CurrentWeatherViewModel(), forecastWeatherVM: ForecastWeatherViewModel())
                                    .environmentObject(locationManager)
                            case .gearshape:
                                SettingsView(newsDataVM: newsDataVM)
                            }
                        }
                    }
                    VStack {
                        Spacer()
                        CustomTabBar(selectedTab: $selectedTab)
                    }
                }
            } else {
                NewsWelcomeView()
                    .environmentObject(locationManager)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
