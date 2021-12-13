//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Goyo Vargas on 12/11/21.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
