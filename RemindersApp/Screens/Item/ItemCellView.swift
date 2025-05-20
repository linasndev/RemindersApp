//
//  ItemCellView.swift
//  RemindersApp
//
//  Created by Linas on 18/05/2025.
//

import SwiftUI
import SwiftData

enum ItemCellEvents {
  case onChecked(ItemModel, Bool)
  case onSelect(ItemModel)
}

struct ItemCellView: View {
  
  @State private var isChecked: Bool = false
  
  let item: ItemModel
  let onEvent: (ItemCellEvents) -> Void
  
  var body: some View {
    HStack(alignment: .center) {
      Image(systemName: isChecked ? "circle.inset.filled" : "circle")
        .font(.title)
        .padding(.trailing, 5)
        .onTapGesture {
          isChecked.toggle()
          onEvent(.onChecked(item, isChecked))
        }
      
      VStack(alignment: .leading) {
        Text(item.title)
          .font(.headline)
          .frame(maxWidth: .infinity, alignment: .leading)
        
        if let notes = item.notes {
          Text(notes)
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        HStack(spacing: 4) {
          if let itemReminderDate = item.itemReminderDate {
            Text("\(formatItemDate(itemReminderDate)),")
              .font(.caption)
              .foregroundStyle(.secondary)
          }
          
          if let itemReminderDate = item.itemReminderDate {
            Text(itemReminderDate.formatted(date: .omitted, time: .shortened))
              .font(.caption)
              .foregroundStyle(.secondary)
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .italic()
      }
      
      Spacer()
      
    }
    .contentShape(Rectangle())
    .onTapGesture {
      onEvent(.onSelect(item))
    }
  }
  
  private func formatItemDate(_ date: Date) -> String {
    if date.isToday {
      return "Today"
    } else if date.isTomorrow {
      return "Tomorrow"
    } else {
      return date.formatted(date: .abbreviated, time: .omitted)
    }
  }
}

//Preview Container
struct ItemCellViewContainer: View {
  
  @Query(sort: \ItemModel.title) private var items: [ItemModel]
  
  var body: some View {
    ItemCellView(item: items[0], onEvent: {_ in })
  }
}

#Preview {
  ItemCellViewContainer()
    .modelContainer(ReminderModel.preview)
}
