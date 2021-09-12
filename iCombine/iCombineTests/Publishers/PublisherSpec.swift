//
//  PublisherSpec.swift
//  iCombineTests
//
//  Created by Adamas Zhu on 17/8/21.
//

import Nimble
import Quick

#if COMBINE
import Combine
#else
@testable import iCombine
#endif

final class PublisherSpec: QuickSpec {

    override func spec() {
        describe("calls subscribe(:)") {
            context("receives a value") {
                it("passes the value") {
                    let subject = CurrentValueSubject<Int?, Error>(nil)
                    let result = PublisherResult<Int?, Error, Cancellable>()
                    let subscriber = Subscribers.Sink<Int?, Error>(receiveCompletion: { completion in
                        switch completion {
                        case let .failure(error):
                            result.failure = error
                        case .finished:
                            result.hasFinished = true
                        }
                    }, receiveValue: { value in
                        result.outputs.append(value)
                    })
                    subject.subscribe(subscriber)
                    subject.value = 1
                    expect(result.outputs.last).toEventually(equal(1))
                }
            }
        }
        describe("calls receive(:)") {
            context("receives a value") {
                it("passes the value") {
                    let subject = CurrentValueSubject<Int?, Error>(nil)
                    let result = PublisherResult<Int?, Error, Cancellable>()
                    let subscriber = Subscribers.Sink<Int?, Error>(receiveCompletion: { completion in
                        switch completion {
                        case let .failure(error):
                            result.failure = error
                        case .finished:
                            result.hasFinished = true
                        }
                    }, receiveValue: { value in
                        result.outputs.append(value)
                    })
                    subject.receive(subscriber: subscriber)
                    subject.value = 1
                    expect(result.outputs.last).toEventually(equal(1))
                }
            }
        }
    }
}
