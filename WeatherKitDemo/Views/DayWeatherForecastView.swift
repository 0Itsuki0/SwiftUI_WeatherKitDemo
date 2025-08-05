//
//  DayWeatherForecastView.swift
//  WeatherKitDemo
//
//  Created by Itsuki on 2025/08/05.
//

import SwiftUI
import WeatherKit


struct DayWeatherForecastView: View {
    var dayWeatherForecast: Forecast<DayWeather>
    
    var body: some View {
        let min: Double? = dayWeatherForecast.map(\.lowTemperature.value).min()
        let max: Double? = dayWeatherForecast.map(\.highTemperature.value).max()
       
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "calendar")
                Text("10-day forecast".capitalized)
            }
            .font(.subheadline)
        

            ForEach(0..<dayWeatherForecast.count, id: \.self) { index in
                let dayWeather: DayWeather = dayWeatherForecast[index]
                
                Divider()
                
                HStack(spacing: 24) {
                    Text(dayWeather.date.weekday)
                    
                    VStack {
                        Image(systemName: dayWeather.symbolName)
                        if dayWeather.precipitationChance > 0 {
                            Text(dayWeather.precipitationChance.percentage)
                                .foregroundStyle(.blue)
                        }
                    }
                    
                    HStack {
                        Text("\(dayWeather.lowTemperature.formattedString)")
                            .foregroundStyle(.secondary)

                        TemperatureIndicatorView(low: dayWeather.lowTemperature.value, high: dayWeather.highTemperature.value, min: min ?? dayWeather.lowTemperature.value, max: max ?? dayWeather.highTemperature.value)
                        
                        Text("\(dayWeather.highTemperature.formattedString)")

                    }

                }
            }
        }

        .foregroundStyle(.white)
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 16).fill(.gray.opacity(0.8)))
    }
}
