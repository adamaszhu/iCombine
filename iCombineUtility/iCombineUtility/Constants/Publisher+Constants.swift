/// Publisher+Constants.swift
/// CombineUtility
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

import iCombine

public extension iCombine.Publisher {
    
    /// An empty publisher with the current publisher output and failure.
    static var empty: iCombine.AnyPublisher<Output, Failure> {
        return iCombine.Empty<Output, Failure>()
            .eraseToAnyPublisher()
    }
}

#if canImport(Combine)

import Combine

@available(iOS 13.0, *)
public extension Combine.Publisher {
    
    /// An empty publisher with the current publisher output and failure.
    static var empty: Combine.AnyPublisher<Output, Failure> {
        return Combine.Empty<Output, Failure>()
            .eraseToAnyPublisher()
    }
}

#endif
