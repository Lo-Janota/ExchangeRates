//
//  RateAPI.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
}

struct RateAPI {
    static let baseURL = "https://api.apilayer.com/exchangerates_data"
    static let apiKey = "ojvvP8gcA1IB8qOs1mHJ4mWBhgoxHPp1"
    static let fluctuation = "/fluctuation"
    static let symbols = "/symbols"
    static let timeseries = "/timeseries"
}

