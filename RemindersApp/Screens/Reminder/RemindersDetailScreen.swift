//
//  RemindersDetailView.swift
//  RemindersApp
//
//  Created by Linas on 18/05/2025.
//

import SwiftUI
import SwiftData

struct RemindersDetailScreen: View {
  
  @State private var title: String = ""
  @State private var isPresentedNewItemAlertSheet: Bool = false
  
  let reminder: ReminderModel
  
  var body: some View {
    VStack {
      if let items = reminder.items {
        List {
          ForEach(items) { item in
            Text(item.title)
          }
        }
        .listStyle(.plain)
        
        Spacer()
        
        Button {
          withAnimation(.easeInOut) {
            isPresentedNewItemAlertSheet.toggle()
          }
        } label: {
          HStack {
            Image(systemName: "plus.circle.fill")
            Text("New Reminder")
          }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding()
      }
    }
    .navigationTitle(reminder.title)
    .ignoresSafeArea(.keyboard, edges: .bottom)
    .alert("New Item", isPresented: $isPresentedNewItemAlertSheet) {
      TextField("Item Title", text: $title)
      Button("Cancel", role: .cancel, action: {})
      Button("Save") {
        saveItem()
        title = ""
      }
      .disabled(!isFormValid)
    }
  }
  
  private func saveItem() {
    let newItem = ItemModel(title: title)
    reminder.items?.append(newItem)
  }
  
  private var isFormValid: Bool {
    !title.isEmptyOrWhitespace
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
