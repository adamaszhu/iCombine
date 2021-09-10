/// PublisherConstantsSpec.swift
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
final class PublisherConstantsSpec: QuickSpec {
    
    override func spec() {
        describe("has empty") {
            context("with a publisher type") {
                it("returns an empty publisher") {
                    let publisher = AnyPublisher<Int, Never>.empty
                    let result = publisher.test()
                    expect(result.outputs.isEmpty).toEventually(equal(true))
                }
            }
        }
    }
}
