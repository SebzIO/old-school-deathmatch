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
	mysql_tquery(Database, "CREATE TABLE IF NOT EXISTS `CLASSES` (`ID` int(11) NOT NULL,`USERNAME` varchar(24) NOT NULL,`CLASSID` char(10) NOT NULL,`MELEE` int(11) NOT NULL,`THROWN` int(11) NOT NULL,`HANDGUN` int(11) NOT NULL,`SHOTGUN` int(11) NOT NULL,`SUBMACHINE` int(11) NOT NULL,`ASSAULT` int(11) NOT NULL,`LONGRIFLE` int(11) NOT NULL, PRIMARY KEY (`ID`), UNIQUE KEY `USERNAME` (`USERNAME`))");
	//================================================
}

hook OnPlayerConnect(playerid)
{
	// Enum for when class data is being edited. Will never be used to give a weapon.
	editClassData[4][playerid][E_MELEE] = -1;
	editClassData[4][playerid][E_THROWN] = -1;
	editClassData[4][playerid][E_HANDGUN] = -1;
	editClassData[4][playerid][E_SHOTGUN] = -1;
	editClassData[4][playerid][E_SUBMACHINE] = -1;
	editClassData[4][playerid][E_ASSAULT] = -1;
	editClassData[4][playerid][E_LONGRIFLE] = -1;

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
					format(weaponList, sizeof(weaponList), "Golf Club\nNite Stick\nKnife (200 score)\nBaseball Bat\nShovel\nPool Cue\nKatana (1,000 score)\nCane\nFlowers\nPurple Dildo (10,000 score)");
					ShowPlayerDialog(playerid, DIALOG_CLASS_MELEE, DIALOG_STYLE_LIST, "Select a melee weapon", weaponList, "Select", "Cancel");
				}

				case 1: // Thrown weapons (grenades etc)
				{
					format(weaponList, sizeof(weaponList), "Frag Grenade\nMolotov Cocktail");
					ShowPlayerDialog(playerid, DIALOG_CLASS_THROWN, DIALOG_STYLE_LIST, "Select a thrown weapon", weaponList, "Select", "Cancel");
				}

				case 2: // Handguns
				{
					format(weaponList, sizeof(weaponList), "Desert Eagle\nSilenced Pistol\nColt 45");
					ShowPlayerDialog(playerid, DIALOG_CLASS_HANDGUN, DIALOG_STYLE_LIST, "Select a handgun", weaponList, "Select", "Cancel");
				}

				case 3: // Shotguns
				{
					format(weaponList, sizeof(weaponList), "Pump shotgun (100 score)\nSawn-Off shotgun (500 score)\nCombat shotgun (1,000 score)");
					ShowPlayerDialog(playerid, DIALOG_CLASS_SHOTGUN, DIALOG_STYLE_LIST, "Select a shotgun", weaponList, "Select", "Cancel");
				}

				case 4: // Sub machineguns.
				{
					format(weaponList, sizeof(weaponList), "Micro Uzi\nMP5\nTEC-9");
					ShowPlayerDialog(playerid, DIALOG_CLASS_SMG, DIALOG_STYLE_LIST, "Select a submachine gun", weaponList, "Select", "Cancel");
				}

				case 5: // Assault rifles.
				{
					format(weaponList, sizeof(weaponList), "AK47\nM4");
					ShowPlayerDialog(playerid, DIALOG_CLASS_ASSAULT, DIALOG_STYLE_LIST, "Select an assault rifle", weaponList, "Select", "Cancel");
				}

				case 6: // Long rifles (such as sniper rifle)
				{
					format(weaponList, sizeof(weaponList), "Sniper Rifle\nCountry Rifle");
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

				}
				case 1: // Nite Stick
				{

				}
				case 2: // Knife
				{

				}
				case 3: // Baseball bat
				{

				}
				case 4: // Shovel
				{

				}
				case 5: // Pool Cue
				{

				}
				case 6: // Katana
				{

				}
				case 7: // Cane
				{

				}
				case 8: // Flowers
				{

				}
				case 9: // Purple dildo
				{

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