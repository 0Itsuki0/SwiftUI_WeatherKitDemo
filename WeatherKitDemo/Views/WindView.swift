//
//  WindView.swift
//  WeatherKitDemo
//
//  Created by Itsuki on 2025/08/05.
//

import SwiftUI
import WeatherKit

struct WindView: View {
    var wind: Wind

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "wind")
                Text("Wind")
            }
            .font(.subheadline.smallCaps())

            Spacer()
                .frame(height: 16)

            
            HStack {
                Text("Wind")
                Spacer()
                Text(wind.speed.formattedString)
                    .foregroundStyle(.secondary)

            }
            
            Divider()
            
            if let gust = wind.gust {
                HStack {
                    Text("Gusts")
                    Spacer()
                    Text(gust.formattedString)
                        .foregroundStyle(.secondary)
                }
                
                Divider()

            }
            
            HStack {
                Text("Direction")
                Spacer()
                Text(wind.direction.formattedString)
                    .foregroundStyle(.secondary)

            }
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 16).fill(.gray.opacity(0.8)))
    }
}
