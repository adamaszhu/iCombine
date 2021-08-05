//
//  PublisherResult.swift
//  CombineFoundationTests
//
//  Created by Leon Nguyen on 5/8/21.
//

import Foundation

/// PublisherResult records events emitted by a publisher.
/// - Warning: This class doesn't belong to Combine and need to be implemented manually after migrating to Combine.
final class PublisherResult<Output, Failure, Cancellable> {
    var outputs: [Output] = []
    var failure: Failure? = nil
    var hasFinished: Bool = false
    var cancellable: Cancellable? = nil
}
