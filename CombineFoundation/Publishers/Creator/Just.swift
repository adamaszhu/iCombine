//
//  Just.swift
//  CombineFoundation
//
//  Created by Leon Nguyen on 5/8/21.
//

import RxCocoa
import RxSwift
#if canImport(Combine)
import Combine
#endif

/// A publisher that emits an output to each subscriber just once, and then finishes.
///
/// You can use a `Just` publisher to start a chain of publishers. A `Just` publisher is also useful when replacing a value with `Catch`.
///
/// In contrast with `Publishers.Once`, a `Just` publisher cannot fail with an error.
public struct Just<Output> : Publisher {

    public let observable: Any

    /// The kind of errors this publisher might publish.
    ///
    /// Use `Never` if this `Publisher` does not publish errors.
    public typealias Failure = Never

    /// Initializes a publisher that emits the specified output just once.
    ///
    /// - Parameter output: The one element that the publisher emits.
    public init(_ output: Output) {
        #if canImport(Combine)
        if #available(iOS 13, *) {
            observable = Combine.Just<Output>(output)
                .eraseToAnyPublisher()
            return
        }
        #endif
        observable = Observable.of(output)
    }

    fileprivate init(observable: Any) {
        self.observable = observable
    }
}

extension Just {

    // public func allSatisfy(_ predicate: (Output) -> Bool) -> Just<Bool>

    // public func tryAllSatisfy(_ predicate: (Output) throws -> Bool) -> Result<Bool, Error>.Publisher

    // public func collect() -> Just<[Output]>

    // public func compactMap<T>(_ transform: (Output) -> T?) -> Optional<T>.Publisher

    // public func min(by areInIncreasingOrder: (Output, Output) -> Bool) -> Just<Output>

    // public func max(by areInIncreasingOrder: (Output, Output) -> Bool) -> Just<Output>

    // public func prepend(_ elements: Output...) -> Publishers.Sequence<[Output], Just<Output>.Failure>

    // public func prepend<S>(_ elements: S) -> Publishers.Sequence<[Output], Just<Output>.Failure> where Output == S.Element, S : Sequence

    // public func append(_ elements: Output...) -> Publishers.Sequence<[Output], Just<Output>.Failure>

    // public func append<S>(_ elements: S) -> Publishers.Sequence<[Output], Just<Output>.Failure> where Output == S.Element, S : Sequence

    // public func contains(where predicate: (Output) -> Bool) -> Just<Bool>

    // public func tryContains(where predicate: (Output) throws -> Bool) -> Result<Bool, Error>.Publisher

    // public func count() -> Just<Int>

    // public func dropFirst(_ count: Int = 1) -> Optional<Output>.Publisher

    // public func drop(while predicate: (Output) -> Bool) -> Optional<Output>.Publisher

    public func first() -> Just<Output> {
        return self
    }

    // public func first(where predicate: (Output) -> Bool) -> Optional<Output>.Publisher

    public func last() -> Just<Output> {
        return self
    }

    // public func last(where predicate: (Output) -> Bool) -> Optional<Output>.Publisher

    // public func filter(_ isIncluded: (Output) -> Bool) -> Optional<Output>.Publisher

    // public func ignoreOutput() -> Empty<Output, Just<Output>.Failure>

    public func map<T>(_ transform: @escaping (Output) -> T) -> Just<T> {
        #if canImport(Combine)
        if #available(iOS 13, *),
            let publisher = observable as? Combine.AnyPublisher<Output, Failure>{
            let publisher = publisher.map(transform).eraseToAnyPublisher()
            return Just<T>(observable: publisher)
        }
        #endif
        if let observable = self.observable as? Observable<Output> {
            let transformedObservable = observable.map(transform)
            return Just<T>(observable: transformedObservable)
        } else {
            fatalError("self.observable of Just has wrong type")
        }
    }

    // public func tryMap<T>(_ transform: (Output) throws -> T) -> Result<T, Error>.Publisher

    // public func mapError<E>(_ transform: (Just<Output>.Failure) -> E) -> Result<Output, E>.Publisher where E : Error

    // public func output(at index: Int) -> Optional<Output>.Publisher

    // public func output<R>(in range: R) -> Optional<Output>.Publisher where R : RangeExpression, R.Bound == Int

    // public func prefix(_ maxLength: Int) -> Optional<Output>.Publisher

    // public func prefix(while predicate: (Output) -> Bool) -> Optional<Output>.Publisher

    // public func reduce<T>(_ initialResult: T, _ nextPartialResult: (T, Output) -> T) -> Result<T, Just<Output>.Failure>.Publisher

    // public func tryReduce<T>(_ initialResult: T, _ nextPartialResult: (T, Output) throws -> T) -> Result<T, Error>.Publisher

    // public func removeDuplicates(by predicate: (Output, Output) -> Bool) -> Just<Output>

    // public func tryRemoveDuplicates(by predicate: (Output, Output) throws -> Bool) -> Result<Output, Error>.Publisher

    // public func replaceError(with output: Output) -> Just<Output>

    // public func replaceEmpty(with output: Output) -> Just<Output>

    // public func retry(_ times: Int) -> Just<Output>

    // public func scan<T>(_ initialResult: T, _ nextPartialResult: (T, Output) -> T) -> Result<T, Just<Output>.Failure>.Publisher

    // public func tryScan<T>(_ initialResult: T, _ nextPartialResult: (T, Output) throws -> T) -> Result<T, Error>.Publisher

    // public func setFailureType<E>(to failureType: E.Type) -> Result<Output, E>.Publisher where E : Error
}

extension Just where Output : Equatable {

    // public func contains(_ output: Output) -> Just<Bool>

    public func removeDuplicates() -> Just<Output> {
        return self
    }
}
