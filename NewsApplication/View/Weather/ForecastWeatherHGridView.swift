//
//  ForecastWeatherHGridView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import SwiftUI

struct ForecastWeatherHGridView: View {
    
    let forecast: ForecastWeatherData
    let rows = [ GridItem(.fixed(80)) ]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows) {
                ForEach(forecast.list, id: \.id) { item in
                    VStack(alignment: .center, spacing: 20) {
                        Text(item.dt.formatted(date: .omitted, time: .shortened))
                        Image(systemName: item.weather[0].weatherIcon)
                            .resizable()
                            .frame(width: 70, height: 50)
                        
                        VStack(alignment: .center, spacing: 20) {
                            Text("\(item.main.temp.description)°C")
                            Text("💧\(item.main.humidity.description)%")
                        }
                        .font(.subheadline)
                        .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

struct ForecastWeatherHGridView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastWeatherHGridView(forecast: ForecastWeatherData.previewForecastWeatherData)
    }
}
