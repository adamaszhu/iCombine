/// Publisher+Error.swift
/// CombineUtility
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

import iCombine

public extension iCombine.Publisher {
    
    /// Map any error into a specific error.
    /// - Parameter error: The error to be mapped into.
    func mapError<E>(into error: E) -> iCombine.AnyPublisher<Output, E> where E : Error {
        return mapError { _ in error }
            .eraseToAnyPublisher()
    }
    
    /// Ignore errors occur in the publisher
    func ignoreError() -> iCombine.AnyPublisher<Output, Never> {
        return self.catch { _ in iCombine.AnyPublisher<Output, Never>.empty }
            .eraseToAnyPublisher()
    }
}

#if canImport(Combine)

import Combine

@available(iOS 14.0, macOS 10.15, *)
public extension Combine.Publisher {
    
    /// Map any error into a specific error.
    /// - Parameter error: The error to be mapped into.
    func mapError<E>(into error: E) -> Combine.AnyPublisher<Output, E> where E : Error {
        return mapError { _ in error }
            .eraseToAnyPublisher()
    }
    
    /// Ignore errors occur in the publisher
    func ignoreError() -> Combine.AnyPublisher<Output, Never> {
        return self.catch { _ in Combine.AnyPublisher<Output, Never>.empty }
            .eraseToAnyPublisher()
    }
}

#endif
