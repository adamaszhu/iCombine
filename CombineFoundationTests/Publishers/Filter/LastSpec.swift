//
//  LastSpec.swift
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

final class LastSpec: QuickSpec {
    
    override func spec() {
        describe("calls last()") {
            context("with values") {
                it("get the last value") {
                    let result = Publishers
                        .Sequence<[Int], Never>(sequence: [1, 2, 3])
                        .last()
                        .test()
                    expect(result.outputs.last).toEventually(equal(3))
                }
            }
        }
        describe("calls last(where)") {
            context("with with conditions") {
                it("get the last value") {
                    let result = Publishers
                        .Sequence<[Int], Never>(sequence: [1, 2, 3])
                        .last(where: { $0 == 2})
                        .test()
                    expect(result.outputs.last).toEventually(equal(2))
                }
            }
        }
        describe("calls tryLast(where)") {
            context("with with conditions") {
                it("get the last value") {
                    let result = Publishers
                        .Sequence<[Int], Never>(sequence: [1, 2, 3])
                        .tryLast(where: { $0 == 2})
                        .test()
                    expect(result.outputs.last).toEventually(equal(2))
                }
            }
        }
    }
}
