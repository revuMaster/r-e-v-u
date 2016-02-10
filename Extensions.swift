//
//  Extensions.swift
//  QuizMe
//
//  Created by Escobido, Matthew George O. on 08/02/2016.
//  Copyright © 2016 AIM. All rights reserved.
//

import Foundation

extension Array {
    mutating func shuffle() {
        if count < 2 { return }
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            customSwap(&self[i],b:&self[j])
        }
    }
}

func customSwap<T>(inout a:T, inout b:T ){
    let temp = a
    a = b
    b = temp
}