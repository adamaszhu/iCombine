//
//  DropSpec.swift
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

final class DropSpec: QuickSpec {
    
    override func spec() {
        describe("calls dropFirst(count)") {
            context("with enough amount") {
                it("drops those elements") {
                    let result = Publishers
                        .Sequence<[Int], Never>(sequence: [1, 2, 3, 4, 5])
                        .dropFirst(2)
                        .test()
                    expect(result.outputs.count).toEventually(equal(3))
                }
            }
        }
        describe("calls drop(untilOutputFrom)") {
            context("with inputs") {
                it("drops those elements") {
                    let currentValueSubject = CurrentValueSubject<Int, Never>(1)
                    let result = Publishers
                        .Sequence<[Int], Never>(sequence: [1, 2, 3, 4, 5])
                        .drop(untilOutputFrom: currentValueSubject)
                        .test()
                    expect(result.outputs.count).toEventually(equal(5))
                }
            }
        }
        describe("calls drop(while)") {
            context("with success predicate") {
                it("drops those elements") {
                    let result = Publishers
                        .Sequence<[Int], Never>(sequence: [1, 2, 3, 4, 5])
                        .drop { _ in true }
                        .test()
                    expect(result.outputs.count).toEventually(equal(0))
                }
            }
            context("with fail predicate") {
                it("doesn't drop those elements") {
                    let result = Publishers
                        .Sequence<[Int], Never>(sequence: [1, 2, 3, 4, 5])
                        .drop { _ in false }
                        .test()
                    expect(result.outputs.count).toEventually(equal(5))
                }
            }
        }
    }
}
