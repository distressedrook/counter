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

    func scheduleNotificationIfNeeded()
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

    var timeRemaining: Int {
        didSet {
            updateDisplayText()
            updateProgress()
        }
    }

    init(timeRemaining: Int, stopped: Bool) {
        self.timeRemaining = timeRemaining
        initialTime = timeRemaining
        displayText = timeRemaining.toClockFormat
        progress = Double(self.timeRemaining) / Double(initialTime) * 100
        self.stopped = stopped
        stopButtonEnabled = !stopped
    }

    private func updateDisplayText() {
        displayText = timeRemaining.toClockFormat
    }

    private func updateProgress() {
        progress = Double(timeRemaining) / Double(initialTime) * 100
    }
}

extension HomeViewModelImp {
    func scheduleNotificationIfNeeded() {
        if stopped { return }
        let notificationTimeInterval = TimeInterval(Double(timeRemaining) / 1000.0)
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
        if stopped {
            startTimer()
        } else {
            pauseTimer()
        }
    }

    func stopTimer() {
        stopped = true
        stopButtonEnabled = false
        timer?.invalidate()
        timeRemaining = initialTime
        previousDate = nil
        timer = nil
    }

    func startTimer() {
        stopped = false
        stopButtonEnabled = true
        previousDate = Date.now
        /*
         It would be unreliable to rely on the Timer (for example timerInterval: 0.001) for updates.
         Instead, we save the previous date, and on the next timer pass which happens every 0.02s or so,
         we get the current time, calculate the time difference, and subtract from time remaining. This logic
         also allows us to be app state agnostic.
         */
        timer = Timer(timeInterval: 0.02, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            guard let initialDate = self.previousDate else {
                self.stopTimer()
                return
            }
            let timeElapsed = Int(Date.now.timeIntervalSince(initialDate) * 1000)
            timeRemaining = timeRemaining - timeElapsed
            if timeRemaining <= 0 {
                timeRemaining = 0
                self.stopTimer()
                self.stopButtonEnabled = false
            }
            self.previousDate = Date.now
        }
        RunLoop.current.add(timer!, forMode: .default)
    }

    func pauseTimer() {
        stopped = true
        timer?.invalidate()
        previousDate = nil
        timer = nil
    }
}
