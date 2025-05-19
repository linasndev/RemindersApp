//
//  EditItemScreen.swift
//  RemindersApp
//
//  Created by Linas on 18/05/2025.
//

import SwiftUI
import SwiftData


struct EditItemScreen: View {
  
  @Environment(\.modelContext) private var context
  @Environment(\.dismiss) private var dismiss
  
  @State private var title: String = ""
  @State private var notes: String = ""
  @State private var itemReminderDate: Date? = nil
  @State private var itemReminderTime: Date? = nil
  @State private var isShowReminderDate: Bool = false
  @State private var isShowReminderTime: Bool = false
  
  let item: ItemModel
  
  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextField("Title", text: $title)
          TextField("Notes", text: $notes)
        }
        
        Section {
          HStack {
            Image(systemName: "calendar")
              .foregroundStyle(.red)
              .font(.title2)
            
            Toggle(isOn: $isShowReminderDate.animation(.bouncy)) {
              Text("Reminder Date")
            }
            
            
          }
          
          if isShowReminderDate {
            DatePicker("Selected Date", selection: $itemReminderDate.unwrapped(default: Date()), in: Date.now... ,displayedComponents: .date)
          }
          
          HStack {
            Image(systemName: "clock")
              .foregroundStyle(.red)
              .font(.title2)
            
            Toggle(isOn: $isShowReminderTime.animation(.bouncy)) {
              Text("Reminder Time")
            }
          }
          .onChange(of: isShowReminderTime) { _, newValue in
            if newValue {
              isShowReminderDate = true
            }
          }
          
          if isShowReminderTime {
            DatePicker("Selected Time", selection: $itemReminderTime.unwrapped(default: Date()), displayedComponents: .hourAndMinute)
          }
        }
      }
      .onAppear {
        title = item.title
        notes = item.notes ?? ""
        itemReminderDate = item.itemReminderDate
        itemReminderTime = item.itemReminderTime
        
        isShowReminderDate = item.itemReminderDate != nil
        isShowReminderTime = item.itemReminderDate != nil
      }
      .onChange(of: isShowReminderDate) { _, newValue in
        if !newValue {
          itemReminderDate = nil
        } else {
          itemReminderDate = Date()
        }
      }
      .onChange(of: isShowReminderTime) { _, newValue in
        if !newValue {
          itemReminderTime = nil
        } else {
          itemReminderTime = Date()
        }
      }
      .toolbar(content: {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Save") {
            item.title = title
            item.notes = notes.isEmpty ? nil : notes
            item.itemReminderDate = itemReminderDate
            item.itemReminderTime = itemReminderTime
            
            do {
             try context.save()
            } catch {
              fatalError("Can't update")
            }
            
            dismiss()
          }
          .disabled(title.isEmpty)
        }
        
        ToolbarItem(placement: .topBarLeading) {
          Button("Dismiss") {
            dismiss()
          }
        }
      })
      .navigationTitle("Item Edit")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

//Preview Container
struct ItemEditScreenContainer: View {
  
  @Query(sort: \ItemModel.title) private var items: [ItemModel]
  
  var body: some View {
    EditItemScreen(item: items[0])
    
  }
}

#Preview {
  ItemEditScreenContainer()
    .modelContainer(ReminderModel.preview)
}
