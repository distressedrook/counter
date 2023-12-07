//
//  Clock.swift
//  Counter
//
//  Created by Avismara Hugoppalu on 07/12/23.
//

import SwiftUI

struct Clock: View {

    @Binding var progress: Double
    @Binding var displayText: String
    let gradientColors = [Color(hex: "C71FD6"), Color(hex: "DC8219"), Color(hex: "172EAA"), Color(hex: "E93D3D")]

    var body: some View {
        ZStack {
            BubbleView(size: 270, x: 0, y: 0)
            Circle().foregroundColor(Color.mainColor).frame(width: 200, height: 200)
            Text(displayText)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(Color.mainSecondaryColor)
            Circle()
                .trim(from: 0, to: CGFloat(progress) / 100)
                .stroke(style: StrokeStyle(lineWidth: 10))
                .fill(LinearGradient(gradient: .init(colors: gradientColors),
                                     startPoint: .topLeading, endPoint: .trailing))
                .animation(.spring(), value: progress).frame(width: 325, height: 325)
        }
    }
}

struct BubbleView: View {
    let size: CGFloat, x: CGFloat, y: CGFloat
    var body: some View {
        ZStack {
            Circle().foregroundColor(.bubbleColor)
                .frame(width: size, height: size).offset(x: x, y: y)
        }
    }
}
