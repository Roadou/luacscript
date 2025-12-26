function PaGlobal_AbyssOneJoinGuide:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_Bg = UI.getChildControl(Panel_AbyssOne_Help, "Static_Bg")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_Bg, "Button_CloseWindow")
  self._ui._txt_title = UI.getChildControl(self._ui._stc_Bg, "StaticText_ShortTitle")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_Bg, "MultilineText_Desc")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_AbyssOneJoinGuide:registEventHandler()
  if Panel_AbyssOne_Help == nil then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_AbyssOneJoinGuide:prepareClose()")
  self._ui._btn_close:SetShow(_ContentsGroup_RenewUI == false)
  if self._isConsole == true then
    Panel_AbyssOne_Help:ignorePadSnapMoveToOtherPanel()
  end
end
function PaGlobal_AbyssOneJoinGuide:prepareOpen()
  if Panel_AbyssOne_Help == nil then
    return
  end
  self:recalcPanelPosition()
  self:open()
end
function PaGlobal_AbyssOneJoinGuide:open()
  if Panel_AbyssOne_Help == nil then
    return
  end
  audioPostEvent_SystemUi(33, 1)
  _AudioPostEvent_SystemUiForXBOX(33, 1)
  Panel_AbyssOne_Help:SetShow(true)
end
function PaGlobal_AbyssOneJoinGuide:prepareClose()
  if Panel_AbyssOne_Help == nil then
    return
  end
  self._showFlag = false
  self:close()
end
function PaGlobal_AbyssOneJoinGuide:close()
  if Panel_AbyssOne_Help == nil then
    return
  end
  Panel_AbyssOne_Help:SetShow(false)
end
function PaGlobal_AbyssOneJoinGuide:validate()
  if Panel_AbyssOne_Help == nil then
    return
  end
  self._ui._stc_Bg:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._txt_title:isValidate()
  self._ui._txt_desc:isValidate()
end
function PaGlobal_AbyssOneJoinGuide:recalcPanelPosition()
  local panel = Panel_AbyssOne_Help
  if panel == nil then
    return
  end
  local screenCenterX = getScreenSizeX() / 2
  local screenCenterY = getScreenSizeY() / 2
  local posX = screenCenterX - panel:GetSizeX() / 2
  local posY = screenCenterY - panel:GetSizeY() / 2
  Panel_AbyssOne_Help:SetPosX(posX)
  Panel_AbyssOne_Help:SetPosY(posY)
  Panel_AbyssOne_Help:ComputePosAllChild()
end
function PaGlobal_AbyssOneJoinGuide_SetOnShowFlag()
  local self = PaGlobal_AbyssOneJoinGuide
  if self == nil then
    return
  end
  self._showFlag = true
end
function PaGlobal_AbyssOneJoinGuide_Update(deltaTime)
  local self = PaGlobal_AbyssOneJoinGuide
  if self == nil or Panel_AbyssOne_Help == nil then
    return
  end
  if self._showFlag == false then
    return
  end
  local currentUIMode = GetUIMode()
  if currentUIMode ~= Defines.UIMode.eUIMode_Default then
    return
  end
  self:prepareOpen()
  self._showFlag = false
end
