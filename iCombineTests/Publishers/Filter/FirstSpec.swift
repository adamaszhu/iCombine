//
//  FirstSpec.swift
//  iCombineTests
//
//  Created by Adamas Zhu on 16/8/21.
//

import Nimble
import Quick

#if COMBINE
import Combine
#else
@testable import iCombine
#endif

final class FirstSpec: QuickSpec {
    
    override func spec() {
        describe("calls first()") {
            context("with values") {
                it("get the value") {
                    let result = Publishers
                        .Sequence<[Int], Never>(sequence: [1, 2, 3])
                        .first()
                        .test()
                    expect(result.outputs.last).toEventually(equal(1))
                }
            }
        }
        describe("calls first(where)") {
            context("with with conditions") {
                it("get the value") {
                    let result = Publishers
                        .Sequence<[Int], Never>(sequence: [1, 2, 3])
                        .first(where: { $0 == 2})
                        .test()
                    expect(result.outputs.last).toEventually(equal(2))
                }
            }
        }
        describe("calls tryFirst(where)") {
            context("with with conditions") {
                it("get the value") {
                    let result = Publishers
                        .Sequence<[Int], Never>(sequence: [1, 2, 3])
                        .tryFirst(where: { $0 == 2})
                        .test()
                    expect(result.outputs.last).toEventually(equal(2))
                }
            }
        }
    }
}
