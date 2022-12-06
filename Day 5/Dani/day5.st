input := stdin nextLine.
c := OrderedCollection new.

[ input ~= nil ] whileTrue: [
    c add: input.
    input := stdin nextLine.
].

c sort do: [ :each | each printNl ]