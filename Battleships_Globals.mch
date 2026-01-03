/* Battleships_Globals
 * Author: User
 * Creation date: 1/3/2026
 */
MACHINE
    Battleships_Globals
    
SETS
    PLAYER = {Player1, Player2};
    SHIP_TYPE = {Submarine, Destroyer, Cruiser};
    ORIENTATION = {Horizontal, Vertical};
    REPORT = {
        Operation_Successful,
        Target_Hit,
        Target_Missed,
        Ship_Sunk,
        Invalid_position,
        Position_Occupied,
        Ship_Already_Deployed,
        Error_Wrong_Phase,
        Error_OutOfBounds,
        SetupNotComplete,
        Error_Already_Shot,
        Player1_Won,
        Player2_Won
    };
    GAME_STATE = {
        SettingUp,
        Playing,
        Player1_Wins,
        Player2_Wins
    }
    
CONSTANTS
    GridX, GridY, Grid, Ship_Size
    
PROPERTIES
    GridX = 1..10 & GridY = 1..10 & Grid = GridX * GridY & 
    Ship_Size : SHIP_TYPE --> NAT1 &
    Ship_Size = {
        Submarine |-> 1,
        Destroyer |-> 2,
        Cruiser |-> 3
    }

END
