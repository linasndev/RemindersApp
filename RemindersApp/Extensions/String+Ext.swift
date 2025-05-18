//
//  String+Ext.swift
//  RemindersApp
//
//  Created by Linas on 18/05/2025.
//

import Foundation

extension String {
  var isEmptyOrWhitespace: Bool {
    trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }
}
