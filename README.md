# swift-tagged-parser

Focused Parser integration for the Tagged domain.

`Tagged Parser` makes a tagged value `Parseable` whenever its underlying value
is parseable as itself. The adapter preserves the underlying parser's input and
failure types while wrapping successful output in the requested tag.
