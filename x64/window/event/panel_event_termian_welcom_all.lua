PaGlobal_Event_Termian_Welcom_All = {
  _ui = {
    _stc_Black = nil,
    _stc_BG = nil,
    _txt_EventTitle = nil,
    _txt_Desc = nil,
    _btn_Confirm = nil
  },
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Event_Termian_Welcom_All_Init")
function FromClient_Event_Termian_Welcom_All_Init()
  PaGlobal_Event_Termian_Welcom_All:initialize()
end
function PaGlobal_Event_Termian_Welcom_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_Black = UI.getChildControl(Panel_Event_Termian_Welcom_All, "Static_Black")
  self._ui._stc_BG = UI.getChildControl(Panel_Event_Termian_Welcom_All, "Static_Bg")
  self._ui._txt_EventTitle = UI.getChildControl(Panel_Event_Termian_Welcom_All, "StaticText_EventTitle")
  self._ui._txt_Desc = UI.getChildControl(Panel_Event_Termian_Welcom_All, "StaticText_Desc")
  self._ui._btn_Confirm = UI.getChildControl(Panel_Event_Termian_Welcom_All, "Button_Confirm")
  self:validate()
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_Event_Termian_Welcom_All:validate()
  if Panel_Event_Termian_Welcom_All == nil then
    return
  end
  self._ui._stc_Black:isValidate()
  self._ui._stc_BG:isValidate()
  self._ui._txt_EventTitle:isValidate()
  self._ui._txt_Desc:isValidate()
  self._ui._btn_Confirm:isValidate()
end
function PaGlobal_Event_Termian_Welcom_All:registEventHandler()
  if Panel_Event_Termian_Welcom_All == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_Event_Termian_Welcom_All_Resize")
  self._ui._btn_Confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_Event_Termian_Welcom_All_Confirm()")
end
function PaGlobal_Event_Termian_Welcom_All:resize()
  if Panel_Event_Termian_Welcom_All == nil then
    return
  end
  local uiScale = getGlobalScale()
  local sizeX = getResolutionSizeX() / uiScale
  local sizeY = getResolutionSizeY() / uiScale
  self._ui._stc_Black:SetSize(sizeX, sizeY)
  Panel_Event_Termian_Welcom_All:ComputePosAllChild()
  self._ui._stc_Black:SetSpanSize(-Panel_Event_Termian_Welcom_All:GetSpanSize().x, -Panel_Event_Termian_Welcom_All:GetSpanSize().y)
end
function PaGlobal_Event_Termian_Welcom_All:prepareOpen()
  if Panel_Event_Termian_Welcom_All == nil then
    return
  end
  self:resize()
  if ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eHideTermianWelcomBanner) == true then
    return
  end
  self:open()
end
function PaGlobal_Event_Termian_Welcom_All:open()
  if Panel_Event_Termian_Welcom_All == nil then
    return
  end
  if true == isGameTypeGT() then
    return
  end
  Panel_Event_Termian_Welcom_All:SetShow(true)
end
function PaGlobal_Event_Termian_Welcom_All:prepareClose()
  if Panel_Event_Termian_Welcom_All == nil then
    return
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eHideTermianWelcomBanner, true, CppEnums.VariableStorageType.eVariableStorageType_User)
  self:close()
end
function PaGlobal_Event_Termian_Welcom_All:close()
  if Panel_Event_Termian_Welcom_All == nil then
    return
  end
  Panel_Event_Termian_Welcom_All:SetShow(false)
end
function PaGlobalFunc_Event_Termian_Welcom_All_Open()
  PaGlobal_Event_Termian_Welcom_All:prepareOpen()
end
function PaGlobalFunc_Event_Termian_Welcom_All_Close()
  PaGlobal_Event_Termian_Welcom_All:prepareClose()
end
function HandleEventLUp_Event_Termian_Welcom_All_Confirm()
  if Panel_Event_Termian_Welcom_All == nil then
    return
  end
  PaGlobal_Event_Termian_Welcom_All:prepareClose()
end
function FromClient_Event_Termian_Welcom_All_Resize()
  PaGlobal_Event_Termian_Welcom_All:resize()
end
