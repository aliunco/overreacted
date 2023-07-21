//
//  Optional.swift
//  Overreacted
//
//  Created by Ali Saeedifar on 7/20/23.
//

import Foundation

protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}
