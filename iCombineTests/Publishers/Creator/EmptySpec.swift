//
//  EmptySpec.swift
//  iCombineTests
//
//  Created by Leon Nguyen on 8/8/21.
//

import Nimble
import Quick

#if COMBINE
import Combine
#else
@testable import iCombine
#endif

final class EmptySpec: QuickSpec {

    override func spec() {
        describe("calls init(completeImmediately:outputType:failureType)") {
            context("with immediately complete") {
                it("finishes immediately") {
                    let result = Empty(completeImmediately: true, outputType: Int.self, failureType: TestError.self)
                        .test()
                    expect(result.hasFinished).toEventually(equal(true))
                }
            }
        }
        describe("calls init(completeImmediately:outputType:failureType)") {
            context("without immediately complete") {
                it("never finishes") {
                    let result = Empty(completeImmediately: false, outputType: Int.self, failureType: TestError.self)
                        .test()
                    expect(result.hasFinished).toEventually(equal(false))
                }
            }
        }
        describe("calls init(completeImmediately)") {
            context("with immediately complete") {
                it("finishes immediately") {
                    let result = Empty<Int, TestError>(completeImmediately: true)
                        .test()
                    expect(result.hasFinished).toEventually(equal(true))
                }
            }
        }
        describe("calls init(completeImmediately)") {
            context("without immediately complete") {
                it("never finishes") {
                    let result = Empty<Int, TestError>(completeImmediately: false)
                        .test()
                    expect(result.hasFinished).toEventually(equal(false))
                }
            }
        }
    }
}
