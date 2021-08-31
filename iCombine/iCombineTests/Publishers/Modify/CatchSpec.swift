//
//  CatchSpec.swift
//  iCombineTests
//
//  Created by Adamas Zhu on 16/8/21.
//

import Nimble
import Quick

#if COMBINE
import Combine
#else
@testable import iCombine
#endif

final class CatchSpec: QuickSpec {
    
    override func spec() {
        describe("calls catch(_)") {
            context("with the generic error type") {
                it("maps to the new publisher") {
                    let result = Fail<Int, Error>(error: TestError.one)
                        .catch { _ in Just<Int>(1) }
                        .test()
                    expect(result.outputs.last).toEventually(equal(1))
                }
            }
            context("with a specific error type") {
                it("maps to the new publisher") {
                    let result = Fail<Int, TestError>(error: TestError.one)
                        .catch { _ in Just<Int>(1) }
                        .test()
                    expect(result.outputs.last).toEventually(equal(1))
                }
            }
        }
        describe("calls tryCatch(_)") {
            context("with a matching error and the generic error type to a publisher with the generic error type") {
                it("maps to an error") {
                    let result = Fail<Int, Error>(error: TestError.one)
                        .tryCatch { error -> AnyPublisher<Int, Error> in
                            if TestError.one == error {
                                throw TestError.two
                            } else {
                                return Empty<Int, Error>().eraseToAnyPublisher()
                            }
                        }
                        .test()

                    expect(result.failure as? TestError).toEventually(equal(TestError.two))
                }
            }
            context("with a mismatching error and the generic error type to a publisher with the generic error type") {
                it("maps to a publisher") {
                    let result = Fail<Int, Error>(error: TestError.two)
                        .tryCatch { error -> AnyPublisher<Int, Error> in
                            if TestError.one == error {
                                throw TestError.two
                            } else {
                                return Empty<Int, Error>().eraseToAnyPublisher()
                            }
                        }
                        .test()

                    expect(result.failure as? TestError).toEventually(beNil())
                }
            }
            context("with a matching error and the generic error type to a publisher with a specific error type") {
                it("maps to an error") {
                    let result = Fail<Int, Error>(error: TestError.one)
                        .tryCatch { error -> AnyPublisher<Int, TestError> in
                            if TestError.one == error {
                                throw TestError.two
                            } else {
                                return Empty<Int, TestError>().eraseToAnyPublisher()
                            }
                        }
                        .test()

                    expect(result.failure as? TestError).toEventually(equal(TestError.two))
                }
            }
            context("with a mismatching error and the generic error type to a publisher with a specific error type") {
                it("maps to a publisher") {
                    let result = Fail<Int, Error>(error: TestError.two)
                        .tryCatch { error -> AnyPublisher<Int, TestError> in
                            if TestError.one == error {
                                throw TestError.two
                            } else {
                                return Empty<Int, TestError>().eraseToAnyPublisher()
                            }
                        }
                        .test()

                    expect(result.failure as? TestError).toEventually(beNil())
                }
            }
            context("with a matching error and a specific error type to a publisher with a specific error type") {
                it("maps to an error") {
                    let result = Fail<Int, TestError>(error: TestError.one)
                        .tryCatch { error -> AnyPublisher<Int, TestError> in
                            if TestError.one == error {
                                throw TestError.two
                            } else {
                                return Empty<Int, TestError>().eraseToAnyPublisher()
                            }
                        }
                        .test()

                    expect(result.failure as? TestError).toEventually(equal(TestError.two))
                }
            }
            context("with a mismatching error and a specific error type to a publisher with a specific error type") {
                it("maps to a publisher") {
                    let result = Fail<Int, TestError>(error: TestError.two)
                        .tryCatch { error -> AnyPublisher<Int, TestError> in
                            if TestError.one == error {
                                throw TestError.two
                            } else {
                                return Empty<Int, TestError>().eraseToAnyPublisher()
                            }
                        }
                        .test()

                    expect(result.failure as? TestError).toEventually(beNil())
                }
            }
            context("with a matching error and a specific error type to a publisher with the generic error type") {
                it("maps to an error") {
                    let result = Fail<Int, TestError>(error: TestError.one)
                        .tryCatch { error -> AnyPublisher<Int, Error> in
                            if TestError.one == error {
                                throw TestError.two
                            } else {
                                return Empty<Int, Error>().eraseToAnyPublisher()
                            }
                        }
                        .test()

                    expect(result.failure as? TestError).toEventually(equal(TestError.two))
                }
            }
            context("with a mismatching error and a specific error type to a publisher with the generic error type") {
                it("maps to a publisher") {
                    let result = Fail<Int, TestError>(error: TestError.two)
                        .tryCatch { error -> AnyPublisher<Int, Error> in
                            if TestError.one == error {
                                throw TestError.two
                            } else {
                                return Empty<Int, Error>().eraseToAnyPublisher()
                            }
                        }
                        .test()

                    expect(result.failure as? TestError).toEventually(beNil())
                }
            }
        }
    }
}

