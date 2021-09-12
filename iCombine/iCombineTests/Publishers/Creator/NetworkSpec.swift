//
//  NetworkSpec.swift
//  iCombineTests
//
//  Created by Leon Nguyen on 11/8/21.
//

import Foundation
import Nimble
import Quick
#if COMBINE
import Combine
import Foundation
#else
@testable import iCombine
#endif

final class NetworkSpec: QuickSpec {
    override func spec() {
        describe("calls DataTaskPublisher") {
            context("with an URL") {
                it("should receive value") {
                    let url = URL(string: "https://www.google.com")
                    let dataTaskPub: URLSession.CombineDataTaskPublisher = URLSession.shared.dataTaskPublisher(for: url!)
                    let result = dataTaskPub.test()
                    expect(result.hasFinished).toEventually(beTrue(), timeout: Self.timeout)
                    expect(result.outputs.last?.data.count).toEventually(beGreaterThan(0), timeout: Self.timeout)
                }
            }
        }
    }
}

private extension NetworkSpec {
    static let timeout: TimeInterval = 5
}
