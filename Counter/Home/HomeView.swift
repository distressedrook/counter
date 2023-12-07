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
                Clock(progress: $viewModel.progress, displayText: $viewModel.displayText)
                ControlBox(viewModel: viewModel)
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .background {
                self.viewModel.saveState()
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModelImp(timeRemaining: 60000, stopped: false))
    }
}
