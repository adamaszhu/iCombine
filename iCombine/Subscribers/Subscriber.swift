//
//  Subscriber.swift
//  iCombine
//
//  Created by Adamas Zhu on 5/8/21.
//

import RxCocoa
import RxSwift
#if canImport(Combine)
import Combine
#endif

/// A protocol that declares a type that can receive input from a publisher.
public protocol Subscriber {
    
    var observer: Any { get }
    
    /// The kind of values this subscriber receives.
    associatedtype Input
    
    /// The kind of errors this subscriber might receive.
    ///
    /// Use `Never` if this `Subscriber` cannot receive errors.
    associatedtype Failure : Error
    
    /// Tells the subscriber that it has successfully subscribed to the publisher and may request items.
    ///
    /// Use the received `Subscription` to request items from the publisher.
    /// - Parameter subscription: A subscription that represents the connection between publisher and subscriber.
    // func receive(subscription: Subscription)
    
    /// Tells the subscriber that the publisher has produced an element.
    ///
    /// - Parameter input: The published element.
    /// - Returns: A `Demand` instance indicating how many more elements the subcriber expects to receive.
    // func receive(_ input: Self.Input) -> Subscribers.Demand
    
    /// Tells the subscriber that the publisher has completed publishing, either normally or with an error.
    ///
    /// - Parameter completion: A `Completion` case indicating whether publishing completed normally or with an error.
    func receive(completion: Subscribers.Completion<Self.Failure>)
}

extension Subscriber {
    
    public func receive(completion: Subscribers.Completion<Self.Failure>) {
        #if canImport(Combine)
        if #available(iOS 14, macOS 10.15, *),
           let subscriber = observer as? Combine.AnySubscriber<Input, Failure> {
            subscriber.receive(completion: completion.combineCompletion)
            return
        }
        #endif
        if let observer = observer as? AnyObserver<Input> {
            switch completion {
            case .finished:
                observer.onCompleted()
            case .failure(let error):
                observer.onError(error)
            }
        }
    }
}
