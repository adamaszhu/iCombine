//
//  Demand.swift
//  CombineFoundation
//
//  Created by Leon Nguyen on 11/8/21.
//

import RxCocoa
import RxSwift

extension Subscribers {

    /// A requested number of items, sent to a publisher from a subscriber via the subscription.
    ///
    /// - unlimited: A request for an unlimited number of items.
    /// - max: A request for a maximum number of items.
    public struct Demand : Equatable, Comparable, Hashable, Codable {

        /// Requests as many values as the `Publisher` can produce.
         public static let unlimited: Subscribers.Demand = Subscribers.Demand()

        /// A demand for no items.
        ///
        /// This is equivalent to `Demand.max(0)`.
        // public static let none: Subscribers.Demand

        /// Limits the maximum number of values.
        /// The `Publisher` may send fewer than the requested number.
        /// Negative values will result in a `fatalError`.
        // @inlinable public static func max(_ value: Int) -> Subscribers.Demand

        /// A textual representation of this instance.
        ///
        /// Calling this property directly is discouraged. Instead, convert an
        /// instance of any type to a string by using the `String(describing:)`
        /// initializer. This initializer works with any type, and uses the custom
        /// `description` property for types that conform to
        /// `CustomStringConvertible`:
        ///
        ///     struct Point: CustomStringConvertible {
        ///         let x: Int, y: Int
        ///
        ///         var description: String {
        ///             return "(\(x), \(y))"
        ///         }
        ///     }
        ///
        ///     let p = Point(x: 21, y: 30)
        ///     let s = String(describing: p)
        ///     print(s)
        ///     // Prints "(21, 30)"
        ///
        /// The conversion of `p` to a string in the assignment to `s` uses the
        /// `Point` type's `description` property.
        // public var description: String { get }

        /// When adding any value to .unlimited, the result is .unlimited.
        // @inlinable public static func + (lhs: Subscribers.Demand, rhs: Subscribers.Demand) -> Subscribers.Demand

        /// When adding any value to .unlimited, the result is .unlimited.
        // @inlinable public static func += (lhs: inout Subscribers.Demand, rhs: Subscribers.Demand)

        /// When adding any value to .unlimited, the result is .unlimited.
        // @inlinable public static func + (lhs: Subscribers.Demand, rhs: Int) -> Subscribers.Demand

        /// When adding any value to .unlimited, the result is .unlimited.
        // @inlinable public static func += (lhs: inout Subscribers.Demand, rhs: Int)

        // public static func * (lhs: Subscribers.Demand, rhs: Int) -> Subscribers.Demand

        // @inlinable public static func *= (lhs: inout Subscribers.Demand, rhs: Int)

        /// When subtracting any value (including .unlimited) from .unlimited, the result is still .unlimited. Subtracting unlimited from any value (except unlimited) results in .max(0). A negative demand is not possible; any operation that would result in a negative value is clamped to .max(0).
        // @inlinable public static func - (lhs: Subscribers.Demand, rhs: Subscribers.Demand) -> Subscribers.Demand

        /// When subtracting any value (including .unlimited) from .unlimited, the result is still .unlimited. Subtracting unlimited from any value (except unlimited) results in .max(0). A negative demand is not possible; any operation that would result in a negative value is clamped to .max(0).
        // @inlinable public static func -= (lhs: inout Subscribers.Demand, rhs: Subscribers.Demand)

        /// When subtracting any value from .unlimited, the result is still .unlimited. A negative demand is possible, but be aware that it is not usable when requesting values in a subscription.
        // @inlinable public static func - (lhs: Subscribers.Demand, rhs: Int) -> Subscribers.Demand

        /// When subtracting any value from .unlimited, the result is still .unlimited. A negative demand is not possible; any operation that would result in a negative value is clamped to .max(0)
        // @inlinable public static func -= (lhs: inout Subscribers.Demand, rhs: Int)

        // @inlinable public static func > (lhs: Subscribers.Demand, rhs: Int) -> Bool

        // @inlinable public static func >= (lhs: Subscribers.Demand, rhs: Int) -> Bool

        // @inlinable public static func > (lhs: Int, rhs: Subscribers.Demand) -> Bool

        // @inlinable public static func >= (lhs: Int, rhs: Subscribers.Demand) -> Bool

        // @inlinable public static func < (lhs: Subscribers.Demand, rhs: Int) -> Bool

        // @inlinable public static func < (lhs: Int, rhs: Subscribers.Demand) -> Bool

        // @inlinable public static func <= (lhs: Subscribers.Demand, rhs: Int) -> Bool

        // @inlinable public static func <= (lhs: Int, rhs: Subscribers.Demand) -> Bool

        /// If lhs is .unlimited, then the result is always false. If rhs is .unlimited then the result is always false. Otherwise, the two max values are compared.
        @inlinable public static func < (lhs: Subscribers.Demand, rhs: Subscribers.Demand) -> Bool  {
            return false
        }

        /// If lhs is .unlimited and rhs is .unlimited then the result is true. Otherwise, the rules for < are followed.
        // @inlinable public static func <= (lhs: Subscribers.Demand, rhs: Subscribers.Demand) -> Bool

        /// Returns a Boolean value that indicates whether the value of the first
        /// argument is greater than or equal to that of the second argument.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        // @inlinable public static func >= (lhs: Subscribers.Demand, rhs: Subscribers.Demand) -> Bool

        /// If rhs is .unlimited, then the result is always false. If lhs is .unlimited then the result is always false. Otherwise, the two max values are compared.
        // @inlinable public static func > (lhs: Subscribers.Demand, rhs: Subscribers.Demand) -> Bool

        /// Returns `true` if `lhs` and `rhs` are equal. `.unlimited` is not equal to any integer.
        // @inlinable public static func == (lhs: Subscribers.Demand, rhs: Int) -> Bool

        /// Returns `true` if `lhs` and `rhs` are not equal. `.unlimited` is not equal to any integer.
        // @inlinable public static func != (lhs: Subscribers.Demand, rhs: Int) -> Bool

        /// Returns `true` if `lhs` and `rhs` are equal. `.unlimited` is not equal to any integer.
        // @inlinable public static func == (lhs: Int, rhs: Subscribers.Demand) -> Bool

        /// Returns `true` if `lhs` and `rhs` are not equal. `.unlimited` is not equal to any integer.
        // @inlinable public static func != (lhs: Int, rhs: Subscribers.Demand) -> Bool

        /// Returns the number of requested values, or nil if unlimited.
        // @inlinable public var max: Int? { get }

        /// Creates a new instance by decoding from the given decoder.
        ///
        /// This initializer throws an error if reading from the decoder fails, or
        /// if the data read is corrupted or otherwise invalid.
        ///
        /// - Parameter decoder: The decoder to read data from.
        // public init(from decoder: Decoder) throws

        /// Encodes this value into the given encoder.
        ///
        /// If the value fails to encode anything, `encoder` will encode an empty
        /// keyed container in its place.
        ///
        /// This function throws an error if any values are invalid for the given
        /// encoder's format.
        ///
        /// - Parameter encoder: The encoder to write data to.
        // public func encode(to encoder: Encoder) throws

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: Subscribers.Demand, b: Subscribers.Demand) -> Bool  {
            return false
        }

        /// The hash value.
        ///
        /// Hash values are not guaranteed to be equal across different executions of
        /// your program. Do not save hash values to use during a future execution.
        ///
        /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
        ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
        // public var hashValue: Int { get }

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
        // public func hash(into hasher: inout Hasher)
    }
}
