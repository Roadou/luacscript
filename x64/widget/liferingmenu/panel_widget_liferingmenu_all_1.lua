function PaGlobal_LifeRingMenu_All:initialize()
  if Panel_Widget_LifeRingMenu_All == nil then
    return
  end
  if PaGlobal_LifeRingMenu_All._initialize == true then
    return
  end
  self._ui._stc_uiBG = UI.getChildControl(Panel_Widget_LifeRingMenu_All, "Static_UIBg")
  self._ui._stc_mouseCursor = UI.getChildControl(self._ui._stc_uiBG, "Static_MouseCursor")
  self._ui.prog_circleBg = UI.getChildControl(self._ui._stc_uiBG, "Static_ProgressBg")
  self._ui.prog_circle = UI.getChildControl(self._ui.prog_circleBg, "CircularProgress_Endurance")
  UI.getChildControl(self._ui._stc_uiBG, "Static_MouseBg"):SetShow(_ContentsGroup_UsePadSnapping == false)
  local iconSlot = {_bg = nil, _slot = nil}
  local slotConfig = {
    createIcon = true,
    createEnchant = true,
    createEnduranceIcon = true
  }
  self._ui.stc_equipSlotBg = UI.getChildControl(self._ui._stc_uiBG, "Static_EquipItemSlot")
  self._ui.stc_equipName = UI.getChildControl(self._ui.stc_equipSlotBg, "StaticText_EquipItemName")
  self._ui.stc_equipEndurance = UI.getChildControl(self._ui.stc_equipSlotBg, "StaticText_Endurance")
  self._ui.stc_equipSlot = {}
  SlotItem.new(self._ui.stc_equipSlot, "Created_Static_LifgSlot", 0, self._ui.stc_equipSlotBg, slotConfig)
  self._ui.stc_equipSlot:createChild()
  self._ui.effectTable = {}
  for idx = 0, self._config._actionModeCount - 1 do
    self._ui._stc_area[idx] = {}
    self._ui._stc_area[idx].bg = UI.getChildControl(self._ui._stc_uiBG, "Static_" .. self._areaInfo[idx].name)
    self._ui._stc_area[idx].onBtn = UI.getChildControl(self._ui._stc_area[idx].bg, "Static_Icon_On")
    self._ui._stc_area[idx].offBtn = UI.getChildControl(self._ui._stc_area[idx].bg, "Static_Icon_Off")
    self._ui._stc_area[idx].texture = UI.getChildControl(self._ui._stc_uiBG, "Static_Effect" .. tostring(idx))
    local padKeyGuide = UI.getChildControl(self._ui._stc_area[idx].bg, "Static_1")
    if padKeyGuide ~= nil then
      padKeyGuide:SetShow(_ContentsGroup_UsePadSnapping)
    end
  end
  self:registEventHandler()
  self:validate()
  self:clearData()
  self:setSelectMode(false)
  self._initialize = true
end
function PaGlobal_LifeRingMenu_All:validate()
  self._ui._stc_uiBG:isValidate()
  self._ui._stc_mouseCursor:isValidate()
  for idx = 0, self._config._actionModeCount - 1 do
    self._ui._stc_area[idx].bg:isValidate()
  end
end
function PaGlobal_LifeRingMenu_All:registEventHandler()
  Panel_Widget_LifeRingMenu_All:RegisterUpdateFunc("PaGlobal_LifeRingMenu_All_Update")
  if _ContentsGroup_UsePadSnapping == false then
  else
    Panel_Widget_LifeRingMenu_All:setUiConvertableType(CppEnums.UIConvertableType.eUIConvertableType_showTime)
    Panel_Widget_LifeRingMenu_All:setConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_UiMode)
    Panel_Widget_LifeRingMenu_All:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "PaGlobal_LifeRingMenu_All:updateButton(1)")
    Panel_Widget_LifeRingMenu_All:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "PaGlobal_LifeRingMenu_All:updateButton(2)")
    Panel_Widget_LifeRingMenu_All:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "PaGlobal_LifeRingMenu_All:updateButton(0)")
    Panel_Widget_LifeRingMenu_All:registerPadEvent(__eConsoleUIPadEvent_A, "PaGlobal_LifeRingMenu_All:applyChangeActionModeAndClose()")
  end
  registerEvent("onScreenResize", "FromClient_LifeRingMenu_All_ResizePanel")
end
function PaGlobal_LifeRingMenu_All:clearData()
  self._keyPressTime = 0
  self._lastSelectAreaIdx = -1
end
function PaGlobal_LifeRingMenu_All:prepareOpen()
  if Panel_Widget_LifeRingMenu_All == nil or Panel_Widget_LifeRingMenu_All:GetShow() == true then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  if selfPlayerWrapper:isDead() == true then
    return
  end
  self._currentMode = ToClient_GetCurrentActionMode()
  if _ContentsGroup_UsePadSnapping == true then
    self._ui._stc_uiBG:SetShow(true)
  end
  for idx = 0, self._config._actionModeCount - 1 do
    self._ui._stc_area[idx].onBtn:SetShow(false)
    self._ui._stc_area[idx].offBtn:SetShow(true)
    self._ui._stc_area[idx].texture:SetShow(false)
  end
  PaGlobal_LifeRingMenu_All:resetEquipInfo()
  FromClient_LifeRingMenu_All_ResizePanel()
  PaGlobal_LifeRingMenu_All:open()
end
function PaGlobal_LifeRingMenu_All:open()
  Panel_Widget_LifeRingMenu_All:SetShow(true)
end
function PaGlobal_LifeRingMenu_All:prepareClose()
  if _ContentsGroup_UsePadSnapping == false then
    PaGlobal_LifeRingMenu_All:changeActionMode()
  else
    SetUIMode(Defines.UIMode.eUIMode_Default)
  end
  self:clearData()
  self:setSelectMode(false)
  PaGlobal_LifeRingMenu_All:close()
end
function PaGlobal_LifeRingMenu_All:close()
  Panel_Widget_LifeRingMenu_All:SetShow(false)
end
function PaGlobal_LifeRingMenu_All:update(deltaTime)
  if self:isSelectMode() == false then
    self:updateForOpen(deltaTime)
  elseif _ContentsGroup_UsePadSnapping == false then
    self:updateForSelectMode(deltaTime)
    if isKeyPressed(self._config._keyBinding) == false then
      PaGlobal_LifeRingMenu_All:prepareClose()
    end
  else
    local beforeIndex = self._lastSelectAreaIdx
    local registPosition = ToClient_checkQuickMenuCurrentPosition()
    if __eQuickMenuStickPosition_Count ~= registPosition then
      if registPosition == 7 or registPosition == 6 then
        PaGlobal_LifeRingMenu_All:updateButton(1)
      elseif registPosition == 4 or registPosition == 3 then
        PaGlobal_LifeRingMenu_All:updateButton(0)
      elseif registPosition == 1 or registPosition == 2 then
        PaGlobal_LifeRingMenu_All:updateButton(2)
      end
    elseif -1 ~= self._lastSelectAreaIdx then
      PaGlobal_LifeRingMenu_All:applyChangeActionModeAndClose()
    end
  end
end
function PaGlobal_LifeRingMenu_All:updateForOpen(deltaTime)
  if _ContentsGroup_UsePadSnapping == false then
    if isKeyPressed(PaGlobal_LifeRingMenu_All._config._exceptKey1) == true or isKeyPressed(PaGlobal_LifeRingMenu_All._config._exceptKey2) == true then
      PaGlobal_LifeRingMenu_All:prepareClose()
      return
    end
    if isKeyPressed(self._config._keyBinding) == false then
      PaGlobal_LifeRingMenu_All:prepareClose()
      return
    end
    self._keyPressTime = self._keyPressTime + deltaTime
    if self._keyPressTime > self._config._keyPressTimeMax then
      self:setSelectMode(true)
      if self._currentMode == __eActionMode_Normal then
        ToClient_setMousePosition(self._screenCenterPos.x, self._screenCenterPos.y + Panel_Widget_LifeRingMenu_All:GetSizeY() * self._uiScale)
      else
        ToClient_setMousePosition(self._screenCenterPos.x + Panel_Widget_LifeRingMenu_All:GetSizeX() * self._uiScale, self._screenCenterPos.y)
      end
    end
  else
    self._keyPressTime = self._keyPressTime + deltaTime
    if self._keyPressTime > self._config._keyPressTimeMax then
      self:setSelectMode(true)
    end
  end
end
function PaGlobal_LifeRingMenu_All:updateForSelectMode(deltaTime)
  ToClient_SetInitMousePosInBoader(false)
  local mouseMovePosX = (getMousePosX() * self._uiScale - self._screenCenterPos.x) / (getScreenSizeX() * self._uiScale)
  local mouseMovePosY = (getMousePosY() * self._uiScale - self._screenCenterPos.y) / (getScreenSizeY() * self._uiScale)
  local moveLength = math.sqrt(math.abs(math.pow(mouseMovePosX, 2)) + math.abs(math.pow(mouseMovePosY, 2)))
  local mouseDirectionX = mouseMovePosX / moveLength
  local mouseDirectionY = mouseMovePosY / moveLength
  if moveLength > 0.5 then
    moveLength = 0.5
  end
  mouseMovePosX = Panel_Widget_LifeRingMenu_All:GetSizeX() * mouseDirectionX * moveLength
  mouseMovePosY = Panel_Widget_LifeRingMenu_All:GetSizeY() * mouseDirectionY * moveLength
  self._ui._stc_mouseCursor:SetSpanSize(mouseMovePosX, mouseMovePosY - 20)
  local areaIdx = -1
  if moveLength > 0.1 then
    local angle = math.floor(-1 * math.atan2(mouseMovePosX, mouseMovePosY) / math.pi * 180)
    if angle <= -60 then
      areaIdx = 2
    elseif angle <= 60 then
      areaIdx = 0
    elseif angle <= 180 then
      areaIdx = 1
    end
  end
  if self._lastSelectAreaIdx ~= areaIdx then
    PaGlobal_LifeRingMenu_All:updateButton(areaIdx)
  end
end
function PaGlobal_LifeRingMenu_All:resetEquipInfo()
  self._ui.stc_equipSlot:clearItem()
  self._ui.stc_equipName:SetText("")
  self._ui.stc_equipEndurance:SetText("")
  self._ui.prog_circle:SetProgressRate(0)
  self._ui.stc_equipEndurance:SetShow(false)
end
function PaGlobal_LifeRingMenu_All:updateButton(areaIdx)
  self._lastSelectAreaIdx = areaIdx
  PaGlobal_LifeRingMenu_All:resetEquipInfo()
  if areaIdx == -1 then
    return
  end
  for idx = 0, self._config._actionModeCount - 1 do
    local isSet = idx == self._lastSelectAreaIdx
    self._ui._stc_area[idx].onBtn:SetShow(isSet == true)
    self._ui._stc_area[idx].offBtn:SetShow(isSet == false)
    self._ui._stc_area[idx].texture:SetShow(isSet == true)
  end
  if self._areaInfo[areaIdx].value == __eActionMode_Normal then
    self._ui.stc_equipSlot:clearItem()
    self._ui.stc_equipName:SetText(self._areaInfo[areaIdx].itemName)
    return
  end
  self._ui.stc_equipEndurance:SetShow(true)
  local itemWrapper = ToClient_getEquipmentItem(self._areaInfo[areaIdx].slotNo)
  if itemWrapper == nil then
    local itemEnchantKey = ItemEnchantKey(self._areaInfo[areaIdx].itemKey, 0)
    if nil == itemEnchantKey then
      return
    end
    if false == itemEnchantKey:isDefined() then
      return
    end
    itemWrapper = getItemEnchantStaticStatus(itemEnchantKey)
    if nil == itemWrapper then
      return
    end
    self._ui.stc_equipName:SetText(self._areaInfo[areaIdx].itemName)
    self._ui.stc_equipSlot:setItemByStaticStatus(itemWrapper, 1)
    self._ui.stc_equipEndurance:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_LIFEVALUE"))
    if 1 == areaIdx then
      self._ui.stc_equipEndurance:SetShow(false)
    end
  else
    itemWrapper = ToClient_getEquipmentItem(self._areaInfo[areaIdx].slotNo)
    if nil == itemWrapper then
      return
    end
    local maxEndurance = itemWrapper:get():getEndurance()
    local currentEndurance = maxEndurance
    local itemSSW = itemWrapper:getStaticStatus()
    if false == itemSSW:get():isUnbreakable() then
      maxEndurance = itemSSW:get():getMaxEndurance()
    end
    local calcEndurance = currentEndurance / maxEndurance
    self._ui.prog_circle:SetProgressRate(calcEndurance * 100)
    self._ui.prog_circle:SetAniSpeed(0)
    self._ui.stc_equipName:SetText(itemSSW:getName())
    self._ui.stc_equipSlot:setItemByStaticStatus(itemSSW, 1, -1, currentEndurance <= 0)
    self._ui.stc_equipEndurance:SetText(currentEndurance .. " / " .. maxEndurance)
  end
end
function PaGlobal_LifeRingMenu_All:applyChangeActionModeAndClose()
  PaGlobal_LifeRingMenu_All:changeActionMode()
  PaGlobal_LifeRingMenu_All:prepareClose()
end
function PaGlobal_LifeRingMenu_All:changeActionMode()
  if self._areaInfo[self._lastSelectAreaIdx] ~= nil then
    ToClient_RequestChangeActionMode(self._areaInfo[self._lastSelectAreaIdx].value)
  end
end
function PaGlobal_LifeRingMenu_All:setSelectMode(flag)
  self._ui._stc_uiBG:SetShow(flag)
  ToClient_blockCameraRotate(flag)
end
function PaGlobal_LifeRingMenu_All:isSelectMode()
  return self._ui._stc_uiBG:GetShow()
end
function PaGlobal_LifeRingMenu_All:SetPanelPosInfo(posX, posY)
  self._uiScale = ToClient_getGameOptionControllerWrapper():getUIScale()
  self._screenCenterPos.x = posX * self._uiScale
  self._screenCenterPos.y = posY * self._uiScale
  self._panelLeftTopPos.x = posX - Panel_Widget_LifeRingMenu_All:GetSizeX() / 2
  self._panelLeftTopPos.y = posY - Panel_Widget_LifeRingMenu_All:GetSizeY() / 2
  Panel_Widget_LifeRingMenu_All:SetPosXY(self._panelLeftTopPos.x, self._panelLeftTopPos.y)
end
