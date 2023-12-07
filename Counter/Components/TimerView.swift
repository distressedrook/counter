//
//  TimerView.swift
//  Counter
//
//  Created by Avismara Hugoppalu on 07/12/23.
//

import SwiftUI

struct TimerView: View {

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

struct TimerActionView<VM>: View where VM: HomeViewModel{

    @ObservedObject var viewModel: VM

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: { viewModel.toggleCountdown()},
                       label: { Image(systemName: !viewModel.stopped ? "pause" : "arrowtriangle.right.fill").resizable().frame(width: 14, height: 18) })
                .frame(width: 50, height: 50)
                .foregroundColor(Color.mainSecondaryColor)
                .background(Color.mainColor).cornerRadius(25)
                Spacer()
                Button(action: { viewModel.stopTimer() },
                label: { Image(systemName: "stop.fill").resizable().frame(width: 18, height: 18) })
                .disabled(!viewModel.stopButtonEnabled)
                .frame(width: 50, height: 50)
                .foregroundColor(Color.mainSecondaryColor)
                .background(!viewModel.stopButtonEnabled ? Color.mainColor.opacity(0.5) : Color.mainColor)
                .cornerRadius(25)
                .animation(.spring(), value: viewModel.stopButtonEnabled    )

            }.padding(75)
        }
    }
}
