//
//  DataProviderMenager.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

// Protocolo para o gerenciador de provedores de dados
protocol DataProviderMenagerDelegate {
    func success(model: Any) // Função chamada quando a operação é bem-sucedida
    func errorData(_ provider: DataProviderMenagerDelegate?, error: Error) // Função chamada em caso de erro
}

// Extensão do protocolo para fornecer comportamento padrão
extension DataProviderMenagerDelegate {
    
    // Implementação padrão para sucesso, que deve ser sobrescrita
    func success(model: Any){
        preconditionFailure("This method must be overridden")
    }
    
    // Implementação padrão para erro, que imprime a descrição do erro
    func errorData(_ provider: DataProviderMenagerDelegate?, error: Error) {
        print(error.localizedDescription)
    }
}

// Classe base para o gerenciador de provedores de dados
class DataProviderMenager<T, S> {
    var delegate: T? // Delegado do gerenciador
    var model: S? // Modelo de dados
}

