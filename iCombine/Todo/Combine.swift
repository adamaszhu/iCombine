//
//  Combine.swift
//  iCombine
//
//  Created by Adamas Zhu on 16/8/21.
//

//import Darwin
//
//extension AnyCancellable {
//
//    /// Stores this AnyCancellable in the specified collection.
//    /// Parameters:
//    ///    - collection: The collection to store this AnyCancellable.
//    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//    final public func store<C>(in collection: inout C) where C : RangeReplaceableCollection, C.Element == AnyCancellable
//
//    /// Stores this AnyCancellable in the specified set.
//    /// Parameters:
//    ///    - collection: The set to store this AnyCancellable.
//    final public func store(in set: inout Set<AnyCancellable>)
//}
//
//extension Cancellable {
//
//    /// Stores this Cancellable in the specified collection.
//    /// Parameters:
//    ///    - collection: The collection to store this Cancellable.
//    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//    public func store<C>(in collection: inout C) where C : RangeReplaceableCollection, C.Element == AnyCancellable
//
//    /// Stores this Cancellable in the specified set.
//    /// Parameters:
//    ///    - collection: The set to store this Cancellable.
//    public func store(in set: inout Set<AnyCancellable>)
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//public struct CombineIdentifier : Hashable, CustomStringConvertible {
//
//    public init()
//
//    public init(_ obj: AnyObject)
//
//    /// A textual representation of this instance.
//    ///
//    /// Calling this property directly is discouraged. Instead, convert an
//    /// instance of any type to a string by using the `String(describing:)`
//    /// initializer. This initializer works with any type, and uses the custom
//    /// `description` property for types that conform to
//    /// `CustomStringConvertible`:
//    ///
//    ///     struct Point: CustomStringConvertible {
//    ///         let x: Int, y: Int
//    ///
//    ///         var description: String {
//    ///             return "(\(x), \(y))"
//    ///         }
//    ///     }
//    ///
//    ///     let p = Point(x: 21, y: 30)
//    ///     let s = String(describing: p)
//    ///     print(s)
//    ///     // Prints "(21, 30)"
//    ///
//    /// The conversion of `p` to a string in the assignment to `s` uses the
//    /// `Point` type's `description` property.
//    public var description: String { get }
//
//    /// The hash value.
//    ///
//    /// Hash values are not guaranteed to be equal across different executions of
//    /// your program. Do not save hash values to use during a future execution.
//    ///
//    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
//    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
//    public var hashValue: Int { get }
//
//    /// Hashes the essential components of this value by feeding them into the
//    /// given hasher.
//    ///
//    /// Implement this method to conform to the `Hashable` protocol. The
//    /// components used for hashing must be the same as the components compared
//    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
//    /// with each of these components.
//    ///
//    /// - Important: Never call `finalize()` on `hasher`. Doing so may become a
//    ///   compile-time error in the future.
//    ///
//    /// - Parameter hasher: The hasher to use when combining the components
//    ///   of this instance.
//    public func hash(into hasher: inout Hasher)
//
//    /// Returns a Boolean value indicating whether two values are equal.
//    ///
//    /// Equality is the inverse of inequality. For any values `a` and `b`,
//    /// `a == b` implies that `a != b` is `false`.
//    ///
//    /// - Parameters:
//    ///   - lhs: A value to compare.
//    ///   - rhs: Another value to compare.
//    public static func == (a: CombineIdentifier, b: CombineIdentifier) -> Bool
//}
//
///// A publisher that provides an explicit means of connecting and canceling publication.
/////
///// Use `makeConnectable()` to create a `ConnectablePublisher` from any publisher whose failure type is `Never`.
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//public protocol ConnectablePublisher : Publisher {
//
//    /// Connects to the publisher and returns a `Cancellable` instance with which to cancel publishing.
//    ///
//    /// - Returns: A `Cancellable` instance that can be used to cancel publishing.
//    func connect() -> Cancellable
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension ConnectablePublisher {
//
//    /// Automates the process of connecting or disconnecting from this connectable publisher.
//    ///
//    /// Use `autoconnect()` to simplify working with `ConnectablePublisher` instances, such as those created with `makeConnectable()`.
//    ///
//    ///     let autoconnectedPublisher = somePublisher
//    ///         .makeConnectable()
//    ///         .autoconnect()
//    ///         .subscribe(someSubscriber)
//    ///
//    /// - Returns: A publisher which automatically connects to its upstream connectable publisher.
//    public func autoconnect() -> Publishers.Autoconnect<Self>
//}
//
///// A publisher that awaits subscription before running the supplied closure to create a publisher for the new subscriber.
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//public struct Deferred<DeferredPublisher> : Publisher where DeferredPublisher : Publisher {
//
//    /// The kind of values published by this publisher.
//    public typealias Output = DeferredPublisher.Output
//
//    /// The kind of errors this publisher might publish.
//    ///
//    /// Use `Never` if this `Publisher` does not publish errors.
//    public typealias Failure = DeferredPublisher.Failure
//
//    /// The closure to execute when it receives a subscription.
//    ///
//    /// The publisher returned by this closure immediately receives the incoming subscription.
//    public let createPublisher: () -> DeferredPublisher
//
//    /// Creates a deferred publisher.
//    ///
//    /// - Parameter createPublisher: The closure to execute when calling `subscribe(_:)`.
//    public init(createPublisher: @escaping () -> DeferredPublisher)
//
//    /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//    ///
//    /// - SeeAlso: `subscribe(_:)`
//    /// - Parameters:
//    ///     - subscriber: The subscriber to attach to this `Publisher`.
//    ///                   once attached it can begin to receive values.
//    public func receive<S>(subscriber: S) where S : Subscriber, DeferredPublisher.Failure == S.Failure, DeferredPublisher.Output == S.Input
//}
//
///// A publisher that eventually produces one value and then finishes or fails.
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//final public class Future<Output, Failure> : Publisher where Failure : Error {
//
//    public typealias Promise = (Result<Output, Failure>) -> Void
//
//    public init(_ attemptToFulfill: @escaping (@escaping Future<Output, Failure>.Promise) -> Void)
//
//    /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//    ///
//    /// - SeeAlso: `subscribe(_:)`
//    /// - Parameters:
//    ///     - subscriber: The subscriber to attach to this `Publisher`.
//    ///                   once attached it can begin to receive values.
//    final public func receive<S>(subscriber: S) where Output == S.Input, Failure == S.Failure, S : Subscriber
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Just : Equatable where Output : Equatable {
//
//    /// Returns a Boolean value indicating whether two values are equal.
//    ///
//    /// Equality is the inverse of inequality. For any values `a` and `b`,
//    /// `a == b` implies that `a != b` is `false`.
//    ///
//    /// - Parameters:
//    ///   - lhs: A value to compare.
//    ///   - rhs: Another value to compare.
//    public static func == (lhs: Just<Output>, rhs: Just<Output>) -> Bool
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Just where Output : Comparable {
//
//    public func min() -> Just<Output>
//
//    public func max() -> Just<Output>
//}
//
///// A type of object with a publisher that emits before the object has changed.
/////
///// By default an `ObservableObject` will synthesize an `objectWillChange`
///// publisher that emits before any of its `@Published` properties changes:
/////
/////     class Contact: ObservableObject {
/////         @Published var name: String
/////         @Published var age: Int
/////
/////         init(name: String, age: Int) {
/////             self.name = name
/////             self.age = age
/////         }
/////
/////         func haveBirthday() -> Int {
/////             age += 1
/////             return age
/////         }
/////     }
/////
/////     let john = Contact(name: "John Appleseed", age: 24)
/////     john.objectWillChange.sink { _ in print("\(john.age) will change") }
/////     print(john.haveBirthday())
/////     // Prints "24 will change"
/////     // Prints "25"
/////
//@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
//public protocol ObservableObject : AnyObject {
//
//    /// The type of publisher that emits before the object has changed.
//    associatedtype ObjectWillChangePublisher : Publisher = ObservableObjectPublisher where Self.ObjectWillChangePublisher.Failure == Never
//
//    /// A publisher that emits before the object has changed.
//    var objectWillChange: Self.ObjectWillChangePublisher { get }
//}
//
//@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
//extension ObservableObject where Self.ObjectWillChangePublisher == ObservableObjectPublisher {
//
//    /// A publisher that emits before the object has changed.
//    public var objectWillChange: ObservableObjectPublisher { get }
//}
//
///// The default publisher of an `ObservableObject`.
//@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
//final public class ObservableObjectPublisher : Publisher {
//
//    /// The kind of values published by this publisher.
//    public typealias Output = Void
//
//    /// The kind of errors this publisher might publish.
//    ///
//    /// Use `Never` if this `Publisher` does not publish errors.
//    public typealias Failure = Never
//
//    public init()
//
//    /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//    ///
//    /// - SeeAlso: `subscribe(_:)`
//    /// - Parameters:
//    ///     - subscriber: The subscriber to attach to this `Publisher`.
//    ///                   once attached it can begin to receive values.
//    final public func receive<S>(subscriber: S) where S : Subscriber, S.Failure == ObservableObjectPublisher.Failure, S.Input == ObservableObjectPublisher.Output
//
//    final public func send()
//}
//
///// Adds a `Publisher` to a property.
/////
///// Properties annotated with `@Published` contain both the stored value and a publisher which sends any new values after the property value has been sent. New subscribers will receive the current value of the property first.
///// Note that the `@Published` property is class-constrained. Use it with properties of classes, not with non-class types like structures.
//@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
//@propertyWrapper public struct Published<Value> {
//
//    /// Initialize the storage of the Published property as well as the corresponding `Publisher`.
//    public init(initialValue: Value)
//
//    /// A publisher for properties marked with the `@Published` attribute.
//    public struct Publisher : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Value
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Never
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where Value == S.Input, S : Subscriber, S.Failure == Published<Value>.Publisher.Failure
//    }
//
//    /// The property that can be accessed with the `$` syntax and allows access to the `Publisher`
//    public var projectedValue: Published<Value>.Publisher { mutating get }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Applies a closure to create a subject that delivers elements to subscribers.
//    ///
//    /// Use a multicast publisher when you have multiple downstream subscribers, but you want upstream publishers to only process one `receive(_:)` call per event.
//    /// In contrast with `multicast(subject:)`, this method produces a publisher that creates a separate Subject for each subscriber.
//    /// - Parameter createSubject: A closure to create a new Subject each time a subscriber attaches to the multicast publisher.
//    public func multicast<S>(_ createSubject: @escaping () -> S) -> Publishers.Multicast<Self, S> where S : Subject, Self.Failure == S.Failure, Self.Output == S.Output
//
//    /// Provides a subject to deliver elements to multiple subscribers.
//    ///
//    /// Use a multicast publisher when you have multiple downstream subscribers, but you want upstream publishers to only process one `receive(_:)` call per event.
//    /// In contrast with `multicast(_:)`, this method produces a publisher shares the provided Subject among all the downstream subscribers.
//    /// - Parameter subject: A subject to deliver elements to downstream subscribers.
//    public func multicast<S>(subject: S) -> Publishers.Multicast<Self, S> where S : Subject, Self.Failure == S.Failure, Self.Output == S.Output
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Specifies the scheduler on which to perform subscribe, cancel, and request operations.
//    ///
//    /// In contrast with `receive(on:options:)`, which affects downstream messages, `subscribe(on:)` changes the execution context of upstream messages. In the following example, requests to `jsonPublisher` are performed on `backgroundQueue`, but elements received from it are performed on `RunLoop.main`.
//    ///
//    ///     let ioPerformingPublisher == // Some publisher.
//    ///     let uiUpdatingSubscriber == // Some subscriber that updates the UI.
//    ///
//    ///     ioPerformingPublisher
//    ///         .subscribe(on: backgroundQueue)
//    ///         .receiveOn(on: RunLoop.main)
//    ///         .subscribe(uiUpdatingSubscriber)
//    ///
//    /// - Parameters:
//    ///   - scheduler: The scheduler on which to receive upstream messages.
//    ///   - options: Options that customize the delivery of elements.
//    /// - Returns: A publisher which performs upstream operations on the specified scheduler.
//    public func subscribe<S>(on scheduler: S, options: S.SchedulerOptions? = nil) -> Publishers.SubscribeOn<Self, S> where S : Scheduler
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Measures and emits the time interval between events received from an upstream publisher.
//    ///
//    /// The output type of the returned scheduler is the time interval of the provided scheduler.
//    /// - Parameters:
//    ///   - scheduler: The scheduler on which to deliver elements.
//    ///   - options: Options that customize the delivery of elements.
//    /// - Returns: A publisher that emits elements representing the time interval between the elements it receives.
//    public func measureInterval<S>(using scheduler: S, options: S.SchedulerOptions? = nil) -> Publishers.MeasureInterval<Self, S> where S : Scheduler
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Raises a debugger signal when a provided closure needs to stop the process in the debugger.
//    ///
//    /// When any of the provided closures returns `true`, this publisher raises the `SIGTRAP` signal to stop the process in the debugger.
//    /// Otherwise, this publisher passes through values and completions as-is.
//    ///
//    /// - Parameters:
//    ///   - receiveSubscription: A closure that executes when when the publisher receives a subscription. Return `true` from this closure to raise `SIGTRAP`, or false to continue.
//    ///   - receiveOutput: A closure that executes when when the publisher receives a value. Return `true` from this closure to raise `SIGTRAP`, or false to continue.
//    ///   - receiveCompletion: A closure that executes when when the publisher receives a completion. Return `true` from this closure to raise `SIGTRAP`, or false to continue.
//    /// - Returns: A publisher that raises a debugger signal when one of the provided closures returns `true`.
//    public func breakpoint(receiveSubscription: ((Subscription) -> Bool)? = nil, receiveOutput: ((Self.Output) -> Bool)? = nil, receiveCompletion: ((Subscribers.Completion<Self.Failure>) -> Bool)? = nil) -> Publishers.Breakpoint<Self>
//
//    /// Raises a debugger signal upon receiving a failure.
//    ///
//    /// When the upstream publisher fails with an error, this publisher raises the `SIGTRAP` signal, which stops the process in the debugger.
//    /// Otherwise, this publisher passes through values and completions as-is.
//    /// - Returns: A publisher that raises a debugger signal upon receiving a failure.
//    public func breakpointOnError() -> Publishers.Breakpoint<Self>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Publishes a single Boolean value that indicates whether all received elements pass a given predicate.
//    ///
//    /// When this publisher receives an element, it runs the predicate against the element. If the predicate returns `false`, the publisher produces a `false` value and finishes. If the upstream publisher finishes normally, this publisher produces a `true` value and finishes.
//    /// As a `reduce`-style operator, this publisher produces at most one value.
//    /// Backpressure note: Upon receiving any request greater than zero, this publisher requests unlimited elements from the upstream publisher.
//    /// - Parameter predicate: A closure that evaluates each received element. Return `true` to continue, or `false` to cancel the upstream and complete.
//    /// - Returns: A publisher that publishes a Boolean value that indicates whether all received elements pass a given predicate.
//    public func allSatisfy(_ predicate: @escaping (Self.Output) -> Bool) -> Publishers.AllSatisfy<Self>
//
//    /// Publishes a single Boolean value that indicates whether all received elements pass a given error-throwing predicate.
//    ///
//    /// When this publisher receives an element, it runs the predicate against the element. If the predicate returns `false`, the publisher produces a `false` value and finishes. If the upstream publisher finishes normally, this publisher produces a `true` value and finishes. If the predicate throws an error, the publisher fails, passing the error to its downstream.
//    /// As a `reduce`-style operator, this publisher produces at most one value.
//    /// Backpressure note: Upon receiving any request greater than zero, this publisher requests unlimited elements from the upstream publisher.
//    /// - Parameter predicate:  A closure that evaluates each received element. Return `true` to continue, or `false` to cancel the upstream and complete. The closure may throw, in which case the publisher cancels the upstream publisher and fails with the thrown error.
//    /// - Returns:  A publisher that publishes a Boolean value that indicates whether all received elements pass a given predicate.
//    public func tryAllSatisfy(_ predicate: @escaping (Self.Output) throws -> Bool) -> Publishers.TryAllSatisfy<Self>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher where Self.Failure == Never {
//
//    /// Attaches a subscriber with closure-based behavior.
//    ///
//    /// This method creates the subscriber and immediately requests an unlimited number of values, prior to returning the subscriber.
//    /// - parameter receiveValue: The closure to execute on receipt of a value.
//    /// - Returns: A cancellable instance; used when you end assignment of the received value. Deallocation of the result will tear down the subscription stream.
//    public func sink(receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher where Self.Output : Equatable {
//
//    /// Publishes a Boolean value upon receiving an element equal to the argument.
//    ///
//    /// The contains publisher consumes all received elements until the upstream publisher produces a matching element. At that point, it emits `true` and finishes normally. If the upstream finishes normally without producing a matching element, this publisher emits `false`, then finishes.
//    /// - Parameter output: An element to match against.
//    /// - Returns: A publisher that emits the Boolean value `true` when the upstream publisher emits a matching value.
//    public func contains(_ output: Self.Output) -> Publishers.Contains<Self>
//}
//

//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Republishes elements up to the specified maximum count.
//    ///
//    /// - Parameter maxLength: The maximum number of elements to republish.
//    /// - Returns: A publisher that publishes up to the specified number of elements before completing.
//    public func prefix(_ maxLength: Int) -> Publishers.Output<Self>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Republishes elements while a predicate closure indicates publishing should continue.
//    ///
//    /// The publisher finishes when the closure returns `false`.
//    ///
//    /// - Parameter predicate: A closure that takes an element as its parameter and returns a Boolean value indicating whether publishing should continue.
//    /// - Returns: A publisher that passes through elements until the predicate indicates publishing should finish.
//    public func prefix(while predicate: @escaping (Self.Output) -> Bool) -> Publishers.PrefixWhile<Self>
//
//    /// Republishes elements while a error-throwing predicate closure indicates publishing should continue.
//    ///
//    /// The publisher finishes when the closure returns `false`. If the closure throws, the publisher fails with the thrown error.
//    ///
//    /// - Parameter predicate: A closure that takes an element as its parameter and returns a Boolean value indicating whether publishing should continue.
//    /// - Returns: A publisher that passes through elements until the predicate throws or indicates publishing should finish.
//    public func tryPrefix(while predicate: @escaping (Self.Output) throws -> Bool) -> Publishers.TryPrefixWhile<Self>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher where Self.Failure == Never {
//
//    /// Changes the failure type declared by the upstream publisher.
//    ///
//    /// The publisher returned by this method cannot actually fail with the specified type and instead just finishes normally. Instead, you use this method when you need to match the error types of two mismatched publishers.
//    ///
//    /// - Parameter failureType: The `Failure` type presented by this publisher.
//    /// - Returns: A publisher that appears to send the specified failure type.
//    public func setFailureType<E>(to failureType: E.Type) -> Publishers.SetFailureType<Self, E> where E : Error
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Publishes a Boolean value upon receiving an element that satisfies the predicate closure.
//    ///
//    /// This operator consumes elements produced from the upstream publisher until the upstream publisher produces a matching element.
//    /// - Parameter predicate: A closure that takes an element as its parameter and returns a Boolean value indicating whether the element satisfies the closure’s comparison logic.
//    /// - Returns: A publisher that emits the Boolean value `true` when the upstream  publisher emits a matching value.
//    public func contains(where predicate: @escaping (Self.Output) -> Bool) -> Publishers.ContainsWhere<Self>
//
//    /// Publishes a Boolean value upon receiving an element that satisfies the throwing predicate closure.
//    ///
//    /// This operator consumes elements produced from the upstream publisher until the upstream publisher produces a matching element. If the closure throws, the stream fails with an error.
//    /// - Parameter predicate: A closure that takes an element as its parameter and returns a Boolean value indicating whether the element satisfies the closure’s comparison logic.
//    /// - Returns: A publisher that emits the Boolean value `true` when the upstream publisher emits a matching value.
//    public func tryContains(where predicate: @escaping (Self.Output) throws -> Bool) -> Publishers.TryContainsWhere<Self>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher where Self.Failure == Never {
//
//    /// Creates a connectable wrapper around the publisher.
//    ///
//    /// - Returns: A `ConnectablePublisher` wrapping this publisher.
//    public func makeConnectable() -> Publishers.MakeConnectable<Self>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Collects all received elements, and emits a single array of the collection when the upstream publisher finishes.
//    ///
//    /// If the upstream publisher fails with an error, this publisher forwards the error to the downstream receiver instead of sending its output.
//    /// This publisher requests an unlimited number of elements from the upstream publisher. It only sends the collected array to its downstream after a request whose demand is greater than 0 items.
//    /// Note: This publisher uses an unbounded amount of memory to store the received values.
//    ///
//    /// - Returns: A publisher that collects all received items and returns them as an array upon completion.
//    public func collect() -> Publishers.Collect<Self>
//
//    /// Collects up to the specified number of elements, and then emits a single array of the collection.
//    ///
//    /// If the upstream publisher finishes before filling the buffer, this publisher sends an array of all the items it has received. This may be fewer than `count` elements.
//    /// If the upstream publisher fails with an error, this publisher forwards the error to the downstream receiver instead of sending its output.
//    /// Note: When this publisher receives a request for `.max(n)` elements, it requests `.max(count * n)` from the upstream publisher.
//    /// - Parameter count: The maximum number of received elements to buffer before publishing.
//    /// - Returns: A publisher that collects up to the specified number of elements, and then publishes them as an array.
//    public func collect(_ count: Int) -> Publishers.CollectByCount<Self>
//
//    /// Collects elements by a given strategy, and emits a single array of the collection.
//    ///
//    /// If the upstream publisher finishes before filling the buffer, this publisher sends an array of all the items it has received. This may be fewer than `count` elements.
//    /// If the upstream publisher fails with an error, this publisher forwards the error to the downstream receiver instead of sending its output.
//    /// Note: When this publisher receives a request for `.max(n)` elements, it requests `.max(count * n)` from the upstream publisher.
//    /// - Parameters:
//    ///   - strategy: The strategy with which to collect and publish elements.
//    ///   - options: `Scheduler` options to use for the strategy.
//    /// - Returns: A publisher that collects elements by a given strategy, and emits a single array of the collection.
//    public func collect<S>(_ strategy: Publishers.TimeGroupingStrategy<S>, options: S.SchedulerOptions? = nil) -> Publishers.CollectByTime<Self, S> where S : Scheduler
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Returns a publisher that publishes the value of a key path.
//    ///
//    /// - Parameter keyPath: The key path of a property on `Output`
//    /// - Returns: A publisher that publishes the value of the key path.
//    public func map<T>(_ keyPath: KeyPath<Self.Output, T>) -> Publishers.MapKeyPath<Self, T>
//
//    /// Returns a publisher that publishes the values of two key paths as a tuple.
//    ///
//    /// - Parameters:
//    ///   - keyPath0: The key path of a property on `Output`
//    ///   - keyPath1: The key path of another property on `Output`
//    /// - Returns: A publisher that publishes the values of two key paths as a tuple.
//    public func map<T0, T1>(_ keyPath0: KeyPath<Self.Output, T0>, _ keyPath1: KeyPath<Self.Output, T1>) -> Publishers.MapKeyPath2<Self, T0, T1>
//
//    /// Returns a publisher that publishes the values of three key paths as a tuple.
//    ///
//    /// - Parameters:
//    ///   - keyPath0: The key path of a property on `Output`
//    ///   - keyPath1: The key path of another property on `Output`
//    ///   - keyPath2: The key path of a third  property on `Output`
//    /// - Returns: A publisher that publishes the values of three key paths as a tuple.
//    public func map<T0, T1, T2>(_ keyPath0: KeyPath<Self.Output, T0>, _ keyPath1: KeyPath<Self.Output, T1>, _ keyPath2: KeyPath<Self.Output, T2>) -> Publishers.MapKeyPath3<Self, T0, T1, T2>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Republishes elements until another publisher emits an element.
//    ///
//    /// After the second publisher publishes an element, the publisher returned by this method finishes.
//    ///
//    /// - Parameter publisher: A second publisher.
//    /// - Returns: A publisher that republishes elements until the second publisher publishes an element.
//    public func prefix<P>(untilOutputFrom publisher: P) -> Publishers.PrefixUntilOutput<Self, P> where P : Publisher
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    public func subscribe<S>(_ subject: S) -> AnyCancellable where S : Subject, Self.Failure == S.Failure, Self.Output == S.Output
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Applies a closure that accumulates each element of a stream and publishes a final result upon completion.
//    ///
//    /// - Parameters:
//    ///   - initialResult: The value the closure receives the first time it is called.
//    ///   - nextPartialResult: A closure that takes the previously-accumulated value and the next element from the upstream publisher to produce a new value.
//    /// - Returns: A publisher that applies the closure to all received elements and produces an accumulated value when the upstream publisher finishes.
//    public func reduce<T>(_ initialResult: T, _ nextPartialResult: @escaping (T, Self.Output) -> T) -> Publishers.Reduce<Self, T>
//
//    /// Applies an error-throwing closure that accumulates each element of a stream and publishes a final result upon completion.
//    ///
//    /// If the closure throws an error, the publisher fails, passing the error to its subscriber.
//    /// - Parameters:
//    ///   - initialResult: The value the closure receives the first time it is called.
//    ///   - nextPartialResult: An error-throwing closure that takes the previously-accumulated value and the next element from the upstream publisher to produce a new value.
//    /// - Returns: A publisher that applies the closure to all received elements and produces an accumulated value when the upstream publisher finishes.
//    public func tryReduce<T>(_ initialResult: T, _ nextPartialResult: @escaping (T, Self.Output) throws -> T) -> Publishers.TryReduce<Self, T>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Calls a closure with each received element and publishes any returned optional that has a value.
//    ///
//    /// - Parameter transform: A closure that receives a value and returns an optional value.
//    /// - Returns: A publisher that republishes all non-`nil` results of calling the transform closure.
//    public func compactMap<T>(_ transform: @escaping (Self.Output) -> T?) -> Publishers.CompactMap<Self, T>
//
//    /// Calls an error-throwing closure with each received element and publishes any returned optional that has a value.
//    ///
//    /// If the closure throws an error, the publisher cancels the upstream and sends the thrown error to the downstream receiver as a `Failure`.
//    /// - Parameter transform: an error-throwing closure that receives a value and returns an optional value.
//    /// - Returns: A publisher that republishes all non-`nil` results of calling the transform closure.
//    public func tryCompactMap<T>(_ transform: @escaping (Self.Output) throws -> T?) -> Publishers.TryCompactMap<Self, T>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Transforms elements from the upstream publisher by providing the current element to a closure along with the last value returned by the closure.
//    ///
//    ///     let pub = (0...5)
//    ///         .publisher
//    ///         .scan(0, { return $0 + $1 })
//    ///         .sink(receiveValue: { print ("\($0)", terminator: " ") })
//    ///      // Prints "0 1 3 6 10 15 ".
//    ///
//    ///
//    /// - Parameters:
//    ///   - initialResult: The previous result returned by the `nextPartialResult` closure.
//    ///   - nextPartialResult: A closure that takes as its arguments the previous value returned by the closure and the next element emitted from the upstream publisher.
//    /// - Returns: A publisher that transforms elements by applying a closure that receives its previous return value and the next element from the upstream publisher.
//    public func scan<T>(_ initialResult: T, _ nextPartialResult: @escaping (T, Self.Output) -> T) -> Publishers.Scan<Self, T>
//
//    /// Transforms elements from the upstream publisher by providing the current element to an error-throwing closure along with the last value returned by the closure.
//    ///
//    /// If the closure throws an error, the publisher fails with the error.
//    /// - Parameters:
//    ///   - initialResult: The previous result returned by the `nextPartialResult` closure.
//    ///   - nextPartialResult: An error-throwing closure that takes as its arguments the previous value returned by the closure and the next element emitted from the upstream publisher.
//    /// - Returns: A publisher that transforms elements by applying a closure that receives its previous return value and the next element from the upstream publisher.
//    public func tryScan<T>(_ initialResult: T, _ nextPartialResult: @escaping (T, Self.Output) throws -> T) -> Publishers.TryScan<Self, T>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Publishes the number of elements received from the upstream publisher.
//    ///
//    /// - Returns: A publisher that consumes all elements until the upstream publisher finishes, then emits a single
//    /// value with the total number of elements received.
//    public func count() -> Publishers.Count<Self>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Ingores all upstream elements, but passes along a completion state (finished or failed).
//    ///
//    /// The output type of this publisher is `Never`.
//    /// - Returns: A publisher that ignores all upstream elements.
//    public func ignoreOutput() -> Publishers.IgnoreOutput<Self>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher where Self.Failure == Never {
//
//    /// Assigns each element from a Publisher to a property on an object.
//    ///
//    /// - Parameters:
//    ///   - keyPath: The key path of the property to assign.
//    ///   - object: The object on which to assign the value.
//    /// - Returns: A cancellable instance; used when you end assignment of the received value. Deallocation of the result will tear down the subscription stream.
//    public func assign<Root>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>, on object: Root) -> AnyCancellable
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher where Self.Failure == Self.Output.Failure, Self.Output : Publisher {
//
//    /// Flattens the stream of events from multiple upstream publishers to appear as if they were coming from a single stream of events.
//    ///
//    /// This operator switches the inner publisher as new ones arrive but keeps the outer one constant for downstream subscribers.
//    /// For example, given the type `Publisher<Publisher<Data, NSError>, Never>`, calling `switchToLatest()` will result in the type `Publisher<Data, NSError>`. The downstream subscriber sees a continuous stream of values even though they may be coming from different upstream publishers.
//    public func switchToLatest() -> Publishers.SwitchToLatest<Self.Output, Self>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Publishes either the most-recent or first element published by the upstream publisher in the specified time interval.
//    ///
//    /// - Parameters:
//    ///   - interval: The interval at which to find and emit the most recent element, expressed in the time system of the scheduler.
//    ///   - scheduler: The scheduler on which to publish elements.
//    ///   - latest: A Boolean value that indicates whether to publish the most recent element. If `false`, the publisher emits the first element received during the interval.
//    /// - Returns: A publisher that emits either the most-recent or first element received during the specified interval.
//    public func throttle<S>(for interval: S.SchedulerTimeType.Stride, scheduler: S, latest: Bool) -> Publishers.Throttle<Self, S> where S : Scheduler
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Returns a publisher as a class instance.
//    ///
//    /// The downstream subscriber receieves elements and completion states unchanged from the upstream publisher. Use this operator when you want to use reference semantics, such as storing a publisher instance in a property.
//    ///
//    /// - Returns: A class instance that republishes its upstream publisher.
//    public func share() -> Publishers.Share<Self>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher where Self.Output : Comparable {
//
//    /// Publishes the minimum value received from the upstream publisher, after it finishes.
//    ///
//    /// After this publisher receives a request for more than 0 items, it requests unlimited items from its upstream publisher.
//    /// - Returns: A publisher that publishes the minimum value received from the upstream publisher, after the upstream publisher finishes.
//    public func min() -> Publishers.Comparison<Self>
//
//    /// Publishes the maximum value received from the upstream publisher, after it finishes.
//    ///
//    /// After this publisher receives a request for more than 0 items, it requests unlimited items from its upstream publisher.
//    /// - Returns: A publisher that publishes the maximum value received from the upstream publisher, after the upstream publisher finishes.
//    public func max() -> Publishers.Comparison<Self>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Publishes the minimum value received from the upstream publisher, after it finishes.
//    ///
//    /// After this publisher receives a request for more than 0 items, it requests unlimited items from its upstream publisher.
//    /// - Parameter areInIncreasingOrder: A closure that receives two elements and returns `true` if they are in increasing order.
//    /// - Returns: A publisher that publishes the minimum value received from the upstream publisher, after the upstream publisher finishes.
//    public func min(by areInIncreasingOrder: @escaping (Self.Output, Self.Output) -> Bool) -> Publishers.Comparison<Self>
//
//    /// Publishes the minimum value received from the upstream publisher, using the provided error-throwing closure to order the items.
//    ///
//    /// After this publisher receives a request for more than 0 items, it requests unlimited items from its upstream publisher.
//    /// - Parameter areInIncreasingOrder: A throwing closure that receives two elements and returns `true` if they are in increasing order. If this closure throws, the publisher terminates with a `Failure`.
//    /// - Returns: A publisher that publishes the minimum value received from the upstream publisher, after the upstream publisher finishes.
//    public func tryMin(by areInIncreasingOrder: @escaping (Self.Output, Self.Output) throws -> Bool) -> Publishers.TryComparison<Self>
//
//    /// Publishes the maximum value received from the upstream publisher, using the provided ordering closure.
//    ///
//    /// After this publisher receives a request for more than 0 items, it requests unlimited items from its upstream publisher.
//    /// - Parameter areInIncreasingOrder: A closure that receives two elements and returns `true` if they are in increasing order.
//    /// - Returns: A publisher that publishes the maximum value received from the upstream publisher, after the upstream publisher finishes.
//    public func max(by areInIncreasingOrder: @escaping (Self.Output, Self.Output) -> Bool) -> Publishers.Comparison<Self>
//
//    /// Publishes the maximum value received from the upstream publisher, using the provided error-throwing closure to order the items.
//    ///
//    /// After this publisher receives a request for more than 0 items, it requests unlimited items from its upstream publisher.
//    /// - Parameter areInIncreasingOrder: A throwing closure that receives two elements and returns `true` if they are in increasing order. If this closure throws, the publisher terminates with a `Failure`.
//    /// - Returns: A publisher that publishes the maximum value received from the upstream publisher, after the upstream publisher finishes.
//    public func tryMax(by areInIncreasingOrder: @escaping (Self.Output, Self.Output) throws -> Bool) -> Publishers.TryComparison<Self>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Replaces nil elements in the stream with the proviced element.
//    ///
//    /// - Parameter output: The element to use when replacing `nil`.
//    /// - Returns: A publisher that replaces `nil` elements from the upstream publisher with the provided element.
//    public func replaceNil<T>(with output: T) -> Publishers.Map<Self, T> where Self.Output == T?
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
////
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Raises a fatal error when its upstream publisher fails, and otherwise republishes all received input.
//    ///
//    /// Use this function for internal sanity checks that are active during testing but do not impact performance of shipping code.
//    ///
//    /// - Parameters:
//    ///   - prefix: A string used at the beginning of the fatal error message.
//    ///   - file: A filename used in the error message. This defaults to `#file`.
//    ///   - line: A line number used in the error message. This defaults to `#line`.
//    /// - Returns: A publisher that raises a fatal error when its upstream publisher fails.
//    public func assertNoFailure(_ prefix: String = "", file: StaticString = #file, line: UInt = #line) -> Publishers.AssertNoFailure<Self>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Publishes elements only after a specified time interval elapses between events.
//    ///
//    /// Use this operator when you want to wait for a pause in the delivery of events from the upstream publisher. For example, call `debounce` on the publisher from a text field to only receive elements when the user pauses or stops typing. When they start typing again, the `debounce` holds event delivery until the next pause.
//    /// - Parameters:
//    ///   - dueTime: The time the publisher should wait before publishing an element.
//    ///   - scheduler: The scheduler on which this publisher delivers elements
//    ///   - options: Scheduler options that customize this publisher’s delivery of elements.
//    /// - Returns: A publisher that publishes events only after a specified time elapses.
//    public func debounce<S>(for dueTime: S.SchedulerTimeType.Stride, scheduler: S, options: S.SchedulerOptions? = nil) -> Publishers.Debounce<Self, S> where S : Scheduler
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Terminates publishing if the upstream publisher exceeds the specified time interval without producing an element.
//    ///
//    /// - Parameters:
//    ///   - interval: The maximum time interval the publisher can go without emitting an element, expressed in the time system of the scheduler.
//    ///   - scheduler: The scheduler to deliver events on.
//    ///   - options: Scheduler options that customize the delivery of elements.
//    ///   - customError: A closure that executes if the publisher times out. The publisher sends the failure returned by this closure to the subscriber as the reason for termination.
//    /// - Returns: A publisher that terminates if the specified interval elapses with no events received from the upstream publisher.
//    public func timeout<S>(_ interval: S.SchedulerTimeType.Stride, scheduler: S, options: S.SchedulerOptions? = nil, customError: (() -> Self.Failure)? = nil) -> Publishers.Timeout<Self, S> where S : Scheduler
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Buffers elements received from an upstream publisher.
//    /// - Parameter size: The maximum number of elements to store.
//    /// - Parameter prefetch: The strategy for initially populating the buffer.
//    /// - Parameter whenFull: The action to take when the buffer becomes full.
//    public func buffer(size: Int, prefetch: Publishers.PrefetchStrategy, whenFull: Publishers.BufferingStrategy<Self.Failure>) -> Publishers.Buffer<Self>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Combine elements from another publisher and deliver pairs of elements as tuples.
//    ///
//    /// The returned publisher waits until both publishers have emitted an event, then delivers the oldest unconsumed event from each publisher together as a tuple to the subscriber.
//    /// For example, if publisher `P1` emits elements `a` and `b`, and publisher `P2` emits event `c`, the zip publisher emits the tuple `(a, c)`. It won’t emit a tuple with event `b` until `P2` emits another event.
//    /// If either upstream publisher finishes successfuly or fails with an error, the zipped publisher does the same.
//    ///
//    /// - Parameter other: Another publisher.
//    /// - Returns: A publisher that emits pairs of elements from the upstream publishers as tuples.
//    public func zip<P>(_ other: P) -> Publishers.Zip<Self, P> where P : Publisher, Self.Failure == P.Failure
//
//    /// Combine elements from another publisher and deliver a transformed output.
//    ///
//    /// The returned publisher waits until both publishers have emitted an event, then delivers the oldest unconsumed event from each publisher together as a tuple to the subscriber.
//    /// For example, if publisher `P1` emits elements `a` and `b`, and publisher `P2` emits event `c`, the zip publisher emits the tuple `(a, c)`. It won’t emit a tuple with event `b` until `P2` emits another event.
//    /// If either upstream publisher finishes successfuly or fails with an error, the zipped publisher does the same.
//    ///
//    /// - Parameter other: Another publisher.
//    ///   - transform: A closure that receives the most recent value from each publisher and returns a new value to publish.
//    /// - Returns: A publisher that emits pairs of elements from the upstream publishers as tuples.
//    public func zip<P, T>(_ other: P, _ transform: @escaping (Self.Output, P.Output) -> T) -> Publishers.Map<Publishers.Zip<Self, P>, T> where P : Publisher, Self.Failure == P.Failure
//
//    /// Combine elements from two other publishers and deliver groups of elements as tuples.
//    ///
//    /// The returned publisher waits until all three publishers have emitted an event, then delivers the oldest unconsumed event from each publisher as a tuple to the subscriber.
//    /// For example, if publisher `P1` emits elements `a` and `b`, and publisher `P2` emits elements `c` and `d`, and publisher `P3` emits the event `e`, the zip publisher emits the tuple `(a, c, e)`. It won’t emit a tuple with elements `b` or `d` until `P3` emits another event.
//    /// If any upstream publisher finishes successfuly or fails with an error, the zipped publisher does the same.
//    ///
//    /// - Parameters:
//    ///   - publisher1: A second publisher.
//    ///   - publisher2: A third publisher.
//    /// - Returns: A publisher that emits groups of elements from the upstream publishers as tuples.
//    public func zip<P, Q>(_ publisher1: P, _ publisher2: Q) -> Publishers.Zip3<Self, P, Q> where P : Publisher, Q : Publisher, Self.Failure == P.Failure, P.Failure == Q.Failure
//
//    /// Combine elements from two other publishers and deliver a transformed output.
//    ///
//    /// The returned publisher waits until all three publishers have emitted an event, then delivers the oldest unconsumed event from each publisher as a tuple to the subscriber.
//    /// For example, if publisher `P1` emits elements `a` and `b`, and publisher `P2` emits elements `c` and `d`, and publisher `P3` emits the event `e`, the zip publisher emits the tuple `(a, c, e)`. It won’t emit a tuple with elements `b` or `d` until `P3` emits another event.
//    /// If any upstream publisher finishes successfuly or fails with an error, the zipped publisher does the same.
//    ///
//    /// - Parameters:
//    ///   - publisher1: A second publisher.
//    ///   - publisher2: A third publisher.
//    ///   - transform: A closure that receives the most recent value from each publisher and returns a new value to publish.
//    /// - Returns: A publisher that emits groups of elements from the upstream publishers as tuples.
//    public func zip<P, Q, T>(_ publisher1: P, _ publisher2: Q, _ transform: @escaping (Self.Output, P.Output, Q.Output) -> T) -> Publishers.Map<Publishers.Zip3<Self, P, Q>, T> where P : Publisher, Q : Publisher, Self.Failure == P.Failure, P.Failure == Q.Failure
//
//    /// Combine elements from three other publishers and deliver groups of elements as tuples.
//    ///
//    /// The returned publisher waits until all four publishers have emitted an event, then delivers the oldest unconsumed event from each publisher as a tuple to the subscriber.
//    /// For example, if publisher `P1` emits elements `a` and `b`, and publisher `P2` emits elements `c` and `d`, and publisher `P3` emits the elements `e` and `f`, and publisher `P4` emits the event `g`, the zip publisher emits the tuple `(a, c, e, g)`. It won’t emit a tuple with elements `b`, `d`, or `f` until `P4` emits another event.
//    /// If any upstream publisher finishes successfuly or fails with an error, the zipped publisher does the same.
//    ///
//    /// - Parameters:
//    ///   - publisher1: A second publisher.
//    ///   - publisher2: A third publisher.
//    ///   - publisher3: A fourth publisher.
//    /// - Returns: A publisher that emits groups of elements from the upstream publishers as tuples.
//    public func zip<P, Q, R>(_ publisher1: P, _ publisher2: Q, _ publisher3: R) -> Publishers.Zip4<Self, P, Q, R> where P : Publisher, Q : Publisher, R : Publisher, Self.Failure == P.Failure, P.Failure == Q.Failure, Q.Failure == R.Failure
//
//    /// Combine elements from three other publishers and deliver a transformed output.
//    ///
//    /// The returned publisher waits until all four publishers have emitted an event, then delivers the oldest unconsumed event from each publisher as a tuple to the subscriber.
//    /// For example, if publisher `P1` emits elements `a` and `b`, and publisher `P2` emits elements `c` and `d`, and publisher `P3` emits the elements `e` and `f`, and publisher `P4` emits the event `g`, the zip publisher emits the tuple `(a, c, e, g)`. It won’t emit a tuple with elements `b`, `d`, or `f` until `P4` emits another event.
//    /// If any upstream publisher finishes successfuly or fails with an error, the zipped publisher does the same.
//    ///
//    /// - Parameters:
//    ///   - publisher1: A second publisher.
//    ///   - publisher2: A third publisher.
//    ///   - publisher3: A fourth publisher.
//    ///   - transform: A closure that receives the most recent value from each publisher and returns a new value to publish.
//    /// - Returns: A publisher that emits groups of elements from the upstream publishers as tuples.
//    public func zip<P, Q, R, T>(_ publisher1: P, _ publisher2: Q, _ publisher3: R, _ transform: @escaping (Self.Output, P.Output, Q.Output, R.Output) -> T) -> Publishers.Map<Publishers.Zip4<Self, P, Q, R>, T> where P : Publisher, Q : Publisher, R : Publisher, Self.Failure == P.Failure, P.Failure == Q.Failure, Q.Failure == R.Failure
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Publishes a specific element, indicated by its index in the sequence of published elements.
//    ///
//    /// If the publisher completes normally or with an error before publishing the specified element, then the publisher doesn’t produce any elements.
//    /// - Parameter index: The index that indicates the element to publish.
//    /// - Returns: A publisher that publishes a specific indexed element.
//    public func output(at index: Int) -> Publishers.Output<Self>
//
//    /// Publishes elements specified by their range in the sequence of published elements.
//    ///
//    /// After all elements are published, the publisher finishes normally.
//    /// If the publisher completes normally or with an error before producing all the elements in the range, it doesn’t publish the remaining elements.
//    /// - Parameter range: A range that indicates which elements to publish.
//    /// - Returns: A publisher that publishes elements specified by a range.
//    public func output<R>(in range: R) -> Publishers.Output<Self> where R : RangeExpression, R.Bound == Int
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publisher {
//
//    /// Delays delivery of all output to the downstream receiver by a specified amount of time on a particular scheduler.
//    ///
//    /// The delay affects the delivery of elements and completion, but not of the original subscription.
//    /// - Parameters:
//    ///   - interval: The amount of time to delay.
//    ///   - tolerance: The allowed tolerance in firing delayed events.
//    ///   - scheduler: The scheduler to deliver the delayed events.
//    /// - Returns: A publisher that delays delivery of elements and completion to the downstream receiver.
//    public func delay<S>(for interval: S.SchedulerTimeType.Stride, tolerance: S.SchedulerTimeType.Stride? = nil, scheduler: S, options: S.SchedulerOptions? = nil) -> Publishers.Delay<Self, S> where S : Scheduler
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that uses a subject to deliver elements to multiple subscribers.
//    final public class Multicast<Upstream, SubjectType> : ConnectablePublisher where Upstream : Publisher, SubjectType : Subject, Upstream.Failure == SubjectType.Failure, Upstream.Output == SubjectType.Output {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        final public let upstream: Upstream
//
//        /// A closure to create a new Subject each time a subscriber attaches to the multicast publisher.
//        final public let createSubject: () -> SubjectType
//
//        /// Creates a multicast publisher that applies a closure to create a subject that delivers elements to subscribers.
//        /// - Parameter upstream: The publisher from which this publisher receives elements.
//        /// - Parameter createSubject: A closure to create a new Subject each time a subscriber attaches to the multicast publisher.
//        public init(upstream: Upstream, createSubject: @escaping () -> SubjectType)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        final public func receive<S>(subscriber: S) where S : Subscriber, SubjectType.Failure == S.Failure, SubjectType.Output == S.Input
//
//        /// Connects to the publisher and returns a `Cancellable` instance with which to cancel publishing.
//        ///
//        /// - Returns: A `Cancellable` instance that can be used to cancel publishing.
//        final public func connect() -> Cancellable
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that receives elements from an upstream publisher on a specific scheduler.
//    public struct SubscribeOn<Upstream, Context> : Publisher where Upstream : Publisher, Context : Scheduler {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// The scheduler the publisher should use to receive elements.
//        public let scheduler: Context
//
//        /// Scheduler options that customize the delivery of elements.
//        public let options: Context.SchedulerOptions?
//
//        public init(upstream: Upstream, scheduler: Context, options: Context.SchedulerOptions?)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that measures and emits the time interval between events received from an upstream publisher.
//    public struct MeasureInterval<Upstream, Context> : Publisher where Upstream : Publisher, Context : Scheduler {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Context.SchedulerTimeType.Stride
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// The scheduler on which to deliver elements.
//        public let scheduler: Context
//
//        public init(upstream: Upstream, scheduler: Context)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, S.Input == Context.SchedulerTimeType.Stride
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that raises a debugger signal when a provided closure needs to stop the process in the debugger.
//    ///
//    /// When any of the provided closures returns `true`, this publisher raises the `SIGTRAP` signal to stop the process in the debugger.
//    /// Otherwise, this publisher passes through values and completions as-is.
//    public struct Breakpoint<Upstream> : Publisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// A closure that executes when the publisher receives a subscription, and can raise a debugger signal by returning a true Boolean value.
//        public let receiveSubscription: ((Subscription) -> Bool)?
//
//        /// A closure that executes when the publisher receives output from the upstream publisher, and can raise a debugger signal by returning a true Boolean value.
//        public let receiveOutput: ((Upstream.Output) -> Bool)?
//
//        /// A closure that executes when the publisher receives completion, and can raise a debugger signal by returning a true Boolean value.
//        public let receiveCompletion: ((Subscribers.Completion<Upstream.Failure>) -> Bool)?
//
//        /// Creates a breakpoint publisher with the provided upstream publisher and breakpoint-raising closures.
//        ///
//        /// - Parameters:
//        ///   - upstream: The publisher from which this publisher receives elements.
//        ///   - receiveSubscription: A closure that executes when the publisher receives a subscription, and can raise a debugger signal by returning a true Boolean value.
//        ///   - receiveOutput: A closure that executes when the publisher receives output from the upstream publisher, and can raise a debugger signal by returning a true Boolean value.
//        ///   - receiveCompletion: A closure that executes when the publisher receives completion, and can raise a debugger signal by returning a true Boolean value.
//        public init(upstream: Upstream, receiveSubscription: ((Subscription) -> Bool)? = nil, receiveOutput: ((Upstream.Output) -> Bool)? = nil, receiveCompletion: ((Subscribers.Completion<Publishers.Breakpoint<Upstream>.Failure>) -> Bool)? = nil)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that publishes a single Boolean value that indicates whether all received elements pass a given predicate.
//    public struct AllSatisfy<Upstream> : Publisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Bool
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// A closure that evaluates each received element.
//        ///
//        ///  Return `true` to continue, or `false` to cancel the upstream and finish.
//        public let predicate: (Upstream.Output) -> Bool
//
//        public init(upstream: Upstream, predicate: @escaping (Upstream.Output) -> Bool)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, S.Input == Publishers.AllSatisfy<Upstream>.Output
//    }
//
//    /// A publisher that publishes a single Boolean value that indicates whether all received elements pass a given error-throwing predicate.
//    public struct TryAllSatisfy<Upstream> : Publisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Bool
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Error
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// A closure that evaluates each received element.
//        ///
//        /// Return `true` to continue, or `false` to cancel the upstream and complete. The closure may throw, in which case the publisher cancels the upstream publisher and fails with the thrown error.
//        public let predicate: (Upstream.Output) throws -> Bool
//
//        public init(upstream: Upstream, predicate: @escaping (Upstream.Output) throws -> Bool)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, S.Failure == Publishers.TryAllSatisfy<Upstream>.Failure, S.Input == Publishers.TryAllSatisfy<Upstream>.Output
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that emits a Boolean value when a specified element is received from its upstream publisher.
//    public struct Contains<Upstream> : Publisher where Upstream : Publisher, Upstream.Output : Equatable {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Bool
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// The element to scan for in the upstream publisher.
//        public let output: Upstream.Output
//
//        public init(upstream: Upstream, output: Upstream.Output)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, S.Input == Publishers.Contains<Upstream>.Output
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that automatically connects and disconnects from this connectable publisher.
//    public class Autoconnect<Upstream> : Publisher where Upstream : ConnectablePublisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        final public let upstream: Upstream
//
//        public init(upstream: Upstream)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input
//    }
//}
//
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that republishes elements while a predicate closure indicates publishing should continue.
//    public struct PrefixWhile<Upstream> : Publisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// The closure that determines whether whether publishing should continue.
//        public let predicate: (Upstream.Output) -> Bool
//
//        public init(upstream: Upstream, predicate: @escaping (Publishers.PrefixWhile<Upstream>.Output) -> Bool)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input
//    }
//
//    /// A publisher that republishes elements while an error-throwing predicate closure indicates publishing should continue.
//    public struct TryPrefixWhile<Upstream> : Publisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Error
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// The error-throwing closure that determines whether publishing should continue.
//        public let predicate: (Upstream.Output) throws -> Bool
//
//        public init(upstream: Upstream, predicate: @escaping (Publishers.TryPrefixWhile<Upstream>.Output) throws -> Bool)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Output == S.Input, S.Failure == Publishers.TryPrefixWhile<Upstream>.Failure
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that appears to send a specified failure type.
//    ///
//    /// The publisher cannot actually fail with the specified type and instead just finishes normally. Use this publisher type when you need to match the error types for two mismatched publishers.
//    public struct SetFailureType<Upstream, Failure> : Publisher where Upstream : Publisher, Failure : Error, Upstream.Failure == Never {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// Creates a publisher that appears to send a specified failure type.
//        ///
//        /// - Parameter upstream: The publisher from which this publisher receives elements.
//        public init(upstream: Upstream)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where Failure == S.Failure, S : Subscriber, Upstream.Output == S.Input
//
//        public func setFailureType<E>(to failure: E.Type) -> Publishers.SetFailureType<Upstream, E> where E : Error
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that emits a Boolean value upon receiving an element that satisfies the predicate closure.
//    public struct ContainsWhere<Upstream> : Publisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Bool
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// The closure that determines whether the publisher should consider an element as a match.
//        public let predicate: (Upstream.Output) -> Bool
//
//        public init(upstream: Upstream, predicate: @escaping (Upstream.Output) -> Bool)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, S.Input == Publishers.ContainsWhere<Upstream>.Output
//    }
//
//    /// A publisher that emits a Boolean value upon receiving an element that satisfies the throwing predicate closure.
//    public struct TryContainsWhere<Upstream> : Publisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Bool
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Error
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// The error-throwing closure that determines whether this publisher should emit a `true` element.
//        public let predicate: (Upstream.Output) throws -> Bool
//
//        public init(upstream: Upstream, predicate: @escaping (Upstream.Output) throws -> Bool)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, S.Failure == Publishers.TryContainsWhere<Upstream>.Failure, S.Input == Publishers.TryContainsWhere<Upstream>.Output
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    public struct MakeConnectable<Upstream> : ConnectablePublisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        public init(upstream: Upstream)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input
//
//        /// Connects to the publisher and returns a `Cancellable` instance with which to cancel publishing.
//        ///
//        /// - Returns: A `Cancellable` instance that can be used to cancel publishing.
//        public func connect() -> Cancellable
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A strategy for collecting received elements.
//    ///
//    /// - byTime: Collect and periodically publish items.
//    /// - byTimeOrCount: Collect and publish items, either periodically or when a buffer reaches its maximum size.
//    public enum TimeGroupingStrategy<Context> where Context : Scheduler {
//
//        case byTime(Context, Context.SchedulerTimeType.Stride)
//
//        case byTimeOrCount(Context, Context.SchedulerTimeType.Stride, Int)
//    }
//
//    /// A publisher that buffers and periodically publishes its items.
//    public struct CollectByTime<Upstream, Context> : Publisher where Upstream : Publisher, Context : Scheduler {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = [Upstream.Output]
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher that this publisher receives elements from.
//        public let upstream: Upstream
//
//        /// The strategy with which to collect and publish elements.
//        public let strategy: Publishers.TimeGroupingStrategy<Context>
//
//        /// `Scheduler` options to use for the strategy.
//        public let options: Context.SchedulerOptions?
//
//        public init(upstream: Upstream, strategy: Publishers.TimeGroupingStrategy<Context>, options: Context.SchedulerOptions?)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, S.Input == [Upstream.Output]
//    }
//
//    /// A publisher that buffers items.
//    public struct Collect<Upstream> : Publisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = [Upstream.Output]
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher that this publisher receives elements from.
//        public let upstream: Upstream
//
//        public init(upstream: Upstream)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, S.Input == [Upstream.Output]
//    }
//
//    /// A publisher that buffers a maximum number of items.
//    public struct CollectByCount<Upstream> : Publisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = [Upstream.Output]
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        ///  The maximum number of received elements to buffer before publishing.
//        public let count: Int
//
//        public init(upstream: Upstream, count: Int)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, S.Input == [Upstream.Output]
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that publishes the value of a key path.
//    public struct MapKeyPath<Upstream, Output> : Publisher where Upstream : Publisher {
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// The key path of a property to publish.
//        public let keyPath: KeyPath<Upstream.Output, Output>
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where Output == S.Input, S : Subscriber, Upstream.Failure == S.Failure
//    }
//
//    /// A publisher that publishes the values of two key paths as a tuple.
//    public struct MapKeyPath2<Upstream, Output0, Output1> : Publisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = (Output0, Output1)
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// The key path of a property to publish.
//        public let keyPath0: KeyPath<Upstream.Output, Output0>
//
//        /// The key path of a second property to publish.
//        public let keyPath1: KeyPath<Upstream.Output, Output1>
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, S.Input == (Output0, Output1)
//    }
//
//    /// A publisher that publishes the values of three key paths as a tuple.
//    public struct MapKeyPath3<Upstream, Output0, Output1, Output2> : Publisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = (Output0, Output1, Output2)
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// The key path of a property to publish.
//        public let keyPath0: KeyPath<Upstream.Output, Output0>
//
//        /// The key path of a second property to publish.
//        public let keyPath1: KeyPath<Upstream.Output, Output1>
//
//        /// The key path of a third property to publish.
//        public let keyPath2: KeyPath<Upstream.Output, Output2>
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, S.Input == (Output0, Output1, Output2)
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    public struct PrefixUntilOutput<Upstream, Other> : Publisher where Upstream : Publisher, Other : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// Another publisher, whose first output causes this publisher to finish.
//        public let other: Other
//
//        public init(upstream: Upstream, other: Other)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that applies a closure to all received elements and produces an accumulated value when the upstream publisher finishes.
//    public struct Reduce<Upstream, Output> : Publisher where Upstream : Publisher {
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// The initial value provided on the first invocation of the closure.
//        public let initial: Output
//
//        /// A closure that takes the previously-accumulated value and the next element from the upstream publisher to produce a new value.
//        public let nextPartialResult: (Output, Upstream.Output) -> Output
//
//        public init(upstream: Upstream, initial: Output, nextPartialResult: @escaping (Output, Upstream.Output) -> Output)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where Output == S.Input, S : Subscriber, Upstream.Failure == S.Failure
//    }
//
//    /// A publisher that applies an error-throwing closure to all received elements and produces an accumulated value when the upstream publisher finishes.
//    public struct TryReduce<Upstream, Output> : Publisher where Upstream : Publisher {
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Error
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// The initial value provided on the first invocation of the closure.
//        public let initial: Output
//
//        /// An error-throwing closure that takes the previously-accumulated value and the next element from the upstream to produce a new value.
//        ///
//        /// If this closure throws an error, the publisher fails and passes the error to its subscriber.
//        public let nextPartialResult: (Output, Upstream.Output) throws -> Output
//
//        public init(upstream: Upstream, initial: Output, nextPartialResult: @escaping (Output, Upstream.Output) throws -> Output)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where Output == S.Input, S : Subscriber, S.Failure == Publishers.TryReduce<Upstream, Output>.Failure
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that republishes all non-`nil` results of calling a closure with each received element.
//    public struct CompactMap<Upstream, Output> : Publisher where Upstream : Publisher {
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// A closure that receives values from the upstream publisher and returns optional values.
//        public let transform: (Upstream.Output) -> Output?
//
//        public init(upstream: Upstream, transform: @escaping (Upstream.Output) -> Output?)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where Output == S.Input, S : Subscriber, Upstream.Failure == S.Failure
//    }
//
//    /// A publisher that republishes all non-`nil` results of calling an error-throwing closure with each received element.
//    public struct TryCompactMap<Upstream, Output> : Publisher where Upstream : Publisher {
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Error
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// An error-throwing closure that receives values from the upstream publisher and returns optional values.
//        ///
//        /// If this closure throws an error, the publisher fails.
//        public let transform: (Upstream.Output) throws -> Output?
//
//        public init(upstream: Upstream, transform: @escaping (Upstream.Output) throws -> Output?)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where Output == S.Input, S : Subscriber, S.Failure == Publishers.TryCompactMap<Upstream, Output>.Failure
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    public struct Scan<Upstream, Output> : Publisher where Upstream : Publisher {
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        public let upstream: Upstream
//
//        public let initialResult: Output
//
//        public let nextPartialResult: (Output, Upstream.Output) -> Output
//
//        public init(upstream: Upstream, initialResult: Output, nextPartialResult: @escaping (Output, Upstream.Output) -> Output)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where Output == S.Input, S : Subscriber, Upstream.Failure == S.Failure
//    }
//
//    public struct TryScan<Upstream, Output> : Publisher where Upstream : Publisher {
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Error
//
//        public let upstream: Upstream
//
//        public let initialResult: Output
//
//        public let nextPartialResult: (Output, Upstream.Output) throws -> Output
//
//        public init(upstream: Upstream, initialResult: Output, nextPartialResult: @escaping (Output, Upstream.Output) throws -> Output)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where Output == S.Input, S : Subscriber, S.Failure == Publishers.TryScan<Upstream, Output>.Failure
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that publishes the number of elements received from the upstream publisher.
//    public struct Count<Upstream> : Publisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Int
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        public init(upstream: Upstream)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, S.Input == Publishers.Count<Upstream>.Output
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that ignores all upstream elements, but passes along a completion state (finish or failed).
//    public struct IgnoreOutput<Upstream> : Publisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Never
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        public init(upstream: Upstream)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, S.Input == Publishers.IgnoreOutput<Upstream>.Output
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that “flattens” nested publishers.
//    ///
//    /// Given a publisher that publishes Publishers, the `SwitchToLatest` publisher produces a sequence of events from only the most recent one.
//    /// For example, given the type `Publisher<Publisher<Data, NSError>, Never>`, calling `switchToLatest()` will result in the type `Publisher<Data, NSError>`. The downstream subscriber sees a continuous stream of values even though they may be coming from different upstream publishers.
//    public struct SwitchToLatest<P, Upstream> : Publisher where P : Publisher, P == Upstream.Output, Upstream : Publisher, P.Failure == Upstream.Failure {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = P.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = P.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// Creates a publisher that “flattens” nested publishers.
//        ///
//        /// - Parameter upstream: The publisher from which this publisher receives elements.
//        public init(upstream: Upstream)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, P.Output == S.Input, Upstream.Failure == S.Failure
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that publishes either the most-recent or first element published by the upstream publisher in a specified time interval.
//    public struct Throttle<Upstream, Context> : Publisher where Upstream : Publisher, Context : Scheduler {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// The interval in which to find and emit the most recent element.
//        public let interval: Context.SchedulerTimeType.Stride
//
//        /// The scheduler on which to publish elements.
//        public let scheduler: Context
//
//        /// A Boolean value indicating whether to publish the most recent element.
//        ///
//        /// If `false`, the publisher emits the first element received during the interval.
//        public let latest: Bool
//
//        public init(upstream: Upstream, interval: Context.SchedulerTimeType.Stride, scheduler: Context, latest: Bool)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher implemented as a class, which otherwise behaves like its upstream publisher.
//    final public class Share<Upstream> : Publisher, Equatable where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        final public let upstream: Upstream
//
//        public init(upstream: Upstream)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        final public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input
//
//        /// Returns a Boolean value indicating whether two values are equal.
//        ///
//        /// Equality is the inverse of inequality. For any values `a` and `b`,
//        /// `a == b` implies that `a != b` is `false`.
//        ///
//        /// - Parameters:
//        ///   - lhs: A value to compare.
//        ///   - rhs: Another value to compare.
//        public static func == (lhs: Publishers.Share<Upstream>, rhs: Publishers.Share<Upstream>) -> Bool
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that republishes items from another publisher only if each new item is in increasing order from the previously-published item.
//    public struct Comparison<Upstream> : Publisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher that this publisher receives elements from.
//        public let upstream: Upstream
//
//        /// A closure that receives two elements and returns `true` if they are in increasing order.
//        public let areInIncreasingOrder: (Upstream.Output, Upstream.Output) -> Bool
//
//        public init(upstream: Upstream, areInIncreasingOrder: @escaping (Upstream.Output, Upstream.Output) -> Bool)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input
//    }
//
//    /// A publisher that republishes items from another publisher only if each new item is in increasing order from the previously-published item, and fails if the ordering logic throws an error.
//    public struct TryComparison<Upstream> : Publisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Error
//
//        /// The publisher that this publisher receives elements from.
//        public let upstream: Upstream
//
//        /// A closure that receives two elements and returns `true` if they are in increasing order.
//        public let areInIncreasingOrder: (Upstream.Output, Upstream.Output) throws -> Bool
//
//        public init(upstream: Upstream, areInIncreasingOrder: @escaping (Upstream.Output, Upstream.Output) throws -> Bool)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Output == S.Input, S.Failure == Publishers.TryComparison<Upstream>.Failure
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that raises a fatal error upon receiving any failure, and otherwise republishes all received input.
//    ///
//    /// Use this function for internal sanity checks that are active during testing but do not impact performance of shipping code.
//    public struct AssertNoFailure<Upstream> : Publisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Never
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// The string used at the beginning of the fatal error message.
//        public let prefix: String
//
//        /// The filename used in the error message.
//        public let file: StaticString
//
//        /// The line number used in the error message.
//        public let line: UInt
//
//        public init(upstream: Upstream, prefix: String, file: StaticString, line: UInt)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Output == S.Input, S.Failure == Publishers.AssertNoFailure<Upstream>.Failure
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that emits all of one publisher’s elements before those from another publisher.
//    public struct Concatenate<Prefix, Suffix> : Publisher where Prefix : Publisher, Suffix : Publisher, Prefix.Failure == Suffix.Failure, Prefix.Output == Suffix.Output {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Suffix.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Suffix.Failure
//
//        /// The publisher to republish, in its entirety, before republishing elements from `suffix`.
//        public let prefix: Prefix
//
//        /// The publisher to republish only after `prefix` finishes.
//        public let suffix: Suffix
//
//        public init(prefix: Prefix, suffix: Suffix)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Suffix.Failure == S.Failure, Suffix.Output == S.Input
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that publishes elements only after a specified time interval elapses between events.
//    public struct Debounce<Upstream, Context> : Publisher where Upstream : Publisher, Context : Scheduler {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// The amount of time the publisher should wait before publishing an element.
//        public let dueTime: Context.SchedulerTimeType.Stride
//
//        /// The scheduler on which this publisher delivers elements.
//        public let scheduler: Context
//
//        /// Scheduler options that customize this publisher’s delivery of elements.
//        public let options: Context.SchedulerOptions?
//
//        public init(upstream: Upstream, dueTime: Context.SchedulerTimeType.Stride, scheduler: Context, options: Context.SchedulerOptions?)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    public struct Timeout<Upstream, Context> : Publisher where Upstream : Publisher, Context : Scheduler {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        public let upstream: Upstream
//
//        public let interval: Context.SchedulerTimeType.Stride
//
//        public let scheduler: Context
//
//        public let options: Context.SchedulerOptions?
//
//        public let customError: (() -> Upstream.Failure)?
//
//        public init(upstream: Upstream, interval: Context.SchedulerTimeType.Stride, scheduler: Context, options: Context.SchedulerOptions?, customError: (() -> Publishers.Timeout<Upstream, Context>.Failure)?)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A strategy for filling a buffer.
//    ///
//    /// * keepFull: A strategy to fill the buffer at subscription time, and keep it full thereafter.
//    /// * byRequest: A strategy that avoids prefetching and instead performs requests on demand.
//    public enum PrefetchStrategy {
//
//        case keepFull
//
//        case byRequest
//
//        /// Returns a Boolean value indicating whether two values are equal.
//        ///
//        /// Equality is the inverse of inequality. For any values `a` and `b`,
//        /// `a == b` implies that `a != b` is `false`.
//        ///
//        /// - Parameters:
//        ///   - lhs: A value to compare.
//        ///   - rhs: Another value to compare.
//        public static func == (a: Publishers.PrefetchStrategy, b: Publishers.PrefetchStrategy) -> Bool
//
//        /// The hash value.
//        ///
//        /// Hash values are not guaranteed to be equal across different executions of
//        /// your program. Do not save hash values to use during a future execution.
//        ///
//        /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
//        ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
//        public var hashValue: Int { get }
//
//        /// Hashes the essential components of this value by feeding them into the
//        /// given hasher.
//        ///
//        /// Implement this method to conform to the `Hashable` protocol. The
//        /// components used for hashing must be the same as the components compared
//        /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
//        /// with each of these components.
//        ///
//        /// - Important: Never call `finalize()` on `hasher`. Doing so may become a
//        ///   compile-time error in the future.
//        ///
//        /// - Parameter hasher: The hasher to use when combining the components
//        ///   of this instance.
//        public func hash(into hasher: inout Hasher)
//    }
//
//    /// A strategy for handling exhaustion of a buffer’s capacity.
//    ///
//    /// * dropNewest: When full, discard the newly-received element without buffering it.
//    /// * dropOldest: When full, remove the least recently-received element from the buffer.
//    /// * customError: When full, execute the closure to provide a custom error.
//    public enum BufferingStrategy<Failure> where Failure : Error {
//
//        case dropNewest
//
//        case dropOldest
//
//        case customError(() -> Failure)
//    }
//
//    /// A publisher that buffers elements received from an upstream publisher.
//    public struct Buffer<Upstream> : Publisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher from which this publisher receives elements.
//        public let upstream: Upstream
//
//        /// The maximum number of elements to store.
//        public let size: Int
//
//        /// The strategy for initially populating the buffer.
//        public let prefetch: Publishers.PrefetchStrategy
//
//        /// The action to take when the buffer becomes full.
//        public let whenFull: Publishers.BufferingStrategy<Upstream.Failure>
//
//        /// Creates a publisher that buffers elements received from an upstream publisher.
//        /// - Parameter upstream: The publisher from which this publisher receives elements.
//        /// - Parameter size: The maximum number of elements to store.
//        /// - Parameter prefetch: The strategy for initially populating the buffer.
//        /// - Parameter whenFull: The action to take when the buffer becomes full.
//        public init(upstream: Upstream, size: Int, prefetch: Publishers.PrefetchStrategy, whenFull: Publishers.BufferingStrategy<Publishers.Buffer<Upstream>.Failure>)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher created by applying the zip function to two upstream publishers.
//    public struct Zip<A, B> : Publisher where A : Publisher, B : Publisher, A.Failure == B.Failure {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = (A.Output, B.Output)
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = A.Failure
//
//        public let a: A
//
//        public let b: B
//
//        public init(_ a: A, _ b: B)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, B.Failure == S.Failure, S.Input == (A.Output, B.Output)
//    }
//
//    /// A publisher created by applying the zip function to three upstream publishers.
//    public struct Zip3<A, B, C> : Publisher where A : Publisher, B : Publisher, C : Publisher, A.Failure == B.Failure, B.Failure == C.Failure {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = (A.Output, B.Output, C.Output)
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = A.Failure
//
//        public let a: A
//
//        public let b: B
//
//        public let c: C
//
//        public init(_ a: A, _ b: B, _ c: C)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, C.Failure == S.Failure, S.Input == (A.Output, B.Output, C.Output)
//    }
//
//    /// A publisher created by applying the zip function to four upstream publishers.
//    public struct Zip4<A, B, C, D> : Publisher where A : Publisher, B : Publisher, C : Publisher, D : Publisher, A.Failure == B.Failure, B.Failure == C.Failure, C.Failure == D.Failure {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = (A.Output, B.Output, C.Output, D.Output)
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = A.Failure
//
//        public let a: A
//
//        public let b: B
//
//        public let c: C
//
//        public let d: D
//
//        public init(_ a: A, _ b: B, _ c: C, _ d: D)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, D.Failure == S.Failure, S.Input == (A.Output, B.Output, C.Output, D.Output)
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that publishes elements specified by a range in the sequence of published elements.
//    public struct Output<Upstream> : Publisher where Upstream : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher that this publisher receives elements from.
//        public let upstream: Upstream
//
//        /// The range of elements to publish.
//        public let range: CountableRange<Int>
//
//        /// Creates a publisher that publishes elements specified by a range.
//        ///
//        /// - Parameters:
//        ///   - upstream: The publisher that this publisher receives elements from.
//        ///   - range: The range of elements to publish.
//        public init(upstream: Upstream, range: CountableRange<Int>)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers {
//
//    /// A publisher that delays delivery of elements and completion to the downstream receiver.
//    public struct Delay<Upstream, Context> : Publisher where Upstream : Publisher, Context : Scheduler {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Upstream.Output
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Upstream.Failure
//
//        /// The publisher that this publisher receives elements from.
//        public let upstream: Upstream
//
//        /// The amount of time to delay.
//        public let interval: Context.SchedulerTimeType.Stride
//
//        /// The allowed tolerance in firing delayed events.
//        public let tolerance: Context.SchedulerTimeType.Stride
//
//        /// The scheduler to deliver the delayed events.
//        public let scheduler: Context
//
//        public let options: Context.SchedulerOptions?
//
//        public init(upstream: Upstream, interval: Context.SchedulerTimeType.Stride, tolerance: Context.SchedulerTimeType.Stride, scheduler: Context, options: Context.SchedulerOptions? = nil)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Filter {
//
//    public func filter(_ isIncluded: @escaping (Publishers.Filter<Upstream>.Output) -> Bool) -> Publishers.Filter<Upstream>
//
//    public func tryFilter(_ isIncluded: @escaping (Publishers.Filter<Upstream>.Output) throws -> Bool) -> Publishers.TryFilter<Upstream>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.TryFilter {
//
//    public func filter(_ isIncluded: @escaping (Publishers.TryFilter<Upstream>.Output) -> Bool) -> Publishers.TryFilter<Upstream>
//
//    public func tryFilter(_ isIncluded: @escaping (Publishers.TryFilter<Upstream>.Output) throws -> Bool) -> Publishers.TryFilter<Upstream>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Contains : Equatable where Upstream : Equatable {
//
//    /// Returns a Boolean value that indicates whether two publishers are equivalent.
//    ///
//    /// - Parameters:
//    ///   - lhs: A contains publisher to compare for equality.
//    ///   - rhs: Another contains publisher to compare for equality.
//    /// - Returns: `true` if the two publishers’ upstream and output properties are equal, `false` otherwise.
//    public static func == (lhs: Publishers.Contains<Upstream>, rhs: Publishers.Contains<Upstream>) -> Bool
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.CombineLatest : Equatable where A : Equatable, B : Equatable {
//
//    /// Returns a Boolean value that indicates whether two publishers are equivalent.
//    ///
//    /// - Parameters:
//    ///   - lhs: A combineLatest publisher to compare for equality.
//    ///   - rhs: Another combineLatest publisher to compare for equality.
//    /// - Returns: `true` if the corresponding upstream publishers of each combineLatest publisher are equal, `false` otherwise.
//    public static func == (lhs: Publishers.CombineLatest<A, B>, rhs: Publishers.CombineLatest<A, B>) -> Bool
//}
//
///// Returns a Boolean value that indicates whether two publishers are equivalent.
/////
///// - Parameters:
/////   - lhs: A combineLatest publisher to compare for equality.
/////   - rhs: Another combineLatest publisher to compare for equality.
///// - Returns: `true` if the corresponding upstream publishers of each combineLatest publisher are equal, `false` otherwise.
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.CombineLatest3 : Equatable where A : Equatable, B : Equatable, C : Equatable {
//
//    /// Returns a Boolean value indicating whether two values are equal.
//    ///
//    /// Equality is the inverse of inequality. For any values `a` and `b`,
//    /// `a == b` implies that `a != b` is `false`.
//    ///
//    /// - Parameters:
//    ///   - lhs: A value to compare.
//    ///   - rhs: Another value to compare.
//    public static func == (lhs: Publishers.CombineLatest3<A, B, C>, rhs: Publishers.CombineLatest3<A, B, C>) -> Bool
//}
//
///// Returns a Boolean value that indicates whether two publishers are equivalent.
/////
///// - Parameters:
/////   - lhs: A combineLatest publisher to compare for equality.
/////   - rhs: Another combineLatest publisher to compare for equality.
///// - Returns: `true` if the corresponding upstream publishers of each combineLatest publisher are equal, `false` otherwise.
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.CombineLatest4 : Equatable where A : Equatable, B : Equatable, C : Equatable, D : Equatable {
//
//    /// Returns a Boolean value indicating whether two values are equal.
//    ///
//    /// Equality is the inverse of inequality. For any values `a` and `b`,
//    /// `a == b` implies that `a != b` is `false`.
//    ///
//    /// - Parameters:
//    ///   - lhs: A value to compare.
//    ///   - rhs: Another value to compare.
//    public static func == (lhs: Publishers.CombineLatest4<A, B, C, D>, rhs: Publishers.CombineLatest4<A, B, C, D>) -> Bool
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.SetFailureType : Equatable where Upstream : Equatable {
//
//    /// Returns a Boolean value indicating whether two values are equal.
//    ///
//    /// Equality is the inverse of inequality. For any values `a` and `b`,
//    /// `a == b` implies that `a != b` is `false`.
//    ///
//    /// - Parameters:
//    ///   - lhs: A value to compare.
//    ///   - rhs: Another value to compare.
//    public static func == (lhs: Publishers.SetFailureType<Upstream, Failure>, rhs: Publishers.SetFailureType<Upstream, Failure>) -> Bool
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Collect : Equatable where Upstream : Equatable {
//
//    /// Returns a Boolean value indicating whether two values are equal.
//    ///
//    /// Equality is the inverse of inequality. For any values `a` and `b`,
//    /// `a == b` implies that `a != b` is `false`.
//    ///
//    /// - Parameters:
//    ///   - lhs: A value to compare.
//    ///   - rhs: Another value to compare.
//    public static func == (lhs: Publishers.Collect<Upstream>, rhs: Publishers.Collect<Upstream>) -> Bool
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.CollectByCount : Equatable where Upstream : Equatable {
//
//    /// Returns a Boolean value indicating whether two values are equal.
//    ///
//    /// Equality is the inverse of inequality. For any values `a` and `b`,
//    /// `a == b` implies that `a != b` is `false`.
//    ///
//    /// - Parameters:
//    ///   - lhs: A value to compare.
//    ///   - rhs: Another value to compare.
//    public static func == (lhs: Publishers.CollectByCount<Upstream>, rhs: Publishers.CollectByCount<Upstream>) -> Bool
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.CompactMap {
//
//    public func compactMap<T>(_ transform: @escaping (Output) -> T?) -> Publishers.CompactMap<Upstream, T>
//
//    public func map<T>(_ transform: @escaping (Output) -> T) -> Publishers.CompactMap<Upstream, T>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.TryCompactMap {
//
//    public func compactMap<T>(_ transform: @escaping (Output) throws -> T?) -> Publishers.TryCompactMap<Upstream, T>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Count : Equatable where Upstream : Equatable {
//
//    /// Returns a Boolean value indicating whether two values are equal.
//    ///
//    /// Equality is the inverse of inequality. For any values `a` and `b`,
//    /// `a == b` implies that `a != b` is `false`.
//    ///
//    /// - Parameters:
//    ///   - lhs: A value to compare.
//    ///   - rhs: Another value to compare.
//    public static func == (lhs: Publishers.Count<Upstream>, rhs: Publishers.Count<Upstream>) -> Bool
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.IgnoreOutput : Equatable where Upstream : Equatable {
//
//    /// Returns a Boolean value that indicates whether two publishers are equivalent.
//    ///
//    /// - Parameters:
//    ///   - lhs: An ignore output publisher to compare for equality.
//    ///   - rhs: Another ignore output publisher to compare for equality.
//    /// - Returns: `true` if the two publishers have equal upstream publishers, `false` otherwise.
//    public static func == (lhs: Publishers.IgnoreOutput<Upstream>, rhs: Publishers.IgnoreOutput<Upstream>) -> Bool
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Retry : Equatable where Upstream : Equatable {
//
//    /// Returns a Boolean value indicating whether two values are equal.
//    ///
//    /// Equality is the inverse of inequality. For any values `a` and `b`,
//    /// `a == b` implies that `a != b` is `false`.
//    ///
//    /// - Parameters:
//    ///   - lhs: A value to compare.
//    ///   - rhs: Another value to compare.
//    public static func == (lhs: Publishers.Retry<Upstream>, rhs: Publishers.Retry<Upstream>) -> Bool
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.ReplaceError : Equatable where Upstream : Equatable, Upstream.Output : Equatable {
//
//    /// Returns a Boolean value that indicates whether two publishers are equivalent.
//    ///
//    /// - Parameters:
//    ///   - lhs: A replace error publisher to compare for equality.
//    ///   - rhs: Another replace error publisher to compare for equality.
//    /// - Returns: `true` if the two publishers have equal upstream publishers and output elements, `false` otherwise.
//    public static func == (lhs: Publishers.ReplaceError<Upstream>, rhs: Publishers.ReplaceError<Upstream>) -> Bool
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Concatenate : Equatable where Prefix : Equatable, Suffix : Equatable {
//
//    /// Returns a Boolean value that indicates whether two publishers are equivalent.
//    ///
//    /// - Parameters:
//    ///   - lhs: A concatenate publisher to compare for equality.
//    ///   - rhs: Another concatenate publisher to compare for equality.
//    /// - Returns: `true` if the two publishers’ prefix and suffix properties are equal, `false` otherwise.
//    public static func == (lhs: Publishers.Concatenate<Prefix, Suffix>, rhs: Publishers.Concatenate<Prefix, Suffix>) -> Bool
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Last : Equatable where Upstream : Equatable {
//
//    /// Returns a Boolean value that indicates whether two publishers are equivalent.
//    ///
//    /// - Parameters:
//    ///   - lhs: A last publisher to compare for equality.
//    ///   - rhs: Another last publisher to compare for equality.
//    /// - Returns: `true` if the two publishers have equal upstream publishers, `false` otherwise.
//    public static func == (lhs: Publishers.Last<Upstream>, rhs: Publishers.Last<Upstream>) -> Bool
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.PrefetchStrategy : Equatable {
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.PrefetchStrategy : Hashable {
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Sequence where Failure == Never {
//
//    public func min(by areInIncreasingOrder: (Publishers.Sequence<Elements, Failure>.Output, Publishers.Sequence<Elements, Failure>.Output) -> Bool) -> Optional<Publishers.Sequence<Elements, Failure>.Output>.Publisher
//
//    public func max(by areInIncreasingOrder: (Publishers.Sequence<Elements, Failure>.Output, Publishers.Sequence<Elements, Failure>.Output) -> Bool) -> Optional<Publishers.Sequence<Elements, Failure>.Output>.Publisher
//
//    public func first(where predicate: (Publishers.Sequence<Elements, Failure>.Output) -> Bool) -> Optional<Publishers.Sequence<Elements, Failure>.Output>.Publisher
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Sequence where Failure == Never, Elements.Element : Comparable {
//
//    public func min() -> Optional<Publishers.Sequence<Elements, Failure>.Output>.Publisher
//
//    public func max() -> Optional<Publishers.Sequence<Elements, Failure>.Output>.Publisher
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Sequence where Elements : Collection, Failure == Never {
//
//    public func first() -> Optional<Publishers.Sequence<Elements, Failure>.Output>.Publisher
//
//    public func output(at index: Elements.Index) -> Optional<Publishers.Sequence<Elements, Failure>.Output>.Publisher
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Sequence where Elements : Collection {
//
//    public func count() -> Result<Int, Failure>.Publisher
//
//    public func output(in range: Range<Elements.Index>) -> Publishers.Sequence<[Publishers.Sequence<Elements, Failure>.Output], Failure>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Sequence where Elements : BidirectionalCollection, Failure == Never {
//
//    public func last() -> Optional<Publishers.Sequence<Elements, Failure>.Output>.Publisher
//
//    public func last(where predicate: (Publishers.Sequence<Elements, Failure>.Output) -> Bool) -> Optional<Publishers.Sequence<Elements, Failure>.Output>.Publisher
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Sequence where Elements : RandomAccessCollection, Failure == Never {
//
//    public func output(at index: Elements.Index) -> Optional<Publishers.Sequence<Elements, Failure>.Output>.Publisher
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Sequence where Elements : RandomAccessCollection {
//
//    public func output(in range: Range<Elements.Index>) -> Publishers.Sequence<[Publishers.Sequence<Elements, Failure>.Output], Failure>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Sequence where Elements : RandomAccessCollection, Failure == Never {
//
//    public func count() -> Just<Int>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Sequence where Elements : RandomAccessCollection {
//
//    public func count() -> Result<Int, Failure>.Publisher
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Sequence where Elements : RangeReplaceableCollection {
//
//    public func prepend(_ elements: Publishers.Sequence<Elements, Failure>.Output...) -> Publishers.Sequence<Elements, Failure>
//
//    public func prepend<S>(_ elements: S) -> Publishers.Sequence<Elements, Failure> where S : Sequence, Elements.Element == S.Element
//
//    public func prepend(_ publisher: Publishers.Sequence<Elements, Failure>) -> Publishers.Sequence<Elements, Failure>
//
//    public func append(_ elements: Publishers.Sequence<Elements, Failure>.Output...) -> Publishers.Sequence<Elements, Failure>
//
//    public func append<S>(_ elements: S) -> Publishers.Sequence<Elements, Failure> where S : Sequence, Elements.Element == S.Element
//
//    public func append(_ publisher: Publishers.Sequence<Elements, Failure>) -> Publishers.Sequence<Elements, Failure>
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Sequence : Equatable where Elements : Equatable {
//
//    /// Returns a Boolean value indicating whether two values are equal.
//    ///
//    /// Equality is the inverse of inequality. For any values `a` and `b`,
//    /// `a == b` implies that `a != b` is `false`.
//    ///
//    /// - Parameters:
//    ///   - lhs: A value to compare.
//    ///   - rhs: Another value to compare.
//    public static func == (lhs: Publishers.Sequence<Elements, Failure>, rhs: Publishers.Sequence<Elements, Failure>) -> Bool
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Zip : Equatable where A : Equatable, B : Equatable {
//
//    /// Returns a Boolean value that indicates whether two publishers are equivalent.
//    ///
//    /// - Parameters:
//    ///   - lhs: A zip publisher to compare for equality.
//    ///   - rhs: Another zip publisher to compare for equality.
//    /// - Returns: `true` if the corresponding upstream publishers of each zip publisher are equal, `false` otherwise.
//    public static func == (lhs: Publishers.Zip<A, B>, rhs: Publishers.Zip<A, B>) -> Bool
//}
//
///// Returns a Boolean value that indicates whether two publishers are equivalent.
/////
///// - Parameters:
/////   - lhs: A zip publisher to compare for equality.
/////   - rhs: Another zip publisher to compare for equality.
///// - Returns: `true` if the corresponding upstream publishers of each zip publisher are equal, `false` otherwise.
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Zip3 : Equatable where A : Equatable, B : Equatable, C : Equatable {
//
//    /// Returns a Boolean value indicating whether two values are equal.
//    ///
//    /// Equality is the inverse of inequality. For any values `a` and `b`,
//    /// `a == b` implies that `a != b` is `false`.
//    ///
//    /// - Parameters:
//    ///   - lhs: A value to compare.
//    ///   - rhs: Another value to compare.
//    public static func == (lhs: Publishers.Zip3<A, B, C>, rhs: Publishers.Zip3<A, B, C>) -> Bool
//}
//
///// Returns a Boolean value that indicates whether two publishers are equivalent.
/////
///// - Parameters:
/////   - lhs: A zip publisher to compare for equality.
/////   - rhs: Another zip publisher to compare for equality.
///// - Returns: `true` if the corresponding upstream publishers of each zip publisher are equal, `false` otherwise.
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Zip4 : Equatable where A : Equatable, B : Equatable, C : Equatable, D : Equatable {
//
//    /// Returns a Boolean value indicating whether two values are equal.
//    ///
//    /// Equality is the inverse of inequality. For any values `a` and `b`,
//    /// `a == b` implies that `a != b` is `false`.
//    ///
//    /// - Parameters:
//    ///   - lhs: A value to compare.
//    ///   - rhs: Another value to compare.
//    public static func == (lhs: Publishers.Zip4<A, B, C, D>, rhs: Publishers.Zip4<A, B, C, D>) -> Bool
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.Output : Equatable where Upstream : Equatable {
//
//    /// Returns a Boolean value indicating whether two values are equal.
//    ///
//    /// Equality is the inverse of inequality. For any values `a` and `b`,
//    /// `a == b` implies that `a != b` is `false`.
//    ///
//    /// - Parameters:
//    ///   - lhs: A value to compare.
//    ///   - rhs: Another value to compare.
//    public static func == (lhs: Publishers.Output<Upstream>, rhs: Publishers.Output<Upstream>) -> Bool
//}
//
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Publishers.First : Equatable where Upstream : Equatable {
//
//    /// Returns a Boolean value that indicates whether two first publishers have equal upstream publishers.
//    ///
//    /// - Parameters:
//    ///   - lhs: A drop publisher to compare for equality.
//    ///   - rhs: Another drop publisher to compare for equality.
//    /// - Returns: `true` if the two publishers have equal upstream publishers, `false` otherwise.
//    public static func == (lhs: Publishers.First<Upstream>, rhs: Publishers.First<Upstream>) -> Bool
//}
//
///// A publisher that allows for recording a series of inputs and a completion for later playback to each subscriber.
//public struct Record<Output, Failure> : Publisher where Failure : Error {
//
//    /// The recorded output and completion.
//    public let recording: Record<Output, Failure>.Recording
//
//    /// Interactively record a series of outputs and a completion.
//    public init(record: (inout Record<Output, Failure>.Recording) -> Void)
//
//    /// Initialize with a recording.
//    public init(recording: Record<Output, Failure>.Recording)
//
//    /// Set up a complete recording with the specified output and completion.
//    public init(output: [Output], completion: Subscribers.Completion<Failure>)
//
//    /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//    ///
//    /// - SeeAlso: `subscribe(_:)`
//    /// - Parameters:
//    ///     - subscriber: The subscriber to attach to this `Publisher`.
//    ///                   once attached it can begin to receive values.
//    public func receive<S>(subscriber: S) where Output == S.Input, Failure == S.Failure, S : Subscriber
//
//    /// A recorded set of `Output` and a `Subscribers.Completion`.
//    public struct Recording {
//
//        public typealias Input = Output
//
//        /// The output which will be sent to a `Subscriber`.
//        public var output: [Output] { get }
//
//        /// The completion which will be sent to a `Subscriber`.
//        public var completion: Subscribers.Completion<Failure> { get }
//
//        /// Set up a recording in a state ready to receive output.
//        public init()
//
//        /// Set up a complete recording with the specified output and completion.
//        public init(output: [Output], completion: Subscribers.Completion<Failure> = .finished)
//
//        /// Add an output to the recording.
//        ///
//        /// A `fatalError` will be raised if output is added after adding completion.
//        public mutating func receive(_ input: Record<Output, Failure>.Recording.Input)
//
//        /// Add a completion to the recording.
//        ///
//        /// A `fatalError` will be raised if more than one completion is added.
//        public mutating func receive(completion: Subscribers.Completion<Failure>)
//    }
//}
//
//extension Record : Codable where Output : Decodable, Output : Encodable, Failure : Decodable, Failure : Encodable {
//
//    /// Creates a new instance by decoding from the given decoder.
//    ///
//    /// This initializer throws an error if reading from the decoder fails, or
//    /// if the data read is corrupted or otherwise invalid.
//    ///
//    /// - Parameter decoder: The decoder to read data from.
//    public init(from decoder: Decoder) throws
//
//    /// Encodes this value into the given encoder.
//    ///
//    /// If the value fails to encode anything, `encoder` will encode an empty
//    /// keyed container in its place.
//    ///
//    /// This function throws an error if any values are invalid for the given
//    /// encoder's format.
//    ///
//    /// - Parameter encoder: The encoder to write data to.
//    public func encode(to encoder: Encoder) throws
//}
//
//extension Record.Recording : Codable where Output : Decodable, Output : Encodable, Failure : Decodable, Failure : Encodable {
//
//    /// Creates a new instance by decoding from the given decoder.
//    ///
//    /// This initializer throws an error if reading from the decoder fails, or
//    /// if the data read is corrupted or otherwise invalid.
//    ///
//    /// - Parameter decoder: The decoder to read data from.
//    public init(from decoder: Decoder) throws
//
//    public func encode(into encoder: Encoder) throws
//
//    /// Encodes this value into the given encoder.
//    ///
//    /// If the value fails to encode anything, `encoder` will encode an empty
//    /// keyed container in its place.
//    ///
//    /// This function throws an error if any values are invalid for the given
//    /// encoder's format.
//    ///
//    /// - Parameter encoder: The encoder to write data to.
//    public func encode(to encoder: Encoder) throws
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Scheduler {
//
//    /// Performs the action at some time after the specified date, using the scheduler’s minimum tolerance.
//    public func schedule(after date: Self.SchedulerTimeType, _ action: @escaping () -> Void)
//
//    /// Performs the action at the next possible opportunity, without options.
//    public func schedule(_ action: @escaping () -> Void)
//
//    /// Performs the action at some time after the specified date.
//    public func schedule(after date: Self.SchedulerTimeType, tolerance: Self.SchedulerTimeType.Stride, _ action: @escaping () -> Void)
//
//    /// Performs the action at some time after the specified date, at the specified
//    /// frequency, taking into account tolerance if possible.
//    public func schedule(after date: Self.SchedulerTimeType, interval: Self.SchedulerTimeType.Stride, tolerance: Self.SchedulerTimeType.Stride, _ action: @escaping () -> Void) -> Cancellable
//
//    /// Performs the action at some time after the specified date, at the specified
//    /// frequency, using minimum tolerance possible for this Scheduler.
//    public func schedule(after date: Self.SchedulerTimeType, interval: Self.SchedulerTimeType.Stride, _ action: @escaping () -> Void) -> Cancellable
//}
//
//extension Subject where Self.Output == Void {
//
//    /// Signals subscribers.
//    public func send()
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Subscriber where Self.Input == Void {
//
//    public func receive() -> Subscribers.Demand
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Subscribers {
//
//    final public class Assign<Root, Input> : Subscriber, Cancellable, CustomStringConvertible, CustomReflectable, CustomPlaygroundDisplayConvertible {
//
//        /// The kind of errors this subscriber might receive.
//        ///
//        /// Use `Never` if this `Subscriber` cannot receive errors.
//        public typealias Failure = Never
//
//        final public var object: Root? { get }
//
//        final public let keyPath: ReferenceWritableKeyPath<Root, Input>
//
//        /// A textual representation of this instance.
//        ///
//        /// Calling this property directly is discouraged. Instead, convert an
//        /// instance of any type to a string by using the `String(describing:)`
//        /// initializer. This initializer works with any type, and uses the custom
//        /// `description` property for types that conform to
//        /// `CustomStringConvertible`:
//        ///
//        ///     struct Point: CustomStringConvertible {
//        ///         let x: Int, y: Int
//        ///
//        ///         var description: String {
//        ///             return "(\(x), \(y))"
//        ///         }
//        ///     }
//        ///
//        ///     let p = Point(x: 21, y: 30)
//        ///     let s = String(describing: p)
//        ///     print(s)
//        ///     // Prints "(21, 30)"
//        ///
//        /// The conversion of `p` to a string in the assignment to `s` uses the
//        /// `Point` type's `description` property.
//        final public var description: String { get }
//
//        /// The custom mirror for this instance.
//        ///
//        /// If this type has value semantics, the mirror should be unaffected by
//        /// subsequent mutations of the instance.
//        final public var customMirror: Mirror { get }
//
//        /// A custom playground description for this instance.
//        final public var playgroundDescription: Any { get }
//
//        public init(object: Root, keyPath: ReferenceWritableKeyPath<Root, Input>)
//
//        /// Tells the subscriber that it has successfully subscribed to the publisher and may request items.
//        ///
//        /// Use the received `Subscription` to request items from the publisher.
//        /// - Parameter subscription: A subscription that represents the connection between publisher and subscriber.
//        final public func receive(subscription: Subscription)
//
//        /// Tells the subscriber that the publisher has produced an element.
//        ///
//        /// - Parameter input: The published element.
//        /// - Returns: A `Demand` instance indicating how many more elements the subcriber expects to receive.
//        final public func receive(_ value: Input) -> Subscribers.Demand
//
//        /// Tells the subscriber that the publisher has completed publishing, either normally or with an error.
//        ///
//        /// - Parameter completion: A `Completion` case indicating whether publishing completed normally or with an error.
//        final public func receive(completion: Subscribers.Completion<Never>)
//
//        /// Cancel the activity.
//        final public func cancel()
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Subscribers.Completion : Equatable where Failure : Equatable {
//
//    /// Returns a Boolean value indicating whether two values are equal.
//    ///
//    /// Equality is the inverse of inequality. For any values `a` and `b`,
//    /// `a == b` implies that `a != b` is `false`.
//    ///
//    /// - Parameters:
//    ///   - lhs: A value to compare.
//    ///   - rhs: Another value to compare.
//    public static func == (a: Subscribers.Completion<Failure>, b: Subscribers.Completion<Failure>) -> Bool
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Subscribers.Completion : Hashable where Failure : Hashable {
//
//    /// The hash value.
//    ///
//    /// Hash values are not guaranteed to be equal across different executions of
//    /// your program. Do not save hash values to use during a future execution.
//    ///
//    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
//    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
//    public var hashValue: Int { get }
//
//    /// Hashes the essential components of this value by feeding them into the
//    /// given hasher.
//    ///
//    /// Implement this method to conform to the `Hashable` protocol. The
//    /// components used for hashing must be the same as the components compared
//    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
//    /// with each of these components.
//    ///
//    /// - Important: Never call `finalize()` on `hasher`. Doing so may become a
//    ///   compile-time error in the future.
//    ///
//    /// - Parameter hasher: The hasher to use when combining the components
//    ///   of this instance.
//    public func hash(into hasher: inout Hasher)
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Subscribers.Completion : Encodable where Failure : Encodable {
//
//    /// Encodes this value into the given encoder.
//    ///
//    /// If the value fails to encode anything, `encoder` will encode an empty
//    /// keyed container in its place.
//    ///
//    /// This function throws an error if any values are invalid for the given
//    /// encoder's format.
//    ///
//    /// - Parameter encoder: The encoder to write data to.
//    public func encode(to encoder: Encoder) throws
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Subscribers.Completion : Decodable where Failure : Decodable {
//
//    /// Creates a new instance by decoding from the given decoder.
//    ///
//    /// This initializer throws an error if reading from the decoder fails, or
//    /// if the data read is corrupted or otherwise invalid.
//    ///
//    /// - Parameter decoder: The decoder to read data from.
//    public init(from decoder: Decoder) throws
//}
//
///// MARK: -
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//public enum Subscriptions {
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Subscriptions {
//
//    /// Returns the 'empty' subscription.
//    ///
//    /// Use the empty subscription when you need a `Subscription` that ignores requests and cancellation.
//    public static var empty: Subscription { get }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Optional {
//
//    /// A publisher that publishes an optional value to each subscriber exactly once, if the optional has a value.
//    ///
//    /// In contrast with `Just`, an `Optional` publisher may send no value before completion.
//    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//    public struct Publisher : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Wrapped
//
//        /// The kind of errors this publisher might publish.
//        ///
//        /// Use `Never` if this `Publisher` does not publish errors.
//        public typealias Failure = Never
//
//        /// The result to deliver to each subscriber.
//        public let output: Wrapped?
//
//        /// Creates a publisher to emit the optional value of a successful result, or fail with an error.
//        ///
//        /// - Parameter result: The result to deliver to each subscriber.
//        public init(_ output: Optional<Wrapped>.Publisher.Output?)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where Wrapped == S.Input, S : Subscriber, S.Failure == Optional<Wrapped>.Publisher.Failure
//    }
//}
//
//@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//extension Result {
//
//    public var publisher: Result<Success, Failure>.Publisher { get }
//
//    /// A publisher that publishes an output to each subscriber exactly once then finishes, or fails immediately without producing any elements.
//    ///
//    /// If `result` is `.success`, then `Once` waits until it receives a request for at least 1 value before sending the output. If `result` is `.failure`, then `Once` sends the failure immediately upon subscription.
//    ///
//    /// In contrast with `Just`, a `Once` publisher can terminate with an error instead of sending a value.
//    /// In contrast with `Optional`, a `Once` publisher always sends one value (unless it terminates with an error).
//    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
//    public struct Publisher : Publisher {
//
//        /// The kind of values published by this publisher.
//        public typealias Output = Success
//
//        /// The result to deliver to each subscriber.
//        public let result: Result<Success, Failure>
//
//        /// Creates a publisher that delivers the specified result.
//        ///
//        /// If the result is `.success`, the `Once` publisher sends the specified output to all subscribers and finishes normally. If the result is `.failure`, then the publisher fails immediately with the specified error.
//        /// - Parameter result: The result to deliver to each subscriber.
//        public init(_ result: Result<Result<Success, Failure>.Publisher.Output, Failure>)
//
//        /// Creates a publisher that sends the specified output to all subscribers and finishes normally.
//        ///
//        /// - Parameter output: The output to deliver to each subscriber.
//        public init(_ output: Result<Success, Failure>.Publisher.Output)
//
//        /// Creates a publisher that immediately terminates upon subscription with the given failure.
//        ///
//        /// - Parameter failure: The failure to send when terminating.
//        public init(_ failure: Failure)
//
//        /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
//        ///
//        /// - SeeAlso: `subscribe(_:)`
//        /// - Parameters:
//        ///     - subscriber: The subscriber to attach to this `Publisher`.
//        ///                   once attached it can begin to receive values.
//        public func receive<S>(subscriber: S) where Success == S.Input, Failure == S.Failure, S : Subscriber
//    }
//}
//
