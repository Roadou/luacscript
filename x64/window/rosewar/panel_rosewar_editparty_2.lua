local dragPanelSizeX = 0
local dragPanelSizeY = 0
function PaGlobal_RoseWarEditParty:initDragPanel()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  self._dragPanel = Panel_RoseWar_EditParty_Drag
  self._dragPanel:SetPosXY(0, 0)
  self._dragPanel:SetIgnore(true)
  self._dragPanel:SetShow(false)
  dragPanelSizeX = self._dragPanel:GetSizeX()
  dragPanelSizeY = self._dragPanel:GetSizeY()
end
function PaGlobal_RoseWarEditParty:startDragByMember(s64_memberListKey)
  if Panel_RoseWar_EditParty == nil or s64_memberListKey == nil then
    return
  end
  if self._isEditMode == false then
    return
  end
  if self._dragPanel == nil or self:isDragging() == true then
    return
  end
  if self:isOpenRClickMenu() == true then
    self:closeRClickMenu()
  end
  if 1 < self._partyMemberList_selectInfo:length() then
    self:clearPartyMemberSelectInfo()
    self:updatePartyList()
  end
  if self._memberList_selectInfo == nil then
    self._memberList_selectInfo = Array.new()
  end
  if 1 >= self._memberList_selectInfo:length() then
    self:addMemberListSelectInfo(s64_memberListKey)
  end
  local txt_selectedCount = UI.getChildControl(self._dragPanel, "StaticText_MultiCount")
  txt_selectedCount:SetText(tostring(self._memberList_selectInfo:length()))
  RoseWarEditParty_DragPanel_UpdatePos()
  self._dragPanel:RegisterUpdateFunc("RoseWarEditParty_DragPanel_UpdatePos")
  self._dragPanel:SetShow(true)
end
function PaGlobal_RoseWarEditParty:startDragByPartyMember(partyDataIndex, partyMemberIndex)
  if Panel_RoseWar_EditParty == nil or partyDataIndex == nil or partyMemberIndex == nil then
    return
  end
  if self._isEditMode == false then
    return
  end
  if self._dragPanel == nil or self:isDragging() == true then
    return
  end
  if self:isOpenRClickMenu() == true then
    self:closeRClickMenu()
  end
  if 1 < self._memberList_selectInfo:length() then
    self:clearMemberSelectInfo()
    self:updateMemberList()
  end
  if self._partyMemberList_selectInfo == nil then
    self._partyMemberList_selectInfo = Array.new()
  end
  if 1 >= self._partyMemberList_selectInfo:length() then
    self:addPartyMemberListSelectInfo(partyDataIndex, partyMemberIndex)
  end
  local txt_selectedCount = UI.getChildControl(self._dragPanel, "StaticText_MultiCount")
  txt_selectedCount:SetText(tostring(self._partyMemberList_selectInfo:length()))
  RoseWarEditParty_DragPanel_UpdatePos()
  self._dragPanel:RegisterUpdateFunc("RoseWarEditParty_DragPanel_UpdatePos")
  self._dragPanel:SetShow(true)
end
function PaGlobal_RoseWarEditParty:clearDrag()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  if self._dragPanel == nil then
    return
  end
  if self:isDragging() == false then
    return
  end
  self._dragPanel:ClearUpdateLuaFunc()
  self._dragPanel:SetShow(false)
end
function PaGlobal_RoseWarEditParty:isDragging()
  if Panel_RoseWar_EditParty == nil then
    return false
  end
  if self._dragPanel == nil then
    return false
  end
  return self._dragPanel:GetShow()
end
function RoseWarEditParty_DragPanel_UpdatePos()
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  local posX = getMousePosX()
  local posY = getMousePosY()
  self._dragPanel:SetPosXY(posX - dragPanelSizeX / 2, posY - dragPanelSizeY)
end
function PaGlobal_RoseWarEditParty:addMemberListSelectInfo(s64_memberListKey)
  if Panel_RoseWar_EditParty == nil or s64_memberListKey == nil then
    return
  end
  if self:isDragging() == true then
    return
  end
  local index = Int64toInt32(s64_memberListKey)
  local roseWarMemberDataWrapper = ToClient_GetRoseWarMemberDataWrapper(index)
  if roseWarMemberDataWrapper == nil then
    return
  end
  if self:isOpenRClickMenu() == true then
    self:closeRClickMenu()
  end
  for currentSelectedIndex = #self._partyMemberList_selectInfo, 1, -1 do
    local value = self._partyMemberList_selectInfo[currentSelectedIndex]
    table.remove(self._partyMemberList_selectInfo, currentSelectedIndex)
    if value ~= nil then
      local partyPoolData = self:getPartyPoolData(value._partyDataIndex)
      if partyPoolData ~= nil then
        local partyMemberContentKey = toInt64(value._partyDataIndex, value._partyMemberIndex)
        local list2_content = partyPoolData._lst_partyMemberList:GetContentByKey(partyMemberContentKey)
        if list2_content ~= nil then
          self:updatePartyMemberListContent(list2_content, partyMemberContentKey)
        end
      end
    end
  end
  local selectMode = self._eSelectMode.COUNT
  local isPressed_Ctrl = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_CONTROL)
  local isPressed_Shift = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT)
  if isPressed_Ctrl == true then
    selectMode = self._eSelectMode.ADD_ONE
  elseif isPressed_Shift == true then
    selectMode = self._eSelectMode.ADD_RANGE
  else
    selectMode = self._eSelectMode.ONLY_ONE
  end
  if self._memberList_selectInfo == nil then
    self._memberList_selectInfo = Array.new()
  end
  local selectedUserNo = roseWarMemberDataWrapper:getUserNo()
  local cacheIndex = index
  if selectMode == self._eSelectMode.ONLY_ONE then
    if 0 < self._memberList_selectInfo:length() then
      self:clearSelectInfo()
    end
    self:pushMemberListSelectInfo(selectedUserNo, cacheIndex)
  elseif selectMode == self._eSelectMode.ADD_ONE then
    if self:popMemberListSelectInfo(index) == false then
      self:pushMemberListSelectInfo(selectedUserNo, cacheIndex)
    end
  elseif selectMode == self._eSelectMode.ADD_RANGE then
    if self._memberList_selectInfo:length() == 0 then
      self:pushMemberListSelectInfo(selectedUserNo, cacheIndex)
    else
      local firstDataIndex
      for cacheIndex = #self._memberList_selectInfo, 1, -1 do
        local value = self._memberList_selectInfo[cacheIndex]
        if value ~= nil then
          if value._isFirst == true then
            firstDataIndex = value._dataIndex
          else
            table.remove(self._memberList_selectInfo, cacheIndex)
          end
        end
      end
      if index > firstDataIndex then
        for beginIndex = firstDataIndex + 1, index do
          local rangeMemberDataWrapper = ToClient_GetRoseWarMemberDataWrapper(beginIndex)
          if rangeMemberDataWrapper ~= nil then
            local isPushable = false
            local gradeType = rangeMemberDataWrapper:getGradeType()
            if self._currentTab == __eRoseWarPartyType_Guild then
              if gradeType == __eRoseWarPlayerGradeType_Commander or gradeType == __eRoseWarPlayerGradeType_SubCommander or gradeType == __eRoseWarPlayerGradeType_GuildPartyLeader or gradeType == __eRoseWarPlayerGradeType_GuildMember then
                isPushable = true
              end
            elseif self._currentTab == __eRoseWarPartyType_Mercenary and (gradeType == __eRoseWarPlayerGradeType_MercenaryPartyLeader or gradeType == __eRoseWarPlayerGradeType_Mercenary) then
              isPushable = true
            end
            if isPushable == true then
              self:pushMemberListSelectInfo(rangeMemberDataWrapper:getUserNo(), beginIndex)
            end
          end
        end
      else
        if index < firstDataIndex then
          for beginIndex = firstDataIndex - 1, index, -1 do
            local rangeMemberDataWrapper = ToClient_GetRoseWarMemberDataWrapper(beginIndex)
            if rangeMemberDataWrapper ~= nil then
              local isPushable = false
              local gradeType = rangeMemberDataWrapper:getGradeType()
              if self._currentTab == __eRoseWarPartyType_Guild then
                if gradeType == __eRoseWarPlayerGradeType_Commander or gradeType == __eRoseWarPlayerGradeType_SubCommander or gradeType == __eRoseWarPlayerGradeType_GuildPartyLeader or gradeType == __eRoseWarPlayerGradeType_GuildMember then
                  isPushable = true
                end
              elseif self._currentTab == __eRoseWarPartyType_Mercenary and (gradeType == __eRoseWarPlayerGradeType_MercenaryPartyLeader or gradeType == __eRoseWarPlayerGradeType_Mercenary) then
                isPushable = true
              end
              if isPushable == true then
                self:pushMemberListSelectInfo(rangeMemberDataWrapper:getUserNo(), beginIndex)
              end
            end
          end
        else
        end
      end
    end
  else
    return
  end
  local memberCount = ToClient_GetRoseWarMemberDataCount()
  for memberIndex = 0, memberCount - 1 do
    local memberContentKey = toInt64(0, memberIndex)
    local list2_content = self._ui._lst_memberList:GetContentByKey(memberContentKey)
    if list2_content ~= nil then
      self:updateMemberListContent(list2_content, memberContentKey)
    end
  end
end
function PaGlobal_RoseWarEditParty:pushMemberListSelectInfo(userNo, dataIndex)
  if Panel_RoseWar_EditParty == nil then
    return
  end
  if self._memberList_selectInfo == nil then
    self._memberList_selectInfo = Array.new()
  end
  local currentSelectedCount = self._memberList_selectInfo:length()
  local memberListSelectInfo = {
    _userNo = userNo,
    _dataIndex = dataIndex,
    _isFirst = currentSelectedCount == 0
  }
  self._memberList_selectInfo:push_back(memberListSelectInfo)
end
function PaGlobal_RoseWarEditParty:popMemberListSelectInfo(dataIndex)
  if Panel_RoseWar_EditParty == nil then
    return false
  end
  if self._memberList_selectInfo == nil then
    return false
  end
  local isNeedUpdateFirstCachInfo = false
  local isRemoved = false
  for cacheIndex = #self._memberList_selectInfo, 1, -1 do
    local value = self._memberList_selectInfo[cacheIndex]
    if value ~= nil and value._dataIndex == dataIndex then
      table.remove(self._memberList_selectInfo, cacheIndex)
      isNeedUpdateFirstCachInfo = value._isFirst
      isRemoved = true
      break
    end
  end
  if isNeedUpdateFirstCachInfo == true then
    for cacheIndex = 1, #self._memberList_selectInfo do
      local value = self._memberList_selectInfo[cacheIndex]
      if value ~= nil then
        value._isFirst = true
        break
      end
    end
  end
  return isRemoved
end
function PaGlobal_RoseWarEditParty:addPartyMemberListSelectInfo(partyDataIndex, partyMemberIndex)
  if Panel_RoseWar_EditParty == nil or partyDataIndex == nil or partyMemberIndex == nil then
    return
  end
  if self:isDragging() == true then
    return
  end
  local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(partyDataIndex)
  if partyDataWrapper == nil then
    return
  end
  local currentMemberCount = partyDataWrapper:getInvitedMemberCount()
  if partyMemberIndex >= currentMemberCount then
    return
  end
  if self:isOpenRClickMenu() == true then
    self:closeRClickMenu()
  end
  for currentSelectedMemberIndex = #self._memberList_selectInfo, 1, -1 do
    local value = self._memberList_selectInfo[currentSelectedMemberIndex]
    table.remove(self._memberList_selectInfo, currentSelectedMemberIndex)
    if value ~= nil then
      local memberContentKey = toInt64(0, value._dataIndex)
      local list2_content = self._ui._lst_memberList:GetContentByKey(memberContentKey)
      if list2_content ~= nil then
        self:updateMemberListContent(list2_content, memberContentKey)
      end
    end
  end
  for currentSelectedIndex = #self._partyMemberList_selectInfo, 1, -1 do
    local value = self._partyMemberList_selectInfo[currentSelectedIndex]
    if value ~= nil and value._partyDataIndex ~= partyDataIndex then
      table.remove(self._partyMemberList_selectInfo, currentSelectedIndex)
      local partyPoolData = self:getPartyPoolData(value._partyDataIndex)
      if partyPoolData ~= nil then
        local partyMemberContentKey = toInt64(value._partyDataIndex, value._partyMemberIndex)
        local list2_content = partyPoolData._lst_partyMemberList:GetContentByKey(partyMemberContentKey)
        if list2_content ~= nil then
          self:updatePartyMemberListContent(list2_content, partyMemberContentKey)
        end
      end
    end
  end
  local selectMode = self._eSelectMode.COUNT
  local isPressed_Ctrl = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_CONTROL)
  local isPressed_Shift = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT)
  if isPressed_Ctrl == true then
    selectMode = self._eSelectMode.ADD_ONE
  elseif isPressed_Shift == true then
    selectMode = self._eSelectMode.ADD_RANGE
  else
    selectMode = self._eSelectMode.ONLY_ONE
  end
  if self._partyMemberList_selectInfo == nil then
    self._partyMemberList_selectInfo = Array.new()
  end
  local partyMemberUserNo = partyDataWrapper:getInvitedMemberUserNo(partyMemberIndex)
  if selectMode == self._eSelectMode.ONLY_ONE then
    if 0 < self._partyMemberList_selectInfo:length() then
      self:clearSelectInfo()
    end
    self:pushPartyMemberListSelectInfo(partyMemberUserNo, partyDataIndex, partyMemberIndex)
  elseif selectMode == self._eSelectMode.ADD_ONE then
    if self:popMemberListSelectInfo(partyDataIndex, partyMemberIndex) == false then
      self:pushPartyMemberListSelectInfo(partyMemberUserNo, partyDataIndex, partyMemberIndex)
    end
  elseif selectMode == self._eSelectMode.ADD_RANGE then
    if self._partyMemberList_selectInfo:length() == 0 then
      self:pushPartyMemberListSelectInfo(partyMemberUserNo, partyDataIndex, partyMemberIndex)
    else
      local firstMemberIndex
      for cacheIndex = #self._partyMemberList_selectInfo, 1, -1 do
        local value = self._partyMemberList_selectInfo[cacheIndex]
        if value ~= nil then
          if value._isFirst == true then
            firstMemberIndex = value._partyMemberIndex
          else
            table.remove(self._partyMemberList_selectInfo, cacheIndex)
          end
        end
      end
      if partyMemberIndex > firstMemberIndex then
        for beginIndex = firstMemberIndex + 1, partyMemberIndex do
          local rangePartyMemberUserNo = partyDataWrapper:getInvitedMemberUserNo(beginIndex)
          self:pushPartyMemberListSelectInfo(rangePartyMemberUserNo, partyDataIndex, beginIndex)
        end
      else
        if partyMemberIndex < firstMemberIndex then
          for beginIndex = firstMemberIndex - 1, partyMemberIndex, -1 do
            local rangePartyMemberUserNo = partyDataWrapper:getInvitedMemberUserNo(beginIndex)
            self:pushPartyMemberListSelectInfo(rangePartyMemberUserNo, partyDataIndex, beginIndex)
          end
        else
        end
      end
    end
  else
    return
  end
  local partyPoolData = self:getPartyPoolData(partyDataIndex)
  if partyPoolData ~= nil then
    local partyMemberCount = partyDataWrapper:getInvitedMemberCount()
    for index = 0, partyMemberCount - 1 do
      local partyMemberContentKey = toInt64(partyDataIndex, index)
      local list2_content = partyPoolData._lst_partyMemberList:GetContentByKey(partyMemberContentKey)
      if list2_content ~= nil then
        self:updatePartyMemberListContent(list2_content, partyMemberContentKey)
      end
    end
  end
end
function PaGlobal_RoseWarEditParty:pushPartyMemberListSelectInfo(userNo, partyDataIndex, partyMemberIndex)
  if Panel_RoseWar_EditParty == nil then
    return
  end
  if self._partyMemberList_selectInfo == nil then
    self._partyMemberList_selectInfo = Array.new()
  end
  local currentSelectedCount = self._partyMemberList_selectInfo:length()
  local memberListSelectInfo = {
    _userNo = userNo,
    _partyDataIndex = partyDataIndex,
    _partyMemberIndex = partyMemberIndex,
    _isFirst = currentSelectedCount == 0
  }
  self._partyMemberList_selectInfo:push_back(memberListSelectInfo)
end
function PaGlobal_RoseWarEditParty:popPartyMemberListSelectInfo(partyDataIndex, partyMemberIndex)
  if Panel_RoseWar_EditParty == nil then
    return false
  end
  if self._partyMemberList_selectInfo == nil then
    return false
  end
  local isNeedUpdateFirstCachInfo = false
  local isRemoved = false
  for cacheIndex = #self._partyMemberList_selectInfo, 1, -1 do
    local value = self._partyMemberList_selectInfo[cacheIndex]
    if value ~= nil and value._partyDataIndex == partyDataIndex and value._partyMemberIndex == partyMemberIndex then
      table.remove(self._partyMemberList_selectInfo, cacheIndex)
      isNeedUpdateFirstCachInfo = value._isFirst
      isRemoved = true
      break
    end
  end
  if isNeedUpdateFirstCachInfo == true then
    for cacheIndex = 1, #self._partyMemberList_selectInfo do
      local value = self._partyMemberList_selectInfo[cacheIndex]
      if value ~= nil then
        value._isFirst = true
        break
      end
    end
  end
  return isRemoved
end
function PaGlobal_RoseWarEditParty:clearSelectInfo()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  self:clearMemberSelectInfo()
  self:clearPartyMemberSelectInfo()
  self:clearDrag()
end
function PaGlobal_RoseWarEditParty:clearMemberSelectInfo()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  self._memberList_selectInfo = Array.new()
end
function PaGlobal_RoseWarEditParty:clearPartyMemberSelectInfo()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  self._partyMemberList_selectInfo = Array.new()
end
function PaGlobal_RoseWarEditParty:makeRClickMenuPool(isExepand)
  if Panel_RoseWar_EditParty == nil then
    return
  end
  if isExepand == false and self._rClickMenuButtonPool ~= nil then
    UI.ASSERT_NAME(false, "\236\157\180\235\175\184 \236\131\157\236\132\177\235\144\156 \236\158\144\236\155\144\236\157\180\235\139\164!", "\236\157\180\236\163\188")
    return
  end
  if isExepand == false then
    self._rClickMenuButtonPool = {}
  end
  local button_Template = UI.getChildControl(self._ui._stc_rclick_menu, "Button_RClick_Template")
  local totalIndex = 0
  local beginIndex = 0
  local count = self._rClickMenuButtonPoolCount - 1
  if isExepand == true then
    totalIndex = self._rClickMenuButtonPoolCount
    beginIndex = self._rClickMenuButtonPoolCount
    self._rClickMenuButtonPoolCount = self._rClickMenuButtonPoolCount + 1
    count = self._rClickMenuButtonPoolCount - 1
  end
  for index = beginIndex, count do
    local controlId = "Button_RClick_" .. tostring(totalIndex)
    local newControl = UI.cloneControl(button_Template, self._ui._stc_rclick_menu, controlId)
    if newControl == nil then
      UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \235\182\128\235\140\128 \237\142\184\236\132\177 UI \236\154\176\237\129\180\235\166\173 \235\169\148\235\137\180 \235\178\132\237\138\188 \236\131\157\236\132\177 \236\139\164\237\140\168. \236\136\152\236\160\149\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    newControl:SetShow(false)
    newControl:SetIgnore(false)
    newControl:SetSpanSize(newControl:GetSpanSize().x, (newControl:GetSizeY() + 10) * (index + 1))
    newControl:ComputePos()
    local rClickButtonData = {
      _control = newControl,
      _buttonType = nil,
      _partyDataKey = nil,
      _userNo = nil,
      _isSet = false
    }
    self._rClickMenuButtonPool[index] = rClickButtonData
    totalIndex = totalIndex + 1
  end
end
function PaGlobal_RoseWarEditParty:activateRClickMenuButton(buttonType, partyDataKey, userNo)
  if Panel_RoseWar_EditParty == nil or buttonType == nil or userNo == nil then
    return
  end
  if self._rClickMenuButtonPool == nil then
    return
  end
  if buttonType ~= self._eRClickButtonType.JOIN_PARTY and buttonType ~= self._eRClickButtonType.SET_PARTY_LEADER and buttonType ~= self._eRClickButtonType.SET_SUBCOMMANDER and buttonType ~= self._eRClickButtonType.UNSET_SUBCOMMANDER then
    return
  end
  local isSuccess = false
  for buttonIndex = 0, self._rClickMenuButtonPoolCount - 1 do
    local rClickButtonData = self._rClickMenuButtonPool[buttonIndex]
    if rClickButtonData ~= nil and rClickButtonData._isSet == false then
      if buttonType == self._eRClickButtonType.JOIN_PARTY then
        local partyPoolData = self:getPartyPoolDataByKey(partyDataKey)
        if partyPoolData == nil then
          return
        end
        local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(partyPoolData._partyDataIndex)
        if partyDataWrapper == nil then
          return
        end
        local partyMemo = partyDataWrapper:getPartyMemo()
        if partyMemo == nil or partyMemo == "" then
          partyMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_PARTY_NAME", "num", partyDataWrapper:getPartyIndex() + 1)
        end
        rClickButtonData._control:SetText(partyMemo)
      elseif buttonType == self._eRClickButtonType.SET_PARTY_LEADER then
        rClickButtonData._control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_PARTYLEADER_APPLY"))
      elseif buttonType == self._eRClickButtonType.SET_SUBCOMMANDER then
        rClickButtonData._control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_SUBCOMMANDER_APPLY"))
      elseif buttonType == self._eRClickButtonType.UNSET_SUBCOMMANDER then
        rClickButtonData._control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_SUBCOMMANDER_DISAPPLY"))
      end
      rClickButtonData._control:SetShow(true)
      rClickButtonData._control:addInputEvent("Mouse_LUp", "HandleEventClicked_RoseWarEditParty_OnClickedRClickMenuButton(" .. tostring(buttonIndex) .. ")")
      rClickButtonData._buttonType = buttonType
      rClickButtonData._partyDataKey = partyDataKey
      rClickButtonData._userNo = userNo
      rClickButtonData._isSet = true
      isSuccess = true
      break
    end
  end
  if isSuccess == false then
    self:makeRClickMenuPool(true)
    self:activateRClickMenuButton(buttonType, partyDataKey, userNo)
  end
end
function PaGlobal_RoseWarEditParty:openRClickMenuByMember(s64_memberListKey)
  if Panel_RoseWar_EditParty == nil or s64_memberListKey == nil then
    return
  end
  if self:isOpenRClickMenu() == true then
    self:closeRClickMenu()
  end
  local memberIndex = Int64toInt32(s64_memberListKey)
  local roseWarMemberDataWrapper = ToClient_GetRoseWarMemberDataWrapper(memberIndex)
  if roseWarMemberDataWrapper == nil then
    return
  end
  local memberGradeType = roseWarMemberDataWrapper:getGradeType()
  local memberUserNo = roseWarMemberDataWrapper:getUserNo()
  local memberPartyDataWrapper = ToClient_GetRoseWarPartyDataWrapperByUserNo(memberUserNo)
  if ToClient_GetRoseWarState() == __eRoseWar_PreStart then
    if memberGradeType == __eRoseWarPlayerGradeType_GuildPartyLeader or memberGradeType == __eRoseWarPlayerGradeType_GuildMember then
      self:activateRClickMenuButton(self._eRClickButtonType.SET_SUBCOMMANDER, nil, memberUserNo)
    end
    if memberGradeType == __eRoseWarPlayerGradeType_SubCommander then
      self:activateRClickMenuButton(self._eRClickButtonType.UNSET_SUBCOMMANDER, nil, memberUserNo)
    end
  end
  local partyCount = ToClient_GetRoseWarPartyDataCount()
  for partyIndex = 0, partyCount - 1 do
    local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(partyIndex)
    if partyDataWrapper ~= nil then
      local isSkip = false
      if memberPartyDataWrapper ~= nil and memberPartyDataWrapper:getPartyDataKey() == partyDataWrapper:getPartyDataKey() then
        isSkip = true
      end
      if isSkip == false then
        local partyType = partyDataWrapper:getPartyType()
        if partyType == __eRoseWarPartyType_Guild then
          if memberGradeType == __eRoseWarPlayerGradeType_Commander or memberGradeType == __eRoseWarPlayerGradeType_SubCommander or memberGradeType == __eRoseWarPlayerGradeType_GuildPartyLeader or memberGradeType == __eRoseWarPlayerGradeType_GuildMember then
            self:activateRClickMenuButton(self._eRClickButtonType.JOIN_PARTY, partyDataWrapper:getPartyDataKey(), memberUserNo)
          end
        elseif partyType == __eRoseWarPartyType_Mercenary and (memberGradeType == __eRoseWarPlayerGradeType_MercenaryPartyLeader or memberGradeType == __eRoseWarPlayerGradeType_Mercenary) then
          self:activateRClickMenuButton(self._eRClickButtonType.JOIN_PARTY, partyDataWrapper:getPartyDataKey(), memberUserNo)
        end
      end
    else
    end
  end
  self:openRClickMenu()
end
function PaGlobal_RoseWarEditParty:openRClickMenuByPartyMember(partyDataIndex, partyMemberIndex)
  if Panel_RoseWar_EditParty == nil or partyDataIndex == nil or partyMemberIndex == nil then
    return
  end
  if self:isOpenRClickMenu() == true then
    self:closeRClickMenu()
  end
  local clickedPartyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(partyDataIndex)
  if clickedPartyDataWrapper == nil then
    return
  end
  local partyLeaderUserNo_s64 = clickedPartyDataWrapper:getPartyLeaderUserNo()
  local partyMemberUserNo_s64 = clickedPartyDataWrapper:getInvitedMemberUserNo(partyMemberIndex)
  local roseWarMemberDataWrapper = ToClient_GetRoseWarMemberDataWrapperByUserNo(partyMemberUserNo_s64)
  if roseWarMemberDataWrapper == nil then
    return
  end
  local clickedPartyDataKey = clickedPartyDataWrapper:getPartyDataKey()
  local memberGradeType = roseWarMemberDataWrapper:getGradeType()
  if partyMemberUserNo_s64 ~= partyLeaderUserNo_s64 then
    self:activateRClickMenuButton(self._eRClickButtonType.SET_PARTY_LEADER, clickedPartyDataKey, partyMemberUserNo_s64)
  end
  local partyCount = ToClient_GetRoseWarPartyDataCount()
  for partyIndex = 0, partyCount - 1 do
    local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(partyIndex)
    if partyDataWrapper ~= nil then
      local isSkip = false
      if clickedPartyDataKey == partyDataWrapper:getPartyDataKey() then
        isSkip = true
      end
      if isSkip == false then
        local partyType = partyDataWrapper:getPartyType()
        if partyType == __eRoseWarPartyType_Guild then
          if memberGradeType == __eRoseWarPlayerGradeType_Commander or memberGradeType == __eRoseWarPlayerGradeType_SubCommander or memberGradeType == __eRoseWarPlayerGradeType_GuildPartyLeader or memberGradeType == __eRoseWarPlayerGradeType_GuildMember then
            self:activateRClickMenuButton(self._eRClickButtonType.JOIN_PARTY, partyDataWrapper:getPartyDataKey(), partyMemberUserNo_s64)
          end
        elseif partyType == __eRoseWarPartyType_Mercenary and (memberGradeType == __eRoseWarPlayerGradeType_MercenaryPartyLeader or memberGradeType == __eRoseWarPlayerGradeType_Mercenary) then
          self:activateRClickMenuButton(self._eRClickButtonType.JOIN_PARTY, partyDataWrapper:getPartyDataKey(), partyMemberUserNo_s64)
        end
      end
    else
    end
  end
  self:openRClickMenu()
end
function PaGlobal_RoseWarEditParty:openRClickMenu()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  local showButtonCount = 0
  local lastSpanY = 0
  for index = 0, self._rClickMenuButtonPoolCount - 1 do
    local rClickButtonData = self._rClickMenuButtonPool[index]
    if rClickButtonData ~= nil and rClickButtonData._isSet == true then
      if lastSpanY < rClickButtonData._control:GetSpanSize().y then
        lastSpanY = rClickButtonData._control:GetSpanSize().y
      end
      showButtonCount = showButtonCount + 1
    end
  end
  if showButtonCount == 0 then
    return
  end
  local button_Template = UI.getChildControl(self._ui._stc_rclick_menu, "Button_RClick_Template")
  self._ui._stc_rclick_menu:SetSize(self._ui._stc_rclick_menu:GetSizeX(), lastSpanY + button_Template:GetSizeY() + 10)
  local sizeX = self._ui._stc_rclick_menu:GetSizeX()
  local sizeY = self._ui._stc_rclick_menu:GetSizeY()
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  local panelPosX = getMousePosX()
  local panelPosY = getMousePosY()
  local term = 10
  if panelPosX < term then
    panelPosX = term
  elseif screenX < panelPosX + sizeX + term then
    panelPosX = screenX - sizeX - term
  end
  if panelPosY < term then
    panelPosY = term
  elseif screenY < panelPosY + sizeY + term then
    panelPosY = screenY - sizeY - term
  end
  self._ui._stc_rclick_menu:SetPosXY(panelPosX, panelPosY)
  self._ui._stc_rclick_menu:SetShow(true)
end
function PaGlobal_RoseWarEditParty:closeRClickMenu()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  for buttonIndex = 0, self._rClickMenuButtonPoolCount - 1 do
    local rClickButtonData = self._rClickMenuButtonPool[buttonIndex]
    if rClickButtonData ~= nil and rClickButtonData._isSet == true then
      rClickButtonData._control:SetShow(false)
      rClickButtonData._control:removeInputEvent("Mouse_LUp")
      rClickButtonData._buttonType = nil
      rClickButtonData._partyDataKey = nil
      rClickButtonData._userNo = nil
      rClickButtonData._isSet = false
    end
  end
  self._ui._stc_rclick_menu:SetShow(false)
end
function PaGlobal_RoseWarEditParty:isOpenRClickMenu()
  if Panel_RoseWar_EditParty == nil then
    return false
  end
  return self._ui._stc_rclick_menu:GetShow()
end
