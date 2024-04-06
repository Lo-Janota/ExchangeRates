//
//  ContentView.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import SwiftUI

// Estrutura da view principal
struct ContentView: View {
    var body: some View {
        RatesFluctuationView() // Exibe a view de flutuação de taxas
    }
}

// Estrutura para preview da view principal
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView() // Exibe a view principal
    }
}

