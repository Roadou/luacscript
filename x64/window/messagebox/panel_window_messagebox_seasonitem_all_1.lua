function PaGlobal_MessageBox_SeasonItem_All:initialize()
  if true == PaGlobal_MessageBox_SeasonItem_All._initialize or nil == Panel_Window_MessageBox_SeasonItem_All then
    return
  end
  self._ui.btn_close = UI.getChildControl(Panel_Window_MessageBox_SeasonItem_All, "Button_Close")
  self._ui.stc_mainImg = UI.getChildControl(Panel_Window_MessageBox_SeasonItem_All, "Static_image")
  self._ui.stc_mainText = UI.getChildControl(Panel_Window_MessageBox_SeasonItem_All, "MultilineText_Only_Season")
  self._ui.stc_consoleGuide = UI.getChildControl(Panel_Window_MessageBox_SeasonItem_All, "Static_BottomBg_ConsoleUI")
  self._ui.stc_mainText:SetTextMode(__eTextMode_AutoWrap)
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_MessageBox_SeasonItem_All:validate()
  PaGlobal_MessageBox_SeasonItem_All:registEventHandler()
  PaGlobal_MessageBox_SeasonItem_All:swichPlatform(self._isConsole)
  PaGlobal_MessageBox_SeasonItem_All._initialize = true
end
function PaGlobal_MessageBox_SeasonItem_All:swichPlatform(isConsole)
  if true == isConsole then
    self._ui.btn_close:SetShow(false)
    self._ui.stc_consoleGuide:SetShow(true)
    local consoleGuideB = UI.getChildControl(self._ui.stc_consoleGuide, "StaticText_B_ConsoleUI")
    local tempBtnGroup = {consoleGuideB}
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui.stc_consoleGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  else
    self._ui.btn_close:SetShow(true)
    self._ui.stc_consoleGuide:SetShow(false)
  end
end
function PaGlobal_MessageBox_SeasonItem_All:prepareOpen()
  if nil == Panel_Window_MessageBox_SeasonItem_All then
    return
  end
  local selfPlayer = getSelfPlayer():get()
  if selfPlayer == nil or selfPlayer:isSeasonCharacter() == false then
    return
  end
  self._mousePosX = getMousePosX()
  self._mousePosY = getMousePosY()
  PaGlobal_MessageBox_SeasonItem_All:open()
  PaGlobal_MessageBox_SeasonItem_All:update()
  PaGlobal_MessageBox_SeasonItem_All:resize()
end
function PaGlobal_MessageBox_SeasonItem_All:dataclear()
end
function PaGlobal_MessageBox_SeasonItem_All:open()
  if nil == Panel_Window_MessageBox_SeasonItem_All then
    return
  end
  Panel_Window_MessageBox_SeasonItem_All:SetShow(true)
end
function PaGlobal_MessageBox_SeasonItem_All:prepareClose()
  if nil == Panel_Window_MessageBox_SeasonItem_All then
    return
  end
  PaGlobal_MessageBox_SeasonItem_All:close()
end
function PaGlobal_MessageBox_SeasonItem_All:close()
  if nil == Panel_Window_MessageBox_SeasonItem_All then
    return
  end
  Panel_Window_MessageBox_SeasonItem_All:SetShow(false)
end
function PaGlobal_MessageBox_SeasonItem_All:update()
end
function PaGlobal_MessageBox_SeasonItem_All:registEventHandler()
  if nil == Panel_Window_MessageBox_SeasonItem_All then
    return
  end
  Panel_Window_MessageBox_SeasonItem_All:ignorePadSnapMoveToOtherPanel()
  self._ui.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_MessageBox_SeasonItem_All_Close()")
  registerEvent("onScreenResize", "FromClient_MessageBox_SeasonItem_All_OnScreenResize")
end
function PaGlobal_MessageBox_SeasonItem_All:validate()
  if nil == Panel_Window_MessageBox_SeasonItem_All then
    return
  end
end
function PaGlobal_MessageBox_SeasonItem_All:resize()
  if nil == Panel_Window_MessageBox_SeasonItem_All then
    return
  end
  FGlobal_PanelRepostionbyScreenOut(Panel_Window_MessageBox_SeasonItem_All)
end
