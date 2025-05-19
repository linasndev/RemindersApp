//
//  ReminderCellView.swift
//  RemindersApp
//
//  Created by Linas on 19/05/2025.
//

import SwiftUI
import SwiftData

struct ReminderCellView: View {
  
  let reminder: ReminderModel
  
  var body: some View {
    HStack {
      Image(systemName: "line.3.horizontal.circle.fill")
        .font(.system(.title))
        .foregroundStyle(Color(hex: reminder.color) ?? Color.cyan)
      
      Text(reminder.title)
        .font(.system(.headline, design: .rounded))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
}

//Preview Container
struct RemindersCellViewContainer: View {
  
  //To not get random, need sort.
  @Query private var reminders: [ReminderModel]
  
  var body: some View {
    ReminderCellView(reminder: reminders[0])
  }
}


#Preview {
  RemindersCellViewContainer()
    .modelContainer(ReminderModel.preview)
}
