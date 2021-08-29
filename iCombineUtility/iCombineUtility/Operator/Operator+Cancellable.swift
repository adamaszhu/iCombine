/// Operator+Cancellable.swift
/// CombineUtility
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

import iCombine

/// Append a cancellable object to a collection
/// - Parameters:
///   - cancellables: The collection
///   - cancellable: The new cancellable object
public func += (cancellables: inout [iCombine.Cancellable], cancellable: iCombine.Cancellable) {
    cancellables.append(cancellable)
}

#if canImport(Combine)

import Combine

@available(iOS 13.0, *)
/// Append a cancellable object to a collection
/// - Parameters:
///   - cancellables: The collection
///   - cancellable: The new cancellable object
public func += (cancellables: inout [Combine.Cancellable], cancellable: Combine.Cancellable) {
    cancellables.append(cancellable)
}

#endif
