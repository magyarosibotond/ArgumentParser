import XCTest
@testable import ArgumentParser

final class ArgumentParserTests: XCTestCase {

    func testNoCommandNoOption() {
        let arguments: [String] = []
        let parser = ArgumentParser(arguments: arguments)
        
        do {
            let result = try parser.parse()

            let expectedResult = ParsingResult.empty

            XCTAssertTrue(result == expectedResult, "Parsing result should be .empty with not arguments given.")
        } catch {
            XCTFail("Failed: \(error.localizedDescription)")
        }
    }
    
    func testNoCommandSimpleOption() {
        let arguments: [String] = ["--verbose"]
        let parser = ArgumentParser(arguments: arguments)
        parser.add(Option(name: "verbose", shortName: nil, description: "Verbose execution."))
        
        do {
            let result = try parser.parse()
            
            let expectedResult = ParsingResult.arguments(parameters: [],
                                                         options: [.option("verbose")])
            XCTAssertTrue(result == expectedResult, "Parsing result should be .option(verbose) when \"--verbose\" argument given.")
        } catch {
            XCTFail("Failed: \(error.localizedDescription)")
        }
    }
    
    func testSimpleCommand() {
        let arguments: [String] = ["init"]
        let parser = ArgumentParser(arguments: arguments)
        parser.add(Command(name: "init", description: "Initialize tool."))
        
        do {
            let result = try parser.parse()
            
            let expectedResult = ParsingResult.command("init", .empty)
            XCTAssertTrue(result == expectedResult, "Parsing result should be .command(init, .empty) when \"init\" argument given.")
        } catch {
            XCTFail("Failed: \(error.localizedDescription)")
        }
    }
    
    
    func testSimpleCommandWithNestedOption() {
        let arguments: [String] = ["init", "--verbose"]
        let parser = ArgumentParser(arguments: arguments)
        parser.add(
            Command(name: "init", description: "Initialize tool.")
                <~ Option(name: "verbose", shortName: nil, description: "Verbose execution.")
        )
        
        do {
            let result = try parser.parse()
            
            let expectedResult = ParsingResult.command("init", .arguments(parameters: [], options: [.option("verbose")]))
            XCTAssertTrue(result == expectedResult, "Parsing result should be .command(init, .option(verbose)) when [\"init\", \"--verbose\"] arguments given.")
        } catch {
            XCTFail("Failed: \(error.localizedDescription)")
        }
    }
    
    
    static var allTests = [
        ("testNoCommandNoOption", testNoCommandNoOption),
        ("testNoCommandSimpleOption", testNoCommandSimpleOption)
    ]
}
