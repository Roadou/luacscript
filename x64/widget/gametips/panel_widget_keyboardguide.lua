PaGlobal_KeyboardGuideButton = {
  _ui = {stc_btn = nil}
}
registerEvent("FromClient_luaLoadComplete", "PaGlobal_KeyboardGuideButton_Init")
function PaGlobal_KeyboardGuideButton_Init()
  if nil == Panel_Widget_KeyboardGuide then
    return
  end
  PaGlobal_KeyboardGuideButton:Init()
end
function PaGlobal_KeyboardGuideButton:Init()
  if nil == Panel_Widget_KeyboardGuide then
    return
  end
  Panel_Widget_KeyboardGuide:SetShow(false)
  self._ui.stc_btn = UI.getChildControl(Panel_Widget_KeyboardGuide, "Button_KeyboardGuide")
  self._ui.stc_btn:addInputEvent("Mouse_LUp", "PaGlobal_KeyboardGuideButton:LClick()")
  self._ui.stc_btn:addInputEvent("Mouse_RUp", "PaGlobal_KeyboardGuideButton:RClick()")
  self._ui.stc_btn:addInputEvent("Mouse_On", "PaGlobal_KeyboardGuideButton_Tooltip(true)")
  self._ui.stc_btn:addInputEvent("Mouse_Out", "PaGlobal_KeyboardGuideButton_Tooltip(false)")
  PaGlobal_KeyboardGuideButton:Open()
  registerEvent("onScreenResize", "PaGlobal_KeyboardGuideButton_Position")
end
function PaGlobal_KeyboardGuideButton:LClick()
  if nil ~= FGlobal_KeyboardHelpShow then
    FGlobal_KeyboardHelpShow()
  end
end
function PaGlobal_KeyboardGuideButton:RClick()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBoolNoSave(__eNewbieCommandGuideHelperShowToday, true)
  PaGlobal_KeyboardGuideButton:Close()
end
function PaGlobal_KeyboardGuideButton_Tooltip(isShow)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  name = ""
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_KEYBOARDHELP_BUTTON_TOOLTIP")
  control = Panel_Widget_KeyboardGuide
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_KeyboardGuideButton_Position()
  if nil == Panel_Widget_KeyboardGuide then
    return
  end
  Panel_Widget_KeyboardGuide:SetPosX(getScreenSizeX() - FGlobal_Panel_Radar_GetSizeX() - Panel_Widget_KeyboardGuide:GetSizeX() - 15)
  Panel_Widget_KeyboardGuide:SetPosY(FGlobal_Panel_Radar_GetPosY() + Panel_Widget_KeyboardGuide:GetSizeY() + 120)
end
function PaGlobal_KeyboardGuideButton:Open()
  if nil == Panel_Widget_KeyboardGuide then
    return
  end
  if getSelfPlayer() == nil then
    return false
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
  if userType ~= 2 then
    return
  end
  local cache = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBoolNoSave(__eNewbieCommandGuideHelperShowToday)
  if cache ~= nil and cache == true then
    return
  end
  PaGlobal_KeyboardGuideButton._ui.stc_btn:EraseAllEffect()
  PaGlobal_KeyboardGuideButton._ui.stc_btn:AddEffect("fUI_Shortcut_Key_01A", true, 0, 0)
  Panel_Widget_KeyboardGuide:SetShow(true)
  PaGlobal_KeyboardGuideButton_Position()
end
function PaGlobal_KeyboardGuideButton:Close()
  Panel_Widget_KeyboardGuide:SetShow(false)
end
