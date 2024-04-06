//
//  RateAPI.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

// Enumeração para definir os tipos de método HTTP
enum HttpMethod: String {
    case get = "GET"
}

// Estrutura para definir a API de taxas de câmbio
struct RateAPI {
    static let baseURL = "https://api.apilayer.com/exchangerates_data" // URL base da API
    static let apiKey = "ojvvP8gcA1IB8qOs1mHJ4mWBhgoxHPp1" // Chave da API
    static let fluctuation = "/fluctuation" // Caminho para flutuação de taxa
    static let symbols = "/symbols" // Caminho para símbolos de moeda
    static let timeseries = "/timeseries" // Caminho para série temporal de taxas
}

