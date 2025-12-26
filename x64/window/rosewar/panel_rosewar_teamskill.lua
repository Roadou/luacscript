PaGlobal_RoseWarSkillList = {
  __eRoseWarSkillType_Scan,
  __eRoseWarSkillType_Recall,
  __eRoseWarSkillType_Bombard,
  __eRoseWarSkillType_Summon,
  __eRoseWarSkillType_Conceal,
  __eRoseWarSkillType_Zonya,
  __eRoseWarSkillType_FixedResurrection
}
PaGlobal_RoseWarTeamSkill = {
  _ui = {
    _stc_bg = nil,
    _stc_skillList = nil,
    _stc_lineDeco = nil
  },
  _skillSlotConfig = {
    createIcon = true,
    createEffect = false,
    createFG = false,
    createFGDisabled = false,
    createLevel = false,
    createLearnButton = false,
    createCooltime = true,
    createCooltimeText = true
  },
  _initialize = false,
  _isMakeSkillButton = false
}
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_TeamSkill_1.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_TeamSkill_2.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_TeamSkill_3.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_TeamSkill_4.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RoseWarTeamSkillInit")
function FromClient_RoseWarTeamSkillInit()
  PaGlobal_RoseWarTeamSkill:initialize()
end
