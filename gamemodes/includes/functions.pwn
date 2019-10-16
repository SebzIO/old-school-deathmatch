/*
                      /$$$$$$   /$$$$$$  /$$$$$$$  /$$      /$$
                     /$$__  $$ /$$__  $$| $$__  $$| $$$    /$$$
                    | $$  \ $$| $$  \__/| $$  \ $$| $$$$  /$$$$
                    | $$  | $$|  $$$$$$ | $$  | $$| $$ $$/$$ $$
                    | $$  | $$ \____  $$| $$  | $$| $$  $$$| $$
                    | $$  | $$ /$$  \ $$| $$  | $$| $$\  $ | $$
                    |  $$$$$$/|  $$$$$$/| $$$$$$$/| $$ \/  | $$
                     \______/  \______/ |_______/ |__/     |__/ 

//-------------------------[FUNCTIONS.PWN]--------------------------------


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

 //========================================================

// FUNCTIONS

#include "./includes/variables.pwn"

SendToAdmins(color, text[])
{
    foreach(new playerid : Player)
    {
        if(pInfo[playerid][Admin] >= 1)
        {
            SendClientMessage(playerid, color, text);
        }
    }
    return 1;
}

UnAuthMessage(playerid)
{
    return SendClientMessage(playerid, COLOR_COMMAND_ERROR, "ACCESS DENIED:{FFFFFF} You are not authorized to use this command.");
}

KickDelay(playerid, msg[])
{
    SendClientMessageToAll(COLOR_MAJOR_WARNING, msg);
    SetTimerEx("KickTime", 400, 0, "d", playerid);
    return 1;
}

GetName(playerid)
{
    new plrName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, plrName, sizeof(plrName));
    return plrName;
}

HideDialog(playerid)
{
    return ShowPlayerDialog(playerid, -1, 0, "","", "", "" ), 1;
}

GetPlayerAdminRank(playerid)
{
    new rankname[32];

    switch(pInfo[playerid][Admin])
    {
        case 1: { rankname = "Trial Administrator"; }
        case 2: { rankname = "Junior Administrator"; }
        case 3: { rankname = "Level 1 Administrator"; }
        case 4: { rankname = "Level 2 Administrator"; }
        case 5: { rankname = "Level 3 Administrator"; }
        case 6: { rankname = "Lead Administrator"; }
        case 7: { rankname = "Head of Staff"; }
        case 8: { rankname = "Community Manager"; }
    }

    return rankname;
}

GetPlayerAdutyStatus(playerid)
{
    new aDutyStatus[32];

    switch(aDuty[playerid])
    {
        case 0: {aDutyStatus = "Off-Duty";}
        case 1: {aDutyStatus = "On-Duty";}
    }

    return aDutyStatus;
}

WeaponIDToName(weaponID)
{
    new weaponName[30];

    switch(weaponID)
    {
        case 0: {weaponName = "Fist";}
        case 1: {weaponName = "Brass Knuckles";}
        case 2: {weaponName = "Golf Club";}
        case 3: {weaponName = "Nightstick";}
        case 4: {weaponName = "Knife";}
        case 5: {weaponName = "Baseball Bat";}
        case 6: {weaponName = "Shovel";}
        case 7: {weaponName = "Pool Cue";}
        case 8: {weaponName = "Katana";}
        case 9: {weaponName = "Chainsaw";}
        case 10: {weaponName = "Purple Dildo";}
        case 11: {weaponName = "Dildo";}
        case 12: {weaponName = "Vibrator";}
        case 13: {weaponName = "Silver Vibrator";}
        case 14: {weaponName = "Flowers";}
        case 15: {weaponName = "Cane";}
        case 16: {weaponName = "Grenade";}
        case 17: {weaponName = "Tear Gas";}
        case 18: {weaponName = "Molotov Cocktail";}
        case 22: {weaponName = "Colt 45";}
        case 23: {weaponName = "Silenced Pistol";}
        case 24: {weaponName = "Desert Eagle";}
        case 25: {weaponName = "Shotgun";}
        case 26: {weaponName = "Sawnoff Shotgun";}
        case 27: {weaponName = "Combat Shotgun";}
        case 28: {weaponName = "Micro Uzi";}
        case 29: {weaponName = "MP5";}
        case 30: {weaponName = "AK-47";}
        case 31: {weaponName = "M4";}
        case 32: {weaponName = "Tec-9";}
        case 33: {weaponName = "Country Rifle";}
        case 34: {weaponName = "Sniper Rifle";}
        case 35: {weaponName = "RPG";}
        case 36: {weaponName = "HS Rocket";}
        case 37: {weaponName = "Flamethrower";}
        case 38: {weaponName = "Minigun";}
        case 39: {weaponName = "Satchel Charge";}
        case 40: {weaponName = "Detonator";}
        case 41: {weaponName = "Spraycan";}
        case 42: {weaponName = "Fire Extinguisher";}
        case 43: {weaponName = "Camera";}
        case 44: {weaponName = "Night Vision Goggles";}
        case 45: {weaponName = "Thermal Goggles";}
        case 46: {weaponName = "Parachute";}
    }

    return weaponName;
}

GetTeamColor(playerid)
{
    new color;
    switch(GetPlayerTeam(playerid))
    {
        case 0: {color = COLOR_POLICE;}
        case 1: {color = COLOR_MAFIA;}
        case 2: {color = COLOR_MEDICS;}
        case 3: {color = COLOR_PIRU;}
        case 4: {color = COLOR_STRIPPERS;}
        case 5: {color = COLOR_HISPANICS;}
        case 6: {color = COLOR_CRENSHAW;}
        case 7: {color = COLOR_PIZZABOYS;}
        case 8: {color = COLOR_SHERIFF;}
    }

    return color;
}

SetEmptyVehiclesToRespawn()
{
    new bool:activeveh[MAX_VEHICLES + 1], tempveh;

    for(new i; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            tempveh = GetPlayerVehicleID(i);
            if(tempveh != INVALID_VEHICLE_ID)
            {
                activeveh[tempveh] = true;
            }
        }
    }

    for(new v = 1; v < (MAX_VEHICLES + 1); v++)
    {
        if(!activeveh[v])
        {
            SetVehicleToRespawn(v);
        }
    }

    return 1;
}

ReturnDate()
{
    new sendString[90], monthStr[40], month, day, year;
    new hour, minute, second;
 
    gettime(hour, minute, second);
    getdate(year, month, day);
    switch(month)
    {
        case 1:  monthStr = "January";
        case 2:  monthStr = "February";
        case 3:  monthStr = "March";
        case 4:  monthStr = "April";
        case 5:  monthStr = "May";
        case 6:  monthStr = "June";
        case 7:  monthStr = "July";
        case 8:  monthStr = "August";
        case 9:  monthStr = "September";
        case 10: monthStr = "October";
        case 11: monthStr = "November";
        case 12: monthStr = "December";
    }
 
    format(sendString, 90, "%s %d, %d %02d:%02d:%02d", monthStr, day, year, hour, minute, second);
    return sendString;
}

//========================================================