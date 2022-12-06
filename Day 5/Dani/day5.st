input := stdin nextLine.
c := ArrayList new.

[ input ~= nil ] whileTrue: [
    c add: input.
    input := stdin nextLine.
].

c do: [ :each | each printNl ]