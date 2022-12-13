//
//  WeatherView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import SwiftUI

struct WeatherView: View {
    
    //let forecast: ForecastWeatherData
    @StateObject var currentWeatherVM: CurrentWeatherViewModel
    @StateObject var forecastWeatherVM: ForecastWeatherViewModel
    
    @State private var searchQuery = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    CurrentWeatherView(currentWeather: currentWeather)
                        .padding(.bottom, 30)
                        .task {
                            await loadCurrentWeather()
                        }
                    
                    CustomSectionView(view: AnyView(
                        ForecastWeatherHGridView(forecast: forecastWeather)
                            .padding()
                            .task {
                                await loadForecastWeather()
                            }
                    ))
                    
                    CustomSectionView(view: AnyView(TommorowsTempView()))
                    
                    CustomSectionView(view: AnyView(SunriseSunsetView()))
                    
                    CustomSectionView(view: AnyView(UvWindHumidityView()))
                    
                    //WeatherFooterView()
                }
                .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always))
            }
        }
    }
    
    @ViewBuilder
    func CustomSectionView(view: AnyView) -> some View {
        Section {
            view
        }
//        .background(.thinMaterial)
//        .background(.blue)
        .background(Color.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black)
        )
        .padding(.horizontal, 10)
    }
    
    private func loadCurrentWeather() async {
        await currentWeatherVM.loadCurrentWeather()
    }
    
    private func loadForecastWeather() async {
        await forecastWeatherVM.loadForecastWeather()
    }
    
    private var currentWeather: CurrentWeatherData {
        if case let .success(currentWeather) = currentWeatherVM.phase {
            return currentWeather
        } else {
            return CurrentWeatherData.previewCurrentWeatherData
        }
    }
    
    private var forecastWeather: ForecastWeatherData {
        if case let .success(forecastWeather) = forecastWeatherVM.phase {
            print(forecastWeather)
            return forecastWeather
        } else {
            return ForecastWeatherData.previewForecastWeatherData
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(currentWeatherVM: CurrentWeatherViewModel(), forecastWeatherVM: ForecastWeatherViewModel())
    }
}
