//
//  AnySubscriberSpec.swift
//  CombineFoundationTests
//
//  Created by Adamas Zhu on 16/8/21.
//

import Nimble
import Quick

#if COMBINE
import Combine
#else
@testable import CombineFoundation
#endif

final class AnySubscriberSpec: QuickSpec {
    
    override func spec() {
        describe("calls init()") {
            context("with a subscriber") {
                it("creates a correct subscriber") {
                    let result = PublisherResult<Int, Never, Cancellable>()
                    let sink = Subscribers.Sink<Int, Never>(
                        receiveCompletion: { completion in
                            switch completion {
                            case .finished:
                                result.hasFinished = true
                            default:
                                return
                            }
                    },
                        receiveValue: { output in
                            result.outputs.append(output)
                    })
                    let anySubscriber = AnySubscriber(sink)
                    let _ = Just<Int>(1).subscribe(anySubscriber)
                    
                    expect(result.hasFinished).toEventually(equal(true))
                    expect(result.outputs.last).toEventually(equal(1))
                }
            }
        }
    }
}
