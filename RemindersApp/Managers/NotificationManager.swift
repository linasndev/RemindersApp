//
//  NotificationManager.swift
//  RemindersApp
//
//  Created by Linas on 20/05/2025.
//

import Foundation
import NotificationCenter

struct UserData {
  let title: String?
  let body: String?
  let date: Date?
  let time: Date?
}

struct NotificationManager {
  static func scheduleNotification(userdata: UserData) {
    
    var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: userdata.date ?? Date())
    
    if let itemTime = userdata.time {
      let itemTimeDateComponents = itemTime.dateComponents
      dateComponents.hour = itemTimeDateComponents.hour
      dateComponents.minute = itemTimeDateComponents.minute
    }
    
    let content = UNMutableNotificationContent()
    content.title = userdata.title ?? "Title"
    content.body = userdata.body ?? "Body"
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    let request = UNNotificationRequest(identifier: "Reminder Notification", content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request)
    
  }
}
