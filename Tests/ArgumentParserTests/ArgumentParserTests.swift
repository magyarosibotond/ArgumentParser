import XCTest
@testable import ArgumentParser

final class ArgumentParserTests: XCTestCase {
    
    func testNoCommandNoOption() {
        let arguments: [String] = []
        let parser = ArgumentParser(arguments: arguments)
        
        do {
            let result = try parser.parse()

            let expectedResult = ParsingResult.empty

            XCTAssertTrue(result == ParsingResult.empty, "Parsing result should be .empty with not arguments given.")
        } catch {
            XCTFail("Failed: \(error.localizedDescription)")
        }
    }
    
    func testNoCommandSimpleOption() {
        let arguments: [String] = ["--verbose"]
        let parser = ArgumentParser(arguments: arguments)
        
        do {
            let result = try parser.parse()
            
            let expectedResult = ParsingResult.arguments(parameters: [],
                                                         options: [.option("verbose")])
            XCTAssertTrue(result == expectedResult, "Parsing result should be .option(verbose) when \"--verbose\" argument given.")
        } catch {
            XCTFail("Failed: \(error.localizedDescription)")
        }
    }
    
    func testNoCommandOptionValue() {
        let arguments: [String] = ["--type=swift"]
        let parser = ArgumentParser(arguments: arguments)
        
        do {
            let result = try parser.parse()
            
            let expectedResult = ParsingResult.arguments(parameters: [],
                                                         options: [.valueOption("type", "swift")])
            XCTAssertTrue(result == expectedResult, "Parsing result should be .valueOption(type, swift) when \"--type=swift\" argument given.")
        } catch {
            XCTFail("Failed: \(error.localizedDescription)")
        }
    }
    
    static var allTests = [
        ("testNoCommandNoOption", testNoCommandNoOption),
        ("testNoCommandSimpleOption", testNoCommandSimpleOption),
        ("testNoCommandOptionValue", testNoCommandOptionValue)
    ]
}