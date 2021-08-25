//
//  ViewController.swift
//  iCombineSample
//
//  Created by Adamas Zhu on 21/8/21.
//

import UIKit
import iCombine
// import Combine

class ViewController: UIViewController {

    private var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        testSequence()
    }

    private func testSequence() {
        let publisher = Publishers
            .Sequence<[Int], Error>(sequence: [0, 1, 2])
            .map({ $0 + 1 })
        let subscriber = Subscribers
            .Sink<Int, Error>(
            receiveCompletion: { print("Sink subscriber", $0) },
            receiveValue: { print("Sink subscriber", $0) })

        publisher
            .receive(on: DispatchQueue.main)
            .subscribe(subscriber)
        cancellable = publisher
            .sink(
                receiveCompletion: { print("Sink method", $0) },
                receiveValue: { print("Sink method", $0) })
    }
}

