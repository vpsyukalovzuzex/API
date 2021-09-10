//
// Dictionary+Common.swift
//

import Foundation

extension Dictionary {
    
    func merged(with dictionary: Dictionary?) -> Dictionary {
        var result = self
        for (key, value) in dictionary ?? [:] {
            result[key] = value
        }
        return result
    }
}
