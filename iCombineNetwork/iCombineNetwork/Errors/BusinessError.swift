/// BusinessError.swift
/// iCombineNetwork
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

import iCombine

/// Any specific business error defined by the HTTP status code and the response.
/// BusinessErrors are detected before checking ServerErrors
public protocol BusinessError: Error {
    init?(response: DataTaskResponse)
}
