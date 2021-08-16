//
//  ReplaceEmptySpec.swift
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

final class ReplaceEmptySpec: QuickSpec {
    
    override func spec() {
        describe("calls replaceEmpty(with)") {
            context("with new value") {
                it("emits the event") {
                    let result = Empty(completeImmediately: true, outputType: Int.self, failureType: TestError.self)
                        .replaceEmpty(with: 1)
                        .test()
                    expect(result.outputs.last).toEventually(equal(1))
                }
            }
        }
    }
}
