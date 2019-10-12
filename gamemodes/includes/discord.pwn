/*
					  /$$$$$$   /$$$$$$  /$$$$$$$  /$$      /$$
					 /$$__  $$ /$$__  $$| $$__  $$| $$$    /$$$
					| $$  \ $$| $$  \__/| $$  \ $$| $$$$  /$$$$
					| $$  | $$|  $$$$$$ | $$  | $$| $$ $$/$$ $$
					| $$  | $$ \____  $$| $$  | $$| $$  $$$| $$
					| $$  | $$ /$$  \ $$| $$  | $$| $$\  $ | $$
					|  $$$$$$/|  $$$$$$/| $$$$$$$/| $$ \/  | $$
					 \______/  \______/ |_______/ |__/     |__/ 

//-------------------------[DISCORD.PWN]--------------------------------


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

 // Discord-Command

DISCORD:cmds(DCC_Channel: channel, DCC_User: author, params[]) {

    new
        DCC_ChannelType: channel_type
    ;

    DCC_GetChannelType(channel, channel_type);

    if (channel_type == DM) {

        return 1;
    }

    DCC_SendChannelMessage(channel, "Commands: `!cmds`, `!ip`");

    return 1;
}

DISCORD:ip(DCC_Channel: channel, DCC_User: author, params[]) {

    new
        DCC_ChannelType: channel_type
    ;

    DCC_GetChannelType(channel, channel_type);

    if (channel_type == DM) {

        return 1;
    }

    DCC_SendChannelMessage(channel, "IP: `osdm.xyz:7777`");

    return 1;
}

// =======================================================