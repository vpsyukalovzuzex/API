//
// TranslateResponse.swift
//

import Foundation

public struct TranslateResponse: Codable {
    
    // MARK: - Private enum
    
    private enum Key: String, CodingKey {
        
        case error = "err"
        case result = "result"
        case source = "source"
        case from = "from"
        case translator = "translator"
        case translatorLink = "translatorLink"
        case sourceTransliteration = "sourceTransliteration"
        case targetTransliteration = "targetTransliteration"
    }
    
    // MARK: - Public var
    
    public var error: String?
    
    public var result: String
    public var source: String
    public var from: String
    public var translator: String
    public var translatorLink: String
    
    public var sourceTransliteration: String?
    public var targetTransliteration: String?
    
    // MARK: - Public init
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.error = try? container.decode(String.self, forKey: .error)
        self.result = try container.decode(String.self, forKey: .result)
        self.source = try container.decode(String.self, forKey: .source)
        self.from = try container.decode(String.self, forKey: .from)
        self.translator = try container.decode(String.self, forKey: .translator)
        self.translatorLink = try container.decode(String.self, forKey: .translatorLink)
        self.sourceTransliteration = try? container.decode(String.self, forKey: .sourceTransliteration)
        self.targetTransliteration = try? container.decode(String.self, forKey: .targetTransliteration)
    }
}
