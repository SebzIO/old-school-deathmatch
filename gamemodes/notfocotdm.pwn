/*
					  /$$$$$$   /$$$$$$  /$$$$$$$  /$$      /$$
					 /$$__  $$ /$$__  $$| $$__  $$| $$$    /$$$
					| $$  \ $$| $$  \__/| $$  \ $$| $$$$  /$$$$
					| $$  | $$|  $$$$$$ | $$  | $$| $$ $$/$$ $$
					| $$  | $$ \____  $$| $$  | $$| $$  $$$| $$
					| $$  | $$ /$$  \ $$| $$  | $$| $$\  $ | $$
					|  $$$$$$/|  $$$$$$/| $$$$$$$/| $$ \/  | $$
					 \______/  \______/ |_______/ |__/     |__/ 

//-------------------------[OSDM.PWN]--------------------------------


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

#include <a_samp>
#include <a_mysql>
#include <streamer>
#include <foreach>
#include <nex-ac>
#include <izcmd>
#include <sscanf2>
#include <BustAim>
#include <discord-connector>
#include <discord-command>
#include <SKY.inc>
#include <weapon-config>

#include "./includes/connections.pwn"
#include "./includes/defines.pwn"
#include "./includes/discord.pwn"
#include "./includes/enums.pwn"
#include "./includes/functions.pwn"
#include "./includes/mapping.pwn"
#include "./includes/variables.pwn"
 
#include "./includes/admin/anticheat.pwn"
#include "./includes/admin/commands.pwn"

#include "./includes/player/satchels.pwn"
#include "./includes/player/classes.pwn"
#include "./includes/player/commands.pwn"


#undef MAX_PLAYERS
#define MAX_PLAYERS 100

//=====================================================


main()
{
	print("Gamemode initialized");
}


public OnGameModeInit()
{
	// Weapon Config
	SetVehiclePassengerDamage(true);
    SetDisableSyncBugs(true);

	// Discord
	DCC_SetBotActivity("Watching the server");

	// Random messages
	SetTimer("SendMSG", 600000, true);

	// Player table creation (if it does not exist).
	mysql_tquery(Database, "CREATE TABLE IF NOT EXISTS `PLAYERS` (`ID` int(11) NOT NULL AUTO_INCREMENT,`USERNAME` varchar(24) NOT NULL,`PASSWORD` char(65) NOT NULL,`SALT` char(11) NOT NULL,`IP` varchar(45) NOT NULL,`SCORE` mediumint(7), `KILLS` mediumint(7), `CASH` mediumint(7) NOT NULL DEFAULT '0',`DEATHS` mediumint(7) NOT NULL DEFAULT '0',`ADMIN` mediumint(7) NOT NULL DEFAULT '0', PRIMARY KEY (`ID`), UNIQUE KEY `USERNAME` (`USERNAME`))");
	//================================================

	// Bans table creation (if it does not exist).
	mysql_tquery(Database, "CREATE TABLE IF NOT EXISTS `BANS` (`ID` int(11) NOT NULL AUTO_INCREMENT,`USERNAME` varchar(24) NOT NULL,`IP` varchar(45) NOT NULL,`ACTIVE` boolean NOT NULL DEFAULT 'false',`ADMIN` varchar(24) NOT NULL,`REASON` varchar(24) NOT NULL, `DATE` VARCHAR(30) NOT NULL, PRIMARY KEY (`ID`), UNIQUE KEY `USERNAME` (`USERNAME`))");
	//================================================

	// SAMP Server variables
	new initString[128];
	format(initString, sizeof(initString), "Gamemode successfully initialized. Version: Beta %i.%i.%i", MAJOR_VERSION, MINOR_VERSION, UPDATE);
	
	new hostname[128];
	format(hostname, sizeof(hostname), "hostname %s", SERVER_NAME);
	SendRconCommand(hostname);
	
	new gamemode[128];
	format(gamemode, sizeof(gamemode), "OS-DM v%d.%d.%d BETA", MAJOR_VERSION, MINOR_VERSION, UPDATE);
	SetGameModeText(gamemode);
	// =====================

	// Disabling/enabling singleplayer functions and other common functions.
	EnableVehicleFriendlyFire(); // No friendly fire on vehicles
    DisableInteriorEnterExits(); // Disable default enterable buildings
    EnableStuntBonusForAll(0); // No insane stunt bonuses

    SetTeamCount(18); // Number of possible teams
    SpawnMapping(); // Spawning mapping/vehicles
	// =====================

    // Player team spawn points and their skins.
	AddPlayerClass(281,1527.8451,-1666.1776,6.2188,269.7270,0,0,0,0,0,0); // TEAM_POLICE
	AddPlayerClass(258,1614.3346,-1893.1771,13.5469,353.6202,0,0,0,0,0,0); // TEAM_MAFIA
	AddPlayerClass(276,1181.1863,-1323.3145,13.5845,264.9875,0,0,0,0,0,0); // TEAM_MEDICS
	AddPlayerClass(19,2517.4446,-1673.5164,14.0904,65.6901,0,0,0,0,0,0); // TEAM_PIRU
	AddPlayerClass(178,2421.5190,-1220.7302,25.4656,180.3368,0,0,0,0,0,0); // TEAM_STRIPPERS
	AddPlayerClass(116,1882.6505,-2018.1281,13.3906,179.5933,0,0,0,0,0,0); // TEAM_HISPANICS
	AddPlayerClass(21,2140.4761,-1454.5516,24.1212,89.9411,0,0,0,0,0,0); // TEAM_CRENSHAW
	AddPlayerClass(155,2100.2622,-1806.5969,13.5547,86.5500,0,0,0,0,0,0); // TEAM_PIZZABOYS
	AddPlayerClass(311,1829.7382,-1414.5942,13.6016,1.2951,0,0,0,0,0,0); // TEAM_SHERIFF
	// =====================

	// Streamer GangZones
	gangZoneIdleGas = CreateDynamicRectangle(1955.0344, -1758.1150, 1904.2009, -1797.0093); // Idlewood Gas Station
	// =====================
	return 1;
}

public OnGameModeExit()
{
	mysql_close(Database);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	switch(classid)
	{
	    case 0:
	    {
	        GameTextForPlayer(playerid,"~w~Los Santos Police Department",3000,5);
	        gTeam[playerid] = TEAM_POLICE;
	    	SetPlayerPos(playerid, 1527.8451, -1666.1776, 6.2188);
			SetPlayerCameraPos(playerid, 1533.6007, -1665.6188, 5.8906);
			SetPlayerCameraLookAt(playerid, 1527.8451, -1666.1776, 6.2188);
	        SetPlayerTeam(playerid, TEAM_POLICE);
	        SetPlayerColor(playerid, COLOR_POLICE);
	    }

	    case 1:
	    {
	        GameTextForPlayer(playerid,"~w~Mafia",3000,5);
	        gTeam[playerid] = TEAM_MAFIA;
	    	SetPlayerPos(playerid, 1614.3346, -1893.1771, 13.5469);
			SetPlayerCameraPos(playerid, 1618.5286, -1892.9930, 13.5487);
			SetPlayerCameraLookAt(playerid, 1614.3346, -1893.1771, 13.5469);
	        SetPlayerTeam(playerid, TEAM_MAFIA);
	        SetPlayerColor(playerid, COLOR_MAFIA);
	    }

	    case 2:
	    {
	        GameTextForPlayer(playerid,"~w~Los Santos Fire Department",3000,5);
	        gTeam[playerid] = TEAM_MEDICS;
	    	SetPlayerPos(playerid, 1181.1863, -1323.3145, 13.5845);
			SetPlayerCameraPos(playerid, 1186.5980, -1323.2159, 13.5589);
			SetPlayerCameraLookAt(playerid, 1181.1863, -1323.3145, 13.5845);
	        SetPlayerTeam(playerid, TEAM_MEDICS);
	        SetPlayerColor(playerid, COLOR_MEDICS);
	    }

	    case 3:
	    {
	        GameTextForPlayer(playerid,"~w~Piru",3000,5);
	        gTeam[playerid] = TEAM_PIRU;
	    	SetPlayerPos(playerid, 2517.4446, -1673.5164, 14.0904);
			SetPlayerCameraPos(playerid, 2510.8079, -1671.5580, 13.4314);
			SetPlayerCameraLookAt(playerid, 2517.4446, -1673.5164, 14.0904);
	        SetPlayerTeam(playerid, TEAM_PIRU);
	        SetPlayerColor(playerid, COLOR_PIRU);
	    }

	    case 4:
	    {
	        GameTextForPlayer(playerid,"~w~The Valentines",3000,5);
	        gTeam[playerid] = TEAM_STRIPPERS;
	    	SetPlayerPos(playerid, 2421.5190, -1220.7302, 25.4656);
			SetPlayerCameraPos(playerid, 2421.3115, -1225.4768, 25.1294);
			SetPlayerCameraLookAt(playerid, 2421.5190, -1220.7302, 25.4656);
	        SetPlayerTeam(playerid, TEAM_STRIPPERS);
	        SetPlayerColor(playerid, COLOR_STRIPPERS);
	    }

	    case 5:
	    {
	        GameTextForPlayer(playerid,"~w~Hispanics",3000,5);
	        gTeam[playerid] = TEAM_HISPANICS;
	    	SetPlayerPos(playerid, 1882.6505, -2018.1281, 13.3906);
			SetPlayerCameraPos(playerid, 1882.3632, -2024.3213, 13.3906);
			SetPlayerCameraLookAt(playerid, 1882.6505, -2018.1281, 13.3906);
	        SetPlayerTeam(playerid, TEAM_HISPANICS);
	        SetPlayerColor(playerid, COLOR_HISPANICS);
	    }

	    case 6:
	    {
	        GameTextForPlayer(playerid,"~w~Crenshaw",3000,5);
	        gTeam[playerid] = TEAM_CRENSHAW;
			SetPlayerPos(playerid, 2140.4761, -1454.5516, 24.1212);
			SetPlayerCameraPos(playerid, 2144.4761, -1460.5516, 24.1212);
			SetPlayerCameraLookAt(playerid, 2140.4761, -1454.5516, 24.1212);
	        SetPlayerTeam(playerid, TEAM_CRENSHAW);
	        SetPlayerColor(playerid, COLOR_CRENSHAW);
	    }

	    case 7:
	    {
	        GameTextForPlayer(playerid,"~w~PizzaBoys",3000,5);
	        gTeam[playerid] = TEAM_PIZZABOYS;
	    	SetPlayerPos(playerid, 2100.2622, -1806.5969, 13.5547);
			SetPlayerCameraPos(playerid, 2108.2622, -1800.5969, 13.5547);
			SetPlayerCameraLookAt(playerid, 2100.2622, -1806.5969, 13.5547);
	        SetPlayerTeam(playerid, TEAM_PIZZABOYS);
	        SetPlayerColor(playerid, COLOR_PIZZABOYS);
	    }

	    case 8:
	    {
	        GameTextForPlayer(playerid,"~w~Los Santos Sheriff's Department",3000,5);
	        gTeam[playerid] = TEAM_SHERIFF;
	    	SetPlayerPos(playerid, 1829.7382, -1414.5942, 13.6016);
			SetPlayerCameraPos(playerid, 1829.3568,-1406.6129,13.6016);
			SetPlayerCameraLookAt(playerid, 1829.7382, -1414.5942, 13.6016);
	        SetPlayerTeam(playerid, TEAM_SHERIFF);
	        SetPlayerColor(playerid, COLOR_SHERIFF);
	    }
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	ids[playerid] = 0; // BustAim IDS reset

	new DB_Query[115];

	// Resetting all player information to null values to avoid new players having old players stats/data.
	pInfo[playerid][Kills] = 0;
	pInfo[playerid][Deaths] = 0;
	pInfo[playerid][PasswordFails] = 0;
	pInfo[playerid][Score] = 0;
	pInfo[playerid][Cash] = 0;
	pInfo[playerid][Admin] = 0;
	aDuty[playerid] = 0;

	// MYSQL Login/Register data check
	GetPlayerName(playerid, pInfo[playerid][Name], MAX_PLAYER_NAME); // Getting the player's name.

	new plrIP[45];
	GetPlayerIp(playerid, plrIP, sizeof(plrIP));
	pInfo[playerid][IP] = plrIP;

	Corrupt_Check[playerid]++;
	
	mysql_format(Database, DB_Query, sizeof(DB_Query), "SELECT * FROM `PLAYERS` WHERE `USERNAME` = '%e' LIMIT 1", pInfo[playerid][Name]);
	mysql_tquery(Database, DB_Query, "OnPlayerDataCheck", "ii", playerid, Corrupt_Check[playerid]);
	
	SetPlayerColor(playerid, COLOR_WHITE); // Setting the player color to white until they choose a class.

	// BAN CHECK
	new query[500], playerName[MAX_PLAYER_NAME + 1];
	GetPlayerName(playerid, playerName, sizeof(playerName));
    format(query, sizeof(query), "SELECT * FROM `BANS` WHERE `IP` = '%s' OR `USERNAME` = '%e'", pInfo[playerid][IP], playerName);
    mysql_tquery(Database, query);
    if(cache_num_rows() > 0)
    {
    	HideDialog(playerid);
        new banstring[256], bName[30], bIP[45], bAdmin[30], bReason[128];
        cache_get_value_name(0, "USERNAME", bName);
        cache_get_value_name(0, "IP", bIP);
        cache_get_value_name(0, "ADMIN", bAdmin);
        cache_get_value_name(0, "REASON", bReason);
        format(banstring, sizeof(banstring), "Name: %s | IP: %s | Admin: %s | Reason: %s", bName, bIP, bAdmin, bReason);
        SendClientMessage(playerid, COLOR_MAJOR_WARNING, banstring);
        ShowPlayerDialog(playerid, DIALOG_BANNED, DIALOG_STYLE_MSGBOX, "You are banned from Old School Deathmatch", banstring, "Appeal On", "The Forums");
        KickDelay(playerid, "You are banned from Old School Deathmatch. Appeal on the forums @ forum.osdm.xyz");
    }

    // Join messages
    new string[128];
    format(string, sizeof(string), "%s has joined the server.", GetName(playerid));
    SendClientMessageToAll(0xAAAAAAAA, string);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	aDuty[playerid] = 0;
	pInfo[playerid][LoggedIn] = false;

    new disconnectname[MAX_PLAYER_NAME], string[39 + MAX_PLAYER_NAME];
    GetPlayerName(playerid, disconnectname, sizeof(disconnectname));
    switch(reason)
    {
        case 0: format(string, sizeof(string), "%s has left the server. (Lost Connection)", disconnectname);
        case 1: format(string, sizeof(string), "%s has left the server. (Leaving)", disconnectname);
        case 2: format(string, sizeof(string), "%s has left the server. (Kicked/Banned)", disconnectname);
    }
    SendClientMessageToAll(0xAAAAAAAA, string);

	print("OnPlayerDisconnect has been called.");
	return 1;
}

public OnPlayerSpawn(playerid)
{
	// Team system
	new playerskin = GetPlayerSkin(playerid);
	if(playerskin == 281) {
		gTeam[playerid] = TEAM_POLICE;
 		SetPlayerTeam(playerid, TEAM_POLICE);
	}	else if(playerskin == 258) {
		gTeam[playerid] = TEAM_MAFIA;
 		SetPlayerTeam(playerid, TEAM_MAFIA);
	}	else if(playerskin == 276) {
		gTeam[playerid] = TEAM_MEDICS;
 		SetPlayerTeam(playerid, TEAM_MEDICS);
	}	else if(playerskin == 19) {
		gTeam[playerid] = TEAM_PIRU;
 		SetPlayerTeam(playerid, TEAM_PIRU);
	}	else if(playerskin == 178) {
		gTeam[playerid] = TEAM_STRIPPERS;
 		SetPlayerTeam(playerid, TEAM_STRIPPERS);
	}	else if(playerskin == 116) {
		gTeam[playerid] = TEAM_HISPANICS;
 		SetPlayerTeam(playerid, TEAM_HISPANICS);
	}	else if(playerskin == 21) {
		gTeam[playerid] = TEAM_CRENSHAW;
 		SetPlayerTeam(playerid, TEAM_CRENSHAW);
	}	else if(playerskin == 155) {
		gTeam[playerid] = TEAM_PIZZABOYS;
 		SetPlayerTeam(playerid, TEAM_PIZZABOYS);
	}	else if(playerskin == 311) {
		gTeam[playerid] = TEAM_SHERIFF;
 		SetPlayerTeam(playerid, TEAM_SHERIFF);
	}
		else {
		SendClientMessage(playerid, COLOR_COMMAND_ERROR, "ERROR: You are not a member of any team, /changeteam immediately!");
	}
	//===========

	GivePlayerWeapon(playerid, 24, 2500); // Always spawn with desert eagle.
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid != INVALID_PLAYER_ID)
	{
		pInfo[killerid][Score] = pInfo[killerid][Score] + 1;
		pInfo[killerid][Cash] = pInfo[killerid][Cash] + 300;
	  	SetPlayerScore(killerid, pInfo[killerid][Score]);
	  	GivePlayerMoney(killerid, pInfo[killerid][Cash]);

	    pInfo[killerid][Kills]++; // Plus one kill to the killer's stats.
	    pInfo[playerid][Deaths]++; // Plus one death to the victim's stats.
	    new DB_Query[1000];

	    // Killer's kills saved via mysql.
	    mysql_format(Database, DB_Query, sizeof(DB_Query), "UPDATE `PLAYERS` SET `KILLS` = %d WHERE `ID` = %d LIMIT 1", pInfo[killerid][Kills], pInfo[killerid][ID]);
		mysql_tquery(Database, DB_Query);

		// Killer's score saved via mysql.
		mysql_format(Database, DB_Query, sizeof(DB_Query), "UPDATE `PLAYERS` SET `SCORE` = %d WHERE `ID` = %d LIMIT 1", pInfo[killerid][Score], pInfo[killerid][ID]);
		mysql_tquery(Database, DB_Query);

		// Killer's money saved via mysql.
		mysql_format(Database, DB_Query, sizeof(DB_Query), "UPDATE `PLAYERS` SET `CASH` = %d WHERE `ID` = %d LIMIT 1", pInfo[killerid][Cash], pInfo[killerid][ID]);
		mysql_tquery(Database, DB_Query);

		// Save victim's deaths via mysql.
		mysql_format(Database, DB_Query, sizeof(DB_Query), "UPDATE `PLAYERS` SET `DEATHS` = %d WHERE `ID` = %d LIMIT 1", pInfo[playerid][Deaths], pInfo[playerid][ID]);
		mysql_tquery(Database, DB_Query);

	    SendDeathMessage(killerid, playerid, reason);
	}
	return 1;
}

public OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart)
{
	// Disable helikill and carpark
    if(weapon == WEAPON_CARPARK || weapon == WEAPON_HELIBLADES)
    {
        return 0;
    }

    // Ignore low fall damage
    if(weapon == WEAPON_COLLISION && amount < 10.0)
    {
        return 0;
    }

	if(aDuty[playerid] == 1)
	{
		SetPlayerHealth(playerid, 10000);
		GameTextForPlayer(issuerid, "Do not shoot at on duty admins.", 5000, 3);
	}

	PlayerPlaySound(issuerid, 17802, 0.0, 0.0, 0.0); // Hitmarker ding sound.
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(hittype == 1 && gTeam[playerid] == gTeam[hitid])
	{
	    return 0;
	}
    return 1;
}

// Streamer

public OnPlayerEnterDynamicArea(playerid, areaid)
{
	if(areaid == gangZoneIdleGas)
	{
		//SendClientMessage(playerid, COLOR_MAJOR_WARNING, "You're in idlegas");
	}
	return 1;
}

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
	if(areaid == gangZoneIdleGas)
	{
		//SendClientMessage(playerid, COLOR_MAJOR_WARNING, "You have left idlegas");
	}
	return 1;
}

// =========

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(pInfo[playerid][Admin] == 0 && pInfo[playerid][LoggedIn] == true)
	{
		new name[MAX_PLAYER_NAME+1], msg[144];

		GetPlayerName(playerid, name, sizeof(name));
		format(msg, sizeof(msg), "[%01d] %s: {FFFFFF}%s", playerid, name, text);

		SendClientMessageToAll(GetPlayerColor(playerid), msg);
	}
	else if(pInfo[playerid][Admin] > 0 && pInfo[playerid][LoggedIn] == true)
	{
		new name[MAX_PLAYER_NAME+1], msg[144];

		GetPlayerName(playerid, name, sizeof(name));
		format(msg, sizeof(msg), "[%01d] %s %s: {FFFFFF}%s", playerid, GetPlayerAdminRank(playerid), name, text);

		SendClientMessageToAll(GetPlayerColor(playerid), msg);
	}
	return 0;
}

//==================== IZCMD =============
public OnPlayerCommandReceived(playerid,cmdtext[])
{
	if(pInfo[playerid][LoggedIn] == false)
	{
		SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You must be logged in to use commands.");
		return 0;
	}
	return 1;
}

public OnPlayerCommandPerformed(playerid,cmdtext[], success)
{
    if (!success)
    {
       SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You've entered an invalid command, try using /help.");
    }
    return 1;
}
//========================================

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER) SetPlayerArmedWeapon(playerid, 0); // Disarming drivers so they may not drive by.
    if(newstate == PLAYER_STATE_PASSENGER && GetPlayerWeapon(playerid) == 24) // No deagle drive by for passengers.
	{
    	SetPlayerArmedWeapon(playerid, 0);
	}
	if(newstate == PLAYER_STATE_ONFOOT) // Stand up upon exiting a vehicle.
	{
        SetPlayerArmedWeapon(playerid, 24);
        ApplyAnimation(playerid, "CARRY", "crry_prtial ", 4.1, 1, 1, 1, 1, 1, 1);
        ClearAnimations(playerid);
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if(pInfo[playerid][LoggedIn] == false) return 0; // If the player is not logged in, they will not be able to spawn.
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

forward OnPlayerRegistrationFinished(playerid);

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch (dialogid)
	{
		case DIALOG_LOGIN:
		{
			if(!response) return Kick(playerid);

			new Salted_Key[65];
			SHA256_PassHash(inputtext, pInfo[playerid][Salt], Salted_Key, 65);

			if(strcmp(Salted_Key, pInfo[playerid][Password]) == 0)
			{
				
				cache_set_active(pInfo[playerid][Player_Cache]);

            	cache_get_value_int(0, "ID", pInfo[playerid][ID]);
            	
        		cache_get_value_int(0, "KILLS", pInfo[playerid][Kills]);
        		cache_get_value_int(0, "DEATHS", pInfo[playerid][Deaths]);

        		cache_get_value_int(0, "SCORE", pInfo[playerid][Score]);
        		cache_get_value_int(0, "CASH", pInfo[playerid][Cash]);

        		cache_get_value_int(0, "ADMIN", pInfo[playerid][Admin]);
        		
        		SetPlayerScore(playerid, pInfo[playerid][Score]);
        		
        		ResetPlayerMoney(playerid);
        		GivePlayerMoney(playerid, pInfo[playerid][Cash]);

				
				cache_delete(pInfo[playerid][Player_Cache]);
				pInfo[playerid][Player_Cache] = MYSQL_INVALID_CACHE;

				pInfo[playerid][LoggedIn] = true;
				SendClientMessage(playerid, 0x00FF00FF, "You have successfully logged into your account.");
			}
			else
			{
			    new String[150];
					
				pInfo[playerid][PasswordFails] += 1;
				printf("%s has been failed to login. (%d)", pInfo[playerid][Name], pInfo[playerid][PasswordFails]);

				if (pInfo[playerid][PasswordFails] >= 3)
				{
					format(String, sizeof(String), "[WATCHDOG] %s has been kicked Reason: {FF0000}(%d/3) Login fails.", pInfo[playerid][Name], pInfo[playerid][PasswordFails]);
					SendClientMessageToAll(0x969696FF, String);
					Kick(playerid);
				}
				else
				{
					// If the player didn't exceed the limits we send him a message that the password is wrong.
					format(String, sizeof(String), "Wrong password, you have used %d out of 3 available attempts.", pInfo[playerid][PasswordFails]);
					SendClientMessage(playerid, 0xFF0000FF, String);
					
              		format(String, sizeof(String), "{FFFFFF}Welcome back, %s.\n\n{0099FF}This account is already registered.\n\
            		{0099FF}Please input your password below.\n\n", pInfo[playerid][Name]);
            		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login System", String, "Login", "Leave");
				}
			}
		}
		case DIALOG_REGISTER:
		{
			if(!response) return Kick(playerid);

			if(strlen(inputtext) <= 5 || strlen(inputtext) > 60)
			{
			    
		    	SendClientMessage(playerid, 0x969696FF, "Invalid password length, should be 5 - 60.");

				new String[150];
		    	
    	    	format(String, sizeof(String), "{FFFFFF}Welcome %s.\n\n{0099FF}This account is not registered.\n\
    	     	{0099FF}Please input a secure password below.\n\n", pInfo[playerid][Name]);
	        	ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registration System", String, "Register", "Leave");
			}
			else
			{

    			// Salting the player's password using SHA256.
			
                for (new i = 0; i < 10; i++)
                {
                    pInfo[playerid][Salt][i] = random(79) + 47;
	    		}
	    		
	    		pInfo[playerid][Salt][10] = 0;
		    	SHA256_PassHash(inputtext, pInfo[playerid][Salt], pInfo[playerid][Password], 65);

		    	new DB_Query[1000];
			
		    	new plrIP[45];
				GetPlayerIp(playerid, plrIP, sizeof(plrIP));
				pInfo[playerid][IP] = plrIP;

				new registered_players, Cache:result = mysql_query(Database, "SELECT COUNT(*) FROM `PLAYERS`");
				cache_get_value_int(0, 0, registered_players);
				cache_delete(result);

		    	// Storing player's information if everything goes right.
		    	mysql_format(Database, DB_Query, sizeof(DB_Query), "INSERT INTO `PLAYERS` (`IP`,`USERNAME`, `PASSWORD`, `SALT`, `SCORE`, `KILLS`, `CASH`, `DEATHS`, `ADMIN`)\
		    	VALUES ('%s', '%e', '%s', '%e', '0', '0', '0', '0', '0')", plrIP, pInfo[playerid][Name], pInfo[playerid][Password], pInfo[playerid][Salt]);
		     	mysql_tquery(Database, DB_Query, "OnPlayerRegister", "d", playerid);

		     	// Empty class 1
		     	mysql_format(Database, DB_Query, sizeof(DB_Query), "INSERT INTO `CLASSES` (`ID`,`USERNAME`, `CLASSID`, `MELEE`, `THROWN`, `HANDGUN`, `SHOTGUN`, `SUBMACHINE`, `ASSAULT`, `LONGRIFLE`)\
		    	VALUES ('%i', '%e', '0', '-1', '-1', '-1', '-1', '-1', '-1', '-1')", registered_players + 1, pInfo[playerid][Name]);
		    	mysql_tquery(Database, DB_Query);

		    	// Empty class 2
		    	mysql_format(Database, DB_Query, sizeof(DB_Query), "INSERT INTO `CLASSES` (`ID`,`USERNAME`, `CLASSID`, `MELEE`, `THROWN`, `HANDGUN`, `SHOTGUN`, `SUBMACHINE`, `ASSAULT`, `LONGRIFLE`)\
		    	VALUES ('%i', '%e', '1', '-1', '-1', '-1', '-1', '-1', '-1', '-1')", registered_players + 1, pInfo[playerid][Name]);
		    	mysql_tquery(Database, DB_Query);

		    	// Empty class 3
		    	mysql_format(Database, DB_Query, sizeof(DB_Query), "INSERT INTO `CLASSES` (`ID`,`USERNAME`, `CLASSID`, `MELEE`, `THROWN`, `HANDGUN`, `SHOTGUN`, `SUBMACHINE`, `ASSAULT`, `LONGRIFLE`)\
		    	VALUES ('%i', '%e', '2', '-1', '-1', '-1', '-1', '-1', '-1', '-1')", registered_players + 1, pInfo[playerid][Name]);
		    	mysql_tquery(Database, DB_Query);

		    	// Empty class 4
		    	mysql_format(Database, DB_Query, sizeof(DB_Query), "INSERT INTO `CLASSES` (`ID`,`USERNAME`, `CLASSID`, `MELEE`, `THROWN`, `HANDGUN`, `SHOTGUN`, `SUBMACHINE`, `ASSAULT`, `LONGRIFLE`)\
		    	VALUES ('%i', '%e', '3', '-1', '-1', '-1', '-1', '-1', '-1', '-1')", registered_players + 1, pInfo[playerid][Name]);
		    	mysql_tquery(Database, DB_Query);

		    	// Empty class 5
		    	mysql_format(Database, DB_Query, sizeof(DB_Query), "INSERT INTO `CLASSES` (`ID`,`USERNAME`, `CLASSID`, `MELEE`, `THROWN`, `HANDGUN`, `SHOTGUN`, `SUBMACHINE`, `ASSAULT`, `LONGRIFLE`)\
		    	VALUES ('%i', '%e', '4', '-1', '-1', '-1', '-1', '-1', '-1', '-1')", registered_players + 1, pInfo[playerid][Name]);
		    	mysql_tquery(Database, DB_Query);
		     	
		     }
		}
		case DIALOG_RADIO:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: ShowPlayerDialog(playerid, DIALOG_RADIO_RAP, DIALOG_STYLE_LIST, "Rap stations", "Capital Tune FM\n1001 The Heat\nFMHiphop.com", "Select", "Cancel"); // Genre rap
					case 1: ShowPlayerDialog(playerid, DIALOG_RADIO_ROCK, DIALOG_STYLE_LIST, "Rock stations", "Classic Rock Florida HD\nAsterisk Radio", "Select", "Cancel"); // Genre rock
				}
			}
		}
		case DIALOG_RADIO_RAP:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: PlayAudioStreamForPlayer(playerid, "http://equinox.shoutca.st:8650"); // Capital Tune FM
					case 1: PlayAudioStreamForPlayer(playerid, "http://149.56.157.81:8569/listen.pls?sid=1&t=.pls"); // 1001 The Heat
					case 2: PlayAudioStreamForPlayer(playerid, "http://149.56.175.167:5708/listen.pls?sid=1&t=.pls"); // FMHiphop.com
				}
			}
		}
		case DIALOG_RADIO_ROCK:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: PlayAudioStreamForPlayer(playerid, "http://us4.internet-radio.com:8258/listen.pls&t=.pls"); // Classic Rock Florida HD
					case 1: PlayAudioStreamForPlayer(playerid, "http://162.252.85.85:9826/listen.pls?sid=1&t=.pls"); // Asterisk Radio
				}
			}
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
    new Float:ratio = floatdiv(pInfo[clickedplayerid][Kills], pInfo[clickedplayerid][Deaths]);

    new dstring[256], name[MAX_PLAYER_NAME];
    GetPlayerName(clickedplayerid, name, sizeof(name));
    format(dstring, sizeof(dstring), "Name: %s | Unique ID: %d | Score: %d | Kills: %i | Deaths: %i | KDR: %.2f | Money: %d | Adminlevel: %d",
        name,
        pInfo[clickedplayerid][ID],
        pInfo[clickedplayerid][Score],
        pInfo[clickedplayerid][Kills],
        pInfo[clickedplayerid][Deaths],
        ratio,
        GetPlayerMoney(clickedplayerid),
        pInfo[clickedplayerid][Admin]
    );

    ShowPlayerDialog(playerid, DIALOG_STATS, DIALOG_STYLE_MSGBOX, "Stats", dstring, "Close", "");
    return 1;
}

forward SendMSG();
public SendMSG()
{
    new randMSG = random(sizeof(RandomMSG));
    SendClientMessageToAll(COLOR_TURF, RandomMSG[randMSG]);
}

forward public OnPlayerDataCheck(playerid, corrupt_check);
public OnPlayerDataCheck(playerid, corrupt_check)
{
	if (corrupt_check != Corrupt_Check[playerid]) return Kick(playerid);

	new String[150];

	if(cache_num_rows() > 0)
	{
		
		cache_get_value(0, "PASSWORD", pInfo[playerid][Password], 65);
		cache_get_value(0, "SALT", pInfo[playerid][Salt], 11);

		pInfo[playerid][Player_Cache] = cache_save();

		format(String, sizeof(String), "{FFFFFF}Welcome back, %s.\n\n{0099FF}This account is already registered.\n\
		{0099FF}Please, input your password below.\n\n", pInfo[playerid][Name]);
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login System", String, "Login", "Leave");
	}
	else
	{
		format(String, sizeof(String), "{FFFFFF}Welcome %s.\n\n{0099FF}This account is not registered.\n\
		{0099FF}Please, insert a secure password below.\n\n", pInfo[playerid][Name]);
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registration System", String, "Register", "Leave");
	}
	return 1;
}

forward public OnPlayerRegister(playerid);
public OnPlayerRegister(playerid)
{
	SendClientMessage(playerid, 0x00FF00FF, "You are now registered and have been logged in.");
    pInfo[playerid][LoggedIn] = true;

    new registered_players, Cache:result = mysql_query(Database, "SELECT COUNT(*) FROM `PLAYERS`");
	cache_get_value_int(0, 0, registered_players);
	cache_delete(result);

	new string[128], name[MAX_PLAYER_NAME + 1];
	GetPlayerName(playerid, name, sizeof(name));
 	format(string, sizeof(string), "%s has registered, they are player number %i to join Old School Deathmatch.", name, registered_players);
	SendClientMessageToAll(COLOR_PLAYER_NUMBER, string);
    return 1;
}

forward KickTime(playerid);
public KickTime(playerid)
{
    Kick(playerid);
}

forward BanTime(playerid);
public BanTime(playerid)
{
    Kick(playerid);
}

// BustAim

public OnPlayerSuspectedForAimbot(playerid, hitid, weaponid, warnings)
{
	new str[144],nme[MAX_PLAYER_NAME],wname[32],Float:Wstats[BUSTAIM_WSTATS_SHOTS];
	
	ids[playerid]++;
	GetPlayerName(playerid,nme,sizeof(nme));
	GetWeaponName(weaponid,wname,sizeof(wname));

	if(warnings & WARNING_OUT_OF_RANGE_SHOT)
	{
	    format(str,256,"[WATCHDOG] [%d]%s(%d) fired shots from a distance greater than the %s's fire range(Normal Range:%f)",ids[playerid],nme,playerid,wname,BustAim::GetNormalWeaponRange(weaponid));
		SendToAdmins(COLOR_WATCHDOG, str);
		BustAim::GetRangeStats(playerid,Wstats);
		format(str,256,"[WATCHDOG] Shooter to Victim Distance(SA Units): 1)%f 2)%f 3)%f",Wstats[0],Wstats[1],Wstats[2]);
		SendToAdmins(COLOR_WATCHDOG, str);
	}
	if(warnings & WARNING_PROAIM_TELEPORT)
	{
	    format(str,256,"[WATCHDOG] [%d]%s(%d) may be using proaim (Teleport Detected)",ids[playerid],nme,playerid);
		SendToAdmins(COLOR_WATCHDOG, str);
		BustAim::GetTeleportStats(playerid,Wstats);
		format(str,256,"[WATCHDOG] Bullet to Victim Distance(SA Units): 1)%f 2)%f 3)%f",Wstats[0],Wstats[1],Wstats[2]);
		SendToAdmins(COLOR_WATCHDOG, str);
	}
	if(warnings & WARNING_RANDOM_AIM)
	{
	    format(str,256,"[WATCHDOG] [%d]%s(%d) is suspected to be using aimbot(Hit with Random Aim with %s)",ids[playerid],nme,playerid,wname);
		SendToAdmins(COLOR_WATCHDOG, str);
		BustAim::GetRandomAimStats(playerid,Wstats);
		format(str,256,"[WATCHDOG] Random Aim Offsets: 1)%f 2)%f 3)%f",Wstats[0],Wstats[1],Wstats[2]);
		SendToAdmins(COLOR_WATCHDOG, str);
	}
	if(warnings & WARNING_CONTINOUS_SHOTS)
	{
	    format(str,256,"[WATCHDOG] [%d]%s(%d) has fired 10 shots continously with %s(%d)",ids[playerid],nme,playerid,wname,weaponid);
		SendToAdmins(COLOR_WATCHDOG, str);
	}
	return 0;
}

//