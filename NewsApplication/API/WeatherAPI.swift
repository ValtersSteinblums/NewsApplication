//
//  WeatherAPI.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import Foundation

struct WeatherAPI {
    
    static let shared = WeatherAPI()
    
    private let apiKey = ""
    private let session = URLSession.shared
    private var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
    
    func getCurrentWeather() async throws -> CurrentWeatherData {
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=57.38944&lon=21.56056&appid=e04ea9586936265be7e8a6dbdd410773&units=metric")!
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await session.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Bad response") }
        
        let decodedData = try jsonDecoder.decode(CurrentWeatherData.self, from: data)
        return decodedData
    }
    
    func getForcastedWeather() async throws -> ForecastWeatherData {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&units=metric&cnt=12&appid=e04ea9586936265be7e8a6dbdd410773")!
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await session.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Bad response") }
        
        let decodedData = try jsonDecoder.decode(ForecastWeatherData.self, from: data)
        return decodedData
    }
    
    // TODO: - finish once setting up coreLocation is done (later..), as for now - hardcoded :)
//    private func generateCurrentWeatherNewsURL() -> URL {
//        var url = "https://api.openweathermap.org/data/2.5/weather?lat=57.38944&lon=21.56056&appid=e04ea9586936265be7e8a6dbdd410773&units=metric"
//
//        return URL(string: url)!
//    }
    
}
