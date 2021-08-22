//
//  NetworkSpec.swift
//  CombineFoundationTests
//
//  Created by Leon Nguyen on 11/8/21.
//

import Nimble
import Quick
#if COMBINE
import Combine
import Foundation
#else
@testable import CombineFoundation
#endif

final class NetworkSpec: QuickSpec {
    override func spec() {
        describe("calls DataTaskPublisher") {
            context("with an URL") {
                it("should receive value") {
                    let url = URL(string: "https://www.google.com")
                    let dataTaskPub: URLSession.CombineDataTaskPublisher = URLSession.shared.dataTaskPublisher(for: url!)
                    let result = dataTaskPub.test()
                    expect(result.hasFinished).toEventually(beTrue())
                    expect(result.outputs.last?.data.count).toEventually(beGreaterThan(0))
                }
            }
        }
    }
}
