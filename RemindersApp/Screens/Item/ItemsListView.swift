//
//  ItemsListView.swift
//  RemindersApp
//
//  Created by Linas on 20/05/2025.
//

import SwiftUI
import SwiftData

struct ItemsListView: View {
  
  @Environment(\.modelContext) private var context
  
  @State private var selectedItem: ItemModel?
  
  let items: [ItemModel]
  
  @State private var itemIdAndDelay: [PersistentIdentifier: Delay] = [:]
  
  var body: some View {
    VStack {
      List {
        ForEach(items) { item in
          ItemCellView(item: item) { event in
            switch event {
            case .onChecked(let item, let isChecked):
              //get the delay from the dictionary
              var delay = itemIdAndDelay[item.persistentModelID]
              
              if let delay {
                delay.cancel()
                itemIdAndDelay.removeValue(forKey: item.persistentModelID)
                
              } else {
                //create new delay and add to the dictionary
                delay = Delay()
                itemIdAndDelay[item.persistentModelID] = delay
                delay?.performWork {
                  item.isCompleted = isChecked
                }
              }
              
            case .onSelect(let item):
              print("onSelect")
              selectedItem = item
            }
          }
        }
        .onDelete(perform: deleteItem)
      }
      .listStyle(.plain)
    }
    .ignoresSafeArea(.keyboard, edges: .bottom)
    .popover(item: $selectedItem) { item in
      EditItemScreen(item: item)
    }
  }
  
  private func deleteItem(_ indexSet: IndexSet) {
    guard let index = indexSet.first else { return }
    let item = items[index]
    context.delete(item)
    
    do {
      try context.save()
    } catch {
      fatalError("Can't delete Item")
    }
  }
}

#Preview {
  let container = ReminderModel.preview
  let fetchDescriptor = FetchDescriptor<ReminderModel>()
  let reminders = try! container.mainContext.fetch(fetchDescriptor)
  ItemsListView(items: reminders[0].items ?? [])
    .modelContainer(container)
}
