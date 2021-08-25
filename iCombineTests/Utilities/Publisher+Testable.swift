//
//  Publisher+Testable.swift
//  iCombineTests
//
//  Created by Leon Nguyen on 5/8/21.
//

import iCombine

extension iCombine.Publisher {

    /// Sink a publisher and record any result in `PublisherResult`
    ///
    /// - Warning: This class doesn't belong to Combine and need to be implemented manually after migrating to Combine.
    /// - Returns: The object that contains any events happening in the result
    func test() -> PublisherResult<Output, Failure, iCombine.Cancellable> {
        let result = PublisherResult<Output, Failure, iCombine.Cancellable>()
        result.cancellable = sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    result.hasFinished = true
                case .failure(let failure):
                    result.failure = failure
                }
            },
            receiveValue: { output in
                result.outputs.append(output)
        })
        return result
    }
}

import Combine

@available(iOS 13, *)
extension Combine.Publisher {

    /// Sink a publisher and record any result in `PublisherResult`
    ///
    /// - Warning: This class doesn't belong to Combine and need to be implemented manually after migrating to Combine.
    /// - Returns: The object that contains any events happening in the result
    func test() -> PublisherResult<Output, Failure, Combine.Cancellable> {
        let result = PublisherResult<Output, Failure, Combine.Cancellable>()
        result.cancellable = sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    result.hasFinished = true
                case .failure(let failure):
                    result.failure = failure
                }
            },
            receiveValue: { output in
                result.outputs.append(output)
        })
        return result
    }
}
