//
//  Date.swift
//  WeatherKitDemo
//
//  Created by Itsuki on 2025/08/05.
//

import SwiftUI

extension Date {
    var hour: String {
        return self.formatted(.dateTime.hour(.twoDigits(amPM: .omitted)))
    }
    
    var weekday: String {
        return self.formatted(.dateTime.weekday(.abbreviated))
    }
    
    var hourMinutes: String {
        return "\(self.hour):\(self.formatted(.dateTime.minute(.twoDigits)))"
    }
}
