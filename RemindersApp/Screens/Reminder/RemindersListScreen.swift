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

enum ItemsStatsType: Int, Identifiable {
  case today
  case scheduled
  case all
  case completed
  
  var id: Int {
    self.rawValue
  }
  
  var title: String {
    switch self {
    case .today:
      "Today"
    case .scheduled:
      "Scheduled"
    case .all:
      "All"
    case .completed:
      "Completed"
    }
  }
}

struct RemindersListScreen: View {
  
  @Query private var reminders: [ReminderModel]
  @Query private var items: [ItemModel]
  
  @State private var isPresentedNewReminderScreenSheet: Bool = false
  @State private var selectedReminder: ReminderModel?
  @State private var actionSheet: ReminderScreenSheet?
  @State private var selectedItemsStatsType: ItemsStatsType?
  
  var body: some View {
    NavigationStack {
      VStack {
        
        VStack {
          HStack {
            ItemsStatsView(icon: "calendar", title: "Today", count: todaysItems.count)
              .onTapGesture {
                selectedItemsStatsType = .today
              }
            
            ItemsStatsView(icon: "calendar.circle.fill", title: "Scheduled", count: scheduledItems.count)
              .onTapGesture {
                selectedItemsStatsType = .scheduled
              }
          }
          
          HStack {
            ItemsStatsView(icon: "tray.circle.fill", title: "All", count: items.count)
              .onTapGesture {
                selectedItemsStatsType = .all
              }
            
            ItemsStatsView(icon: "checkmark.circle.fill", title: "Completed", count: completedItems.count)
              .onTapGesture {
                selectedItemsStatsType = .completed
              }
          }
        }
        .padding()
        
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
        .navigationDestination(item: $selectedItemsStatsType) { itemsStatsType in
          NavigationStack {
            List {
              ForEach(showItems(for: itemsStatsType)) { item in
                Text(item.title)
              }
            }
            .navigationTitle(itemsStatsType.title)
            .navigationBarTitleDisplayMode(.large)
          }
        }
      }
    }
  }
  
  private var todaysItems: [ItemModel] {
    items.filter {
      guard let itemReminderDate = $0.itemReminderDate else { return false }
      return itemReminderDate.isToday && !$0.isCompleted
    }
  }
  
  private var scheduledItems: [ItemModel] {
    items.filter { $0.itemReminderDate != nil && !$0.isCompleted }
  }
  
  private var completedItems: [ItemModel] {
    items.filter { $0.isCompleted }
  }
  
  private func showItems(for type: ItemsStatsType) -> [ItemModel] {
    switch type {
    case .today:
      return todaysItems
    case .scheduled:
      return scheduledItems
    case .all:
      return items
    case .completed:
      return completedItems
    }
  }
}

#Preview {
  NavigationStack {
    RemindersListScreen()
      .modelContainer(ReminderModel.preview)
  }
}
