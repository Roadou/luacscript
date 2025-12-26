function PaGlobal_WareHouseFunctionPanel_All:initialize()
  if Panel_WareHouseFunctionPanel_All == nil or _ContentsGroup_UsePadSnapping == false then
    return
  end
  self._ui.stc_TitleBg = UI.getChildControl(Panel_WareHouseFunctionPanel_All, "Static_TitleArea")
  self._ui.stc_MainBg = UI.getChildControl(Panel_WareHouseFunctionPanel_All, "Static_MainArea")
  self._ui.btn_FucntionTemp = UI.getChildControl(self._ui.stc_MainBg, "Button_FunctionButton_Temp")
  self._ui.stc_ConsoleKeyGuide = UI.getChildControl(Panel_WareHouseFunctionPanel_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_ConsoleKeyGuide, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_ConsoleKeyGuide, "StaticText_B_ConsoleUI")
  self._originPanelSize = Panel_WareHouseFunctionPanel_All:GetSizeY()
  self._ui.btn_FucntionTemp:SetShow(false)
  self._ui.stc_ConsoleKeyGuide:SetShow(_ContentsGroup_UsePadSnapping)
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobalFunc_ConsoleKeyGuide_SetAlign({
      self._ui.stc_KeyGuide_A,
      self._ui.stc_KeyGuide_B
    }, self._ui.stc_ConsoleKeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  PaGlobal_WareHouseFunctionPanel_All:registerEvent()
  PaGlobal_WareHouseFunctionPanel_All:validate()
  PaGlobal_WareHouseFunctionPanel_All:createMenuBtn()
end
function PaGlobal_WareHouseFunctionPanel_All:validate()
  self._ui.stc_MainBg:isValidate()
  self._ui.btn_FucntionTemp:isValidate()
  self._ui.stc_ConsoleKeyGuide:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
end
function PaGlobal_WareHouseFunctionPanel_All:registerEvent()
end
function PaGlobal_WareHouseFunctionPanel_All:createMenuBtn()
  local startPosY = self._ui.btn_FucntionTemp:GetPosY()
  local startPosX = self._ui.btn_FucntionTemp:GetPosX() - self._ui.btn_FucntionTemp:GetSizeX() / 2 - 5
  for idx = 0, self._menuCount - 1 do
    local btn = UI.cloneControl(self._ui.btn_FucntionTemp, self._ui.stc_MainBg, "Static_FuncBtn_" .. idx)
    btn:SetPosY(startPosY + (self._ui.btn_FucntionTemp:GetSizeY() + 10) * idx)
    btn:SetPosX(startPosX + 10)
    btn:SetShow(true)
    self._funcBtnTable[idx] = btn
  end
end
function PaGlobal_WareHouseFunctionPanel_All:dataClear()
  if nil ~= self._funcBtnTable then
    for idx = 0, self._menuCount - 1 do
      self._funcBtnTable[idx]:SetText("")
      self._funcBtnTable[idx]:SetShow(false)
      self._funcBtnTable[idx]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    end
  end
  self._enabledBtnCount = 0
end
function PaGlobal_WareHouseFunctionPanel_All:prepareOpen()
  PaGlobal_WareHouseFunctionPanel_All:dataClear()
  PaGlobal_WareHouseFunctionPanel_All:SetWareHouseInfoBtnMenu()
  local titleSizeY = self._ui.stc_TitleBg:GetSizeY()
  local btnSize = math.floor((self._enabledBtnCount + 1) / 2) * (self._ui.btn_FucntionTemp:GetSizeY() + 10) + self._ui.btn_FucntionTemp:GetSizeY() + 10
  local panelY = math.max(self._originPanelSize, btnSize)
  Panel_WareHouseFunctionPanel_All:SetSize(self._ui.btn_FucntionTemp:GetSizeX() + 50, panelY)
  self._ui.stc_MainBg:SetSize(Panel_WareHouseFunctionPanel_All:GetSizeX(), panelY - titleSizeY)
  self._ui.stc_ConsoleKeyGuide:SetSize(Panel_WareHouseFunctionPanel_All:GetSizeX(), self._ui.stc_ConsoleKeyGuide:GetSizeY())
  Panel_WareHouseFunctionPanel_All:SetPosX(Panel_Window_Warehouse:GetPosX() + Panel_Window_Warehouse:GetSizeX() / 2 - Panel_WareHouseFunctionPanel_All:GetSizeX() / 2)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign({
    self._ui.stc_KeyGuide_A,
    self._ui.stc_KeyGuide_B
  }, self._ui.stc_ConsoleKeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  Panel_WareHouseFunctionPanel_All:ignorePadSnapMoveToOtherPanel()
  PaGlobal_WareHouseFunctionPanel_All:open()
end
function PaGlobal_WareHouseFunctionPanel_All:open()
  Panel_WareHouseFunctionPanel_All:SetShow(true)
end
function PaGlobal_WareHouseFunctionPanel_All:prepareClose()
  Panel_WareHouseFunctionPanel_All:SetShow(false)
end
function PaGlobal_WareHouseFunctionPanel_All:SetWareHouseInfoBtnMenu()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local infoBtnList = {
    [0] = self._eFuncType.autoMoveCurrentWay,
    [1] = self._eFuncType.autoMoveAllWay,
    [2] = self._eFuncType.autoMoveException
  }
  for ii = 0, #infoBtnList do
    self:SetButton(infoBtnList[ii])
  end
end
function PaGlobal_WareHouseFunctionPanel_All:SetButton(btnType)
  if nil == self._funcBtnTable then
    return
  end
  local btnText = self._btnString[btnType]
  self._funcBtnTable[self._enabledBtnCount]:SetText(btnText)
  self._funcBtnTable[self._enabledBtnCount]:SetShow(true)
  if _ContentsGroup_ProjectAbyssOne == false and isGameServiceTypeConsole() == false then
    local startPosX = self._ui.btn_FucntionTemp:GetPosX()
    if self._eFuncType.autoMoveAllWay == btnType then
      self._funcBtnTable[self._enabledBtnCount]:SetShow(false)
    end
    if self._eFuncType.autoMoveException == btnType then
      self._funcBtnTable[self._enabledBtnCount]:SetPosY(self._funcBtnTable[self._enabledBtnCount - 1]:GetPosY())
    end
  end
  self._funcBtnTable[self._enabledBtnCount]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventPadPress_WareHouseFunctionPanel_All_PressHouseInfoFunc(" .. btnType .. ")")
  self._enabledBtnCount = self._enabledBtnCount + 1
end
