//
//  CurrentValueSubjectSpec.swift
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

final class CurrentValueSubjectSpec: QuickSpec {

    override func spec() {
        describe("has value") {
            context("with value setting") {
                it("publishes the settled value") {
                    let subject = CurrentValueSubject<Int?, Never>(nil)
                    let result = subject.test()
                    subject.value = 1
                    subject.value = 2
                    expect(result.outputs.last).toEventually(equal(2))
                }
                it("returns the settled value") {
                    let subject = CurrentValueSubject<Int?, Never>(nil)
                    subject.value = 1
                    expect(subject.value) == 1
                }
            }
        }
        describe("calls send(event)") {
            context("with new value") {
                it("publish the new value") {
                    let subject = CurrentValueSubject<Int?, Never>(nil)
                    let result = subject.test()
                    subject.send(1)
                    expect(result.outputs.last).toEventually(equal(1))
                }
            }
        }
        describe("calls send(completion)") {
            context("with finish") {
                it("publish the ending event") {
                    let subject = CurrentValueSubject<Int?, Never>(nil)
                    let result = subject.test()
                    subject.send(completion: .finished)
                    expect(result.hasFinished).toEventually(equal(true))
                }
            }
            context("with error") {
                it("publish the error") {
                    let subject = CurrentValueSubject<Int?, Error>(nil)
                    let result = subject.test()
                    subject.send(completion: .failure(TestError.one))
                    expect(result.failure).toEventuallyNot(beNil())
                }
            }
        }
    }
}
