enum ArgumentParseError: Error {
    case invalidOption(String)
    case invalidArgument(String)
}

protocol Container {
    var commands: [Command] { get set }
    var parameters: [Parameter]  { get set }
    var options: [Option] { get set }
}

public class ArgumentParser: Container {
    
    /// Holds the list of arguments to parse.
    private let arguments: [String]
    
    /// Holds the list of possible commands.
    internal var commands: [Command] = []
    internal var parameters: [Parameter] = []
    internal var options: [Option] = []
    
    /// Initialize ArgumentParser with the list command line argumernts.
    ///
    /// - Parameter arguments: list of arguments
    init(arguments: [String]) {
        self.arguments = arguments
    }
    
    func parse() throws -> ParsingResult {
        var arguments = self.arguments
        var container: Container = self
        
        var options: [OptionResult] = []
        var parameters: [String] = []
        
        while let firstArgument = arguments.first {
            if firstArgument.isValidCommand,
                let command = container.commands.first(where: { $0.name == firstArgument }) {
                return ParsingResult.command(command.name, try ArgumentParser(arguments: Array(arguments.dropFirst())).parse())
            } else if firstArgument.isValidOptionWithValue {
                options.append(try getOptionResult(argument: firstArgument))
            } else if firstArgument.isValidOption {
                if let option = container.options.first(where: { firstArgument.contains($0.name) }) {
                    options.append(.option(option.name))
                } else {
                    throw ArgumentParseError.invalidArgument(firstArgument)
                }
            } else if !container.parameters.isEmpty {
                parameters.append(firstArgument)
            } else {
                throw ArgumentParseError.invalidArgument(firstArgument)
            }
            
            arguments = Array(arguments.dropFirst())
        }
        
        if parameters.isEmpty && options.isEmpty {
            return .empty
        } else {
            return .arguments(parameters: parameters, options: options)
        }
    }
    
    func getOptionResult(argument: String) throws -> OptionResult {
        return .option("")
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
