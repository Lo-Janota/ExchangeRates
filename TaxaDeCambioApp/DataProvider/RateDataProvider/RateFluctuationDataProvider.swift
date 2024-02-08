//
//  RateFluctuationDataProvider.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

protocol RateFluctuationDataProviderDelegate: DataProviderMenagerDelegate {
    func success(model: RateFluctuationObject)
}

class RateFluctuationDataProvider: DataProviderMenager <RateFluctuationDataProviderDelegate, RateFluctuationObject> {
    
    private let ratesStore: RateStore
    
    init(ratesStore: RateStore = RateStore()) {
        self.ratesStore = ratesStore
    }
    
    func fetchFluctuation(by base: String, from symbols: [String], startDate: String, endDate: String) {
        Task.init {
            do {
                let model = try await ratesStore.fetchFluectuation(by: base, from: symbols, startDate: startDate, endDate: endDate)
                delegate?.success(model: model)
            } catch {
                delegate?.errorData(delegate, error: error)
            }
        }
    }
}
