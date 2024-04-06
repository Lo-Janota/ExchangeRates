//
//  RateStore.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

// Protocolo para a loja de taxas
protocol RateStoreProtocol {
    func fetchFluectuation(by base: String, from symbols: [String], startDate: String, endDate: String)
        async throws -> RateFluctuationObject // Função para buscar flutuação de taxa
    func fetchTimeseries(by base: String, from symbols: [String], startDate: String, endDate: String)
        async throws -> RateHistoricalObject // Função para buscar série temporal de taxas
}

// Classe responsável por armazenar e fornecer taxas
class RateStore: BaseStore, RateStoreProtocol {
    
    // Função para buscar flutuação de taxa
    func fetchFluectuation(by base: String, from symbols: [String], startDate: String, endDate: String)
    async throws -> RateFluctuationObject {
        // Criação da URL de requisição
        guard let urlRequest = try RatesRouter.fluctuation(base: base, symbols: symbols, startDate: startDate, endDate: endDate).asUrlRequest() else {
            throw error
        }
        // Realiza a requisição e obtém os dados
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        // Decodifica os dados para obter as taxas de flutuação
        guard let rates = try RateResult<RateFluctuationObject>(data: data, response: response).rates
        else {
            throw error
        }
        return rates
    }
    
    // Função para buscar série temporal de taxas
    func fetchTimeseries(by base: String, from symbols: [String], startDate: String, endDate: String)
    async throws -> RateHistoricalObject {
        // Criação da URL de requisição
        guard let urlRequest = try RatesRouter.timeseries(base: base, symbols: symbols, startDate: startDate, endDate: endDate).asUrlRequest() else {
            throw error
        }
        
        // Realiza a requisição e obtém os dados
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        // Decodifica os dados para obter a série temporal de taxas
        guard let rates = try RateResult<RateHistoricalObject>(data: data, response: response).rates
        else {
            throw error
        }
        return rates
        
    }
}

