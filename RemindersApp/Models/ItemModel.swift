//
//  ItemModel.swift
//  RemindersApp
//
//  Created by Linas on 17/05/2025.
//

import Foundation
import SwiftData

@Model
class ItemModel {
  var itemReminderDate: Date?
  var itemReminderTime: Date?
  var title: String
  var notes: String?
  var isCompleted: Bool
  
  var reminders: ReminderModel?
  
  init(itemReminderDate: Date? = nil, itemReminderTime: Date? = nil, title: String, notes: String? = nil, isCompleted: Bool , reminders: ReminderModel? = nil) {
    self.itemReminderDate = itemReminderDate
    self.itemReminderTime = itemReminderTime
    self.title = title
    self.notes = notes
    self.isCompleted = isCompleted
    self.reminders = reminders
  }
}
