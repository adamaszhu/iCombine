//
//  HandleEvents.swift
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
    
    /// A publisher that performs the specified closures when publisher events occur.
    public struct HandleEvents<Upstream> : Publisher where Upstream : Publisher {
        
        public let observable: Any
        
        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output
        
        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Upstream.Failure
        
        public init(upstream: Upstream,
                    receiveSubscription: ((Subscription) -> Void)? = nil,
                    receiveOutput: ((Publishers.HandleEvents<Upstream>.Output) -> Void)? = nil,
                    receiveCompletion: ((Subscribers.Completion<Publishers.HandleEvents<Upstream>.Failure>) -> Void)? = nil,
                    receiveCancel: (() -> Void)? = nil, receiveRequest: ((Subscribers.Demand) -> Void)?) {
            #if canImport(Combine)
            if #available(iOS 14, macOS 10.15, *),
                    let publisher = upstream.observable as? Combine.AnyPublisher<Upstream.Output, Upstream.Failure> {
                observable = Combine.Publishers
                .HandleEvents(upstream: publisher,
                receiveSubscription: { subcription in
                    // TODO: Something to consider for future release
                },receiveOutput: { (value) in
                    receiveOutput?(value)
                }, receiveCompletion: { completion in
                    receiveCompletion?(.init(combineCompletion: completion))
                }, receiveCancel: receiveCancel, receiveRequest: { (demand) in
                    // TODO: Something to consider for future release
                }).eraseToAnyPublisher()
                return
            }
            #endif
            if let upstreamObservable = upstream.observable as? Observable<Upstream.Output> {
                observable = upstreamObservable
                .do(onNext: { receiveOutput?($0) },
                    onError: { error in
                        if let error = error as? Upstream.Failure {
                            receiveCompletion?(.failure(error))
                        }
                },
                    onCompleted: { receiveCompletion?(.finished) },
                    onDispose: { receiveCancel?() })
            } else {
                fatalError("failed to init HandleEvents")
            }
        }
    }
}

extension Publisher {
    
    /// Performs the specified closures when publisher events occur.
    ///
    /// - Parameters:
    ///   - receiveSubscription: A closure that executes when the publisher receives the  subscription from the upstream publisher. Defaults to `nil`.
    ///   - receiveOutput: A closure that executes when the publisher receives a value from the upstream publisher. Defaults to `nil`.
    ///   - receiveCompletion: A closure that executes when the publisher receives the completion from the upstream publisher. Defaults to `nil`.
    ///   - receiveCancel: A closure that executes when the downstream receiver cancels publishing. Defaults to `nil`.
    ///   - receiveRequest: A closure that executes when the publisher receives a request for more elements. Defaults to `nil`.
    /// - Returns: A publisher that performs the specified closures when publisher events occur.
    public func handleEvents(receiveSubscription: ((Subscription) -> Void)? = nil, receiveOutput: ((Self.Output) -> Void)? = nil, receiveCompletion: ((Subscribers.Completion<Self.Failure>) -> Void)? = nil, receiveCancel: (() -> Void)? = nil, receiveRequest: ((Subscribers.Demand) -> Void)? = nil) -> Publishers.HandleEvents<Self> {
        return Publishers.HandleEvents(upstream: self, receiveSubscription: receiveSubscription, receiveOutput: receiveOutput, receiveCompletion: receiveCompletion, receiveCancel: receiveCancel, receiveRequest: receiveRequest)
    }
}
