//
//  CurrentWeatherViewModel.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import Foundation
import CoreLocation

enum WeatherDataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}

@MainActor
class CurrentWeatherViewModel: ObservableObject {
    
    @Published var phase = WeatherDataFetchPhase<CurrentWeatherData>.empty
    private let weatherAPI = WeatherAPI.shared
    
    init(currentWeather: CurrentWeatherData? = nil) {
        if let currentWeather = currentWeather {
            self.phase = .success(currentWeather)
        } else {
            self.phase = .empty
        }
    }
    
    func loadCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async {
//        phase = .success(CurrentWeatherData.previewCurrentWeatherData)
        
        phase = .empty
        do {
            let currentWeather = try await weatherAPI.getCurrentWeather(latitude: latitude, longitude: longitude)
            phase = .success(currentWeather)
        } catch {
            phase = .failure(error)
        }
    }
}
