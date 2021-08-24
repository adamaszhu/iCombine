//
//  PassthroughSubject.swift
//  CombineFoundation
//
//  Created by Adamas Zhu on 15/8/21.
//

import RxCocoa
import RxSwift
#if canImport(Combine)
import Combine
#endif

final public class PassthroughSubject<Output, Failure> : Subject where Failure : Error {

    public typealias Input = Output
    
    public let observable: Any
    
    public var observer: Any {
        #if canImport(Combine)
        if #available(iOS 14, macOS 10.15, *),
            let passthoughSubject = self.publishSubject as? Combine.PassthroughSubject<Output, Failure> {
                return Combine.AnySubscriber(passthoughSubject)
        }
        #endif
        if let publishSubject = self.publishSubject as? PublishSubject<Output> {
            return AnyObserver(publishSubject.asObserver())
        } else {
            fatalError("self.observable of PassthroughSubject has wrong type")
        }
    }
    
    private let publishSubject: Any

    public init() {
        #if canImport(Combine)
        if #available(iOS 14, macOS 10.15, *) {
            let passthoughSubject = Combine.PassthroughSubject<Output, Failure>()
            observable = passthoughSubject.eraseToAnyPublisher()
            publishSubject = passthoughSubject
            return
        }
        #endif
        let subject = PublishSubject<Output>()
        observable = subject.asObservable()
        publishSubject = subject
    }

    /// Provides this Subject an opportunity to establish demand for any new upstream subscriptions (say via, ```Publisher.subscribe<S: Subject>(_: Subject)`
    // final public func send(subscription: Subscription)

    /// Sends a value to the subscriber.
    ///
    /// - Parameter value: The value to send.
    final public func send(_ input: Output) {
        #if canImport(Combine)
        if #available(iOS 14, macOS 10.15, *),
                let passthoughSubject = self.publishSubject as? Combine.PassthroughSubject<Output, Failure> {
            passthoughSubject.send(input)
            return
        }
        #endif
        if let publishSubject = self.publishSubject as? PublishSubject<Output> {
            publishSubject.onNext(input)
        }
    }

    /// Sends a completion signal to the subscriber.
    ///
    /// - Parameter completion: A `Completion` instance which indicates whether publishing has finished normally or failed with an error.
    final public func send(completion: Subscribers.Completion<Failure>) {
        #if canImport(Combine)
        if #available(iOS 14, macOS 10.15, *),
                let passthoughSubject = self.publishSubject as? Combine.PassthroughSubject<Output, Failure> {
            switch completion {
            case .finished:
                passthoughSubject.send(completion: .finished)
            case .failure(let error):
                passthoughSubject.send(completion: .failure(error))
            }
            return
        }
        #endif
        if let publishSubject = self.publishSubject as? PublishSubject<Output> {
            switch completion {
            case .finished:
                publishSubject.onCompleted()
            case .failure(let error):
                publishSubject.onError(error)
            }
        }
    }
}
