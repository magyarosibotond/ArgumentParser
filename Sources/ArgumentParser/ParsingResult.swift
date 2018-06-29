//
//  ParsingResult.swift
//  ArgumentParser
//
//  Created by Botond Magyarosi on 20/06/2018.
//

import Foundation

indirect enum ParsingResult: Equatable {
    case command(String, ParsingResult)
    case arguments(parameters: [String], options: [OptionResult])
    case empty
}

enum OptionResult: Equatable {
    case option(String)
    case valueOption(String, String)
}
