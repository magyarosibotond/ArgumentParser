//
//  ArgumentParser.swift
//  ArgumentParser
//
//  Created by Botond Magyarosi on 20/06/2018.
//

public class ArgumentParser: Container {

    /// Holds the list of arguments to parse.
    private let arguments: [String]
    
    /// Holds the list of possible commands.
    internal var commands: [Command]
    internal var parameters: [Parameter]
    internal var options: [Option]
    
    /// Initialize with the list command line argumernts.
    ///
    /// - Parameter arguments: list of arguments
    public convenience init(arguments: [String]) {
        self.init(arguments: arguments, commands: [], parameters: [], options: [])
    }
    
    /// Initialize ArgumentParser with the list command line argumernts
    /// and argument definitions.
    ///
    /// - Parameters:
    ///   - arguments: list of arguments
    ///   - commands: list of commands
    ///   - parameters: list of parameters
    ///   - options: list of options
    private init(arguments: [String],
                 commands: [Command],
                 parameters: [Parameter],
                 options: [Option]) {
        self.arguments = arguments
        self.commands = commands
        self.parameters = parameters
        self.options = options
    }

    /// Parse the given list or aguments based on the defined command an option list.
    ///
    /// - Returns: A ParsingResult object.
    /// - Throws: ArgumentParseError if an error is present.
    public func parse() throws -> ParsingResult {
        var arguments = self.arguments
        var container: Container = self

        var options: [OptionResult] = []
        var parameters: [String] = []
        
        // Parse options defined on this level.
        
        var remainder: [String] = []
        arguments.forEach { argument in
            let option = container.options.first(where: { option -> Bool in
                if "--\(option.name)" == argument {
                    return true
                } else if let shortName = option.shortName, "-\(shortName)" == argument {
                    return true
                }
                return false
            })
            
            if let option = option {
                options.append(OptionResult.option(option.name))
            } else {
                remainder.append(argument)
            }
        }

        arguments = remainder
        
        // Check for subcommand
        
        if let argument = arguments.first,
            argument.isValidCommand,
            let command = container.commands.first(where: { $0.name == argument }) {
            let subparser = ArgumentParser(arguments: Array(arguments.dropFirst()),
                                                            commands: command.commands,
                                                            parameters: command.parameters,
                                                            options: command.options)
            return ParsingResult.command(command.name, try subparser.parse())
        }
        
        // check for parameters
        
        if !container.parameters.isEmpty {
            let parameterArguments = Array(arguments.prefix(container.parameters.count))

            if parameterArguments.count >= container.parameters.count {
                try parameterArguments.forEach {
                    if $0.isValidOption {
                        throw ArgumentParseError.invalidOption($0)
                    }
                }
                parameters = parameterArguments
            } else {
                throw ArgumentParseError.invalidNumberOfParameters("\(container.parameters.count) parameters expected, \(parameterArguments.count) given.")
            }
            
            arguments = Array(arguments.dropFirst(container.parameters.count))
        }
        
        // If not all arguments were parsed.
        
        if let argument = arguments.first {
            throw ArgumentParseError.invalidArgument(argument)
        }
        
        if parameters.isEmpty && options.isEmpty {
            return .empty
        } else {
            return .arguments(parameters: parameters, options: options)
        }
    }
}

// MARK: - Additions

public extension ArgumentParser {

    func add(_ command: Command) {
        commands.append(command)
    }
    
    func add(_ parameter: Parameter) {
        parameters.append(parameter)
    }
    
    func add(_ option: Option) {
        options.append(option)
    }
}
