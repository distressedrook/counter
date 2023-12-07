//
//  ContentView.swift
//  Counter
//
//  Created by Avismara Hugoppalu on 07/12/23.
//

import SwiftUI

struct ContentView<HVM>: View where HVM : HomeViewModel {
    let homeViewModel: HVM
    var body: some View {
        HomeView(viewModel: homeViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(homeViewModel: HomeViewModelImp(timeRemaining: 60000, stopped: true))
    }
}
