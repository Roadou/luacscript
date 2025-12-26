PaGlobal_SkillGroup_SelectType = {
  _panel = nil,
  _ui = {
    _stc_centerMainArea = nil,
    _stc_bottomBG = nil,
    _stc_bottomSkillArea = nil,
    _stc_bottomSkillAreaBg = nil,
    _stc_bigCharacter = nil,
    _stc_skillTypeTop = nil,
    _stc_skillTypeBottom = nil,
    _txt_title = nil,
    _txt_desc = nil,
    _stc_skillTypeLine = nil,
    _stc_horizonLineTop = nil,
    _stc_horizonLineBottom = nil,
    _stc_combatTypeTitle = nil,
    _stc_Dot1 = nil,
    _stc_Dot2 = nil,
    _txt_weaponTypeTitle = nil,
    _txt_weaponTypeValue = nil,
    _txt_combatTypeTitle = nil,
    _txt_combatTypeValue = nil,
    _stc_skillSlotBg = nil,
    _stc_skillSlot = nil,
    _txt_skillName = nil,
    _txt_skillPoint = nil,
    _btn_confirm = nil,
    _btn_cancel = nil,
    _btn_awakenGuideComplete = nil,
    _stc_centerMainArea = nil,
    _txt_learnSkill = nil,
    _stc_keyGuideBG = nil,
    _txt_keyGuideY = nil,
    _txt_keyGuideA = nil,
    _txt_keyGuideB = nil
  },
  _texturePath = "Combine/Etc/Combine_Etc_Skill_00.dds",
  _originBottomAreaPosY = 0,
  _originBottomBgPosY = 0,
  _originCenterMainAreaSizeY = 0,
  _isAwakenGuide = false,
  _bigCharacterBgBaseSpanX = 0,
  _isConsole = false,
  _treeTypeDataList = {
    [__eSkillTypeParam_Awaken] = {
      _uv = {
        x1 = 518,
        y1 = 212,
        x2 = 599,
        y2 = 422
      },
      _title = "PANEL_STABLESTALLION_AWAKEN",
      _titleSub = "AWAKEN",
      _weaponType = "LUA_SKILL_AWAKEN_WEAPON_NAME"
    },
    [__eSkillTypeParam_Inherit] = {
      _uv = {
        x1 = 518,
        y1 = 1,
        x2 = 599,
        y2 = 211
      },
      _title = "PANEL_SKILL_SUCCESSTIONSKILL_TAB_NAME",
      _titleSub = "SUCCESSION",
      _weaponType = "LUA_SKILL_SUCCESSION_WEAPON_NAME"
    }
  }
}
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_SelectType_1.lua")
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_SelectType_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SkillGroupSelectTypeInit")
function FromClient_SkillGroupSelectTypeInit()
  PaGlobal_SkillGroup_SelectType:init()
end
