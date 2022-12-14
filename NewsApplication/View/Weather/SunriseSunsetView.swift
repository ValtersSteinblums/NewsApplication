//
//  SunriseSunsetView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import SwiftUI

struct SunriseSunsetView: View {
    
    let currentWeather: CurrentWeatherData
    
    var body: some View {
        HStack(spacing: 100) {
            VStack(spacing: 10) {
                Text("Sunrise")
                    .fontWeight(.bold)
                Image(systemName: "sunrise.fill")
                Text(currentWeather.sys.sunrise.formatted(date: .omitted, time: .shortened))
            }
            
            VStack(spacing: 10) {
                Text("Sunset")
                    .fontWeight(.bold)
                Image(systemName: "sunset.fill")
                Text(currentWeather.sys.sunset.formatted(date: .omitted, time: .shortened))
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct SunriseSunsetView_Previews: PreviewProvider {
    static var previews: some View {
        SunriseSunsetView(currentWeather: CurrentWeatherData.previewCurrentWeatherData)
    }
}
