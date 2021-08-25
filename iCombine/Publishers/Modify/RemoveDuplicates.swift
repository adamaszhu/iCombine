//
//  RemoveDuplicates.swift
//  iCombine
//
//  Created by Adamas Zhu on 15/8/21.
//

import RxSwift
import RxCocoa
#if canImport(Combine)
import Combine
#endif

extension Publishers {

    /// A publisher that publishes only elements that don’t match the previous element.
    public struct RemoveDuplicates<Upstream> : Publisher where Upstream : Publisher {
        
        public let observable: Any

        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Upstream.Failure

        /// The publisher from which this publisher receives elements.
        public let upstream: Upstream

        /// A closure to evaluate whether two elements are equivalent, for purposes of filtering.
        public let predicate: (Upstream.Output, Upstream.Output) -> Bool

        /// Creates a publisher that publishes only elements that don’t match the previous element, as evaluated by a provided closure.
        /// - Parameter upstream: The publisher from which this publisher receives elements.
        /// - Parameter predicate: A closure to evaluate whether two elements are equivalent, for purposes of filtering. Return `true` from this closure to indicate that the second element is a duplicate of the first.
        public init(upstream: Upstream,
                    predicate: @escaping (Publishers.RemoveDuplicates<Upstream>.Output, Publishers.RemoveDuplicates<Upstream>.Output) -> Bool) {
            self.upstream = upstream
            self.predicate = predicate
            #if canImport(Combine)
            if #available(iOS 14, macOS 10.15, *),
                let publisher = upstream.observable as? Combine.AnyPublisher<Upstream.Output, Failure> {
                observable = Combine.Publishers.RemoveDuplicates(upstream: publisher, predicate: predicate)
                    .eraseToAnyPublisher()
                return
            }
            #endif
            if let upstreamObservable = upstream.observable as? Observable<Upstream.Output> {
                observable = upstreamObservable.distinctUntilChanged(predicate)
            } else {
                fatalError("failed to init RemoveDuplicates")
            }
        }
    }

    /// A publisher that publishes only elements that don’t match the previous element, as evaluated by a provided error-throwing closure.
    public struct TryRemoveDuplicates<Upstream> : Publisher where Upstream : Publisher {

        public let observable: Any
        
        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Error

        /// The publisher from which this publisher receives elements.
        public let upstream: Upstream

        /// An error-throwing closure to evaluate whether two elements are equivalent, for purposes of filtering.
        public let predicate: (Upstream.Output, Upstream.Output) throws -> Bool

        /// Creates a publisher that publishes only elements that don’t match the previous element, as evaluated by a provided error-throwing closure.
        /// - Parameter upstream: The publisher from which this publisher receives elements.
        /// - Parameter predicate: An error-throwing closure to evaluate whether two elements are equivalent, for purposes of filtering. Return `true` from this closure to indicate that the second element is a duplicate of the first. If this closure throws an error, the publisher terminates with the thrown error.
        public init(upstream: Upstream,
                    predicate: @escaping (Publishers.TryRemoveDuplicates<Upstream>.Output, Publishers.TryRemoveDuplicates<Upstream>.Output) throws -> Bool) {
            self.upstream = upstream
            self.predicate = predicate
            #if canImport(Combine)
            if #available(iOS 14, macOS 10.15, *),
                let publisher = upstream.observable as? Combine.AnyPublisher<Upstream.Output, Upstream.Failure> {
                observable = Combine.Publishers.TryRemoveDuplicates(upstream: publisher, predicate: predicate)
                    .eraseToAnyPublisher()
                return
            }
            #endif
            if let upstreamObservable = upstream.observable as? Observable<Upstream.Output> {
                observable = upstreamObservable.distinctUntilChanged(predicate)
            } else {
                fatalError("failed to init TryRemoveDuplicates")
            }
        }
    }
}

extension Publisher where Self.Output : Equatable {

    /// Publishes only elements that don’t match the previous element.
    ///
    /// - Returns: A publisher that consumes — rather than publishes — duplicate elements.
    public func removeDuplicates() -> Publishers.RemoveDuplicates<Self> {
        return Publishers.RemoveDuplicates(upstream: self, predicate: { $0 == $1 })
    }
}

extension Publisher {

    /// Publishes only elements that don’t match the previous element, as evaluated by a provided closure.
    /// - Parameter predicate: A closure to evaluate whether two elements are equivalent, for purposes of filtering. Return `true` from this closure to indicate that the second element is a duplicate of the first.
    public func removeDuplicates(by predicate: @escaping (Self.Output, Self.Output) -> Bool) -> Publishers.RemoveDuplicates<Self> {
        return Publishers.RemoveDuplicates(upstream: self, predicate: predicate)
    }

    /// Publishes only elements that don’t match the previous element, as evaluated by a provided error-throwing closure.
    /// - Parameter predicate: A closure to evaluate whether two elements are equivalent, for purposes of filtering. Return `true` from this closure to indicate that the second element is a duplicate of the first. If this closure throws an error, the publisher terminates with the thrown error.
    public func tryRemoveDuplicates(by predicate: @escaping (Self.Output, Self.Output) throws -> Bool) -> Publishers.TryRemoveDuplicates<Self> {
        return Publishers.TryRemoveDuplicates(upstream: self, predicate: predicate)
    }
}
