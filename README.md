# Mastermind
A ruby implementation of [Mastermind](https://en.wikipedia.org/wiki/Mastermind_(board_game)#Gameplay_and_rules)

## To run
```
$ git clone git@github.com:kehlynch/mastermind-ruby.git
$ cd mastermind-ruby
$ ruby mastermind.rb
Code has been chosen!
❓❓❓❓
Guess from 6 colours 🔴💚💙💛💜🍊
rgbypo or 123456 > rybg
🔴💛💙💚 ⚫️⚪️

guess 2 > grry
💚🔴🔴💛 ⚫️
...

```

## Colour output
If the [colorize gem](https://github.com/fazibear/colorize) is installed the guess hints will be coloured
```
$ gem install colorize
```

## Debug mode
Pass `debug` as a command line argument to show the code
```
$ ruby mastermind.rb debug
Code has been chosen!
💙🍊🍊💙
Guess from 6 colours 🔴💚💙💛💜🍊
rgbypo or 123456 >
```

## TODO
* guess cap (standard is 10, would be nice to make user configurable)
* scoring
* allow player to switch modes (breaker, setter, watch)
    * code breaker logic
* add more testing
* high scores
* configurable number of colors/guess pegs/guesses
