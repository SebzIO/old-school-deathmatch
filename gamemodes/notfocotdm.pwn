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

#include "./includes/admin/anticheat.pwn"
#include "./includes/admin/commands.pwn"

#include "./includes/player/commands.pwn"

#include "./includes/connections.pwn"
#include "./includes/defines.pwn"
#include "./includes/discord.pwn"
#include "./includes/enums.pwn"
#include "./includes/functions.pwn"
#include "./includes/variables.pwn"

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

	// MYSQL INIT
	new MySQLOpt: option_id = mysql_init_options();
	mysql_set_option(option_id, AUTO_RECONNECT, true);

	Database = mysql_connect(SQL_HOSTNAME, SQL_USERNAME, SQL_PASSWORD, SQL_DATABASE, option_id);
	printf("ATTEMPTING MYSQL CONNNECTION...");
	printf(" "); // Blank line for spacing

	if(mysql_errno() != 0){ // Connection failed.
		printf ("DATABASE CONNECTION FAILED TO SERVER @ SQL_HOSTNAME");
		SendRconCommand("exit");
	} else { // Connection successfully made.
		printf ("DATABASE CONNECTION SUCCESSFUL TO SERVER @ SQL_HOSTNAME");
	}

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
	// =====================

	// Streamer GangZones
	gangZoneIdleGas = CreateDynamicRectangle(1955.0344, -1758.1150, 1904.2009, -1797.0093); // Idlewood Gas Station
	// =====================
	return 1;
}

public OnGameModeExit()
{
	foreach(new i: Player)
    {
		if(IsPlayerConnected(i))
		{
			OnPlayerDisconnect(i, 1); // Save player data if/when gamemode exits.
		}
	}

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
	        GameTextForPlayer(playerid,"~w~Strippers",3000,5);
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
        KickDelay(playerid, "You are banned from Old School Deathmatch. Appeal on the forums @ forums.osdm.xyz");
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

	Corrupt_Check[playerid]++;

	new DB_Query[500];

	mysql_format(Database, DB_Query, sizeof(DB_Query), "UPDATE `PLAYERS` SET `SCORE` = %d, `CASH` = %d, `KILLS` = %d, `DEATHS` = %d, `ADMIN` = %d, `IP` = %d WHERE `ID` = %d LIMIT 1",
	pInfo[playerid][Score], pInfo[playerid][Cash], pInfo[playerid][Kills], pInfo[playerid][Deaths], pInfo[playerid][ID], pInfo[playerid][Admin], pInfo[playerid][IP]);

	mysql_tquery(Database, DB_Query);

	if(cache_is_valid(pInfo[playerid][Player_Cache]))
	{
		cache_delete(pInfo[playerid][Player_Cache]);
		pInfo[playerid][Player_Cache] = MYSQL_INVALID_CACHE;
	}

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
	}	else {
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

		    	// Storing player's information if everything goes right.
		    	mysql_format(Database, DB_Query, sizeof(DB_Query), "INSERT INTO `PLAYERS` (`IP`,`USERNAME`, `PASSWORD`, `SALT`, `SCORE`, `KILLS`, `CASH`, `DEATHS`, `ADMIN`)\
		    	VALUES ('%s', '%e', '%s', '%e', '0', '0', '0', '0', '0')", plrIP, pInfo[playerid][Name], pInfo[playerid][Password], pInfo[playerid][Salt]);
		     	mysql_tquery(Database, DB_Query, "OnPlayerRegister", "d", playerid);
		     	
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

//================= MAPPING AND VEHICLES ================= // CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay, addsiren=0)
stock SpawnMapping()
{
	//============================= Crenshaw Mapping/Vehicles ================================
	CreateVehicle(400, 2133.1780, -1469.7430, 23.8316, 0.0000, 179, 179, 120); // Crenshaw gang
	CreateVehicle(458, 2133.1843, -1460.5956, 23.9970, 0.0000, 179, 179, 120); // Crenshaw gang
	CreateVehicle(479, 2133.1682, -1478.3824, 23.2891, 0.0000, 179, 179, 120); // Crenshaw gang
	CreateVehicle(579, 2128.9045, -1446.4017, 24.0365, 180.0000, 179, 179, 120); // Crenshaw gang
	CreateVehicle(566, 2129.0002, -1437.9952, 24.4330, 180.0000, 179, 179, 120); // Crenshaw gang
	//=========================================================================================

	//============================= LSPD HQ Mapping/Vehicles ================================
	CreateVehicle(490, 1526.5490, -1644.8408, 6.0212, 180.0000, 0, 0, 120);
	CreateVehicle(490, 1530.4589, -1644.8408, 6.0212, 180.0000, 0, 0, 120);
	CreateVehicle(490, 1534.5389, -1644.8408, 6.0212, 180.0000, 0, 0, 120);
	CreateVehicle(490, 1538.4489, -1644.8408, 6.0212, 180.0000, 0, 0, 120);
	CreateVehicle(426, 1528.1772, -1684.1036, 5.5611, 270.0000, 0, 1, 120, 1);
	CreateVehicle(426, 1528.1772, -1687.9976, 5.5611, 270.0000, 0, 1, 120, 1);
	CreateVehicle(596, 1544.8545, -1651.0107, 5.6481, 90.0000, 0, 1, 120);
	CreateVehicle(596, 1544.8545, -1654.7867, 5.6481, 90.0000, 0, 1, 120);
	CreateVehicle(596, 1544.8545, -1658.9757, 5.6481, 90.0000, 0, 1, 120);
	CreateVehicle(596, 1544.8545, -1662.9667, 5.6481, 90.0000, 0, 1, 120);
	CreateVehicle(596, 1544.9456, -1667.7897, 5.6481, 90.0000, 0, 1, 120);
	CreateVehicle(596, 1544.9456, -1671.9757, 5.6481, 90.0000, 0, 1, 120);
	CreateVehicle(596, 1544.9456, -1675.9797, 5.6481, 90.0000, 0, 1, 120);
	CreateVehicle(596, 1544.9456, -1680.2567, 5.6481, 90.0000, 0, 1, 120);
	CreateVehicle(596, 1544.9456, -1684.2607, 5.6481, 90.0000, 0, 1, 120);
	CreateVehicle(541, 1585.3888, -1671.7435, 5.5197, 270.0000, 0, 1, 120, 1);
	CreateVehicle(415, 1585.2844, -1667.6128, 5.7012, 270.0000, 0, 1, 120, 1);
	CreateVehicle(599, 1601.6288, -1683.9128, 6.0635, 90.0000, 0, 1, 120);
	CreateVehicle(599, 1601.6288, -1687.7347, 6.0635, 90.0000, 0, 1, 120);
	CreateVehicle(497, 1568.2406, -1695.4041, 28.5722, 87.1526, 0, 1, 120);
	CreateVehicle(596, 1558.8632, -1710.1434, 5.6481, 0.0000, 0, 1, 120);
	CreateVehicle(596, 1570.2662, -1710.1434, 5.6481, 0.0000, 0, 1, 120);
	CreateVehicle(596, 1574.4292, -1710.1434, 5.6481, 0.0000, 0, 1, 120);
	CreateVehicle(596, 1578.5922, -1710.1434, 5.6481, 0.0000, 0, 1, 120);
	CreateVehicle(596, 1583.2982, -1710.1434, 5.6481, 0.0000, 0, 1, 120);
	CreateVehicle(596, 1587.4612, -1710.1434, 5.6481, 0.0000, 0, 1, 120);
	CreateVehicle(596, 1591.4232, -1710.1427, 5.6481, 0.0000, 0, 1, 120);
	CreateVehicle(596, 1595.4052, -1710.1427, 5.6481, 0.0000, 0, 1, 120);
	CreateVehicle(599, 1601.6288, -1691.8977, 6.0635, 90.0000, 0, 1, 120);
	CreateVehicle(599, 1601.6288, -1696.0607, 6.0635, 90.0000, 0, 1, 120);
	CreateVehicle(599, 1601.6288, -1700.2238, 6.0635, 90.0000, 0, 1, 120);
	CreateVehicle(599, 1601.6288, -1704.3868, 6.0635, 90.0000, 0, 1, 120);
	CreateVehicle(487, 1555.0923, -1609.1469, 13.5979, 180.0000, 0, 1, 120);
	//=========================================================================================

	//============================= Mafia Mapping/Vehicles ================================
	CreateVehicle(580, 1631.5427, -1907.9242, 13.4493, 0.0000, 51, 51, 120);
	CreateVehicle(580, 1635.1395, -1906.4312, 13.4493, 0.0000, 51, 51, 120);
	CreateVehicle(580, 1638.6147, -1905.6790, 13.4493, 0.0000, 51, 51, 120);
	CreateVehicle(580, 1645.6010, -1903.5651, 13.4493, 0.0000, 51, 51, 120);
	CreateVehicle(580, 1642.1191, -1904.6340, 13.4493, 0.0000, 51, 51, 120);
	CreateVehicle(521, 1648.8828, -1903.7393, 13.2675, 0.0000, 51, 51, 120);
	CreateVehicle(521, 1650.5419, -1903.7823, 13.2675, 0.0000, 51, 51, 120);
	CreateVehicle(579, 1669.3582, -1884.6866, 13.6242, 90.0000, 51, 51, 120);
	CreateVehicle(579, 1669.3582, -1888.6686, 13.6242, 90.0000, 51, 51, 120);
	CreateVehicle(609, 1669.0735, -1895.0786, 13.6302, 90.0000, 51, 51, 120);
	CreateVehicle(487, 1678.8270, -1889.6235, 22.1046, 0.0000, 51, 51, 120);
	//=========================================================================================

	//============================= LSFD Mapping/Vehicles ================================
    CreateVehicle(416, 1180.6284, -1339.0195, 14.0455, 270.0000, 1, 161, 120);
	CreateVehicle(416, 1180.6284, -1309.0284, 14.0455, 270.0000, 1, 161, 120);
	CreateVehicle(407, 1179.1649, -1286.0665, 13.5637, 270.0000, 1, 161, 120);
	CreateVehicle(560, 1211.8083, -1316.1541, 13.0676, 0.0000, 1, 161, 120, 1);
	CreateVehicle(560, 1211.7893, -1307.9764, 13.0676, 0.0000, 1, 161, 120, 1);
	CreateVehicle(560, 1211.8102, -1324.3580, 13.0676, 0.0000, 1, 161, 120, 1);
	CreateVehicle(487, 1180.3014, -1361.0465, 14.3449, 270.0000, 161, 151, 120);
	//=========================================================================================

	//============================= Piru Mapping/Vehicles ================================
    CreateVehicle(560, 2509.2024, -1670.7142, 12.9876, 0.0000, 43, 43, 120);
	CreateVehicle(560, 2505.7954, -1695.2542, 13.0596, 0.0000, 43, 43, 120);
	CreateVehicle(600, 2473.6863, -1692.5765, 13.2238, 0.0000, 43, 43, 120);
	CreateVehicle(566, 2450.1355, -1664.6355, 13.0938, 90.0000, 43, 43, 120);
	CreateVehicle(566, 2484.3250, -1653.3691, 13.0938, 90.0000, 43, 43, 120);
	CreateVehicle(521, 2513.2896, -1679.7494, 13.0581, 47.0000, 43, 43, 120);
	CreateVehicle(492, 2501.9158, -1656.2000, 13.1235, 76.0000, 43, 43, 120);
	CreateVehicle(487, 2530.7190, -1677.6693, 20.2108, 0.0000, 43, 43, 120);
	//=========================================================================================

	//============================= Strippers Mapping/Vehicles ================================
    CreateVehicle(541, 2436.2551, -1244.2429, 23.6942, 0.0000, 232, 232, 120);
	CreateVehicle(541, 2433.1589, -1244.2429, 23.6942, 0.0000, 232, 232, 120);
	CreateVehicle(541, 2429.9912, -1244.2429, 23.6942, 0.0000, 232, 232, 120);
	CreateVehicle(521, 2426.6526, -1244.2463, 23.5819, 0.0000, 232, 232, 120);
	CreateVehicle(521, 2424.8525, -1244.2463, 23.5819, 0.0000, 232, 232, 120);
	CreateVehicle(521, 2423.3406, -1244.2463, 23.5819, 0.0000, 232, 232, 120);
	CreateVehicle(471, 2406.2358, -1243.0020, 23.3389, 270.0000, 232, 232, 120);
	CreateVehicle(471, 2406.2358, -1241.1300, 23.3389, 270.0000, 232, 232, 120);
	CreateVehicle(560, 2407.3723, -1237.5541, 23.6459, 270.0000, 232, 232, 120);
	CreateVehicle(560, 2407.3723, -1234.3141, 23.6459, 270.0000, 232, 232, 120);
	CreateVehicle(487, 2429.3867, -1232.3993, 25.2995, 90.0000, 232, 232, 120);
	//=========================================================================================

	//============================= Hispanics Mapping/Vehicles ================================
	CreateVehicle(474, 1877.1576, -2021.1320, 13.1105, 180.0000, 135, 135, 120);
	CreateVehicle(474, 1877.1576, -2031.3409, 13.1105, 180.0000, 135, 135, 120);
	CreateVehicle(567, 1877.0907, -2040.6190, 13.2813, 180.0000, 135, 135, 120);
	CreateVehicle(487, 1867.8578, -2000.7408, 18.9879, 270.0000, 135, 135, 120);
	CreateVehicle(521, 1892.3164, -2015.4200, 13.0281, 180.0000, 135, 135, 120);
	CreateVehicle(521, 1892.3164, -2019.4360, 13.0281, 180.0000, 135, 135, 120);
	CreateVehicle(521, 1892.3164, -2023.7030, 13.0281, 180.0000, 135, 135, 120);
	CreateVehicle(521, 1892.3164, -2028.4720, 13.0281, 180.0000, 135, 135, 120);
	CreateVehicle(527, 1888.5768, -2020.2721, 13.1528, 180.0000, 135, 135, 120);
	CreateVehicle(527, 1888.5768, -2030.5631, 13.1528, 180.0000, 135, 135, 120);
	CreateVehicle(535, 1888.7665, -2039.6906, 13.0422, 180.0000, 135, 135, 120);

	CreateObject(5130, 1858.70947, -2020.03076, 14.84350,   0.00000, 0.00000, -225.00000);
	CreateObject(2675, 1868.40820, -2012.94995, 17.94100,   0.00000, 0.00000, 0.00000);
	CreateObject(2675, 1869.18188, -2019.48547, 17.94100,   0.00000, 0.00000, 0.00000);
	CreateObject(1448, 1866.95178, -2009.46960, 17.88041,   0.00000, 0.00000, 0.00000);
	CreateObject(1448, 1866.95178, -2008.48560, 17.88040,   0.00000, 0.00000, 0.00000);
	CreateObject(1448, 1866.95178, -2007.50159, 17.88040,   0.00000, 0.00000, 0.00000);
	CreateObject(1448, 1866.95178, -2006.51758, 17.88040,   0.00000, 0.00000, 0.00000);
	CreateObject(1448, 1866.95178, -2005.53357, 17.88040,   0.00000, 0.00000, 0.00000);
	CreateObject(1448, 1866.95178, -2004.54956, 17.88040,   0.00000, 0.00000, 0.00000);
	//=========================================================================================

	//============================= Pizza Boys Mapping/Vehicles ================================
	CreateVehicle(423, 2122.6035, -1783.0453, 13.3955, 0.0000, 6, 6, 100);
	CreateVehicle(445, 2122.7026, -1775.5262, 13.1546, 0.0000, 6, 6, 100);
	CreateVehicle(448, 2121.5710, -1787.4194, 13.0470, 34.0000, 6, 6, 100);
	CreateVehicle(448, 2121.5710, -1788.9594, 13.0470, 34.0000, 6, 6, 100);
	CreateVehicle(609, 2104.7795, -1782.8207, 13.3800, 0.0000, 6, 6, 100);
	CreateVehicle(579, 2104.8015, -1773.7148, 13.2806, -32.1200, 6, 6, 100);
	//=========================================================================================

}