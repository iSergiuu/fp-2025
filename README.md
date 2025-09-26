# Game Library DSL

## Domain
The chosen domain is **video games** 🎮.  
The goal is to build a **Domain Specific Language (DSL)** that models a game library and the interactions with friends.  

Main entities:
- **Game**: a game has a title, genre, release year, and can contain other games (DLCs, expansions).  
- **Friend**: a friend has a username, a real name, and an online/offline status.  

Supported operations (DSL commands) include adding, removing, searching, playing, and gifting games.  

---

## BNF Grammar

<start> ::= <command_list>

<command_list> ::= <command> | <command> <newline> <command_list>

<command> ::= "dump" "examples"
            | "addGame" <game>
            | "removeGame" <game>
            | "giftGame" <friend> <game>
            | "playGame" <game>
            | "searchGame" <game>

<game> ::= <string> <string> <int> <addons>

<addons> ::= "[]" | "[" <game_list> "]"

<game_list> ::= <game> | <game> "," <game_list>

<friend> ::= "(" <string> <string> <bool> ")"

<string> ::= "\"" <char_seq> "\""

<char_seq> ::= <char> | <char> <char_seq>

<char> ::= "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k" | "l" | "m"
          | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z"
          | "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" | "K" | "L" | "M"
          | "N" | "O" | "P" | "Q" | "R" | "S" | "T" | "U" | "V" | "W" | "X" | "Y" | "Z"
          | "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
          | " " | "-" | ":"

<int> ::= <digit> | <digit> <int>

<digit> ::= "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"

<bool> ::= "True" | "False"

<newline> ::= "\n"

## Recursion

Recursion is present in the **Game** entity: a game can contain other games in its `addons` field.  
Example: *The Witcher 3* has two expansions (DLCs), which are themselves games.  


## Example Commands (DSL)

### Simple examples

addGame "Minecraft" "Sandbox" 2011 []
addGame "Red Dead Redemption 2" "Open World" 2018 []
removeGame "Far Cry I" "Action-adventure" 2004 []
playGame "EA Sports FC 26" "Sports" 2025 []
giftGame ("Miwy" "Andrei" True) ("Dying Light: The Beast" "Action RPG" 2025 [])

### Recursive example

addGame "The Witcher 3" "RPG" 2015
    [ "Hearts of Stone" "DLC" 2015 []
    , "Blood and Wine" "DLC" 2016 []
    ]

## Mapping BNF → ADT (Haskell)

addGame <game> → AddGame Game
removeGame <game> → RemoveGame Game
giftGame <friend> <game> → GiftGame Friend Game
playGame <game> → PlayGame Game
searchGame <game> → SearchGame Game
dump examples → Dump Examples


## Dump Examples

examples = 
    [ Dump Examples
    , AddGame (Game "Minecraft" "Sandbox" 2011 [])
    , AddGame (Game "Far Cry New Dawn" "Action-adventure" 2019 [])
    , AddGame (Game "Farming Simulator 17" "Simulator" 2016 [])
    , AddGame (Game "Red Dead Redemption 2" "Open World" 2018 [])
    , RemoveGame (Game "Far Cry I" "Action-adventure" 2004 [])
    , GiftGame (Friend "Miwy" "Andrei" True)
               (Game "Dying Light: The Beast" "Action RPG" 2025 [])
    , PlayGame (Game "EA Sports FC 26" "Sports" 2025 [])
    , SearchGame (Game "Metro 2033" "Shooter" 2010 [])
    , AddGame (Game "The Witcher 3" "RPG" 2015
                  [ Game "Hearts of Stone" "DLC" 2015 []
                  , Game "Blood and Wine" "DLC" 2016 []
                  ])
    ]
