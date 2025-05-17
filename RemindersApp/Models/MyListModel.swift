//
//  MyListModel.swift
//  RemindersApp
//
//  Created by Linas on 17/05/2025.
//

import Foundation
import SwiftData

@Model
class MyListModel {
  var name: String
  var color: String
  
  init(name: String, color: String) {
    self.name = name
    self.color = color
  }
}
