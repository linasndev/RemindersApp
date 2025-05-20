//
//  ItemsStatsView.swift
//  RemindersApp
//
//  Created by Linas on 20/05/2025.
//

import SwiftUI

struct ItemsStatsView: View {
  
  let icon: String
  let title: String
  let count: Int
  
  var body: some View {
    GroupBox {
      HStack {
        VStack(alignment: .leading, spacing: 10) {
          Image(systemName: icon)
            .font(.title)

          Text(title)
        }
        
        Spacer()
        
        Text("\(count)")
          .font(.system(.largeTitle, design: .rounded, weight: .bold))
      }
      .frame(maxWidth: .infinity)
      .padding(.vertical)
    }
  }
}

#Preview {
  ItemsStatsView(icon: "calendar", title: "Today", count: 9)
}
