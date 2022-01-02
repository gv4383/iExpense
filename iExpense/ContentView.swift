//
//  ContentView.swift
//  iExpense
//
//  Created by Goyo Vargas on 12/6/21.
//

import SwiftUI

extension View {
    func setStyleForAmount(_ amount: Double) -> some View {
        self.modifier(AmountStyle(amount: amount))
    }
}

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var personalExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal" }
    }
    var businessExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }
    
    var body: some View {
        NavigationView {
            List {
                if personalExpenses.count > 0 {
                    Section("Personal") {
                        ForEach(personalExpenses) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: item.currency))
                                    .setStyleForAmount(item.amount)
                            }
                        }
                        .onDelete(perform: removePersonalItems)
                    }
                }
                
                if businessExpenses.count > 0 {
                    Section("Business") {
                        ForEach(businessExpenses) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: item.currency))
                                    .setStyleForAmount(item.amount)
                            }
                        }
                        .onDelete(perform: removeBusinessItems)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        for offset in offsets {
            let itemId = personalExpenses[offset].id
            let itemIndex = expenses.items.firstIndex { item in
                return item.id == itemId
            }
            
            expenses.items.remove(at: itemIndex!)
        }
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        for offset in offsets {
            let itemId = businessExpenses[offset].id
            let itemIndex = expenses.items.firstIndex { item in
                return item.id == itemId
            }
            
            expenses.items.remove(at: itemIndex!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
