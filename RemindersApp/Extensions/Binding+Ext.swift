//
//  Binding+Ext.swift
//  RemindersApp
//
//  Created by Linas on 18/05/2025.
//

import SwiftUI

extension Binding where Value == Date? {
  func unwrapped(default defaultValue: Date = Date()) -> Binding<Date> {
    Binding<Date>(
      get: { self.wrappedValue ?? defaultValue },
      set: { self.wrappedValue = $0 }
    )
  }
}
