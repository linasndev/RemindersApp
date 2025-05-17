//
//  ColorPickerView.swift
//  RemindersApp
//
//  Created by Linas on 17/05/2025.
//

import SwiftUI

struct ColorPickerView: View {
  
  @Binding var selectedColor: Color
  
  let colors: [Color] = [.red, .green, .cyan, .indigo, .pink, .orange]
  
  var body: some View {
    HStack {
      ForEach(colors, id: \.self) { color in
        ZStack {
          Circle()
            .fill()
            .foregroundStyle(color)
            .padding(2)
          
          Circle()
            .strokeBorder(selectedColor == color ? .black : .clear, lineWidth: 4)
            .scaleEffect(CGSize(width: 1.2, height: 1.2))
        }
        .onTapGesture {
          selectedColor = color
        }
      }
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: 100)
    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
  }
}

#Preview {
  ColorPickerView(selectedColor: .constant(.cyan))
}
