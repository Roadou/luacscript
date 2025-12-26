PaGlobal_ContentsTutorial_All = {
  _ui = {
    _stc_blackBg = nil,
    _stc_blackTopBg = nil,
    _stc_blackBottomBg = nil,
    _stc_blackLeftBg = nil,
    _stc_blackRightBg = nil,
    _stc_guideBg = nil,
    _stc_guideTitleBg = nil,
    _stc_guideTitleIcon = nil,
    _txt_guideTitle = nil,
    _stc_guideDescBg = nil,
    _txt_guideDesc = nil,
    _stc_nextIcon = nil,
    _txt_next = nil,
    _stc_guideImageBG = nil,
    _stc_guideImage = nil,
    _stc_messageBox = nil,
    _stc_messageTitle = nil,
    _stc_messageText = nil,
    _stc_btn_Yes = nil,
    _stc_btn_No = nil,
    _stc_btn_Close = nil,
    _stc_btn_Cancel = nil
  },
  _tutorialDataCount = 0,
  _tutorialKey = -1,
  _nextDataIndex = 0,
  _prevUIMode = nil,
  _tmpControl = {},
  _realTargetControl = nil,
  _copyTargetControl = nil,
  _isNoneCopyControl = false,
  _eWaitingType = {
    NO_WATING = 0,
    INPUT_SPACE = 1,
    INPUT_ENTER = 2,
    INPUT_MOUSE = 3,
    UI_INPUT_TYPE = 4,
    SHOW_CONTROL = 5,
    HIDE_CONTROL = 6,
    TIMER = 7
  },
  _curWaitingType = 0,
  _uiInputType = nil,
  _uiInputTypeFunc = nil,
  _uiInputTypeFuncParam = nil,
  _watingTime = 0,
  _curWatingTime = 0,
  _isSetWatingSkipTime = false,
  _checkResult = false,
  _isSetCameraBlock = false,
  _eTutorialType = {PET = 0, VIPIKO = 1},
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_ContentsTutorial_All_Init")
function FromClient_ContentsTutorial_All_Init()
  PaGlobal_ContentsTutorial_All:initialize()
end
function PaGlobal_ContentsTutorial_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_blackBg = UI.getChildControl(Panel_ContentsTutorial_All, "Static_BlackBG")
  self._ui._stc_blackTopBg = UI.getChildControl(self._ui._stc_blackBg, "Static_BlackTopBG")
  self._ui._stc_blackBottomBg = UI.getChildControl(self._ui._stc_blackBg, "Static_BlackBottomBG")
  self._ui._stc_blackLeftBg = UI.getChildControl(self._ui._stc_blackBg, "Static_BlackLeftBG")
  self._ui._stc_blackRightBg = UI.getChildControl(self._ui._stc_blackBg, "Static_BlackRightBG")
  self._ui._stc_guideBg = UI.getChildControl(Panel_ContentsTutorial_All, "Static_GuideBG")
  self._ui._stc_guideTitleBg = UI.getChildControl(self._ui._stc_guideBg, "Static_GuideTitleBG")
  self._ui._stc_guideTitleIcon = UI.getChildControl(self._ui._stc_guideTitleBg, "Static_GuideTitleIcon")
  self._ui._txt_guideTitle = UI.getChildControl(self._ui._stc_guideTitleIcon, "StaticText_GuideTitle")
  self._ui._stc_guideDescBg = UI.getChildControl(self._ui._stc_guideBg, "Static_GuideDescBG")
  self._ui._txt_guideDesc = UI.getChildControl(self._ui._stc_guideDescBg, "StaticText_GuideDesc")
  self._ui._stc_nextIcon = UI.getChildControl(self._ui._stc_guideBg, "Static_NextIcon")
  self._ui._txt_next = UI.getChildControl(self._ui._stc_nextIcon, "StaticText_Next")
  self._ui._stc_guideImageBG = UI.getChildControl(self._ui._stc_guideBg, "Static_GuideImageBG")
  self._ui._stc_guideImage = UI.getChildControl(self._ui._stc_guideImageBG, "Static_GuideImage")
  self._ui._stc_messageBox = UI.getChildControl(Panel_ContentsTutorial_All, "Static_Messagebox")
  self._ui._stc_message_Title = UI.getChildControl(self._ui._stc_messageBox, "Static_Text_Title")
  self._ui._stc_messageText = UI.getChildControl(self._ui._stc_messageBox, "StaticText_Content")
  self._ui._stc_btn_Yes = UI.getChildControl(self._ui._stc_messageBox, "Button_Yes")
  self._ui._stc_btn_No = UI.getChildControl(self._ui._stc_messageBox, "Button_No")
  self._ui._stc_btn_Cancel = UI.getChildControl(self._ui._stc_messageBox, "Button_Cancel")
  self._ui._stc_btn_Close = UI.getChildControl(self._ui._stc_messageBox, "Button_Close")
  self:validate()
  self:registEventHandler()
  self:prepareClose()
  self._initialize = true
end
function PaGlobal_ContentsTutorial_All:validate()
  if Panel_ContentsTutorial_All == nil then
    return
  end
  self._ui._stc_blackBg:isValidate()
  self._ui._stc_blackTopBg:isValidate()
  self._ui._stc_blackBottomBg:isValidate()
  self._ui._stc_blackLeftBg:isValidate()
  self._ui._stc_blackRightBg:isValidate()
  self._ui._stc_guideBg:isValidate()
  self._ui._stc_guideTitleBg:isValidate()
  self._ui._stc_guideTitleIcon:isValidate()
  self._ui._txt_guideTitle:isValidate()
  self._ui._stc_guideDescBg:isValidate()
  self._ui._txt_guideDesc:isValidate()
  self._ui._stc_nextIcon:isValidate()
  self._ui._txt_next:isValidate()
  self._ui._stc_guideImageBG:isValidate()
  self._ui._stc_guideImage:isValidate()
end
function PaGlobal_ContentsTutorial_All:registEventHandler()
  if Panel_ContentsTutorial_All == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_ContentsTutorial_All_Resize")
  registerEvent("FromClient_StartContentsTutorial", "PaGlobalFunc_ContentsTutorial_All_Open")
  registerEvent("EventSelfPlayerPreDead", "PaGlobalFunc_ContentsTutorial_All_Close")
  registerEvent("selfPlayer_regionChanged", "PaGlobalFunc_ContentsTutorial_All_ServantTutorialCheck")
  registerEvent("Event_ManufactureResultList", "PaGlobalFunc_ContentsTutorial_All_ManuFactureCheck")
  local alpha = 0.8
  self._ui._stc_blackTopBg:SetAlpha(alpha)
  self._ui._stc_blackBottomBg:SetAlpha(alpha)
  self._ui._stc_blackLeftBg:SetAlpha(alpha)
  self._ui._stc_blackRightBg:SetAlpha(alpha)
  self._ui._txt_guideTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_guideDesc:SetTextMode(__eTextMode_AutoWrap)
end
function PaGlobal_ContentsTutorial_All:resize()
  if Panel_ContentsTutorial_All == nil then
    return
  end
  local uiScale = getGlobalScale()
  local sizeX = getResolutionSizeX() / uiScale
  local sizeY = getResolutionSizeY() / uiScale
  Panel_ContentsTutorial_All:SetPosX(0)
  Panel_ContentsTutorial_All:SetPosY(0)
  Panel_ContentsTutorial_All:SetSize(sizeX, sizeY)
  self._ui._stc_blackBg:SetSize(sizeX, sizeY)
  self._ui._stc_blackTopBg:SetSize(sizeX, sizeY)
  self._ui._stc_blackBottomBg:SetSize(sizeX, sizeY)
  self._ui._stc_blackLeftBg:SetSize(sizeX, sizeY)
  self._ui._stc_blackRightBg:SetSize(sizeX, sizeY)
  Panel_ContentsTutorial_All:ComputePosAllChild()
  self._ui._stc_nextIcon:SetSpanSize(self._ui._txt_next:GetTextSizeX() + 55, self._ui._stc_nextIcon:GetSpanSize().y)
  if Panel_ContentsTutorial_All:GetShow() ~= false then
  end
  if self._tutorialDataCount < self._nextDataIndex then
    return
  end
  local data = ToClient_GetContentsTutorialData(self._nextDataIndex)
  if data ~= nil then
    local subCategoriIndex = data:getCategoriIndex()
    local data = ToClient_GetContentsTutorialDataBySubCategoriIndex(subCategoriIndex)
    self._nextDataIndex = data:getIndex()
    self._nextDataIndex = self._nextDataIndex + 1
    local functionCount = data:getFunctionCount()
    for ii = 0, functionCount - 1 do
      local funcString = data:getFunctionString(ii)
      if funcString == nil or funcString == "" then
        return false
      end
      local strSplitParam = string.split(funcString, "(")
      local func = strSplitParam[1]
      if func == nil or strSplitParam[2] == nil then
        return false
      end
      local strSplitParam2 = string.split(strSplitParam[2], ")")
      local funcParam = strSplitParam2[1]
      if self:executeTutorialData(func, funcParam, subCategoriIndex) == false then
        return false
      end
    end
  end
end
function PaGlobal_ContentsTutorial_All:clear()
  if Panel_ContentsTutorial_All == nil then
    return
  end
  self._tutorialKey = -1
  self._tutorialDataCount = 0
  self._nextDataIndex = 0
  self._prevUIMode = nil
  self._curWaitingType = self._eWaitingType.NO_WATING
  self._uiInputType = nil
  self._uiInputTypeFunc = nil
  self._uiInputTypeFuncParam = nil
  self._checkResult = false
  self._watingTime = 0
  self._curWatingTime = 0
  self._isSetWatingSkipTime = false
  self._ui._stc_blackBg:SetShow(false)
  self._ui._stc_guideBg:SetShow(false)
  self._ui._stc_guideImageBG:SetShow(false)
  self:resetTempControl()
  Panel_ContentsTutorial_All:ClearUpdateLuaFunc()
end
function PaGlobal_ContentsTutorial_All:resetTempControl()
  ClearFocusEdit()
  for _, control in ipairs(self._tmpControl) do
    if control ~= nil then
      control:EraseAllEffect()
      control:addInputEvent("Mouse_LUp", "")
      control:addInputEvent("Mouse_RUp", "")
      if control:GetType() == __ePAUIControl_Edit then
        control:SetEditText("")
      end
      control:SetShow(false)
    end
  end
  if self._copyTargetControl ~= nil then
    self._copyTargetControl:EraseAllEffect()
    if self._isNoneCopyControl == false then
      if self._copyTargetControl:GetType() == __ePAUIControl_Edit then
        self._copyTargetControl:SetEditText("")
      end
      self._copyTargetControl:addInputEvent("Mouse_LUp", "")
      self._copyTargetControl:addInputEvent("Mouse_RUp", "")
      self._copyTargetControl:SetShow(false)
    end
  end
  self._realTargetControl = nil
  self._copyTargetControl = nil
  self._isNoneCopyControl = false
end
function PaGlobal_ContentsTutorial_All:openCheckAndLoadFile(fileName, tutorialKey)
  if Panel_ContentsTutorial_All == nil then
    return false
  end
  if _ContentsGroup_ContentsTutorial == false then
    return false
  end
  if self._isConsole == true then
    return false
  end
  if fileName == nil or tutorialKey == nil then
    return false
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return false
  end
  if self._eTutorialType.PET == tutorialKey then
    local unsealPetCount = ToClient_getPetUnsealedList()
    for index = 0, unsealPetCount - 1 do
      local pcPetData = ToClient_getPetUnsealedDataByIndex(index)
      if pcPetData ~= nil then
        local petStaticStatus = pcPetData:getPetStaticStatus()
        if petStaticStatus ~= nil and 4 <= petStaticStatus:getPetTier() then
          return false
        end
      end
    end
    local sealPetCount = ToClient_getPetSealedList()
    for index = 0, sealPetCount - 1 do
      local pcPetData = ToClient_getPetSealedDataByIndex(index)
      if pcPetData ~= nil then
        local petStaticStatus = pcPetData:getPetStaticStatus()
        if petStaticStatus ~= nil and 4 <= petStaticStatus:getPetTier() then
          return false
        end
      end
    end
  else
    if self._eTutorialType.VIPIKO == tutorialKey then
      local pcPosition = selfPlayer:get():getPosition()
      local regionInfo = getRegionInfoByPosition(pcPosition)
      if nil == regionInfo then
        return false
      end
      if false == regionInfo:get():isSafeZone() then
        return false
      end
    else
    end
  end
  self:resize()
  self:clear()
  if ToClient_LoadContentsTutorialData(fileName, tutorialKey) ~= 0 then
    return false
  end
  local tutorialDataCount = ToClient_GetContentsTutorialDataCount()
  if tutorialDataCount <= 0 then
    return false
  end
  local tutorialNameKey = ToClient_GetContentsTutorialName()
  if tutorialNameKey == nil then
    return false
  end
  self._ui._txt_guideTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, tutorialNameKey))
  self._tutorialKey = tutorialKey
  self._tutorialDataCount = tutorialDataCount
  return true
end
function PaGlobal_ContentsTutorial_All:prepareOpen()
  if Panel_ContentsTutorial_All == nil then
    return
  end
  if self._tutorialKey == -1 or self._tutorialDataCount == 0 then
    if isGameServiceTypeDev() == true then
      _PA_LOG("\236\161\176\234\180\145\235\175\188", "[ContentsTutorial OpenFailed] prepareOpen\237\152\184\236\182\156 \236\160\132 openCheckAndLoadFile \235\165\188 \235\168\188\236\160\128 \237\152\184\236\182\156\237\149\180\236\163\188\236\132\184\236\154\148.")
    end
    return
  end
  local isOffUi = ToClient_GetContentsTutorialIsOffUI()
  if isOffUi == true then
    close_WindowPanelList()
  end
  ToClient_blockCameraRotate(true)
  self._isSetCameraBlock = true
  self._prevUIMode = GetUIMode()
  SetUIMode(Defines.UIMode.eUIMode_Tutorial)
  if isGameServiceTypeDev() == true then
    _PA_LOG("\236\161\176\234\180\145\235\175\188", "[ContentsTutorial Start] tutorialKey(" .. tostring(self._tutorialKey) .. ")")
  end
  if self:updateNextTutorialData() == false then
    PaGlobalFunc_ContentsTutorial_All_Close()
    return
  end
  Panel_ContentsTutorial_All:RegisterUpdateFunc("PaGlobalFunc_ContentsTutorial_All_UpdatePerFrame")
  self._ui._stc_messageBox:SetShow(false)
  self:open()
end
function PaGlobal_ContentsTutorial_All:open()
  if Panel_ContentsTutorial_All == nil then
    return
  end
  Panel_ContentsTutorial_All:SetShow(true)
end
function PaGlobal_ContentsTutorial_All:prepareClose()
  if Panel_ContentsTutorial_All == nil then
    return
  end
  if self._tutorialKey ~= -1 and isGameServiceTypeDev() == true then
    _PA_LOG("\236\161\176\234\180\145\235\175\188", "[ContentsTutorial End] tutorialKey(" .. tostring(self._tutorialKey) .. ")")
  end
  ToClient_ClearContentsTutorialData()
  if self._prevUIMode ~= nil and GetUIMode() == Defines.UIMode.eUIMode_Tutorial then
    SetUIMode(self._prevUIMode)
  end
  if self._isSetCameraBlock == true then
    ToClient_blockCameraRotate(false)
    self._isSetCameraBlock = false
  end
  self:clear()
  self:close()
end
function PaGlobal_ContentsTutorial_All:close()
  if Panel_ContentsTutorial_All == nil then
    return
  end
  Panel_ContentsTutorial_All:SetShow(false)
end
function PaGlobal_ContentsTutorial_All:updateTutorial(deltaTime)
  if Panel_ContentsTutorial_All == nil or Panel_ContentsTutorial_All:GetShow() == false then
    return
  end
  if self._tutorialDataCount < self._nextDataIndex then
    PaGlobalFunc_ContentsTutorial_All_Close()
    return
  end
  if self._curWaitingType == self._eWaitingType.NO_WATING then
    self._updateFunc = nil
    if self:updateNextTutorialData() == false then
      PaGlobalFunc_ContentsTutorial_All_Close()
    end
  elseif self:updateWaiting(deltaTime) == false then
    PaGlobalFunc_ContentsTutorial_All_Close()
  end
  if self._updateFunc ~= nil then
    self._updateFunc()
  end
end
function PaGlobal_ContentsTutorial_All:updateNextTutorialData()
  if Panel_ContentsTutorial_All == nil then
    return false
  end
  local data = ToClient_GetContentsTutorialData(self._nextDataIndex)
  if data == nil then
    return false
  end
  if data:getTutorialKey() ~= self._tutorialKey then
    return false
  end
  local subCategoriIndex = data:getCategoriIndex()
  self._nextDataIndex = self._nextDataIndex + 1
  local functionCount = data:getFunctionCount()
  for ii = 0, functionCount - 1 do
    local funcString = data:getFunctionString(ii)
    if funcString == nil or funcString == "" then
      return false
    end
    local strSplitParam = string.split(funcString, "(")
    local func = strSplitParam[1]
    if func == nil or strSplitParam[2] == nil then
      return false
    end
    local strSplitParam2 = string.split(strSplitParam[2], ")")
    local funcParam = strSplitParam2[1]
    if self:executeTutorialData(func, funcParam, subCategoriIndex) == false then
      return false
    end
  end
  return true
end
function PaGlobal_ContentsTutorial_All:updateWaiting(deltaTime)
  if Panel_ContentsTutorial_All == nil then
    return false
  end
  if self._curWaitingType == self._eWaitingType.INPUT_SPACE then
    if keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Jump) == true then
      self._curWaitingType = self._eWaitingType.NO_WATING
    end
  elseif self._curWaitingType == self._eWaitingType.INPUT_ENTER then
    if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_RETURN) == true then
      if self._realTargetControl ~= nil and self._copyTargetControl ~= nil and self._copyTargetControl:GetType() == __ePAUIControl_Edit and self._copyTargetControl:GetType() == self._copyTargetControl:GetType() then
        local editText = self._copyTargetControl:GetEditText()
        if editText == nil or editText == "" then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNameCharacterIsInvalid"))
          return
        end
        self._realTargetControl:SetEditText(self._copyTargetControl:GetEditText())
        self._copyTargetControl:SetEditText("")
        self._copyTargetControl:SetShow(false)
        ClearFocusEdit()
      end
      self._curWaitingType = self._eWaitingType.NO_WATING
    end
  elseif self._curWaitingType == self._eWaitingType.UI_INPUT_TYPE then
    if self._uiInputType == keyCustom_GetProcessedUiInputType() and GlobalKeyBinder_CheckKeyPressed(CppEnums.VirtualKeyCode.KeyCode_MENU) == false and isPhotoMode() == false then
      self._uiInputTypeFunc(self._uiInputTypeFuncParam)
      self._uiInputType = nil
      self._uiInputTypeFunc = nil
      self._uiInputTypeFuncParam = nil
      self._curWaitingType = self._eWaitingType.NO_WATING
    end
  elseif self._curWaitingType == self._eWaitingType.SHOW_CONTROL then
    if self._realTargetControl == nil then
      return false
    end
    if self._realTargetControl:GetShow() == true then
      self._curWaitingType = self._eWaitingType.NO_WATING
    end
  elseif self._curWaitingType == self._eWaitingType.HIDE_CONTROL then
    if self._realTargetControl == nil then
      return false
    end
    if self._realTargetControl:GetShow() == false then
      self._curWaitingType = self._eWaitingType.NO_WATING
    end
  elseif self._curWaitingType == self._eWaitingType.TIMER then
    self._curWatingTime = self._curWatingTime + deltaTime
    if self._watingTime < self._curWatingTime then
      self._watingTime = 0
      self._curWatingTime = 0
      self._curWaitingType = self._eWaitingType.NO_WATING
    end
  end
  if self._isSetWatingSkipTime == true then
    local isReset = false
    if self._curWaitingType == self._eWaitingType.NO_WATING then
      isReset = true
    else
      self._curWatingTime = self._curWatingTime + deltaTime
      if self._watingTime < self._curWatingTime then
        isReset = true
      end
    end
    if isReset == true then
      self._watingTime = 0
      self._curWatingTime = 0
      self._isSetWatingSkipTime = false
      self._curWaitingType = self._eWaitingType.NO_WATING
    end
  end
  return true
end
function PaGlobal_ContentsTutorial_All:findControlByFuncString(funcParam)
  if funcParam == nil then
    return nil
  end
  local controlDepthList = string.split(funcParam, "/")
  local targetControl
  for ii = 1, #controlDepthList do
    local controlName = controlDepthList[ii]
    if controlName == nil then
      return nil
    end
    if targetControl == nil then
      targetControl = ToClient_getPanelByKey(ToClient_computeHashCode(controlName))
    elseif targetControl:GetType() == __ePAUIControl_List2 then
      local index = Int64toInt32(tonumber64(controlName))
      local key = targetControl:getKeyByIndex(index)
      targetControl = targetControl:GetContentByKey(key)
    else
      targetControl = UI.getChildControl(targetControl, controlName)
    end
    if targetControl == nil then
      return nil
    end
  end
  return targetControl
end
function PaGlobal_ContentsTutorial_All:targetControl(targetControl)
  if targetControl == nil then
    return false
  end
  self:resetTempControl()
  local controlType = targetControl:GetType()
  self._isNoneCopyControl = controlType == __ePAUIControl_Panel or controlType == __ePAUIControl_List2Content
  self._realTargetControl = targetControl
  if self._tmpControl[controlType] == nil then
    if self._isNoneCopyControl == true then
      self._tmpControl[controlType] = targetControl
    else
      self._tmpControl[controlType] = UI.createControl(controlType, Panel_ContentsTutorial_All, "Static_Temp_" .. tostring(controlType))
    end
  end
  if self._tmpControl[controlType] == nil then
    return false
  end
  if self._isNoneCopyControl == true then
    self._copyTargetControl = self._tmpControl[controlType]
    if self._copyTargetControl == nil then
      return false
    end
  else
    CopyBaseProperty(self._realTargetControl, self._tmpControl[controlType])
    self._copyTargetControl = self._tmpControl[controlType]
    if self._copyTargetControl == nil then
      return false
    end
    self._copyTargetControl:ChangeTextureInfoNameAsync("")
    if controlType == __ePAUIControl_Button then
      self._copyTargetControl:ChangeOnTextureInfoNameAsync("")
      self._copyTargetControl:ChangeClickTextureInfoNameAsync("")
    end
    if controlType == __ePAUIControl_RadioButton then
      self._copyTargetControl:SetTextMode(__eTextMode_None)
    end
    local controlRealPos = {
      x = self._realTargetControl:GetParentPosX(),
      y = self._realTargetControl:GetParentPosY()
    }
    local controlSize = {
      x = self._realTargetControl:GetSizeX(),
      y = self._realTargetControl:GetSizeY()
    }
    self._copyTargetControl:SetSpanSize(0, 0)
    self._copyTargetControl:SetPosX(controlRealPos.x)
    self._copyTargetControl:SetPosY(controlRealPos.y)
    self._copyTargetControl:SetShow(true)
    if controlType == __ePAUIControl_Edit then
      self._copyTargetControl:SetEditText("")
      self._realTargetControl:SetEditText("")
    elseif controlType == __ePAUIControl_CheckButton then
      self._copyTargetControl:SetCheck(self._realTargetControl:IsCheck())
    end
  end
  return true
end
function PaGlobal_ContentsTutorial_All:focusControl()
  if self._realTargetControl == nil or self._copyTargetControl == nil then
    return false
  end
  local controlRealPos = {
    x = self._realTargetControl:GetParentPosX(),
    y = self._realTargetControl:GetParentPosY()
  }
  local controlSize = {
    x = self._realTargetControl:GetSizeX(),
    y = self._realTargetControl:GetSizeY()
  }
  local uiScale = getGlobalScale()
  local screenSizeX = getResolutionSizeX() / uiScale
  local screenSizeY = getResolutionSizeY() / uiScale
  self._ui._stc_blackTopBg:SetSize(screenSizeX, controlRealPos.y)
  self._ui._stc_blackBottomBg:SetSize(screenSizeX, screenSizeY - (controlRealPos.y + controlSize.y))
  self._ui._stc_blackLeftBg:SetSize(controlRealPos.x, controlSize.y)
  self._ui._stc_blackLeftBg:SetSpanSize(self._ui._stc_blackLeftBg:GetSpanSize().x, controlRealPos.y)
  self._ui._stc_blackRightBg:SetSize(screenSizeX - (controlRealPos.x + controlSize.x), controlSize.y)
  self._ui._stc_blackRightBg:SetSpanSize(self._ui._stc_blackRightBg:GetSpanSize().x, controlRealPos.y)
  self._ui._stc_blackBg:ComputePosAllChild()
  self._ui._stc_blackBg:SetShow(true)
  self._ui._stc_blackTopBg:SetShow(true)
  self._ui._stc_blackBottomBg:SetShow(true)
  self._ui._stc_blackLeftBg:SetShow(true)
  self._ui._stc_blackRightBg:SetShow(true)
  return true
end
function PaGlobal_ContentsTutorial_All:setInputTypeFunction(UIInputType)
  self._uiInputTypeFunc = nil
  self._uiInputTypeFuncParam = nil
  if UIInputType == nil or UIInputType == __eUiInputType_Undefined then
    return false
  end
  if UIInputType == __eUiInputType_Inventory then
    function self._uiInputTypeFunc()
      InventoryWindow_Show(true)
    end
  end
  if UIInputType == __eUiInputType_Present then
    function self._uiInputTypeFunc()
      Process_UIMode_CommonWindow_Present()
    end
  end
  if UIInputType == __eUiInputType_Manufacture then
    function self._uiInputTypeFunc()
      Process_UIMode_CommonWindow_Manufacture()
    end
  end
  if self._uiInputTypeFunc == nil then
    return false
  end
  return true
end
function PaGlobal_ContentsTutorial_All:executeTutorialData(func, funcParam, subCategoriIndex)
  if Panel_ContentsTutorial_All == nil then
    return false
  end
  if func == nil or func == "" then
    return false
  end
  local isSuccess = false
  if func == "CloseWindowPanelList" then
    isSuccess = self:executeCloseWindowPanelList(funcParam)
  elseif func == "ShowFullBlackBG" then
    isSuccess = self:executeShowFullBlackBG(funcParam)
  elseif func == "SetShowGuide" then
    isSuccess = self:executeSetShowGuide(funcParam)
  elseif func == "SetShowGuideImage" then
    isSuccess = self:executeSetShowGuideImage(funcParam)
  elseif func == "TargetControl" then
    isSuccess = self:executeTargetControl(funcParam)
  elseif func == "TargetEvent" then
    isSuccess = self:executeTargetEvent(funcParam)
  elseif func == "Waiting" then
    isSuccess = self:executeWaiting(funcParam)
  elseif func == "SetWatingSkipTime" then
    isSuccess = self:executeSetWatingSkipTime(funcParam)
  elseif func == "Check" then
    isSuccess = self:executeCheck(funcParam)
  elseif func == "CheckExecute" then
    isSuccess = self:executeCheckExecute(funcParam)
  elseif func == "SetShowPanel" then
    isSuccess = self:executeSetShowPanel(funcParam)
  elseif func == "EndManufacture" then
    isSuccess = self:executeEndManufacture(funcParam)
  end
  if isSuccess == true then
    _PA_LOG("\236\161\176\234\180\145\235\175\188", "[SUCCESS] [" .. tostring(self._nextDataIndex - 1) .. "], subCategori(" .. tostring(subCategoriIndex) .. "), " .. tostring(func) .. "(" .. tostring(funcParam) .. ")")
  else
    _PA_LOG("\236\161\176\234\180\145\235\175\188", "[FAILED] [" .. tostring(self._nextDataIndex - 1) .. "], subCategori(" .. tostring(subCategoriIndex) .. "), " .. tostring(func) .. "(" .. tostring(funcParam) .. ")")
  end
  return isSuccess
end
function PaGlobal_ContentsTutorial_All:executeCloseWindowPanelList(funcParam)
  self:resetTempControl()
  close_WindowPanelList()
  return true
end
function PaGlobal_ContentsTutorial_All:executeShowFullBlackBG(funcParam)
  local uiScale = getGlobalScale()
  local screenSizeX = getResolutionSizeX() / uiScale
  local screenSizeY = getResolutionSizeY() / uiScale
  self._ui._stc_blackBg:ComputePosAllChild()
  self._ui._stc_blackBg:SetShow(true)
  self._ui._stc_blackTopBg:SetShow(true)
  self._ui._stc_blackTopBg:SetSize(screenSizeX, screenSizeY)
  self._ui._stc_blackBottomBg:SetShow(false)
  self._ui._stc_blackLeftBg:SetShow(false)
  self._ui._stc_blackRightBg:SetShow(false)
  return true
end
function PaGlobal_ContentsTutorial_All:executeSetShowGuide(funcParam)
  if funcParam == nil then
    return false
  end
  local paramList = string.split(funcParam, ":")
  if paramList[1] == nil then
    return false
  end
  local isShow = paramList[1] == "true"
  if isShow == true then
    if paramList[2] == nil then
      return false
    end
    local strSplitParam = string.split(paramList[2], "|")
    local strAlignX = strSplitParam[1]
    local strAlignY = strSplitParam[2]
    local strSpanX = strSplitParam[3]
    local strSpanY = strSplitParam[4]
    local stringParam = strSplitParam[5]
    if strAlignX == nil or strAlignY == nil or strSpanX == nil or strSpanY == nil or stringParam == nil then
      return false
    end
    local stringKeySplitParam = string.split(stringParam, "/")
    local stringSheetType = stringKeySplitParam[1]
    local stringKey = stringKeySplitParam[2]
    if stringSheetType == nil or stringKey == nil then
      return false
    end
    local sheetType = Defines.StringSheet_GAME
    if stringSheetType == "GAME" then
      sheetType = Defines.StringSheet_GAME
    elseif stringSheetType == "RESOURCE" then
      sheetType = Defines.StringSheet_RESOURCE
    else
      return false
    end
    local spanX = 0
    local spanY = 0
    if strAlignX == "Right" or strAlignX == "RIGHT" then
      spanX = Panel_ContentsTutorial_All:GetSizeX() - self._ui._stc_guideBg:GetSizeX() - Int64toInt32(tonumber64(strSpanX))
    elseif strAlignX == "Left" or strAlignX == "LEFT" then
      spanX = Int64toInt32(tonumber64(strSpanX))
    else
      return false
    end
    if strAlignY == "Bottom" or strAlignY == "BOTTOM" then
      spanY = Panel_ContentsTutorial_All:GetSizeY() - self._ui._stc_guideBg:GetSizeY() - Int64toInt32(tonumber64(strSpanY))
    elseif strAlignY == "Top" or strAlignY == "TOP" then
      spanY = Int64toInt32(tonumber64(strSpanY))
    else
      return false
    end
    self._ui._stc_guideBg:SetSpanSize(spanX + 100, spanY)
    local desc = PAGetString(sheetType, stringKey)
    self._ui._txt_guideDesc:SetText(desc)
    self._ui._stc_nextIcon:SetShow(false)
  else
    self._ui._txt_guideDesc:SetText("")
  end
  self._ui._stc_guideBg:SetShow(isShow)
  return true
end
function PaGlobal_ContentsTutorial_All:executeSetShowGuideImage(funcParam)
  if funcParam == nil then
    return false
  end
  local paramList = string.split(funcParam, ":")
  if paramList[1] == nil then
    return false
  end
  local isShow = paramList[1] == "true"
  if isShow == true then
    if paramList[2] == nil then
      return false
    end
    local strSplitParam = string.split(paramList[2], "|")
    local strSpanX = strSplitParam[1]
    local strSpanY = strSplitParam[2]
    local strSizeX = strSplitParam[3]
    local strSizeY = strSplitParam[4]
    local imagePath = strSplitParam[5]
    local strUVX1 = strSplitParam[6]
    local strUVY1 = strSplitParam[7]
    local strUVX2 = strSplitParam[8]
    local strUVY2 = strSplitParam[9]
    if strSpanX == nil or strSpanY == nil or strSizeX == nil or strSizeY == nil or imagePath == nil or strUVX1 == nil or strUVY1 == nil or strUVX2 == nil or strUVY2 == nil then
      return false
    end
    local UV = {
      x1 = Int64toInt32(tonumber64(strUVX1)),
      y1 = Int64toInt32(tonumber64(strUVY1)),
      x2 = Int64toInt32(tonumber64(strUVX2)),
      y2 = Int64toInt32(tonumber64(strUVY2))
    }
    self._ui._stc_guideImage:ChangeTextureInfoNameAsync(imagePath)
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_guideImage, UV.x1, UV.y1, UV.x2, UV.y2)
    self._ui._stc_guideImage:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_guideImage:setRenderTexture(self._ui._stc_guideImage:getBaseTexture())
    local sizeX = Int64toInt32(tonumber64(strSizeX))
    local sizeY = Int64toInt32(tonumber64(strSizeY))
    self._ui._stc_guideImage:SetSize(sizeX, sizeY)
    local spanX = Int64toInt32(tonumber64(strSpanX))
    local spanY = Int64toInt32(tonumber64(strSpanY))
    self._ui._stc_guideImage:SetSpanSize(spanX, spanY)
  end
  self._ui._stc_guideImageBG:SetShow(isShow)
  return true
end
function PaGlobal_ContentsTutorial_All:executeTargetControl(funcParam)
  if funcParam == nil then
    return false
  end
  local paramList = string.split(funcParam, ":")
  if paramList[1] == nil then
    return false
  end
  local isTargetSuccess = false
  if paramList[1] == "Item" or paramList[1] == "ItemMarketInventory" or paramList[1] == "ItemMarketWallet" or paramList[1] == "ItemMarketWalletInventory" then
    if paramList[2] == nil then
      return false
    end
    local itemKeyRaw = Int64toInt32(tonumber64(paramList[2]))
    if self._isConsole == false then
      do
        local foundSlot, scrollInfo
        if paramList[1] == "ItemMarketInventory" then
          foundSlot, scrollInfo = PaGlobal_MarketPlace_MyInven_All_FindItemSlot(itemKeyRaw)
        elseif paramList[1] == "ItemMarketWallet" then
          PaGlobalFunc_MarketPlace_Wallet_SelectView(1)
          foundSlot, scrollInfo = PaGlobal_MarketPlace_Wallet_All_FindItemSlot(itemKeyRaw)
        elseif paramList[1] == "ItemMarketWalletInventory" then
          foundSlot, scrollInfo = PaGlobal_MarketPlace_WalletInven_All_FindItemSlot(itemKeyRaw)
        elseif paramList[1] == "Item" then
          foundSlot, scrollInfo = PaGlobal_Inventory_All_FindItemSlot(itemKeyRaw)
        else
          return false
        end
        if self:targetControl(foundSlot) == false then
          return false
        end
        function self._updateFunc()
          if self._realTargetControl == nil or self._copyTargetControl == nil then
            return false
          end
          if scrollInfo == nil then
            return false
          end
          if scrollInfo._isCategory == true then
            PaGlobal_Inventory_All._ui.frame_categoryVerticalScroll:SetControlPos(scrollInfo._pos)
            PaGlobal_Inventory_All._ui.frame_category:UpdateContentScroll()
            PaGlobal_Inventory_All._ui.frame_category:UpdateContentPos()
          elseif scrollInfo._isCategory == false then
            PaGlobal_Inventory_All._ui.scroll_inven:SetControlPos(scrollInfo._pos)
          end
          self._copyTargetControl:SetSpanSize(0, 0)
          self._copyTargetControl:SetPosX(self._realTargetControl:GetParentPosX())
          self._copyTargetControl:SetPosY(self._realTargetControl:GetParentPosY())
          self._copyTargetControl:SetShow(true)
          self:focusControl()
        end
        isTargetSuccess = true
      end
    else
      if Panel_Window_Inventory == nil or Panel_Window_Inventory:GetShow() == false then
        return false
      end
      return false
    end
  else
    isTargetSuccess = self:targetControl(self:findControlByFuncString(paramList[1]))
  end
  return isTargetSuccess
end
function PaGlobal_ContentsTutorial_All:executeTargetEvent(funcParam)
  if funcParam == nil then
    return false
  end
  local paramList = string.split(funcParam, ":")
  local eventType = paramList[1]
  if eventType == nil then
    return false
  end
  if eventType == "LUp" then
    if self._realTargetControl == nil then
      return false
    end
    ToClient_ExecuteHandleEventByControl(PaGlobal_ContentsTutorial_All._realTargetControl, "Mouse_LUp")
  elseif eventType == "RUp" then
    if self._realTargetControl == nil then
      return false
    end
    ToClient_ExecuteHandleEventByControl(PaGlobal_ContentsTutorial_All._realTargetControl, "Mouse_RUp")
  elseif eventType == "Focus" then
    if self._updateFunc == nil then
      function self._updateFunc()
        self:focusControl()
      end
      return true
    end
    return self:focusControl()
  elseif eventType == "AddEffect" then
    if paramList[2] == nil then
      return false
    end
    if self._copyTargetControl == nil then
      return false
    end
    local effectInfoList = string.split(paramList[2], "/")
    local effectName = effectInfoList[1]
    if effectName == nil then
      return false
    end
    local isLoop = effectInfoList[2] == "true"
    local offsetX = 0
    if effectInfoList[3] ~= nil then
      offsetX = effectInfoList[3]
    end
    local offsetY = effectInfoList[4]
    if effectInfoList[4] ~= nil then
      offsetY = effectInfoList[4]
    end
    self._copyTargetControl:EraseAllEffect()
    self._copyTargetControl:AddEffect(effectName, isLoop, offsetX, offsetY)
  elseif eventType == "EraseEffect" then
    for _, control in ipairs(self._tmpControl) do
      if control ~= nil then
        control:EraseAllEffect()
      end
    end
    if self._copyTargetControl ~= nil then
      self._copyTargetControl:EraseAllEffect()
    end
  else
    return false
  end
  return true
end
function PaGlobal_ContentsTutorial_All:executeWaiting(funcParam)
  if funcParam == nil then
    return false
  end
  local paramList = string.split(funcParam, ":")
  local watingType = paramList[1]
  local watingValue = paramList[2]
  if watingType == "Timer" then
    if watingValue == nil then
      return false
    end
    self._watingTime = Int64toInt32(tonumber64(watingValue))
    self._curWatingTime = 0
    self._curWaitingType = self._eWaitingType.TIMER
    self._isSetWatingSkipTime = false
  elseif watingType == "ShowControl" then
    if watingValue == nil then
      return false
    end
    local targetControl = self:findControlByFuncString(watingValue)
    if targetControl == nil then
      return false
    end
    self:resetTempControl()
    self._realTargetControl = targetControl
    self._curWaitingType = self._eWaitingType.SHOW_CONTROL
  elseif watingType == "HideControl" then
    if watingValue == nil then
      return false
    end
    local targetControl = self:findControlByFuncString(watingValue)
    if targetControl == nil then
      return false
    end
    self:resetTempControl()
    self._realTargetControl = targetControl
    self._curWaitingType = self._eWaitingType.HIDE_CONTROL
  elseif watingType == "Input" then
    if watingValue == nil then
      return false
    end
    if watingValue == "SpaceBar" then
      if self._ui._stc_guideBg:GetShow() == true then
        self._ui._stc_nextIcon:SetShow(true)
        self._ui._txt_next:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TUTORIAL_SPACEKEY"))
      end
      self._curWaitingType = self._eWaitingType.INPUT_SPACE
    elseif watingValue == "Enter" then
      self._curWaitingType = self._eWaitingType.INPUT_ENTER
    elseif watingValue == "LUp" then
      if self._realTargetControl == nil then
        return false
      end
      if self._copyTargetControl == nil then
        return false
      end
      self._curWaitingType = self._eWaitingType.INPUT_MOUSE
      self._copyTargetControl:SetIgnore(false)
      self._copyTargetControl:SetEnable(true)
      self._copyTargetControl:addInputEvent("Mouse_LUp", "HandleEventLUp_ContentsTutorial_All_Execute()")
    elseif watingValue == "RUp" then
      if self._realTargetControl == nil then
        return false
      end
      if self._copyTargetControl == nil then
        return false
      end
      self._curWaitingType = self._eWaitingType.INPUT_MOUSE
      self._copyTargetControl:SetIgnore(false)
      self._copyTargetControl:SetEnable(true)
      self._copyTargetControl:addInputEvent("Mouse_RUp", "HandleEventRUp_ContentsTutorial_All_Execute()")
    else
      local UIInputType = UIInputTypeToEnum(watingValue)
      if UIInputType == __eUiInputType_Undefined then
        return false
      end
      if self:setInputTypeFunction(UIInputType) == false then
        return false
      end
      self._uiInputType = UIInputType
      self._curWaitingType = self._eWaitingType.UI_INPUT_TYPE
    end
  else
    return false
  end
  return true
end
function PaGlobal_ContentsTutorial_All:executeSetWatingSkipTime(funcParam)
  if funcParam == nil then
    return false
  end
  self._watingTime = Int64toInt32(tonumber64(funcParam))
  self._curWatingTime = 0
  self._isSetWatingSkipTime = true
end
function PaGlobal_ContentsTutorial_All:exchangeTimeReset()
  self._watingTime = 0
  self._curWatingTime = 0
  self._isSetWatingSkipTime = false
  self._curWaitingType = self._eWaitingType.NO_WATING
end
function PaGlobal_ContentsTutorial_All:executeCheck(funcParam)
  if funcParam == nil then
    return false
  end
  local paramList = string.split(funcParam, ":")
  local checkType = paramList[1]
  local checkParam = paramList[2]
  if checkType == "ShowControl" then
    local checkControl = self:findControlByFuncString(checkParam)
    if checkControl == nil then
      return false
    end
    self._checkResult = checkControl:GetShow()
  elseif checkType == "HideControl" then
    local checkControl = self:findControlByFuncString(checkParam)
    if checkControl == nil then
      return false
    end
    self._checkResult = not checkControl:GetShow()
  elseif checkType == "IsCheck" then
    local checkControl = self:findControlByFuncString(checkParam)
    if checkControl == nil then
      return false
    end
    if checkControl:GetType() ~= __ePAUIControl_CheckButton then
      return false
    end
    self._checkResult = checkControl:IsCheck()
  elseif checkType == "MessageBoxSelect" then
    if PaGlobalFunc_MessageBox_GetSelectResult == nil then
      return false
    end
    self._checkResult = PaGlobalFunc_MessageBox_GetSelectResult()
  else
    return false
  end
  return true
end
function PaGlobal_ContentsTutorial_All:executeCheckExecute(funcParam)
  if funcParam == nil then
    return false
  end
  local paramList = string.split(funcParam, ":")
  if paramList[1] == nil or paramList[2] == nil then
    return false
  end
  local checkType = false
  if paramList[1] == "true" then
    checkType = true
  end
  local checkParamList = string.split(paramList[2], "/")
  local executeType = checkParamList[1]
  if executeType == nil then
    return false
  end
  if executeType == "Index" then
    if self._checkResult == checkType then
      local indexParam = checkParamList[2]
      if indexParam == nil then
        return false
      end
      local index = Int64toInt32(tonumber64(indexParam))
      local checkData = ToClient_GetContentsTutorialDataBySubCategoriIndex(index)
      if checkData == nil then
        return false
      end
      self:resetTempControl()
      self._nextDataIndex = checkData:getIndex()
    end
  elseif executeType == "Exit" then
    if self._checkResult == checkType then
      return false
    end
  else
    return false
  end
  return true
end
function PaGlobal_ContentsTutorial_All:executeSetShowPanel(funcParam)
  if funcParam == nil then
    return false
  end
  if funcParam == "ServantIcon" then
    if Panel_Widget_ServantIcon == nil then
      return false
    end
    if Panel_Widget_ServantIcon:GetShow() == true then
      return true
    end
    if PaGlobalFunc_ServantIcon_OnResize == nil or PaGlobalFunc_MainStatus_GetPosY == nil or PaGlobalFunc_MainStatus_GetSizeY == nil then
      return false
    end
    PaGlobalFunc_ServantIcon_OnResize()
    Panel_Widget_ServantIcon:SetShow(true)
    Panel_Widget_ServantIcon:SetPosX(10)
    Panel_Widget_ServantIcon:SetPosY(PaGlobalFunc_MainStatus_GetPosY() + PaGlobalFunc_MainStatus_GetSizeY() - 50)
  else
    return false
  end
  return true
end
function PaGlobal_ContentsTutorial_All:executeEndManufacture(funcParam)
  StopManufactureAction()
  FromClient_Manufacture_All_EmergencyEvadeActionStart()
  PaGlobalFunc_Manufacture_Notify_All_IsManufactureChk()
  return true
end
function PaGlobalFunc_ContentsTutorial_All_Open(fileName, tutorialKey)
  if _ContentsGroup_ContentsTutorial == false then
    return
  end
  if PaGlobal_ContentsTutorial_All:openCheckAndLoadFile(fileName, tutorialKey) == false then
    return
  end
  local isOffUi = ToClient_GetContentsTutorialIsOffUI()
  if isOffUi == true and PaGlobalFunc_DialogMain_All_Close ~= nil then
    PaGlobalFunc_DialogMain_All_Close()
  end
  local startTutorial = function()
    PaGlobal_ContentsTutorial_All:prepareOpen()
  end
  local tutorialNameKey = ToClient_GetContentsTutorialName()
  if tutorialNameKey == nil then
    return false
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetString(Defines.StringSheet_RESOURCE, tutorialNameKey) .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_OBSIDIAN_TEXT_NEW_KR_29"),
    functionYes = startTutorial,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if tutorialKey == PaGlobal_ContentsTutorial_All._eTutorialType.VIPIKO then
    messageboxData.content = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_START_MSG_VIPIKO")
  end
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobalFunc_ContentsTutorial_All_Close()
  PaGlobal_ContentsTutorial_All:prepareClose()
end
function PaGlobalFunc_ContentsTutorial_All_CancleTutorial()
  if Panel_ContentsTutorial_All == nil then
    return
  end
  if PaGlobal_ContentsTutorial_All._tutorialKey == -1 or PaGlobal_ContentsTutorial_All._tutorialDataCount == 0 then
    return
  end
  if PaGlobal_ContentsTutorial_All._ui._stc_messageBox:GetShow() == true then
    PaGlobalFunc_ContentsTutorial_All_Refuse()
    return
  end
  if PaGlobal_ContentsTutorial_All._copyTargetControl ~= nil then
    PaGlobal_ContentsTutorial_All._copyTargetControl:SetShow(false)
  end
  PaGlobal_ContentsTutorial_All._ui._stc_messageText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_TUTORIAL_EXIT_DESC"))
  PaGlobal_ContentsTutorial_All._ui._stc_btn_Yes:addInputEvent("Mouse_LUp", "PaGlobalFunc_ContentsTutorial_All_Close()")
  PaGlobal_ContentsTutorial_All._ui._stc_btn_No:addInputEvent("Mouse_LUp", "PaGlobalFunc_ContentsTutorial_All_Refuse()")
  PaGlobal_ContentsTutorial_All._ui._stc_btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_ContentsTutorial_All_Refuse()")
  PaGlobal_ContentsTutorial_All._ui._stc_btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ContentsTutorial_All_Refuse()")
  PaGlobal_ContentsTutorial_All._ui._stc_messageBox:SetShow(true)
end
function PaGlobalFunc_ContentsTutorial_All_Refuse()
  PaGlobal_ContentsTutorial_All._ui._stc_messageBox:SetShow(false)
  if PaGlobal_ContentsTutorial_All._copyTargetControl ~= nil then
    PaGlobal_ContentsTutorial_All._copyTargetControl:SetShow(true)
  end
end
function PaGlobalFunc_ContentsTutorial_All_UpdatePerFrame(deltaTime)
  PaGlobal_ContentsTutorial_All:updateTutorial(deltaTime)
end
function HandleEventLUp_ContentsTutorial_All_Execute()
  if Panel_ContentsTutorial_All == nil then
    return
  end
  if PaGlobal_ContentsTutorial_All._realTargetControl == nil then
    PaGlobalFunc_ContentsTutorial_All_Close()
    return
  end
  ToClient_ExecuteHandleEventByControl(PaGlobal_ContentsTutorial_All._realTargetControl, "Mouse_LUp")
  PaGlobal_ContentsTutorial_All._curWaitingType = PaGlobal_ContentsTutorial_All._eWaitingType.NO_WATING
  if PaGlobal_ContentsTutorial_All._copyTargetControl ~= nil then
    PaGlobal_ContentsTutorial_All._copyTargetControl:addInputEvent("Mouse_LUp", "")
    PaGlobal_ContentsTutorial_All._copyTargetControl:SetShow(false)
  end
end
function HandleEventRUp_ContentsTutorial_All_Execute()
  if Panel_ContentsTutorial_All == nil then
    return
  end
  if PaGlobal_ContentsTutorial_All._realTargetControl == nil then
    PaGlobalFunc_ContentsTutorial_All_Close()
    return
  end
  ToClient_ExecuteHandleEventByControl(PaGlobal_ContentsTutorial_All._realTargetControl, "Mouse_RUp")
  PaGlobal_ContentsTutorial_All._curWaitingType = PaGlobal_ContentsTutorial_All._eWaitingType.NO_WATING
  if PaGlobal_ContentsTutorial_All._copyTargetControl ~= nil then
    PaGlobal_ContentsTutorial_All._copyTargetControl:addInputEvent("Mouse_RUp", "")
    PaGlobal_ContentsTutorial_All._copyTargetControl:SetShow(false)
  end
end
function TutorialTest_Dev()
  if isGameServiceTypeDev() then
    PaGlobalFunc_ContentsTutorial_All_Open("ContentsTutorial", 0)
  end
end
function FromClient_ContentsTutorial_All_Resize()
  PaGlobal_ContentsTutorial_All:resize()
end
function PaGlobalFunc_ContentsTutorial_All_ManuFactureCheck(itemDynamicListWrapper, failReason)
  if Panel_ContentsTutorial_All == nil then
    return
  end
  if itemDynamicListWrapper == nil then
    return
  end
  if PaGlobal_ContentsTutorial_All._realTargetControl == nil then
    return
  end
  if PaGlobal_ContentsTutorial_All._tutorialKey == -1 or PaGlobal_ContentsTutorial_All._tutorialDataCount == 0 then
    return
  end
  if PaGlobal_ContentsTutorial_All._eTutorialType.VIPIKO == PaGlobal_ContentsTutorial_All._tutorialKey then
    local data = ToClient_GetContentsTutorialData(PaGlobal_ContentsTutorial_All._nextDataIndex)
    if data == nil then
      return false
    end
    local subCategoriIndex = data:getCategoriIndex()
    if subCategoriIndex == 13 then
      PaGlobal_ContentsTutorial_All:exchangeTimeReset()
      PaGlobal_ContentsTutorial_All:updateNextTutorialData()
    end
  end
end
function PaGlobalFunc_ContentsTutorial_All_ServantTutorialCheck()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  if selfPlayerWrapper:isDead() == true then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  if selfPlayer:getLevel() < 20 then
    return
  end
  local pcPosition = selfPlayer:getPosition()
  local regionInfo = getRegionInfoByPosition(pcPosition)
  if regionInfo == nil then
    return
  end
  if regionInfo:get():isSafeZone() == false then
    return
  end
  if ToClient_hasVipicoChallengeProgess() == false then
    return
  end
  PaGlobalFunc_ContentsTutorial_All_Open("ContentsTutorial", 1)
  ToClient_skipVipicoTutorial()
end
