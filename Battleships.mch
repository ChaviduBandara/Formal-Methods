/* Battleships
 * Author: User
 * Creation date: 1/2/2026
 */
MACHINE
    Battleships
    
SETS
    PLAYER = {Player1, Player2};
    SHIP_TYPE = {Submarine, Destroyer, Cruiser};
    ORIENTATION = {Horizontal, Vertical};
    REPORT = {
        Operation_Successful,
        Traget_Hit,
        Target_Missed,
        Ship_Shunk,
        Invalid_position,
        Position_Occupied,
        Ship_Already_Deployed,
        Error_Wrong_Phase,
        Error_OutOfBounds,
        SetupNotComplete
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
    
VARIABLES
    game_state, current_player, ships_placed, ship_occupancy, shots_taken
    
INVARIANT
    game_state : GAME_STATE & current_player : PLAYER &
    ships_placed : PLAYER <-> SHIP_TYPE &
    ship_occupancy : (PLAYER * SHIP_TYPE) <-> Grid &
    shots_taken : PLAYER <-> Grid &
    dom(ship_occupancy) = ships_placed &
    
    !(pp, s1, s2).(
        pp : PLAYER &
        s1 : SHIP_TYPE &
        s2 : SHIP_TYPE &
        s1 /= s2 &
        (pp, s1) : ships_placed & (pp, s2) : ships_placed
        =>
        ship_occupancy[{ (pp, s1) }] /\ ship_occupancy [{ (pp, s2) }] = {}
    )
    
INITIALISATION
    game_state := SettingUp || 
    current_player := Player1 ||
    ship_occupancy := {} ||
    ships_placed := {} ||
    shots_taken := {}
    
OPERATIONS
    // Deploy Submarine
    res <-- DeploySubmarine(player, position)=
    PRE
        player : PLAYER & position : Grid
    THEN
        IF game_state /= SettingUp 
        THEN
            res := Error_Wrong_Phase
        ELSIF
            player /= current_player 
        THEN
            res := Error_Wrong_Phase
        ELSIF
            (player, Submarine) : ships_placed
        THEN
            res := Ship_Already_Deployed
        ELSE
            ships_placed := ships_placed \/ {(player, Submarine)} ||
            ship_occupancy := ship_occupancy \/ {(player, Submarine) |-> position} ||
            res := Operation_Successful
        END
    END;
    
    // Deploy Destroyer
    res <-- DeployDestroyer(player, position, orientation)=
    PRE
        player : PLAYER & position : Grid & orientation : ORIENTATION
    THEN
        IF game_state /= SettingUp 
        THEN
            res := Error_Wrong_Phase
        ELSIF player /= current_player 
        THEN
            res := Error_Wrong_Phase
        ELSIF (player, Submarine) /: ships_placed 
        THEN
            res := SetupNotComplete
        ELSIF (player, Destroyer) : ships_placed 
        THEN
            res := Ship_Already_Deployed
            
        // Horizontal Logic    
        ELSIF orientation = Horizontal 
        THEN
            IF prj1(GridX, GridY)(position) > 9 
            THEN
                res := Error_OutOfBounds
            ELSIF 
                position : ship_occupancy[{ (player, Submarine), (player, Destroyer), (player, Cruiser) }] or
                (prj1(GridX, GridY)(position) + 1, prj2(GridX, GridY)(position)) : ship_occupancy[{ (player, Submarine), (player, Destroyer), (player, Cruiser) }]
            THEN
                res := Position_Occupied
            ELSE
                ships_placed := ships_placed \/ {(player, Destroyer)} ||
                ship_occupancy := ship_occupancy \/ {
                    (player, Destroyer) |-> position,
                    (player, Destroyer) |-> (prj1(GridX, GridY)(position) + 1, prj2(GridX, GridY)(position))
                } ||
                res := Operation_Successful
            END
            
            // Vertical Logic
        ELSE
            IF prj2(GridX, GridY)(position) > 9
            THEN
                res := Error_OutOfBounds
            ELSIF
                position : ship_occupancy [{ (player, Submarine), (player, Destroyer), (player, Cruiser) }] or
                (prj1(GridX, GridY)(position), prj2(GridX, GridY)(position) + 1) : ship_occupancy[{ (player, Submarine), (player, Destroyer), (player, Cruiser) }]
            THEN
                res := Position_Occupied
            ELSE
                ships_placed := ships_placed \/ {(player, Destroyer)} ||
                ship_occupancy := ship_occupancy \/ {
                    (player, Destroyer) |-> position,
                    (player, Destroyer) |-> (prj1(GridX, GridY)(position), prj2(GridX, GridY)(position) + 1)
                } ||
                res := Operation_Successful
            END
        END
    END;
    
    // Deploy Cruiser
    
    
               
END
