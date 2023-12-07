//
//  ControlBox.swift
//  Counter
//
//  Created by Avismara Hugoppalu on 07/12/23.
//

import SwiftUI

struct ControlBox<VM>: View where VM: HomeViewModel{

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
