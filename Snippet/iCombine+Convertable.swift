//
//  iCombine+Convertable.swift
//  iCombine
//
//  Created by Adamas Zhu on 4/8/21.
//

import CombineRx
import ReactiveCocoa
import ReactiveSwift

extension Publisher where Failure: Error {

    var reactive: (signalProducer: SignalProducer<Output, Failure>, cancellable: Cancellable?) {
        var cancellable: Cancellable?
        let signalProducer = SignalProducer<Output, Failure> { observer, _ in
            cancellable = self.sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    observer.sendCompleted()
                case .failure(let error):
                    observer.send(error: error)
                }
            }, receiveValue: { value in
                observer.send(value: value)
            })
        }
        return (signalProducer, cancellable)
    }
}

extension Publisher where Failure == Never {

    var reactive: (signalProducer: SignalProducer<Output, Never>, cancellable: Cancellable?) {
        var cancellable: Cancellable?
        let signalProducer = SignalProducer<Output, Never> { observer, _ in
            cancellable = self.sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    observer.sendCompleted()
                default:
                    break
                }
            }, receiveValue: { value in
                observer.send(value: value)
            })
        }
        return (signalProducer, cancellable)
    }
}
