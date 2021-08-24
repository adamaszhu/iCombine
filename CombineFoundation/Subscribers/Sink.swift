//
//  Sink.swift
//  CombineFoundation
//
//  Created by Leon Nguyen on 5/8/21.
//

import RxCocoa
import RxSwift
#if canImport(Combine)
import Combine
#endif

extension Subscribers {

    /// A simple subscriber that requests an unlimited number of values upon subscription.
    final public class Sink<Input, Failure> : Subscriber, Cancellable where Failure : Error {

        public var disposable: Any?
        public let observer: Any

        /// The closure to execute on receipt of a value.
        //final public let receiveValue: (Input) -> Void

        /// The closure to execute on completion.
        //final public let receiveCompletion: (Subscribers.Completion<Failure>) -> Void

        /// Initializes a sink with the provided closures.
        ///
        /// - Parameters:
        ///   - receiveCompletion: The closure to execute on completion.
        ///   - receiveValue: The closure to execute on receipt of a value.
        public init(receiveCompletion: @escaping ((Subscribers.Completion<Failure>) -> Void), receiveValue: @escaping ((Input) -> Void)) {
            #if canImport(Combine)
            if #available(iOS 14, macOS 10.15, *) {
                let observer = Combine.Subscribers.Sink<Input, Failure>(receiveCompletion: { (completion) in
                    switch completion {
                    case .finished:
                        receiveCompletion(.finished)
                    case .failure(let error):
                        receiveCompletion(.failure(error))
                    }
                }) { (value) in
                    receiveValue(value)
                }
                self.observer = Combine.AnySubscriber(observer)
                return
            }
            #endif
            self.observer = AnyObserver<Input> { event in
                switch event {
                case .completed:
                    receiveCompletion(.finished)
                case .error(let error):
                    if let error = error as? Failure {
                        receiveCompletion(.failure(error))
                    }
                case .next(let value):
                    receiveValue(value)
                }
            }
        }

        /// Tells the subscriber that it has successfully subscribed to the publisher and may request items.
        ///
        /// Use the received `Subscription` to request items from the publisher.
        /// - Parameter subscription: A subscription that represents the connection between publisher and subscriber.
        // final public func receive(subscription: Subscription)

        /// Tells the subscriber that the publisher has produced an element.
        ///
        /// - Parameter input: The published element.
        /// - Returns: A `Demand` instance indicating how many more elements the subcriber expects to receive.
        // final public func receive(_ value: Input) -> Subscribers.Demand

        /// Cancel the activity.
        final public func cancel() {
            #if canImport(Combine)
            if #available(iOS 14, macOS 10.15, *),
               let cancellable = disposable as? Combine.Cancellable {
                cancellable.cancel()
                return
            }
            #endif
            if let disposable = disposable as? Disposable {
                disposable.dispose()
            }
        }
    }
}
