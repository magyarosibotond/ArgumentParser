//
//  Command.swift
//  ArgumentParser
//
//  Created by Botond Magyarosi on 20/06/2018.
//

import Foundation

public class Command: Container {
    
    let name: String
    let description: String
    
    internal var commands: [Command] = []
    internal var parameters: [Parameter] = []
    internal var options: [Option] = []
    
    init(name: String, description: String) {
        assert(name.isValidCommand, "\(name) is not a vlaid command")
        self.name = name
        self.description = description
    }
}

// MARK: - Command addition operator

infix operator <~
extension Command {
    
    static func <~ (lhs: Command, rhs: Command) -> Command {
        lhs.commands.append(rhs)
        return lhs
    }
    
    static func <~ (lhs: Command, rhs: Parameter) -> Command {
        lhs.parameters.append(rhs)
        return lhs
    }
    
    static func <~ (lhs: Command, rhs: Option) -> Command {
        lhs.options.append(rhs)
        return lhs
    }
}
