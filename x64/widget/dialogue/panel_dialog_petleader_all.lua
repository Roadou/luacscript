PaGlobal_DialogPetLeader_All = {
  _ui = {
    stc_SlotBg = nil,
    stc_PetSlotEmpty = nil,
    stc_PetSlot = nil,
    stc_ItemSlot = nil,
    stc_ResultSlot = nil,
    stc_SkillDesc = nil,
    txt_SkillTitle = nil,
    txt_Empty = nil,
    stc_SkillBg = nil,
    stc_UpgradeBg = nil,
    stc_SkillSubBg = nil,
    txt_LeaderSkillDesc = nil,
    txt_BaseSkill = nil,
    stc_UpgradeIcon = nil,
    txt_BaseSkillDesc = nil,
    txt_DescBox = nil,
    txt_Desc = nil,
    btn_Training = nil
  },
  _ui_pc = {
    btn_Exit = nil,
    btn_Question = nil,
    btn_Training = nil
  },
  _isUpgradeStart = false,
  _upgradeStartDelayTime = 0,
  _upgradeSealIndex = nil,
  _upgradeInvenSlotNo = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_PetLeader_All_1.lua")
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_PetLeader_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_DialogPetLeader_All_Init")
function FromClient_DialogPetLeader_All_Init()
  PaGlobal_DialogPetLeader_All:initialize()
end
