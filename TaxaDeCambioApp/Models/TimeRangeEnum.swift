//
//  TimeRangeEnum.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 19/02/24.
//

import Foundation

// Enumeração para representar diferentes intervalos de tempo
enum TimeRangeEnum {
    case today // Hoje
    case thisWeek // Esta semana
    case thisMonth // Este mês
    case thisSemester // Este semestre
    case thisYear // Este ano
    
    // Propriedade computada para obter a data correspondente ao intervalo
    var date: Date {
        switch self {
        case .today:
            return Date(from: .day, value: 1) // Retorna a data de hoje
        case .thisWeek:
            return Date(from: .day, value: 6) // Retorna a data de 6 dias atrás
        case .thisMonth:
            return Date(from: .month, value: 1) // Retorna a data do primeiro dia do mês
        case .thisSemester:
            return Date(from: .month, value: 6) // Retorna a data de 6 meses atrás
        case .thisYear:
            return Date(from: .year, value: 1) // Retorna a data do primeiro dia do ano
        }
    }
}

