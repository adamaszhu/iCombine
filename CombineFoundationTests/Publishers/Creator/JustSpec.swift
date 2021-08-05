//
//  JustSpec.swift
//  CombineFoundationTests
//
//  Created by Leon Nguyen on 5/8/21.
//

import Nimble
import Quick

#if COMBINE
import Combine
#else
@testable import CombineFoundation
#endif

final class JustSpec: QuickSpec {

    override func spec() {
        describe("calls first()") {
            context("with a just publisher") {
                it("returns a just publisher") {
                    let result = Just(1)
                        .first()
                        .test()
                    expect(result.outputs.count).toEventually(equal(1))
                }
            }
        }
        describe("calls last()") {
            context("with with a just publisher") {
                it("returns a just publisher") {
                    let result = Just(1)
                        .last()
                        .test()
                    expect(result.outputs.count).toEventually(equal(1))
                }
            }
        }
        describe("calls map(transform)") {
            context("with a transform") {
                it("returns a new just publisher") {
                    let result = Just(1)
                        .map { String($0) }
                        .test()
                    expect(result.outputs.count).toEventually(equal(1))
                    expect(result.outputs.last).toEventually(equal("1"))
                }
            }
        }
    }
}
