//
//  ContentView.swift
//  WeatherWizard
//
//  Created by dsm 5e on 03.08.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack(spacing: 30) {
            
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                               weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longtitude: location.longitude)
                            } catch {
                                
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .fontDesign(.monospaced)
        .background(LinearGradient(colors: [.purple, .indigo], startPoint: .bottomLeading, endPoint: .topLeading))
        .preferredColorScheme(.dark)
    }
    
}

#Preview {
    ContentView()
}
