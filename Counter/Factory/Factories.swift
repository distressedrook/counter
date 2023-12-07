//
//  Factories.swift
//  Counter
//
//  Created by Avismara Hugoppalu on 07/12/23.
//

import Foundation

struct Factories {
    var viewModelFactory: ViewModelFactory

    static var `default`: Factories = Factories(viewModelFactory: ViewModelFactoryImp())

}
