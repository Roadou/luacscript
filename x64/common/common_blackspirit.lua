local UIMode = Defines.UIMode
local IM = CppEnums.EProcessorInputMode
function appear_blackSpirit(questNo, blackSpiritUIType)
  ToClient_SaveUiInfo(false)
  close_WindowPanelList()
  local preUIMode = GetUIMode()
  SetUIMode(UIMode.eUIMode_NpcDialog_Dummy)
  local callSummon = RequestAppearBlackSpirit(questNo, blackSpiritUIType)
  if callSummon then
    PaGlobalFunc_DialogMain_All_ShowToggle(false)
    PaGlobal_DialogMain_All._renderMode:set()
    ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_OPEN_BLACKSPIRIT")
  else
    SetUIMode(preUIMode)
    ToClient_PopBlackSpiritFlush()
    PaGlobalFunc_DialogMain_All_ShowToggle(false)
  end
end
function FromClient_CloseWindowPanelList()
  close_attacked_WindowPanelList(true)
end
function FromClient_ClosePanelList()
  if _ContentsGroup_ShowOtherClassSkill == true then
    PaGlobalFunc_SkillGroup_All_Close()
  else
    PaGlobalFunc_SkillGroup_CloseRenderMode()
  end
  Panel_Knowledge_Hide()
  InGameShop_Close()
  ToClient_PopBlackSpiritFlush()
end
registerEvent("appear_blackSpirit", "appear_blackSpirit")
registerEvent("FromClient_CloseWindowPanelList", "FromClient_CloseWindowPanelList")
registerEvent("FromClient_ClosePanelList", "FromClient_ClosePanelList")
