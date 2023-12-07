//
//  ViewModelFactory.swift
//  Counter
//
//  Created by Avismara Hugoppalu on 07/12/23.
//

import Foundation

protocol ViewModelFactory {
    func createHomeViewModel(timeRemaining: Int, stopped: Bool) -> any HomeViewModel
}

struct ViewModelFactoryImp: ViewModelFactory {
    func createHomeViewModel(timeRemaining: Int, stopped: Bool) -> any HomeViewModel {
        return HomeViewModelImp(timeRemaining: timeRemaining, stopped: stopped)
    }
}
