//
//  RateFlutuationObject.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

// Definição do tipo de objeto para flutuação de taxa
typealias RateFluctuationObject = [String: FluctuationObject]

// Estrutura que representa a flutuação de taxa
struct FluctuationObject: Codable {
    let change: Double // Variação da taxa
    let endRate: Double // Taxa final
    let changePct: Double // Variação percentual
    
    // Mapeamento das chaves para decodificação do JSON
    enum CodingKeys: String, CodingKey {
        case change
        case endRate = "end_rate"
        case changePct = "change_pct"
    }
}

