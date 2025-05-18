//
//  RemindersDetailView.swift
//  RemindersApp
//
//  Created by Linas on 18/05/2025.
//

import SwiftUI
import SwiftData

struct RemindersDetailScreen: View {
  
  let reminder: ReminderModel
  
  var body: some View {
    VStack {
      if let items = reminder.items {
        List {
          ForEach(items) { item in
            Text(item.title)
          }
        }
      }
    }
    .navigationTitle(reminder.title)
  }
}

//Preview Container
struct RemindersDetailScreenContainer: View {
  
  //To not get random, need sort.
  @Query private var reminders: [ReminderModel]
  
  var body: some View {
    RemindersDetailScreen(reminder: reminders[0])
  }
}

#Preview {
  NavigationStack {
    RemindersDetailScreenContainer()
      .modelContainer(ReminderModel.preview)
  }
}
