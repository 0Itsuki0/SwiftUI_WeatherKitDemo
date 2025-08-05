//
//  AdditionalInfoView.swift
//  WeatherKitDemo
//
//  Created by Itsuki on 2025/08/05.
//

import SwiftUI
import WeatherKit

struct AdditionalInfoView: View {
    var currentWeather: CurrentWeather
    var dayWeather: DayWeather?

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "lightbulb.max")
                Text("Additional")
            }
            .font(.subheadline.smallCaps())

            Spacer()
                .frame(height: 16)
            
            HStack {
                Text("UV")
                Spacer()
                Text(String("\(currentWeather.uvIndex.value) (\(currentWeather.uvIndex.category.description))"))
                    .foregroundStyle(.secondary)

            }
            
            Divider()
            
            
            HStack {
                Text("Visibility")
                Spacer()
                Text(currentWeather.visibility.formattedString)
                    .foregroundStyle(.secondary)

            }
            
            
            if let dayWeather = dayWeather, let sunrise = dayWeather.sun.sunrise, let sunset = dayWeather.sun.sunset {
                Divider()
                HStack {
                    let date = Date()
                    if date > sunrise {
                        Text("Sunset")
                        Spacer()
                        Text(sunset.hourMinutes)
                            .foregroundStyle(.secondary)

                    } else {
                        Text("Sunrise")
                        Spacer()
                        Text(sunrise.hourMinutes)
                            .foregroundStyle(.secondary)

                    }

                }
            }
            
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 16).fill(.gray.opacity(0.8)))

    }
}
