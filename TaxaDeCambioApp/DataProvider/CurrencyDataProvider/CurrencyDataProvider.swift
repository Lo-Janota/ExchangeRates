//
//  CurrencyDataProvider.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

protocol CurrencyDataProviderDelegate: DataProviderMenagerDelegate {
    func success(model: CurrencySymbolObject)
}

class CurrencyDataProvider: DataProviderMenager <CurrencyDataProviderDelegate, CurrencySymbolObject> {
    
    private let currencyStore: CurrencyStore
    
    init(currencyStore: CurrencyStore = CurrencyStore()) {
        self.currencyStore = currencyStore
    }
    
    func fetchSymbols() {
        Task.init {
            do {
                let model = try await currencyStore.fetchSymbols()
                delegate?.success(model: model)
            } catch {
                delegate?.errorData(delegate, error: error)
            }
        }
    }
}
