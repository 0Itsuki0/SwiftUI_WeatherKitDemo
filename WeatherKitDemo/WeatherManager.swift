//
//  WeatherManager.swift
//  WeatherKitDemo
//
//  Created by Itsuki on 2025/08/04.
//

import SwiftUI
import WeatherKit
import CoreLocation

@Observable
class WeatherManager {
    private let service = WeatherService.shared

    // location
    var latitude: CLLocationDegrees = .zero
    var longitude: CLLocationDegrees = .zero
    var altitude: CLLocationDistance? = nil
    
    var locationString: String {
        return self.makeLocation().formattedString
    }

    var currentWeather: CurrentWeather? = nil
    var hourlyForecast: Forecast<HourWeather>? = nil
    var dailyForecast: Forecast<DayWeather>? = nil
    
    // Attribution is required for publishing software using WeatherKit
    var attribution: WeatherAttribution? = nil
    
    var error: (any Error)? = nil {
        didSet {
            guard let error = self.error else { return }
            print(error)
        }
    }
    
    // keep a reference to timer so that we can invalidate it when location changed
    private var currentWeatherTimer: Timer? = nil
    private var hourlyForecastTimer: Timer? = nil
    private var dailyForecastTimer: Timer? = nil

    private enum QueryType {
        case current
        case daily
        case hourly
    }
    
    init() {
        Task {
            do {
                self.attribution = try await service.attribution
            } catch(let error) {
                self.error = error
            }
        }
        self.refreshWeather()
    }
    
    deinit {
        self.invalidTimers()
    }
    
    func refreshWeather() {
        print(#function)
        self.error = nil
        self.invalidTimers()
        
        self.getCurrent()
        self.getDaily()
        self.getHourly()
    }
    
    // to disable auto updates
    private func invalidTimers() {
        self.currentWeatherTimer?.invalidate()
        self.hourlyForecastTimer?.invalidate()
        self.dailyForecastTimer?.invalidate()
        
        self.currentWeatherTimer = nil
        self.hourlyForecastTimer = nil
        self.dailyForecastTimer = nil

    }
    
    
    // Handle individually because Each type of weather data contains a different expirationDate: The time the weather data expires.
    @objc private func getCurrent() {
        print(#function)
        
        Task {
            do {
                let location: CLLocation = self.makeLocation()
                // daily: 10 contiguous days, beginning with the current day.
                // - to get weather for an arbitrary range of days, use daily(startDate:endDate:) instead.
                let weather = try await service.weather(
                    for: location,
                    including: .current)
                self.currentWeather = weather
                self.scheduleTask(weather.metadata.expirationDate, for: .current)
            } catch (let error) {
                self.error = error
            }
        }
    }
    
    
    // hourly: 25 contiguous hours, beginning with the current hour..
    // - to get weather for an arbitrary range of hours, use hourly(startDate:endDate:) instead.
    @objc private func getHourly() {
        print(#function)
        
        Task {
            do {
                let location: CLLocation = self.makeLocation()
                let weather = try await service.weather(
                    for: location,
                    including: .hourly)
                self.hourlyForecast = weather
                self.scheduleTask(weather.metadata.expirationDate, for: .hourly)
            } catch (let error) {
                self.error = error
            }
        }
    }
    
    
    // daily: 10 contiguous days, beginning with the current day.
    // - to get weather for an arbitrary range of days, use daily(startDate:endDate:) instead.
    @objc private func getDaily() {
        print(#function)
        
        Task {
            do {
                let location: CLLocation = self.makeLocation()
                let weather = try await service.weather(
                    for: location,
                    including: .daily)
                self.dailyForecast = weather
                self.scheduleTask(weather.metadata.expirationDate, for: .daily)
            } catch (let error) {
                self.error = error
            }
        }

    }

    
    private func scheduleTask(_ date: Date, for type: QueryType) {
        print(#function)
        print(date, type)
        let selector: Selector = switch type {
        case .current:
            #selector(getCurrent)
        case .daily:
            #selector(getDaily)
        case .hourly:
            #selector(getHourly)
        }
        
        let timer = Timer(fireAt: date, interval: 0, target: self, selector: selector, userInfo: nil, repeats: false)
        
        switch type {
        case .current:
            self.currentWeatherTimer?.invalidate()
            self.currentWeatherTimer = timer
        case .daily:
            self.dailyForecastTimer?.invalidate()
            self.dailyForecastTimer = timer
        case .hourly:
            self.hourlyForecastTimer?.invalidate()
            self.hourlyForecastTimer = timer
        }
        
        RunLoop.main.add(timer, forMode: .common)
    }

    
    private func makeLocation() -> CLLocation {
        let location: CLLocation = .init(
            coordinate: .init(latitude: latitude, longitude: longitude),
            altitude: altitude ?? 0,
            horizontalAccuracy: 0,
            verticalAccuracy: altitude == nil ? -1 : 0, //  -1 to indicate that the altitude is invalid in the case of nil
            timestamp: Date()
        )

        return location
    }
}
