# The Pawn Simulator

## Description 

- The application is a simulation of a Pawn moving on a chess board, of dimensions 8
squares x 8 squares.
- There are no other obstructions/pieces on the chess board.
- The pawn is free to roam around the surface of the table following the rules below,but must be prevented from falling off. Any movement that would result in the pawnfalling from the table must be prevented, however further valid movement commands must still be allowed.
- The pawn can move only to adjacent squares but not diagonally. The first time that the pawn moves it can move 1 or 2 squares.

## Steps to Run the project Locally

To run this project, you will need to install the following libraries to your system

`ruby: 3.0.0`

`rails: 7.0.6`

### Installing Dependencies
once you have them on your machine and you are in project folder, run `bundle install` and all of the project dependencies will be installed.


#### Database creation

Create make sure you have postgresql installed and provide details of database in file(if needed):

```bash
database.yml
```


After that you can create a database and run seed files by and install any dependencies by command

```bash
bin/setup
```
once all done you just need to run the project by starting the server for rails, JS & SCSS compiler by

```bash
  bin/dev
```
To run Tests you can use following commands: 
- TO run capybara Tests you can run command (capybara will open crome tab and run test cases)
```bash
  rails test:system
```

- TO run Mini Tests you can run command it will run all of the unit tests

```bash
  rails test
```
## Project Overview

Once the server is running you can redirect to the home address which in case of local will be  `http://localhost:3000/`  the UI will appear as soon as you  are on the page.


## Possible Commands

The application accepts specific commands, the details of command is given below


| Command       | Purpose    | Example                       |
|--------------|---------|-------------------------------|
|   PLACE     | Place pawn on specific place  | PLACE 0,0,NORTH,WHITE                      |
| MOVE         | Move pawn  | MOVE 1                     |
| LEFT         | rotate pawn to left  | LEFT                      |
| RIGHT          | rotate pawn to the right  | RIGHT      |
| REPORT       | Get details for the pawn  | REPORT      |
                     

- **Important Note:**
  - `No movement/rotation is allowed before PLACE command`

---
## Author

- [github:@muhammad-ur-rehman](https://github.com/muhammad-ur-rehman)

- [linkedin:@m-ur-rehman](https://www.linkedin.com/in/m-ur-rehman/)
