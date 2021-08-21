//
//  AnyPublisherSpec.swift
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

final class AnyPublisherSpec: QuickSpec {
    
    override func spec() {
        describe("calls eraseToPublisher()") {
            context("with a publisher") {
                it("returns an any publisher") {
                    let result = Just<Int>(3)
                        .eraseToAnyPublisher()
                        .test()
                    
                    expect(result.outputs.last).toEventually(equal(3))
                }
            }
        }
    }
}
