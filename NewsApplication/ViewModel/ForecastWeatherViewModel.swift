//
//  ForecastWeatherViewModel.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import Foundation
import CoreLocation

enum ForecastDataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}

@MainActor
class ForecastWeatherViewModel: ObservableObject {
    
    @Published var phase = ForecastDataFetchPhase<ForecastWeatherData>.empty
    private let weatherAPI = WeatherAPI.shared
    let searchQuerry = CurrentWeatherViewModel()
    
    init(forecastWeather: ForecastWeatherData? = nil) {
        if let forecastWeather = forecastWeather {
            self.phase = .success(forecastWeather)
        } else {
            self.phase = .empty
        }
    }
    
    func searchForecastWeather(for city: String) async {        
        phase = .empty
        
        if city.isEmpty {
            return
        }
        
        do {
            let forecastWeather = try await weatherAPI.searchForecastWeather(for: city)
            phase = .success(forecastWeather)
        } catch {
            phase = .failure(error)
        }
    }
    
    func loadForecastWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async {
//        phase = .success(ForecastWeatherData.previewForecastWeatherData)
        
        phase = .empty
        do {
            let forecastWeather = try await weatherAPI.getForcastedWeather(latitude: latitude, longitude: longitude)
            phase = .success(forecastWeather)
        } catch {
            phase = .failure(error)
        }
    }
}
