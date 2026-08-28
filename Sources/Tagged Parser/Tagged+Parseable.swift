public import Parser
public import Tagged

extension Tagged::Tagged where Underlying: Parseable, Underlying.Parser.Output == Underlying {

    public struct UnderlyingParser {

        @inlinable
        public init() {}
    }
}

extension Tagged::Tagged.UnderlyingParser: Parser::Parser.`Protocol`
where
    Underlying: Parseable,
    Underlying.Parser.Output == Underlying
{

    public typealias Input = Underlying.Parser.Input

    public typealias Output = Tagged::Tagged<Tag, Underlying>

    public typealias Failure = Underlying.Parser.Failure

    public typealias Body = Never

    @inlinable
    public borrowing func parse(
        _ input: inout Underlying.Parser.Input
    ) throws(Underlying.Parser.Failure) -> Tagged::Tagged<Tag, Underlying> {
        let underlying = try Underlying.parser.parse(&input)
        return Tagged::Tagged<Tag, Underlying>(_unchecked: underlying)
    }
}

extension Tagged::Tagged: @retroactive Parseable
where
    Underlying: Parseable,
    Underlying.Parser.Output == Underlying
{

    @inlinable
    public static var parser: Tagged::Tagged<Tag, Underlying>.UnderlyingParser {
        Tagged::Tagged<Tag, Underlying>.UnderlyingParser()
    }
}
