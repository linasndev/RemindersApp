//
//  Date+Ext.swift
//  RemindersApp
//
//  Created by Linas on 18/05/2025.
//

import Foundation

extension Date {
  
  var isToday: Bool {
    let calendar = Calendar.current
    return calendar.isDateInToday(self)
  }
  
  var isTomorrow: Bool {
    let calendar = Calendar.current
    return calendar.isDateInTomorrow(self)
  }
}
