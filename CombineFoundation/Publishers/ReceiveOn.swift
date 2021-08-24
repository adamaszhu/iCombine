//
//  ReceiveOn.swift
//  CombineFoundation
//
//  Created by Leon Nguyen on 5/8/21.
//

import RxCocoa
import RxSwift
#if canImport(Combine)
import Combine
#endif

extension Publishers {

    /// A publisher that delivers elements to its downstream subscriber on a specific scheduler.
    // TODO: at the moment, all of the Context are DispatchQueue but they are suposed to conform to Scheduler protocol
    // and CombineFoundation.Scheduler needs to be converted to Combine.Scheduler somehow
    public struct ReceiveOn<Upstream, Context> : Publisher where Upstream : Publisher, Context : DispatchQueue {

        public let observable: Any

        /// The kind of values published by this publisher.
        public typealias Output = Upstream.Output

        /// The kind of errors this publisher might publish.
        ///
        /// Use `Never` if this `Publisher` does not publish errors.
        public typealias Failure = Upstream.Failure

        public init(upstream: Upstream, scheduler: Context, options: Context.CombineSchedulerOptions?) {
            #if canImport(Combine)
            if #available(iOS 14, macOS 10.15, *),
                    let publisher = upstream.observable as? Combine.AnyPublisher<Upstream.Output, Upstream.Failure> {
                observable = Combine.Publishers.ReceiveOn(upstream: publisher, scheduler: scheduler, options: nil)
                                .eraseToAnyPublisher()
                return
            }
            #endif
            if let upstreamObservable = upstream.observable as? Observable<Upstream.Output> {
                observable = upstreamObservable.observeOn(scheduler.schedulerType)
            } else {
                fatalError("failed to init ReceiveOn")
            }
        }
    }
}
