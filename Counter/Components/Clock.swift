//
//  Clock.swift
//  Counter
//
//  Created by Avismara Hugoppalu on 07/12/23.
//

import SwiftUI

struct Clock: View {
    private let BubbleSize: Double = 270
    private let InnerCircleSize: Double = 200
    private let ProgressCircleSize: Double = 325

    @Binding var progress: Double
    @Binding var displayText: String
    let gradientColors = [Color(hex: "C71FD2"), Color(hex: "DC8269"), Color(hex: "172E3A"), Color(hex: "E93D7D")]

    var body: some View {
        ZStack {
            Circle().foregroundColor(.bubbleColor)
                .frame(width: BubbleSize, height: BubbleSize).offset(x: 0, y: 0)

            Circle().foregroundColor(Color.mainColor).frame(width: InnerCircleSize, height: InnerCircleSize)

            Text(displayText)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(Color.mainSecondaryColor)

            Circle()
                .trim(from: 0, to: CGFloat(progress) / 100)
                .stroke(style: StrokeStyle(lineWidth: 10))
                .fill(LinearGradient(gradient: .init(colors: gradientColors),
                                     startPoint: .topLeading, endPoint: .trailing))
                .animation(.spring(), value: progress)
                .frame(width: ProgressCircleSize, height: ProgressCircleSize)
        }
    }
}
