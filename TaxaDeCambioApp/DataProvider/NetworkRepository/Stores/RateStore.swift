//
//  RateStore.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

protocol RateStoreProtocol {
    func fetchFluectuation(by base: String, from symbols: [String], startDate: String, endDate: String)
        async throws -> RateFluctuationObject
    func fetchTimeseries(by base: String, from symbols: [String], startDate: String, endDate: String)
        async throws -> RateHistoricalObject
}

class RateStore: BaseStore, RateStoreProtocol {
    
    func fetchFluectuation(by base: String, from symbols: [String], startDate: String, endDate: String)
    async throws -> RateFluctuationObject {
        guard let urlRequest = try RatesRouter.fluctuation(base: base, symbols: symbols, startDate: startDate, endDate: endDate).asUrlRequest() else {
            throw error
        }
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let rates = try RateResult<RateFluctuationObject>(data: data, response: response).rates
        else {
            throw error
        }
        return rates
    }
    
    func fetchTimeseries(by base: String, from symbols: [String], startDate: String, endDate: String)
    async throws -> RateHistoricalObject {
        guard let urlRequest = try RatesRouter.timeseries(base: base, symbols: symbols, startDate: startDate, endDate: endDate).asUrlRequest() else {
            throw error
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let rates = try RateResult<RateHistoricalObject>(data: data, response: response).rates
        else {
            throw error
        }
        return rates
        
    }
}
