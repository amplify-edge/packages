## ARBS to JSON ( and back again)

Arb IS the default format for Flutter.

SO we need a way to convert back and forth between ARB and JSON

https://github.com/bmw-tech/arb-converter-cli

It will be best to rewrite this in golang actually. Its only 100 lines of code in typescript.

https://github.com/empirefox/protoc-gen-dart-ext/tree/master/pkg/arb
- this looks like a much better approach
- also has currency, etc

## Reconcilliation

Then wire a simple compare tool in golang to compare each side to see what is orphaned and on which side ( dart arb code or data side).