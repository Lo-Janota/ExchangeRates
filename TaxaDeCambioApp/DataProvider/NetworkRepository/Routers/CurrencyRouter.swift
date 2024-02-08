//
//  CurrencyRouter.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

enum CurrencyRouter {
    
    case symbols
    
    var path: String {
        switch self {
        case .symbols: return RateAPI.symbols
        }
    }
    
    func asUrlRequest() throws -> URLRequest? {
        guard let url = URL(string: RateAPI.baseURL) else { return nil }
        
        switch self {
        case .symbols:
            var request = URLRequest(url: url.appendingPathComponent(path), timeoutInterval: Double.infinity)
            request.httpMethod = HttpMethod.get.rawValue
            request.addValue(RateAPI.apiKey, forHTTPHeaderField: "apikey")
            return request
        }
    }
}
