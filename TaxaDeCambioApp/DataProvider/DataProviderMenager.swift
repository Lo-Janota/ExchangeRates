//
//  DataProviderMenager.swift
//  TaxaDeCambioApp
//
//  Created by Lorenzo Janota on 06/02/24.
//

import Foundation

protocol DataProviderMenagerDelegate {
    func success(model: Any)
    func errorData(_ provider: DataProviderMenagerDelegate?, error: Error)
}

extension DataProviderMenagerDelegate {
    
    func success(model: Any){
        preconditionFailure("This method must be overridden")
    }
    
    func errorData(_ provider: DataProviderMenagerDelegate?, error: Error) {
        print(error.localizedDescription)
    }
}

class DataProviderMenager<T, S> {
    var delegate: T?
    var model: S?
}
