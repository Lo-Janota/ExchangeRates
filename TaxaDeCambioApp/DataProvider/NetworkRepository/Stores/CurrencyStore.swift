//
//  CurrencyStore.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

protocol CurrencyProtocol {
    func fetchSymbols() async throws -> CurrencySymbolObject
}

class CurrencyStore: BaseStore, CurrencyProtocol {
    
    func fetchSymbols() async throws -> CurrencySymbolObject {
        guard let urlRequest = try CurrencyRouter.symbols.asUrlRequest() else { throw error }
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let symbols = try SymbolResult(data: data, response: response).symbols else { throw error }
        return symbols
    }

}
