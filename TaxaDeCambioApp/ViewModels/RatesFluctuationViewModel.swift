//
//  RatesFluctuationViewModel.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 04/05/24.
//


/* PARAMOS NO MINUTO 52:43
 -> Video 3
 -> Pasta 3
 */
import Foundation
import SwiftUI

extension RatesFluctuationView {
    @MainActor class ViewModel: ObservableObject {
        @Published var ratesFluctuation = [RateFluctuationModel]()
        
        private let dataProvider: RatesFluctuationDataProvider?
        
        init(ratesFluctuation: RatesFluctuationDataProvider = RatesFluctuationDataProvider()) {
            self.dataProvider = dataProvider
            self
        }
    }
}
