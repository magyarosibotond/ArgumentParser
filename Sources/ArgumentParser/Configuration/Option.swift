//
//  ArgumentOption.swift
//  ArgumentParser
//
//  Created by Botond Magyarosi on 20/06/2018.
//

import Foundation

public struct Option {
    let name: String
    let shortName: String?
    let description: String
    
    public init(name: String, shortName: String?, description: String) {
        assert(name.isValidCommand, "-\(name) is not a valid option name.")
        self.name = name
        self.shortName = shortName
        self.description = description
    }
}
