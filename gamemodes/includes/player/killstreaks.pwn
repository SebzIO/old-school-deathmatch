/*
            /$$$$$$   /$$$$$$  /$$$$$$$  /$$      /$$
           /$$__  $$ /$$__  $$| $$__  $$| $$$    /$$$
          | $$  \ $$| $$  \__/| $$  \ $$| $$$$  /$$$$
          | $$  | $$|  $$$$$$ | $$  | $$| $$ $$/$$ $$
          | $$  | $$ \____  $$| $$  | $$| $$  $$$| $$
          | $$  | $$ /$$  \ $$| $$  | $$| $$\  $ | $$
          |  $$$$$$/|  $$$$$$/| $$$$$$$/| $$ \/  | $$
           \______/  \______/ |_______/ |__/     |__/ 

//-------------------------[PLAYER/KILLSTREAK.PWN]--------------------------------


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

/*
    MODULE DESCRIPTION:
      This module will handle player killstreaks (primarily for on screen streak messages). Players might be paid for ending a certain killstreak.
        Module created by Sebz.
*/

/*HandleKS(playerid, killerid)
{
     killstreak[playerid] = 0;
     killstreak[killerid] ++;

     new msg1[128], msg2[128], name1[MAX_PLAYER_NAME], name2[MAX_PLAYER_NAME];

     format(msg1, strlen(msg1), "%s has ended %s's killstreak", GetName(killerid), GetName(playerid));
     format(msg2, strlen(msg2), "%s is now on a killsreak of %i", GetName(killerid), killstreak[killerid]);

     switch(killstreak[killerid])
     {
          case 3:
          {
          	new name[MAX_PLAYER_NAME], dstring[128];
            GetPlayerName(killerid, name, sizeof(name));
            format(dstring, sizeof(dstring), "%s has reached a 3 killstreak and has been given a Shotgun with 100 shells.", name);
            GivePlayerWeapon(killerid, 25, 100);
            SendClientMessageToAll(0xAA3333AA, dstring);
        	SetTimer("HideTextDraw", 5000, 0);
          }
          case 5:
          {
            new name[MAX_PLAYER_NAME], dstring[128];
            GetPlayerName(killerid, name, sizeof(name));
	        new Float:phealth;
	        new Float:ahealth;
	        GetPlayerHealth(killerid, phealth);
	        SetPlayerHealth(killerid, phealth + 50);
	        GetPlayerHealth(killerid, ahealth);
	        format(dstring, sizeof(dstring), "%s has reached a 5 killstreak and has been given 50 HP. (New HP: %.3f)", name, ahealth+50);
	        SendClientMessageToAll(0xAA3333AA, dstring);
          }
          case 9:
          {
          	new name[MAX_PLAYER_NAME], dstring[128];
            GetPlayerName(killerid, name, sizeof(name));
            format(dstring, sizeof(dstring), "%s has reached a 9 killstreak and has been given an M4 with 250 rounds.", name);
            GivePlayerWeapon(killerid, 31, 250);
            SendClientMessageToAll(0xAA3333AA, dstring);
          }
          case 10:
          {
            new name[MAX_PLAYER_NAME], dstring[128];
            GetPlayerName(killerid, name, sizeof(name));
	        new Float:phealth;
	        new Float:ahealth;
	        GetPlayerHealth(killerid, phealth);
	        SetPlayerHealth(killerid, phealth + 50);
	        GetPlayerHealth(killerid, ahealth);
	        format(dstring, sizeof(dstring), "%s has reached a 10 killstreak and has been given 50 HP. (New HP: %.3f)", name, ahealth+50);
	        SendClientMessageToAll(0xAA3333AA, dstring);
          }
          case 15:
          {
            new name[MAX_PLAYER_NAME], dstring[128];
            GetPlayerName(killerid, name, sizeof(name));
	        new Float:phealth;
	        new Float:ahealth;
	        GetPlayerHealth(killerid, phealth);
	        SetPlayerHealth(killerid, phealth + 50);
	        GetPlayerHealth(killerid, ahealth);
	        GivePlayerWeapon(killerid, 34, 20);
	        format(dstring, sizeof(dstring), "%s has reached a 15 killstreak and has been given 50 HP and a Sniper with 20 rounds. (New HP: %.3f)", name, ahealth+50);
	        SendClientMessageToAll(0xAA3333AA, dstring);
          }
     }
     return 1;
}*/