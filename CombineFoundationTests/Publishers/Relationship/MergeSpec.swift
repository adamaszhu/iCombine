//
//  MergeSpec.swift
//  CombineFoundationTests
//
//  Created by Leon Nguyen on 11/8/21.
//

import Nimble
import Quick

#if COMBINE
import Combine
#else
@testable import CombineFoundation
#endif

final class MergeSpec: QuickSpec {

    override func spec() {
        describe("calls merge(with)") {
            context("from a publisher") {
                it("merges the result") {
                    let result = Publishers.Sequence<[Int], Never>(sequence: [1])
                        .merge(with: Just(2))
                        .test()
                    expect(result.outputs.count).toEventually(equal(2))
                }
                it("emits events in sequence") {
                    let subject1 = CurrentValueSubject<Int, Never>(1)
                    let subject2 = CurrentValueSubject<Int, Never>(2)
                    let result = subject1.merge(with: subject2)
                        .test()
                    subject1.value = 3
                    subject2.value = 4
                    expect(result.outputs.count).toEventually(equal(4))
                    expect(result.outputs[0]).toEventually(equal(1))
                    expect(result.outputs[1]).toEventually(equal(2))
                    expect(result.outputs[2]).toEventually(equal(3))
                    expect(result.outputs[3]).toEventually(equal(4))
                }
            }
            context("from a publisher with a similar publisher") {
                it("merges the result") {
                    let result = Publishers.Sequence<[Int], Error>(sequence: [1])
                        .merge(with: Publishers.Sequence<[Int], Error>(sequence: [2]))
                        .test()
                    expect(result.outputs.count).toEventually(equal(2))
                }
            }
            context("from a merge publisher") {
                it("merges the result") {
                    let result = Publishers.Merge(Just(1), Just(2))
                        .merge(with: Just(3))
                        .test()
                    expect(result.outputs.count).toEventually(equal(3))
                }
            }
            context("from a merge 3 publisher") {
                it("merges the result") {
                    let result = Publishers.Merge3(Just(1), Just(2), Just(3))
                        .merge(with: Just(4))
                        .test()
                    expect(result.outputs.count).toEventually(equal(4))
                }
            }
            context("from a merge 4 publisher") {
                it("merges the result") {
                    let result = Publishers.Merge4(Just(1), Just(2), Just(3), Just(4))
                        .merge(with: Just(5))
                        .test()
                    expect(result.outputs.count).toEventually(equal(5))
                }
            }
            context("from a merge 5 publisher") {
                it("merges the result") {
                    let result = Publishers.Merge5(Just(1), Just(2), Just(3), Just(4), Just(5))
                        .merge(with: Just(6))
                        .test()
                    expect(result.outputs.count).toEventually(equal(6))
                }
            }
            context("from a merge 6 publisher") {
                it("merges the result") {
                    let result = Publishers.Merge6(Just(1), Just(2), Just(3), Just(4), Just(5), Just(6))
                        .merge(with: Just(7))
                        .test()
                    expect(result.outputs.count).toEventually(equal(7))
                }
            }
            context("from a merge 7 publisher") {
                it("merges the result") {
                    let result = Publishers.Merge7(Just(1), Just(2), Just(3), Just(4), Just(5), Just(6), Just(7))
                        .merge(with: Just(8))
                        .test()
                    expect(result.outputs.count).toEventually(equal(8))
                }
            }
            context("from a merge many publisher") {
                it("merges the result") {
                    let result = Publishers.MergeMany([Just(1), Just(2)])
                        .merge(with: Just(3))
                        .test()
                    expect(result.outputs.count).toEventually(equal(3))
                }
            }
            context("from a merge many publisher") {
                it("merges the result") {
                    let result = Publishers.MergeMany(Just(1), Just(2))
                        .merge(with: Just(3))
                        .test()
                    expect(result.outputs.count).toEventually(equal(3))
                }
            }
        }
        describe("calls merge(with:_)") {
            context("from a publisher") {
                it("merges the result") {
                    let result = Publishers.Sequence<[Int], Never>(sequence: [1])
                        .merge(with: Just(2), Just(3))
                        .test()
                    expect(result.outputs.count).toEventually(equal(3))
                }
            }
            context("from a merge publisher") {
                it("merges the result") {
                    let result = Publishers.Merge(Just(1), Just(2))
                        .merge(with: Just(3), Just(4))
                        .test()
                    expect(result.outputs.count).toEventually(equal(4))
                }
            }
            context("from a merge 3 publisher") {
                it("merges the result") {
                    let result = Publishers.Merge3(Just(1), Just(2), Just(3))
                        .merge(with: Just(4), Just(5))
                        .test()
                    expect(result.outputs.count).toEventually(equal(5))
                }
            }
            context("from a merge 4 publisher") {
                it("merges the result") {
                    let result = Publishers.Merge4(Just(1), Just(2), Just(3), Just(4))
                        .merge(with: Just(5), Just(6))
                        .test()
                    expect(result.outputs.count).toEventually(equal(6))
                }
            }
            context("from a merge 5 publisher") {
                it("merges the result") {
                    let result = Publishers.Merge5(Just(1), Just(2), Just(3), Just(4), Just(5))
                        .merge(with: Just(6), Just(7))
                        .test()
                    expect(result.outputs.count).toEventually(equal(7))
                }
            }
            context("from a merge 6 publisher") {
                it("merges the result") {
                    let result = Publishers.Merge6(Just(1), Just(2), Just(3), Just(4), Just(5), Just(6))
                        .merge(with: Just(7), Just(8))
                        .test()
                    expect(result.outputs.count).toEventually(equal(8))
                }
            }
        }
        describe("calls merge(with:_:_)") {
            context("from a publisher") {
                it("merges the result") {
                    let result = Publishers.Sequence<[Int], Never>(sequence: [1])
                        .merge(with: Just(2), Just(3), Just(4))
                        .test()
                    expect(result.outputs.count).toEventually(equal(4))
                }
            }
            context("from a merge publisher") {
                it("merges the result") {
                    let result = Publishers.Merge(Just(1), Just(2))
                        .merge(with: Just(3), Just(4), Just(5))
                        .test()
                    expect(result.outputs.count).toEventually(equal(5))
                }
            }
            context("from a merge 3 publisher") {
                it("merges the result") {
                    let result = Publishers.Merge3(Just(1), Just(2), Just(3))
                        .merge(with: Just(4), Just(5), Just(6))
                        .test()
                    expect(result.outputs.count).toEventually(equal(6))
                }
            }
            context("from a merge 4 publisher") {
                it("merges the result") {
                    let result = Publishers.Merge4(Just(1), Just(2), Just(3), Just(4))
                        .merge(with: Just(5), Just(6), Just(7))
                        .test()
                    expect(result.outputs.count).toEventually(equal(7))
                }
            }
            context("from a merge 5 publisher") {
                it("merges the result") {
                    let result = Publishers.Merge5(Just(1), Just(2), Just(3), Just(4), Just(5))
                        .merge(with: Just(6), Just(7), Just(8))
                        .test()
                    expect(result.outputs.count).toEventually(equal(8))
                }
            }
        }
        describe("calls merge(with:_:_:_)") {
            context("from a publisher") {
                it("merges the result") {
                    let result = Publishers.Sequence<[Int], Never>(sequence: [1])
                        .merge(with: Just(2), Just(3), Just(4), Just(5))
                        .test()
                    expect(result.outputs.count).toEventually(equal(5))
                }
            }
            context("from a merge publisher") {
                it("merges the result") {
                    let result = Publishers.Merge(Just(1), Just(2))
                        .merge(with: Just(3), Just(4), Just(5), Just(6))
                        .test()
                    expect(result.outputs.count).toEventually(equal(6))
                }
            }
            context("from a merge 3 publisher") {
                it("merges the result") {
                    let result = Publishers.Merge3(Just(1), Just(2), Just(3))
                        .merge(with: Just(4), Just(5), Just(6), Just(7))
                        .test()
                    expect(result.outputs.count).toEventually(equal(7))
                }
            }
            context("from a merge 4 publisher") {
                it("merges the result") {
                    let result = Publishers.Merge4(Just(1), Just(2), Just(3), Just(4))
                        .merge(with: Just(5), Just(6), Just(7), Just(8))
                        .test()
                    expect(result.outputs.count).toEventually(equal(8))
                }
            }
        }
        describe("calls merge(with:_:_:_:_)") {
            context("from a publisher") {
                it("merges the result") {
                    let result = Publishers.Sequence<[Int], Never>(sequence: [1])
                        .merge(with: Just(2), Just(3), Just(4), Just(5), Just(6))
                        .test()
                    expect(result.outputs.count).toEventually(equal(6))
                }
            }
            context("from a merge publisher") {
                it("merges the result") {
                    let result = Publishers.Merge(Just(1), Just(2))
                        .merge(with: Just(3), Just(4), Just(5), Just(6), Just(7))
                        .test()
                    expect(result.outputs.count).toEventually(equal(7))
                }
            }
            context("from a merge 3 publisher") {
                it("merges the result") {
                    let result = Publishers.Merge3(Just(1), Just(2), Just(3))
                        .merge(with: Just(4), Just(5), Just(6), Just(7), Just(8))
                        .test()
                    expect(result.outputs.count).toEventually(equal(8))
                }
            }
        }
        describe("calls merge(with:_:_:_:_:_)") {
            context("from a publisher") {
                it("merges the result") {
                    let result = Publishers.Sequence<[Int], Never>(sequence: [1])
                        .merge(with: Just(2), Just(3), Just(4), Just(5), Just(6), Just(7))
                        .test()
                    expect(result.outputs.count).toEventually(equal(7))
                }
            }
            context("from a merge publisher") {
                it("merges the result") {
                    let result = Publishers.Merge(Just(1), Just(2))
                        .merge(with: Just(3), Just(4), Just(5), Just(6), Just(7), Just(8))
                        .test()
                    expect(result.outputs.count).toEventually(equal(8))
                }
            }
        }
        describe("calls merge(with:_:_:_:_:_:_)") {
            context("from a publisher") {
                it("merges the result") {
                    let result = Publishers.Sequence<[Int], Never>(sequence: [1])
                        .merge(with: Just(2), Just(3), Just(4), Just(5), Just(6), Just(7), Just(8))
                        .test()
                    expect(result.outputs.count).toEventually(equal(8))
                }
            }
        }
    }
}
