/*
					  /$$$$$$   /$$$$$$  /$$$$$$$  /$$      /$$
					 /$$__  $$ /$$__  $$| $$__  $$| $$$    /$$$
					| $$  \ $$| $$  \__/| $$  \ $$| $$$$  /$$$$
					| $$  | $$|  $$$$$$ | $$  | $$| $$ $$/$$ $$
					| $$  | $$ \____  $$| $$  | $$| $$  $$$| $$
					| $$  | $$ /$$  \ $$| $$  | $$| $$\  $ | $$
					|  $$$$$$/|  $$$$$$/| $$$$$$$/| $$ \/  | $$
					 \______/  \______/ |_______/ |__/     |__/ 

//-------------------------[ADMIN/ANTICHEAT.PWN]--------------------------------


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
 
#include "./includes/connections.pwn"
#include "./includes/defines.pwn"
#include "./includes/enums.pwn"
#include "./includes/variables.pwn"

// NEX-AC
forward OnCheatDetected(playerid, ip_address[], type, code);
public OnCheatDetected(playerid, ip_address[], type, code)
{
	new cheaterName[MAX_PLAYER_NAME];
	new string[128];
	new reason[128];
	cheaterName = GetName(playerid);
    if(type) BlockIpAddress(ip_address, 0);
    else
    {
        switch(code)
        {
            case 0: // Anti Airbreak, on foot.
            {
            	format(string, sizeof(string), "[WATCHDOG] %s has triggered anti-airbreak (on-foot).", cheaterName);
            	SendToAdmins(COLOR_WATCHDOG, string);
            }
            case 1: // Anti Airbreak in-vehicle
            {
            	format(string, sizeof(string), "[WATCHDOG] %s has triggered anti-airbreak (in-vehicle).", cheaterName);
            	SendToAdmins(COLOR_WATCHDOG, string);
            }
            case 2: // Anti Teleport on-foot
            {
            	format(string, sizeof(string), "[WATCHDOG] %s has triggered anti-teleport (on-foot).", cheaterName);
            	SendToAdmins(COLOR_WATCHDOG, string);
            }
            case 3: // Anti Teleport in-vehicle
            {
            	format(string, sizeof(string), "[WATCHDOG] %s has triggered anti-teleport (in-vehicle).", cheaterName);
            	SendToAdmins(COLOR_WATCHDOG, string);
            }
            case 4: // Anti Teleport (into/between vehicles)
            {
            	format(string, sizeof(string), "[WATCHDOG] %s has triggered anti-teleport (into/between vehicles).", cheaterName);
            	SendToAdmins(COLOR_WATCHDOG, string);
            }
            case 5: // Anti Teleport (vehicle to player)
            {
            	format(string, sizeof(string), "[WATCHDOG] %s has triggered anti-teleport (vehicle to player).", cheaterName);
            	SendToAdmins(COLOR_WATCHDOG, string);
            }
            case 6: // Anti Teleport in-vehicle
            {
            	format(string, sizeof(string), "[WATCHDOG] %s has triggered anti-teleport (pickups).", cheaterName);
            	SendToAdmins(COLOR_WATCHDOG, string);
            }
            case 7: // Anti Flyhack on-foot
            {
            	format(string, sizeof(string), "[WATCHDOG] %s has triggered anti-flyhack (on-foot).", cheaterName);
            	SendToAdmins(COLOR_WATCHDOG, string);
            }
            case 8: // Anti SpeedHack on-foot
            {
            	format(string, sizeof(string), "[WATCHDOG] %s has triggered anti-flyhack (in-vehicle).", cheaterName);
            	SendToAdmins(COLOR_WATCHDOG, string);
            }
            case 9: // Anti SpeedHack on-foot
            {
            	format(string, sizeof(string), "[WATCHDOG] %s has triggered anti-speedhack (on-foot).", cheaterName);
            	SendToAdmins(COLOR_WATCHDOG, string);
            }
            case 10: // Anti SpeedHack in-vehicle
            {
            	format(string, sizeof(string), "[WATCHDOG] %s has triggered anti-speedhack (in-vehicle).", cheaterName);
            	SendToAdmins(COLOR_WATCHDOG, string);
            }
            case 15: // Anti Weapon Hack
            {
            	format(string, sizeof(string), "[WATCHDOG] %s has triggered anti-weaponhack", cheaterName);
            	SendToAdmins(COLOR_WATCHDOG, string);
				reason = "Weapon Hacking";
				format(string, sizeof(string), "AdmCmd(1): '%s' has been banned by administrator 'WATCHDOG'. Reason: %s", cheaterName, reason);
				SendClientMessageToAll(COLOR_MAJOR_WARNING, string);

				new DB_Query[1000];
				// Saving ban to BANS table.
				mysql_format(Database, DB_Query, sizeof(DB_Query), "INSERT INTO `BANS` (`USERNAME`, `ADMIN`, `IP`, `ACTIVE`, `REASON`, `DATE`)\
				VALUES ('%e', '%e', '%s', TRUE, '%s', '%e')", pInfo[playerid][Name], "WATCHDOG", pInfo[playerid][IP], reason, ReturnDate());
			 	mysql_tquery(Database, DB_Query);
				SetTimerEx("BanTime", 400, 0, "d", playerid);
            }
            case 32:
            {
                new Float:x, Float:y, Float:z;
                AntiCheatGetPos(playerid, x, y, z);
                SetPlayerPos(playerid, x, y, z);
                return 1;
            }
            case 40: SendClientMessage(playerid, -1, MAX_CONNECTS_MSG);
            case 41: SendClientMessage(playerid, -1, UNKNOWN_CLIENT_MSG);
            default:
            {
                new strtmp[sizeof KICK_MSG];
                format(strtmp, sizeof strtmp, KICK_MSG, code);
                //SendClientMessage(playerid, -1, strtmp);
            }
        }
    }
    return 1;
}
// ====================