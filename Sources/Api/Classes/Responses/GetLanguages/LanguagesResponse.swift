//
// LanguagesResponse.swift
//

import Foundation

public struct LanguagesResponse: Codable {
    
    private enum Key: String, CodingKey {
        
        case error = "err"
        case result = "result"
    }
    
    public var error: String?
    
    public var result: [LanguageResponse]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.error = try? container.decode(String.self, forKey: .error)
        self.result = try container.decode([LanguageResponse].self, forKey: .result)
    }
}
