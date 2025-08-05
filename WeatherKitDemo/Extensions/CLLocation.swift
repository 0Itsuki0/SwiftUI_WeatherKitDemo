//
//  CLLocation.swift
//  WeatherKitDemo
//
//  Created by Itsuki on 2025/08/05.
//

import CoreLocation
import SwiftUI

extension CLLocation {
    var formattedString: String {
        return "(\(self.coordinate.latitude.formattedDegree), \(self.coordinate.longitude.formattedDegree))"
    }
}
