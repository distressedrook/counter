//
//  CounterApp.swift
//  Counter
//
//  Created by Avismara Hugoppalu on 07/12/23.
//

import SwiftUI

@main
struct CounterApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            /*
             This is the most basic form of DI. You can avoid the "constructor hell" by using DI frameworks. If you want to
             create a mock for your tests, you can create a HomeViewModelMock that implements HomeViewModel and inject into it.
             */
            ContentView(homeViewModel: HomeViewModelImp(timeRemaining: 60000, stopped: true))
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in
        }
        return true
    }
}
