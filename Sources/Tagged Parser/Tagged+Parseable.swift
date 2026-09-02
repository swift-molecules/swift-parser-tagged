public import Parser
public import Tagged

extension Tagged::Tagged
where
    Underlying: Parseable,
    Underlying.Parser.Output == Underlying,
    Underlying.Parser.Input: ~Copyable & ~Escapable
{

    public struct UnderlyingParser: Parser::Parser.`Protocol` {

        public typealias Input = Underlying.Parser.Input

        public typealias Output = Tagged::Tagged<Tag, Underlying>

        public typealias Failure = Underlying.Parser.Failure

        @inlinable
        public init() {}

        @inlinable
        public borrowing func parse(
            _ input: inout Underlying.Parser.Input
        ) throws(Underlying.Parser.Failure) -> Tagged::Tagged<Tag, Underlying> {
            let underlying = try Underlying.parser.parse(&input)
            return Tagged::Tagged<Tag, Underlying>(_unchecked: underlying)
        }
    }
}

extension Tagged::Tagged: @retroactive Parseable
where
    Underlying: Parseable,
    Underlying.Parser.Output == Underlying,
    Underlying.Parser.Input: ~Copyable & ~Escapable
{

    @inlinable
    public static var parser: Tagged::Tagged<Tag, Underlying>.UnderlyingParser {
        Tagged::Tagged<Tag, Underlying>.UnderlyingParser()
    }
}
