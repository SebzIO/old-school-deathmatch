/*
					  /$$$$$$   /$$$$$$  /$$$$$$$  /$$      /$$
					 /$$__  $$ /$$__  $$| $$__  $$| $$$    /$$$
					| $$  \ $$| $$  \__/| $$  \ $$| $$$$  /$$$$
					| $$  | $$|  $$$$$$ | $$  | $$| $$ $$/$$ $$
					| $$  | $$ \____  $$| $$  | $$| $$  $$$| $$
					| $$  | $$ /$$  \ $$| $$  | $$| $$\  $ | $$
					|  $$$$$$/|  $$$$$$/| $$$$$$$/| $$ \/  | $$
					 \______/  \______/ |_______/ |__/     |__/ 

//-------------------------[VARIABLES.PWN]--------------------------------


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

 //================ SPECTATION RELATED VARIABLES =======

new Float:SpecX[MAX_PLAYERS], Float:SpecY[MAX_PLAYERS], Float:SpecZ[MAX_PLAYERS], vWorld[MAX_PLAYERS], Inter[MAX_PLAYERS];
new IsSpecing[MAX_PLAYERS], IsBeingSpeced[MAX_PLAYERS], spectatorid[MAX_PLAYERS];

//=====================================================

// Random messages.
new RandomMSG[][] =
{
    "{00FF00}Did you know?: {FFFFFF}You can use /help to see all of our server commands for players!",
    "{00FF00}Did you know?: {FFFFFF}Old School Deathmatch has a discord server! There's a link to the server on our forums.",
    "{00FF00}Did you know?: {FFFFFF}Old School Deathmatch prototype was developed in December, 2015.",
    "{00FF00}Did you know?: {FFFFFF}You can view another player's stats by double clicking their name in your tab list.",
    "{00FF00}Did you know?: {FFFFFF}You can register an account on our forums at www.forum.osdm.xyz."
};

new gTeam[MAX_PLAYERS]; // Player team

new aDuty[MAX_PLAYERS]; // Admin duty

//=====================================================

//============================BUST AIM ================

new ids[MAX_PLAYERS]; //Needs to be reset on OnPlayerConnect

//=====================================================

// GangZones (streamer)
new gangZoneIdleGas; // Idlewood Gas Station

// =====================