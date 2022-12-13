//
//  SimpleWeatherView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import SwiftUI

struct SimpleWeatherView: View {
    
    let currentWeather: CurrentWeatherData
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(spacing: 5) {
                    Text("\(currentWeather.name)")
                        .font(.title3)
                        .fontWeight(.bold)
//                    Image(systemName: "location.circle.fill")
                }
                
                Text("\(currentWeather.weather[0].main) · \(currentWeather.main.humidityInt)%")
                    .font(.caption)
            }
            
            Spacer()
            
            HStack {
                Text("\(currentWeather.main.currentTemp)°C")
                    .font(.title)
                    .fontWeight(.bold)
                
                Image(systemName: "\(currentWeather.weather[0].weatherIcon)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
            }
        }
        //        .padding()
        //        .background(Color.secondary)
        //        .clipShape(RoundedRectangle(cornerRadius: 20))
        //
        //        .overlay(
        //            RoundedRectangle(cornerRadius: 20)
        //                .stroke(.black)
        //        )
        .padding(.horizontal, 10)
    }
}

struct SimpleWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleWeatherView(currentWeather: CurrentWeatherData.previewCurrentWeatherData)
    }
}
