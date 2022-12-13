//
//  ForecastWeatherData.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import Foundation

struct ForecastWeatherData: Codable {
    let list: [ForecastList]
    let city: City
    
    struct ForecastList: Codable, Identifiable {
        var id: Date {dt}
        
        let main: MainTemp
        let weather: [Weather]
        let wind: Wind
        
        let dt: Date
    }
    
    struct MainTemp: Codable {
        let temp: Double
//        let feels_like: Double
//        let pressure: Double
        let humidity: Double
    }
    
    struct Weather: Codable {
        let id: Double
        let main: String
        let description: String
        let icon: String
    }
    
    struct Wind: Codable {
        let speed: Double
        let deg: Double
    }
    
    struct City: Codable {
        let coord: Coordinates
        
//        let name: String
//        let country: String
//        let sunrise: Date
//        let sunset: Date
        
        struct Coordinates: Codable {
            let lon: Double
            let lat: Double
        }
    }
}

// computed variables for easier viewing
extension ForecastWeatherData.MainTemp {
    var currentTemp: String {
        return String(temp)
    }
    
//    var feelsLike: Double {
//        return feels_like
//    }
}

extension ForecastWeatherData.Wind {
    var windDirection: String {
            switch deg {
            case 11...79:
                return "NE"
            case 79...124:
                return "E"
            case 125...169:
                return "SE"
            case 170...213:
                return "S"
            case 214...258:
                return "SW"
            case 259...303:
                return "W"
            case 304...348:
                return "NW"
            default:
                return "N"
            }
        }
}

extension ForecastWeatherData.Weather {
    var weatherIcon: String {
        switch id {
        case 0...300 :
            return "wind"
        case 301...500 :
            return "cloud.rain"
        case 501...600 :
            return "cloud.rain.fill"
        case 601...700 :
            return "cloud.snow.fill"
        case 701...771 :
            return "cloud.fog.fill"
        case 772...799 :
            return "cloud.bolt.rain.fill"
        case 800 :
            return "sun.max.fill"
        case 801...804 :
            return "smoke.fill"
        case 900...903, 905...1000  :
            return "cloud.bolt.rain.fill"
        case 903 :
            return "cloud.snow.fill"
        case 904 :
            return "sun.max.fill"
        default:
            return "smoke.fill"
        }
    }
}

// current weather preview
extension ForecastWeatherData {
    static var previewForecastWeatherData: ForecastWeatherData {
        let previewURL = Bundle.main.url(forResource: "forecastWeather", withExtension: "json")!
        let data = try! Data(contentsOf: previewURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        
        let response = (try? jsonDecoder.decode(ForecastWeatherData.self, from: data))!
        return response
    }
}
