function PaGlobal_Solare_Custom:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local titleArea = UI.getChildControl(Panel_Window_Solrare_CustomMatching, "Static_Title_Bg")
  local topArea = UI.getChildControl(Panel_Window_Solrare_CustomMatching, "Static_TopArea")
  local stcMapBg = UI.getChildControl(topArea, "Static_MapBg")
  self._ui._stc_MapImage = UI.getChildControl(stcMapBg, "Static_MapSelect")
  self._ui._txt_MapName = UI.getChildControl(stcMapBg, "StaticText_MapName")
  local waitListArea = UI.getChildControl(Panel_Window_Solrare_CustomMatching, "Static_ListArea")
  self._ui._list_WaitMember = UI.getChildControl(waitListArea, "List2_Member")
  local chatArea = UI.getChildControl(Panel_Window_Solrare_CustomMatching, "Static_ChatArea")
  self._ui._frame_Chat = UI.getChildControl(chatArea, "Frame_ChatLog")
  self._ui._frame_ChatContent = UI.getChildControl(self._ui._frame_Chat, "Frame_1_Content")
  self._ui._txt_ChatTemplate = UI.getChildControl(self._ui._frame_ChatContent, "StaticText_Log_Template")
  self._ui._stc_frameVScroll = self._ui._frame_Chat:GetVScroll()
  self._ui._edit_Chat = UI.getChildControl(chatArea, "Edit_1")
  self._ui._stc_FloatBtnBg = UI.getChildControl(Panel_Window_Solrare_CustomMatching, "Static_FloatingBtnBg")
  self._ui._btn_Close = UI.getChildControl(titleArea, "Button_Close")
  self._ui._btn_Guide = UI.getChildControl(titleArea, "Button_Guide")
  self._ui._btn_Start = UI.getChildControl(waitListArea, "Button_Start")
  self._ui._btn_Exit = UI.getChildControl(waitListArea, "Button_Exit")
  if self._isConsole == false then
    self._ui._pc._btn_MapLeft = UI.getChildControl(stcMapBg, "Button_Left")
    self._ui._pc._btn_MapRight = UI.getChildControl(stcMapBg, "Button_Right")
  else
    self._ui._console._keyGuideBg = UI.getChildControl(Panel_Window_Solrare_CustomMatching, "Static_Key_GuideGroup_ConsoleUI")
    self._ui._console._txt_InputChat = UI.getChildControl(self._ui._console._keyGuideBg, "StaticText_X_ConsoleUI")
    self._ui._console._txt_Close = UI.getChildControl(self._ui._console._keyGuideBg, "StaticText_B_ConsoleUI")
    self._ui._console._txt_Select = UI.getChildControl(self._ui._console._keyGuideBg, "StaticText_A_ConsoleUI")
    self._ui._console._txt_Start = UI.getChildControl(self._ui._console._keyGuideBg, "StaticText_Y_ConsoleUI")
  end
  self._originFloatBtnBgSizeY = self._ui._stc_FloatBtnBg:GetSizeY()
  self._originFrameChatContentSizeY = self._ui._frame_ChatContent:GetSizeY()
  self._originChatDataSizeX = self._ui._txt_ChatTemplate:GetSizeX()
  self._originChatDataSizeY = self._ui._txt_ChatTemplate:GetSizeY()
  self._ui._btn_Start:SetIgnore(true)
  self._ui._btn_Start:SetMonoTone(true)
  self._ui._stc_frameVScroll:SetControlPos(1)
  self:createFloatButtons()
  self:createTeamControls()
  self:createChatMessagePool()
  self:registerEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Solare_Custom:createFloatButtons()
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  local buttonTemplate = UI.getChildControl(self._ui._stc_FloatBtnBg, "Button_Template")
  buttonTemplate:SetShow(false)
  self._ui._btn_KickOut = UI.cloneControl(buttonTemplate, self._ui._stc_FloatBtnBg, "Button_KickOut")
  self._ui._btn_MoveToWait = UI.cloneControl(buttonTemplate, self._ui._stc_FloatBtnBg, "Button_MoveToWait")
  self._ui._btn_MoveToRed = UI.cloneControl(buttonTemplate, self._ui._stc_FloatBtnBg, "Button_MoveToRed")
  self._ui._btn_MoveToBlue = UI.cloneControl(buttonTemplate, self._ui._stc_FloatBtnBg, "Button_MoveToBlue")
  self._ui._btn_KickOut:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOLARE_CUSTOMGAME_KICKOUT"))
  self._ui._btn_MoveToWait:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOLARE_CUSTOMGAME_MOVETOWAIT"))
  self._ui._btn_MoveToRed:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOLARECUSTOMGAME_TORED"))
  self._ui._btn_MoveToBlue:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOLARECUSTOMGAME_TOBLACK"))
end
function PaGlobal_Solare_Custom:createTeamControls()
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  if 0 < #self._redTeamMemberUI or 0 < #self._blueTeamMemberUI then
    return
  end
  local topArea = UI.getChildControl(Panel_Window_Solrare_CustomMatching, "Static_TopArea")
  local redTeamArea = UI.getChildControl(topArea, "Static_RedTeam")
  local blueTeamArea = UI.getChildControl(topArea, "Static_BlueTeam")
  for redIndex = 0, __eInstanceSolareCustomMatch_TeamPlayerCount - 1 do
    local temp = {}
    temp._memberBg = UI.getChildControl(redTeamArea, "Static_Member_BG_" .. tostring(redIndex + 1))
    temp._profile = UI.getChildControl(temp._memberBg, "Static_Profile")
    temp._tier = UI.getChildControl(temp._memberBg, "Static_Tier")
    temp._awakenIcon = UI.getChildControl(temp._memberBg, "Static_Type_Awaken")
    temp._successionIcon = UI.getChildControl(temp._memberBg, "Static_Type_Succession")
    temp._shyIcon = UI.getChildControl(temp._memberBg, "Static_Type_Shy")
    temp._archerIcon = UI.getChildControl(temp._memberBg, "Static_Type_Archer")
    temp._scholarIcon = UI.getChildControl(temp._memberBg, "Static_Type_Scholar")
    temp._deadeyeIcon = UI.getChildControl(temp._memberBg, "Static_Type_DeadEye")
    temp._ogongIcon = UI.getChildControl(temp._memberBg, "Static_Type_Ogong")
    temp._seraphimIcon = UI.getChildControl(temp._memberBg, "Static_Type_Seraphim")
    temp._userName = UI.getChildControl(temp._memberBg, "StaticText_Name")
    temp._chk_ShowFloatButton = UI.getChildControl(temp._memberBg, "CheckButton_Show_Button")
    temp._userNo = nil
    temp._chk_ShowFloatButton:addInputEvent("Mouse_LUp", "HandleEventLUp_SolareCustom_ShowFloatButton(" .. tostring(__eInstanceSolareCustomMatch_RedTeam) .. ", " .. tostring(redIndex) .. ")")
    self._redTeamMemberUI:push_back(temp)
  end
  for blueIndex = 0, __eInstanceSolareCustomMatch_TeamPlayerCount - 1 do
    local temp = {}
    temp._memberBg = UI.getChildControl(blueTeamArea, "Static_Member_BG_" .. tostring(blueIndex + 1))
    temp._profile = UI.getChildControl(temp._memberBg, "Static_Profile")
    temp._tier = UI.getChildControl(temp._memberBg, "Static_Tier")
    temp._awakenIcon = UI.getChildControl(temp._memberBg, "Static_Type_Awaken")
    temp._successionIcon = UI.getChildControl(temp._memberBg, "Static_Type_Succession")
    temp._shyIcon = UI.getChildControl(temp._memberBg, "Static_Type_Shy")
    temp._archerIcon = UI.getChildControl(temp._memberBg, "Static_Type_Archer")
    temp._scholarIcon = UI.getChildControl(temp._memberBg, "Static_Type_Scholar")
    temp._deadeyeIcon = UI.getChildControl(temp._memberBg, "Static_Type_DeadEye")
    temp._ogongIcon = UI.getChildControl(temp._memberBg, "Static_Type_Ogong")
    temp._seraphimIcon = UI.getChildControl(temp._memberBg, "Static_Type_Seraphim")
    temp._userName = UI.getChildControl(temp._memberBg, "StaticText_Name")
    temp._chk_ShowFloatButton = UI.getChildControl(temp._memberBg, "CheckButton_Show_Button")
    temp._userNo = nil
    temp._chk_ShowFloatButton:addInputEvent("Mouse_LUp", "HandleEventLUp_SolareCustom_ShowFloatButton(" .. tostring(__eInstanceSolareCustomMatch_BlueTeam) .. ", " .. tostring(blueIndex) .. ")")
    self._blueTeamMemberUI:push_back(temp)
  end
end
function PaGlobal_Solare_Custom:createChatMessagePool()
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  if self._chatMessagePool ~= nil then
    return
  end
  self._chatMessagePool = Array.new()
  for index = 1, self._chatMessageMaxCount do
    local controlId = "Static_SolareCustom_Chat_" .. tostring(index)
    local newControl = UI.cloneControl(self._ui._txt_ChatTemplate, self._ui._frame_ChatContent, controlId)
    if newControl == nil then
      return
    end
    local chatData = {_control = newControl, _posIndex = 0}
    chatData._control:SetShow(false)
    chatData._control:SetSpanSize(0, 5)
    chatData._control:ComputePos()
    self._chatMessagePool:push_back(chatData)
  end
  self._chatMessageAccCount = 0
end
function PaGlobal_Solare_Custom:registerEventHandler()
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  if self._isConsole == false then
    self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_SolareCustom_Close()")
    self._ui._btn_Guide:addInputEvent("Mouse_LUp", "HandleEventLUp_SolareCustom_ShowGuide()")
    self._ui._btn_Start:addInputEvent("Mouse_LUp", "HandleEventLUp_SolareCustom_StartCustomMatch()")
    self._ui._btn_Exit:addInputEvent("Mouse_LUp", "HandleEventLUp_SolareCustom_ExitRoom()")
  else
    Panel_Window_Solrare_CustomMatching:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobalFunc_SolareCustom_Close()")
    Panel_Window_Solrare_CustomMatching:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_SolareCustom_StartCustomMatch()")
    Panel_Window_Solrare_CustomMatching:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_SolareCustom_EditChat_SetFocus()")
    self._ui._btn_Start:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_SolareCustom_StartCustomMatch()")
    self._ui._btn_Exit:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_SolareCustom_ExitRoom()")
    if ToClient_isConsole() == true then
      self._ui._edit_Chat:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_SolareCustom_PressedEnter")
    end
  end
  self._ui._list_WaitMember:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_SolareCustom_UpdateWaitInfo")
  self._ui._list_WaitMember:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_MoveToRed:addInputEvent("Mouse_LUp", "HandleEventLUp_SolareCustom_MoveTeam(" .. tostring(__eInstanceSolareCustomMatch_RedTeam) .. ")")
  self._ui._btn_MoveToBlue:addInputEvent("Mouse_LUp", "HandleEventLUp_SolareCustom_MoveTeam(" .. tostring(__eInstanceSolareCustomMatch_BlueTeam) .. ")")
  self._ui._btn_MoveToWait:addInputEvent("Mouse_LUp", "HandleEventLUp_SolareCustom_MoveTeam(" .. tostring(__eInstanceSolareCustomMatch_WaitTeam) .. ")")
  self._ui._btn_KickOut:addInputEvent("Mouse_LUp", "HandleEventLUp_SolareCustom_KickOut()")
  registerEvent("FromClient_NotifyCreateSolareCustomRoom", "FromClient_NotifyCreateSolareCustomRoom")
  registerEvent("FromClient_NotifyDestroySolareCustomRoom", "FromClient_NotifyDestroySolareCustomRoom")
  registerEvent("FromClient_UpdateSolareCustomRoom", "FromClient_UpdateSolareCustomRoom")
  registerEvent("FromClient_NotifyInviteSolareCustomRoom", "FromClient_NotifyInviteSolareCustomRoom")
  registerEvent("FromClient_NotifySolareCustomRoomChat", "FromClient_NotifySolareCustomRoomChat")
  registerEvent("FromClient_ExitSolareCustomRoom", "FromClient_ExitSolareCustomRoom")
  registerEvent("FromClient_SuccessAcceptInviteSolareCustomRoom", "PaGlobalFunc_SolareCustom_Open()")
end
function PaGlobal_Solare_Custom:validate()
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  self._ui._stc_MapImage:isValidate()
  self._ui._txt_MapName:isValidate()
  self._ui._list_WaitMember:isValidate()
  self._ui._frame_Chat:isValidate()
  self._ui._edit_Chat:isValidate()
  self._ui._frame_ChatContent:isValidate()
  self._ui._txt_ChatTemplate:isValidate()
  self._ui._btn_Close:isValidate()
  self._ui._btn_Guide:isValidate()
  self._ui._btn_Start:isValidate()
  self._ui._btn_Exit:isValidate()
  if self._isConsole == false then
    self._ui._pc._btn_MapLeft:isValidate()
    self._ui._pc._btn_MapRight:isValidate()
  else
    self._ui._console._keyGuideBg:isValidate()
    self._ui._console._txt_InputChat:isValidate()
    self._ui._console._txt_Close:isValidate()
    self._ui._console._txt_Select:isValidate()
    self._ui._console._txt_Start:isValidate()
  end
  for index = 1, #self._redTeamMemberUI do
    self._redTeamMemberUI[index]._memberBg:isValidate()
    self._redTeamMemberUI[index]._profile:isValidate()
    self._redTeamMemberUI[index]._tier:isValidate()
    self._redTeamMemberUI[index]._awakenIcon:isValidate()
    self._redTeamMemberUI[index]._successionIcon:isValidate()
    self._redTeamMemberUI[index]._shyIcon:isValidate()
    self._redTeamMemberUI[index]._archerIcon:isValidate()
    self._redTeamMemberUI[index]._scholarIcon:isValidate()
    self._redTeamMemberUI[index]._deadeyeIcon:isValidate()
    self._redTeamMemberUI[index]._ogongIcon:isValidate()
    self._redTeamMemberUI[index]._seraphimIcon:isValidate()
    self._redTeamMemberUI[index]._userName:isValidate()
    self._redTeamMemberUI[index]._chk_ShowFloatButton:isValidate()
  end
  for index = 1, #self._blueTeamMemberUI do
    self._blueTeamMemberUI[index]._memberBg:isValidate()
    self._blueTeamMemberUI[index]._profile:isValidate()
    self._blueTeamMemberUI[index]._tier:isValidate()
    self._blueTeamMemberUI[index]._awakenIcon:isValidate()
    self._blueTeamMemberUI[index]._successionIcon:isValidate()
    self._blueTeamMemberUI[index]._shyIcon:isValidate()
    self._blueTeamMemberUI[index]._archerIcon:isValidate()
    self._blueTeamMemberUI[index]._scholarIcon:isValidate()
    self._blueTeamMemberUI[index]._deadeyeIcon:isValidate()
    self._blueTeamMemberUI[index]._ogongIcon:isValidate()
    self._blueTeamMemberUI[index]._seraphimIcon:isValidate()
    self._blueTeamMemberUI[index]._userName:isValidate()
    self._blueTeamMemberUI[index]._chk_ShowFloatButton:isValidate()
  end
end
function PaGlobal_Solare_Custom:prepareOpen()
  if Panel_Window_Solrare_CustomMatching == nil then
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
  local userNo = selfPlayer:getUserNo()
  local playerInfo = ToClient_GetSolareCustomRoomPlayerInfoWrapperByUserNo(userNo)
  if playerInfo ~= nil then
    self._isRoomLeader = playerInfo:isRoomLeader()
  end
  self._ui._edit_Chat:SetEditText("")
  if self._isConsole == true then
    self._ui._btn_Close:SetShow(false)
    self._ui._btn_Guide:SetShow(false)
    self._ui._console._keyGuideBg:SetShow(true)
    local tempBtnGroup = {
      self._ui._console._txt_Select,
      self._ui._console._txt_Close,
      self._ui._console._txt_InputChat,
      self._ui._console._txt_Start
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui._console._keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  self:updateChatMessage(0)
  self:open()
end
function PaGlobal_Solare_Custom:open()
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  Panel_Window_Solrare_CustomMatching:SetShow(true)
  self:updateTeamInfo()
end
function PaGlobal_Solare_Custom:prepareClose()
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  self:closeFloatingPopUp()
  self:clearTeamInfo()
  self:close()
end
function PaGlobal_Solare_Custom:close()
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  Panel_Window_Solrare_CustomMatching:SetShow(false)
end
function PaGlobal_Solare_Custom:updateTeamInfo()
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  if Panel_Window_Solrare_CustomMatching:GetShow() == false then
    return
  end
  self:clearTeamInfo()
  for index = 0, __eInstanceSolareCustomMatch_TeamPlayerCount - 1 do
    local redTeamPlayerInfo = ToClient_GetSolareCustomRoomPlayerInfoWrapper(__eInstanceSolareCustomMatch_RedTeam, index)
    local blueTeamPlayerInfo = ToClient_GetSolareCustomRoomPlayerInfoWrapper(__eInstanceSolareCustomMatch_BlueTeam, index)
    if redTeamPlayerInfo ~= nil then
      self:activateMemberByIndex(__eInstanceSolareCustomMatch_RedTeam, index)
    end
    if blueTeamPlayerInfo ~= nil then
      self:activateMemberByIndex(__eInstanceSolareCustomMatch_BlueTeam, index)
    end
  end
  local isExistEmptySlot = false
  for index = 0, __eInstanceSolareCustomMatch_TotalPlayerCount - 1 do
    local waitPlayerInfo = ToClient_GetSolareCustomRoomPlayerInfoWrapper(__eInstanceSolareCustomMatch_WaitTeam, index)
    if waitPlayerInfo ~= nil then
      self._ui._list_WaitMember:getElementManager():pushKey(waitPlayerInfo:getUserNo())
    else
      isExistEmptySlot = true
    end
  end
  if isExistEmptySlot == true then
    self._ui._list_WaitMember:getElementManager():pushKey(toInt64(0, 0))
  end
end
function PaGlobal_Solare_Custom:updateWaitTeamInfo(control, index)
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  if Panel_Window_Solrare_CustomMatching:GetShow() == false then
    return
  end
  local userNo = index
  local uiControls = {
    _memberBg = nil,
    _profile = nil,
    _tier = nil,
    _awakenIcon = nil,
    _successionIcon = nil,
    _shyIcon = nil,
    _archerIcon = nil,
    _scholarIcon = nil,
    _deadeyeIcon = nil,
    _ogongIcon = nil,
    _seraphimIcon = nil,
    _userName = nil,
    _chk_ShowFloatButton = nil,
    _addIcon = nil,
    _userNo = nil
  }
  uiControls._memberBg = UI.getChildControl(control, "Static_Member_BG")
  uiControls._profile = UI.getChildControl(uiControls._memberBg, "Static_Profile")
  uiControls._tier = UI.getChildControl(uiControls._memberBg, "Static_Tier")
  uiControls._awakenIcon = UI.getChildControl(uiControls._memberBg, "Static_Type_Awaken")
  uiControls._successionIcon = UI.getChildControl(uiControls._memberBg, "Static_Type_Succession")
  uiControls._shyIcon = UI.getChildControl(uiControls._memberBg, "Static_Type_Shy")
  uiControls._archerIcon = UI.getChildControl(uiControls._memberBg, "Static_Type_Archer")
  uiControls._scholarIcon = UI.getChildControl(uiControls._memberBg, "Static_Type_Scholar")
  uiControls._deadeyeIcon = UI.getChildControl(uiControls._memberBg, "Static_Type_DeadEye")
  uiControls._ogongIcon = UI.getChildControl(uiControls._memberBg, "Static_Type_Ogong")
  uiControls._seraphimIcon = UI.getChildControl(uiControls._memberBg, "Static_Type_Seraphim")
  uiControls._userName = UI.getChildControl(uiControls._memberBg, "StaticText_Name")
  uiControls._chk_ShowFloatButton = UI.getChildControl(uiControls._memberBg, "CheckButton_Show_Button")
  uiControls._addIcon = UI.getChildControl(uiControls._memberBg, "Static_AddIcon")
  uiControls._memberBg:SetShow(false)
  uiControls._profile:SetShow(false)
  uiControls._tier:SetShow(false)
  uiControls._awakenIcon:SetShow(false)
  uiControls._successionIcon:SetShow(false)
  uiControls._shyIcon:SetShow(false)
  uiControls._archerIcon:SetShow(false)
  uiControls._scholarIcon:SetShow(false)
  uiControls._deadeyeIcon:SetShow(false)
  uiControls._ogongIcon:SetShow(false)
  uiControls._seraphimIcon:SetShow(false)
  uiControls._userName:SetShow(false)
  uiControls._chk_ShowFloatButton:SetShow(false)
  uiControls._addIcon:SetShow(false)
  local parent = uiControls._memberBg:getParent()
  if parent ~= nil then
    parent:SetSize(uiControls._memberBg:GetSizeX(), uiControls._memberBg:GetSizeY())
  end
  if userNo == toInt64(0, 0) then
    if ToClient_isPlayingSolareCustomMatch() == false or self._isRoomLeader == true then
      uiControls._memberBg:SetShow(true)
      uiControls._addIcon:SetShow(true)
      uiControls._memberBg:addInputEvent("Mouse_LUp", "HandleEventLUp_SolareCustom_Invite()")
    end
  else
    local playerInfo = ToClient_GetSolareCustomRoomPlayerInfoWrapperByUserNo(userNo)
    if playerInfo ~= nil then
      local teamType = playerInfo:getTeamType()
      local memberIndex = playerInfo:getMemberIndex()
      if self._isRoomLeader == true then
        uiControls._chk_ShowFloatButton:addInputEvent("Mouse_LUp", "HandleEventLUp_SolareCustom_ShowFloatButton(" .. tostring(teamType) .. ", " .. tostring(memberIndex) .. ")")
        uiControls._chk_ShowFloatButton:SetShow(true)
      else
        uiControls._chk_ShowFloatButton:SetShow(false)
      end
      uiControls._memberBg:removeInputEvent("Mouse_LUp")
      self:setPlayerInfo(uiControls, playerInfo)
    end
  end
end
function PaGlobal_Solare_Custom:activateMemberByIndex(teamNo, index)
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  if teamNo == __eInstanceSolareCustomMatch_RedTeam then
    if index >= 0 and index < __eInstanceSolareCustomMatch_TeamPlayerCount then
      local playerInfo = ToClient_GetSolareCustomRoomPlayerInfoWrapper(__eInstanceSolareCustomMatch_RedTeam, index)
      if playerInfo ~= nil then
        self:setPlayerInfo(self._redTeamMemberUI[index + 1], playerInfo)
      end
    end
  elseif teamNo == __eInstanceSolareCustomMatch_BlueTeam then
    if index >= 0 and index < __eInstanceSolareCustomMatch_TeamPlayerCount then
      local playerInfo = ToClient_GetSolareCustomRoomPlayerInfoWrapper(__eInstanceSolareCustomMatch_BlueTeam, index)
      if playerInfo ~= nil then
        self:setPlayerInfo(self._blueTeamMemberUI[index + 1], playerInfo)
      end
    end
  else
    UI.ASSERT_NAME(false, "\236\134\148\235\157\188\235\160\136 \237\140\128\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 \236\151\172\234\184\176\235\143\132 \236\182\148\234\176\128\237\149\180\236\163\188\236\133\148\236\149\188\237\149\169\235\139\136\235\139\164.", "\236\160\149\236\132\157\235\175\188")
  end
end
function PaGlobal_Solare_Custom:deactivateMemberByIndex(teamNo, index)
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  if teamNo == __eInstanceSolareCustomMatch_RedTeam then
    if index > 0 and index <= #self._redTeamMemberUI then
      self._redTeamMemberUI[index]._profile:SetShow(false)
      self._redTeamMemberUI[index]._tier:SetShow(false)
      self._redTeamMemberUI[index]._awakenIcon:SetShow(false)
      self._redTeamMemberUI[index]._successionIcon:SetShow(false)
      self._redTeamMemberUI[index]._shyIcon:SetShow(false)
      self._redTeamMemberUI[index]._archerIcon:SetShow(false)
      self._redTeamMemberUI[index]._scholarIcon:SetShow(false)
      self._redTeamMemberUI[index]._deadeyeIcon:SetShow(false)
      self._redTeamMemberUI[index]._ogongIcon:SetShow(false)
      self._redTeamMemberUI[index]._seraphimIcon:SetShow(false)
      self._redTeamMemberUI[index]._userName:SetShow(false)
      self._redTeamMemberUI[index]._chk_ShowFloatButton:SetShow(false)
      self._redTeamMemberUI[index]._userNo = nil
    end
  elseif teamNo == __eInstanceSolareCustomMatch_BlueTeam then
    if index > 0 and index <= #self._blueTeamMemberUI then
      self._blueTeamMemberUI[index]._profile:SetShow(false)
      self._blueTeamMemberUI[index]._tier:SetShow(false)
      self._blueTeamMemberUI[index]._awakenIcon:SetShow(false)
      self._blueTeamMemberUI[index]._successionIcon:SetShow(false)
      self._blueTeamMemberUI[index]._shyIcon:SetShow(false)
      self._blueTeamMemberUI[index]._archerIcon:SetShow(false)
      self._blueTeamMemberUI[index]._scholarIcon:SetShow(false)
      self._blueTeamMemberUI[index]._deadeyeIcon:SetShow(false)
      self._blueTeamMemberUI[index]._ogongIcon:SetShow(false)
      self._blueTeamMemberUI[index]._seraphimIcon:SetShow(false)
      self._blueTeamMemberUI[index]._userName:SetShow(false)
      self._blueTeamMemberUI[index]._chk_ShowFloatButton:SetShow(false)
      self._blueTeamMemberUI[index]._userNo = nil
    end
  else
    UI.ASSERT_NAME(false, "\236\134\148\235\157\188\235\160\136 \237\140\128\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 \236\151\172\234\184\176\235\143\132 \236\182\148\234\176\128\237\149\180\236\163\188\236\133\148\236\149\188\237\149\169\235\139\136\235\139\164.", "\236\160\149\236\132\157\235\175\188")
  end
end
function PaGlobal_Solare_Custom:clearTeamInfo()
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  for index = 1, #self._redTeamMemberUI do
    self:deactivateMemberByIndex(__eInstanceSolareCustomMatch_RedTeam, index)
  end
  for index = 1, #self._blueTeamMemberUI do
    self:deactivateMemberByIndex(__eInstanceSolareCustomMatch_BlueTeam, index)
  end
  self._ui._list_WaitMember:getElementManager():clearKey()
end
function PaGlobal_Solare_Custom:setPlayerInfo(control, playerInfo)
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  if Panel_Window_Solrare_CustomMatching:GetShow() == false then
    return
  end
  if control == nil then
    return
  end
  if playerInfo == nil then
    return
  end
  local classType = playerInfo:getClassType()
  local skillTypeParam = playerInfo:getSkillTypeParam()
  local userName = playerInfo:getUserName()
  local solareRankRating = playerInfo:getSolareRankRating()
  control._userNo = Int64toInt32(playerInfo:getUserNo())
  control._userName:SetText(userName)
  PaGlobalFunc_Util_SetSolrareIngameClassBg(control._profile, classType)
  if classType == __eClassType_ShyWaman then
    control._shyIcon:SetShow(true)
  elseif classType == __eClassType_RangerMan then
    control._archerIcon:SetShow(true)
  elseif classType == __eClassType_Scholar then
    control._scholarIcon:SetShow(true)
  elseif classType == __eClassType_PWGE then
    control._deadeyeIcon:SetShow(true)
  elseif classType == __eClassType_PJKD then
    control._ogongIcon:SetShow(true)
  elseif classType == __eClassType_PDKL then
    control._seraphimIcon:SetShow(true)
  elseif skillTypeParam == __eSkillTypeParam_Awaken then
    control._awakenIcon:SetShow(true)
  elseif skillTypeParam == __eSkillTypeParam_Inherit then
    control._successionIcon:SetShow(true)
  end
  _PA_ASSERT_NAME(NewClassData.NewClassType == __eClassType_PDKL, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. ", "\236\161\176\236\139\156\236\153\132")
  PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(control._tier, solareRankRating)
  control._memberBg:SetShow(true)
  control._profile:SetShow(true)
  control._userName:SetShow(true)
  control._tier:SetShow(true)
  if self._isRoomLeader == true then
    control._chk_ShowFloatButton:SetShow(true)
  else
    control._chk_ShowFloatButton:SetShow(false)
  end
  if control._addIcon ~= nil then
    control._addIcon:SetShow(false)
  end
end
function PaGlobal_Solare_Custom:openFloatingPopUp(teamType, memberIndex)
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  if self._isRoomLeader == false then
    return
  end
  self:closeFloatingPopUp()
  local panelPosX = Panel_Window_Solrare_CustomMatching:GetPosX()
  local panelPosY = Panel_Window_Solrare_CustomMatching:GetPosY()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  local playerInfoWrapper = ToClient_GetSolareCustomRoomPlayerInfoWrapper(teamType, memberIndex)
  if playerInfoWrapper == nil then
    return
  end
  if teamType == __eInstanceSolareCustomMatch_RedTeam then
    if self._redTeamMemberUI[memberIndex + 1]._chk_ShowFloatButton:IsCheck() == true then
      self._selectedTeamType = teamType
      self._selectedMemberIndex = memberIndex
      self._ui._stc_FloatBtnBg:SetShow(true)
      self._ui._btn_MoveToBlue:SetShow(true)
      self._ui._btn_MoveToWait:SetShow(true)
      self._ui._btn_MoveToBlue:SetSpanSize(0, 10)
      self._ui._btn_MoveToWait:SetSpanSize(0, 60)
      local parentPosX = self._redTeamMemberUI[memberIndex + 1]._chk_ShowFloatButton:GetParentPosX()
      local parentPosY = self._redTeamMemberUI[memberIndex + 1]._chk_ShowFloatButton:GetParentPosY()
      local diffX = parentPosX - panelPosX
      local diffY = parentPosY - panelPosY
      self._ui._stc_FloatBtnBg:SetPosX(diffX + 30)
      self._ui._stc_FloatBtnBg:SetPosY(diffY)
      if playerInfoWrapper:getUserNo() == selfPlayer:getUserNo() then
        self._ui._btn_KickOut:SetShow(false)
        self._ui._stc_FloatBtnBg:SetSize(self._ui._stc_FloatBtnBg:GetSizeX(), self._originFloatBtnBgSizeY - self._ui._btn_KickOut:GetSizeY() - 10)
      else
        self._ui._btn_KickOut:SetShow(true)
        self._ui._btn_KickOut:SetSpanSize(0, 110)
        self._ui._stc_FloatBtnBg:SetSize(self._ui._stc_FloatBtnBg:GetSizeX(), self._originFloatBtnBgSizeY)
      end
    end
  elseif teamType == __eInstanceSolareCustomMatch_BlueTeam then
    if self._blueTeamMemberUI[memberIndex + 1]._chk_ShowFloatButton:IsCheck() == true then
      self._selectedTeamType = teamType
      self._selectedMemberIndex = memberIndex
      self._ui._stc_FloatBtnBg:SetShow(true)
      self._ui._btn_MoveToRed:SetShow(true)
      self._ui._btn_MoveToWait:SetShow(true)
      self._ui._btn_MoveToRed:SetSpanSize(0, 10)
      self._ui._btn_MoveToWait:SetSpanSize(0, 60)
      local parentPosX = self._blueTeamMemberUI[memberIndex + 1]._chk_ShowFloatButton:GetParentPosX()
      local parentPosY = self._blueTeamMemberUI[memberIndex + 1]._chk_ShowFloatButton:GetParentPosY()
      local diffX = parentPosX - panelPosX
      local diffY = parentPosY - panelPosY
      self._ui._stc_FloatBtnBg:SetPosX(diffX + 30)
      self._ui._stc_FloatBtnBg:SetPosY(diffY)
      if playerInfoWrapper:getUserNo() == selfPlayer:getUserNo() then
        self._ui._btn_KickOut:SetShow(false)
        self._ui._stc_FloatBtnBg:SetSize(self._ui._stc_FloatBtnBg:GetSizeX(), self._originFloatBtnBgSizeY - self._ui._btn_KickOut:GetSizeY() - 10)
      else
        self._ui._btn_KickOut:SetShow(true)
        self._ui._btn_KickOut:SetSpanSize(0, 110)
        self._ui._stc_FloatBtnBg:SetSize(self._ui._stc_FloatBtnBg:GetSizeX(), self._originFloatBtnBgSizeY)
      end
    end
  elseif teamType == __eInstanceSolareCustomMatch_WaitTeam then
    local waitMemberControl = self._ui._list_WaitMember:GetContentByKey(playerInfoWrapper:getUserNo())
    local waitMemberBg = UI.getChildControl(waitMemberControl, "Static_Member_BG")
    local chkButton = UI.getChildControl(waitMemberBg, "CheckButton_Show_Button")
    if chkButton:IsCheck() == true then
      self._selectedTeamType = teamType
      self._selectedMemberIndex = memberIndex
      self._ui._stc_FloatBtnBg:SetShow(true)
      self._ui._btn_MoveToRed:SetShow(true)
      self._ui._btn_MoveToBlue:SetShow(true)
      self._ui._btn_MoveToRed:SetSpanSize(0, 10)
      self._ui._btn_MoveToBlue:SetSpanSize(0, 60)
      local parentPosX = chkButton:GetParentPosX()
      local parentPosY = chkButton:GetParentPosY()
      local diffX = parentPosX - panelPosX
      local diffY = parentPosY - panelPosY
      self._ui._stc_FloatBtnBg:SetPosX(diffX + 30)
      self._ui._stc_FloatBtnBg:SetPosY(diffY)
      if playerInfoWrapper:getUserNo() == selfPlayer:getUserNo() then
        self._ui._btn_KickOut:SetShow(false)
        self._ui._stc_FloatBtnBg:SetSize(self._ui._stc_FloatBtnBg:GetSizeX(), self._originFloatBtnBgSizeY - self._ui._btn_KickOut:GetSizeY() - 10)
      else
        self._ui._btn_KickOut:SetShow(true)
        self._ui._btn_KickOut:SetSpanSize(0, 110)
        self._ui._stc_FloatBtnBg:SetSize(self._ui._stc_FloatBtnBg:GetSizeX(), self._originFloatBtnBgSizeY)
      end
    end
  else
    UI.ASSERT_NAME(false, "\236\134\148\235\157\188\235\160\136 \237\140\128\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 \236\151\172\234\184\176\235\143\132 \236\182\148\234\176\128\237\149\180\236\163\188\236\133\148\236\149\188\237\149\169\235\139\136\235\139\164.", "\236\160\149\236\132\157\235\175\188")
  end
end
function PaGlobal_Solare_Custom:closeFloatingPopUp()
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  if self._selectedTeamType == nil or self._selectedMemberIndex == nil then
    self._ui._stc_FloatBtnBg:SetShow(false)
    return
  end
  if self._selectedTeamType == __eInstanceSolareCustomMatch_RedTeam then
    local control = self._redTeamMemberUI[self._selectedMemberIndex + 1]
    if control == nil then
      self._selectedTeamType = nil
      self._selectedMemberIndex = nil
      self._ui._stc_FloatBtnBg:SetShow(false)
      return
    end
    control._chk_ShowFloatButton:SetCheck(false)
  elseif self._selectedTeamType == __eInstanceSolareCustomMatch_BlueTeam then
    local control = self._blueTeamMemberUI[self._selectedMemberIndex + 1]
    if control == nil then
      self._selectedTeamType = nil
      self._selectedMemberIndex = nil
      self._ui._stc_FloatBtnBg:SetShow(false)
      return
    end
    control._chk_ShowFloatButton:SetCheck(false)
  elseif self._selectedTeamType == __eInstanceSolareCustomMatch_WaitTeam then
    local playerInfoWrapper = ToClient_GetSolareCustomRoomPlayerInfoWrapper(__eInstanceSolareCustomMatch_WaitTeam, self._selectedMemberIndex)
    if playerInfoWrapper == nil then
      self._selectedTeamType = nil
      self._selectedMemberIndex = nil
      self._ui._stc_FloatBtnBg:SetShow(false)
      return
    end
    local waitMemberControl = self._ui._list_WaitMember:GetContentByKey(playerInfoWrapper:getUserNo())
    local waitMemberBg = UI.getChildControl(waitMemberControl, "Static_Member_BG")
    local checkBox = UI.getChildControl(waitMemberBg, "CheckButton_Show_Button")
    checkBox:SetCheck(false)
  end
  self._selectedTeamType = nil
  self._selectedMemberIndex = nil
  self._ui._stc_FloatBtnBg:SetShow(false)
  self._ui._btn_KickOut:SetShow(false)
  self._ui._btn_MoveToRed:SetShow(false)
  self._ui._btn_MoveToBlue:SetShow(false)
  self._ui._btn_MoveToWait:SetShow(false)
end
function PaGlobal_Solare_Custom:sendChatMessage()
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  local message = self._ui._edit_Chat:GetEditText()
  self._ui._edit_Chat:SetEditText("")
  if ToClient_isPlayingSolareCustomMatch() == false then
    return
  end
  chatting_sendMessage("", message, CppEnums.ChatType.SolareCustom)
end
function PaGlobal_Solare_Custom:addChatMessage(userNickname, message)
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  if self._chatMessagePool == nil then
    return
  end
  local chatIndex = self._chatMessageAccCount % self._chatMessageMaxCount + 1
  local chatData = self._chatMessagePool[chatIndex]
  if chatData == nil then
    return
  end
  chatData._control:SetShow(true)
  chatData._posIndex = 0
  chatData._control:SetText("[" .. tostring(userNickname) .. "]: " .. tostring(message))
  chatData._control:SetSize(chatData._control:GetSizeX(), chatData._control:GetTextSizeY())
  self:updateChatMessage(chatData._control:GetSizeY())
  self._chatMessageAccCount = self._chatMessageAccCount + 1
end
function PaGlobal_Solare_Custom:calcChatMessageSpanY(posIndex)
  if Panel_Window_Solrare_CustomMatching == nil then
    return 0
  end
  if self._chatMessagePool == nil then
    return 0
  end
  local termY = 5
  local spanY = 0
  for messageIndex = 1, self._chatMessageMaxCount do
    local chatMessageData = self._chatMessagePool[messageIndex]
    if chatMessageData ~= nil and chatMessageData._control:GetShow() == true and posIndex > chatMessageData._posIndex then
      spanY = spanY + chatMessageData._control:GetSizeY() + termY
    end
  end
  return spanY
end
function PaGlobal_Solare_Custom:clearChatMessage()
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  if self._chatMessagePool == nil then
    return
  end
  for messageIndex = 1, self._chatMessageMaxCount do
    local chatData = self._chatMessagePool[messageIndex]
    if chatData ~= nil and chatData._control:GetShow() == true then
      chatData._posIndex = nil
      chatData._control:SetText("")
      chatData._control:SetShow(false)
    end
  end
  self._ui._frame_ChatContent:SetSize(self._ui._frame_ChatContent:GetSizeX(), self._originFrameChatContentSizeY)
  self._ui._frame_ChatContent:ComputePosAllChild()
  self._ui._stc_frameVScroll:SetShow(false)
  self._ui._stc_frameVScroll:SetControlPos(0)
  self._ui._frame_Chat:UpdateContentPos()
  self._ui._frame_Chat:ComputePosAllChild()
  self._chatMessageAccCount = 0
end
function PaGlobal_Solare_Custom:checkCanStartCustomMatch()
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  if self._isRoomLeader == false then
    self._ui._btn_Start:SetIgnore(true)
    self._ui._btn_Start:SetMonoTone(true)
    return
  end
  if ToClient_GetTeamPlayerCountInSolareCustomRoom(tostring(__eInstanceSolareCustomMatch_RedTeam)) ~= __eInstanceSolareCustomMatch_TeamPlayerCount or ToClient_GetTeamPlayerCountInSolareCustomRoom(tostring(__eInstanceSolareCustomMatch_BlueTeam)) ~= __eInstanceSolareCustomMatch_TeamPlayerCount then
    self._ui._btn_Start:SetIgnore(true)
    self._ui._btn_Start:SetMonoTone(true)
  else
    self._ui._btn_Start:SetIgnore(false)
    self._ui._btn_Start:SetMonoTone(false)
  end
end
function PaGlobal_Solare_Custom:updateChatMessage(newChatMessageSizeY)
  if Panel_Window_Solrare_CustomMatching == nil then
    return
  end
  local termY = 5
  local highestSpanY = -1
  local currentScrollPos = 1
  local spanX = 5
  for messageIndex = 1, self._chatMessageMaxCount do
    local chatMessageData = self._chatMessagePool[messageIndex]
    if chatMessageData ~= nil and chatMessageData._control:GetShow() == true then
      chatMessageData._posIndex = chatMessageData._posIndex + 1
      if self._chatMessageMaxCount < chatMessageData._posIndex then
        chatMessageData._posIndex = chatMessageData._posIndex % self._chatMessageMaxCount
      end
      local spanY = self:calcChatMessageSpanY(chatMessageData._posIndex)
      chatMessageData._control:SetSpanSize(spanX, spanY)
      if highestSpanY < spanY then
        highestSpanY = spanY
      end
    end
  end
  self._ui._frame_ChatContent:SetSize(self._ui._frame_ChatContent:GetSizeX(), highestSpanY + newChatMessageSizeY)
  self._ui._frame_ChatContent:ComputePosAllChild()
  if self._ui._frame_Chat:GetSizeY() < self._ui._frame_ChatContent:GetSizeY() then
    self._ui._stc_frameVScroll:SetShow(true)
  else
    self._ui._stc_frameVScroll:SetShow(false)
  end
  self._ui._stc_frameVScroll:SetControlPos(currentScrollPos)
  self._ui._frame_Chat:UpdateContentPos()
  self._ui._frame_Chat:ComputePosAllChild()
end
