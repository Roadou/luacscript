function PaGlobal_YachtDice_FindingMatch:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_matchingBg = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_FindingMatch, "Static_MatchingWaiting")
  self._ui._txt_matchingState = UI.getChildControl(self._ui._stc_matchingBg, "StaticText_Loading")
  self._ui._btn_cancel = UI.getChildControl(self._ui._stc_matchingBg, "Button_Cancel")
  self._ui._txt_matchingElapsedTime = UI.getChildControl(self._ui._stc_matchingBg, "StaticText_Time")
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_YachtDice_FindingMatch:registEventHandler()
  if Panel_Widget_MiniGame_YachtDice_FindingMatch == nil then
    return
  end
  self._ui._btn_cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_YachtDice_FindingMatch_Cancel()")
  registerEvent("FromClient_ChangeYachtDiceMatchState", "FromClient_YachtDice_FindingMatch_ChangeMatchState")
end
function PaGlobal_YachtDice_FindingMatch:prepareOpen()
  if Panel_Widget_MiniGame_YachtDice_FindingMatch == nil then
    return
  end
  self._ui._txt_matchingElapsedTime:SetText("")
  self._currentElapsedTime = 0
  self._currentDeltaTime = 0
  self._ui._stc_matchingBg:EraseAllEffect()
  self._ui._stc_matchingBg:AddEffect("fUI_Solrare_Start_01A", true, 16, 1)
  self:open()
end
function PaGlobal_YachtDice_FindingMatch:open()
  if Panel_Widget_MiniGame_YachtDice_FindingMatch == nil then
    return
  end
  Panel_Widget_MiniGame_YachtDice_FindingMatch:ComputePos()
  Panel_Widget_MiniGame_YachtDice_FindingMatch:RegisterUpdateFunc("PaGlobalFunc_YachtDice_FindingMatch_Update")
  Panel_Widget_MiniGame_YachtDice_FindingMatch:SetShow(true)
end
function PaGlobal_YachtDice_FindingMatch:prepareClose()
  if Panel_Widget_MiniGame_YachtDice_FindingMatch == nil then
    return
  end
  self:close()
end
function PaGlobal_YachtDice_FindingMatch:close()
  if Panel_Widget_MiniGame_YachtDice_FindingMatch == nil then
    return
  end
  Panel_Widget_MiniGame_YachtDice_FindingMatch:ClearUpdateLuaFunc()
  Panel_Widget_MiniGame_YachtDice_FindingMatch:SetShow(false)
end
