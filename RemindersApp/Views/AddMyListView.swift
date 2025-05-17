//
//  AddMyListView.swift
//  RemindersApp
//
//  Created by Linas on 17/05/2025.
//

import SwiftUI
import SwiftData

struct AddMyListView: View {
  
  @Environment(\.modelContext) private var context
  @Environment(\.dismiss) private var dismiss
  
  @State private var listName: String = ""
  @State private var selectedColor: Color = .cyan
  
  var body: some View {
    NavigationStack {
      VStack {
        Image(systemName: "line.3.horizontal.circle.fill")
          .font(.system(size: 80))
          .foregroundStyle(selectedColor)
          .animation(.easeInOut, value: selectedColor)
        
        TextField("List Name", text: $listName)
          .textFieldStyle(.roundedBorder)
          .padding(.horizontal, 44)
        
        ColorPickerView(selectedColor: $selectedColor)
      }
      .navigationTitle("New List")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button("Dismiss") {
            dismiss()
          }
        }
        
        ToolbarItem(placement: .topBarTrailing) {
          Button("Save") {
            guard let colorHexString = selectedColor.toHexString() else { return }
            let newMyList = MyListModel(name: listName, color: colorHexString)
            
            do {
              context.insert(newMyList)
              try context.save()
              dismiss()
            } catch {
              fatalError("❌ Can't save my new list")
            }
          }
          .disabled(listName.isEmpty)
        }
      }
    }
  }
}

#Preview {
  AddMyListView()
}
