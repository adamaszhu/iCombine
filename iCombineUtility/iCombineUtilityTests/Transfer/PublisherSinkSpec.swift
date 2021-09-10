/// PublisherSinkSpec.swift
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

@available(iOS 14.0, macOS 10.15, *)
final class PublisherSinkSpec: QuickSpec {
    
    override func spec() {
        describe("calls sink(receiveFinished:receiveFailure:receiveValue)") {
            context("with a value") {
                it("gets the value") {
                    var value: Int?
                    let _ = Just<Int>(0)
                        .sink(receiveValue: { value = $0 })
                    expect(value).toEventually(equal(0))
                }
                it("finishes") {
                    var isFinished = false
                    let _ = Just<Int>(0)
                        .sink(receiveFinished: { isFinished = true })
                    expect(isFinished).toEventually(beTrue())
                }
            }
            context("with an error") {
                it("gets no value") {
                    var value: Int?
                    let _ = Fail<Int, SomeError>(error: SomeError())
                        .sink(receiveValue: { value = $0 })
                    expect(value).toEventually(beNil())
                }
                it("doesn't finish") {
                    var isFinished = false
                    let _ = Fail<Int, SomeError>(error: SomeError())
                        .sink(receiveFinished: { isFinished = true })
                    expect(isFinished).toEventually(beFalse())
                }
                it("gets the error") {
                    var error: SomeError?
                    let _ = Fail<Int, SomeError>(error: SomeError())
                        .sink(receiveFailure: { error = $0 })
                    expect(error).toEventuallyNot(beNil())
                }
            }
        }
    }
}
