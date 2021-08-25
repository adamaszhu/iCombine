//
//  CombineLatestSpec.swift
//  iCombineTests
//
//  Created by Leon Nguyen on 8/8/21.
//

import Nimble
import Quick

#if COMBINE
import Combine
#else
@testable import iCombine
#endif

final class CombineLatestSpec: QuickSpec {

    override func spec() {
        describe("create CombineLatest") {
            context("from 4 Publishers") {
                it("should receive values") {
                    let subject1 = CurrentValueSubject<Int,Never>(0)
                    let subject2 = CurrentValueSubject<Int,Never>(1)
                    let subject3 = CurrentValueSubject<Int,Never>(2)
                    let subject4 = CurrentValueSubject<Int,Never>(3)

                    let combineLatestPub = Publishers.CombineLatest4(subject1, subject2, subject3, subject4)

                    let result = combineLatestPub.test()
                    expect(result.hasFinished).toEventually(beFalse())
                    expect(result.outputs.last?.0).toEventually(equal(0))
                    expect(result.outputs.last?.1).toEventually(equal(1))
                    expect(result.outputs.last?.2).toEventually(equal(2))
                    expect(result.outputs.last?.3).toEventually(equal(3))
                    expect(result.outputs.count).toEventually(equal(1))

                    subject2.value = 10
                    expect(result.outputs.last?.0).toEventually(equal(0))
                    expect(result.outputs.last?.1).toEventually(equal(10))
                    expect(result.outputs.last?.2).toEventually(equal(2))
                    expect(result.outputs.last?.3).toEventually(equal(3))
                    expect(result.outputs.count).toEventually(equal(2))
                }
            }
        }
        describe("create CombineLatest") {
            context("from 3 Publishers") {
                it("should receive values") {
                    let subject1 = CurrentValueSubject<Int,Never>(0)
                    let subject2 = CurrentValueSubject<Int,Never>(1)
                    let subject3 = CurrentValueSubject<Int,Never>(2)

                    let combineLatestPub = Publishers.CombineLatest3(subject1, subject2, subject3)

                    let result = combineLatestPub.test()
                    expect(result.hasFinished).toEventually(beFalse())
                    expect(result.outputs.last?.0).toEventually(equal(0))
                    expect(result.outputs.last?.1).toEventually(equal(1))
                    expect(result.outputs.last?.2).toEventually(equal(2))
                    expect(result.outputs.count).toEventually(equal(1))

                    subject2.value = 10
                    expect(result.outputs.last?.0).toEventually(equal(0))
                    expect(result.outputs.last?.1).toEventually(equal(10))
                    expect(result.outputs.last?.2).toEventually(equal(2))
                    expect(result.outputs.count).toEventually(equal(2))
                }
            }
        }
        describe("create CombineLatest") {
            context("from 2 Publishers") {
                it("should receive values") {
                    let subject1 = CurrentValueSubject<Int,Never>(0)
                    let subject2 = CurrentValueSubject<Int,Never>(1)
                    let combineLatestPub = Publishers.CombineLatest(subject1, subject2)

                    let result = combineLatestPub.test()
                    expect(result.hasFinished).toEventually(beFalse())
                    expect(result.outputs.last?.0).toEventually(equal(0))
                    expect(result.outputs.last?.1).toEventually(equal(1))
                    expect(result.outputs.count).toEventually(equal(1))

                    subject2.value = 10
                    expect(result.outputs.last?.0).toEventually(equal(0))
                    expect(result.outputs.last?.1).toEventually(equal(10))
                    expect(result.outputs.count).toEventually(equal(2))
                }
            }
        }
        describe("calls combineLatest") {
            context("on a Publisher") {
                it("with 3 more publishers") {
                    let subject1 = CurrentValueSubject<Int,Never>(0)
                    let subject2 = CurrentValueSubject<Int,Never>(1)
                    let subject3 = CurrentValueSubject<Int,Never>(2)
                    let subject4 = CurrentValueSubject<Int,Never>(3)
                    let combineLatestPub = subject1.combineLatest(subject2, subject3, subject4)

                    let result = combineLatestPub.test()
                    expect(result.hasFinished).toEventually(beFalse())
                    expect(result.outputs.last?.0).toEventually(equal(0))
                    expect(result.outputs.last?.1).toEventually(equal(1))
                    expect(result.outputs.last?.2).toEventually(equal(2))
                    expect(result.outputs.last?.3).toEventually(equal(3))
                    expect(result.outputs.count).toEventually(equal(1))

                    subject2.value = 10
                    expect(result.outputs.last?.0).toEventually(equal(0))
                    expect(result.outputs.last?.1).toEventually(equal(10))
                    expect(result.outputs.last?.2).toEventually(equal(2))
                    expect(result.outputs.last?.3).toEventually(equal(3))
                    expect(result.outputs.count).toEventually(equal(2))
                }
            }
        }
        describe("calls combineLatest") {
            context("on a Publisher") {
                it("with 2 more publishers") {
                    let subject1 = CurrentValueSubject<Int,Never>(0)
                    let subject2 = CurrentValueSubject<Int,Never>(1)
                    let subject3 = CurrentValueSubject<Int,Never>(2)
                    let combineLatestPub = subject1.combineLatest(subject2, subject3)

                    let result = combineLatestPub.test()
                    expect(result.hasFinished).toEventually(beFalse())
                    expect(result.outputs.last?.0).toEventually(equal(0))
                    expect(result.outputs.last?.1).toEventually(equal(1))
                    expect(result.outputs.last?.2).toEventually(equal(2))
                    expect(result.outputs.count).toEventually(equal(1))

                    subject2.value = 10
                    expect(result.outputs.last?.0).toEventually(equal(0))
                    expect(result.outputs.last?.1).toEventually(equal(10))
                    expect(result.outputs.last?.2).toEventually(equal(2))
                    expect(result.outputs.count).toEventually(equal(2))
                }
            }
        }
        describe("calls combineLatest") {
            context("on a Publisher") {
                it("should receive values") {
                    let subject1 = CurrentValueSubject<Int,Never>(0)
                    let subject2 = CurrentValueSubject<Int,Never>(1)
                    let combineLatestPub = subject1.combineLatest(subject2)

                    let result = combineLatestPub.test()
                    expect(result.hasFinished).toEventually(beFalse())
                    expect(result.outputs.last?.0).toEventually(equal(0))
                    expect(result.outputs.last?.1).toEventually(equal(1))
                    expect(result.outputs.count).toEventually(equal(1))

                    subject2.value = 10
                    expect(result.outputs.last?.0).toEventually(equal(0))
                    expect(result.outputs.last?.1).toEventually(equal(10))
                    expect(result.outputs.count).toEventually(equal(2))

                    subject1.value = 2
                    expect(result.outputs.last?.0).toEventually(equal(2))
                    expect(result.outputs.last?.1).toEventually(equal(10))
                    expect(result.outputs.count).toEventually(equal(3))
                }
            }
        }
    }
}
