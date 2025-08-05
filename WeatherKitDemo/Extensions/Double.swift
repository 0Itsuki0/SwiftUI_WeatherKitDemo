//
//  Double.swift
//  WeatherKitDemo
//
//  Created by Itsuki on 2025/08/05.
//

import SwiftUI
import CoreLocation

extension Double {
    var percentage: String {
        return self.formatted(.percent.precision(.fractionLength(0)))
    }
    
    var formattedDegree: String {
        return "\(self.formatted(.number.precision(.fractionLength(2))))°"
    }
    
    var formattedMeter: String {
        return "\(self.formatted(.number.precision(.fractionLength(2))))m"
    }
}
