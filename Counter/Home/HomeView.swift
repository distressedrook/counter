//
//  HomeView.swift
//  Counter
//
//  Created by Avismara Hugoppalu on 07/12/23.
//

import SwiftUI
import Combine

struct HomeView<VM>: View where VM: HomeViewModel {

    init(viewModel: VM) {
        self.viewModel = viewModel
    }

    @Environment(\.scenePhase) var scenePhase

    let appWidth = UIScreen.main.bounds.width
    let appHeight = UIScreen.main.bounds.height
    var subscriberStore = Set<AnyCancellable>()

    @ObservedObject var viewModel: VM

    var body: some View {
        ZStack {
            Color.primaryColor.edgesIgnoringSafeArea(.all)
            Group {
                TimerView(progress: $viewModel.progress, displayText: $viewModel.displayText)
                TimerActionView(viewModel: viewModel)
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .background {
                self.viewModel.saveState()
            }
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModelImp(timeRemaining: 60000, stopped: false))
    }
}
