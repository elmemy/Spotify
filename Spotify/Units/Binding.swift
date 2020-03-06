//
//  Binding.swift
//  YTS
//
//  Created by ahmed elmemy on 1/23/20.
//  Copyright © 2020 ElMeMy. All rights reserved.
//

import Foundation

class Binding<T>
{
    typealias Listener = (T) -> Void
    var listener : Listener?
    var value : T
    {
        didSet
        {
            listener?(value)
        }
    }
    init(_ value:T) {
        self.value = value
    }
    func bind(listener:Listener?){
        self.listener = listener
        listener?(value)
    }
}
