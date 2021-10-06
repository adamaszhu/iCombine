//
//  Publisher.swift
//  iCombine
//
//  Created by Adamas Zhu on 5/8/21.
//

import Foundation
import OpenCombine
#if canImport(Combine)
import Combine
#endif

/// Declares that a type can transmit a sequence of values over time.
///
/// There are four kinds of messages:
///     subscription - A connection between `Publisher` and `Subscriber`.
///     value - An element in the sequence.
///     error - The sequence ended with an error (`.failure(e)`).
///     complete - The sequence ended successfully (`.finished`).
///
/// Both `.failure` and `.finished` are terminal messages.
///
/// You can summarize these possibilities with a regular expression:
///   value*(error|finished)?
///
/// Every `Publisher` must adhere to this contract.
public protocol Publisher {
    
    var observable: Any { get }
    
    /// The kind of values published by this publisher.
    associatedtype Output
    
    /// The kind of errors this publisher might publish.
    ///
    /// Use `Never` if this `Publisher` does not publish errors.
    associatedtype Failure : Error
    
    /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
    ///
    /// - SeeAlso: `subscribe(_:)`
    /// - Parameters:
    ///     - subscriber: The subscriber to attach to this `Publisher`.
    ///                   once attached it can begin to receive values.
    func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input
}

public extension Publisher {
    
    func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        #if canImport(Combine)
        if #available(iOS 14, macOS 10.15, *),
            let publisher = observable as? Combine.AnyPublisher<Output, Failure>,
            let subscriber = subscriber.observer as? Combine.AnySubscriber<Output, Failure> {
            publisher.subscribe(subscriber)
            return
        }
        #endif
        if let publisher = observable as? OpenCombine.AnyPublisher<Output, Failure>,
           let subscriber = subscriber.observer as? OpenCombine.AnySubscriber<Output, Failure> {
            publisher.subscribe(subscriber)
            return
        } else {
            fatalError("Failed to receive on Publisher")
        }
    }
}

extension Publisher {
    
    /// Attaches the specified subscriber to this publisher.
    ///
    /// Always call this function instead of `receive(subscriber:)`.
    /// Adopters of `Publisher` must implement `receive(subscriber:)`. The implementation of `subscribe(_:)` in this extension calls through to `receive(subscriber:)`.
    /// - SeeAlso: `receive(subscriber:)`
    /// - Parameters:
    ///     - subscriber: The subscriber to attach to this `Publisher`. After attaching, the subscriber can start to receive values.
    public func subscribe<S>(_ subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        receive(subscriber: subscriber)
    }

    /// Attaches a subscriber with closure-based behavior.
    ///
    /// This method creates the subscriber and immediately requests an unlimited number of values, prior to returning the subscriber.
    /// - parameter receiveComplete: The closure to execute on completion.
    /// - parameter receiveValue: The closure to execute on receipt of a value.
    /// - Returns: A cancellable instance; used when you end assignment of the received value. Deallocation of the result will tear down the subscription stream.
    public func sink(receiveCompletion: @escaping ((Subscribers.Completion<Self.Failure>) -> Void), receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable {
        let sink = Subscribers.Sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
        receive(subscriber: sink)
        return AnyCancellable(sink)
    }

    /// Specifies the scheduler on which to receive elements from the publisher.
    ///
    /// You use the `receive(on:options:)` operator to receive results on a specific scheduler, such as performing UI work on the main run loop.
    /// In contrast with `subscribe(on:options:)`, which affects upstream messages, `receive(on:options:)` changes the execution context of downstream messages. In the following example, requests to `jsonPublisher` are performed on `backgroundQueue`, but elements received from it are performed on `RunLoop.main`.
    ///
    ///     let jsonPublisher = MyJSONLoaderPublisher() // Some publisher.
    ///     let labelUpdater = MyLabelUpdateSubscriber() // Some subscriber that updates the UI.
    ///
    ///     jsonPublisher
    ///         .subscribe(on: backgroundQueue)
    ///         .receiveOn(on: RunLoop.main)
    ///         .subscribe(labelUpdater)
    ///
    /// - Parameters:
    ///   - scheduler: The scheduler the publisher is to use for element delivery.
    ///   - options: Scheduler options that customize the element delivery.
    /// - Returns: A publisher that delivers elements using the specified scheduler.
    public func receive<S>(on scheduler: S, options: S.CombineSchedulerOptions? = nil) -> Publishers.ReceiveOn<Self, S>
        where S : DispatchQueue
    {
        return Publishers.ReceiveOn(upstream: self, scheduler: scheduler, options: options)
    }
}
