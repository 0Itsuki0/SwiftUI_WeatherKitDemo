//
//  ContentView.swift
//  WeatherKitDemo
//
//  Created by Itsuki on 2025/08/04.
//

import SwiftUI
import WeatherKit

struct ContentView: View {
    @Environment(WeatherManager.self) private var weatherManager

    @State private var showLocationEditSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    if let currentWeather = weatherManager.currentWeather, let hourlyForecast = weatherManager.hourlyForecast, let dailyForecast = weatherManager.dailyForecast {
                        
                        Section {
                            VStack(alignment: .leading) {
                                Text("Location: \(weatherManager.locationString)")
                                if let altitude = weatherManager.altitude {
                                    Text("Altitude: \(altitude.formattedMeter)")
                                }
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)

                            
                            Spacer()
                                .frame(height: 8)
                            
                            WeatherOverview(currentWeather: currentWeather, dayWeather: dailyForecast.first)
                            
                            Spacer()
                                .frame(height: 8)
                            
                            HourWeatherForecastView(hourWeatherForecast: hourlyForecast)
                            
                            DayWeatherForecastView(dayWeatherForecast: dailyForecast)
                            
                            HStack(alignment: .top) {
                                WindView(wind: currentWeather.wind)
                                AdditionalInfoView(currentWeather: currentWeather, dayWeather: dailyForecast.first)
                            }
                            .frame(maxWidth: .infinity)

                        } footer: {
                            if let attribution = weatherManager.attribution {
                                HStack {
                                    AsyncImage(url:attribution.combinedMarkLightURL) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 12)
                                    } placeholder: {}
                                    
                                    Text("[Copy right](\(attribution.legalPageURL))")
                                }
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }

                        }

                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            .scrollIndicators(.hidden)
            .background(.yellow.opacity(0.1))
            .overlay(content: {
                if let _ = weatherManager.error {
                    ContentUnavailableView("Oops!", systemImage: "exclamationmark.circle.fill", description: Text("Something went wrong!"))
                } else if weatherManager.currentWeather == nil || weatherManager.dailyForecast == nil || weatherManager.hourlyForecast == nil {
                    ContentUnavailableView("Unavailable", systemImage: "questionmark.app.fill", description: Text("Weather Information Not Available."))
                }

            })
            .navigationTitle("Weather By Itsuki")
            .navigationBarTitleDisplayMode(.large)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button(action: {
                        self.showLocationEditSheet = true
                    }, label: {
                        Image(systemName: "gearshape")
                    })
                })
            })
            .sheet(isPresented: $showLocationEditSheet, content: {
                LocationEditSheet()
                    .environment(self.weatherManager)
            })
        }
    }
}
