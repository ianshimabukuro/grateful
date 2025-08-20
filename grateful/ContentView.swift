//
//  ContentView.swift
//  grateful
//
//  Created by Ian Shimabukuro on 8/11/25.
//

import SwiftUI
import SwiftData
import UserNotifications

struct ContentView: View {
    
    private func requestNotificationPermissionAndSchedule() async {
        let center = UNUserNotificationCenter.current()
        do {
            let granted = try await center.requestAuthorization(options: [.alert, .sound, .badge])
            guard granted else { return }
            
            let content = UNMutableNotificationContent()
            content.title = "Daily Check-in"
            content.body = "It's time to be grateful!"
            content.sound = .default

            var dateComponents = DateComponents()
            dateComponents.hour = 21
            dateComponents.minute = 0

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

            let request = UNNotificationRequest(identifier: "daily-9am", content: content, trigger: trigger)
            try await center.add(request)
        } catch {
            print("Notification setup error: \(error)")
        }
    }
    
    var body: some View {
        NavigationStack{
            MainView()
        }
        .task { await requestNotificationPermissionAndSchedule() }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
