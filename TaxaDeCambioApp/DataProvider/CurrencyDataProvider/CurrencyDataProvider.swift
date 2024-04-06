//
//  CurrencyDataProvider.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

// Protocolo para o provedor de dados de moeda
protocol CurrencyDataProviderDelegate: DataProviderMenagerDelegate {
    // Função chamada em caso de sucesso
    func success(model: CurrencySymbolObject)
}

// Classe responsável por prover os dados de moeda
class CurrencyDataProvider: DataProviderMenager <CurrencyDataProviderDelegate, CurrencySymbolObject> {
    
    // Armazenamento da loja de moeda
    private let currencyStore: CurrencyStore
    
    // Inicializador da classe
    init(currencyStore: CurrencyStore = CurrencyStore()) {
        self.currencyStore = currencyStore
    }
    
    // Função para buscar os símbolos de moeda
    func fetchSymbols() {
        Task.init {
            do {
                // Tenta buscar os símbolos de moeda
                let model = try await currencyStore.fetchSymbols()
                // Chama a função de sucesso do delegate
                delegate?.success(model: model)
            } catch {
                // Em caso de erro, chama a função de erro do delegate
                delegate?.errorData(delegate, error: error)
            }
        }
    }
}
