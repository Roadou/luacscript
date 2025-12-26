PaGlobal_SequenceNotifier = {
  _subTitleInfo = {
    _templateControl = UI.getChildControl(Panel_SequenceNotifier, "MultilineText_Subtitle_Template"),
    _controlList = nil,
    _msgList = nil,
    _remainTimeList = nil,
    _moveUpAniSpeed = 0.2,
    _moveDownAniSpeed = 0.1,
    _maxCount = 5
  },
  _isInitialized = false
}
function PaGlobal_SequenceNotifier:initialize()
  if Panel_SequenceNotifier == nil then
    return
  end
  if self._isInitialized == true then
    return
  end
  self:resizePanel()
  self:initialize_subTitleInfo()
  self:registEventHandler()
  self._isInitialized = true
end
function PaGlobal_SequenceNotifier:initialize_subTitleInfo()
  if Panel_SequenceNotifier == nil then
    return
  end
  self._subTitleInfo._templateControl:SetShow(false)
  self._subTitleInfo._controlList = Array.new()
  self._subTitleInfo._remainTimeList = Array.new()
  for index = 1, self._subTitleInfo._maxCount do
    local id = "SequenceNotifier_SubTitle_" .. index
    if UI.getChildControlNoneAssert(Panel_SequenceNotifier, id) == nil then
      local newSubTitleControl = UI.cloneControl(self._subTitleInfo._templateControl, Panel_SequenceNotifier, id)
      if newSubTitleControl ~= nil then
        newSubTitleControl:ComputePos()
        newSubTitleControl:SetIgnore(true)
        newSubTitleControl:SetShow(false)
        self._subTitleInfo._controlList:push_back(newSubTitleControl)
        self._subTitleInfo._remainTimeList:push_back(0)
      end
    end
  end
end
function PaGlobal_SequenceNotifier:resizePanel()
  if Panel_SequenceNotifier == nil then
    return
  end
  Panel_SequenceNotifier:SetPosX(0)
  Panel_SequenceNotifier:SetPosY(0)
  Panel_SequenceNotifier:SetSize(getScreenSizeX(), getScreenSizeY())
end
function PaGlobal_SequenceNotifier:registEventHandler()
  if Panel_SequenceNotifier == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_SequenceNotifier_ResizePanel")
  registerEvent("EventSequenceNotify", "FromClient_SequenceNotifier_EventSequenceNotify")
end
function PaGlobal_SequenceNotifier:open()
  if Panel_SequenceNotifier == nil then
    return
  end
  self:resizePanel()
  Panel_SequenceNotifier:RegisterUpdateFunc("PaGlobalFunc_SequenceNotifier_Update")
  Panel_SequenceNotifier:SetShow(true)
end
function PaGlobal_SequenceNotifier:close()
  if Panel_SequenceNotifier == nil then
    return
  end
  Panel_SequenceNotifier:ClearUpdateLuaFunc()
  Panel_SequenceNotifier:SetShow(false)
end
function PaGlobal_SequenceNotifier:popMsgData()
  if Panel_SequenceNotifier == nil then
    return nil
  end
  local popData
  for index = 1, #self._subTitleInfo._msgList do
    local msgData = self._subTitleInfo._msgList[index]
    if msgData ~= nil then
      popData = msgData
      table.remove(self._subTitleInfo._msgList, index)
      break
    end
  end
  return popData
end
function PaGlobal_SequenceNotifier:getWaitSubTitleControl()
  if Panel_SequenceNotifier == nil then
    return nil, nil
  end
  for index = 1, self._subTitleInfo._maxCount do
    local subtitleControl = self._subTitleInfo._controlList[index]
    if subtitleControl ~= nil and subtitleControl:GetShow() == false then
      return subtitleControl, index
    end
  end
  return nil, nil
end
function PaGlobal_SequenceNotifier:makeNewSubTitleControl()
  if Panel_SequenceNotifier == nil then
    return nil, nil
  end
  local newIndex = self._subTitleInfo._maxCount + 1
  local newSubTitleControl = UI.cloneControl(self._subTitleInfo._templateControl, Panel_SequenceNotifier, "SequenceNotifier_SubTitle_" .. newIndex)
  if newSubTitleControl == nil then
    return nil, nil
  end
  newSubTitleControl:SetIgnore(true)
  newSubTitleControl:SetShow(false)
  self._subTitleInfo._controlList:push_back(newSubTitleControl)
  self._subTitleInfo._remainTimeList:push_back(0)
  self._subTitleInfo._maxCount = newIndex
  return newSubTitleControl, newIndex
end
function PaGlobalFunc_SequenceNotifier_Update(deltaTime)
  local self = PaGlobal_SequenceNotifier
  if self == nil then
    return
  end
  if 0 < self._subTitleInfo._msgList:length() then
    local subtitleControl, index = self:getWaitSubTitleControl()
    if subtitleControl == nil then
      subtitleControl, index = self:makeNewSubTitleControl()
    end
    if subtitleControl ~= nil then
      local newMsg = self:popMsgData()
      if newMsg ~= nil then
        for idx = 1, self._subTitleInfo._maxCount do
          local control = self._subTitleInfo._controlList[idx]
          if control ~= nil and control:GetShow() == true then
            local aniInfo = control:addMoveAnimation(0, self._subTitleInfo._moveUpAniSpeed, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
            aniInfo:SetStartPosition(control:GetPosX(), control:GetPosY())
            aniInfo:SetEndPosition(control:GetPosX(), control:GetPosY() - control:GetSizeY())
            control:CalcUIAniPos(aniInfo)
          end
        end
        self._subTitleInfo._remainTimeList[index] = newMsg._showTime
        subtitleControl:SetText(newMsg._msg)
        subtitleControl:SetShow(true)
        subtitleControl:SetAlpha(0)
        UIAni.AlphaAnimation(1, subtitleControl, 0, 0.5)
      end
    end
  end
  for index = 1, self._subTitleInfo._maxCount do
    local subtitleControl = self._subTitleInfo._controlList[index]
    if subtitleControl ~= nil and subtitleControl:GetShow() == true then
      self._subTitleInfo._remainTimeList[index] = self._subTitleInfo._remainTimeList[index] - deltaTime
      if 0 > self._subTitleInfo._remainTimeList[index] then
        for idx = 1, self._subTitleInfo._maxCount do
          local control = self._subTitleInfo._controlList[idx]
          if control ~= nil and control:GetShow() == true and control:GetPosY() < subtitleControl:GetPosY() then
            local aniInfo = control:addMoveAnimation(0, self._subTitleInfo._moveDownAniSpeed, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
            aniInfo:SetStartPosition(control:GetPosX(), control:GetPosY())
            aniInfo:SetEndPosition(control:GetPosX(), control:GetPosY() + control:GetSizeY())
            control:CalcUIAniPos(aniInfo)
          end
        end
        self._subTitleInfo._remainTimeList[index] = 0
        subtitleControl:ResetVertexAni()
        subtitleControl:ComputePos()
        subtitleControl:SetAlpha(1)
        subtitleControl:SetShow(false)
      end
    end
  end
  local hideCount = 0
  for index = 1, self._subTitleInfo._maxCount do
    local subtitleControl = self._subTitleInfo._controlList[index]
    if subtitleControl ~= nil and subtitleControl:GetShow() == false then
      hideCount = hideCount + 1
    end
  end
  if hideCount >= self._subTitleInfo._maxCount then
    self:close()
  end
end
function FromClient_SequenceNotifier_ResizePanel()
  local self = PaGlobal_SequenceNotifier
  if self == nil then
    return
  end
  if Panel_SequenceNotifier:GetShow() == false then
    return
  end
  self:resizePanel()
end
function FromClient_SequenceNotifier_EventSequenceNotify(noticeType, noticeValue, msg)
  local self = PaGlobal_SequenceNotifier
  if self == nil then
    return
  end
  if self._subTitleInfo._msgList == nil then
    self._subTitleInfo._msgList = Array.new()
  end
  local msgData = {
    _type = noticeType,
    _showTime = noticeValue,
    _msg = msg
  }
  self._subTitleInfo._msgList:push_back(msgData)
  if Panel_SequenceNotifier:GetShow() == false then
    self:open()
  end
end
Panel_SequenceNotifier:SetShow(false)
Panel_SequenceNotifier:SetFadeOverRender()
PaGlobal_SequenceNotifier:initialize()
