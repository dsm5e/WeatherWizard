//
//  WelcomeView.swift
//  WeatherWizard
//
//  Created by dsm 5e on 03.08.2023.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome to the Weather App")
                    .font(.title.bold())
                Text("Please share your current location to get the weather in your area")
                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareMyCurrentLocation) {
                locationManager.requestLocation()
            }
            .clipShape(.rect(cornerRadius: 30))
            .symbolVariant(.fill)
            .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    WelcomeView()
}
