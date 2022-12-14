//
//  CurrentWeatherData.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import Foundation

struct CurrentWeatherData: Codable {
    let coord: Coordinates
    let weather: [Weather]
    let main: MainTemp
    let name: String
    let wind: Wind
    let sys: Sys
    let dt: Date
    
    struct Coordinates: Codable {
        let lon: Double
        let lat: Double
    }
    
    struct Weather: Codable {
        let id: Double
        let main: String
        let description: String
        let icon: String
    }
    
    struct MainTemp: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Double
        let humidity: Double
    }
    
    struct Wind: Codable {
        let speed: Double
        let deg: Double
    }
    
    struct Sys: Codable {
        let country: String
        let sunrise: Date
        let sunset: Date
    }
}


// computed variables for easier viewing
extension CurrentWeatherData.MainTemp {
    
    var feelsLike: Double {
        return feels_like
    }
    
    var tempMin: Double {
        return temp_min
    }
    
    var tempMax: Double {
        return temp_max
    }
    
    var humidityInt: Int {
        return Int(humidity)
    }
}

extension CurrentWeatherData.Wind {
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

extension CurrentWeatherData.Weather {
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
extension CurrentWeatherData {
    static var previewCurrentWeatherData: CurrentWeatherData {
        let previewURL = Bundle.main.url(forResource: "currentWeather", withExtension: "json")!
        let data = try! Data(contentsOf: previewURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        
        let response = (try? jsonDecoder.decode(CurrentWeatherData.self, from: data))!
        return response
    }
}
