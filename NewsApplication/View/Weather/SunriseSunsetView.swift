//
//  SunriseSunsetView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import SwiftUI

struct SunriseSunsetView: View {
    var body: some View {
        HStack(spacing: 100) {
            VStack(spacing: 10) {
                Text("Sunrise")
                    .fontWeight(.bold)
                Image(systemName: "sunrise.fill")
                Text("12:00")
            }
            
            VStack(spacing: 10) {
                Text("Sunset")
                    .fontWeight(.bold)
                Image(systemName: "sunset.fill")
                Text("12:00")
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct SunriseSunsetView_Previews: PreviewProvider {
    static var previews: some View {
        SunriseSunsetView()
    }
}
