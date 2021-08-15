//
//  ReplaceError.swift
//  CombineFoundation
//
//  Created by Adamas Zhu on 15/8/21.
//

import RxSwift
import RxCocoa
#if canImport(Combine)
import Combine
#endif

extension Publishers {
    
    /// A publisher that replaces any errors in the stream with a provided element.
    public struct ReplaceError<Upstream> : Publisher where Upstream : Publisher {
        
        public let observable: Any
        
        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output
        
        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Never
        
        public init(upstream: Upstream, output: Publishers.ReplaceError<Upstream>.Output) {
            #if canImport(Combine)
            if #available(iOS 14, *),
                let publisher = upstream.observable as? Combine.AnyPublisher<Output, Upstream.Failure> {
                observable = Combine.Publishers.ReplaceError(upstream: publisher, output: output)
                    .eraseToAnyPublisher()
                return
            }
            #endif
            if let upstreamObservable = upstream.observable as? Observable<Upstream.Output> {
                observable = upstreamObservable.catchErrorJustReturn(output)
            } else {
                fatalError("failed to init ReplaceError")
            }
        }
    }
}


extension Publisher {

    /// Replaces any errors in the stream with the provided element.
    ///
    /// If the upstream publisher fails with an error, this publisher emits the provided element, then finishes normally.
    /// - Parameter output: An element to emit when the upstream publisher fails.
    /// - Returns: A publisher that replaces an error from the upstream publisher with the provided output element.
    public func replaceError(with output: Self.Output) -> Publishers.ReplaceError<Self> {
        return Publishers.ReplaceError(upstream: self, output: output)
    }
}
