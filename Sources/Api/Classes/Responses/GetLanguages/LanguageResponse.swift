//
// LanguageResponse.swift
//

import Foundation

public struct LanguageResponse: Codable {
    
    private enum Key: String, CodingKey {
        
        case fullCode = "full_code"
        case codeAlpha1 = "code_alpha_1"
        case englishName = "englishName"
        case codeName = "codeName"
        case flagPath = "flagPath"
        case testWordForSyntezis = "testWordForSyntezis"
        case rtl = "rtl"
        case modes = "modes"
    }
    
    public var fullCode: String
    public var codeAlpha1: String
    public var englishName: String
    public var codeName: String
    public var flagPath: String
    public var testWordForSyntezis: String
    
    public var rtl: Bool
    
    public var modes: [ModeResponse]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.fullCode = try container.decode(String.self, forKey: .fullCode)
        self.codeAlpha1 = try container.decode(String.self, forKey: .codeAlpha1)
        self.englishName = try container.decode(String.self, forKey: .englishName)
        self.codeName = try container.decode(String.self, forKey: .codeName)
        self.flagPath = try container.decode(String.self, forKey: .flagPath)
        self.testWordForSyntezis = try container.decode(String.self, forKey: .testWordForSyntezis)
        self.rtl = (try container.decode(String.self, forKey: .rtl)) == "true"
        self.modes = try container.decode([ModeResponse].self, forKey: .modes)
    }
}
