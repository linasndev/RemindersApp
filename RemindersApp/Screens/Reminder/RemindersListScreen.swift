//
//  RemindersListScreen.swift
//  RemindersApp
//
//  Created by Linas on 17/05/2025.
//

import SwiftUI
import SwiftData

struct RemindersListScreen: View {
  
  @Query private var reminders: [ReminderModel]
  
  @State private var isPresentedNewReminderScreenSheet: Bool = false
  
  var body: some View {
    NavigationStack {
      List {
        Text("Reminders")
          .font(.system(.largeTitle, design: .rounded, weight: .bold))
        
        Group {
          ForEach(reminders) { reminder in
            NavigationLink(value: reminder) {
              HStack {
                Image(systemName: "line.3.horizontal.circle.fill")
                  .font(.system(.title))
                  .foregroundStyle(Color(hex: reminder.color) ?? Color.cyan)
                
                Text(reminder.title)
                  .font(.system(.headline, design: .rounded))
              }
            }
          }
          
          Button {
            isPresentedNewReminderScreenSheet.toggle()
          } label: {
            Text("Add Reminder")
              .foregroundStyle(.cyan)
              .frame(maxWidth: .infinity, alignment: .trailing)
          }
        }
        .listRowSeparator(.hidden)
      }
      .listStyle(.plain)
      .popover(isPresented: $isPresentedNewReminderScreenSheet) {
        NewReminderScreen()
          .presentationCompactAdaptation(.sheet)
          .presentationDetents([.medium])
      }
      .navigationDestination(for: ReminderModel.self) { reminder in
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
