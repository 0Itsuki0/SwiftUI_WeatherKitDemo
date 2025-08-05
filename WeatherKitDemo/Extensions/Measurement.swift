//
//  Measurement.swift
//  WeatherKitDemo
//
//  Created by Itsuki on 2025/08/05.
//

import SwiftUI

extension Measurement where UnitType: Dimension {
    var formattedString: String {
        return self.formatted(.measurement(width: .narrow, numberFormatStyle: .number.precision(.fractionLength(0))))
    }
}
