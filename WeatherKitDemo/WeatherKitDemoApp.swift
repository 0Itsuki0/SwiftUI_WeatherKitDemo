//
//  WeatherKitDemoApp.swift
//  WeatherKitDemo
//
//  Created by Itsuki on 2025/08/04.
//

import SwiftUI

@main
struct WeatherKitDemoApp: App {
    private let weatherManager = WeatherManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(weatherManager)
        }
    }
}
