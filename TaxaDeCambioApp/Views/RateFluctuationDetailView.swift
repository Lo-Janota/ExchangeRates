//
//  RateFluctuationDetailView.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 09/02/24.
//

// Importação das bibliotecas necessárias
import SwiftUI
import Charts

// Definição de uma struct para representar uma comparação de gráfico
struct ChartComparation: Identifiable, Equatable {
    let id = UUID()
    var symbol: String
    var period: Date
    var endRate: Double
}

// Classe que contém a lógica de visualização e processamento dos dados
class RateFluctuationViewModel: ObservableObject {
    @Published var fluctuations: [Fluctuation] = [
        Fluctuation(symbol: "JPY", change: 0.0008, changePct: 0.0005, endRate: 0.007242),
        Fluctuation(symbol: "EUR", change: 0.0003, changePct: 0.1651, endRate: 0.181353),
        Fluctuation(symbol: "GBP", change: -0.0001, changePct: -0.0403, endRate: 0.1589150)
    ]
    @Published var chartComparations: [ChartComparation] = [
        ChartComparation(symbol: "USD", period: "2022-11-13".toDate(), endRate: 0.18857),
        ChartComparation(symbol: "USD", period: "2022-11-12".toDate(), endRate: 0.18757),
        ChartComparation(symbol: "USD", period: "2022-11-11".toDate(), endRate: 0.189786),
        ChartComparation(symbol: "USD", period: "2022-11-10".toDate(), endRate: 0.197073),
    ]
    @Published var timeRange = TimeRangeEnum.today
    
    // Verifica se há taxas disponíveis para exibição
    var hasRates: Bool {
        return chartComparations.filter { $0.endRate > 0 }.count > 0
    }
    
    // Calcula o valor mínimo do eixo Y do gráfico
    var yAxisMin: Double {
        let min = chartComparations.map { $0.endRate }.min() ?? 0.0
        return (min - (min * 0.02))
    }
    
    // Calcula o valor máximo do eixo Y do gráfico
    var yAxisMax: Double {
        let max = chartComparations.map { $0.endRate }.max() ?? 0.0
        return (max + (max * 0.02))
    }
    
    // Formata o rótulo do eixo X com base no período selecionado
    func xAxisLabelFormatStyle(for date: Date) -> String {
        switch timeRange {
        case .today:
            return date.Formatter(to: "HH:mm")
        case .thisWeek, .thisMonth:
            return date.Formatter(to: "dd, MMM")
        case .thisSemester:
            return date.Formatter(to: "MMM")
        case .thisYear:
            return date.Formatter(to: "MMM, YYYY")
        }
    }
}

// View que representa a tela de detalhes da flutuação da taxa de câmbio
struct RateFluctuationDetailView: View {
    
    @StateObject var viewModel = RateFluctuationViewModel() // View model para gerenciar os dados
    
    @State var baseCurrecy: String // Moeda base
    @State var rateFluctuation: Fluctuation // Flutuação da taxa de câmbio
    @State private var isPresentedBaseCurrencyFilter = false // Estado para controlar a exibição do filtro de moeda base
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            valuesView
            graphicChartView
            comparationView
        }
        .padding(.leading, 8)
        .padding(.trailing, 8)
        .navigationTitle("BRL a EUR")
    }
    
    // View para exibir os valores da flutuação da taxa de câmbio
    private var valuesView: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(rateFluctuation.endRate.formatter(decimalPlaces: 4))
                .font(.system(size: 28, weight: .bold))
            Text(rateFluctuation.changePct.toPercentage(with: true))
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(rateFluctuation.changePct.color)
                .background(rateFluctuation.changePct.color.opacity(0.2))
            Text(rateFluctuation.change.formatter(decimalPlaces: 4, with: true))
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(rateFluctuation.change.color)
            Spacer()
        }
        .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 8))
    }
    
    // View para exibir o gráfico da taxa de câmbio
    private var graphicChartView: some View {
        VStack {
            periodFilterView
            lineChartView
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
    }
    
    // View para exibir os botões de filtro de período do gráfico
    private var periodFilterView: some View {
        HStack(spacing: 16) {
            Button {
                print("1 Dia")
            } label: {
                Text("1 Dia")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.blue)
                    .underline()
            }
            
            // Outros botões de filtro omitidos por brevidade
        }
    }
    
    // View para exibir o gráfico da taxa de câmbio
    private var lineChartView: some View {
        Chart(viewModel.chartComparations) { item in
            LineMark (
                x: .value("Period", item.period),
                y: .value("Rates", item.endRate)
            )
            .interpolationMethod(.catmullRom)
            
            if !viewModel.hasRates {
                RuleMark(
                    y: .value("Conversão Zero", 0)
                )
                .annotation(position: .overlay, alignment: .center) {
                    Text("Sem valores nesse período.")
                        .font(.footnote)
                        .padding()
                        .background(Color(UIColor.systemBackground))
                }
            }
        }
        .chartXAxis{
            AxisMarks(preset: .aligned) { date in
                AxisGridLine()
                AxisValueLabel(viewModel.xAxisLabelFormatStyle(for: date.as(Date.self) ?? Date()))
            }
        }
        .chartYAxis{
            AxisMarks(position: .leading) { rate in
                AxisGridLine()
                AxisValueLabel(rate.as(Double.self)?.formatter(decimalPlaces: 3) ?? 0.0.formatter(decimalPlaces: 3))
            }
        }
        .chartYScale(domain: viewModel.yAxisMin...viewModel.yAxisMax)
        .frame(height: 260)
        .padding(.trailing, 18)
    }
    
    // View para exibir a comparação com outras moedas
    private var comparationView: some View {
        VStack(spacing: 8) {
            comparationButtonView
            comparationScrollView
            Spacer()
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
    }
    
    // Botão para abrir o filtro de comparação de moedas
    private var comparationButtonView: some View {
        Button {
            isPresentedBaseCurrencyFilter.toggle()
        } label: {
            Image(systemName: "magnifyingglass")
            Text("Comparar com")
                .font(.system(size: 16))
        }
        .fullScreenCover(isPresented: $isPresentedBaseCurrencyFilter, content: {
            BaseCurrencyFilterView()
        })
    }
    
    // Scroll view horizontal para exibir as comparações de moedas
    private var comparationScrollView: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())], alignment: .center) {
                ForEach(viewModel.fluctuations) { fluctuation in
                    Button {
                        print("Comparação")
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(fluctuation.symbol) / \(baseCurrecy)")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                            Text(fluctuation.endRate.formatter(decimalPlaces: 4))
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.black)
                            HStack(alignment: .bottom, spacing: 60) {
                                Text(fluctuation.symbol)
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.gray)
                                Text(fluctuation.changePct.toPercentage())
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(fluctuation.changePct.color)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                        .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 1)
                        )
                    }
                }
            }
        }
    }
}

// Preview da tela de detalhes da flutuação da taxa de câmbio
struct RateFluctuationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RateFluctuationDetailView(baseCurrecy: "BRL", rateFluctuation: Fluctuation(symbol: "EUR", change: 0.0003, changePct: 0.1651, endRate: 0.181353))
    }
}

