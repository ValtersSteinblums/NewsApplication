//
//  WeatherAPI.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import Foundation
import CoreLocation

struct WeatherAPI {
    
    static let shared = WeatherAPI()
    
    private let apiKey = ""
    private let session = URLSession.shared
    private var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> CurrentWeatherData {
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=e04ea9586936265be7e8a6dbdd410773&units=metric")!
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await session.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Bad response") }
        
        let decodedData = try jsonDecoder.decode(CurrentWeatherData.self, from: data)
        return decodedData
    }
    
    func getForcastedWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ForecastWeatherData {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&units=metric&cnt=12&appid=e04ea9586936265be7e8a6dbdd410773")!
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await session.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Bad response") }
        
        let decodedData = try jsonDecoder.decode(ForecastWeatherData.self, from: data)
        return decodedData
    }
    
}
