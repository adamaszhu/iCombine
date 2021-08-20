//
//  PassthroughSubjectSpec.swift
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

final class PassthroughSubjectSpec: QuickSpec {
    
    override func spec() {
        describe("calls send(event)") {
            context("with new value") {
                it("publish the new value") {
                    let subject = PassthroughSubject<Int, Never>()
                    let result = subject.test()
                    subject.send(1)
                    expect(result.outputs.last).toEventually(equal(1))
                }
            }
        }
        describe("calls send(completion)") {
            context("with finish") {
                it("publish the ending event") {
                    let subject = PassthroughSubject<Int, Never>()
                    let result = subject.test()
                    subject.send(completion: .finished)
                    expect(result.hasFinished).toEventually(equal(true))
                }
            }
            context("with error") {
                it("publish the error") {
                    let subject = PassthroughSubject<Int, Error>()
                    let result = subject.test()
                    subject.send(completion: .failure(TestError.one))
                    expect(result.failure).toEventuallyNot(beNil())
                }
            }
        }
    }
}
