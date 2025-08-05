//
//  TemperatureIndicatorView.swift
//  WeatherKitDemo
//
//  Created by Itsuki on 2025/08/05.
//


import SwiftUI

struct TemperatureIndicatorView: View {
    var low: Double
    var high: Double
    var min: Double
    var max: Double
        
    var body: some View {
        let startingPercent = (low - min) / (max - min)
        let endingPercent = 1 - (max - high) / (max - min)
        
        Capsule()
            .fill(.black.opacity(0.5))
            .frame(height: 4)
            .frame(maxWidth: .infinity)
            .overlay(alignment: .leading, content: {
                GeometryReader { geometry in
                    let size = geometry.size
                    return Capsule()
                        .offset(x: size.width * startingPercent)
                        .fill(LinearGradient(colors: [.yellow, .orange, .red], startPoint: .leading, endPoint: .trailing))
                        .frame(width: size.width * (endingPercent - startingPercent))

                }
                    
            })
    }
}
