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
