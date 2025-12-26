function PaGlobal_SimpleBuildMode_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_commandBg = UI.getChildControl(Panel_SimpleBuildMode, "Static_CommandBG")
  self._ui._keyGuideArray[self._eKeyGuideType.FIX] = UI.getChildControl(self._ui._stc_commandBg, "StaticText_Key_Fix")
  self._ui._keyGuideArray[self._eKeyGuideType.MOVE_CLICK] = UI.getChildControl(self._ui._stc_commandBg, "Static_Key_MoveClick")
  self._ui._keyGuideArray[self._eKeyGuideType.ROTATE_LEFT] = UI.getChildControl(self._ui._stc_commandBg, "StaticText_Key_Rotate_Left")
  self._ui._keyGuideArray[self._eKeyGuideType.ROTATE_RIGHT] = UI.getChildControl(self._ui._stc_commandBg, "StaticText_Key_Rotate_Right")
  self._ui._keyGuideArray[self._eKeyGuideType.ROTATE_FAST_LEFT] = UI.getChildControl(self._ui._stc_commandBg, "StaticText_Key_Rotate_Fast_Left")
  self._ui._keyGuideArray[self._eKeyGuideType.ROTATE_FAST_RIGHT] = UI.getChildControl(self._ui._stc_commandBg, "StaticText_Key_Rotate_Fast_Right")
  self._ui._keyGuideArray[self._eKeyGuideType.CHANGE_CAMERA_MODE] = UI.getChildControl(self._ui._stc_commandBg, "StaticText_Key_ChangeCameraMode")
  self._ui._keyGuideArray[self._eKeyGuideType.INSTALL] = UI.getChildControl(self._ui._stc_commandBg, "StaticText_Key_Install")
  self._ui._keyGuideArray[self._eKeyGuideType.CANCLE] = UI.getChildControl(self._ui._stc_commandBg, "StaticText_Key_Cancle")
  self._ui._stc_showCommandBg = UI.getChildControl(Panel_SimpleBuildMode, "Static_ShowCommandBG")
  self._ui._btn_showCommand = UI.getChildControl(self._ui._stc_showCommandBg, "Button_ShowCommand")
  self._ui._btn_showCommand:SetCheck(true)
  self:registEventHandler()
  self:validate()
  PaGlobal_SimpleBuildMode_All_SimpleBuildEnd()
  self._initialize = true
end
function PaGlobal_SimpleBuildMode_All:validate()
  if Panel_SimpleBuildMode == nil then
    return
  end
  self._ui._stc_commandBg:isValidate()
  self._ui._stc_showCommandBg:isValidate()
  self._ui._btn_showCommand:isValidate()
  for index = 0, self._eKeyGuideType.COUNT - 1 do
    self._ui._keyGuideArray[index]:isValidate()
  end
end
function PaGlobal_SimpleBuildMode_All:registEventHandler()
  if Panel_SimpleBuildMode == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_SimpleBuildMode_All_ResizePanel")
  registerEvent("FromClient_SimpleBuildStart", "PaGlobal_SimpleBuildMode_All_Open")
  registerEvent("FromClient_SimpleBuildEnd", "PaGlobal_SimpleBuildMode_All_Close")
  registerEvent("EventSelfPlayerPreDead", "PaGlobal_SimpleBuildMode_All_SimpleBuildEnd")
  self._ui._btn_showCommand:addInputEvent("Mouse_LUp", "HandleEventLUp_SimpleBuildMode_All_ShowCommandFunc()")
end
function PaGlobal_SimpleBuildMode_All:resize()
  if Panel_SimpleBuildMode == nil then
    return
  end
  Panel_SimpleBuildMode:ComputePosAllChild()
  local maxSizeX = 0
  for index = 0, self._eKeyGuideType.COUNT - 1 do
    if self._ui._keyGuideArray[index] ~= nil then
      local descControl = UI.getChildControl(self._ui._keyGuideArray[index], "StaticText_Desc")
      if descControl ~= nil then
        local checkSizeX = descControl:GetTextSizeX() + descControl:GetSpanSize().x + self._ui._keyGuideArray[index]:GetSpanSize().x * 2
        if maxSizeX < checkSizeX then
          maxSizeX = checkSizeX
        end
      end
    end
  end
  self._ui._stc_commandBg:SetSize(maxSizeX, self._ui._stc_commandBg:GetSizeY())
  Panel_SimpleBuildMode:SetSize(self._ui._stc_commandBg:GetSizeX(), self._ui._stc_commandBg:GetSpanSize().y + self._ui._stc_commandBg:GetSizeY())
  self._ui._stc_showCommandBg:SetSize(self._ui._btn_showCommand:GetSizeX() + self._ui._btn_showCommand:GetTextSizeX() + 10, self._ui._stc_showCommandBg:GetSizeY())
  self._ui._stc_showCommandBg:ComputePos()
end
function PaGlobal_SimpleBuildMode_All:prepareOpen()
  if Panel_SimpleBuildMode == nil then
    return
  end
  if _ContentsGroup_SimpleBuildMode == false then
    return
  end
  if ToClient_isSimpleBuildMode() == false then
    return
  end
  self:resize()
  close_WindowPanelList()
  if _ContentsGroup_NewUI_ClothInventory_All == true or _ContentsGroup_RenewUI == true then
    if PaGlobalFunc_ClothInventory_All_Close ~= nil then
      PaGlobalFunc_ClothInventory_All_Close()
    end
  elseif ClothInventory_Close ~= nil then
    ClothInventory_Close()
  end
  ToClient_HideMouseCursor()
  PaGlobal_SimpleBuildMode_All_SetCameraMode(false)
  PaGlobal_SimpleBuildMode_All_SetSimpleBuildFixState(false)
  Panel_SimpleBuildMode:ClearUpdateLuaFunc()
  Panel_SimpleBuildMode:RegisterUpdateFunc("PaGlobal_SimpleBuildMode_All_Update")
  self._isShowSkillCommond = false
  if Panel_SkillCommand ~= nil and Panel_SkillCommand:GetShow() == true then
    Panel_SkillCommand:SetShow(false)
    self._isShowSkillCommond = true
  end
  self._isShowCommond = false
  if Panel_WatchingMode ~= nil and Panel_WatchingMode:GetShow() == true then
    Panel_WatchingMode:SetShow(false)
    self._isShowCommond = true
  end
  self._ui._stc_commandBg:SetShow(self._ui._btn_showCommand:IsCheck() == true)
  self._isCheckDelay = false
  self._isChangeCameraMode = false
  self._prevCameraPitch = nil
  local isSuccess = ToClient_onBossCamera(true, 1500, 100, 10, 2000, 70, 0.4, 0.08)
  self._ui._keyGuideArray[self._eKeyGuideType.FIX]:SetText(keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Interaction))
  self:open()
end
function PaGlobal_SimpleBuildMode_All:open()
  if Panel_SimpleBuildMode == nil then
    return
  end
  Panel_SimpleBuildMode:SetShow(true)
end
function PaGlobal_SimpleBuildMode_All:prepareClose()
  if Panel_SimpleBuildMode == nil then
    return
  end
  PaGlobal_SimpleBuildMode_All_SetSimpleBuildFixState(false)
  PaGlobal_SimpleBuildMode_All_SetCameraMode(false)
  Panel_SimpleBuildMode:ClearUpdateLuaFunc()
  self._isCheckDelay = false
  self._isChangeCameraMode = false
  self._prevCameraPitch = nil
  if self._isShowSkillCommond == true then
    if nil ~= Panel_SkillCommand then
      Panel_SkillCommand:SetShow(true)
    end
    self._isShowSkillCommond = false
  end
  if self._isShowCommond == true then
    if nil ~= Panel_WatchingMode then
      Panel_WatchingMode:SetShow(true)
    end
    self._isShowCommond = false
  end
  if Panel_House_InstallationMode_WarInfomation_All ~= nil then
    Panel_House_InstallationMode_WarInfomation_All:setUiConvertableType(CppEnums.UIConvertableType.eUIConvertableType_always)
    Panel_House_InstallationMode_WarInfomation_All:setConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_UiControlMode)
    if PaGlobal_WarInfomation_All_Close ~= nil then
      PaGlobal_WarInfomation_All_Close()
    end
  end
  if PaGlobal_House_InstallationSiege_All_EndBuildTent ~= nil and Panel_House_InstallationMode_Siege_All ~= nil then
    PaGlobal_House_InstallationSiege_All_EndBuildTent()
  end
  ToClient_onBossCamera(false)
  self:close()
end
function PaGlobal_SimpleBuildMode_All:close()
  if Panel_SimpleBuildMode == nil then
    return
  end
  Panel_SimpleBuildMode:SetShow(false)
end
function PaGlobal_SimpleBuildMode_All:update(deltaTime)
  if Panel_SimpleBuildMode == nil then
    return
  end
  if ToClient_isSimpleBuildMode() == false then
    PaGlobal_SimpleBuildMode_All_SimpleBuildEnd()
    return
  end
  local currentInputMode = getInputMode()
  if currentInputMode ~= CppEnums.EProcessorInputMode.eProcessorInputMode_GameMode and currentInputMode ~= CppEnums.EProcessorInputMode.eProcessorInputMode_UiModeNotInput and currentInputMode ~= CppEnums.EProcessorInputMode.eProcessorInputMode_UiMode then
    self._isCheckDelay = true
    return
  end
  if self._isCheckDelay == true then
    self._isCheckDelay = false
    self:updateFixState()
    return
  end
  if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) == true then
    if check_ShowWindow() == true then
      close_WindowPanelList()
    end
    if ToClient_isSimpleBuildFixState() == true then
      PaGlobal_SimpleBuildMode_All_SetSimpleBuildFixState(false)
      PaGlobal_SimpleBuildMode_All_SetCameraMode(false)
    else
      PaGlobal_SimpleBuildMode_All_SimpleBuildEnd()
    end
    return
  end
  if keyCustom_IsUp_Action(CppEnums.ActionInputType.ActionInputType_Interaction) == true then
    if ToClient_isSimpleBuildFixable() == false and ToClient_isPlayerLord() == false then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoPositionIsInvalidate"))
      return
    end
    if ToClient_isSimpleBuildFixState() == false then
      if self:checkRightHandEquipType() == false then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoItemUseRestricted"))
        return
      end
      if IsSelfPlayerWaitAction() == false then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoItemUseRestricted"))
        return
      end
      close_WindowPanelList()
      PaGlobal_SimpleBuildMode_All_SetSimpleBuildFixState(true)
    end
    return
  end
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_SPACE) == true then
    if ToClient_isSimpleBuildFixable() == false and ToClient_isPlayerLord() == false then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoPositionIsInvalidate"))
      return
    end
    if ToClient_isSimpleBuildFixState() == true then
      if self:checkRightHandEquipType() == false then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoItemUseRestricted"))
        return
      end
      if IsSelfPlayerWaitAction() == false then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoItemUseRestricted"))
        return
      end
      ToClient_InstallSimpleBuildSelectObject(0)
      PaGlobal_SimpleBuildMode_All:prepareClose()
    end
    return
  end
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_F) == true then
    if ToClient_isSimpleBuildFixState() == true then
      PaGlobal_SimpleBuildMode_All_SetCameraMode(not self._isChangeCameraMode, 2)
    end
    return
  end
end
function PaGlobal_SimpleBuildMode_All:checkRightHandEquipType()
  local rightHandItemWrapper = ToClient_getEquipmentItem(0)
  if rightHandItemWrapper == nil then
    return true
  end
  local equipType = rightHandItemWrapper:getStaticStatus():getEquipType()
  if 43 == equipType or 44 == equipType or 45 == equipType or 47 == equipType or 48 == equipType or 49 == equipType or 50 == equipType or 53 == equipType or 60 == equipType or 61 == equipType or 62 == equipType then
    return false
  end
  return true
end
function PaGlobal_SimpleBuildMode_All:updateFixState()
  if Panel_SimpleBuildMode == nil then
    return
  end
  for index = 0, self._eKeyGuideType.COUNT - 1 do
    self._ui._keyGuideArray[index]:SetShow(false)
  end
  if ToClient_isSimpleBuildFixState() == true then
    ToClient_uiManagerSetUIConvertableState(CppEnums.UIConvertableType.eUIConvertableType_always, true)
    ToClient_uiManagerSetConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_UiModeNotInput)
    self._ui._keyGuideArray[self._eKeyGuideType.ROTATE_LEFT]:SetShow(true)
    self._ui._keyGuideArray[self._eKeyGuideType.ROTATE_RIGHT]:SetShow(true)
    self._ui._keyGuideArray[self._eKeyGuideType.ROTATE_FAST_LEFT]:SetShow(true)
    self._ui._keyGuideArray[self._eKeyGuideType.ROTATE_FAST_RIGHT]:SetShow(true)
    self._ui._keyGuideArray[self._eKeyGuideType.CHANGE_CAMERA_MODE]:SetShow(true)
    self._ui._keyGuideArray[self._eKeyGuideType.INSTALL]:SetShow(true)
    self._ui._keyGuideArray[self._eKeyGuideType.CANCLE]:SetShow(true)
    self._ui._keyGuideArray[self._eKeyGuideType.MOVE_CLICK]:SetShow(self._isChangeCameraMode)
  else
    ToClient_uiManagerSetUIConvertableState(CppEnums.UIConvertableType.eUIConvertableType_always, false)
    ToClient_uiManagerSetConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_GameMode)
    self._ui._keyGuideArray[self._eKeyGuideType.FIX]:SetShow(true)
    self._ui._keyGuideArray[self._eKeyGuideType.CANCLE]:SetShow(true)
  end
  Panel_SimpleBuildMode:SetDragEnable(not self._isChangeCameraMode)
  PaGlobal_SimpleBuildMode_All:alignKeyGuide()
end
function PaGlobal_SimpleBuildMode_All:alignKeyGuide()
  local gapY = 0
  local baseSpanSizeY = 10
  local keyGuidGapY = 35
  for index = 0, self._eKeyGuideType.COUNT - 1 do
    if self._ui._keyGuideArray[index] ~= nil and self._ui._keyGuideArray[index]:GetShow() == true then
      self._ui._keyGuideArray[index]:SetSpanSize(self._ui._keyGuideArray[index]:GetSpanSize().x, baseSpanSizeY + gapY)
      gapY = gapY + keyGuidGapY
    end
  end
  self._ui._stc_commandBg:SetSize(self._ui._stc_commandBg:GetSizeX(), gapY + baseSpanSizeY * 1.5)
  Panel_SimpleBuildMode:SetSize(self._ui._stc_commandBg:GetSizeX(), self._ui._stc_commandBg:GetSpanSize().y + self._ui._stc_commandBg:GetSizeY())
end
