//
//  ReminderModel.swift
//  RemindersApp
//
//  Created by Linas on 17/05/2025.
//

import Foundation
import SwiftData

@Model
class ReminderModel {
  @Attribute(originalName: "name") var title: String = ""
  var color: String
  
  @Relationship(deleteRule: .cascade, inverse: \ItemModel.reminders) var items: [ItemModel]?
  
  init(title: String, color: String, items: [ItemModel]? = nil) {
    self.title = title
    self.color = color
    self.items = items
  }
}
