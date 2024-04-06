//
//  CurrencyStore.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

// Protocolo para a loja de moeda
protocol CurrencyProtocol {
    func fetchSymbols() async throws -> CurrencySymbolObject // Função para buscar símbolos de moeda
}

// Classe responsável por armazenar e fornecer dados de moeda
class CurrencyStore: BaseStore, CurrencyProtocol {
    
    // Função para buscar símbolos de moeda
    func fetchSymbols() async throws -> CurrencySymbolObject {
        // Criação da URL de requisição
        guard let urlRequest = try CurrencyRouter.symbols.asUrlRequest() else { throw error }
        // Realiza a requisição e obtém os dados
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        // Decodifica os dados para obter os símbolos de moeda
        guard let symbols = try SymbolResult(data: data, response: response).symbols else { throw error }
        return symbols
    }

}

