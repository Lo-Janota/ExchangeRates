//
//  RatesHistoricalDataProvider.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

// Protocolo para o provedor de dados de histórico de taxas
protocol RatesHistoricalDataProviderDelegate: DataProviderMenagerDelegate {
    // Função chamada em caso de sucesso
    func success(model: RateHistoricalObject)
}

// Classe responsável por prover os dados de histórico de taxas
class RatesHistoricalDataProvider: DataProviderMenager <RatesHistoricalDataProviderDelegate, RateHistoricalObject> {
    
    // Armazenamento da loja de taxas
    private let ratesStore: RateStore
    
    // Inicializador da classe
    init(ratesStore: RateStore = RateStore()) {
        self.ratesStore = ratesStore
    }
    
    // Função para buscar a série temporal de taxas
    func fetchTimeseries(by base: String, from symbols: [String], startDate: String, endDate: String) {
        Task.init {
            do {
                // Tenta buscar a série temporal de taxas
                let model = try await ratesStore.fetchTimeseries(by: base, from: symbols, startDate: startDate, endDate: endDate)
                // Chama a função de sucesso do delegate
                delegate?.success(model: model)
            } catch {
                // Em caso de erro, chama a função de erro do delegate
                delegate?.errorData(delegate, error: error)
            }
        }
    }
}

