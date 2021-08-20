//
//  CurrentValueSubject.swift
//  CombineFoundation
//
//  Created by Leon Nguyen on 8/8/21.
//

import RxCocoa
import RxSwift
#if canImport(Combine)
import Combine
#endif

/// A subject that wraps a single value and publishes a new element whenever the value changes.
final public class CurrentValueSubject<Output, Failure> : Subject where Failure : Error {

    public typealias Input = Output

    public let observable: Any

    private let behaviourSubject: Any
    private let initialValue: Output

    /// The value wrapped by this subject, published as a new element whenever it changes.
    final public var value: Output {
        get {
            #if canImport(Combine)
            if #available(iOS 14, *),
                let currentValueSubject = self.behaviourSubject as? Combine.CurrentValueSubject<Output, Failure> {
                    return currentValueSubject.value
            }
            #endif
            if let publishSubject = self.behaviourSubject as? BehaviorSubject<Output> {
                let currentValue = try? publishSubject.value()
                return currentValue ?? initialValue
            } else {
                fatalError("behaviourSubject of CurrentValueSubject has wrong type")
            }
        }
        set {
            #if canImport(Combine)
            if #available(iOS 14, *),
                let currentValueSubject = self.behaviourSubject as? Combine.CurrentValueSubject<Output, Failure> {
                    currentValueSubject.value = newValue
                return
            }
            #endif
            if let publishSubject = self.behaviourSubject as? BehaviorSubject<Output> {
                publishSubject.onNext(newValue)
            } else {
                fatalError("behaviourSubject of CurrentValueSubject has wrong type")
            }
        }
    }

    /// Creates a current value subject with the given initial value.
    ///
    /// - Parameter value: The initial value to publish.
    public init(_ value: Output) {
        #if canImport(Combine)
        if #available(iOS 14, *) {
            let currentValueSubject = Combine.CurrentValueSubject<Output, Failure>(value)
            observable = currentValueSubject.eraseToAnyPublisher()
            behaviourSubject = currentValueSubject
            initialValue = value
            return
        }
        #endif
        let newSubject = BehaviorSubject(value: value)
        observable = newSubject.asObservable()
        behaviourSubject = newSubject
        initialValue = value
    }

    /// Provides this Subject an opportunity to establish demand for any new upstream subscriptions (say via, ```Publisher.subscribe<S: Subject>(_: Subject)`
    // final public func send(subscription: Subscription)

    /// Sends a value to the subscriber.
    ///
    /// - Parameter value: The value to send.
    final public func send(_ input: Output) {
        #if canImport(Combine)
        if #available(iOS 14, *),
            let currentValueSubject = self.behaviourSubject as? Combine.CurrentValueSubject<Output, Failure> {
                return currentValueSubject.send(input)
        }
        #endif
        if let behaviourSubject = self.behaviourSubject as? BehaviorSubject<Output> {
            behaviourSubject.onNext(input)
        } else {
            fatalError("behaviourSubject of CurrentValueSubject has wrong type")
        }
    }

    /// Sends a completion signal to the subscriber.
    ///
    /// - Parameter completion: A `Completion` instance which indicates whether publishing has finished normally or failed with an error.
    final public func send(completion: Subscribers.Completion<Failure>) {
        #if canImport(Combine)
        if #available(iOS 14, *),
            let currentValueSubject = self.behaviourSubject as? Combine.CurrentValueSubject<Output, Failure> {
                switch completion {
                case .finished:
                    currentValueSubject.send(completion: .finished)
                case .failure(let error):
                    currentValueSubject.send(completion: .failure(error))
                }
            return
        }
        #endif
        if let behaviourSubject = self.behaviourSubject as? BehaviorSubject<Output> {
            switch completion {
            case .failure(let error):
                behaviourSubject.onError(error)
            case .finished:
                behaviourSubject.onCompleted()
            }
        } else {
            fatalError("behaviourSubject of CurrentValueSubject has wrong type")
        }
    }
}
