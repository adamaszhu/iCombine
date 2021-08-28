/// Dictionary+Formatter.swift
/// iCombineNetwork
///
/// - author: Leon Nguyen
/// - date: 28/8/21
///

internal extension Dictionary {
    
    var form: String {
        return map { key, value in
                let key = String(describing: key)
                    .addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? .empty
                let value = String(describing: value)
                    .addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? .empty
                return key + .equal + value
            }
            .joined(separator: .and)
    }
}
