Integration of the Parser domain with the Tagged domain.

`Parser Tagged` makes a tagged value `Parseable` whenever its underlying value
is parseable as itself. The adapter preserves the underlying parser's input and
failure types while wrapping successful output in the requested tag.
