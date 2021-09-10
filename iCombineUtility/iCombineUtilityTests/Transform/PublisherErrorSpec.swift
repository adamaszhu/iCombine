/// PublisherErrorSpec.swift
/// CombineUtility
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

import Nimble
import Quick
@testable import iCombineUtility

#if COMBINE
import Combine
#else
import iCombine
#endif

@available(iOS 13.0, *)
final class PublisherErrorSpec: QuickSpec {
    
    override func spec() {
        describe("calls mapError(into)") {
            context("with an error") {
                it("returns a publisher with correct error type") {
                    let result = Fail<Int, OtherError>(error: OtherError())
                        .mapError(into: SomeError())
                        .test()
                    expect(result.failure).toEventually(equal(SomeError()))
                }
            }
        }
        describe("calls ignoreError()") {
            context("with an error") {
                it("returns a publisher without any error") {
                    let result = Fail<Int, OtherError>(error: OtherError())
                        .ignoreError()
                        .test()
                    expect(result.failure).toEventually(beNil())
                }
            }
        }
    }
}
