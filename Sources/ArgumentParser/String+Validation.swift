//
//  String+Validation.swift
//  ArgumentParser
//
//  Created by Botond Magyarosi on 20/06/2018.
//

import Foundation

extension String {

    /// Check is the String is a valid command.
    /// *Validation*: [All alphanumeric caracters]
    var isValidCommand: Bool {
        return range(of: "^[a-z0-9]+$", options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    
    /// Checks if a string is a valid option without value.
    /// *Validation*: -(-)[All alphanumeric caracters]
    var isValidOption: Bool {
        return range(of: "^-{1,2}[a-z0-9]+$", options: .regularExpression, range: nil, locale: nil) != nil
    }
}
