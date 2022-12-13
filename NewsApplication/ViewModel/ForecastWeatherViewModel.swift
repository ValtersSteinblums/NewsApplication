//
//  ForecastWeatherViewModel.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import Foundation

enum ForecastDataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}

@MainActor
class ForecastWeatherViewModel: ObservableObject {
    
    @Published var phase = ForecastDataFetchPhase<ForecastWeatherData>.empty
    private let weatherAPI = WeatherAPI.shared
    
    init(forecastWeather: ForecastWeatherData? = nil) {
        if let forecastWeather = forecastWeather {
            self.phase = .success(forecastWeather)
        } else {
            self.phase = .empty
        }
    }
    
    func loadForecastWeather() async {
//        phase = .success(ForecastWeatherData.previewForecastWeatherData)
        
        phase = .empty
        do {
            let forecastWeather = try await weatherAPI.getForcastedWeather()
            phase = .success(forecastWeather)
        } catch {
            phase = .failure(error)
        }
    }
}
