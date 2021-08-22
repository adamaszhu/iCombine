//
//  AnyCancellable.swift
//  CombineFoundation
//
//  Created by Adamas Zhu on 5/8/21.
//

import RxCocoa
import RxSwift
#if canImport(Combine)
import Combine
#endif

/// A type-erasing cancellable object that executes a provided closure when canceled.
///
/// Subscriber implementations can use this type to provide a “cancellation token” that makes it possible for a caller to cancel a publisher, but not to use the `Subscription` object to request items.
/// An AnyCancellable instance automatically calls `cancel()` when deinitialized.
final public class AnyCancellable : Cancellable, Hashable {
    
    public var disposable: Any?

    /// Initializes the cancellable object with the given cancel-time closure.
    ///
    /// - Parameter cancel: A closure that the `cancel()` method executes.
    // public init(_ cancel: @escaping () -> Void)

    public init<C>(_ canceller: C) where C : Cancellable {
        self.disposable = canceller.disposable
    }

    /// Cancel the activity.
    final public func cancel() {
        #if canImport(Combine)
        if #available(iOS 14, *),
           let cancellable = disposable as? Combine.Cancellable {
            cancellable.cancel()
            return
        }
        #endif
        if let disposable = disposable as? Disposable {
            disposable.dispose()
        }
    }

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: Never call `finalize()` on `hasher`. Doing so may become a
    ///   compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    final public func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: disposable))
    }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: AnyCancellable, rhs: AnyCancellable) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    deinit {
        cancel()
    }
}
