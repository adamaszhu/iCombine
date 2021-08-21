//
//  TestError.swift
//  CombineFoundationTests
//
//  Created by Leon Nguyen on 5/8/21.
//

enum TestError: Int, Error {
    case one
    case two
}

func ==(lhs: Error, rhs: Error) -> Bool {
    guard let lhs = lhs as? TestError,
        let rhs = rhs as? TestError else {
            return false
    }
    return lhs.rawValue == rhs.rawValue
}
