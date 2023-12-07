//
//  HomeViewModel.swift
//  Counter
//
//  Created by Avismara Hugoppalu on 07/12/23.
//

import SwiftUI

protocol HomeViewModel: ObservableObject {
    var progress: Double { get set }
    var displayText: String { get set }
    var stopped: Bool { get set }
    var stopButtonEnabled: Bool { get set }

    func stopTimer()
    func toggleCountdown()
    func startTimer()

    func saveState()

}

class HomeViewModelImp: HomeViewModel {

    @Published var progress: Double
    @Published var displayText: String
    @Published var stopped: Bool
    @Published var stopButtonEnabled: Bool

    private let initialTime: Int
    private var timer: Timer?
    private var savedDate: Date?
    private var previousDate: Date?

    var timeRemaining: Int  {
        didSet {
            updateDisplayText()
            updateProgress()
        }
    }

    init(timeRemaining: Int, stopped: Bool) {
        self.timeRemaining = timeRemaining
        self.initialTime = timeRemaining
        let seconds = self.timeRemaining / 1000
        let milliseconds = (self.timeRemaining % 1000) / 10
        self.displayText = "\(seconds):\(String(format: "%02d", milliseconds))"
        self.progress = Double(self.timeRemaining) / Double(self.initialTime) * 100
        self.stopped = stopped
        self.stopButtonEnabled = !stopped
    }


    private func updateDisplayText() {
        let seconds = self.timeRemaining / 1000
        let milliseconds = (self.timeRemaining % 1000) / 10
        self.displayText = "\(seconds):\(String(format: "%02d", milliseconds))"
    }

    private func updateProgress() {
        self.progress = Double(self.timeRemaining) / Double(self.initialTime) * 100
    }
}

extension HomeViewModelImp {
    func saveState() {
        if self.stopped { return }
        let notificationTimeInterval = TimeInterval(Double(self.timeRemaining) / 1000.0)
        let notificationDate = Date.now.addingTimeInterval(notificationTimeInterval)
        scheduleNotification(at: notificationDate)
    }

    private func scheduleNotification(at date: Date) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "Tick"
        content.body = "Your countdown has ended!"

        let timeDifference = date.timeIntervalSinceNow
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeDifference, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully.")
            }
        }
    }
}

extension HomeViewModelImp {

    func toggleCountdown() {
        if self.stopped {
            self.startTimer()
        } else {
            self.pauseTimer()
        }
    }

    func stopTimer() {
        self.stopped = true
        self.stopButtonEnabled = false
        self.timer?.invalidate()
        self.timeRemaining = self.initialTime
        self.previousDate = nil
        self.timer = nil
    }

    func startTimer() {
        self.stopped = false
        self.stopButtonEnabled = true
        self.previousDate = Date.now
        self.timer = Timer(timeInterval: 0.02, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            guard let initialDate = self.previousDate else {
                timer.invalidate()
                self.timer = nil
                return
            }
            let timeInterval = Int(Date.now.timeIntervalSince(initialDate) * 1000)
            timeRemaining = timeRemaining - timeInterval
            if timeRemaining <= 0 {
                timeRemaining = 0
                self.stopTimer()
                timer.invalidate()
                self.timer = nil
                self.stopButtonEnabled = false
            }
            self.previousDate = Date.now
        }
        RunLoop.current.add(self.timer!, forMode: .default)
    }

    func pauseTimer() {
        self.stopped = true
        self.timer?.invalidate()
        self.previousDate = nil
        self.timer = nil
    }
}
