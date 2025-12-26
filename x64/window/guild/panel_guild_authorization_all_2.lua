function PaGlobal_Guild_Authorization_All_Open(memberUserNo)
  if memberUserNo == nil then
    return
  end
  PaGlobal_Guild_Authorization_All._targetMemberUserNo = memberUserNo
  PaGlobal_Guild_Authorization_All:prepareOpen()
end
function PaGlobal_Guild_Authorization_All_Close()
  if PaGlobal_Guild_Authorization_All._initialize == true then
    PaGlobal_Guild_Authorization_All:prepareClose()
  end
end
function RightList_ScrollEvent(isDown)
  local self = PaGlobal_Guild_Authorization_All
  if isDown then
    self._ui.verticalScroll:ControlButtonDown()
  else
    self._ui.verticalScroll:ControlButtonUp()
  end
  self._ui.frame_1:UpdateContentScroll()
end
function HandleEventOnOut_Guild_Authorization_All_Tooltip(groupNo, rightNo, isShow)
  local self = PaGlobal_Guild_Authorization_All
  if isShow == false then
    TooltipSimple_Hide()
    return
  elseif _ContentsGroup_UsePadSnapping == true then
    self._rightControlList[groupNo][rightNo]:SetCheck(self._rightControlList[groupNo][rightNo]:IsCheck())
  end
  local index = groupNo - 1
  local name = self._rightInfoList[groupNo][rightNo]:getRightName()
  local desc = self._rightInfoList[groupNo][rightNo]:getRightDesc()
  TooltipSimple_Show(self._rightControlList[groupNo][rightNo], name, desc)
end
function HandleEventLUp_Guild_Authorization_All_CheckRight(groupNo, rightNo)
  local self = PaGlobal_Guild_Authorization_All
  if self == nil then
    return
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if myGuildListInfo == nil then
    return
  end
  local myGuildMemberInfo = myGuildListInfo:getMemberByUserNo(self._targetMemberUserNo)
  if myGuildMemberInfo == nil then
    return
  end
  local isSelf = myGuildMemberInfo:isSelf()
  local isCheck = self._rightControlList[groupNo][rightNo]:IsCheck()
  local isRight = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_ChangeMemberRight)
  local rightName = PaGlobalFunc_Guild_Authorization_GetRightName(__eGuildRightNew_ChangeMemberRight)
  local myGrade = getSelfPlayer():getGuildMemberGrade()
  local mySelfGuildMaster = myGrade == __eGuildMemberGradeMaster
  if isSelf == true and isRight == false then
    local function revertCheck()
      self._rightControlList[groupNo][rightNo]:SetCheck(isCheck)
      self._rightControlList[groupNo][rightNo]:SetMonoTone(not isCheck)
    end
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_AUTHORITY_ALERTCHANGE_TITLE"),
      content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_NO_RIGHT_MESSAGE_PARAM", "rightName", rightName),
      functionYes = revertCheck,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  elseif isSelf == true and mySelfGuildMaster == true then
    local function revertCheck()
      self._rightControlList[groupNo][rightNo]:SetCheck(isCheck)
      self._rightControlList[groupNo][rightNo]:SetMonoTone(not isCheck)
    end
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_AUTHORITY_ALERTCHANGE_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_AUTHORITY_CANTCHANGE_MASTER"),
      functionYes = revertCheck,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    self._rightControlList[groupNo][rightNo]:SetMonoTone(isCheck)
    if isCheck == true then
      self._groupControlList[groupNo]:SetCheck(false)
    else
      local isAllChecked = true
      for jj = 0, self._rightCount[groupNo] - 1 do
        if jj ~= rightNo and self._rightControlList[groupNo][jj]:IsCheck() == false then
          isAllChecked = false
        end
      end
      self._groupControlList[groupNo]:SetCheck(isAllChecked)
    end
  end
end
function HandleEventLUp_Guild_Authorization_All_Reset()
  local self = PaGlobal_Guild_Authorization_All
  if self == nil then
    return
  end
  local function doReset()
    for ii = 1, self._groupCount do
      self._groupControlList[ii]:SetCheck(false)
      for jj = 0, self._rightCount[ii] - 1 do
        self._rightControlList[ii][jj]:SetCheck(false)
      end
    end
    ToClient_ClearGuildRight(self._targetMemberUserNo)
    PaGlobal_Guild_Authorization_All_Close()
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if myGuildListInfo == nil then
    return
  end
  local myGuildMemberInfo = myGuildListInfo:getMemberByUserNo(self._targetMemberUserNo)
  if myGuildMemberInfo == nil then
    return
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_AUTHORITY_RESET_POPUP_TITLE"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AUTHORITY_RESET_POPUP_DESC", "userName", myGuildMemberInfo:getName()),
    functionYes = doReset,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_Guild_Authorization_All_Apply()
  local self = PaGlobal_Guild_Authorization_All
  if self == nil then
    return
  end
  local function doApply()
    local rightNoStr
    for ii = 1, self._groupCount do
      for jj = 0, self._rightCount[ii] - 1 do
        if self._rightControlList[ii][jj]:IsCheck() == true then
          local rightNo = self._rightInfoList[ii][jj]:getRightNo()
          if rightNoStr == nil then
            rightNoStr = tostring(rightNo)
          else
            rightNoStr = rightNoStr .. "," .. tostring(rightNo)
          end
        end
      end
    end
    ToClient_ApplyGuildRight(self._targetMemberUserNo, rightNoStr)
    PaGlobal_Guild_Authorization_All_Close()
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if myGuildListInfo == nil then
    return
  end
  local myGuildMemberInfo = myGuildListInfo:getMemberByUserNo(self._targetMemberUserNo)
  if myGuildMemberInfo == nil then
    return
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_AUTHORITY_APPLY_POPUP_TITLE"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AUTHORITY_APPLY_POPUP_DESC", "userName", myGuildMemberInfo:getName()),
    functionYes = doApply,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_Guild_Authorization_All_Reset_Tooltip(isShow)
  local self = PaGlobal_Guild_Authorization_All
  if self == nil then
    TooltipSimple_Hide()
    return
  end
  if isShow == nil then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_AUTHORIZATION_GUILD_RESET_TOOLTIP_NAME")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_AUTHORIZATION_GUILD_RESET_TOOLTIP_DESC")
  TooltipSimple_Show(self._ui.btn_reset, name, desc, false)
end
function HandleEventLUp_Guild_Authorization_All_CheckGroup(groupNo)
  local self = PaGlobal_Guild_Authorization_All
  if self == nil then
    return
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if myGuildListInfo == nil then
    return
  end
  local myGuildMemberInfo = myGuildListInfo:getMemberByUserNo(self._targetMemberUserNo)
  if myGuildMemberInfo == nil then
    return
  end
  local isCheck = self._groupControlList[groupNo]:IsCheck()
  local isSelf = myGuildMemberInfo:isSelf()
  local isRight = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_ChangeMemberRight)
  local rightName = PaGlobalFunc_Guild_Authorization_GetRightName(__eGuildRightNew_ChangeMemberRight)
  local myGrade = getSelfPlayer():getGuildMemberGrade()
  local mySelfGuildMaster = myGrade == __eGuildMemberGradeMaster
  if isSelf == true and isRight == false then
    local function revertCheck()
      self._groupControlList[groupNo]:SetCheck(isCheck)
      return
    end
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_AUTHORITY_ALERTCHANGE_TITLE"),
      content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_NO_RIGHT_MESSAGE_PARAM", "rightName", rightName),
      functionYes = revertCheck,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  elseif isSelf == true and mySelfGuildMaster == true then
    local function revertCheck()
      self._groupControlList[groupNo]:SetCheck(isCheck)
      return
    end
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_AUTHORITY_ALERTCHANGE_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_AUTHORITY_CANTCHANGE_MASTER"),
      functionYes = revertCheck,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    self._groupControlList[groupNo]:SetCheck(not isCheck)
    for jj = 0, self._rightCount[groupNo] - 1 do
      self._rightControlList[groupNo][jj]:SetCheck(not isCheck)
      self._rightControlList[groupNo][jj]:SetMonoTone(isCheck)
    end
  end
end
function FromClient_GuildMemberRight_ChangeSuccess()
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if myGuildListInfo == nil then
    return
  end
  local myGuildMemberInfo = myGuildListInfo:getMemberByUserNo(PaGlobal_Guild_Authorization_All._targetMemberUserNo)
  if myGuildMemberInfo == nil then
    return
  end
  local msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AUTHORITY_APPLYSUCCESS", "userName", myGuildMemberInfo:getName())
  Proc_ShowMessage_Ack(msg)
end
function FromClient_GuildMemberRight_AlertChange(userNo)
  if Panel_Guild_Authorization_All:GetShow() == false then
    return
  end
  local self = PaGlobal_Guild_Authorization_All
  if self == nil then
    return
  end
  if userNo == nil then
    return
  end
  if Panel_Guild_Authorization_All:GetShow() == true then
    if MessageBoxGetShow() == true then
      messageBox_CloseButtonUp()
    end
    local doRefresh = function()
      PaGlobal_Guild_Authorization_All:laodMemberRight()
    end
    local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
    if myGuildListInfo == nil then
      return
    end
    local myGuildMemberInfo = myGuildListInfo:getMemberByUserNo(self._targetMemberUserNo)
    if myGuildMemberInfo == nil then
      return
    end
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_AUTHORITY_ALERTCHANGE_TITLE"),
      content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AUTHORITY_ALERTCHANGE_DESC", "userName", myGuildMemberInfo:getName()),
      functionYes = doRefresh,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function PaGlobalFunc_Guild_Authorization_RightCheck(eRightTypeNew)
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return false
  end
  if selfPlayer:get():isGuildMaster() == true then
    return true
  end
  return selfPlayer:get():checkRightNewLua(eRightTypeNew)
end
function PaGlobalFunc_Guild_Authorization_GetRightName(eRightTypeNew)
  local self = PaGlobal_Guild_Authorization_All
  if self == nil then
    return
  end
  if self._initialize == false then
    return
  end
  for ii = 1, self._groupCount do
    for jj = 0, self._rightCount[ii] - 1 do
      if self._rightInfoList[ii][jj]:getRightNo() == eRightTypeNew then
        return self._rightInfoList[ii][jj]:getRightName()
      end
    end
  end
  return nil
end
function PaGlobalFunc_Guild_Authorization_ShowErrMessage(eRightTypeNew)
  local rightName = PaGlobalFunc_Guild_Authorization_GetRightName(eRightTypeNew)
  local errMessage = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_NO_RIGHT_MESSAGE_PARAM", "rightName", rightName)
  Proc_ShowMessage_Ack(errMessage)
end
