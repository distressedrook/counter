//
//  HomeView.swift
//  Counter
//
//  Created by Avismara Hugoppalu on 07/12/23.
//

import Combine
import SwiftUI

struct HomeView<VM>: View where VM: HomeViewModel {
    @ObservedObject var viewModel: VM
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        ZStack {
            Color.primaryColor.edgesIgnoringSafeArea(.all)
            Clock(progress: $viewModel.progress, displayText: $viewModel.displayText)
            ControlBox(viewModel: viewModel)
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .background { self.viewModel.scheduleNotificationIfNeeded() }
        }
    }
}
