//
//  NewEditReminderScreen.swift
//  RemindersApp
//
//  Created by Linas on 17/05/2025.
//

import SwiftUI
import SwiftData

struct NewEditReminderScreen: View {
  
  @Environment(\.modelContext) private var context
  @Environment(\.dismiss) private var dismiss
  
  @State private var title: String = ""
  @State private var selectedColor: String = "0077b6"
  
  var reminder: ReminderModel? = nil
  
  var body: some View {
    NavigationStack {
      VStack {
        Image(systemName: "line.3.horizontal.circle.fill")
          .font(.system(size: 80))
          .foregroundStyle(Color(hex: selectedColor) ?? Color.black)
          .animation(.easeInOut, value: selectedColor)
        
        TextField("Reminder Name", text: $title)
          .textFieldStyle(.roundedBorder)
          .padding(.horizontal, 44)
        
        ColorPickerView(selectedColor: $selectedColor)
      }
      .onAppear(perform: {
        if let reminder {
          title = reminder.title
          selectedColor = reminder.color
        }
      })
      .navigationTitle(reminder != nil ? "Edit Reminder" : "New Reminder")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button("Dismiss") {
            dismiss()
          }
        }
        
        ToolbarItem(placement: .topBarTrailing) {
          Button(reminder != nil ? "Update" : "Save") {
            if let reminder {
              reminder.title = title
              reminder.color = selectedColor
              
              do {
                try context.save()
                dismiss()
              } catch {
                fatalError("❌ Can't update reminder")
              }
              
            } else {
              let newMyList = ReminderModel(title: title, color: selectedColor)
              context.insert(newMyList)
              
              do {
                try context.save()
                dismiss()
              } catch {
                fatalError("❌ Can't save new reminder")
              }
            }
          }
          .disabled(title.isEmpty)
        }
      }
    }
  }
}

#Preview {
  NewEditReminderScreen()
}
