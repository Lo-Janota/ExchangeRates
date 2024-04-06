//
//  RateFluctuationDataProvider.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

// Protocolo para o provedor de dados de flutuação de taxa
protocol RateFluctuationDataProviderDelegate: DataProviderMenagerDelegate {
    // Função chamada em caso de sucesso
    func success(model: RateFluctuationObject)
}

// Classe responsável por prover os dados de flutuação de taxa
class RateFluctuationDataProvider: DataProviderMenager <RateFluctuationDataProviderDelegate, RateFluctuationObject> {
    
    // Armazenamento da loja de taxas
    private let ratesStore: RateStore
    
    // Inicializador da classe
    init(ratesStore: RateStore = RateStore()) {
        self.ratesStore = ratesStore
    }
    
    // Função para buscar a flutuação de taxas
    func fetchFluctuation(by base: String, from symbols: [String], startDate: String, endDate: String) {
        Task.init {
            do {
                // Tenta buscar a flutuação de taxas
                let model = try await ratesStore.fetchFluectuation(by: base, from: symbols, startDate: startDate, endDate: endDate)
                // Chama a função de sucesso do delegate
                delegate?.success(model: model)
            } catch {
                // Em caso de erro, chama a função de erro do delegate
                delegate?.errorData(delegate, error: error)
            }
        }
    }
}
