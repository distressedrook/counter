//
//  String.swift
//  Counter
//
//  Created by Avismara Hugoppalu on 08/12/23.
//

import Foundation

extension Int {
    var toClockFormat: String {
        let seconds = self / 1000
        let milliseconds = (self % 1000) / 10
        return "\(seconds):\(String(format: "%02d", milliseconds))"
    }
}
