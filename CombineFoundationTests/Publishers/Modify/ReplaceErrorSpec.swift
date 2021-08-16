//
//  ReplaceErrorSpec.swift
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

final class ReplaceErrorSpec: QuickSpec {
    
    override func spec() {
        describe("calls replaceError(with)") {
            context("with an error") {
                it("replaces the value") {
                    let result = Just(1)
                        .tryMap { _ in throw TestError.one }
                        .replaceError(with: 2)
                        .test()
                    expect(result.outputs.last).toEventually(equal(2))
                }
            }
        }
    }
}
