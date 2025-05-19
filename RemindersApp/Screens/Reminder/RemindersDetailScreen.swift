//
//  RemindersDetailView.swift
//  RemindersApp
//
//  Created by Linas on 18/05/2025.
//

import SwiftUI
import SwiftData

struct RemindersDetailScreen: View {
  
  @Environment(\.modelContext) private var context
  
  @State private var title: String = ""
  @State private var isPresentedNewItemAlertSheet: Bool = false
  @State private var activeSelectedItem: ItemModel?
  @State private var itemToEditInPopover: ItemModel?
  
  let reminder: ReminderModel
  
  private let delayToCompleted: Delay = Delay(seconds: 2.0)
  
  var body: some View {
    VStack {
      if let items = reminder.items {
        List {
          ForEach(items.filter { !$0.isCompleted }) { item in
            ItemCellView(item: item, isSelected: isItemSelected(item)) { event in
              switch event {
              case .onChecked(let item, let isChecked):
                //Cancel pending task
                delayToCompleted.cancel()
                
                //Perform work
                delayToCompleted.performWork {
                  item.isCompleted = isChecked
                }
                
              case .onSelect(let item):
                print("onSelect")
                activeSelectedItem = item
              case .onInfoSelected(let item):
                print("onInfoSelected")
                itemToEditInPopover = item
              }
            }
          }
          .onDelete(perform: deleteItem)
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
    .popover(item: $itemToEditInPopover) { item in
      EditItemScreen(item: item)
    }
  }
  
  private func saveItem() {
    let newItem = ItemModel(title: title)
    reminder.items?.append(newItem)
  }
  
  private var isFormValid: Bool {
    !title.isEmptyOrWhitespace
  }
  
  private func isItemSelected(_ item: ItemModel) -> Bool {
    item.persistentModelID == activeSelectedItem?.persistentModelID
  }
  
  //TODO: Need fix, because it's not delete from filter array.
  private func deleteItem(_ indexSet: IndexSet) {
    indexSet.forEach { index in
      if let items = reminder.items {
        let deleteItem = items[index]
        do {
          context.delete(deleteItem)
          try context.save()
        } catch {
          fatalError("Can't delete item")
        }
      }
    }
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
