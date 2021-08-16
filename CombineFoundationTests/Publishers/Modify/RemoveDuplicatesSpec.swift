//
//  RemoveDuplicatesSpec.swift
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

final class RemoveDuplicatesSpec: QuickSpec {
    
    override func spec() {
        describe("calls removeDuplicates()") {
            context("with duplicated elements") {
                it("removes duplicates") {
                    let result = Publishers.Sequence<[Int], Never>(sequence: [1, 1, 2])
                        .removeDuplicates()
                        .test()
                    expect(result.outputs.count).toEventually(equal(2))
                }
            }
        }
        describe("calls removeDuplicates(by)") {
            context("with duplicated elements") {
                it("removes duplicates") {
                    let result = Publishers.Sequence<[Int], Never>(sequence: [1, 1, 2, 4])
                        .removeDuplicates(by: { $0 + 1 == $1 })
                        .test()
                    expect(result.outputs.count).toEventually(equal(3))
                }
            }
        }
        describe("calls tryRemoveDuplicates(by)") {
            context("with duplicated elements") {
                it("removes duplicates") {
                    let result = Publishers.Sequence<[Int], Never>(sequence: [1, 1, 2, 4])
                        .tryRemoveDuplicates(by: { $0 + 1 == $1 })
                        .test()
                    expect(result.outputs.count).toEventually(equal(3))
                }
            }
        }
    }
}
