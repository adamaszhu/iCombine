//
//  Map.swift
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

    /// A publisher that transforms all elements from the upstream publisher with a provided closure.
    public struct Map<Upstream, Output> : Publisher where Upstream : Publisher {

        public let observable: Any

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Upstream.Failure

        public init(upstream: Upstream, transform: @escaping (Upstream.Output) -> Output) {
            #if canImport(Combine)
            if #available(iOS 14, *),
                let publisher = upstream.observable as? Combine.AnyPublisher<Upstream.Output, Failure> {
                observable = publisher.map(transform)
                    .eraseToAnyPublisher()
                return
            }
            #endif
            if let upstreamObservable = upstream.observable as? Observable<Upstream.Output> {
                observable = upstreamObservable
                    .map(transform)
            } else {
                fatalError("failed to init Map")
            }
        }

        fileprivate init(observable: Any) {
            self.observable = observable
        }
    }

    /// A publisher that transforms all elements from the upstream publisher with a provided error-throwing closure.
    public struct TryMap<Upstream, Output> : Publisher where Upstream : Publisher {

        public let observable: Any

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Error

        public init(upstream: Upstream, transform: @escaping (Upstream.Output) throws -> Output) {
            #if canImport(Combine)
            if #available(iOS 14, *),
                let publisher = upstream.observable as? Combine.AnyPublisher<Upstream.Output, Upstream.Failure> {
                observable = publisher.tryMap(transform)
                    .eraseToAnyPublisher()
                return
            }
            #endif
            if let upstreamObservable = upstream.observable as? Observable<Upstream.Output> {
                observable = upstreamObservable
                    .map(transform)
            } else {
                fatalError("failed to init TryMap")
            }
        }

        fileprivate init(observable: Any) {
            self.observable = observable
        }
    }
}

extension Publisher {

    /// Transforms all elements from the upstream publisher with a provided closure.
    ///
    /// - Parameter transform: A closure that takes one element as its parameter and returns a new element.
    /// - Returns: A publisher that uses the provided closure to map elements from the upstream publisher to new elements that it then publishes.
    public func map<T>(_ transform: @escaping (Self.Output) -> T) -> Publishers.Map<Self, T> {
        return Publishers.Map(upstream: self, transform: transform)
    }

    /// Transforms all elements from the upstream publisher with a provided error-throwing closure.
    ///
    /// If the `transform` closure throws an error, the publisher fails with the thrown error.
    /// - Parameter transform: A closure that takes one element as its parameter and returns a new element.
    /// - Returns: A publisher that uses the provided closure to map elements from the upstream publisher to new elements that it then publishes.
    public func tryMap<T>(_ transform: @escaping (Self.Output) throws -> T) -> Publishers.TryMap<Self, T> {
        return Publishers.TryMap(upstream: self, transform: transform)
    }
}

extension Publishers.Map {

    public func map<T>(_ transform: @escaping (Output) -> T) -> Publishers.Map<Upstream, T> {
        #if canImport(Combine)
        if #available(iOS 14, *), let publisher = self.observable as? Combine.AnyPublisher<Output, Failure> {
            let newPublisher = publisher.map(transform).eraseToAnyPublisher()
            return Publishers.Map(observable: newPublisher)
        }
        #endif
        if let localObservable = self.observable as? Observable<Output> {
            let newObservable = localObservable.map(transform)
            return Publishers.Map(observable: newObservable)
        } else {
            fatalError("failed to do Map.map")
        }
    }

    public func tryMap<T>(_ transform: @escaping (Output) throws -> T) -> Publishers.TryMap<Upstream, T> {
        #if canImport(Combine)
        if #available(iOS 14, *), let publisher = self.observable as? Combine.AnyPublisher<Output, Failure> {
            let newPublisher = publisher.tryMap(transform).eraseToAnyPublisher()
            return Publishers.TryMap(observable: newPublisher)
        }
        #endif
        if let localObservable = self.observable as? Observable<Output> {
            let newObservable = localObservable.map(transform)
            return Publishers.TryMap(observable: newObservable)
        } else {
            fatalError("failed to do Map.tryMap")
        }
    }
}

extension Publishers.TryMap {

    public func map<T>(_ transform: @escaping (Output) -> T) -> Publishers.TryMap<Upstream, T> {
        #if canImport(Combine)
        if #available(iOS 14, *), let publisher = self.observable as? Combine.AnyPublisher<Output, Failure> {
            let newPublisher = publisher.tryMap(transform).eraseToAnyPublisher()
            return Publishers.TryMap(observable: newPublisher)
        }
        #endif
        if let localObservable = self.observable as? Observable<Output> {
            let newObservable = localObservable.map(transform)
            return Publishers.TryMap(observable: newObservable)
        } else {
            fatalError("failed to do Map.tryMap")
        }
    }

    public func tryMap<T>(_ transform: @escaping (Output) throws -> T) -> Publishers.TryMap<Upstream, T> {
        #if canImport(Combine)
        if #available(iOS 14, *), let publisher = self.observable as? Combine.AnyPublisher<Output, Failure> {
            let newPublisher = publisher.tryMap(transform).eraseToAnyPublisher()
            return Publishers.TryMap(observable: newPublisher)
        }
        #endif
        if let localObservable = self.observable as? Observable<Output> {
            let newObservable = localObservable.map(transform)
            return Publishers.TryMap(observable: newObservable)
        } else {
            fatalError("failed to do Map.tryMap")
        }
    }
}
