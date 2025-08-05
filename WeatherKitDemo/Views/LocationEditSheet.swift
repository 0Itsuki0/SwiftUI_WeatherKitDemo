//
//  LocationEditSheet.swift
//  WeatherKitDemo
//
//  Created by Itsuki on 2025/08/05.
//

import SwiftUI

struct LocationEditSheet: View {
    @Environment(WeatherManager.self) private var weatherManager
    @Environment(\.dismiss) private var dismiss
    
    @State private var altitude: Double = 0
    @State private var enableAltitude: Bool = false
    
    @State private var error: String? = nil
    
    var body: some View {
        NavigationStack {
            @Bindable var weatherManager = self.weatherManager
            Form {
                if let error = self.error {
                    Text(error)
                        .foregroundStyle(.red)
                }
                
                Section {
                    HStack {
                        Text("Latitude(deg)")

                        Spacer()
                        TextField("", value: $weatherManager.latitude, format: .number)
                            .multilineTextAlignment(.trailing)
                            .foregroundStyle(.secondary)

                    }
                    .listRowInsets(.horizontal, 24)

                    HStack {
                        Text("Longitude(Deg)")
                        Spacer()
                        TextField("", value: $weatherManager.longitude, format: .number)
                            .multilineTextAlignment(.trailing)
                            .foregroundStyle(.secondary)

                    }
                    .listRowInsets(.horizontal, 24)
                }
                
                Section("Altitude(m)") {
                    HStack {
                        Text("Use Altitude")
                        Spacer()
                        Toggle(isOn: $enableAltitude, label: {})
                            .labelsHidden()
                    }
                    .listRowInsets(.horizontal, 24)
                  
                    if enableAltitude {
                        HStack {
                            Text("Altitude")
                            Spacer()
                            TextField("", value: $altitude, format: .number)
                                .multilineTextAlignment(.trailing)
                                .foregroundStyle(.secondary)

                        }
                        .listRowInsets(.horizontal, 24)
                    }
                }
                .onAppear {
                    if let altitude = weatherManager.altitude {
                        self.enableAltitude = true
                        self.altitude = altitude
                    } else {
                        self.enableAltitude = false
                        self.altitude = 0
                    }
                }
                .onChange(of: self.enableAltitude, {
                    weatherManager.altitude = enableAltitude ? self.altitude : nil
                })
                .onChange(of: self.altitude, {
                    guard self.enableAltitude else { return }
                    weatherManager.altitude = self.altitude
                })
                               
            }
            .keyboardType(.numbersAndPunctuation)
            .navigationTitle("Edit Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading, content: {
                    Button(role: .destructive, action: {
                        self.dismiss()
                    }, label: {
                        Text("Cancel")
                            .foregroundStyle(.red)
                    })
                })
                
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button(action: {
                        var messages: [String] = []
                        if !(-90...90).contains(weatherManager.latitude) {
                            messages.append("Latitude should be within -90 to 90.")
                        }
                        
                        if !(-180...180).contains(weatherManager.longitude) {
                            messages.append("Longitude should be within -180 to 180.")
                        }
                        
                        if !messages.isEmpty {
                            self.error = messages.joined(separator: "\n")
                            return
                        }
                    
                        weatherManager.refreshWeather()
                        self.dismiss()
                        
                    }, label: {
                        Text("Confirm")
                            .foregroundStyle(.blue)
                            .fontWeight(.semibold)
                    })
                })
            })
            
        }
    }
}
