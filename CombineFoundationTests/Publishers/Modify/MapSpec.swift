//
//  MapSpec.swift
//  CombineFoundation
//
//  Created by Leon Nguyen on 11/8/21.
//

import Nimble
import Quick
#if COMBINE
import Combine
#else
@testable import CombineFoundation
#endif

final class MapSpec: QuickSpec {

    override func spec() {
        describe("calls Map") {
            context("with a publisher") {
                it("produce correct value") {
                    let intPublisher = Publishers.Sequence<[Int], Never>(sequence: [1, 2, 3])
                    let mappedPublisher = Publishers.Map(upstream: intPublisher) { $0 + 1 }
                    let result = mappedPublisher.test()
                    expect(result.outputs.count).toEventually(equal(3))
                    expect(result.outputs[0]).toEventually(equal(2))
                }
            }
        }
        describe("calls .tryMap") {
            context("with a Sequence publisher") {
                it("produce correct value") {
                    enum SimpleError: Error { case error }
                    let array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                    let errorPublisher = Publishers.Sequence<[Int], Error>(sequence: array)
                        .tryMap { v -> Int in
                            if v < 5 {
                                return v
                            } else {
                                throw SimpleError.error
                            }
                    }

                    let result = errorPublisher.test()
                    expect(result.hasFinished).toEventually(beFalse())
                    expect(result.failure).toEventuallyNot(beNil())
                    expect((result.failure as? SimpleError)).toEventually(equal(SimpleError.error))
                    expect(result.outputs.count).toEventually(equal(5))
                    expect(result.outputs[0]).toEventually(equal(0))
                }
            }
        }
        describe("calls .map") {
            context("with a Map") {
                it("produce correct value") {
                    let intPublisher = Publishers.Sequence<[Int], Never>(sequence: [1, 2, 3])
                    let mappedPublisher = Publishers.Map(upstream: intPublisher) { $0 + 1 }
                    let mappedPublisher2 = mappedPublisher.map({ $0 + 1 })
                    let result = mappedPublisher2.test()
                    expect(result.outputs.count).toEventually(equal(3))
                    expect(result.outputs[0]).toEventually(equal(3))
                }
            }
        }
    }
}
