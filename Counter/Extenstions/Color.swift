//
//  Color.swift
//  Counter
//
//  Created by Avismara Hugoppalu on 07/12/23.
//

import SwiftUI

extension Color {
    static let mainColor = Color(hex: "1C437E")
    static let mainSecondaryColor = Color.white
    static let primaryColor = Color.black
    static let secondaryColor = Color(hex: "111111")
    static let bubbleColor = Color(hex: "ffffff", alpha: 0.1)
    static let textPrimaryColor = Color.white

    init(hex: String, alpha: Double = 1) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) { cString.remove(at: cString.startIndex) }

        let scanner = Scanner(string: cString)
        scanner.currentIndex = scanner.string.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        self.init(.sRGB, red: Double(r) / 0xff, green: Double(g) / 0xff, blue:  Double(b) / 0xff, opacity: alpha)
    }
}
