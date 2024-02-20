//
//  RatesFlutuationView.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 08/02/24.
//

import SwiftUI

struct Fluctuation: Identifiable {
    let id = UUID()
    var symbol: String
    var change: Double
    var changePct: Double
    var endRate: Double
}


class FluctuationViewModel: ObservableObject {
    @Published var fluctuation: [Fluctuation] = [
        Fluctuation(symbol: "USD", change: 0.0008, changePct: 0.4175, endRate: 0.18857),
        Fluctuation(symbol: "EUR", change: 0.0003, changePct: 0.1651, endRate: 0.181353),
        Fluctuation(symbol: "GBP", change: -0.0001, changePct: -0.0403, endRate: 0.158915)
    ]
}

struct RatesFluctuationView: View {
    
    @StateObject var viewModel = FluctuationViewModel()
    
    @State private var searchText = ""
    
    var searchResult: [Fluctuation] {
        if searchText.isEmpty {
            return viewModel.fluctuation
        } else {
            return viewModel.fluctuation.filter {
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
                    print("Filtrar Moedas")
                } label: {
                    Image(systemName: "slider.horizontal.3")
                }
            }
        }
    }
    
    private var baseCurrencyPeriodFilterView: some View {
        HStack(alignment: .center, spacing: 16) {
            
            Button {
                print("Filtrar moeda base")
            } label: {
                Text("BRL")
                    .font(.system(size: 14, weight: .bold))
                    .padding(.init(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8).stroke(.white, lineWidth: 1)
                    )
            }
            .background(Color(UIColor.lightGray))
            .cornerRadius(8)
            
            Button {
                print("1 Dia")
            } label: {
                Text("1 Dia")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.blue)
                    .underline()
            }
            
            Button {
                print("7 Dias")
            } label: {
                Text("7 Dias")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
            }
            
            Button {
                print("1 Mês")
            } label: {
                Text("1 Mês")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
            }
            
            Button {
                print("6 Meses")
            } label: {
                Text("6 Meses")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
            }
            
            Button {
                print("1 Ano")
            } label: {
                Text("1 Ano")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 16)
    }
    
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


#Preview {
    RatesFluctuationView()
}
