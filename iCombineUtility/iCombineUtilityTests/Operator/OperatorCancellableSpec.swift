/// OperatorCancellableSpec.swift
/// CombineUtility
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

import Nimble
import Quick
@testable import iCombineUtility

#if COMBINE
import Combine
#else
import iCombine
#endif

@available(iOS 13.0, *)
final class OperatorCancellableSpec: QuickSpec {
    
    override func spec() {
        describe("calls +=(cancellables:cancellable)") {
            context("with a cancellable object") {
                it("adds the object into the collection") {
                    var cancellables = [Cancellable]()
                    cancellables += Just<Int>(0)
                        .sink(receiveCompletion: { _ in },
                              receiveValue: { _ in })
                    expect(cancellables.count) == 1
                }
            }
        }
    }
}
