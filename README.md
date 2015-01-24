Author: Peter DePaulo
GitHub: pndpo

Instructions from assignment at www.vikingcodeschool.com:

## Intermediate: Mastermind

It's time to pull together a slightly more meaty game. Mastermind is a board game where you need to guess your opponent's colored pegs within 12 turns. Each turn, you will get feedback about how good your guesses were (e.g. is it exactly correct or just the correct color in the wrong space?).

# Your Task

Build a Mastermind game from the command line where you have 12 turns to guess the secret code. Begin each turn by rendering the current state of the game board and soliciting a guess from the player. Assume the human is the "codebreaker".

Start by thinking through the problem and whiteboarding your solution. Focus on:

Which parts of the program should actually be separate objects (classes) and methods? You can optionally wrap them all in a module.

What variables and methods need to be exposed and which should be private?

# Human as Codemaker

Now add functionality which asks whether the player would like to be the "codemaker" or "codebreaker". Create a simple AI which will play the game by making guesses if you choose "codemaker".

As always, think through how you would implement this problem before diving into the code. Focus on:

What functionality is shared between the human player and AI player? How can you DRY out your code using OOP principles?
What can you refactor in your existing code to make sure each class or method only does one thing?
Bonus: Saving

Give the user the option each turn to either enter a move or save their game (to a file). When the game begins, give the user the option to start a new game or open the saved game.

TODO:

dynamic ANSI colored pegs for when the user inputs
CLI green load with an animation and a music file and VFX

########################################

V 1.0 Gameplay:

Game initializes with a code and a code_breaker
Computer generates code
Computer prompts code_breaker for a guess
The guess is tested against the code
win is checked
  win is all colors and positions match
the response is rendered
repeat until games > 12 or win

Pseudo Code
Set up the game [Mastermind]
	create a @board [Board]
	create a @code [CodeMaker]
	create a @code_breaker [CodeBreaker]
Start the game loop [Mastermind]
	render the board [Board]
	Ask for player to guess and validate guess
	If game ends [Mastermind]
		render the victory/ lose message
		stop loop
	else
		Keep looping [Mastermind]

NOTE: the RESULT holds the guesses and checks them against the code
then returns the result array. The render function renders this result.
Should the board render in full with all results each round?
