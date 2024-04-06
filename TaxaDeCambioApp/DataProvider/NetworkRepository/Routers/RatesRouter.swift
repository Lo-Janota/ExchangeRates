//
//  RatesRouter.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

// Enumeração para definir os tipos de rotas de taxas
enum RatesRouter {
    
    case fluctuation(base: String, symbols: [String], startDate: String, endDate: String) // Rota para flutuação de taxa
    case timeseries(base: String, symbols: [String], startDate: String, endDate: String) // Rota para série temporal de taxas
    
    // Propriedade para obter o caminho da rota
    var path: String {
        switch self {
        case .fluctuation: return RateAPI.fluctuation
        case .timeseries: return RateAPI.timeseries
        }
    }
    
    // Função para obter a URL de requisição
    func asUrlRequest() throws -> URLRequest? {
        guard var url = URL(string: RateAPI.baseURL) else { return nil }
        
        switch self {
        case .fluctuation(let base, let symbols, let startDate, let endDate):
            // Adiciona os parâmetros à URL para a rota de flutuação
            url.append(queryItems: [
                URLQueryItem(name: "base", value: base),
                URLQueryItem(name: "symbols", value: symbols.joined(separator: ",")),
                URLQueryItem(name: "start_date", value: startDate),
                URLQueryItem(name: "end_date", value: endDate)
            ])
        case .timeseries(let base, let symbols, let startDate, let endDate):
            // Adiciona os parâmetros à URL para a rota de série temporal
            url.append(queryItems: [
                URLQueryItem(name: "base", value: base),
                URLQueryItem(name: "symbols", value: symbols.joined(separator: ",")),
                URLQueryItem(name: "start_date", value: startDate),
                URLQueryItem(name: "end_date", value: endDate)
            ])
        }
        
        // Cria e configura a requisição
        var request = URLRequest(url: url.appendingPathComponent(path), timeoutInterval: Double.infinity)
        request.httpMethod = HttpMethod.get.rawValue
        request.addValue(RateAPI.apiKey, forHTTPHeaderField: "apikey")
        return request
    }
}

