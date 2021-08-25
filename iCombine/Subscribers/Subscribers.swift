//
//  Subscribers.swift
//  iCombine
//
//  Created by Adamas Zhu on 5/8/21.
//

import RxCocoa
import RxSwift
#if canImport(Combine)
import Combine
#endif

/// A namespace for types related to the `Subscriber` protocol.
public enum Subscribers {}

extension Subscribers {
    
    /// A signal that a publisher doesn’t produce additional elements, either due to normal completion or an error.
    ///
    /// - finished: The publisher finished normally.
    /// - failure: The publisher stopped publishing due to the indicated error.
    public enum Completion<Failure> where Failure : Error {
        
        case finished
        
        case failure(Failure)

        #if canImport(Combine)
        @available(iOS 14, macOS 10.15, *)
        init(combineCompletion: Combine.Subscribers.Completion<Failure>) {
            switch combineCompletion {
            case .finished:
                self = .finished
            case .failure(let error):
                self = .failure(error)
            }
        }
        #endif

        #if canImport(Combine)
        @available(iOS 14, macOS 10.15, *)
        var combineCompletion: Combine.Subscribers.Completion<Failure> {
            switch self {
            case .finished:
                return .finished
            case .failure(let error):
                return .failure(error)
            }
        }
        #endif
    }
}
