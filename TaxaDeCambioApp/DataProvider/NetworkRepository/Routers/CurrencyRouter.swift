//
//  CurrencyRouter.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

// Enumeração para definir os tipos de rotas de moeda
enum CurrencyRouter {
    
    case symbols // Rota para símbolos de moeda
    
    // Propriedade para obter o caminho da rota
    var path: String {
        switch self {
        case .symbols: return RateAPI.symbols
        }
    }
    
    // Função para obter a URL de requisição
    func asUrlRequest() throws -> URLRequest? {
        guard let url = URL(string: RateAPI.baseURL) else { return nil }
        
        switch self {
        case .symbols:
            // Cria e configura a requisição
            var request = URLRequest(url: url.appendingPathComponent(path), timeoutInterval: Double.infinity)
            request.httpMethod = HttpMethod.get.rawValue
            request.addValue(RateAPI.apiKey, forHTTPHeaderField: "apikey")
            return request
        }
    }
}

