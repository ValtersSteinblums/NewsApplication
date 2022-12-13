//
//  CurrentWeatherView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import SwiftUI

struct CurrentWeatherView: View {
    
    let currentWeather: CurrentWeatherData
    
    var body: some View {
        VStack(alignment: .leading) {
                HStack {
                    VStack {
                        Text("\(currentWeather.main.currentTemp)°")
                            .fontWeight(.bold)
                            .font(.system(size: 60))
                    }
                    
                    Spacer()
                    
                    Image(systemName: currentWeather.weather[0].weatherIcon)
                        .resizable()
                    .frame(width: 150, height: 100)
                }
                
            
            Text("\(currentWeather.name), \(currentWeather.sys.country) ")
                .fontWeight(.bold)
                .font(.system(size: 30))
                .padding(.bottom, 20)
            
            
            VStack {
                VStack(alignment: .leading) {
                    Text("\(currentWeather.main.tempMax.description)° / \(currentWeather.main.tempMin.description)° Feels like \(currentWeather.main.feelsLike.description)°")
                    Text(currentWeather.dt.formatted(date: .abbreviated, time: .shortened))
                }
                .fontWeight(.bold)
                .font(.system(size: 15))
            }
        }
        .padding(.horizontal, 10)
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(currentWeather: CurrentWeatherData.previewCurrentWeatherData)
    }
}
