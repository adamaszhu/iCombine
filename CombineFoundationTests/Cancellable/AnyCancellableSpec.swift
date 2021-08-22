//
//  AnyCancellableSpec.swift
//  CombineFoundationTests
//
//  Created by Adamas Zhu on 22/8/21.
//

import Nimble
import Quick

#if COMBINE
import Combine
#else
@testable import CombineFoundation
#endif

final class AnyCancellableSpec: QuickSpec {

    override func spec() {
        describe("calls ==") {
            context("with different object") {
                it("returns false") {
                    let firstCancellable = CurrentValueSubject<Int?, Never>(nil)
                        .sink(receiveCompletion: { _ in },
                              receiveValue: { _ in })
                    let secondCancellable = Just<Int?>(nil)
                        .sink(receiveCompletion: { _ in },
                              receiveValue: { _ in })
                    expect(firstCancellable == secondCancellable) == false
                }
            }
            context("with the same object") {
                it("returns true") {
                    let cancellable = CurrentValueSubject<Int?, Never>(nil)
                        .sink(receiveCompletion: { _ in },
                              receiveValue: { _ in })
                    expect(cancellable == cancellable) == true
                }
            }
        }
    }
}
