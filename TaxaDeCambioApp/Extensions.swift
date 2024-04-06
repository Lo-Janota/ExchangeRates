//
//  Extensions.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 08/02/24.
//

// Importa o framework Foundation para usar tipos como Double, String, Date e UINavigationController
import Foundation
import SwiftUI

// Extensão para o tipo Double
extension Double {
    
    // Propriedade computada que retorna uma cor com base no sinal do número (verde para positivo e vermelho para negativo)
    var color: Color {
        if self.sign == .minus {
            return .red
        } else {
            return .green
        }
    }
    
    // Método que formata um Double como uma string com um número específico de casas decimais e opcionalmente adiciona um símbolo de mudança (+ ou -)
    func formatter(decimalPlaces: Int, with changeSymbol: Bool = false) -> String {
        // Configura um NumberFormatter para formatação
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.roundingMode = .halfUp
        numberFormatter.minimumFractionDigits = (decimalPlaces > 2) ? decimalPlaces : 2
        numberFormatter.maximumFractionDigits = (decimalPlaces > 2) ? decimalPlaces : 2
        numberFormatter.locale = Locale(identifier: "pt_BR")
        
        // Formata o número e retorna como uma string
        guard let value = numberFormatter.string(from: NSNumber(value: self)) else { return String(self) }
        
        // Adiciona o símbolo de mudança se necessário
        if changeSymbol {
            if self.sign == .minus {
                return "\(value)"
            } else {
                return "+\(value)"
            }
        }
        return value.replacingOccurrences(of: "-", with: "")
    }
    
    // Método que formata um Double como uma string percentual com um número específico de casas decimais e opcionalmente adiciona um símbolo de mudança (+ ou -)
    func toPercentage(with changeSymbol: Bool = false) -> String {
        let value = formatter(decimalPlaces: 2)
        
        if changeSymbol {
            if self.sign == .minus {
                return "\u{2193} \(value)%"
            } else {
                return "\u{2191} \(value)%"
            }
        }
        return "\(value)%"
    }
}

// Extensão para o tipo String
extension String {
    
    // Método que converte uma string em uma data usando um formato específico (padrão: "yyyy-MM-dd")
    func toDate(dateFormat: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self) ?? Date()
    }
}

// Extensão para o tipo Date
extension Date {
    
    // Inicializador personalizado que cria uma data subtraindo um componente e um valor específico da data atual
    init(from componet: Calendar.Component, value: Int) {
        self = Calendar.current.date(byAdding: componet, value: -value, to: Date()) ?? Date()
    }
    
    // Método que formata uma data como uma string usando um formato específico
    func Formatter(to dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR_POSIX")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}

// Extensão para o tipo UINavigationController
extension UINavigationController {
    
    // Sobrescreve o método viewWillLayoutSubviews para configurar o botão de voltar sem texto na barra de navegação
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

