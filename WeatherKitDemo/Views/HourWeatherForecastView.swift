//
//  HourWeatherForecastView.swift
//  WeatherKitDemo
//
//  Created by Itsuki on 2025/08/05.
//


import SwiftUI
import WeatherKit


struct HourWeatherForecastView: View {
    var hourWeatherForecast: Forecast<HourWeather>
    
    var body: some View {

        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "clock")
                Text("hourly forecast".capitalized)
            }
            .font(.subheadline.smallCaps())

            Spacer()
                .frame(height: 16)
            
            ScrollView(.horizontal, content: {
                HStack(spacing: 24) {
                    ForEach(0..<hourWeatherForecast.count, id: \.self) { index in
                        let hourWeather: HourWeather = hourWeatherForecast[index]
                        
                        VStack(spacing: 16) {
                            Text(hourWeather.date.hour)
                            Image(systemName: hourWeather.symbolName)
                            Text(hourWeather.temperature.formattedString)
                        }
                    }
                }
            })
            .scrollIndicators(.hidden)

        }
        .foregroundStyle(.white)
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 16).fill(.gray.opacity(0.8)))

    }
}
