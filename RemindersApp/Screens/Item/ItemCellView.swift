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
  case onInfoSelected(ItemModel)
}

struct ItemCellView: View {
  
  @State private var isChecked: Bool = false
  
  let item: ItemModel
  let isSelected: Bool
  let onEvent: (ItemCellEvents) -> Void
  
  var body: some View {
    HStack(alignment: .center) {
      Image(systemName: "circle")
        .font(.title)
        .padding(.trailing, 5)
        .onTapGesture {
          isChecked.toggle()
          onEvent(.onChecked(item, isChecked))
        }
      
      VStack(alignment: .leading) {
        Text(item.title)
          .font(.headline)
        
        if let notes = item.notes {
          Text(notes)
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        
        HStack(spacing: 4) {
          if let itemReminderDate = item.itemReminderDate {
            Text(itemReminderDate, format: .dateTime.day().month())
              .font(.caption)
              .foregroundStyle(.secondary)
          }
          
          if let itemReminderDate = item.itemReminderDate {
            Text(itemReminderDate.formatted(date: .omitted, time: .shortened))
              .font(.caption)
              .foregroundStyle(.secondary)
          }
        }
        .italic()
      }
      
      Spacer()
      
      Image(systemName: "info.circle.fill")
        .padding(.trailing, 30)
        .font(.title3)
        .opacity(isSelected ? 1 : 0)
        .onTapGesture {
          onEvent(.onInfoSelected(item))
        }
    }
    .contentShape(Rectangle())
    .onTapGesture {
      onEvent(.onSelect(item))
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

//Preview Container
struct ItemCellViewContainer: View {
  
  @Query(sort: \ItemModel.title) private var items: [ItemModel]
  
  var body: some View {
    ItemCellView(item: items[0], isSelected: false, onEvent: {_ in })
  }
}

#Preview {
  ItemCellViewContainer()
    .modelContainer(ReminderModel.preview)
}
