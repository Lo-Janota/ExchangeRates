//
//  RateHistoricalModel.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 04/05/24.
//

import Foundation

// Definição de uma struct para representar uma comparação de gráfico
struct RateHistoricalModel: Identifiable {
    let id = UUID()
    var symbol: String
    var period: Date
    var endRate: Double
}
