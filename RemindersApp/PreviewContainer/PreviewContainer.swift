//
//  PreviewContainer.swift
//  RemindersApp
//
//  Created by Linas on 17/05/2025.
//

import Foundation
import SwiftData

extension ReminderModel {
  
  @MainActor
  static var preview: ModelContainer {
    let container = try! ModelContainer(for: ReminderModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    let shopping = ReminderModel(title: "Shopping", color: "355070", items: [
      ItemModel(
        itemReminderDate: Date(),
        itemReminderTime: Date(),
        title: "Buy milk",
        notes: "Low-fat if available",
        isCompleted: false
      ),
      ItemModel(
        itemReminderDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()),
        itemReminderTime: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date()),
        title: "Pick up laundry",
        notes: "From downtown store",
        isCompleted: false
      ),
      ItemModel(
        itemReminderDate: Calendar.current.date(byAdding: .day, value: 2, to: Date()),
        itemReminderTime: Calendar.current.date(bySettingHour: 15, minute: 0, second: 0, of: Date()),
        title: "Buy bread",
        notes: "Whole grain preferred",
        isCompleted: false
      )
    ])
    container.mainContext.insert(shopping)
    
    let groceries = ReminderModel(title: "Groceries", color: "386641", items: [
      ItemModel(
        itemReminderDate: Calendar.current.date(byAdding: .day, value: 2, to: Date()),
        itemReminderTime: Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date()),
        title: "Buy vegetables",
        notes: "Carrots, onions, spinach",
        isCompleted: false
      ),
      ItemModel(
        itemReminderDate: Date(),
        itemReminderTime: Date(),
        title: "Get fruits",
        notes: "Apples and bananas",
        isCompleted: false
      ),
      ItemModel(
        itemReminderDate: Calendar.current.date(byAdding: .day, value: 2, to: Date()),
        itemReminderTime: Calendar.current.date(bySettingHour: 11, minute: 15, second: 0, of: Date()),
        title: "Buy eggs",
        notes: "One dozen, free-range",
        isCompleted: false
      )
    ])
    container.mainContext.insert(groceries)
    
    let backLog = ReminderModel(title: "Backlog", color: "f77f00", items: [
      ItemModel(
        itemReminderDate: nil,
        itemReminderTime: nil,
        title: "Finish project proposal",
        notes: "Due by end of the week",
        isCompleted: false
      ),
      ItemModel(
        itemReminderDate: nil,
        itemReminderTime: nil,
        title: "Read SwiftData documentation",
        notes: nil,
        isCompleted: false
      ),
      ItemModel(
        itemReminderDate: nil,
        itemReminderTime: nil,
        title: "Organize files",
        notes: "Group by topic",
        isCompleted: false
      )
    ])
    container.mainContext.insert(backLog)
    
    let work = ReminderModel(title: "Work", color: "0077b6", items: [
      ItemModel(
        itemReminderDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()),
        itemReminderTime: Calendar.current.date(bySettingHour: 14, minute: 0, second: 0, of: Date()),
        title: "Team meeting",
        notes: "Discuss Q2 goals",
        isCompleted: false
      ),
      ItemModel(
        itemReminderDate: Calendar.current.date(byAdding: .day, value: 2, to: Date()),
        itemReminderTime: Calendar.current.date(bySettingHour: 9, minute: 30, second: 0, of: Date()),
        title: "Code review",
        notes: "Review John's PR",
        isCompleted: false
      ),
      ItemModel(
        itemReminderDate: Calendar.current.date(byAdding: .day, value: 3, to: Date()),
        itemReminderTime: Calendar.current.date(bySettingHour: 16, minute: 0, second: 0, of: Date()),
        title: "Submit report",
        notes: "Finance department",
        isCompleted: false
      )
    ])
    container.mainContext.insert(work)
    
    let personal = ReminderModel(title: "Personal", color: "6a4c93", items: [
      ItemModel(
        itemReminderDate: Calendar.current.date(byAdding: .day, value: 4, to: Date()),
        itemReminderTime: Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date()),
        title: "Call Mom",
        notes: "Her birthday",
        isCompleted: false
      ),
      ItemModel(
        itemReminderDate: Calendar.current.date(byAdding: .day, value: 5, to: Date()),
        itemReminderTime: Calendar.current.date(bySettingHour: 8, minute: 30, second: 0, of: Date()),
        title: "Morning run",
        notes: "Try new route in park",
        isCompleted: false
      ),
      ItemModel(
        itemReminderDate: Calendar.current.date(byAdding: .day, value: 6, to: Date()),
        itemReminderTime: Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date()),
        title: "Read book",
        notes: "At least 30 minutes",
        isCompleted: false
      ),
      ItemModel(
        itemReminderDate: Calendar.current.date(byAdding: .day, value: 6, to: Date()),
        itemReminderTime: Calendar.current.date(bySettingHour: 21, minute: 0, second: 0, of: Date()),
        title: "Meditate",
        notes: nil,
        isCompleted: false
      )
    ])
    container.mainContext.insert(personal)
    
    return container
  }
}


