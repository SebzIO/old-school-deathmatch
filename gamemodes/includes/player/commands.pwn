/*
					  /$$$$$$   /$$$$$$  /$$$$$$$  /$$      /$$
					 /$$__  $$ /$$__  $$| $$__  $$| $$$    /$$$
					| $$  \ $$| $$  \__/| $$  \ $$| $$$$  /$$$$
					| $$  | $$|  $$$$$$ | $$  | $$| $$ $$/$$ $$
					| $$  | $$ \____  $$| $$  | $$| $$  $$$| $$
					| $$  | $$ /$$  \ $$| $$  | $$| $$\  $ | $$
					|  $$$$$$/|  $$$$$$/| $$$$$$$/| $$ \/  | $$
					 \______/  \______/ |_______/ |__/     |__/ 

//-------------------------[PLAYER/COMMANDS.PWN]--------------------------------


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

// I-ZCMD PLAYER COMMANDS
CMD:help(playerid)
{
	SendClientMessage(playerid, COLOR_WHITE, "==============Old School Deathmatch commands==============");
	SendClientMessage(playerid, COLOR_WHITE, "INFO: /forum, /admins, /rules");
	SendClientMessage(playerid, COLOR_WHITE, "ACCOUNT: /stats, /password");
	SendClientMessage(playerid, COLOR_WHITE, "TEAM: /changeteam, /g");
	SendClientMessage(playerid, COLOR_WHITE, "HELP: /report");
	SendClientMessage(playerid, COLOR_WHITE, "OTHER: /pm, /radio(off)");
	return CMD_SUCCESS;
}

CMD:password(playerid, params[])
{
	new password[65];
	if(sscanf(params, "s", password))
	{
		return SendClientMessage(playerid, COLOR_COMMAND_ERROR, "Usage: /password <newpassword>");
	}	
	else if(strlen(password) <= 5 || strlen(password) > 60)
	{
    	return SendClientMessage(playerid, 0x969696FF, "Invalid password length, it should be 6 - 60 characters long.");
    } else{
    	new DB_Query[1000];
		// Salting the player's password using SHA256.
			
        for (new i = 0; i < 10; i++)
        {
            pInfo[playerid][Salt][i] = random(79) + 47;
		}
		
		pInfo[playerid][Salt][10] = 0;
    	SHA256_PassHash(password, pInfo[playerid][Salt], pInfo[playerid][Password], 65);

    	// Storing player's information if everything goes right.
    	mysql_format(Database, DB_Query, sizeof(DB_Query), "UPDATE `PLAYERS` SET `PASSWORD` = '%e', `SALT` = '%e' WHERE `USERNAME` = '%e' LIMIT 1", pInfo[playerid][Password], pInfo[playerid][Salt], pInfo[playerid][Name]);
     	mysql_tquery(Database, DB_Query, "OnPlayerCommandPerformed", "d", playerid);
     	SendClientMessage(playerid, COLOR_MAJOR_WARNING, "[WARNING]: {FFFFFF} You have just changed your user password! This is irreversible!");
     	SendClientMessage(playerid, COLOR_MAJOR_WARNING, "[WARNING]: {FFFFFF} If you are unsure what you set it to, /password again before logging out.");
     	SendClientMessage(playerid, COLOR_MAJOR_WARNING, "[WARNING]: {FFFFFF} We will not help you recover your account without proof that you are the account owner.");

     	// Warning admins of this change.
     	new string[128];
     	format(string, sizeof(string), "[WATCHDOG] %s has changed their password. {FFFFFF}[DBID: %i] [IP: %s]", pInfo[playerid][Name], pInfo[playerid][ID], pInfo[playerid][IP]);
     	SendToAdmins(COLOR_WATCHDOG, string);
    }
 	return CMD_SUCCESS;
}

CMD:stats(playerid, params[])
{
	new string[128];
	new Float:ratio=floatdiv(pInfo[playerid][Kills], pInfo[playerid][Deaths]);
 	new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
	format(string, sizeof(string), "Name: %s | Unique ID: %d | Score: %d | Kills: %i | Deaths: %i | KDR: %.2f | Money: %d | Adminlevel: %d", name, pInfo[playerid][ID], pInfo[playerid][Score], pInfo[playerid][Kills], pInfo[playerid][Deaths], ratio, GetPlayerMoney(playerid), pInfo[playerid][Admin]);
	SendClientMessage(playerid, -1, string);
	SendClientMessage(playerid, -1, "To see another player's stats, simply double click their name on your TAB list!");
	return 1;
}

CMD:rules(playerid, params[])
{
	new rulesDialogStr[1000];
	strcat(rulesDialogStr, "{00FFEE}1) {FFFFFF}No camping in other team spawns.\n{00FFEE}2) {FFFFFF}No racism or politically based chat.\n", sizeof(rulesDialogStr));
	strcat(rulesDialogStr, "{00FFEE}3) {FFFFFF}Hacking or use of any advantageous third party modifications.\n{00FFEE}4) {FFFFFF}No bug abusing. If you find a bug, report it on the forums.\n", sizeof(rulesDialogStr));
	strcat(rulesDialogStr, "{00FFEE}5) {FFFFFF}No abuse of SAMP physics (cbugging, crolling, csliding).\n{00FFEE}6) {FFFFFF}No server advertising of any form.\n", sizeof(rulesDialogStr));
	strcat(rulesDialogStr, "{00FFEE}7) {FFFFFF}No excessive car ramming. Car parking and heliblading are strictly forbidden.", sizeof(rulesDialogStr));
	ShowPlayerDialog(playerid, DIALOG_RULES, DIALOG_STYLE_LIST, "Old School Deathmatch Rules", rulesDialogStr, "Okay", "");
	return 1;
}

CMD:forum(playerid, params[])
{
	SendClientMessage(playerid, -1, "Register for an account on our forums today at forum.osdm.xyz!");
	return 1;
}

CMD:admins(playerid, params[])
{
	SendClientMessage(playerid, COLOR_TURF, "Online OSDM admins:");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(pInfo[i][Admin] >= 1)
			{
				new admString[128];
				if(aDuty[i] == 0)
				{
					format(admString, sizeof(admString), "%s %s [%s]", GetPlayerAdminRank(i), GetName(i), GetPlayerAdutyStatus(i));
					SendClientMessage(playerid, -1, admString);
				}
				else
				{
					format(admString, sizeof(admString), "%s %s {8000FF}[%s]", GetPlayerAdminRank(i), GetName(i), GetPlayerAdutyStatus(i));
					SendClientMessage(playerid, -1, admString);
				}
			}
	    }
	}
	return 1;
}

CMD:pm(playerid, params[])
{
	new str[128], str2[128], id, Name1[MAX_PLAYER_NAME], Name2[MAX_PLAYER_NAME];
	if(sscanf(params, "us[128]", id, str2))
	{
	    SendClientMessage(playerid, 0xD5AA2BFF, "Usage: /pm <id> <message>");
	    return 1;
	}
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, 0xD5AA2BFF, "ERROR: Player not connected");
	if(playerid == id) return SendClientMessage(playerid, 0xD5AA2BFF, "ERROR: You cannot pm yourself!");
	{
		GetPlayerName(playerid, Name1, sizeof(Name1));
		GetPlayerName(id, Name2, sizeof(Name2));
		format(str, sizeof(str), "PM To %s(ID %d): %s", Name2, id, str2);
		SendClientMessage(playerid, 0xD5AA2BFF, str);
		format(str, sizeof(str), "PM From %s(ID %d): %s", Name1, playerid, str2);
		SendClientMessage(id, 0xFFFF00FF, str);
	}
	return 1;
}

CMD:changeteam(playerid, params[])
{
    ForceClassSelection(playerid);
    TogglePlayerSpectating(playerid, true);
    TogglePlayerSpectating(playerid, false);
    SetPlayerHealth(playerid, 100);
    return 1;
}

CMD:g( playerid, params[ ] )
{
	if(isnull(params))
		return SendClientMessage( playerid, -1, "Syntax: /g <message>" );
	new
		x = GetPlayerTeam( playerid ),
		szStr[ 145 ],
		szName[ MAX_PLAYER_NAME ];
	GetPlayerName( playerid, szName, MAX_PLAYER_NAME );
	for ( new i, j = GetMaxPlayers( ); i < j; ++ i )
	{
		if ( !IsPlayerConnected( i ) )
			continue;
		if ( GetPlayerTeam( i ) != x )
			continue;
		format( szStr, sizeof ( szStr ), "{FFFF33}[TEAM-CHAT]: [%01d] %s: {FFFFFF}%s", playerid, szName, params );
		SendClientMessage( i, -1, szStr );
	}
	return 1;
}

CMD:report(playerid, params[])
{
	new text[126];
	if(sscanf(params, "s[126]", text))
		return SendClientMessage(playerid, -1, "Syntax: /report [text]");

	SetPVarInt(playerid, "ReportPending", 1);
	SetPVarString(playerid, "ReportText", text);
	SetPVarInt(playerid, "ReportTime", gettime());

	SendClientMessage(playerid, -1, "Thank you for submitting your report. An admin will be with you as soon as possible");
	SendClientMessage(playerid, -1, "Spamming this command WILL result in you being banned, do not abuse this.");

	new name[MAX_PLAYER_NAME], string[1200];
    GetPlayerName(playerid, name, sizeof(name));
    format(string, sizeof(string), "Report from %s(%d): %s", name, playerid, text);
    SendToAdmins(0xFFA200FF, string);
	return 1;
}

//========================================================


CMD:radio(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOG_RADIO, DIALOG_STYLE_TABLIST, "Select a genre below", "Rap\nRock\nPlaceHolder\nPlaceHolder", "Select", "Cancel");
	return 1;
}

CMD:radiooff(playerid, params[])
{
	StopAudioStreamForPlayer(playerid);
	return 1;
}
//================================================================================================================================================