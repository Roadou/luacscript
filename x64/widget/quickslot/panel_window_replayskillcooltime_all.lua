PaGlobal_ReplaySkillCooltime = {
  config = {
    slotGapX = 50,
    slotGapY = 50,
    screenPosX = 0.33,
    screenPosY = 0.42
  },
  slotConfig = {
    createIcon = true,
    createEffect = false,
    createFG = false,
    createFGDisabled = false,
    createLevel = false,
    createLearnButton = false,
    createCooltime = true,
    createCooltimeText = true
  },
  _slot_leftInitPosY = 0,
  _slot_rightInitPosY = 0,
  _slot_rightSkillNameInitPosX = 0,
  slots = {},
  _maxSlotCount = 40,
  _redTeam_skillData = {},
  _blueTeam_skillData = {},
  _initialize = false
}
runLua("UI_Data/Script/Widget/QuickSlot/Panel_Window_ReplaySkillCooltime_All_1.lua")
runLua("UI_Data/Script/Widget/QuickSlot/Panel_Window_ReplaySkillCooltime_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ReplaySkillCooltimeInit")
function FromClient_ReplaySkillCooltimeInit()
  PaGlobal_ReplaySkillCooltime:initialize()
end
