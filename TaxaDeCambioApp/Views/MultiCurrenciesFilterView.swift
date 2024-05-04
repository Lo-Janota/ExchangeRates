//
//  MultiCurrenciesFilterViewView.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 21/02/24.
//

// Importação das bibliotecas necessárias
import SwiftUI

// View para exibir o filtro de múltiplas moedas
struct MultiCurrenciesFilterView: View {
    
    @Environment(\.dismiss) var dismiss // Ambiente para dismiss da view
    
    @StateObject var viewModel = ViewModel() // View model para gerenciar os dados
    
    @State private var searchText = "" // Texto de busca
    @State private var selections: [String] = [] // Seleções das moedas
    
    var searchResults: [CurrencySymbolModel] { // Resultados da busca
        if searchText.isEmpty { // Se a busca estiver vazia, retorna todos os símbolos
            return viewModel.currencySymbols
        } else { // Caso contrário, filtra os símbolos que contenham o texto de busca
            return viewModel.currencySymbols.filter {
                $0.symbol.contains(searchText.uppercased()) ||
                $0.fullName.uppercased().contains(searchText.uppercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            listCurrenciesView // Exibe a lista de moedas
        }
        .onAppear {
            viewModel.doFetchCurrencySymbols()
        }
    }
    
    // View da lista de moedas
    private var listCurrenciesView: some View {
        List(searchResults, id: \.symbol) { item in
            Button { // Botão para selecionar/deselecionar a moeda
                if selections.contains(item.symbol) {
                    selections.removeAll { $0 == item.symbol } // Remove a moeda se já estiver selecionada
                } else {
                    selections.append(item.symbol) // Adiciona a moeda se ainda não estiver selecionada
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
                    Image(systemName: "checkmark") // Ícone de checkmark para indicar seleção
                        .opacity(selections.contains(item.symbol) ? 1.0 : 0.0) // Opacidade do ícone de acordo com a seleção
                    Spacer()
                }
            }
            .foregroundColor(.primary) // Cor do texto
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

// Preview da view de filtro de múltiplas moedas
struct CurrencySelectionFilter_Previews: PreviewProvider {
    static var previews: some View {
        MultiCurrenciesFilterView()
    }
}

