//
//  RatesFlutuationView.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 08/02/24.
//

import SwiftUI

// View principal para exibir a flutuação de taxas
struct RatesFluctuationView: View {
    
    @StateObject var viewModel = ViewModel()
    
    @State private var searchText = ""
    @State private var isPresentedBaseCurrencyFilter = false
    @State private var isPresentedMultiCurrencyFilter = false
    
    var searchResult: [RateFluctuationModel] {
        if searchText.isEmpty {
            return viewModel.ratesFluctuation
        } else {
            return viewModel.ratesFluctuation.filter {
                $0.symbol.contains(searchText.uppercased()) ||
                $0.change.formatter(decimalPlaces: 4).contains(searchText.uppercased()) ||
                $0.changePct.toPercentage().contains(searchText.uppercased()) ||
                $0.endRate.formatter(decimalPlaces: 2).contains(searchText.uppercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                baseCurrencyPeriodFilterView
                ratesFluctuationListView
            }
            .searchable(text: $searchText)
            .navigationTitle("Conversão de Moedas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    isPresentedMultiCurrencyFilter.toggle()
                } label: {
                    Image(systemName: "slider.horizontal.3")
                }
                .fullScreenCover(isPresented: $isPresentedMultiCurrencyFilter, content:  {
                    MultiCurrenciesFilterView()
                })
            }
        }
    }
    
    // View para os filtros de moeda base e período
    private var baseCurrencyPeriodFilterView: some View {
        HStack(alignment: .center, spacing: 16) {
            Button {
                isPresentedBaseCurrencyFilter.toggle()
            } label: {
                Text("BRL")
                    .font(.system(size: 14, weight: .bold))
                    .padding(.init(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8).stroke(.white, lineWidth: 1)
                    )
            }
            .fullScreenCover(isPresented: $isPresentedBaseCurrencyFilter, content: {
                BaseCurrencyFilterView()
            })
            .background(Color(UIColor.lightGray))
            .cornerRadius(8)
            
            // Botões para os períodos de tempo
            Button {
                print("1 Dia")
            } label: {
                Text("1 Dia")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.blue)
                    .underline()
            }
            
            // Outros botões para períodos de tempo
            // ...
        }
        .padding(.top, 8)
        .padding(.bottom, 16)
    }
    
    // Lista de flutuações de taxa
    private var ratesFluctuationListView: some View {
        List(searchResult) { fluctuation in
            NavigationLink(destination: RateFluctuationDetailView(baseCurrecy: "BRL", rateFluctuation: fluctuation)) {
                VStack {
                    HStack (alignment: .center, spacing: 8){
                        Text("\(fluctuation.symbol) / BRL")
                            .font(.system(size: 14, weight: .medium))
                        Text(fluctuation.endRate.formatter(decimalPlaces: 2))
                            .font(.system(size: 14, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        Text(fluctuation.change.formatter(decimalPlaces: 4, with: true))
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(fluctuation.change.color)
                        Text("(\(fluctuation.changePct.toPercentage()))")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(fluctuation.changePct.color)
                    }
                    Divider()
                        .padding(.leading, -20)
                        .padding(.trailing, -40)
                    }
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.white)
            }
            .listStyle(.plain)
        }
    }


// Preview da view de flutuação de taxas
#Preview {
    RatesFluctuationView()
}

