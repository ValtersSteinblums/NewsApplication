//
//  WeatherView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    
    //let forecast: ForecastWeatherData
    @StateObject var currentWeatherVM: CurrentWeatherViewModel
    @StateObject var forecastWeatherVM: ForecastWeatherViewModel
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var searchWeather = ""

    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    CurrentWeatherView(currentWeather: currentWeather)
                        .padding(.bottom, 30)
                        .task {
                            if let location = locationManager.location {
                                await loadCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            }
                        }
                    
                    CustomSectionView(view: AnyView(
                        ForecastWeatherHGridView(forecast: forecastWeather)
                            .padding()
                            .task {
                                if let location = locationManager.location {
                                    await loadForecastWeather(latitude: location.latitude, longitude: location.longitude)
                                }
                            }
                            .scrollIndicators(.hidden)
                    ))
                    
                    CustomSectionView(view: AnyView(TommorowsTempView()))
                    
                    CustomSectionView(view: AnyView(SunriseSunsetView(currentWeather: currentWeather)))
                    
                    CustomSectionView(view: AnyView(UvWindHumidityView(currentWeather: currentWeather)))
                    
                    //WeatherFooterView()
                }
                .searchable(text: $searchWeather, placement: .navigationBarDrawer(displayMode: .always))
                .onSubmit(of: .search) {
                    Task {
                        await currentWeatherVM.searchCurrentWeather(for: searchWeather)
                        await forecastWeatherVM.searchForecastWeather(for: searchWeather)
                    }
                }
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
    
    private func loadCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async {
        await currentWeatherVM.loadCurrentWeather(latitude: latitude, longitude: longitude)
    }
    
    private func loadForecastWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async {
        await forecastWeatherVM.loadForecastWeather(latitude: latitude, longitude: longitude)
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
            return forecastWeather
        } else {
            return ForecastWeatherData.previewForecastWeatherData
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(currentWeatherVM: CurrentWeatherViewModel(), forecastWeatherVM: ForecastWeatherViewModel())
            .environmentObject(LocationManager())
    }
}
