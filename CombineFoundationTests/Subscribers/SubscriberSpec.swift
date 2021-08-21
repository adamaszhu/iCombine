//
//  SubscriberSpec.swift
//  CombineFoundationTests
//
//  Created by Adamas Zhu on 17/8/21.
//

import Nimble
import Quick

#if COMBINE
import Combine
#else
@testable import CombineFoundation
#endif

final class SubscriberSpec: QuickSpec {
    
    override func spec() {
        describe("calls receive(completion:)") {
            context("with an error"){
                it("sends the error") {
                    let result = PublisherResult<Int?, TestError, Cancellable>()
                    let subscriber = Subscribers.Sink<Int?, TestError>(receiveCompletion: { completion in
                        switch completion {
                        case let .failure(error):
                            result.failure = error
                        case .finished:
                            result.hasFinished = true
                        }
                    }, receiveValue: { value in
                        result.outputs.append(value)
                    })
                    subscriber.receive(completion: .failure(TestError.one))
                    expect(result.failure).toEventually(equal(.one))
                }
            }
            context("with a completion"){
                it("sends the completion") {
                    let result = PublisherResult<Int?, TestError, Cancellable>()
                    let subscriber = Subscribers.Sink<Int?, TestError>(receiveCompletion: { completion in
                        switch completion {
                        case let .failure(error):
                            result.failure = error
                        case .finished:
                            result.hasFinished = true
                        }
                    }, receiveValue: { value in
                        result.outputs.append(value)
                    })
                    subscriber.receive(completion: .finished)
                    expect(result.hasFinished).toEventually(equal(true))
                }
            }
        }
    }
}
