//
//  ColorPickerView.swift
//  RemindersApp
//
//  Created by Linas on 17/05/2025.
//

import SwiftUI

struct ColorPickerView: View {
  
  @Binding var selectedColor: String
  
  let colors: [String] = ["355070", "6a4c93", "0077b6", "f77f00", "386641", "1d2d44"]
  
  var body: some View {
    HStack {
      ForEach(colors, id: \.self) { color in
        ZStack {
          Circle()
            .fill()
            .foregroundStyle(Color(hex: color) ?? Color.black)
            .padding(2)
          
          Circle()
            .strokeBorder(selectedColor == color ? .gray : .clear, lineWidth: 3)
            .scaleEffect(CGSize(width: 1.1, height: 1.1))
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
  ColorPickerView(selectedColor: .constant("0077b6"))
}
