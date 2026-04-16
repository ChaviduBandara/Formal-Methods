# Battleships Formal Specification

A formal specification of the Battleships game using the **B-Method**, modeling players, ship types, game states, grid constraints, and validated ship deployment rules on a 10×10 board.

## Features

- **Formal B-Method Modeling**: Built using abstract machines, sets, constants, variables, invariants, and operations
- **Two-Player Game Model**: Supports `Player1` and `Player2`
- **10×10 Grid Representation**: Defines the playing area using coordinate-based positions
- **Ship Type Definitions**: Includes:
  - Submarine
  - Destroyer
  - Cruiser
- **Ship Size Mapping**: Each ship type is formally mapped to its correct size
- **Game State Modeling**: Covers states such as:
  - `SettingUp`
  - `Playing`
  - `Player1_Wins`
  - `Player2_Wins`
- **Validated Deployment Rules**:
  - Prevents invalid placements
  - Prevents overlapping ships
  - Prevents redeploying the same ship
  - Enforces setup order and phase restrictions
- **Orientation Support**: Horizontal and vertical placement logic
- **Error/Report Handling**: Uses formal report values for operation outcomes

## File Structure

```text
Battleships/
├── Battleships.mch            # Main Battleships machine
└── Battleships_Globals.mch    # Shared global definitions
```

## Project Overview

This project is a formal specification of the classic Battleships game written in the B-Method.
It focuses on defining the system behavior mathematically rather than building a graphical interface or a playable application.

The model captures important game rules such as player turns, ship placement, valid grid boundaries, non-overlapping ships, and state transitions. It is useful for understanding how formal methods can be used to specify and verify the correctness of a software system.

## Core Functionalities

# Player Modeling
Defines two players:
- Player1
- Player2

# Grid Definition
Uses a 10×10 grid
Coordinates are formally defined through GridX, GridY, and Grid

# Ship Types
The system models three ship types:
- Submarine → size 1
- Destroyer → size 2
- Cruiser → size 3

# Game States
The game progresses through formally defined states:
- SettingUp
- Playing
- Player1_Wins
- Player2_Wins

# Deployment Rules
The specification includes deployment operations that enforce:
- Ship placement only during setup
- Correct player turn during setup
- No duplicate deployment of the same ship
- No overlap with already occupied positions
- No out-of-bounds placement
- Setup-order requirements before deploying larger ships
