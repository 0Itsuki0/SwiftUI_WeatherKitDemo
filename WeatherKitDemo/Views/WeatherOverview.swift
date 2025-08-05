//
//  WeatherOverview.swift
//  WeatherKitDemo
//
//  Created by Itsuki on 2025/08/05.
//

import SwiftUI
import WeatherKit

struct WeatherOverview: View {
    var currentWeather: CurrentWeather
    var dayWeather: DayWeather?

    var body: some View {
        VStack(spacing: 16) {
            Text(currentWeather.temperature.formattedString)
                .font(.system(size: 48))

            VStack(spacing: 4) {
                
                Text(currentWeather.condition.description)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text("Humidity: \(currentWeather.humidity.percentage)")
                
                if let dayWeather {
                    HStack {
                        Text("H:\(dayWeather.highTemperature.formattedString)")
                        Text("L:\(dayWeather.lowTemperature.formattedString)")
                    }
                    .foregroundStyle(.secondary)
                }
                
            }
        }
    }
}
