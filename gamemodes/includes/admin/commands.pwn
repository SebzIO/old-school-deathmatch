/*
                      /$$$$$$   /$$$$$$  /$$$$$$$  /$$      /$$
                     /$$__  $$ /$$__  $$| $$__  $$| $$$    /$$$
                    | $$  \ $$| $$  \__/| $$  \ $$| $$$$  /$$$$
                    | $$  | $$|  $$$$$$ | $$  | $$| $$ $$/$$ $$
                    | $$  | $$ \____  $$| $$  | $$| $$  $$$| $$
                    | $$  | $$ /$$  \ $$| $$  | $$| $$\  $ | $$
                    |  $$$$$$/|  $$$$$$/| $$$$$$$/| $$ \/  | $$
                     \______/  \______/ |_______/ |__/     |__/ 

//-------------------------[ADMIN/COMMANDS.PWN]--------------------------------


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

#include <YSI\y_hooks>

#include "./includes/defines.pwn"
#include "./includes/enums.pwn"
#include "./includes/variables.pwn"
#include "./includes/connections.pwn"

new Float:aDutyX, Float:aDutyY, Float:aDutyZ;
new Text3D:adminText;
hook OnPlayerConnect(playerid)
{
	GetPlayerPos(playerid, aDutyX, aDutyY, aDutyZ);
	adminText = Create3DTextLabel("On-Duty Admin", COLOR_WATCHDOG, aDutyX, aDutyY, aDutyZ, 40.0, 0); // Aduty 3dText
}

hook OnPlayerDisconnect(playerid, reason)
{

	DeletePlayer3DTextLabel(playerid, PlayerText3D:adminText);
	aDuty[playerid] = 0;
	DestroyDynamic3DTextLabel(Text3D:adminText);
	return 1;
}

// IZCMD ADMIN COMMANDS

CMD:ahelp(playerid)
{
	if(pInfo[playerid][Admin] >= 1)
	{
		SendClientMessage(playerid, COLOR_WHITE, "==============Old School Deathmatch admin commands==============");
		SendClientMessage(playerid, COLOR_WHITE, "PLAYER: /kick, /(un)ban, /oban, /send, /go, /get, /slap, /spec(off), /forceclass, /ip");
		SendClientMessage(playerid, COLOR_WHITE, "TEAM: ");
		SendClientMessage(playerid, COLOR_WHITE, "EVENT:");
		SendClientMessage(playerid, COLOR_WHITE, "GIVE/SET: /makeadmin, /changename");
		SendClientMessage(playerid, COLOR_WHITE, "OTHER: /announce, /crespawn, /aduty, /reports, /ar, /tr");
	}
	else
	{
		return UnAuthMessage(playerid);
	}
	return CMD_SUCCESS;
}

CMD:kick(playerid, params[])
{
	if(pInfo[playerid][Admin] >= 1)
	{
        new PID, reason[64], str[128], playerName[MAX_PLAYER_NAME], adminName[MAX_PLAYER_NAME];
        if(sscanf(params, "us[64]", PID, reason)) return SendClientMessage(playerid, -1, "USAGE: /kick [playerid] [reason]");
        GetPlayerName(playerid, adminName, sizeof(adminName));
  		GetPlayerName(PID, playerName, sizeof(playerName));

        if(!IsPlayerConnected(PID)) return SendClientMessage(playerid, -1, "The player you have specified is not connected.");

        format(str, sizeof(str), "AdmCmd(1): '%s' has been kicked by administrator '%s'. Reason: %e ", playerName, adminName, reason);
		KickDelay(PID, str);

	}
    else
	{
		return UnAuthMessage(playerid);
	}
    return 1;
}

CMD:changename(playerid, params[])
{
	if(pInfo[playerid][Admin] >= 6)
	{
		new toid, oldName[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME];
		if(sscanf(params, "us[24]", toid, name))
		{
			return SendClientMessage(playerid, COLOR_COMMAND_ERROR, "Usage: /changename <playerid> <newname>");
		}
		GetPlayerName(toid, oldName, sizeof(oldName));
		new DB_Query[100];
		
		// Storing player's information if everything goes right.
		mysql_format(Database, DB_Query, sizeof(DB_Query), "UPDATE `PLAYERS` SET `USERNAME` = '%e' WHERE `ID` = '%d' LIMIT 1", name, pInfo[toid][ID]);
	 	mysql_tquery(Database, DB_Query);
	 	new string[128];
	 	format(string, sizeof(string), "Your name was changed to '%s' by admin %s.", name, GetName(playerid));
	 	SendClientMessage(toid, COLOR_WATCHDOG, string);

	 	// Warning admins of this change.
	 	format(string, sizeof(string), "[WATCHDOG] %s has changed %s's name to %s. {FFFFFF}[DBID: %i]", GetName(playerid), oldName, name, pInfo[toid][ID]);
	 	SendToAdmins(COLOR_WATCHDOG, string);
	 	SetPlayerName(toid, name);
 	}
 	else return UnAuthMessage(playerid);
 	return CMD_SUCCESS;
}

CMD:ip(playerid, params[])
{
	new playerName[MAX_PLAYER_NAME], PID, playerIP[50], string[128];
	if(sscanf(params, "u", PID)) return SendClientMessage(playerid, -1, "USAGE: /ip [playerid]");
	GetPlayerName(PID, playerName, sizeof(playerName));
	GetPlayerIp(PID, playerIP, sizeof(playerIP));
	if(!IsPlayerConnected(PID)) return SendClientMessage(playerid, -1, "The player you have specified is not connected.");

	format(string, sizeof(string), "[WATCHDOG] %s's IP address is %s.", playerName, playerIP);
	SendClientMessage(playerid, COLOR_WATCHDOG, string);
	return 1;
}

// Ban System
CMD:ban(playerid, params[])
{
	if(pInfo[playerid][Admin] >= 3)
	{
        new PID, reason[64], str[128], playerName[MAX_PLAYER_NAME], adminName[MAX_PLAYER_NAME];
        if(sscanf(params, "us[64]", PID, reason)) return SendClientMessage(playerid, -1, "USAGE: /ban [playerid] [reason]");

        GetPlayerName(playerid, adminName, sizeof(adminName));
  		GetPlayerName(PID, playerName, sizeof(playerName));

        if(!IsPlayerConnected(PID)) return SendClientMessage(playerid, -1, "The player you have specified is not connected.");

        format(str, sizeof(str), "AdmCmd(1): '%s' has been banned by administrator '%s'. Reason: %s ", playerName, adminName, reason);
		SendClientMessageToAll(COLOR_MAJOR_WARNING, str);
    	SetTimerEx("BanTime", 400, 0, "d", PID);

		new DB_Query[1000];
		// Saving ban to BANS table.
		mysql_format(Database, DB_Query, sizeof(DB_Query), "INSERT INTO `BANS` (`USERNAME`, `ADMIN`, `IP`, `ACTIVE`, `REASON`, `DATE`)\
		VALUES ('%e', '%e', '%s', TRUE, '%s', '%e')", pInfo[PID][Name], adminName, pInfo[PID][IP], reason, ReturnDate());
	 	mysql_tquery(Database, DB_Query);
	}
    else
	{
		return UnAuthMessage(playerid);
	}
    return 1;
}

CMD:unban(playerid, params[])
{
	if(pInfo[playerid][Admin] >= 3)
	{
		new name[MAX_PLAYER_NAME], adminName[MAX_PLAYER_NAME], query[150], string[150], rows;
	    if(sscanf(params, "s[128]", name)) return SendClientMessage(playerid, -1, "USAGE: /unban [name]");
	    mysql_format(Database, query, sizeof(query), "SELECT * FROM `BANS` WHERE `USERNAME` = '%e' LIMIT 0, 1", name);
	    new Cache:result = mysql_query(Database, query);
	    cache_get_row_count(rows);
	   
	    if(!rows)
	    {
	        SendClientMessage(playerid, COLOR_COMMAND_ERROR, "That name does not exist or there is no ban under that name.");
	    }
	   
	    for (new i = 0; i < rows; i ++)
	    {
	        mysql_format(Database, query, sizeof(query), "DELETE FROM `BANS` WHERE `USERNAME` = '%e'", name);
	        mysql_tquery(Database, query);
		}
		GetPlayerName(playerid, adminName, sizeof(adminName));
		format(string, sizeof(string), "[WATCHDOG] %s has unbanned %s", adminName, name);
		SendToAdmins(COLOR_WATCHDOG, string);
		cache_delete(result);
	}
	else
	{
		return UnAuthMessage(playerid);
	}
	return 1;
}

CMD:oban(playerid, params[])
{
    if(pInfo[playerid][Admin] >= 3)
	{
	    new name[MAX_PLAYER_NAME], reason[128], query[300], string[100], rows;
	    if(sscanf(params, "s[24]s[128]", name, reason)) return SendClientMessage(playerid, -1, "USAGE: /oban [username] [reason]");
	    mysql_format(Database, query, sizeof(query), "SELECT `USERNAME` FROM `PLAYERS` WHERE `USERNAME` = '%e' LIMIT 0,1", name);
	    new Cache:result = mysql_query(Database, query);
	    cache_get_row_count(rows);
	 
	    if(!rows)
	    {
	        SendClientMessage(playerid, COLOR_COMMAND_ERROR, "That name does not exist.");
	    }
	   
	    for (new i = 0; i < rows; i ++)
	    {
	    	new DB_Query[1000], adminName[MAX_PLAYER_NAME];
	    	GetPlayerName(playerid, adminName, sizeof(adminName));
	        mysql_format(Database, DB_Query, sizeof(DB_Query), "INSERT INTO `BANS` (`USERNAME`, `ADMIN`, `ACTIVE`, `REASON`, `DATE`)\
			VALUES ('%e', '%e', TRUE, '%s', '%e')", name, adminName, reason, ReturnDate());
		 	mysql_tquery(Database, DB_Query);
	        format(string, sizeof(string), "AdmCmd(3): %s has been offline-banned by %s, Reason: %s", name, adminName, reason);
	        SendClientMessageToAll(-1, string);
	        cache_delete(result);
	    }
    }
    else
	{
		return UnAuthMessage(playerid);
	}
    return 1;
}

CMD:reports(playerid, params[])
{
	if(pInfo[playerid][Admin] >= 1)
	{
		SendClientMessage(playerid, -1, "Reports:");
		for(new i;i < MAX_PLAYERS; i++)
		{
			if(GetPVarInt(i, "ReportPending") == 1)
			{
				new string[200], reportText[126], pendingtime, name[MAX_PLAYER_NAME];
				GetPlayerName(i, name, sizeof(name));
				GetPVarString(i, "ReportText", reportText, sizeof(reportText));
				pendingtime = (gettime()-GetPVarInt(i, "ReportTime"))/60;
				format(string, sizeof(string), "%s (ID: %d) | '%s' | Pending: %d minutes", name, i, reportText, pendingtime);
				SendClientMessage(playerid, -1, string);
			}
		}
	}
	return 1;
}

CMD:ar(playerid, params[])
{
	if(pInfo[playerid][Admin] >= 1)
	{
		new id, string[126];
		if(sscanf(params, "u", id))
			return SendClientMessage(playerid, -1, "Syntax: /ar [player id]");

		DeletePVar(id, "ReportPending");
		DeletePVar(id, "ReportText");
		DeletePVar(id, "ReportTime");

		new name[MAX_PLAYER_NAME], name2[MAX_PLAYER_NAME];
		GetPlayerName(playerid, name, sizeof(name));
		GetPlayerName(id, name2, sizeof(name2));
		format(string, sizeof(string), "%s has accepted the report from %s (ID %d)", name, name2, id);
		SendToAdmins(0xFFA200FF, string);

		format(string, sizeof(string), "%s has accepted your report. Please wait for the the admin to resolve the issue.", name);
		SendClientMessage(id, -1, string);
	}
	return 1;
}

CMD:tr(playerid, params[])
{
	if(pInfo[playerid][Admin] >= 1)
	{
		new id, string[126];
		if(sscanf(params, "u", id))
			return SendClientMessage(playerid, -1, "Syntax: /tr [player id]");

		DeletePVar(id, "ReportPending");
		DeletePVar(id, "ReportText");
		DeletePVar(id, "ReportTime");

		new name[MAX_PLAYER_NAME], name2[MAX_PLAYER_NAME];
		GetPlayerName(playerid, name, sizeof(name));
		GetPlayerName(id, name2, sizeof(name2));
		format(string, sizeof(string), "%s has denied the report from %s (ID %d)", name, name2, id);
		SendToAdmins(0xFFA200FF, string);

		format(string, sizeof(string), "%s has denied your report due to it being invalid.", name);
		SendClientMessage(id, -1, string);
	}
	return 1;
}

CMD:aduty(playerid)
{
	if(pInfo[playerid][Admin] >=1 || IsPlayerAdmin(playerid))
	{
		if (aDuty[playerid] == 0)
		{
			new string[128];
			new Float:x,Float:y,Float:z;
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, sizeof(name));
			GetPlayerPos(playerid,x,y,z);
			SetPlayerHealth(playerid, Float:0x7F800000 );
			SetPlayerColor(playerid, COLOR_WATCHDOG);
			format(string,sizeof(string), "%s %s is now on Admin Duty!", GetPlayerAdminRank(playerid) , name);


			SendClientMessageToAll(COLOR_WATCHDOG, string);
			SendClientMessage(playerid, COLOR_WATCHDOG, "You are now on duty!");
			aDuty[playerid] = 1;
			Attach3DTextLabelToPlayer(adminText, playerid, 0.0, 0.0, 0.7);
		}
		else if (aDuty[playerid] == 1)
		{
  			new string[128];
  			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, sizeof(name));
     		SetPlayerHealth(playerid,100);
			format(string,sizeof(string), "%s %s is now off Admin Duty!", GetPlayerAdminRank(playerid), name);

			SetPlayerColor(playerid, GetTeamColor(playerid));
			SendClientMessageToAll(COLOR_WATCHDOG, string);
			SendClientMessage(playerid, COLOR_WATCHDOG, "You are now off duty!");
			aDuty[playerid] = 0;
			DeletePlayer3DTextLabel(playerid, PlayerText3D:adminText);
		}
 	}
	else
		return UnAuthMessage(playerid);
	return 1;
}

CMD:send(playerid, params[])
{
    new Player1, Player2, Float:x, Float:y, Float:z, PortMsg[128], IntID, WorldID, pName[24], AdminName[24];
    if(pInfo[playerid][Admin] >=3)
    {
        if (sscanf(params, "uu", Player1, Player2)) SendClientMessage(playerid, -1, "Usage: /send <Player> <Player>");
        else
        {

        GetPlayerName(playerid, AdminName, sizeof(AdminName));
        GetPlayerName(Player2, pName, sizeof(pName));

        GetPlayerPos(Player2, x, y, z);
        IntID = GetPlayerInterior(Player2);
        WorldID = GetPlayerVirtualWorld(Player2);

        SetPlayerVirtualWorld(Player1, WorldID);
        SetPlayerInterior(Player1, IntID);
        SetPlayerPos(Player1, x, y, z + 3.0);

        format(PortMsg, 128, "You have been sent to player %s by %s", pName, AdminName);
        SendClientMessage(Player1, 0xFFFFFFFF, PortMsg);
        }
     }
     else
     {
     	return UnAuthMessage(playerid);
     }
	return 1;
}

CMD:go(playerid, params[])
{
	if(pInfo[playerid][Admin] >= 1)
	{
		new targetid, string[128];
		if(sscanf(params, "uz", targetid)) return SendClientMessage(playerid, COLOR_WHITE, "[USAGE] /go [PlayerID/PartOfName]");
		if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_WHITE, "[ERROR] Player not connected!");
		else
		{
			new pName[24];
			GetPlayerName(targetid, pName, 128);
			format(string, sizeof(string), "You have successfully teleported to %s.",pName);
			SendClientMessage(playerid, -1 ,string);
			SetPlayerInterior(playerid, GetPlayerInterior(targetid));
			new Float:TPX, Float:TPY, Float:TPZ;
			GetPlayerPos(targetid, TPX, TPY, TPZ);
			SetPlayerPos(playerid, TPX, TPY, TPZ+1);
		}
 	}
 	else
	{
   		return UnAuthMessage(playerid);
	}
	return 1;
}

CMD:get(playerid, params[])
{
	if(pInfo[playerid][Admin] >= 1)
	{
		new targetid, string[128];
		if(sscanf(params, "uz", targetid)) return SendClientMessage(playerid, COLOR_WHITE, "[USAGE] /get [PlayerID/PartOfName]");
		if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_WHITE, "[ERROR] Player not connected!");
		else
		{
			new pName[24];
			GetPlayerName(playerid,pName,128);
			format(string, sizeof(string), "You have been teleported to Administrator %s.",pName);
			SendClientMessage(targetid, -1 ,string);
			SetPlayerInterior(targetid, GetPlayerInterior(playerid));
			new Float:TPX, Float:TPY, Float:TPZ;
			GetPlayerPos(playerid, TPX, TPY, TPZ);
			SetPlayerPos(targetid, TPX, TPY, TPZ+1);
		}
 	}
 	else
	{
   		return UnAuthMessage(playerid);
	}
	return 1;
}

CMD:slap(playerid, params[])
{
if(pInfo[playerid][Admin] >= 1) {
	new id, Float:x, Float:y, Float:z, msg[128];
 	if(sscanf(params,"u",id)) return SendClientMessage(playerid,-1,"Usage: /slap [id]");
  	else if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "That player name is invalid or they are not connected anymore!");
   	else
	{
 		SendClientMessage(playerid,-1,"You have successfully slapped that player!");
   		GetPlayerPos(id,x,y,z); // Get target position
   		SetPlayerPos(id,x,y,z+4); // Change position of target
      	format(msg,sizeof(msg),"AdmCmd: You have been slapped by Admin %s", GetName(playerid));
       	SendClientMessage(id,-1,msg);
       	format(msg, sizeof(msg), "[WATCHDOG] %s slapped %s", GetName(playerid), GetName(id));
       	SendToAdmins(COLOR_WATCHDOG, msg);
       	PlayerPlaySound(id, 1190, 0.0, 0.0, 0.0);
	}
 	}
 	else
	{
		return UnAuthMessage(playerid);
	}
return 1;
}

CMD:makeadmin(playerid, params[])
{
    if(IsPlayerAdmin(playerid) || pInfo[playerid][Admin] >= 6)
    {
		new toid, level;
		if(!sscanf(params, "ui", toid, level))
		{
			pInfo[toid][Admin] = level;
			new string[128], adminName[MAX_PLAYER_NAME], playerName[MAX_PLAYER_NAME];
			GetPlayerName(toid, playerName, sizeof(playerName));
			GetPlayerName(playerid, adminName, sizeof(adminName));
			format(string, sizeof(string), "You have been made a level %d administrator by %s. Use /ahelp to see your new commands.", level, adminName);
			SendClientMessage(toid, -1, string);
			format(string, sizeof(string), "You have set %s's admin level to %d.", playerName, level);
			SendClientMessage(playerid, COLOR_WATCHDOG, string);
			format(string, sizeof(string), "[WATCHDOG] %s has set %s's admin level to %d", adminName, playerName, level);
			SendToAdmins(COLOR_WATCHDOG, string);

			new DB_Query[1000];
			mysql_format(Database, DB_Query, sizeof(DB_Query), "UPDATE `PLAYERS` SET `ADMIN` = '%d' WHERE `USERNAME` = '%e' LIMIT 1", pInfo[toid][Admin], pInfo[toid][Name]);
			mysql_tquery(Database, DB_Query, "OnPlayerCommandPerformed", "d", playerid);
        }
   		else
       	{
			return SendClientMessage(playerid, -1, "USAGE: /makeadmin [playerid/partofname] [level]");
		}
    }
    else
	{
		return UnAuthMessage(playerid);
	}
	return 1;
}

CMD:spec(playerid, params[])
{
	new id, theirName[MAX_PLAYER_NAME], specString[128];
	if(pInfo[playerid][Admin] == 0) return UnAuthMessage(playerid);
	if(sscanf(params,"u", id))return SendClientMessage(playerid, COLOR_COMMAND_ERROR, "Usage: /spec [id]");
	if(id == playerid)return SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You cannot spectate yourself.");
	if(id == INVALID_PLAYER_ID)return SendClientMessage(playerid, COLOR_COMMAND_ERROR, "Player not found.");
	if(IsSpecing[playerid] == 1)return SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You are already specing someone. (If this is an error, /specoff to reset)");
	GetPlayerPos(playerid,SpecX[playerid],SpecY[playerid],SpecZ[playerid]);
	Inter[playerid] = GetPlayerInterior(playerid);
	vWorld[playerid] = GetPlayerVirtualWorld(playerid);
	TogglePlayerSpectating(playerid, true);
	if(IsPlayerInAnyVehicle(id))
	{
	    if(GetPlayerInterior(id) > 0)
	    {
			SetPlayerInterior(playerid, GetPlayerInterior(id));
		}
		if(GetPlayerVirtualWorld(id) > 0)
		{
		    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
		}
	    PlayerSpectateVehicle(playerid, GetPlayerVehicleID(id));
	}
	else
	{
	    if(GetPlayerInterior(id) > 0)
	    {
			SetPlayerInterior(playerid,GetPlayerInterior(id));
		}
		if(GetPlayerVirtualWorld(id) > 0)
		{
		    SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(id));
		}
	    PlayerSpectatePlayer(playerid,id);
	}
	GetPlayerName(id, theirName, sizeof(theirName));
	format(specString, sizeof(specString),"You have started to spectate %s.",theirName);
	SendClientMessage(playerid, 0x0080C0FF ,specString);
	IsSpecing[playerid] = 1;
	IsBeingSpeced[id] = 1;
	spectatorid[playerid] = id;
 	return 1;
}

CMD:specoff(playerid, params[])
{
	if(pInfo[playerid][Admin] == 0)return 0;
	if(IsSpecing[playerid] == 0)return SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You are not spectating anyone.");
	TogglePlayerSpectating(playerid, 0);
	IsSpecing[playerid] = 0; // Setting player's spec to off regardless of state.
	return 1;
}

CMD:forceclass(playerid, params[])
{
	new targetid,Adminname[MAX_PLAYER_NAME], classString[128];
	GetPlayerName(playerid, Adminname, sizeof(Adminname));
    if(pInfo[playerid][Admin] == 0) return UnAuthMessage(playerid);
	else if (sscanf(params,"us",targetid))SendClientMessage(playerid,-1,"Usage: /forceclass [Playerid]");
	else if(!IsPlayerConnected(targetid))SendClientMessage(playerid,-1,"Error: Player is not connected!");
	else {
	ForceClassSelection(targetid);
	TogglePlayerSpectating(targetid, true);
	TogglePlayerSpectating(targetid, false);
	format(classString, sizeof(classString), "[WATCHDOG] You have been forced to pick a class by Admin %s.",Adminname);
	SendClientMessage(targetid, COLOR_WATCHDOG, classString);
	}
	return 1;
}

CMD:announce(playerid, params[])
{
    new
        str[128],
        name[24]
    ;
    if(pInfo[playerid][Admin] < 1) return SendClientMessage(playerid, 0xFF0000FF, "ERROR: You are not a admin!");
    {
        if(sscanf(params, "s[128]", str)) return SendClientMessage(playerid, 0xFF0000FF, "USAGE: /announce <message>");
        GetPlayerName(playerid, name, 24);
        format(str, sizeof(str),"[ANNOUNCEMENT] {FFFFFF}%s(%d): %s.",name,playerid,str);
        SendClientMessageToAll(0xFF0000FF, str);
    }
    return 1;
}

CMD:crespawn(playerid, params[])
{
if(pInfo[playerid][Admin] >= 1) {
        SetEmptyVehiclesToRespawn();
        SendClientMessage(playerid, COLOR_WATCHDOG, "All vehicles respawned");
        SendClientMessageToAll(COLOR_WATCHDOG, "[WATCHDOG] All vehicles have been respawned by an administrator!");
        return 1;
    }
    else return UnAuthMessage(playerid);
}

CMD:a(playerid, params[])
{
	if(pInfo[playerid][Admin] >= 1)
	{
		new string[126];

		if(isnull(params))
			return SendClientMessage(playerid, -1, "Syntax: /a [text]");

        new name[MAX_PLAYER_NAME];
		GetPlayerName(playerid, name, sizeof(name));
		format(string, sizeof(string), "%s (%d): %s", name, pInfo[playerid][Admin], params);
		SendToAdmins(0xF2FF00FF, string);
	}
	else return UnAuthMessage(playerid);
	return 1;
}