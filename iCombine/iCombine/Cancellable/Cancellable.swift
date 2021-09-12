//
//  Cancellable.swift
//  iCombine
//
//  Created by Adamas Zhu on 4/8/21.
//

import RxCocoa
import RxSwift

/// A protocol indicating that an activity or action may be canceled.
///
/// Calling `cancel()` frees up any allocated resources. It also stops side effects such as timers, network access, or disk I/O.
public protocol Cancellable {
    
    var disposable: Any? { get set }
    
    /// Cancel the activity.
    func cancel()
}
