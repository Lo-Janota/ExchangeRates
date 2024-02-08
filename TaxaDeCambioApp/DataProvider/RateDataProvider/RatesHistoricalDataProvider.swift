//
//  RatesHistoricalDataProvider.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

protocol RatesHistoricalDataProviderDelegate: DataProviderMenagerDelegate {
    func success(model: RateHistoricalObject)
}

class RatesHistoricalDataProvider: DataProviderMenager <RatesHistoricalDataProviderDelegate, RateHistoricalObject> {
    
    private let ratesStore: RateStore
    
    init(ratesStore: RateStore = RateStore()) {
        self.ratesStore = ratesStore
    }
    
    func fetchTimeseries(by base: String, from symbols: [String], startDate: String, endDate: String) {
        Task.init {
            do {
                let model = try await ratesStore.fetchTimeseries(by: base, from: symbols, startDate: startDate, endDate: endDate)
                delegate?.success(model: model)
            } catch {
                delegate?.errorData(delegate, error: error)
            }
        }
    }
}
