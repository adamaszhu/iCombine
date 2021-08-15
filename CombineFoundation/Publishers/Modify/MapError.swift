//
//  MapError.swift
//  CombineFoundation
//
//  Created by Adamas Zhu on 15/8/21.
//

import RxCocoa
import RxSwift
#if canImport(Combine)
import Combine
#endif

extension Publishers {
    
    /// A publisher that converts any failure from the upstream publisher into a new error.
    public struct MapError<Upstream, Failure> : Publisher where Upstream : Publisher, Failure : Error {
        
        public let observable: Any
        
        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output
        
        public init(upstream: Upstream, transform: @escaping (Upstream.Failure) -> Failure) {
            #if canImport(Combine)
            if #available(iOS 14, *),
                    let publisher = upstream.observable as? Combine.AnyPublisher<Upstream.Output, Upstream.Failure> {
                observable = Combine.Publishers.MapError(upstream: publisher, transform: transform)
                                .eraseToAnyPublisher()
                return
            }
            #endif
            if let upstreamObservable = upstream.observable as? Observable<Upstream.Output> {
                observable = upstreamObservable
                    .catchError { error in
                        if let error = error as? Upstream.Failure {
                            throw transform(error)
                        } else {
                            throw error
                        }
                }
            } else {
                fatalError("failed to init MapError")
            }
        }
        
        public init(upstream: Upstream, _ map: @escaping (Upstream.Failure) -> Failure) {
            self.init(upstream: upstream, transform: map)
        }
    }
}

extension Publisher {
    
    /// Converts any failure from the upstream publisher into a new error.
    ///
    /// Until the upstream publisher finishes normally or fails with an error, the returned publisher republishes all the elements it receives.
    ///
    /// - Parameter transform: A closure that takes the upstream failure as a parameter and returns a new error for the publisher to terminate with.
    /// - Returns: A publisher that replaces any upstream failure with a new error produced by the `transform` closure.
    public func mapError<E>(_ transform: @escaping (Self.Failure) -> E) -> Publishers.MapError<Self, E> where E : Error {
        return Publishers.MapError<Self, E>(upstream: self, transform: transform)
    }
}
