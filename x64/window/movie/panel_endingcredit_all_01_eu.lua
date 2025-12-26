function PaGlobal_EndingCredit:initialize()
  self._ui.stc_ImageArea = UI.getChildControl(Panel_EndingCredit_All, "Static_ImageArea")
  self._ui.stc_G = UI.getChildControl(self._ui.stc_ImageArea, "Static_G")
  self._ui.stc_S = UI.getChildControl(self._ui.stc_ImageArea, "Static_S")
  self._ui.txt_Log = UI.getChildControl(self._ui.stc_ImageArea, "StaticText_LogForDev")
  if ToClient_IsDevelopment() == true then
    self._ui.txt_Log:SetShow(true)
  end
  self._ui.chk_Fast = UI.getChildControl(self._ui.stc_ImageArea, "CheckButton_Fast")
  if isGameServiceTypeConsole() then
    self._ui.chk_Fast:SetShow(false)
  end
  self._ui.stc_CreditArea = UI.getChildControl(Panel_EndingCredit_All, "Static_CreditArea")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_CreditArea, "StaticText_Title")
  self._ui.stc_RectArea = UI.getChildControl(self._ui.stc_CreditArea, "Static_RectArea")
  self._ui.txt_Name_0 = UI.getChildControl(self._ui.stc_RectArea, "StaticText_Name_0")
  self._ui.txt_Name_1 = UI.getChildControl(self._ui.stc_RectArea, "StaticText_Name_1")
  self._ui.txt_Name_2 = UI.getChildControl(self._ui.stc_RectArea, "StaticText_Name_2")
  for index = 0, self._nameControlMaxCount - 1 do
    self._ui.txt_Name[index] = {}
    self._ui.txt_Name[index]._0 = UI.cloneControl(self._ui.txt_Name_0, self._ui.stc_RectArea, "StaticText_Name_" .. index .. "_0")
    self._ui.txt_Name[index]._0:SetPosY(self._ui.txt_Name_0:GetPosY() + index * (self._ui.txt_Name_0:GetSizeY() + 10))
    self._ui.txt_Name[index]._0:SetShow(true)
    self._ui.txt_Name[index]._1 = UI.cloneControl(self._ui.txt_Name_1, self._ui.stc_RectArea, "StaticText_Name_" .. index .. "_1")
    self._ui.txt_Name[index]._1:SetPosY(self._ui.txt_Name_1:GetPosY() + index * (self._ui.txt_Name_1:GetSizeY() + 10))
    self._ui.txt_Name[index]._1:SetShow(true)
    self._ui.txt_Name[index]._2 = UI.cloneControl(self._ui.txt_Name_2, self._ui.stc_RectArea, "StaticText_Name_" .. index .. "_2")
    self._ui.txt_Name[index]._2:SetPosY(self._ui.txt_Name_2:GetPosY() + index * (self._ui.txt_Name_2:GetSizeY() + 10))
    self._ui.txt_Name[index]._2:SetShow(true)
  end
  self._ui.stc_LastCreditArea = UI.getChildControl(Panel_EndingCredit_All, "Static_LastCreditArea")
  self._ui.mul_Desc = UI.getChildControl(self._ui.stc_LastCreditArea, "MultilineText_Desc")
  self._ui.stc_Ci = UI.getChildControl(self._ui.stc_LastCreditArea, "Static_CI")
  self:setNameList()
  local myFamilyName = getFamilyName()
  if nil ~= myFamilyName then
    for index = 0, #self.nameList - 1 do
      if self.nameList[index] == myFamilyName then
        self.nameList[index] = "<PAColor0xfff5ba3a>" .. self.nameList[index] .. "<PAOldColor>"
        break
      end
    end
  end
  self:registEventHandler()
end
function PaGlobal_EndingCredit:registEventHandler()
  self._ui.chk_Fast:addInputEvent("Mouse_LUp", "PaGlobal_EndingCredit_MouseLUp()")
end
function PaGlobal_EndingCredit_MouseLUp()
  local self = PaGlobal_EndingCredit
  if true == self._ui.chk_Fast:IsCheck() then
    self._speedValue = 5
  else
    self._speedValue = 1
  end
end
function PaGlobal_EndingCredit:keyCheck()
  self._ui.chk_Fast:SetCheck(not self._ui.chk_Fast:IsCheck())
  PaGlobal_EndingCredit_MouseLUp()
end
function PaGlobal_EndingCredit:messageBoxOpen()
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MESSAGEBOX_ENDINGCREDIT_DESC"),
    functionYes = PaGlobal_EndingCredit_Close,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
end
function PaGlobal_EndingCredit:preOpen()
  if Panel_EndingCredit_All:GetShow() then
    return
  end
  PaGlobal_EndingCredit:clear()
  PaGlobal_EndingCredit:setData()
  PaGlobal_EndingCredit:open()
end
function PaGlobal_EndingCredit:open()
  Panel_EndingCredit_All:SetShow(true)
  Panel_EndingCredit_All:RegisterUpdateFunc("PaGlobal_EndingCredit_RollAni")
end
function PaGlobal_EndingCredit:preClose()
  Panel_EndingCredit_All:ClearUpdateLuaFunc()
  self._hideTime = 0
  audioPostEvent_SystemUi(54, 2)
  PaGlobal_EndingCredit:close()
end
function PaGlobal_EndingCredit:close()
  Panel_EndingCredit_All:SetShow(false)
end
function PaGlobal_EndingCredit_Open()
  PaGlobal_EndingCredit:preOpen()
end
function PaGlobal_EndingCredit_Close()
  PaGlobal_EndingCredit:preClose()
end
function PaGlobal_EndingCredit:clear()
  self._ui.txt_Title:SetPosY(100 + self._ui.stc_RectArea:GetSizeY())
  for index = 0, self._nameControlMaxCount - 1 do
    self._ui.txt_Name[index]._0:SetPosY(self._ui.txt_Name_0:GetPosY() + index * (self._ui.txt_Name_0:GetSizeY() + 10) + self._ui.stc_RectArea:GetSizeY())
    self._ui.txt_Name[index]._1:SetPosY(self._ui.txt_Name_1:GetPosY() + index * (self._ui.txt_Name_1:GetSizeY() + 10) + self._ui.stc_RectArea:GetSizeY())
    self._ui.txt_Name[index]._2:SetPosY(self._ui.txt_Name_2:GetPosY() + index * (self._ui.txt_Name_2:GetSizeY() + 10) + self._ui.stc_RectArea:GetSizeY())
  end
  self._ui.stc_G:SetShow(false)
  self._ui.stc_S:SetShow(false)
  local screenSizeY = getScreenSizeY()
  self._ui.stc_Ci:SetPosY(screenSizeY + screenSizeY / 2)
  self._ui.mul_Desc:SetPosY(screenSizeY)
  self._lastCredeit = false
  self._ciPosY = 0
  self._speedValue = 1
end
function PaGlobal_EndingCredit:setData()
  self._ui.stc_RectArea:SetRectClipOnArea(float2(0, 0), float2(self._ui.stc_RectArea:GetSizeX(), self._ui.stc_RectArea:GetSizeY()))
  for index = 0, self._nameControlMaxCount - 1 do
    self._ui.txt_Name[index]._0:SetText(self.nameList[index * 3 + 0])
    self._ui.txt_Name[index]._1:SetText(self.nameList[index * 3 + 1])
    self._ui.txt_Name[index]._2:SetText(self.nameList[index * 3 + 2])
    self._currentIndex = index * 3 + 2
  end
  self._ui.chk_Fast:SetCheck(false)
  self._imageTime = 9
  self._ui.txt_Title:SetShow(true)
  self._ui.chk_Fast:SetShow(true)
  audioPostEvent_SystemUi(54, 1)
end
function PaGlobal_EndingCredit:setLastCredit()
  self._ui.stc_LastCreditArea:SetRectClipOnArea(float2(0, 0), float2(self._ui.stc_LastCreditArea:GetSizeX(), self._ui.stc_LastCreditArea:GetSizeY()))
end
function PaGlobal_EndingCredit:setImage()
  local imageNo = math.random(1, self._imageAllCount)
  if imageNo > self._imageGCount then
    control = self._ui.stc_S
  else
    control = self._ui.stc_G
  end
  if imageNo < 10 then
    imageNo = "00" .. tostring(imageNo)
  elseif imageNo < 100 then
    imageNo = "0" .. tostring(imageNo)
  else
    imageNo = tostring(imageNo)
  end
  control:ChangeTextureInfoNameAsync("combine/etc/endingcredit/" .. imageNo .. ".dds")
  control:SetAlpha(0)
  control:SetShow(true)
  self:imageAni(control)
end
function PaGlobal_EndingCredit:imageAni(control)
  local showAni = control:addColorAnimation(0, 1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  showAni:SetStartColor(Defines.Color.C_00FFFFFF)
  showAni:SetEndColor(Defines.Color.C_FFFFFFFF)
  showAni:SetStartIntensity(1)
  showAni:SetEndIntensity(3)
  local closeAni = control:addColorAnimation(9, 10, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  closeAni:SetStartColor(Defines.Color.C_FFFFFFFF)
  closeAni:SetEndColor(Defines.Color.C_00FFFFFF)
  closeAni:SetStartIntensity(3)
  closeAni:SetEndIntensity(1)
end
local delayTime = 0
function PaGlobal_EndingCredit_RollAni(deltaTime)
  local self = PaGlobal_EndingCredit
  delayTime = delayTime + deltaTime
  if delayTime > 1 then
    if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_G) then
      self:keyCheck()
      delayTime = 0
    end
    if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) and ToClient_IsDevelopment() == true then
      self._currentIndex = 75700
      delayTime = 0
    end
    if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
      self:messageBoxOpen()
      delayTime = 0
    end
    if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SPACE) then
      self._pause = not self._pause
      delayTime = 0
    end
  end
  if true == self._pause then
    return
  end
  if 100 < self._ui.txt_Title:GetPosY() then
    self._ui.txt_Title:SetPosY(self._ui.txt_Title:GetPosY() - self._speed * self._speedValue * deltaTime)
  else
    self._ui.txt_Title:SetPosY(100)
  end
  for index = 0, self._nameControlMaxCount - 1 do
    self._ui.txt_Name[index]._0:SetPosY(self._ui.txt_Name[index]._0:GetPosY() - self._speed * self._speedValue * deltaTime)
    self._ui.txt_Name[index]._1:SetPosY(self._ui.txt_Name[index]._1:GetPosY() - self._speed * self._speedValue * deltaTime)
    self._ui.txt_Name[index]._2:SetPosY(self._ui.txt_Name[index]._2:GetPosY() - self._speed * self._speedValue * deltaTime)
    if self._ui.txt_Name[index]._0:GetPosY() < -30 then
      self._currentIndex = self._currentIndex + 1
      if nil == self.nameList[self._currentIndex] then
        self.nameList[self._currentIndex] = ""
      end
      self._ui.txt_Name[index]._0:SetText(self.nameList[self._currentIndex])
      self._currentIndex = self._currentIndex + 1
      if nil == self.nameList[self._currentIndex] then
        self.nameList[self._currentIndex] = ""
      end
      self._ui.txt_Name[index]._1:SetText(self.nameList[self._currentIndex])
      self._currentIndex = self._currentIndex + 1
      if nil == self.nameList[self._currentIndex] then
        self.nameList[self._currentIndex] = ""
      end
      self._ui.txt_Name[index]._2:SetText(self.nameList[self._currentIndex])
      self._ui.txt_Name[index]._0:SetPosY(self._ui.txt_Name[(index + self._nameControlMaxCount - 1) % self._nameControlMaxCount]._0:GetPosY() + (self._ui.txt_Name_0:GetSizeY() + 10))
      self._ui.txt_Name[index]._1:SetPosY(self._ui.txt_Name[(index + self._nameControlMaxCount - 1) % self._nameControlMaxCount]._1:GetPosY() + (self._ui.txt_Name_1:GetSizeY() + 10))
      self._ui.txt_Name[index]._2:SetPosY(self._ui.txt_Name[(index + self._nameControlMaxCount - 1) % self._nameControlMaxCount]._2:GetPosY() + (self._ui.txt_Name_2:GetSizeY() + 10))
    end
  end
  self._imageTime = self._imageTime + deltaTime
  if self._imageShowTime < self._imageTime and false == self._lastCredeit then
    self:setImage()
    self._imageTime = 0
  end
  if #self.nameList <= self._currentIndex + 3 and false == self._lastCredeit then
    self._hideTime = self._hideTime + deltaTime
    if self._endTime < self._hideTime then
      self._lastCredeit = true
      self:setLastCredit()
      self._hideTime = 0
      self._ui.txt_Title:SetShow(false)
      self._ui.chk_Fast:SetShow(false)
    end
  end
  self._ui.txt_Log:SetText(self._currentIndex .. " / " .. #self.nameList)
  if true == self._lastCredeit then
    self._ui.mul_Desc:SetPosY(self._ui.mul_Desc:GetPosY() - self._speedValue * deltaTime / 4)
    self._ui.stc_Ci:SetPosY(math.max(self._ciPosY, self._ui.stc_Ci:GetPosY() - self._speedValue * deltaTime / 4))
    if self._ui.stc_Ci:GetPosY() == self._ciPosY then
      self._hideTime = self._hideTime + deltaTime
      if 10 < self._hideTime then
        PaGlobal_EndingCredit:preClose()
      end
    end
  end
end
function PaGlobal_EndingCredit:setNameList()
