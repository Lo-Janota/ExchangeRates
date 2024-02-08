//
//  RatesRouter.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

enum RatesRouter {
    
    case fluctuation(base: String, symbols: [String], startDate: String, endDate: String)
    case timeseries(base: String, symbols: [String], startDate: String, endDate: String)
    
    var path: String {
        switch self {
        case .fluctuation: return RateAPI.fluctuation
        case .timeseries: return RateAPI.timeseries
        }
    }
    
    func asUrlRequest() throws -> URLRequest? {
        guard var url = URL(string: RateAPI.baseURL) else { return nil }
        
        switch self {
        case .fluctuation(let base, let symbols, let startDate, let endDate):
            url.append(queryItems: [
                URLQueryItem(name: "base", value: base),
                URLQueryItem(name: "symbols", value: symbols.joined(separator: ",")),
                URLQueryItem(name: "start_date", value: startDate),
                URLQueryItem(name: "end_date", value: endDate)
            ])
        case .timeseries(let base, let symbols, let startDate, let endDate):
            url.append(queryItems: [
                URLQueryItem(name: "base", value: base),
                URLQueryItem(name: "symbols", value: symbols.joined(separator: ",")),
                URLQueryItem(name: "start_date", value: startDate),
                URLQueryItem(name: "end_date", value: endDate)
            ])
        }
        
        var request = URLRequest(url: url.appendingPathComponent(path), timeoutInterval: Double.infinity)
        request.httpMethod = HttpMethod.get.rawValue
        request.addValue(RateAPI.apiKey, forHTTPHeaderField: "apikey")
        return request
    }
}
