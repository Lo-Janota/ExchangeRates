//
//  MultiCurrenciesFilterViewView.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 21/02/24.
//

import SwiftUI

class MultiCurrenciesFilterViewModel: ObservableObject {
    @Published var symbols: [Symbol] = [
        Symbol(symbol: "BRL", fullName: "Brazilian Real"),
        Symbol(symbol: "EUR", fullName: "Euro"),
        Symbol(symbol: "GBP", fullName: "British Pound Sterling"),
        Symbol(symbol: "JPY", fullName: "Japanese Yen"),
        Symbol(symbol: "USD", fullName: "United States Dollar")
    ]
}

struct MultiCurrenciesFilterView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = MultiCurrenciesFilterViewModel()
    
    @State private var searchText = ""
    @State private var selections: [String] = []
    
    var searchResults: [Symbol] {
        if searchText.isEmpty {
            return viewModel.symbols
        } else {
            return viewModel.symbols.filter {
                $0.symbol.contains(searchText.uppercased()) ||
                $0.fullName.uppercased().contains(searchText.uppercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            listCurrenciesView
        }
    }
    
    private var listCurrenciesView: some View {
        List(searchResults, id: \.symbol) { item in
            Button {
                if selections.contains(item.symbol) {
                    selections.removeAll { $0 == item.symbol }
                } else {
                    selections.append(item.symbol)
                }
            } label: {
                HStack {
                    HStack {
                        Text(item.symbol)
                            .font(.system(size: 14, weight: .bold))
                        Text("-")
                            .font(.system(size: 14, weight: .semibold))
                        Text(item.fullName)
                            .font(.system(size: 14, weight: .semibold))
                        Spacer()
                    }
                    Image(systemName: "checkmark")
                        .opacity(selections.contains(item.symbol) ? 1.0 : 0.0)
                    Spacer()
                }
            }
            .foregroundColor(.primary)
        }
        .searchable(text: $searchText)
        .navigationTitle("Filtrar Moedas")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                dismiss()
            } label: {
                Text("OK")
                    .fontWeight(.bold)
            }
        }
    }
}

struct CurrencySelectionFilter_Previews: PreviewProvider {
    static var previews: some View {
        MultiCurrenciesFilterView()
    }
}
