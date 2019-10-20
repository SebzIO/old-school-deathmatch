/*
                      /$$$$$$   /$$$$$$  /$$$$$$$  /$$      /$$
                     /$$__  $$ /$$__  $$| $$__  $$| $$$    /$$$
                    | $$  \ $$| $$  \__/| $$  \ $$| $$$$  /$$$$
                    | $$  | $$|  $$$$$$ | $$  | $$| $$ $$/$$ $$
                    | $$  | $$ \____  $$| $$  | $$| $$  $$$| $$
                    | $$  | $$ /$$  \ $$| $$  | $$| $$\  $ | $$
                    |  $$$$$$/|  $$$$$$/| $$$$$$$/| $$ \/  | $$
                     \______/  \______/ |_______/ |__/     |__/ 

//-------------------------[PLAYER/CLASSES.PWN]--------------------------------


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

#include "./includes/connections.pwn"
#include "./includes/defines.pwn"
#include "./includes/enums.pwn"
#include "./includes/functions.pwn"

#define CLASS_MAX_WEAPONS 7
static ClassWeapons[MAX_PLAYERS][CLASS_MAX_WEAPONS];
static lastClassIndex[MAX_PLAYERS];


hook OnGameModeInit()
{
	// Player weapon class data table creation (if it does not exist).
	mysql_tquery(Database, "CREATE TABLE IF NOT EXISTS `CLASSES` (`ID` int(11) NOT NULL,`USERNAME` varchar(24) NOT NULL,`CLASSID` char(10) NOT NULL,`MELEE` int(11) NOT NULL,`THROWN` int(11) NOT NULL,`HANDGUN` int(11) NOT NULL,`SHOTGUN` int(11) NOT NULL,`SUBMACHINE` int(11) NOT NULL,`ASSAULT` int(11) NOT NULL,`LONGRIFLE` int(11) NOT NULL, FOREIGN KEY (`ID`) REFERENCES PLAYERS (`ID`))");
	//================================================
}

hook OnPlayerConnect(playerid)
{
	// Enum for when class data is being edited. Will never be used to give a weapon.
	for(new i=0; i<=4; i++)
	{
		editClassData[i][playerid][E_MELEE] = -1;
		editClassData[i][playerid][E_THROWN] = -1;
		editClassData[i][playerid][E_HANDGUN] = -1;
		editClassData[i][playerid][E_SHOTGUN] = -1;
		editClassData[i][playerid][E_SUBMACHINE] = -1;
		editClassData[i][playerid][E_ASSAULT] = -1;
		editClassData[i][playerid][E_LONGRIFLE] = -1;		
	}

	// Enum for the currently selected class (via select class). WILL give guns.
	classData[playerid][E_MELEE] = -1;
	classData[playerid][E_THROWN] = -1;
	classData[playerid][E_HANDGUN] = -1;
	classData[playerid][E_SHOTGUN] = -1;
	classData[playerid][E_SUBMACHINE] = -1;
	classData[playerid][E_ASSAULT] = -1;
	classData[playerid][E_LONGRIFLE] = -1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_CLASS_MENU)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: ShowPlayerDialog(playerid, DIALOG_CLASS_SELECT, DIALOG_STYLE_LIST, "Select a class", "Class 1\nClass 2\nClass 3\nClass 4\nClass 5", "Select", "Cancel");
				case 1: ShowPlayerDialog(playerid, DIALOG_CLASS_EDIT, DIALOG_STYLE_LIST, "Select a class to edit", "Class 1\nClass 2\nClass 3\nClass 4\nClass 5", "Select", "Cancel");
			}
		}
	}

	if(dialogid == DIALOG_CLASS_SELECT)
	{
		if(response)
		{
			switch(listitem)
			{
				// Load player class here (1-5)
			}
		}
	}

	if(dialogid == DIALOG_CLASS_EDIT)
	{
		new editString[1000];
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					format(editString, sizeof(editString), "Melee:\t%s\n\
						Thrown:\t%s\n\
						Handgun:\t%s\n\
						Shotgun:\t%s\n\
						SMG:\t%s\n\
						Assault Rifle:\t%s\n\
						Long Rifle:\t%s",
						WeaponIDToName(editClassData[0][playerid][E_MELEE]), 
						WeaponIDToName(editClassData[0][playerid][E_THROWN]), 
						WeaponIDToName(editClassData[0][playerid][E_HANDGUN]), 
						WeaponIDToName(editClassData[0][playerid][E_SHOTGUN]), 
						WeaponIDToName(editClassData[0][playerid][E_SUBMACHINE]), 
						WeaponIDToName(editClassData[0][playerid][E_ASSAULT]), 
						WeaponIDToName(editClassData[0][playerid][E_LONGRIFLE]));
					ShowPlayerDialog(playerid, DIALOG_CLASS_EDITING, DIALOG_STYLE_TABLIST, "Editing class number 1", editString, "Select", "Cancel");
					lastClassIndex[playerid] = listitem;
				}

				case 1:
				{
					format(editString, sizeof(editString), "Melee:\t%s\n\
						Thrown:\t%s\n\
						Handgun:\t%s\n\
						Shotgun:\t%s\n\
						SMG:\t%s\n\
						Assault Rifle:\t%s\n\
						Long Rifle:\t%s", 
						WeaponIDToName(editClassData[1][playerid][E_MELEE]), 
						WeaponIDToName(editClassData[1][playerid][E_THROWN]), 
						WeaponIDToName(editClassData[1][playerid][E_HANDGUN]), 
						WeaponIDToName(editClassData[1][playerid][E_SHOTGUN]), 
						WeaponIDToName(editClassData[1][playerid][E_SUBMACHINE]), 
						WeaponIDToName(editClassData[1][playerid][E_ASSAULT]), 
						WeaponIDToName(editClassData[1][playerid][E_LONGRIFLE]));
					ShowPlayerDialog(playerid, DIALOG_CLASS_EDITING, DIALOG_STYLE_TABLIST, "Editing class number 2", editString, "Select", "Cancel");
					lastClassIndex[playerid] = listitem;
				}

				case 2:
				{
					format(editString, sizeof(editString), "Melee:\t%s\n\
						Thrown:\t%s\n\
						Handgun:\t%s\n\
						Shotgun:\t%s\n\
						SMG:\t%s\n\
						Assault Rifle:\t%s\n\
						Long Rifle:\t%s", 
						WeaponIDToName(editClassData[2][playerid][E_MELEE]), 
						WeaponIDToName(editClassData[2][playerid][E_THROWN]), 
						WeaponIDToName(editClassData[2][playerid][E_HANDGUN]), 
						WeaponIDToName(editClassData[2][playerid][E_SHOTGUN]), 
						WeaponIDToName(editClassData[2][playerid][E_SUBMACHINE]), 
						WeaponIDToName(editClassData[2][playerid][E_ASSAULT]), 
						WeaponIDToName(editClassData[2][playerid][E_LONGRIFLE]));
					ShowPlayerDialog(playerid, DIALOG_CLASS_EDITING, DIALOG_STYLE_TABLIST, "Editing class number 3", editString, "Select", "Cancel");
					lastClassIndex[playerid] = listitem;
				}

				case 3:
				{
					format(editString, sizeof(editString), "Melee:\t%s\n\
						Thrown:\t%s\n\
						Handgun:\t%s\n\
						Shotgun:\t%s\n\
						SMG:\t%s\n\
						Assault Rifle:\t%s\n\
						Long Rifle:\t%s", 
						WeaponIDToName(editClassData[3][playerid][E_MELEE]), 
						WeaponIDToName(editClassData[3][playerid][E_THROWN]), 
						WeaponIDToName(editClassData[3][playerid][E_HANDGUN]), 
						WeaponIDToName(editClassData[3][playerid][E_SHOTGUN]), 
						WeaponIDToName(editClassData[3][playerid][E_SUBMACHINE]), 
						WeaponIDToName(editClassData[3][playerid][E_ASSAULT]), 
						WeaponIDToName(editClassData[3][playerid][E_LONGRIFLE]));
					ShowPlayerDialog(playerid, DIALOG_CLASS_EDITING, DIALOG_STYLE_TABLIST, "Editing class number 4", editString, "Select", "Cancel");
					lastClassIndex[playerid] = listitem;
				}

				case 4:
				{
					format(editString, sizeof(editString), "Melee:\t%s\n\
						Thrown:\t%s\n\
						Handgun:\t%s\n\
						Shotgun:\t%s\n\
						SMG:\t%s\n\
						Assault Rifle:\t%s\n\
						Long Rifle:\t%s", 
						WeaponIDToName(editClassData[4][playerid][E_MELEE]), 
						WeaponIDToName(editClassData[4][playerid][E_THROWN]), 
						WeaponIDToName(editClassData[4][playerid][E_HANDGUN]), 
						WeaponIDToName(editClassData[4][playerid][E_SHOTGUN]), 
						WeaponIDToName(editClassData[4][playerid][E_SUBMACHINE]), 
						WeaponIDToName(editClassData[4][playerid][E_ASSAULT]), 
						WeaponIDToName(editClassData[4][playerid][E_LONGRIFLE]));
					ShowPlayerDialog(playerid, DIALOG_CLASS_EDITING, DIALOG_STYLE_TABLIST, "Editing class number 5", editString, "Select", "Cancel");
					lastClassIndex[playerid] = listitem;
				}
			}
		}
	}

	if(dialogid == DIALOG_CLASS_EDITING)
	{
		new weaponList[1000];
		if(response)
		{
			switch(listitem)
			{
				case 0: // Melee Weapons
				{
					format(weaponList, sizeof(weaponList), "Golf Club\nNite Stick\nKnife (200 score)\nBaseball Bat\nShovel\nPool Cue\nKatana (1,000 score)\nCane\nFlowers\nPurple Dildo (25,000 score)");
					ShowPlayerDialog(playerid, DIALOG_CLASS_MELEE, DIALOG_STYLE_LIST, "Select a melee weapon", weaponList, "Select", "Cancel");
				}

				case 1: // Thrown weapons (grenades etc)
				{
					format(weaponList, sizeof(weaponList), "Frag Grenade (2500 score)\nMolotov Cocktail (3000 score)");
					ShowPlayerDialog(playerid, DIALOG_CLASS_THROWN, DIALOG_STYLE_LIST, "Select a thrown weapon", weaponList, "Select", "Cancel");
				}

				case 2: // Handguns
				{
					format(weaponList, sizeof(weaponList), "Desert Eagle\nSilenced Pistol (100 score)\nColt 45 (50 score)");
					ShowPlayerDialog(playerid, DIALOG_CLASS_HANDGUN, DIALOG_STYLE_LIST, "Select a handgun", weaponList, "Select", "Cancel");
				}

				case 3: // Shotguns
				{
					format(weaponList, sizeof(weaponList), "Pump shotgun (100 score)\nSawn-Off shotgun (500 score)\nCombat shotgun (1,000 score)");
					ShowPlayerDialog(playerid, DIALOG_CLASS_SHOTGUN, DIALOG_STYLE_LIST, "Select a shotgun", weaponList, "Select", "Cancel");
				}

				case 4: // Sub machineguns.
				{
					format(weaponList, sizeof(weaponList), "Micro Uzi (300 score)\nMP5 (500 score)\nTEC-9 (300 score)");
					ShowPlayerDialog(playerid, DIALOG_CLASS_SMG, DIALOG_STYLE_LIST, "Select a submachine gun", weaponList, "Select", "Cancel");
				}

				case 5: // Assault rifles.
				{
					format(weaponList, sizeof(weaponList), "AK47 (750 score)\nM4 (1,000 score)");
					ShowPlayerDialog(playerid, DIALOG_CLASS_ASSAULT, DIALOG_STYLE_LIST, "Select an assault rifle", weaponList, "Select", "Cancel");
				}

				case 6: // Long rifles (such as sniper rifle)
				{
					format(weaponList, sizeof(weaponList), "Sniper Rifle (1,250 score)\nCountry Rifle (500 score)");
					ShowPlayerDialog(playerid, DIALOG_CLASS_RIFLE, DIALOG_STYLE_LIST, "Select a long rifle", weaponList, "Select", "Cancel");
				}
			}
		}
	}

	if(dialogid == DIALOG_CLASS_MELEE)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: // Golf Club
				{
					editClassData[lastClassIndex[playerid]][playerid][E_MELEE] = 2;
					SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
				}
				case 1: // Nite Stick
				{
					editClassData[lastClassIndex[playerid]][playerid][E_MELEE] = 3;
					SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
				}
				case 2: // Knife
				{
					if(GetPlayerScore(playerid) >= 200)
					{
						editClassData[lastClassIndex[playerid]][playerid][E_MELEE] = 4;
						SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
					}
					else SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You do not meet the score requirement for: Knife (200 score)");
				}
				case 3: // Baseball bat
				{
					editClassData[lastClassIndex[playerid]][playerid][E_MELEE] = 5;
					SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
				}
				case 4: // Shovel
				{
					editClassData[lastClassIndex[playerid]][playerid][E_MELEE] = 6;
					SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
				}
				case 5: // Pool Cue
				{
					editClassData[lastClassIndex[playerid]][playerid][E_MELEE] = 7;
					SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
				}
				case 6: // Katana
				{
					if(GetPlayerScore(playerid) >= 1000)
					{
						editClassData[lastClassIndex[playerid]][playerid][E_MELEE] = 8;
						SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
					}
					else SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You do not meet the score requirement for: Katana (1000 score)");
				}
				case 7: // Cane
				{
					editClassData[lastClassIndex[playerid]][playerid][E_MELEE] = 15;
					SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
				}
				case 8: // Flowers
				{
					editClassData[lastClassIndex[playerid]][playerid][E_MELEE] = 14;
					SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
				}
				case 9: // Purple dildo
				{
					if(GetPlayerScore(playerid) >= 25000)
					{
						editClassData[lastClassIndex[playerid]][playerid][E_MELEE] = 8;
						SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
					}
					else SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You do not meet the score requirement for: Purple Dildo (25000 score)");
				}
			}
		}
	}

	if(dialogid == DIALOG_CLASS_THROWN)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: // Frag Grenade
				{
					if(GetPlayerScore(playerid) >= 2500)
					{
						editClassData[lastClassIndex[playerid]][playerid][E_THROWN] = 16;
						SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
					}
					else SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You do not meet the score requirement for: Frag Grenade (2500 score)");
				}

				case 1: // Molotov Cocktail
				{
					if(GetPlayerScore(playerid) >= 3000)
					{
						editClassData[lastClassIndex[playerid]][playerid][E_THROWN] = 18;
						SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
					}
					else SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You do not meet the score requirement for: Molotov Cocktail (3000 score)");
				}
			}
		}
	}

	if(dialogid == DIALOG_CLASS_HANDGUN)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: // Desert Eagle
				{
					editClassData[lastClassIndex[playerid]][playerid][E_HANDGUN] = 24;
					SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
				}

				case 1: // Silenced Pistol
				{
					if(GetPlayerScore(playerid) >= 100)
					{
						editClassData[lastClassIndex[playerid]][playerid][E_HANDGUN] = 23;
						SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
					}
					else SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You do not meet the score requirement for: Silenced Pistol (100 score)");
				}

				case 2: // Colt 45
				{
					if(GetPlayerScore(playerid) >= 50)
					{
						editClassData[lastClassIndex[playerid]][playerid][E_HANDGUN] = 22;
						SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
					}
					else SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You do not meet the score requirement for: Colt 45 (50 score)");
				}
			}
		}
	}

	if(dialogid == DIALOG_CLASS_SHOTGUN)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: // Pump Shotgun
				{
					if(GetPlayerScore(playerid) >= 100)
					{
						editClassData[lastClassIndex[playerid]][playerid][E_SHOTGUN] = 25;
						SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
					}
					else SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You do not meet the score requirement for: Pump Shotgun (100 score)");
				}

				case 1: // Sawn-Off Shotgun
				{
					if(GetPlayerScore(playerid) >= 500)
					{
						editClassData[lastClassIndex[playerid]][playerid][E_SHOTGUN] = 26;
						SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
					}
					else SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You do not meet the score requirement for: Sawn-off Shotgun (500 score)");
				}

				case 2: // Combat Shotgun
				{
					if(GetPlayerScore(playerid) >= 1000)
					{
						editClassData[lastClassIndex[playerid]][playerid][E_SHOTGUN] = 27;
						SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
					}
					else SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You do not meet the score requirement for: Combat Shotgun (1,000 score)");
				}
			}
		}
	}

	if(dialogid == DIALOG_CLASS_SMG)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: // Micro Uzi
				{
					if(GetPlayerScore(playerid) >= 300)
					{
						editClassData[lastClassIndex[playerid]][playerid][E_SUBMACHINE] = 28;
						SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
					}
					else SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You do not meet the score requirement for: Micro Uzi (300 score)");
				}

				case 1: // Mp5
				{
					if(GetPlayerScore(playerid) >= 500)
					{
						editClassData[lastClassIndex[playerid]][playerid][E_SUBMACHINE] = 29;
						SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
					}
					else SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You do not meet the score requirement for: MP5 (500 score)");
				}

				case 2: // Tec-9
				{
					if(GetPlayerScore(playerid) >= 300)
					{
						editClassData[lastClassIndex[playerid]][playerid][E_SUBMACHINE] = 32;
						SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
					}
					else SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You do not meet the score requirement for: Tec-9 (300 score)");
				}
			}
		}
	}

	if(dialogid == DIALOG_CLASS_ASSAULT)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: // AK47
				{
					if(GetPlayerScore(playerid) >= 750)
					{
						editClassData[lastClassIndex[playerid]][playerid][E_ASSAULT] = 30;
						SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
					}
					else SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You do not meet the score requirement for: AK47 (750 score)");
				}

				case 1: // M4
				{
					if(GetPlayerScore(playerid) >= 1000)
					{
						editClassData[lastClassIndex[playerid]][playerid][E_ASSAULT] = 31;
						SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
					}
					else SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You do not meet the score requirement for: M4 (1,000 score)");
				}
			}
		}
	}

	if(dialogid == DIALOG_CLASS_RIFLE)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: // Sniper Rifle
				{
					if(GetPlayerScore(playerid) >= 1250)
					{
						editClassData[lastClassIndex[playerid]][playerid][E_LONGRIFLE] = 34;
						SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
					}
					else SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You do not meet the score requirement for: Sniper Rifle (1,250 score)");
				}

				case 1: // Country Rifle
				{
					if(GetPlayerScore(playerid) >= 500)
					{
						editClassData[lastClassIndex[playerid]][playerid][E_LONGRIFLE] = 33;
						SendClientMessage(playerid, COLOR_PLAYER_NUMBER, "You've successfully updated your class.");
					}
					else SendClientMessage(playerid, COLOR_COMMAND_ERROR, "You do not meet the score requirement for: Country Rifle (500 score)");
				}
			}
		}
	}

	return 1;
}


CMD:class(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOG_CLASS_MENU, DIALOG_STYLE_LIST, "OSDM Class Menu", "Select Class\nEdit Class", "Select", "Cancel");
    return 1;
}

CMD:classindex(playerid, params[])
{
	new string[128];
	format(string, sizeof(string), "Last class edited was class number (%i).", lastClassIndex[playerid] + 1);
	SendClientMessage(playerid, -1, string);
	return 1;
}