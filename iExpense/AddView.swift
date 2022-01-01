//
//  AddView.swift
//  iExpense
//
//  Created by Goyo Vargas on 12/12/21.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var currency = "USD"
    @State private var amount = 0.0
    
    let types = ["Business", "Personal"]
    let currencies = ["USD", "EUR"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("Currency", selection: $currency) {
                    ForEach(currencies, id: \.self) {
                        Text($0)
                    }
                }
                
                if currency == "USD" {
                    TextField(
                        "Amount",
                        value: $amount,
                        format: .currency(code: "USD")
                    )
                        .keyboardType(.decimalPad)
                } else if currency == "EUR" {
                    TextField(
                        "Amount",
                        value: $amount,
                        format: .currency(code: "EUR")
                    )
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(
                        name: name,
                        type: type,
                        currency: currency,
                        amount: amount
                    )
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
