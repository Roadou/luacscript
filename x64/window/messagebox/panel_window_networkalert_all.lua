PaGlobal_NetworkAlert = {
  _ui = {
    stc_titleArea = nil,
    stc_blackBG = nil,
    txt_title = nil,
    txt_desc = nil,
    btn_exit = nil
  },
  _customArgument = 0,
  _isPadSnapping = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_NetworkAlertInit")
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_NetworkAlertInit")
function FromClient_NetworkAlertInit()
  PaGlobal_NetworkAlert:initialize()
end
function PaGlobal_NetworkAlert:initialize()
  if Panel_Window_NetworkAlert_All == nil then
    return
  end
  if self._initialize == true then
    return
  end
  self._ui.stc_titleArea = UI.getChildControl(Panel_Window_NetworkAlert_All, "Static_TitleArea")
  self._ui.stc_blackBG = UI.getChildControl(Panel_Window_NetworkAlert_All, "Static_CircleBG")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_titleArea, "StaticText_TItle")
  self._ui.txt_desc = UI.getChildControl(Panel_Window_NetworkAlert_All, "MultilineText_Desc")
  self._ui.btn_exit = UI.getChildControl(Panel_Window_NetworkAlert_All, "Button_Exit")
  self:registerEventHandler()
  self:validate()
  self._isPadSnapping = _ContentsGroup_UsePadSnapping
  self._initialize = true
end
function PaGlobal_NetworkAlert:registerEventHandler()
  registerEvent("FromClient_OpenNetworkAlert", "FromClient_OpenNetworkAlert")
  self._ui.btn_exit:addInputEvent("Mouse_LUp", "exitGameClient(true)")
end
function PaGlobal_NetworkAlert:prepareOpen()
  if Panel_Window_NetworkAlert_All == nil then
    return
  end
  self:update()
  self:open()
end
function PaGlobal_NetworkAlert:open()
  if Panel_Window_NetworkAlert_All == nil then
    return
  end
  Panel_Window_NetworkAlert_All:SetShow(true)
end
function PaGlobal_NetworkAlert:prepareClose()
  if Panel_Window_NetworkAlert_All == nil then
    return
  end
  self:close()
end
function PaGlobal_NetworkAlert:close()
  if Panel_Window_NetworkAlert_All == nil then
    return
  end
  Panel_Window_NetworkAlert_All:SetShow(false)
end
function PaGlobal_NetworkAlert:update()
  if Panel_Window_NetworkAlert_All == nil then
    return
  end
  if PanelCloseFunc_Skill ~= nil then
    PanelCloseFunc_Skill()
  end
  if PaGlobalFunc_Finish_WorldBossItemLooting ~= nil then
    PaGlobalFunc_Finish_WorldBossItemLooting()
  end
  if PaGlobal_DeadMessage_All ~= nil then
    PaGlobal_DeadMessage_All:closeChannelMoveWindow()
  end
  if close_attacked_WindowPanelList ~= nil then
    close_attacked_WindowPanelList(true)
  end
  local screenX = getResolutionSizeX()
  local screenY = getResolutionSizeY()
  self._ui.stc_blackBG:SetSize(screenX + 500, screenY + 500)
  self._ui.stc_blackBG:ComputePos()
  local title = PAGetString(Defines.StringSheet_GAME, "LUA_NEWGAMEOPTION_Function_Alert")
  local content = PAGetString(Defines.StringSheet_GAME, "LUA_GAME_INTERNET_STATE")
  self._ui.txt_title:SetText(title)
  self._ui.txt_desc:SetText(content)
end
function PaGlobal_NetworkAlert:computePos()
  if Panel_Window_NetworkAlert_All == nil then
    return
  end
  local screenX = getResolutionSizeX()
  local screenY = getResolutionSizeY()
  self._ui.stc_blackBG:SetSize(screenX, screenY)
  Panel_Window_NetworkAlert_All:ComputePosAllChild()
  self._ui.txt_desc:SetSize(self._ui.txt_desc:GetSizeX(), self._ui.txt_desc:GetTextSizeY())
  Panel_Window_NetworkAlert_All:SetSize(Panel_Window_NetworkAlert_All:GetSizeX(), self._ui.txt_title:GetSizeY() + self._ui.txt_desc:GetSizeY() + 70)
  self._ui.btn_exit:SetPosY(self._ui.txt_desc:GetPosY() + self._ui.txt_desc:GetSizeY() + 8)
end
function FromClient_OpenNetworkAlert(isShow)
  if isShow == true then
    PaGlobal_NetworkAlert:prepareOpen()
  else
    PaGlobal_NetworkAlert:prepareClose()
  end
end
function PaGlobal_NetworkAlert:validate()
  if Panel_Window_NetworkAlert_All == nil then
    return
  end
  self._ui.stc_titleArea:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui.btn_exit:isValidate()
end
function HandleEventLUp_ConfirmExitButton()
  if Panel_Window_NetworkAlert_All == nil then
    return
  end
  PaGlobal_NetworkAlert:prepareClose()
end
