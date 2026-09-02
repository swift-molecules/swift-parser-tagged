import Parser
import Tagged_Parser
import Tagged
import Testing

@Suite
struct `Tagged Parser` {

    @Test
    func `parseable lifts its parser through the tag`() throws(any Swift.Error) {
        var input: Substring = "abc"

        let value = try Tagged::Tagged<Field, Token>.parser.parse(&input)

        #expect(value.underlying == Token(character: "a"))
        #expect(input == "bc")
    }
}

private enum Field {}

private struct Token: Equatable, Parseable {
    let character: Character

    static var parser: TokenParser {
        TokenParser()
    }
}

private enum TokenError: Error {
    case empty
}

private struct TokenParser: Parser::Parser.`Protocol` {
    typealias Input = Substring
    typealias Output = Token
    typealias Failure = TokenError

    func parse(_ input: inout Substring) throws(TokenError) -> Token {
        guard let character = input.first else { throw .empty }
        input = input.dropFirst()
        return Token(character: character)
    }
}
