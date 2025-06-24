local PLAYER_EVENT_ON_KILL_CREATURE = 7

local QUEST_ID = 52
local CREATURE_PROWLER_ID = 118
local CREATURE_GRAY_FOREST_WOLF = 1922

local QUEST_STATUS_NONE = 0 -- Quest isn't shown in quest list; default
local QUEST_STATUS_COMPLETE = 1 -- Quest has been completed
local QUEST_STATUS_UNAVAILABLE = 2 -- NOT USED
local QUEST_STATUS_INCOMPLETE = 3 -- Quest is active in quest log but incomplete
local QUEST_STATUS_AVAILABLE = 4 -- NOT USED
local QUEST_STATUS_FAILED = 5 -- 	Player failed to complete the quest

local function OnPlayerKillCreature(event, killer, killed)
	if not killer:IsPlayer() then
		return
	end
	
	local player = killer:ToPlayer()
	local status = player:GetQuestStatus(QUEST_ID)
	
	if status == QUEST_STATUS_COMPLETE then
		return
	elseif status == QUEST_STATUS_INCOMPLETE then
		if player:HasQuest(QUEST_ID) then
			if killed:GetEntry() == CREATURE_GRAY_FOREST_WOLF then
				player:KilledMonsterCredit(CREATURE_PROWLER_ID, true)
			end
		end
	end
end

RegisterPlayerEvent(PLAYER_EVENT_ON_KILL_CREATURE, OnPlayerKillCreature)
