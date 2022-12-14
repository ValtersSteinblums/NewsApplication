//
//  NewsWelcomeView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 14/12/2022.
//

import SwiftUI
import CoreLocationUI

struct NewsWelcomeView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome to the News Application")
                    .bold()
                    .font(.title)
                
                Text("Please share your current location to get the weather in your area")
                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()
            
            
            // LocationButton from CoreLocationUI framework imported above, allows us to requestionLocation
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct NewsWelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewsWelcomeView()
    }
}
