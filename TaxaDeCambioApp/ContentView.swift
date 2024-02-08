//
//  ContentView.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import SwiftUI

struct ContentView: View, CurrencyDataProviderDelegate {
    var body: some View {
        VStack {
            Button {
                doFetchData()
            } label: {
                //Shift + Command + L
                Image(systemName: "network")
            }
        }
        .padding()
    }
    
    private func doFetchData() {
        let rateFluctuationProvider = RateFluctuationDataProvider()
        rateFluctuationProvider.delegate = self
        rateFluctuationProvider.fetchFluctuation(by: "BRL", from: ["USD", "EUA"], startDate: "2022-10-11", endDate: "2022-11-11")
        
        let rateSymbolDataProvider = CurrencyDataProvider()
        rateSymbolDataProvider.delegate = self
        rateSymbolDataProvider.fetchSymbols()
        
        let rateHistoricalDataProvider = RatesHistoricalDataProvider()
        rateHistoricalDataProvider.delegate = self
        rateHistoricalDataProvider.fetchTimeseries(by: "BRL", from: ["USD", "EUA"], startDate: "2022-10-11", endDate: "2022-11-11")
    }
}

extension ContentView: RateFluctuationDataProviderDelegate {
    
    func success(model: RateFluctuationObject) {
        print("RateFluctuationModel: \(model)\n\n")
    }
}

extension ContentView {
    
    func success(model: CurrencySymbolObject) {
        print("RateSymbolsDataProviderDelegate: \(model)\n\n")
    }
}

extension ContentView: RatesHistoricalDataProviderDelegate {
    
    func success(model: RateHistoricalObject) {
        print("ReteHistoricalModel: \(model)\n\n")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    ContentView()
}
