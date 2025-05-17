//
//  PreviewContainer.swift
//  RemindersApp
//
//  Created by Linas on 17/05/2025.
//

import Foundation
import SwiftData

extension MyListModel {
  
  @MainActor
  static var preview: ModelContainer {
    let container = try! ModelContainer(for: MyListModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    let reminders = MyListModel(name: "Reminders", color: "355070")
    container.mainContext.insert(reminders)
    
    let groceries = MyListModel(name: "Groceries", color: "386641")
    container.mainContext.insert(groceries)
    
    let backLog = MyListModel(name: "Backlog", color: "f77f00")
    container.mainContext.insert(backLog)
    
    return container
  }
}
