//
// ModeResponse.swift
//

import Foundation

public struct ModeResponse: Codable {
    
    private enum Key: String, CodingKey {
        
        case name = "name"
        case value = "value"
    }
    
    public var name: String
    
    public var value: Bool
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.value = try container.decode(Bool.self, forKey: .value)
    }
}
