//
//  FilterSpec.swift
//  iCombine
//
//  Created by Leon Nguyen on 11/8/21.
//

import Nimble
import Quick

#if COMBINE
import Combine
#else
@testable import iCombine
#endif

final class FilterSpec: QuickSpec {

    override func spec() {
        describe("calls filter()") {
            context("with valid condition") {
                it("returns the value") {
                    let result = Publishers
                        .Sequence<[Int], Never>(sequence: [1, 2, 3])
                        .filter { $0 == 2 }
                        .test()
                    expect(result.outputs.last).toEventually(equal(2))
                }
            }
        }
        describe("calls tryFilter()") {
            context("with valid condition") {
                it("returns the value") {
                    let result = Publishers
                        .Sequence<[Int], Never>(sequence: [1, 2, 3])
                        .tryFilter { $0 == 2 }
                        .test()
                    expect(result.outputs.last).toEventually(equal(2))
                }
            }
        }
    }
}
