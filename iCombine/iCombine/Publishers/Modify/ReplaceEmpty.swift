//
//  ReplaceEmpty.swift
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

    /// A publisher that replaces an empty stream with a provided element.
    public struct ReplaceEmpty<Upstream> : Publisher where Upstream : Publisher {
        
        public let observable: Any
        
        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Upstream.Failure

        public init(upstream: Upstream, output: Publishers.ReplaceEmpty<Upstream>.Output) {
            #if canImport(Combine)
            if #available(iOS 14, macOS 10.15, *),
                let publisher = upstream.observable as? Combine.AnyPublisher<Output, Failure> {
                observable = Combine.Publishers.ReplaceEmpty(upstream: publisher, output: output)
                    .eraseToAnyPublisher()
                return
            }
            #endif
            if let upstreamObservable = upstream.observable as? Observable<Upstream.Output> {
                observable = upstreamObservable.ifEmpty(default: output)
            } else {
                fatalError("failed to init ReplaceEmpty")
            }
        }
    }
}


extension Publisher {

    /// Replaces an empty stream with the provided element.
    ///
    /// If the upstream publisher finishes without producing any elements, this publisher emits the provided element, then finishes normally.
    /// - Parameter output: An element to emit when the upstream publisher finishes without emitting any elements.
    /// - Returns: A publisher that replaces an empty stream with the provided output element.
    public func replaceEmpty(with output: Self.Output) -> Publishers.ReplaceEmpty<Self> {
        return Publishers.ReplaceEmpty(upstream: self, output: output)
    }
}
