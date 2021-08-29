/// Publisher+Nil.swift
/// CombineUtility
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

import iCombine

public extension iCombine.Publisher {
    
    /// Remove all nil values from the stream
    func removeNil<O>() -> iCombine.AnyPublisher<O, Failure> where O? == Output {
        return filter { $0 != nil }
            .map { $0! }
            .eraseToAnyPublisher()
    }
}

#if canImport(Combine)

import Combine

@available(iOS 13.0, *)
public extension Combine.Publisher {
    
    /// Remove all nil values from the stream
    func removeNil<O>() -> Combine.AnyPublisher<O, Failure> where O? == Output {
        return filter { $0 != nil }
            .map { $0! }
            .eraseToAnyPublisher()
    }
}

#endif
