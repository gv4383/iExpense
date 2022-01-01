//
//  AmountStyle.swift
//  iExpense
//
//  Created by Goyo Vargas on 12/22/21.
//

import SwiftUI

struct AmountStyle: ViewModifier {
    let amount: Double
    
    func body(content: Content) -> some View {
        var foregroundColor = Color.black
        
        if amount >= 10 && amount < 100 {
            foregroundColor = Color.yellow
        } else if amount >= 100 {
            foregroundColor = Color.red
        }
        
        return content
            .foregroundColor(foregroundColor)
    }
}
