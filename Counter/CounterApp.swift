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
            ContentView(homeViewModel:  HomeViewModelImp(timeRemaining: 60000, stopped: true))
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in

        }
        return true
    }
}
