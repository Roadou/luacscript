function PaGlobal_YachtDice_MatchConfirm:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_RenewUI
  self._ui._txt_Confirm = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_MatchConfirm, "StaticText_Confirm")
  self._ui._stc_ProgressBar = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_MatchConfirm, "Progress2_1")
  local titleBg = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_MatchConfirm, "Static_TitleBg")
  self._ui_pc._btn_Confrim = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_MatchConfirm, "Button_Ok")
  self._ui_pc._btn_Cancel = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_MatchConfirm, "Button_Cancel")
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_MatchConfirm, "Static_KeyGuide_ConsoleUI")
  self._ui_console.txt_KeyGuideA = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Confirm_A")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Refuse_B")
  local keyguides = {
    self._ui_console.txt_KeyGuideA,
    self._ui_console.txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, self._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self._ui._txt_Confirm:SetTextMode(__eTextMode_AutoWrap)
  self:registEventHandler()
  self:swichPlatform()
  self._initialize = true
end
function PaGlobal_YachtDice_MatchConfirm:registEventHandler()
  if Panel_Widget_MiniGame_YachtDice_MatchConfirm == nil then
    return
  end
  self._ui_pc._btn_Confrim:addInputEvent("Mouse_LUp", "HandleEventLUp_YachtDice_MatchConfirm()")
  self._ui_pc._btn_Cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_YachtDice_MatchRefuse()")
  registerEvent("FromClient_ChangeYachtDiceMatchState", "FromClient_YachtDice_MatchConfirm_ChangeMatchState")
end
function PaGlobal_YachtDice_MatchConfirm:swichPlatform()
  if Panel_Widget_MiniGame_YachtDice_MatchConfirm == nil then
    return
  end
  for _, control in pairs(self._ui_pc) do
    control:SetShow(self._isConsole == false)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole == true)
  end
end
function PaGlobal_YachtDice_MatchConfirm:prepareOpen()
  if Panel_Widget_MiniGame_YachtDice_MatchConfirm == nil then
    return
  end
  if Panel_Window_GameExit_All ~= nil and Panel_Window_GameExit_All:GetShow() == true then
    PaGlobal_GameExit_All_Close(true)
  end
  self._isReq = false
  self._deltaTime = 0
  self:open()
end
function PaGlobal_YachtDice_MatchConfirm:open()
  if Panel_Widget_MiniGame_YachtDice_MatchConfirm == nil then
    return
  end
  audioPostEvent_SystemUi(30, 7)
  _AudioPostEvent_SystemUiForXBOX(30, 7)
  Panel_Widget_MiniGame_YachtDice_MatchConfirm:ComputePos()
  Panel_Widget_MiniGame_YachtDice_MatchConfirm:SetEnable(true)
  Panel_Widget_MiniGame_YachtDice_MatchConfirm:SetMonoTone(false)
  Panel_Widget_MiniGame_YachtDice_MatchConfirm:RegisterUpdateFunc("PaGlobalFunc_YachtDice_MatchConfirm_Update")
  Panel_Widget_MiniGame_YachtDice_MatchConfirm:SetShow(true)
end
function PaGlobal_YachtDice_MatchConfirm:prepareClose()
  if Panel_Widget_MiniGame_YachtDice_MatchConfirm == nil then
    return
  end
  self:close()
end
function PaGlobal_YachtDice_MatchConfirm:close()
  if Panel_Widget_MiniGame_YachtDice_MatchConfirm == nil then
    return
  end
  Panel_Widget_MiniGame_YachtDice_MatchConfirm:ClearUpdateLuaFunc()
  Panel_Widget_MiniGame_YachtDice_MatchConfirm:SetShow(false)
end
