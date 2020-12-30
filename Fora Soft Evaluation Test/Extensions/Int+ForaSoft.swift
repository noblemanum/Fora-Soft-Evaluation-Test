//
//  Int+ForaSoft.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 29.12.2020.
//

import Foundation

extension Int {
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second, .nanosecond]
        formatter.unitsStyle = style
        formatter.zeroFormattingBehavior = .pad
        guard let formattedString = formatter.string(from: Double(self / 1000)) else { return "" }
        return formattedString
    }
}
