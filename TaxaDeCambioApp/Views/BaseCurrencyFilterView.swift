//
//  BaseCurrencyFilterView.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 21/02/24.
//

// Importação das bibliotecas necessárias
import SwiftUI

// Struct para representar um símbolo de moeda
struct Symbol: Identifiable, Equatable {
    let id = UUID()
    var symbol: String
    var fullName: String
}

// Classe que contém a lógica de visualização e processamento dos dados
class BaseCurrencyFilterViewModel: ObservableObject {
    @Published var symbols: [Symbol] = [ // Lista de símbolos de moeda
        Symbol(symbol: "BRL", fullName: "Brazilian Real"),
        Symbol(symbol: "EUR", fullName: "Euro"),
        Symbol(symbol: "GBP", fullName: "British Pound Sterling"),
        Symbol(symbol: "JPY", fullName: "Japanese Yen"),
        Symbol(symbol: "USD", fullName: "United States Dollar")
    ]
}

// View para exibir o filtro de moeda base
struct BaseCurrencyFilterView: View {
    
    @Environment(\.dismiss) var dismiss // Ambiente para dismiss da view
    
    @StateObject var viewModel = BaseCurrencyFilterViewModel() // View model para gerenciar os dados
    
    @State private var searchText = "" // Texto de busca
    @State private var selection: String? // Seleção da moeda base
    
    var searchResults: [Symbol] { // Resultados da busca
        if searchText.isEmpty { // Se a busca estiver vazia, retorna todos os símbolos
            return viewModel.symbols
        } else { // Caso contrário, filtra os símbolos que contenham o texto de busca
            return viewModel.symbols.filter {
                $0.symbol.contains(searchText.uppercased()) ||
                $0.fullName.uppercased().contains(searchText.uppercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            listCurrenciesView // Exibe a lista de moedas
        }
    }
    
    // View da lista de moedas
    private var listCurrenciesView: some View {
        List(searchResults, id: \.symbol, selection: $selection) { item in
            HStack {
                Text(item.symbol)
                    .font(.system(size: 14, weight: .bold))
                Text("-")
                    .font(.system(size: 14, weight: .semibold))
                Text(item.fullName)
                    .font(.system(size: 14, weight: .semibold))
            }
        }
        .searchable(text: $searchText) // Adiciona a funcionalidade de busca
        .navigationTitle("Filtrar Moedas") // Título da navegação
        .navigationBarTitleDisplayMode(.inline) // Modo de exibição do título
        .toolbar {
            Button { // Botão para confirmar a seleção e fechar a view
                dismiss()
            } label: {
                Text("OK")
                    .fontWeight(.bold)
            }
        }
    }
}

// Preview da view de filtro de moeda base
struct BaseCurrencyFilterView_Previews: PreviewProvider {
    static var previews: some View {
        BaseCurrencyFilterView()
    }
}

