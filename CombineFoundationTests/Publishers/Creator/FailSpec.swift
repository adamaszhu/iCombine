//
//  FailSpec.swift
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

final class FailSpec: QuickSpec {

    override func spec() {
        describe("calls init(error)") {
            context("with an error") {
                it("emits the error") {
                    let result = Fail<Int, Error>(error: TestError.one)
                        .test()
                    expect(result.failure).toEventuallyNot(beNil())
                }
            }
        }
        describe("calls init(outputType:failure)") {
            context("with an error") {
                it("emits the error") {
                    let result = Fail(outputType: Int.self, failure: TestError.one)
                        .test()
                    expect(result.failure).toEventuallyNot(beNil())
                }
            }
        }
    }
}
