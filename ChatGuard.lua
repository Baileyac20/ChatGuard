--[[

  ██         ██  █████  ███████ ██    ██ ███    ██  ██████     ██    
 ██         ██  ██   ██ ██       ██  ██  ████   ██ ██           ██  
██         ██   ███████ ███████   ████   ██ ██  ██ ██            ██ 
 ██       ██    ██   ██      ██    ██    ██  ██ ██ ██           ██  
  ██     ██     ██   ██ ███████    ██    ██   ████  ██████     ██   
                                                                    
                     
-- This order was developed by SetAsync.
-- Please contact me if you need any help.
-- The settings for each system are inside the module script which holds all of the scripts for each system (childs of the SetAsync's Systems folder).

-- March / 2024

-- https://www.setasync.me
-- contact@SetAsync.me

--]]

--[[
ORDER SUMMARY:
Λｎｔｉ－Ｂｏｔ
Λｎｔｉ－Ｓｐａｍ
Λｎｔｉ－Ｌｉｎｋｓ　（安け彙）
--]]

local ChatGuard = {}

-- Server Lock
-- How many times a player gets kicked by ChatGuard before it considers the player a threat and stops them
-- from rejoining the current threat.
ChatGuard.ServerLock = 3

-- At what level is a user considered suspicious?
ChatGuard.SuspiciousLevel = 3;

-- At what level should a user be kicked?
ChatGuard.ActionLevel = 5;

-- Define how many levels each offense should contribute to a user.
ChatGuard.Offenses = {
	BotName = 200;
	DiscordLink = 200;
	Spamming = 200;
}

-- ADDITIONAL SETTINGS HAVE NOT BEEN INCLUDED IN THIS OPEN SOURCE ANNOTATION.
return ChatGuard

--[[
           __________                                 
         .'----------`.                              
         | .--------. |                             
         | |########| |       __________              
         | |########| |      /__________\             
.--------| `--------' |------|    --=-- |-------------.
|        `----,-.-----'      |o ======  |             | 
|       ______|_|_______     |__________|             | 
|      /  %%%%%%%%%%%%  \                             | 
|     /  %%%%%%%%%%%%%%  \                            | 
|     ^^^^^^^^^^^^^^^^^^^^                            | 
+-----------------------------------------------------+
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
--]]
