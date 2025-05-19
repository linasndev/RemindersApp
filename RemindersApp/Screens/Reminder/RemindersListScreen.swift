//
//  RemindersListScreen.swift
//  RemindersApp
//
//  Created by Linas on 17/05/2025.
//

import SwiftUI
import SwiftData

enum ReminderScreenSheet: Identifiable {
case newReminder
case editReminder(ReminderModel)
  
  var id: Int {
    switch self {
    case .newReminder:
      return 1
    case .editReminder(let reminder):
      return reminder.hashValue
    }
  }
}

struct RemindersListScreen: View {
  
  @Query private var reminders: [ReminderModel]
  
  @State private var isPresentedNewReminderScreenSheet: Bool = false
  @State private var selectedReminder: ReminderModel?
  @State private var actionSheet: ReminderScreenSheet?
  
  var body: some View {
    NavigationStack {
      List {
        Text("Reminders")
          .font(.system(.largeTitle, design: .rounded, weight: .bold))
        
        Group {
          ForEach(reminders) { reminder in
            NavigationLink(value: reminder) {
              ReminderCellView(reminder: reminder)
                .contentShape(Rectangle())
                .onTapGesture(perform: {
                  selectedReminder = reminder
                })
                .onLongPressGesture(minimumDuration: 0.4) {
                  actionSheet = .editReminder(reminder)
                }
            }
          }
          .listRowSeparator(.visible)
          
          Button {
            actionSheet = .newReminder
          } label: {
            Text("Add Reminder")
              .foregroundStyle(.cyan)
              .frame(maxWidth: .infinity, alignment: .trailing)
          }
        }
        .listRowSeparator(.hidden)
      }
      .listStyle(.plain)
      .popover(item: $actionSheet, content: { actionSheet in
        switch actionSheet {
        case .newReminder:
          NewEditReminderScreen()
            .presentationCompactAdaptation(.sheet)
            .presentationDetents([.medium])
          
        case .editReminder(let reminder):
          NewEditReminderScreen(reminder: reminder)
            .presentationCompactAdaptation(.sheet)
            .presentationDetents([.medium])
        }
      })
      .navigationDestination(item: $selectedReminder) { reminder in
        RemindersDetailScreen(reminder: reminder)
      }
    }
  }
}

#Preview {
  NavigationStack {
    RemindersListScreen()
      .modelContainer(ReminderModel.preview)
  }
}
