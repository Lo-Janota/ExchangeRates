//
//  CurrencySymbolModel.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 04/05/24.
//

import Foundation

// Struct para representar um símbolo de moeda
struct CurrencySymbolModel: Identifiable {
    let id = UUID()
    var symbol: String
    var fullName: String
}
