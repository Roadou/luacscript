PaGlobalFunc_Sequence_SubTitle = {
  _templateUIList = {
    [__eSequenceSubTitlePositionType_Bottom] = UI.getChildControl(Panel_Sequence_SubTitle, "MultilineText_Subtitle_Bottom_Group"),
    [__eSequenceSubTitlePositionType_Mid] = UI.getChildControl(Panel_Sequence_SubTitle, "MultilineText_Subtitle_Mid_Group"),
    [__eSequenceSubTitlePositionType_Top] = UI.getChildControl(Panel_Sequence_SubTitle, "MultilineText_Subtitle_Top_Group")
  },
  _subTitleControlList = {
    [__eSequenceSubTitlePositionType_Bottom] = {},
    [__eSequenceSubTitlePositionType_Mid] = {},
    [__eSequenceSubTitlePositionType_Top] = {},
    [__eSequenceSubTitlePositionType_Name] = {
      [0] = UI.getChildControl(Panel_Sequence_SubTitle, "MultilineText_Subtitle_Name_Default"),
      [1] = UI.getChildControl(Panel_Sequence_SubTitle, "MultilineText_Subtitle_Name_Small"),
      [2] = UI.getChildControl(Panel_Sequence_SubTitle, "MultilineText_Subtitle_Name_Big")
    },
    [__eSequenceSubTitlePositionType_Custom] = {
      [0] = UI.getChildControl(Panel_Sequence_SubTitle, "MultilineText_Subtitle_Custom_Default"),
      [1] = UI.getChildControl(Panel_Sequence_SubTitle, "MultilineText_Subtitle_Custom_Small"),
      [2] = UI.getChildControl(Panel_Sequence_SubTitle, "MultilineText_Subtitle_Custom_Big")
    }
  },
  _originControlSizeX = 1280,
  _originControlSizeY = 100,
  _isInitialized = false,
  _currentPoolCount = {
    [__eSequenceSubTitlePositionType_Bottom] = 0,
    [__eSequenceSubTitlePositionType_Mid] = 0,
    [__eSequenceSubTitlePositionType_Top] = 0
  },
  _expendPoolCount = 2
}
function PaGlobalFunc_Sequence_SubTitle:initialize()
  if Panel_Sequence_SubTitle == nil then
    return
  end
  if self._isInitialized == true then
    return
  end
  self:reset(false, true, true)
  self:registEventHandler()
  self:initSubtitlePoolUI(__eSequenceSubTitlePositionType_Bottom)
  self:initSubtitlePoolUI(__eSequenceSubTitlePositionType_Mid)
  self:initSubtitlePoolUI(__eSequenceSubTitlePositionType_Top)
  self._isInitialized = true
end
function PaGlobalFunc_Sequence_SubTitle:registEventHandler()
  if Panel_Sequence_SubTitle == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_SequenceSubTitle_ResizePanel")
  registerEvent("FromClient_CloseSequenceEditorUI_Ocean", "PaGlobalFunc_SequenceSubTitle_Close")
  registerEvent("FromClient_PlaySequence", "FromClient_SequenceSubTitle_PlaySequence")
  registerEvent("FromClient_PlaySequence_Ocean", "FromClient_SequenceSubTitle_PlaySequence_Ocean")
  registerEvent("FromClient_StopSequence", "FromClient_SequenceSubTitle_StopSequence")
  registerEvent("FromClient_StopSequence_Ocean", "FromClient_SequenceSubTitle_StopSequence_Ocean")
  registerEvent("FromClient_PauseResumeSequence", "FromClient_SequenceSubTitle_PauseResumeSequence")
  registerEvent("FromClient_ShowSequenceSubtitle", "FromClient_ShowSequenceSubtitle")
  registerEvent("FromClient_HideSequenceSubtitle", "FromClient_HideSequenceSubtitle")
  registerEvent("FromClient_ShowSequenceSubtitleForEditor", "FromClient_ShowSequenceSubtitleForEditor")
end
function PaGlobalFunc_Sequence_SubTitle:initSubtitlePoolUI(positionType)
  for i = 1, 2 do
    self:addSubtitlePoolUI(positionType, i)
    self._currentPoolCount[positionType] = self._currentPoolCount[positionType] + 1
  end
end
function PaGlobalFunc_Sequence_SubTitle:expendSubtitlePoolUI(positionType)
  local count = self._currentPoolCount[positionType]
  for i = count + 1, count + self._expendPoolCount do
    self:addSubtitlePoolUI(positionType, i)
    self._currentPoolCount[positionType] = self._currentPoolCount[positionType] + 1
  end
end
function PaGlobalFunc_Sequence_SubTitle:addSubtitlePoolUI(positionType, index)
  local controlId = "Static_Subtitle_" .. positionType .. "_" .. index
  local controlGroup = UI.getChildControlNoneAssert(Panel_Sequence_SubTitle, controlId)
  if controlGroup == nil then
    controlGroup = UI.cloneControl(self._templateUIList[positionType], Panel_Sequence_SubTitle, controlId)
  end
  local controlDefault = UI.getChildControl(controlGroup, "MultilineText_Default")
  local controlSmall = UI.getChildControl(controlGroup, "MultilineText_Small")
  local controlBig = UI.getChildControl(controlGroup, "MultilineText_Big")
  controlDefault:ComputePos()
  controlSmall:ComputePos()
  controlBig:ComputePos()
  self._subTitleControlList[positionType][index] = {
    _mainControl = controlGroup,
    _textControl = {
      [__eSequenceSubTitleSizeType_Default] = controlDefault,
      [__eSequenceSubTitleSizeType_Small] = controlSmall,
      [__eSequenceSubTitleSizeType_Big] = controlBig
    },
    _dataID = 0,
    _startFrame = 0,
    _isActive = false
  }
end
function PaGlobalFunc_Sequence_SubTitle:setActiveSubtitleUI(positionType, dataID, startFrame)
  if self._currentPoolCount[positionType] ~= 0 then
    for ii = 1, self._currentPoolCount[positionType] do
      if self._subTitleControlList[positionType][ii]._isActive == true and self._subTitleControlList[positionType][ii]._dataID == dataID then
        return ii
      end
    end
    for jj = 1, self._currentPoolCount[positionType] do
      if self._subTitleControlList[positionType][jj]._isActive == false then
        self._subTitleControlList[positionType][jj]._dataID = dataID
        self._subTitleControlList[positionType][jj]._startFrame = startFrame
        self._subTitleControlList[positionType][jj]._isActive = true
        return jj
      end
    end
  end
  self:expendSubtitlePoolUI(positionType)
  return self:setActiveSubtitleUI(positionType, dataID, startFrame)
end
function PaGlobalFunc_Sequence_SubTitle:resetAllActiveSubtitleUI()
  for positionType = 0, __eSequenceSubTitlePositionType_Count do
    if self._currentPoolCount[positionType] ~= nil and self._currentPoolCount[positionType] ~= 0 then
      for ii = 1, self._currentPoolCount[positionType] do
        self._subTitleControlList[positionType][ii]._dataID = 0
        self._subTitleControlList[positionType][ii]._startFrame = 0
        self._subTitleControlList[positionType][ii]._isActive = false
        self._subTitleControlList[positionType][ii]._mainControl:SetShow(false)
      end
    end
  end
end
function PaGlobalFunc_Sequence_SubTitle:getCountActiveSubtitleUI(positionType)
  local activatedCount = 0
  for ii = 1, self._currentPoolCount[positionType] do
    if self._subTitleControlList[positionType][ii]._isActive == true then
      activatedCount = activatedCount + 1
    end
  end
  return activatedCount
end
function PaGlobalFunc_Sequence_SubTitle:updatePosActiveSubtitleUI(positionType)
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  local centerRatio = 0.5
  local newPosX, newPosY
  local bottomMargin = 10
  local offsetY
  local isConsole = ToClient_isConsole()
  if GetUIMode ~= nil and GetUIMode() == Defines.UIMode.eUIMode_SequencePlayerControl and (_ContentsGroup_UsePadSnapping == true or isConsole == true) then
    bottomMargin = 120
  end
  local activatedCount = self:getCountActiveSubtitleUI(positionType)
  if activatedCount == 0 then
    return
  end
  table.sort(self._subTitleControlList[positionType], function(a, b)
    return a._startFrame < b._startFrame
  end)
  local centerPosY = 0
  local textSizeX = self._subTitleControlList[positionType][1]._mainControl:GetSizeX()
  local textSizeY = self._subTitleControlList[positionType][1]._mainControl:GetSizeY()
  local textCenter = screenX * centerRatio - textSizeX * centerRatio
  if positionType == __eSequenceSubTitlePositionType_Bottom then
    centerPosY = screenY - textSizeY - bottomMargin
  elseif positionType == __eSequenceSubTitlePositionType_Mid then
    centerPosY = screenY / 2
  elseif positionType == __eSequenceSubTitlePositionType_Top then
    centerPosY = textSizeY
  else
    UI.ASSERT_NAME(false, "subtitlePositionType\236\157\180 \236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164. " .. positionType, "\234\182\140\236\132\160\236\154\169")
    return
  end
  local centerFloat = activatedCount / 2
  local index = 0
  for ii = 1, self._currentPoolCount[positionType] do
    local controlUIData = self._subTitleControlList[positionType][ii]
    if controlUIData._isActive == true then
      if positionType == __eSequenceSubTitlePositionType_Bottom then
        offsetY = (index - centerFloat) * textSizeY / 2
        newPosX = textCenter
        newPosY = centerPosY + offsetY
      elseif positionType == __eSequenceSubTitlePositionType_Mid then
        offsetY = (index - centerFloat) * textSizeY / 2
        newPosX = textCenter
        newPosY = centerPosY + offsetY
      elseif positionType == __eSequenceSubTitlePositionType_Top then
        offsetY = (index - centerFloat) * textSizeY / 2
        newPosX = textCenter
        newPosY = centerPosY + offsetY
      else
        UI.ASSERT_NAME(false, "subtitlePositionType\236\157\180 \236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164." .. positionType, "\234\182\140\236\132\160\236\154\169")
        return
      end
      controlUIData._mainControl:SetPosX(newPosX)
      controlUIData._mainControl:SetPosY(newPosY)
      index = index + 1
    end
  end
end
function PaGlobalFunc_Sequence_SubTitle:reset(isShow, doClearText, doClearPos)
  if Panel_Sequence_SubTitle == nil then
    return
  end
  self:resetAllActiveSubtitleUI()
  for posIndex, posList in pairs(self._subTitleControlList) do
    if (posIndex == __eSequenceSubTitlePositionType_Name or posIndex == __eSequenceSubTitlePositionType_Custom) and posList ~= nil then
      for sizeIndex, control in pairs(posList) do
        if control ~= nil then
          control:SetSize(self._originControlSizeX, self._originControlSizeY)
          if isShow ~= nil then
            control:SetShow(isShow)
          end
          if doClearText ~= nil and doClearText == true then
            control:SetText("")
          end
          if doClearPos ~= nil and doClearPos == true then
            control:ComputePos()
          end
        end
      end
    end
  end
end
function PaGlobalFunc_Sequence_SubTitle:resizePanel()
  if Panel_Sequence_SubTitle == nil then
    return
  end
  Panel_Sequence_SubTitle:SetPosX(0)
  Panel_Sequence_SubTitle:SetPosY(0)
  Panel_Sequence_SubTitle:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Sequence_SubTitle:ComputePosAllChild()
end
function PaGlobalFunc_Sequence_SubTitle:open()
  if Panel_Sequence_SubTitle == nil then
    return
  end
  self:resizePanel()
  Panel_Sequence_SubTitle:SetShow(true)
end
function PaGlobalFunc_Sequence_SubTitle:close()
  if Panel_Sequence_SubTitle == nil then
    return
  end
  Panel_Sequence_SubTitle:SetShow(false)
end
function PaGlobalFunc_SequenceSubTitle_Close()
  local self = PaGlobalFunc_Sequence_SubTitle
  if self == nil then
    return
  end
  if ToClient_isWriteLogCurrentSequence() == true then
    _PA_SVC_LOG("[FromLua_CS_Awake_04_Woosa][PaGlobalFunc_SequenceSubTitle_Close]")
  end
  self:close()
end
function FromClient_SequenceSubTitle_ResizePanel()
  local self = PaGlobalFunc_Sequence_SubTitle
  if self == nil then
    return
  end
  if ToClient_isWriteLogCurrentSequence() == true then
    _PA_SVC_LOG("[FromLua_CS_Awake_04_Woosa][FromClient_SequenceSubTitle_ResizePanel]")
  end
  self:resizePanel()
end
function FromClient_SequenceSubTitle_PlaySequence()
  local self = PaGlobalFunc_Sequence_SubTitle
  if self == nil then
    return
  end
  if ToClient_isWriteLogCurrentSequence() == true then
    _PA_SVC_LOG("[FromLua_CS_Awake_04_Woosa][FromClient_SequenceSubTitle_PlaySequence]")
  end
  self:open()
end
function FromClient_SequenceSubTitle_PlaySequence_Ocean()
  local self = PaGlobalFunc_Sequence_SubTitle
  if self == nil then
    return
  end
  if Panel_Sequence_SubTitle:GetShow() == true then
    return
  end
  if ToClient_isWriteLogCurrentSequence() == true then
    _PA_SVC_LOG("[FromLua_CS_Awake_04_Woosa][FromClient_SequenceSubTitle_PlaySequence_Ocean]")
  end
  self:open()
end
function FromClient_SequenceSubTitle_StopSequence()
  local self = PaGlobalFunc_Sequence_SubTitle
  if self == nil then
    return
  end
  if ToClient_isWriteLogCurrentSequence() == true then
    _PA_SVC_LOG("[FromLua_CS_Awake_04_Woosa][FromClient_SequenceSubTitle_StopSequence]")
  end
  self:reset(false, true, true)
  self:close()
end
function FromClient_SequenceSubTitle_StopSequence_Ocean()
  local self = PaGlobalFunc_Sequence_SubTitle
  if self == nil then
    return
  end
  if ToClient_isWriteLogCurrentSequence() == true then
    _PA_SVC_LOG("[FromLua_CS_Awake_04_Woosa][FromClient_SequenceSubTitle_StopSequence_Ocean]")
  end
  self:reset(false, true, true)
  self:close()
end
function FromClient_SequenceSubTitle_PauseResumeSequence(isOn)
  local self = PaGlobalFunc_Sequence_SubTitle
  if self == nil then
    return
  end
  if ToClient_isWriteLogCurrentSequence() == true then
    _PA_SVC_LOG("[FromLua_CS_Awake_04_Woosa][FromClient_SequenceSubTitle_PauseResumeSequence(isOn = " .. tostring(isOn) .. ")]")
  end
  if isOn == true then
    if Panel_Sequence_SubTitle:GetShow() == true then
      return
    end
    self:open()
  else
    self:close()
  end
end
function FromClient_ShowSequenceSubtitle(subtitleText, isTestString, dataID, subtitlePositionType, subtitleSizeType, posRatioX, posRatioY, alignType, startFrame)
  local self = PaGlobalFunc_Sequence_SubTitle
  if self == nil or Panel_Sequence_SubTitle == nil then
    return
  end
  if ToClient_isWriteLogCurrentSequence() == true then
    _PA_SVC_LOG("begin - [FromLua_CS_Awake_04_Woosa][FromClient_ShowSequenceSubtitle](subtitleText=" .. tostring(subTitleText) .. ")(posType=" .. tostring(subtitlePositionType) .. ")(sizeType=" .. tostring(subtitleSizeType) .. ")")
  end
  if subtitlePositionType == __eSequenceSubTitlePositionType_Bottom or subtitlePositionType == __eSequenceSubTitlePositionType_Mid or subtitlePositionType == __eSequenceSubTitlePositionType_Top then
    local uiIndex = self:setActiveSubtitleUI(subtitlePositionType, dataID, startFrame)
    local controlUIData = self._subTitleControlList[subtitlePositionType][uiIndex]
    controlUIData._mainControl:SetShow(true)
    controlUIData._mainControl:SetSize(self._originControlSizeX, self._originControlSizeY)
    local textControl = controlUIData._textControl[subtitleSizeType]
    local subtitleString = subtitleText
    if isTestString == false then
      subtitleString = PAGetString(Defines.StringSheet_CUTSCENE, subtitleText)
    end
    textControl:SetSize(self._originControlSizeX, self._originControlSizeY)
    textControl:SetText(subtitleString)
    textControl:SetShow(true)
    self:updatePosActiveSubtitleUI(subtitlePositionType)
  else
    local targetControl = self._subTitleControlList[subtitlePositionType][subtitleSizeType]
    if targetControl == nil then
      _PA_SVC_LOG("[FromClient_ShowSequenceSubtitle] targetControl is nil (posType=" .. tostring(subtitlePositionType) .. ")(sizeType=" .. tostring(subtitleSizeType) .. ")")
      UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 type\236\158\133\235\139\136\235\139\164. \235\163\168\236\149\132\236\157\152 self._subTitleControlList \237\133\140\236\157\180\235\184\148 \236\160\149\236\157\152\235\182\128\235\165\188 \236\176\184\234\179\160\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\157\180\236\163\188")
      return
    end
    local subtitleString = subtitleText
    if isTestString == false then
      subtitleString = PAGetString(Defines.StringSheet_CUTSCENE, subtitleText)
    end
    targetControl:SetSize(self._originControlSizeX, self._originControlSizeY)
    targetControl:SetText(subtitleString)
    local screenX = getScreenSizeX()
    local screenY = getScreenSizeY()
    local centerRatio = 0.5
    local newPosX, newPosY
    if alignType == 0 then
      centerRatio = 0
    elseif alignType == 2 then
      centerRatio = 1
    end
    if subtitlePositionType == __eSequenceSubTitlePositionType_Name then
      local textSizeX = targetControl:GetSizeX()
      local textCenter = screenX * centerRatio - textSizeX * centerRatio
      newPosX = textCenter
      newPosY = screenY / 1.2 - targetControl:GetSizeY()
    elseif subtitlePositionType == __eSequenceSubTitlePositionType_Custom then
      targetControl:SetSize(targetControl:GetTextSizeX(), targetControl:GetTextSizeY())
      local textSizeX = targetControl:GetSizeX()
      local textSizeY = targetControl:GetSizeY()
      newPosX = screenX * posRatioX * 0.01 - textSizeX * centerRatio
      newPosY = screenY * posRatioY * 0.01 - textSizeY * centerRatio
    else
      _PA_SVC_LOG("[FromClient_ShowSequenceSubtitle] subtitlePositionType is undefined (posType=" .. tostring(subtitlePositionType) .. ")")
      UI.ASSERT_NAME(false, "subtitlePositionType\236\157\180 \236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    local rightPos = newPosX + targetControl:GetSizeX()
    if screenX < rightPos then
      local delta = rightPos - screenX + 10
      newPosX = newPosX - delta
    elseif newPosX < 0 then
      newPosX = 10
    end
    local bottomPos = newPosY + targetControl:GetSizeY()
    if screenY < bottomPos then
      local delta = bottomPos - screenY + 10
      newPosY = newPosY - delta
    elseif newPosY < 0 then
      newPosY = 10
    end
    targetControl:SetPosX(newPosX)
    targetControl:SetPosY(newPosY)
    targetControl:SetShow(true)
  end
  if Panel_Sequence_SubTitle:GetShow() == false then
    self:open()
  end
  if ToClient_isWriteLogCurrentSequence() == true then
    _PA_SVC_LOG("end - [FromLua_CS_Awake_04_Woosa][FromClient_ShowSequenceSubtitle](newPosX=" .. tostring(newPosX) .. ")(newPosY=" .. tostring(newPosY) .. ")(panelPosX=" .. tostring(Panel_Sequence_SubTitle:GetPosX()) .. ")(panelPosY=" .. tostring(Panel_Sequence_SubTitle:GetPosY()) .. ")(panelSizeX=" .. tostring(Panel_Sequence_SubTitle:GetSizeX()) .. ")(panelSizeY=" .. tostring(Panel_Sequence_SubTitle:GetSizeY()) .. ")")
  end
end
function FromClient_HideSequenceSubtitle(dataID, subtitlePositionType, subtitleSizeType, startFrame)
  local self = PaGlobalFunc_Sequence_SubTitle
  if self == nil or Panel_Sequence_SubTitle == nil then
    return
  end
  if subtitlePositionType == __eSequenceSubTitlePositionType_Bottom or subtitlePositionType == __eSequenceSubTitlePositionType_Mid or subtitlePositionType == __eSequenceSubTitlePositionType_Top then
    local uiIndex = self:setActiveSubtitleUI(subtitlePositionType, dataID, startFrame)
    local controlUIData = self._subTitleControlList[subtitlePositionType][uiIndex]
    controlUIData._mainControl:SetShow(false)
    controlUIData._textControl[subtitleSizeType]:SetShow(false)
    controlUIData._isActive = false
    self:updatePosActiveSubtitleUI(subtitlePositionType)
  else
    local targetControl = self._subTitleControlList[subtitlePositionType][subtitleSizeType]
    if targetControl == nil then
      _PA_SVC_LOG("[FromClient_ShowSequenceSubtitle] targetControl is nil (posType=" .. tostring(subtitlePositionType) .. ")(sizeType=" .. tostring(subtitleSizeType) .. ")")
      UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 type\236\158\133\235\139\136\235\139\164. \235\163\168\236\149\132\236\157\152 self._subTitleControlList \237\133\140\236\157\180\235\184\148 \236\160\149\236\157\152\235\182\128\235\165\188 \236\176\184\234\179\160\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\157\180\236\163\188")
      return
    end
    targetControl:SetText("")
    targetControl:SetShow(false)
  end
end
function FromClient_ShowSequenceSubtitleForEditor(isOn)
end
Panel_Sequence_SubTitle:SetShow(false)
Panel_Sequence_SubTitle:SetFadeOverRender()
PaGlobalFunc_Sequence_SubTitle:initialize()
