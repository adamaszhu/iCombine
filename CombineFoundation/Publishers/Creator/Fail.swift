//
//  Fail.swift
//  CombineFoundation
//
//  Created by Leon Nguyen on 5/8/21.
//

import RxSwift
import RxCocoa
#if canImport(Combine)
import Combine
#endif

/// A publisher that immediately terminates with the specified error.
public struct Fail<Output, Failure> : Publisher where Failure : Error {

    public let observable: Any

    /// Creates a publisher that immediately terminates with the specified failure.
    ///
    /// - Parameter error: The failure to send when terminating the publisher.
    public init(error: Failure) {
        #if canImport(Combine)
        if #available(iOS 13, *) {
            observable = Combine.Fail<Output, Failure>(error: error)
                .eraseToAnyPublisher()
            return
        }
        #endif
        observable = Observable<Output>.error(error)
    }

    /// Creates publisher with the given output type, that immediately terminates with the specified failure.
    ///
    /// Use this initializer to create a `Fail` publisher that can work with subscribers or publishers that expect a given output type.
    /// - Parameters:
    ///   - outputType: The output type exposed by this publisher.
    ///   - failure: The failure to send when terminating the publisher.
    public init(outputType: Output.Type, failure: Failure) {
        #if canImport(Combine)
        if #available(iOS 13, *) {
            observable = Combine.Fail<Output, Failure>(outputType: outputType, failure: failure)
                .eraseToAnyPublisher()
            return
        }
        #endif
        observable = Observable<Output>.error(failure)
    }
}
