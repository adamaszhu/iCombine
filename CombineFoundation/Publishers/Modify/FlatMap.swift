//
//  FlatMap.swift
//  CombineFoundation
//
//  Created by Leon Nguyen on 11/8/21.
//

import RxCocoa
import RxSwift
#if canImport(Combine)
import Combine
#endif

extension Publishers {

    public struct FlatMap<NewPublisher, Upstream> : Publisher where NewPublisher : Publisher, Upstream : Publisher, NewPublisher.Failure == Upstream.Failure {

        public let observable: Any

        /// The kind of values published by this publisher.
        public typealias Output = NewPublisher.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Upstream.Failure

        public init(upstream: Upstream,
                    maxPublishers: Subscribers.Demand,
                    transform: @escaping (Upstream.Output) -> NewPublisher) {
            #if canImport(Combine)
            if #available(iOS 14, macOS 10.15, *),
                let publisher = upstream.observable as? Combine.AnyPublisher<Upstream.Output, Failure> {
                observable = publisher.flatMap({ (output) -> Combine.AnyPublisher<NewPublisher.Output, Failure> in
                    let publisher = transform(output).observable as? Combine.AnyPublisher<NewPublisher.Output, Failure>
                    return publisher ?? Combine.Empty<NewPublisher.Output, Failure>().eraseToAnyPublisher()
                })
                .eraseToAnyPublisher()
                return
            }
            #endif
            if let upstreamObservable = upstream.observable as? Observable<Upstream.Output> {
                observable = upstreamObservable.flatMap { output -> Observable<NewPublisher.Output> in
                    let observable = transform(output).observable as? Observable<NewPublisher.Output>
                    return observable ?? Observable<NewPublisher.Output>.empty()
                }
            } else {
                fatalError("failed to init FlatMap")
            }
        }
    }
}

extension Publisher {

    /// Transforms all elements from an upstream publisher into a new or existing publisher.
    ///
    /// `flatMap` merges the output from all returned publishers into a single stream of output.
    ///
    /// - Parameters:
    ///   - maxPublishers: The maximum number of publishers produced by this method.
    ///   - transform: A closure that takes an element as a parameter and returns a publisher
    /// that produces elements of that type.
    /// - Returns: A publisher that transforms elements from an upstream publisher into
    /// a publisher of that element’s type.
    public func flatMap<T, P>(maxPublishers: Subscribers.Demand = .unlimited, _ transform: @escaping (Self.Output) -> P) -> Publishers.FlatMap<P, Self> where T == P.Output, P : Publisher, Self.Failure == P.Failure {
        return Publishers.FlatMap(upstream: self, maxPublishers: maxPublishers, transform: transform)
    }
}
