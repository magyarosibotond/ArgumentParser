//
//  ArgumentParseError.swift
//  ArgumentParser
//
//  Created by Botond Magyarosi on 01/07/2018.
//

import Foundation

public enum ArgumentParseError: Error {
    case invalidOption(String)
    case invalidNumberOfParameters(String)
    case parameterExpected(String)
    case invalidArgument(String)
}

// MARK: - LocalizedError

extension ArgumentParseError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .invalidOption(let option):
            return "Invalid option: \(option)"
        case .invalidNumberOfParameters(let message):
            return "Invalid number of parameters: \(message)"
        case .parameterExpected(let parameter):
            return "Parameter expected \(parameter)"
        case .invalidArgument(let argument):
            return "Invalid argument given: \(argument)"
        }
    }
}
