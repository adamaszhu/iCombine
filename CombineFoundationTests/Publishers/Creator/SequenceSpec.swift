//
//  SequenceSpec.swift
//  CombineFoundationTests
//
//  Created by Leon Nguyen on 8/8/21.
//

import Nimble
import Quick

#if COMBINE
import Combine
#else
@testable import CombineFoundation
#endif

final class SequenceSpec: QuickSpec {

    override func spec() {
        describe("calls Sequence") {
            context("with Subcriber") {
                it("should receive values") {
                    let result = Publishers
                        .Sequence<[Int], Error>(sequence: [0, 1, 2])
                        .map({ $0 + 1 })
                        .test()

                    expect(result.hasFinished).toEventually(beTrue())
                    expect(result.outputs.count).toEventually(equal(3))
                    expect(result.outputs[0]).toEventually(equal(1))
                }
            }
        }
        describe("calls Sequence") {
            context("with another Sequence") {
                it("should append") {
                    let publisher1 = Publishers
                        .Sequence<[Int], Error>(sequence: [0, 1, 2])
                        .map({ $0 + 1 })
                    let publisher2 = Publishers
                        .Sequence<[Int], Error>(sequence: [3, 4, 5])
                        .map({ $0 + 1 })
                    let result = publisher1
                        .append(publisher2)
                        .test()

                    expect(result.outputs.count).toEventually(equal(6))
                    expect(result.outputs[0]).toEventually(equal(1))
                    expect(result.outputs[5]).toEventually(equal(6))
                }
            }
        }
        describe("calls Sequence") {
            context("with another Sequence") {
                it("should prepend") {
                    let publisher1 = Publishers
                        .Sequence<[Int], Error>(sequence: [0, 1, 2])
                        .map({ $0 + 1 })
                    let publisher2 = Publishers
                        .Sequence<[Int], Error>(sequence: [3, 4, 5])
                        .map({ $0 + 1 })
                    let result = publisher1
                        .prepend(publisher2)
                        .test()

                    expect(result.outputs.count).toEventually(equal(6))
                    expect(result.outputs[0]).toEventually(equal(4))
                    expect(result.outputs[5]).toEventually(equal(3))
                }
            }
        }
        describe("has Sequence") {
            context("with some values") {
                it("returns appended Sequence") {
                    let result = Publishers
                        .Sequence<[Int], Error>(sequence: [0, 1, 2])
                        .map({ $0 + 1 })
                        .append(4, 5, 6)
                        .test()

                    expect(result.outputs.count).toEventually(equal(6))
                    expect(result.outputs[0]).toEventually(equal(1))
                    expect(result.outputs[5]).toEventually(equal(6))
                }
            }
        }
        describe("has Sequence") {
            context("with some values") {
                it("returns prepended Sequence") {
                    let result = Publishers
                        .Sequence<[Int], Error>(sequence: [0, 1, 2])
                        .map({ $0 + 1 })
                        .prepend(4, 5, 6)
                        .test()

                    expect(result.outputs.count).toEventually(equal(6))
                    expect(result.outputs[0]).toEventually(equal(4))
                    expect(result.outputs[5]).toEventually(equal(3))
                }
            }
        }
        describe("has Sequence") {
            context("with an array") {
                it("returns appended Sequence") {
                    let result = Publishers
                        .Sequence<[Int], Error>(sequence: [0, 1, 2])
                        .map({ $0 + 1 })
                        .append([4, 5, 6])
                        .test()

                    expect(result.outputs.count).toEventually(equal(6))
                    expect(result.outputs[0]).toEventually(equal(1))
                    expect(result.outputs[5]).toEventually(equal(6))
                }
            }
        }
        describe("has Sequence") {
            context("with an array") {
                it("returns prepended Sequence") {
                    let result = Publishers
                        .Sequence<[Int], Error>(sequence: [0, 1, 2])
                        .map({ $0 + 1 })
                        .prepend([4, 5, 6])
                        .test()

                    expect(result.outputs.count).toEventually(equal(6))
                    expect(result.outputs[0]).toEventually(equal(4))
                    expect(result.outputs[5]).toEventually(equal(3))
                }
            }
        }
    }
}
