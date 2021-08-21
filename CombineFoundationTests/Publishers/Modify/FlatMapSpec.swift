//
//  FlatMapSpec.swift
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

final class FlatMapSpec: QuickSpec {

    override func spec() {
        describe("calls flatMap()") {
            context("with a producer") {
                it("does the mapping") {
                    let intPublisher = Publishers.Sequence<[Int], Never>(sequence: [1, 2, 3])
                    let stringPublisher = Publishers.Sequence<[String], Never>(sequence: ["String1", "String2"])
                    let result = intPublisher
                        .flatMap { _ in stringPublisher }
                        .test()
                    expect(result.outputs.count).toEventually(equal(6))
                }
            }
        }
    }
}
