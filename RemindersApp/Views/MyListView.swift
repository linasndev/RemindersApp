//
//  MyListView.swift
//  RemindersApp
//
//  Created by Linas on 17/05/2025.
//

import SwiftUI

struct MyListView: View {
  
  let myLists: [String] = ["Reminders", "Groceries"]
  
  @State private var isPresentedNewListViewSheet: Bool = false
  
  var body: some View {
    List {
      Text("My Lists")
        .font(.system(.largeTitle, design: .rounded, weight: .bold))
      
      Group {
        ForEach(myLists, id: \.self) { myList in
            HStack {
              Image(systemName: "line.3.horizontal.circle.fill")
                .font(.system(.title))
              
              Text(myList)
            }
        }
        
        Button {
          isPresentedNewListViewSheet.toggle()
        } label: {
          Text("Add List")
            .foregroundStyle(.cyan)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
      }
      .listRowSeparator(.hidden)
    }
    .listStyle(.plain)
    .popover(isPresented: $isPresentedNewListViewSheet) {
      AddMyListView()
        .presentationCompactAdaptation(.sheet)
        .presentationDetents([.medium])
    }
  }
}

#Preview {
  MyListView()
}
