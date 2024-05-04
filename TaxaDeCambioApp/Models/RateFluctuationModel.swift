//
//  RateFluctuationModel.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 04/05/24.
//

import Foundation

// Estrutura para representar uma flutuação de taxa
struct RateFluctuationModel: Identifiable {
    let id = UUID()
    var symbol: String
    var change: Double
    var changePct: Double
    var endRate: Double
}
