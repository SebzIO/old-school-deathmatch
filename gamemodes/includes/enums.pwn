/*
                      /$$$$$$   /$$$$$$  /$$$$$$$  /$$      /$$
                     /$$__  $$ /$$__  $$| $$__  $$| $$$    /$$$
                    | $$  \ $$| $$  \__/| $$  \ $$| $$$$  /$$$$
                    | $$  | $$|  $$$$$$ | $$  | $$| $$ $$/$$ $$
                    | $$  | $$ \____  $$| $$  | $$| $$  $$$| $$
                    | $$  | $$ /$$  \ $$| $$  | $$| $$\  $ | $$
                    |  $$$$$$/|  $$$$$$/| $$$$$$$/| $$ \/  | $$
                     \______/  \______/ |_______/ |__/     |__/ 

//-------------------------[ENUMS.PWN]--------------------------------


 * Copyright (c) 2019, Old School Deathmatch
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are not permitted in any case.
 *
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

//=========== PLAYER DATA ENUMERATOR ==================

enum ENUM_PLAYER_DATA
{
    ID,
    Name[25],
    
    Password[65],
    Salt[11],

    IP[45],
    
    PasswordFails,
    
    Kills,
    Deaths,

    Admin,
    
    Score,
    Cash,
    
    Cache: Player_Cache,
    bool:LoggedIn
}

new pInfo[MAX_PLAYERS][ENUM_PLAYER_DATA]; // Player Data enumerator.

//=========== PLAYER CLASS ENUMERATOR ==================

enum E_PlayerClass
{
    E_MELEE,
    E_THROWN,
    E_HANDGUN,
    E_SHOTGUN,
    E_SUBMACHINE,
    E_ASSAULT,
    E_LONGRIFLE
}

new classData[MAX_PLAYERS][E_PlayerClass];

enum E_PlayerClassEdit
{
    E_MELEE,
    E_THROWN,
    E_HANDGUN,
    E_SHOTGUN,
    E_SUBMACHINE,
    E_ASSAULT,
    E_LONGRIFLE
}

new editClassData[5][MAX_PLAYERS][E_PlayerClassEdit];