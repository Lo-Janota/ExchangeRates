//
//  RateFlutuationObject.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

typealias RateFluctuationObject = [String: FluctuationObject]

struct FluctuationObject: Codable {
    let change: Double
    let endRate: Double
    let changePct: Double
    
    enum CodingKeys: String, CodingKey {
        case change
        case endRate = "end_rate"
        case changePct = "change_pct"
    }
}
