//
//  Empty.swift
//  CombineFoundation
//
//  Created by Leon Nguyen on 8/8/21.
//

import RxCocoa
import RxSwift
#if canImport(Combine)
import Combine
#endif

/// A publisher that never publishes any values, and optionally finishes immediately.
///
/// You can create a ”Never” publisher — one which never sends values and never finishes or fails — with the initializer `Empty(completeImmediately: false)`.
public struct Empty<Output, Failure> : Publisher where Failure : Error {

    public let observable: Any

    /// Creates an empty publisher.
    ///
    /// - Parameter completeImmediately: A Boolean value that indicates whether the publisher should immediately finish.
    public init(completeImmediately: Bool = true) {
        #if canImport(Combine)
        if #available(iOS 13, *) {
            observable = Combine.Empty<Output, Failure>(completeImmediately: completeImmediately)
                .eraseToAnyPublisher()
            return
        }
        #endif
        observable = completeImmediately
        ? Observable<Output>.empty()
        : Observable<Output>.never()
    }

    /// Creates an empty publisher with the given completion behavior and output and failure types.
    ///
    /// Use this initializer to connect the empty publisher to subscribers or other publishers that have specific output and failure types.
    /// - Parameters:
    ///   - completeImmediately: A Boolean value that indicates whether the publisher should immediately finish.
    ///   - outputType: The output type exposed by this publisher.
    ///   - failureType: The failure type exposed by this publisher.
    public init(completeImmediately: Bool = true, outputType: Output.Type, failureType: Failure.Type) {
        #if canImport(Combine)
        if #available(iOS 13, *) {
            observable = Combine.Empty<Output, Failure>(completeImmediately: completeImmediately,
                                                        outputType: outputType,
                                                        failureType: failureType)
                        .eraseToAnyPublisher()
            return
        }
        #endif
        observable = completeImmediately
        ? Observable<Output>.empty()
        : Observable<Output>.never()
    }
}
