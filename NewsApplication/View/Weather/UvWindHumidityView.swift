//
//  UvWindHumidityView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import SwiftUI

struct UvWindHumidityView: View {
    var body: some View {
        HStack(spacing: 20) {
            
            VStack(spacing: 10) {
                Image(systemName: "sun.min.fill")
                Text("UV index")
                    .fontWeight(.bold)
                Text("Low")
            }
            
            
            
            Rectangle()
                .frame(width: 2, height: 100)
                .foregroundColor(.white)
                .padding(.vertical)
            
            
            
            VStack(spacing: 10) {
                Image(systemName: "wind")
                Text("Wind")
                    .fontWeight(.bold)
                Text("11 km/h")
            }
            
            
            
            Rectangle()
                .frame(width: 2, height: 100)
                .foregroundColor(.white)
                .padding(.vertical)
            
            
            
            VStack(spacing: 10) {
                Image(systemName: "humidity.fill")
                Text("Humidity")
                    .fontWeight(.bold)
                Text("94%")
            }
            
            
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct UvWindHumidityView_Previews: PreviewProvider {
    static var previews: some View {
        UvWindHumidityView()
    }
}
