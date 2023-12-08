//
//  ControlBox.swift
//  Counter
//
//  Created by Avismara Hugoppalu on 07/12/23.
//

import SwiftUI

struct ControlBox<VM>: View where VM: HomeViewModel {
    private let PauseImageName = "pause"
    private let ArrowTriangleImageName = "arrowtriangle.right.fill"
    private let ButtonDimension: Double = 50
    private let IconDimension: Double = 18

    @ObservedObject var viewModel: VM

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: {
                    viewModel.toggleCountdown()
                }, label: {
                    Image(systemName: !viewModel.stopped ? PauseImageName : ArrowTriangleImageName).frame(width: IconDimension, height: IconDimension)
                })
                .frame(width: ButtonDimension, height: ButtonDimension)
                .foregroundColor(Color.mainSecondaryColor)
                .background(Color.mainColor).cornerRadius(ButtonDimension / 2)

                Spacer()

                Button(action: {
                    viewModel.stopTimer()
                }, label: {
                    Image(systemName: "stop.fill").resizable().frame(width: IconDimension, height: IconDimension)
                })
                .disabled(!viewModel.stopButtonEnabled)
                .frame(width: ButtonDimension, height: ButtonDimension)
                .foregroundColor(Color.mainSecondaryColor)
                .background(!viewModel.stopButtonEnabled ? Color.mainColor.opacity(0.5) : Color.mainColor)
                .cornerRadius(ButtonDimension / 2)
                .animation(.spring(), value: viewModel.stopButtonEnabled)

            }.padding(75)
        }
    }
}
