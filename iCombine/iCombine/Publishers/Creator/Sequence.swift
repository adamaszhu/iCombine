//
//  Sequence.swift
//  iCombine
//
//  Created by Leon Nguyen on 8/8/21.
//

import OpenCombine
#if canImport(Combine)
import Combine
#endif

extension Publishers {

    /// A publisher that publishes a given sequence of elements.
    ///
    /// When the publisher exhausts the elements in the sequence, the next request causes the publisher to finish.
    public struct Sequence<Elements, Failure> : Publisher where Elements : Swift.Sequence, Failure : Error {

        public let observable: Any

        /// The kind of values published by this publisher.
        public typealias Output = Elements.Element

        /// Creates a publisher for a sequence of elements.
        ///
        /// - Parameter sequence: The sequence of elements to publish.
        public init(sequence: Elements) {
            #if canImport(Combine)
            if #available(iOS 14, macOS 10.15, *) {
                observable = Combine.Publishers.Sequence<Elements, Failure>(sequence: sequence)
                    .eraseToAnyPublisher()
                return
            }
            #endif
            observable = OpenCombine.Publishers.Sequence<Elements, Failure>(sequence: sequence)
                .eraseToAnyPublisher()
            return
        }

        fileprivate init(observable: Any) {
            self.observable = observable
        }
    }
}

extension Publishers.Sequence {

    // public func allSatisfy(_ predicate: (Publishers.Sequence<Elements, Failure>.Output) -> Bool) -> Result<Bool, Failure>.Publisher

    // public func tryAllSatisfy(_ predicate: (Publishers.Sequence<Elements, Failure>.Output) throws -> Bool) -> Result<Bool, Error>.Publisher

    // public func collect() -> Result<[Publishers.Sequence<Elements, Failure>.Output], Failure>.Publisher

    // public func compactMap<T>(_ transform: (Publishers.Sequence<Elements, Failure>.Output) -> T?) -> Publishers.Sequence<[T], Failure>

    // public func contains(where predicate: (Publishers.Sequence<Elements, Failure>.Output) -> Bool) -> Result<Bool, Failure>.Publisher

    // public func tryContains(where predicate: (Publishers.Sequence<Elements, Failure>.Output) throws -> Bool) -> Result<Bool, Error>.Publisher

    // public func drop(while predicate: (Elements.Element) -> Bool) -> Publishers.Sequence<DropWhileSequence<Elements>, Failure>

    // public func dropFirst(_ count: Int = 1) -> Publishers.Sequence<DropFirstSequence<Elements>, Failure>

    public func filter(_ isIncluded: @escaping (Publishers.Sequence<Elements, Failure>.Output) -> Bool) -> Publishers.Sequence<[Publishers.Sequence<Elements, Failure>.Output], Failure> {
        #if canImport(Combine)
        if #available(iOS 14, macOS 10.15, *),
            let publisher = observable as? Combine.AnyPublisher<Output, Failure>{
            let publisher = publisher.filter(isIncluded)
                .eraseToAnyPublisher()
            return Publishers.Sequence(observable: publisher)
        }
        #endif
        if let publisher = observable as? OpenCombine.AnyPublisher<Output, Failure>{
            let publisher = publisher.filter(isIncluded)
                .eraseToAnyPublisher()
            return Publishers.Sequence(observable: publisher)
        }
        fatalError("self.observable of Sequence filter has wrong type")
    }

    // public func ignoreOutput() -> Empty<Publishers.Sequence<Elements, Failure>.Output, Failure>

    public func map<T>(_ transform: @escaping (Elements.Element) -> T) -> Publishers.Sequence<[T], Failure> {
        #if canImport(Combine)
        if #available(iOS 14, macOS 10.15, *),
            let publisher = observable as? Combine.AnyPublisher<Output, Failure>{
            let publisher = publisher.map(transform)
                .eraseToAnyPublisher()
            return Publishers.Sequence(observable: publisher)
        }
        #endif
        if let publisher = observable as? OpenCombine.AnyPublisher<Output, Failure>{
            let publisher = publisher.map(transform)
                .eraseToAnyPublisher()
            return Publishers.Sequence(observable: publisher)
        }
        fatalError("self.observable of Sequence map has wrong type")
    }

    // public func prefix(_ maxLength: Int) -> Publishers.Sequence<PrefixSequence<Elements>, Failure>

    // public func prefix(while predicate: (Elements.Element) -> Bool) -> Publishers.Sequence<[Elements.Element], Failure>

    // public func reduce<T>(_ initialResult: T, _ nextPartialResult: @escaping (T, Publishers.Sequence<Elements, Failure>.Output) -> T) -> Result<T, Failure>.Publisher

    // public func tryReduce<T>(_ initialResult: T, _ nextPartialResult: @escaping (T, Publishers.Sequence<Elements, Failure>.Output) throws -> T) -> Result<T, Error>.Publisher

    // public func replaceNil<T>(with output: T) -> Publishers.Sequence<[Publishers.Sequence<Elements, Failure>.Output], Failure> where Elements.Element == T?

    // public func scan<T>(_ initialResult: T, _ nextPartialResult: @escaping (T, Publishers.Sequence<Elements, Failure>.Output) -> T) -> Publishers.Sequence<[T], Failure>

    // public func setFailureType<E>(to error: E.Type) -> Publishers.Sequence<Elements, E> where E : Error
}

extension Publishers.Sequence where Elements : RangeReplaceableCollection {

    public func prepend(_ elements: Publishers.Sequence<Elements, Failure>.Output...) -> Publishers.Sequence<Elements, Failure> {
        #if canImport(Combine)
        if #available(iOS 14, macOS 10.15, *),
            let publisher = observable as? Combine.AnyPublisher<Output, Failure>{

            let publisher = publisher.prepend(elements)
                .eraseToAnyPublisher()
            return Publishers.Sequence(observable: publisher)
        }
        #endif
        if let publisher = observable as? OpenCombine.AnyPublisher<Output, Failure>{

            let publisher = publisher.prepend(elements)
                .eraseToAnyPublisher()
            return Publishers.Sequence(observable: publisher)
        }
        fatalError("something of Sequence prepend has wrong type")
    }

    public func prepend<S>(_ elements: S) -> Publishers.Sequence<Elements, Failure> where S : Sequence, Elements.Element == S.Element {
        #if canImport(Combine)
        if #available(iOS 14, macOS 10.15, *),
            let publisher = observable as? Combine.AnyPublisher<Output, Failure>{
            let publisher = publisher.prepend(elements)
                .eraseToAnyPublisher()
            return Publishers.Sequence(observable: publisher)
        }
        #endif
        if let publisher = observable as? OpenCombine.AnyPublisher<Output, Failure> {
            let publisher = publisher.prepend(elements)
                .eraseToAnyPublisher()
            return Publishers.Sequence(observable: publisher)
        }
        fatalError("something of Sequence prepend has wrong type")
    }

    public func prepend(_ publisher: Publishers.Sequence<Elements, Failure>) -> Publishers.Sequence<Elements, Failure> {
        #if canImport(Combine)
        if #available(iOS 14, macOS 10.15, *),
            let internalPublisher = observable as? Combine.AnyPublisher<Output, Failure>,
            let toAppendPublisher = publisher.observable as? Combine.AnyPublisher<Output, Failure> {
            let appendedPublisher = internalPublisher.prepend(toAppendPublisher)
                .eraseToAnyPublisher()
            return Publishers.Sequence(observable: appendedPublisher)
        }
        #endif
        if let internalPublisher = observable as? OpenCombine.AnyPublisher<Output, Failure>,
            let toAppendPublisher = publisher.observable as? OpenCombine.AnyPublisher<Output, Failure> {
            let appendedPublisher = internalPublisher.prepend(toAppendPublisher)
                .eraseToAnyPublisher()
            return Publishers.Sequence(observable: appendedPublisher)
        }
        fatalError("something of Sequence prepend has wrong type")
    }

    public func append(_ elements: Publishers.Sequence<Elements, Failure>.Output...) -> Publishers.Sequence<Elements, Failure> {
        #if canImport(Combine)
        if #available(iOS 14, macOS 10.15, *),
            let publisher = observable as? Combine.AnyPublisher<Output, Failure>{

            let publisher = publisher.append(elements)
                .eraseToAnyPublisher()
            return Publishers.Sequence(observable: publisher)
        }
        #endif
        if let publisher = observable as? OpenCombine.AnyPublisher<Output, Failure>{

            let publisher = publisher.append(elements)
                .eraseToAnyPublisher()
            return Publishers.Sequence(observable: publisher)
        }
        fatalError("something of Sequence append has wrong type")
    }

    public func append<S>(_ elements: S) -> Publishers.Sequence<Elements, Failure> where S : Sequence, Elements.Element == S.Element {
        #if canImport(Combine)
        if #available(iOS 14, macOS 10.15, *),
            let publisher = observable as? Combine.AnyPublisher<Output, Failure>{
            let publisher = publisher.append(elements)
                .eraseToAnyPublisher()
            return Publishers.Sequence(observable: publisher)
        }
        #endif
        if let publisher = observable as? OpenCombine.AnyPublisher<Output, Failure> {
            let publisher = publisher.append(elements)
                .eraseToAnyPublisher()
            return Publishers.Sequence(observable: publisher)
        }
        fatalError("something of Sequence append has wrong type")
    }

    public func append(_ publisher: Publishers.Sequence<Elements, Failure>) -> Publishers.Sequence<Elements, Failure> {
        #if canImport(Combine)
        if #available(iOS 14, macOS 10.15, *),
            let internalPublisher = observable as? Combine.AnyPublisher<Output, Failure>,
            let toAppendPublisher = publisher.observable as? Combine.AnyPublisher<Output, Failure> {
            let appendedPublisher = internalPublisher.append(toAppendPublisher)
                .eraseToAnyPublisher()
            return Publishers.Sequence(observable: appendedPublisher)
        }
        #endif
        if let internalPublisher = observable as? OpenCombine.AnyPublisher<Output, Failure>,
            let toAppendPublisher = publisher.observable as? OpenCombine.AnyPublisher<Output, Failure> {
            let appendedPublisher = internalPublisher.append(toAppendPublisher)
                .eraseToAnyPublisher()
            return Publishers.Sequence(observable: appendedPublisher)
        }
        fatalError("something of Sequence append has wrong type")
    }
}

extension Publishers.Sequence where Elements.Element : Equatable {

    // public func removeDuplicates() -> Publishers.Sequence<[Publishers.Sequence<Elements, Failure>.Output], Failure>

    // public func contains(_ output: Elements.Element) -> Result<Bool, Failure>.Publisher
}

extension Sequence {

    public var publisher: Publishers.Sequence<Self, Never> {
        return Publishers.Sequence(sequence: self)
    }
}
