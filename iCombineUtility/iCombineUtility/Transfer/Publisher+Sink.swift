/// Publisher+Sink.swift
/// CombineUtility
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

import iCombine

public extension iCombine.Publisher {
    
    /// Attaches a subscriber with closure-based behavior.
    /// - Parameters:
    ///   - receiveFinished: The closure to execute on finishing
    ///   - receiveFailure: The closure to execute on receipt of a failure
    ///   - receiveValue: The closure to execute on receipt of a value
    /// - Returns: A cancellable instance; used when you end assignment of the received value. Deallocation of the result will tear down the subscription stream.
    func sink(receiveFinished: @escaping (() -> Void) = {},
              receiveFailure: @escaping ((Self.Failure) -> Void) = { _ in },
              receiveValue: @escaping ((Self.Output) -> Void) = { _ in }) -> iCombine.AnyCancellable {
        return sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            receiveFinished()
                        case .failure(let error):
                            receiveFailure(error)
                        }
                    },
                    receiveValue: receiveValue)
    }
}

#if canImport(Combine)

import Combine

@available(iOS 14.0, macOS 10.15, *)
public extension Combine.Publisher {
    
    /// Attaches a subscriber with closure-based behavior.
    /// - Parameters:
    ///   - receiveFinished: The closure to execute on finishing
    ///   - receiveFailure: The closure to execute on receipt of a failure
    ///   - receiveValue: The closure to execute on receipt of a value
    /// - Returns: A cancellable instance; used when you end assignment of the received value. Deallocation of the result will tear down the subscription stream.
    func sink(receiveFinished: @escaping (() -> Void) = {},
              receiveFailure: @escaping ((Self.Failure) -> Void) = { _ in },
              receiveValue: @escaping ((Self.Output) -> Void) = { _ in }) -> Combine.AnyCancellable {
        return sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            receiveFinished()
                        case .failure(let error):
                            receiveFailure(error)
                        }
                    },
                    receiveValue: receiveValue)
    }
}

#endif
