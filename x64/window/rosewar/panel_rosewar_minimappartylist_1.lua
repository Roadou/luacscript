function PaGlobal_RoseWarMiniMapPartyList:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_alphaSlider = UI.getChildControl(self._ui._stc_titleArea, "Slider_Alpha")
  self._ui._btn_alphaSlider = UI.getChildControl(self._ui._stc_alphaSlider, "Slider_Alpha_Button")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleArea, "Button_Close")
  self._ui._frm_content_original = UI.getChildControl(self._ui._frm_original, "Frame_1_Content")
  self._ui._stc_original_guild_line = UI.getChildControl(self._ui._frm_content_original, "StaticText_GuildParty")
  self._ui._stc_original_mercenary_line = UI.getChildControl(self._ui._frm_content_original, "StaticText_MercenaryParty")
  self._ui._frm_content_simple = UI.getChildControl(self._ui._frm_simple, "Frame_1_Content")
  self._ui._stc_simple_guild_line = UI.getChildControl(self._ui._frm_content_simple, "StaticText_GuildParty")
  self._ui._stc_simple_mercenary_line = UI.getChildControl(self._ui._frm_content_simple, "StaticText_MercenaryParty")
  self._ui._btn_rClickMenu_forceComplete = UI.getChildControl(self._ui._stc_rClickMenu, "Button_ForceCompleteMission")
  self._ui._stc_alphaSlider:SetControlPos(self._lastAlphaSliderControlPos)
  self._ui._chk_simpleMode:SetCheck(false)
  self:createOriginalFrameControlPool(20)
  self:createSimpleFrameControlPool(20)
  self:validate()
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_RoseWarMiniMapPartyList:createOriginalFrameControlPool(createCount)
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  if self._originalFrameControlPool == nil then
    self._originalFrameControlPool = {}
  end
  local beginIndex = self._originalPoolCount
  local endIndex = self._originalPoolCount + createCount
  local totalIndex = beginIndex
  local templateControl = UI.getChildControl(self._ui._frm_content_original, "Static_PartyInfo_Template")
  for index = beginIndex, endIndex - 1 do
    local controlId = "Static_OriginalInfo_" .. tostring(totalIndex)
    local newControl = UI.cloneControl(templateControl, self._ui._frm_content_original, controlId)
    if newControl == nil then
      UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \235\182\128\235\140\128 \235\170\169\235\161\157 UI \236\152\164\235\166\172\236\167\128\235\132\144 \237\146\128 \236\180\136\234\184\176\237\153\148 \236\139\164\237\140\168! \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\176\148\235\158\141\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    local partyInfoBG = UI.getChildControl(newControl, "Static_PartyInfoBG")
    local partyName = UI.getChildControl(partyInfoBG, "StaticText_PartyName")
    local missionIcon = UI.getChildControl(partyInfoBG, "Static_MissionIcon")
    local partyMemberCount = UI.getChildControl(partyInfoBG, "StaticText_PartyMemCount")
    newControl:SetShow(false)
    newControl:SetIgnore(false)
    local frameControl = {
      _bg = partyInfoBG,
      _control = newControl,
      _partyName = partyName,
      _missionIcon = missionIcon,
      _partyMemberCount = partyMemberCount,
      _partyDataIndex = nil,
      _isSet = false
    }
    self._originalFrameControlPool[index] = frameControl
    self._originalPoolCount = self._originalPoolCount + 1
    totalIndex = totalIndex + 1
  end
end
function PaGlobal_RoseWarMiniMapPartyList:createSimpleFrameControlPool(createCount)
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  if self._simpleFrameControlPool == nil then
    self._simpleFrameControlPool = {}
  end
  local beginIndex = self._simplePoolCount
  local endIndex = self._simplePoolCount + createCount
  local totalIndex = beginIndex
  local templateControl = UI.getChildControl(self._ui._frm_content_simple, "Static_PartyInfo_Template")
  for index = beginIndex, endIndex - 1 do
    local controlId = "Static_SimpleInfo_" .. tostring(totalIndex)
    local newControl = UI.cloneControl(templateControl, self._ui._frm_content_simple, controlId)
    if newControl == nil then
      UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \235\182\128\235\140\128 \235\170\169\235\161\157 UI \234\176\132\236\134\140\237\153\148 \237\146\128 \236\180\136\234\184\176\237\153\148 \236\139\164\237\140\168! \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\176\148\235\158\141\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    local partyInfoBG = UI.getChildControl(newControl, "Static_PartyInfoBG")
    local classIcon = UI.getChildControl(partyInfoBG, "Static_ClassIcon")
    local missionIcon = UI.getChildControl(partyInfoBG, "Static_MissionIcon")
    local partyMemberCount = UI.getChildControl(partyInfoBG, "StaticText_PartyMemCount")
    newControl:SetShow(false)
    newControl:SetIgnore(false)
    local frameControl = {
      _bg = partyInfoBG,
      _control = newControl,
      _classIcon = classIcon,
      _missionIcon = missionIcon,
      _partyMemberCount = partyMemberCount,
      _partyDataIndex = nil,
      _isSet = false
    }
    self._simpleFrameControlPool[index] = frameControl
    self._simplePoolCount = self._simplePoolCount + 1
    totalIndex = totalIndex + 1
  end
end
function PaGlobal_RoseWarMiniMapPartyList:validate()
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  self._ui._stc_titleArea:isValidate()
  self._ui._stc_alphaSlider:isValidate()
  self._ui._btn_alphaSlider:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._chk_simpleMode:isValidate()
  self._ui._frm_original:isValidate()
  self._ui._frm_content_original:isValidate()
  self._ui._stc_original_guild_line:isValidate()
  self._ui._stc_original_mercenary_line:isValidate()
  self._ui._frm_simple:isValidate()
  self._ui._frm_content_simple:isValidate()
  self._ui._stc_simple_guild_line:isValidate()
  self._ui._stc_simple_mercenary_line:isValidate()
  self._ui._stc_rClickMenu:isValidate()
  self._ui._btn_rClickMenu_forceComplete:isValidate()
end
function PaGlobal_RoseWarMiniMapPartyList:registEventHandler()
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  self._ui._chk_simpleMode:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarMiniMapPartyList_ToggleSimpleMode()")
  self._ui._stc_alphaSlider:addInputEvent("Mouse_LPress", "HandleMouseLPress_RoseWarMiniMapPartyList_AlphaSlider()")
  self._ui._btn_alphaSlider:addInputEvent("Mouse_LPress", "HandleMouseLPress_RoseWarMiniMapPartyList_AlphaSlider()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_RoseWarMiniMapPartyList_Close()")
  registerEvent("FromClient_ReceivedNewRoseWarMissionToCommander", "FromClient_RoseWarMiniMapPartyList_RefreshPartyMissionIcon")
  registerEvent("FromClient_CompleteRoseWarMissionToCommander", "FromClient_RoseWarMiniMapPartyList_RefreshPartyMissionIcon")
  registerEvent("FromClient_FailedRoseWarMissionToCommander", "FromClient_RoseWarMiniMapPartyList_RefreshPartyMissionIcon")
end
function PaGlobal_RoseWarMiniMapPartyList:prepareOpen()
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  self:refreshPartyList()
  self:open()
end
function PaGlobal_RoseWarMiniMapPartyList:open()
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  Panel_RoseWar_MiniMapPartyList:SetShow(true)
end
function PaGlobal_RoseWarMiniMapPartyList:prepareClose()
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  if self:isOpenRClickMenu() == true then
    self:closeRClickMenu()
  end
  self:close()
end
function PaGlobal_RoseWarMiniMapPartyList:close()
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  Panel_RoseWar_MiniMapPartyList:SetShow(false)
end
function PaGlobal_RoseWarMiniMapPartyList:refreshPartyList()
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  local isSimpleMode = self._ui._chk_simpleMode:IsCheck()
  self._ui._frm_original:SetShow(not isSimpleMode)
  self._ui._frm_simple:SetShow(isSimpleMode)
  if isSimpleMode == true then
    self:updateSimpleFrame()
  else
    self:updateOriginalFrame()
  end
end
function PaGlobal_RoseWarMiniMapPartyList:refreshPartyMissionIcon(partyDataKey)
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  local isSimpleMode = self._ui._chk_simpleMode:IsCheck()
  if isSimpleMode == true then
    for index = 0, self._simplePoolCount - 1 do
      local frameControl = self._simpleFrameControlPool[index]
      if frameControl ~= nil and frameControl._isSet == true then
        local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(frameControl._partyDataIndex)
        if partyDataWrapper ~= nil and partyDataWrapper:getPartyDataKey() == partyDataKey then
          local isProgressMission = partyDataWrapper:isProgressMission()
          if isProgressMission == true then
            local progressMissionDataWrapper = ToClient_GetRoseWarMissionDataWrapper(partyDataWrapper:getProgressMissionKey())
            if progressMissionDataWrapper ~= nil then
              local typeIconTextureId
              local progressMissionType = progressMissionDataWrapper:getMissionType()
              if progressMissionType == __eRoseWarMissionType_FierceAttack or progressMissionType == __eRoseWarMissionType_CastleAttack or progressMissionType == __eRoseWarMissionType_GimmikAttack then
                typeIconTextureId = "Combine_Etc_RoseWar_Command_Wight_Mission_Red"
              elseif progressMissionType == __eRoseWarMissionType_FierceDefence or progressMissionType == __eRoseWarMissionType_CastleDefence then
                typeIconTextureId = "Combine_Etc_RoseWar_Command_Wight_Mission_Blue"
              elseif progressMissionType == __eRoseWarMissionType_Kill then
                typeIconTextureId = "Combine_Etc_RoseWar_Command_Wight_Mission_Kill"
              else
                UI.ASSERT_NAME(false, "\236\158\132\235\172\180 \237\131\128\236\158\133\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \234\188\173 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
              end
              if typeIconTextureId ~= nil then
                frameControl._missionIcon:ChangeTextureInfoTextureIDAsync(typeIconTextureId)
                frameControl._missionIcon:setRenderTexture(frameControl._missionIcon:getBaseTexture())
                frameControl._missionIcon:SetShow(true)
              else
                frameControl._missionIcon:SetShow(false)
              end
            else
              frameControl._missionIcon:SetShow(false)
            end
          else
            frameControl._missionIcon:SetShow(false)
          end
          if frameControl._missionIcon:GetShow() == true then
            frameControl._bg:addInputEvent("Mouse_On", "HandleEventOnOut_MiniMapPartyList_ShowRMenuTooltip(true, true, " .. tostring(partyDataKey) .. ")")
            frameControl._bg:addInputEvent("Mouse_Out", "HandleEventOnOut_MiniMapPartyList_ShowRMenuTooltip(false, true, " .. tostring(partyDataKey) .. ")")
            break
          end
          frameControl._bg:removeInputEvent("Mouse_On")
          frameControl._bg:removeInputEvent("Mouse_Out")
          break
        end
      end
    end
  else
    for index = 0, self._originalPoolCount - 1 do
      local frameControl = self._originalFrameControlPool[index]
      if frameControl ~= nil and frameControl._isSet == true then
        local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(frameControl._partyDataIndex)
        if partyDataWrapper ~= nil and partyDataWrapper:getPartyDataKey() == partyDataKey then
          local isProgressMission = partyDataWrapper:isProgressMission()
          if isProgressMission == true then
            local progressMissionDataWrapper = ToClient_GetRoseWarMissionDataWrapper(partyDataWrapper:getProgressMissionKey())
            if progressMissionDataWrapper ~= nil then
              local typeIconTextureId
              local progressMissionType = progressMissionDataWrapper:getMissionType()
              if progressMissionType == __eRoseWarMissionType_FierceAttack or progressMissionType == __eRoseWarMissionType_CastleAttack or progressMissionType == __eRoseWarMissionType_GimmikAttack then
                typeIconTextureId = "Combine_Etc_RoseWar_Command_Wight_Mission_Red"
              elseif progressMissionType == __eRoseWarMissionType_FierceDefence or progressMissionType == __eRoseWarMissionType_CastleDefence then
                typeIconTextureId = "Combine_Etc_RoseWar_Command_Wight_Mission_Blue"
              elseif progressMissionType == __eRoseWarMissionType_Kill then
                typeIconTextureId = "Combine_Etc_RoseWar_Command_Wight_Mission_Kill"
              else
                UI.ASSERT_NAME(false, "\236\158\132\235\172\180 \237\131\128\236\158\133\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \234\188\173 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
              end
              if typeIconTextureId ~= nil then
                frameControl._missionIcon:ChangeTextureInfoTextureIDAsync(typeIconTextureId)
                frameControl._missionIcon:setRenderTexture(frameControl._missionIcon:getBaseTexture())
                frameControl._missionIcon:SetShow(true)
              else
                frameControl._missionIcon:SetShow(false)
              end
            else
              frameControl._missionIcon:SetShow(false)
            end
          else
            frameControl._missionIcon:SetShow(false)
          end
          if frameControl._missionIcon:GetShow() == true then
            frameControl._bg:addInputEvent("Mouse_On", "HandleEventOnOut_MiniMapPartyList_ShowRMenuTooltip(true, false, " .. tostring(partyDataKey) .. ")")
            frameControl._bg:addInputEvent("Mouse_Out", "HandleEventOnOut_MiniMapPartyList_ShowRMenuTooltip(false, false, " .. tostring(partyDataKey) .. ")")
            break
          end
          frameControl._bg:removeInputEvent("Mouse_On")
          frameControl._bg:removeInputEvent("Mouse_Out")
          break
        end
      end
    end
  end
end
function PaGlobal_RoseWarMiniMapPartyList:updateSimpleFrame()
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  self:deactivateAllSimpleFrameControl()
  local partyCount = ToClient_GetRoseWarPartyDataCount()
  for index = 0, partyCount - 1 do
    local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(index)
    if partyDataWrapper ~= nil and partyDataWrapper:isMadeParty() == true then
      self:activateSimpleFrameControl(index)
    end
  end
  self:updateSimpleFrameControlPosition()
end
function PaGlobal_RoseWarMiniMapPartyList:updateOriginalFrame()
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  self:deactivateAllOriginalFrameControl()
  local partyCount = ToClient_GetRoseWarPartyDataCount()
  for index = 0, partyCount - 1 do
    local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(index)
    if partyDataWrapper ~= nil and partyDataWrapper:isMadeParty() == true then
      self:activateOriginalFrameControl(index)
    end
  end
  self:updateOriginalFrameControlPosition()
end
function PaGlobal_RoseWarMiniMapPartyList:deactivateAllSimpleFrameControl()
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  if self._simpleFrameControlPool == nil then
    return
  end
  for index = 0, self._simplePoolCount - 1 do
    local frameControl = self._simpleFrameControlPool[index]
    if frameControl ~= nil and frameControl._isSet == true then
      frameControl._bg:removeInputEvent("Mouse_LUp")
      frameControl._control:SetShow(false)
      frameControl._partyDataIndex = nil
      frameControl._isSet = false
    end
  end
end
function PaGlobal_RoseWarMiniMapPartyList:activateSimpleFrameControl(partyDataIndex)
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  if self._simpleFrameControlPool == nil then
    return
  end
  local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(partyDataIndex)
  if partyDataWrapper == nil then
    return
  end
  local isSuccess = false
  for index = 0, self._simplePoolCount - 1 do
    local frameControl = self._simpleFrameControlPool[index]
    if frameControl ~= nil and frameControl._isSet == false then
      local leaderUserNo = partyDataWrapper:getPartyLeaderUserNo()
      local memberDataWrapper = ToClient_GetRoseWarMemberDataWrapperByUserNo(leaderUserNo)
      if memberDataWrapper == nil then
        frameControl._classIcon:SetShow(false)
      elseif PaGlobalFunc_Util_SetFriendClassTypeIcon == nil then
        frameControl._classIcon:SetShow(false)
      else
        PaGlobalFunc_Util_SetFriendClassTypeIcon(frameControl._classIcon, memberDataWrapper:getClassTypeRaw())
        frameControl._classIcon:SetShow(true)
      end
      local isProgressMission = partyDataWrapper:isProgressMission()
      if isProgressMission == true then
        local progressMissionDataWrapper = ToClient_GetRoseWarMissionDataWrapper(partyDataWrapper:getProgressMissionKey())
        if progressMissionDataWrapper ~= nil then
          local typeIconTextureId
          local progressMissionType = progressMissionDataWrapper:getMissionType()
          if progressMissionType == __eRoseWarMissionType_FierceAttack or progressMissionType == __eRoseWarMissionType_CastleAttack or progressMissionType == __eRoseWarMissionType_GimmikAttack then
            typeIconTextureId = "Combine_Etc_RoseWar_Command_Wight_Mission_Red"
          elseif progressMissionType == __eRoseWarMissionType_FierceDefence or progressMissionType == __eRoseWarMissionType_CastleDefence then
            typeIconTextureId = "Combine_Etc_RoseWar_Command_Wight_Mission_Blue"
          elseif progressMissionType == __eRoseWarMissionType_Kill then
            typeIconTextureId = "Combine_Etc_RoseWar_Command_Wight_Mission_Kill"
          else
            UI.ASSERT_NAME(false, "\236\158\132\235\172\180 \237\131\128\236\158\133\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \234\188\173 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
          end
          if typeIconTextureId ~= nil then
            frameControl._missionIcon:ChangeTextureInfoTextureIDAsync(typeIconTextureId)
            frameControl._missionIcon:setRenderTexture(frameControl._missionIcon:getBaseTexture())
            frameControl._missionIcon:SetShow(true)
          else
            frameControl._missionIcon:SetShow(false)
          end
        else
          frameControl._missionIcon:SetShow(false)
        end
      else
        frameControl._missionIcon:SetShow(false)
      end
      frameControl._partyMemberCount:SetText(partyDataWrapper:getInvitedMemberCount())
      frameControl._bg:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarPartyList_SelectParty(" .. tostring(partyDataWrapper:getPartyDataKey()) .. ")")
      frameControl._bg:addInputEvent("Mouse_RUp", "HandleEventRUp_RoseWarPartyList_ToggleRMenu(" .. tostring(partyDataWrapper:getPartyDataKey()) .. ")")
      if frameControl._missionIcon:GetShow() == true then
        frameControl._bg:addInputEvent("Mouse_On", "HandleEventOnOut_MiniMapPartyList_ShowRMenuTooltip(true, true, " .. tostring(partyDataWrapper:getPartyDataKey()) .. ")")
        frameControl._bg:addInputEvent("Mouse_Out", "HandleEventOnOut_MiniMapPartyList_ShowRMenuTooltip(false, true, " .. tostring(partyDataWrapper:getPartyDataKey()) .. ")")
      else
        frameControl._bg:removeInputEvent("Mouse_On")
        frameControl._bg:removeInputEvent("Mouse_Out")
      end
      frameControl._control:SetShow(true)
      frameControl._partyDataIndex = partyDataIndex
      frameControl._isSet = true
      isSuccess = true
      break
    end
  end
  if isSuccess == false then
    self:createSimpleFrameControlPool(1)
    self:activateSimpleFrameControl(partyDataIndex)
  end
end
function PaGlobal_RoseWarMiniMapPartyList:updateSimpleFrameControlPosition()
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  if self._simpleFrameControlPool == nil then
    return
  end
  local templateControl = UI.getChildControl(self._ui._frm_content_simple, "Static_PartyInfo_Template")
  if templateControl == nil then
    return
  end
  local spanX = 0
  local spanY = 0
  local rowIndex = 0
  local colIndex = 0
  local templateSizeX = templateControl:GetSizeX()
  local templateSizeY = templateControl:GetSizeY()
  local rowMaxCount = 5
  self._ui._stc_simple_guild_line:SetSpanSize(10, 5)
  self._ui._stc_simple_guild_line:ComputePos()
  local guildLineSpanY = self._ui._stc_simple_guild_line:GetSpanSize().y
  local guildLineSizeY = self._ui._stc_simple_guild_line:GetSizeY()
  for index = 0, self._simplePoolCount - 1 do
    local frameControl = self._simpleFrameControlPool[index]
    if frameControl ~= nil and frameControl._isSet == true then
      local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(frameControl._partyDataIndex)
      if partyDataWrapper ~= nil then
        local partyType = partyDataWrapper:getPartyType()
        if partyType == __eRoseWarPartyType_Guild then
          spanX = 5 + frameControl._control:GetSizeX() * rowIndex
          spanY = guildLineSpanY + guildLineSizeY + frameControl._control:GetSizeY() * colIndex
          rowIndex = rowIndex + 1
          frameControl._control:SetSpanSize(spanX, spanY)
          frameControl._control:ComputePos()
          if rowMaxCount <= rowIndex then
            rowIndex = 0
            colIndex = colIndex + 1
          end
        end
      end
    end
  end
  self._ui._stc_simple_mercenary_line:SetSpanSize(10, spanY + templateSizeY)
  self._ui._stc_simple_mercenary_line:ComputePos()
  local mercenaryLineSpanY = self._ui._stc_simple_mercenary_line:GetSpanSize().y
  local mercenaryLineSizeY = self._ui._stc_simple_mercenary_line:GetSizeY()
  rowIndex = 0
  colIndex = 0
  for index = 0, self._simplePoolCount - 1 do
    local frameControl = self._simpleFrameControlPool[index]
    if frameControl ~= nil and frameControl._isSet == true then
      local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(frameControl._partyDataIndex)
      if partyDataWrapper ~= nil then
        local partyType = partyDataWrapper:getPartyType()
        if partyType == __eRoseWarPartyType_Mercenary then
          spanX = 5 + frameControl._control:GetSizeX() * rowIndex
          spanY = mercenaryLineSpanY + mercenaryLineSizeY + frameControl._control:GetSizeY() * colIndex
          rowIndex = rowIndex + 1
          frameControl._control:SetSpanSize(spanX, spanY)
          frameControl._control:ComputePos()
          if rowMaxCount <= rowIndex then
            rowIndex = 0
            colIndex = colIndex + 1
          end
        end
      end
    end
  end
  self._ui._frm_content_simple:SetSize(rowMaxCount * templateSizeX + 5, spanY + templateSizeY)
  self._ui._frm_simple:SetSize(self._ui._frm_content_simple:GetSizeX(), self._ui._frm_content_simple:GetSizeY())
  self._ui._stc_titleArea:SetSize(self._ui._frm_simple:GetSizeX(), self._ui._stc_titleArea:GetSizeY())
  Panel_RoseWar_MiniMapPartyList:SetSize(self._ui._frm_simple:GetSizeX(), self._ui._frm_simple:GetSpanSize().y + self._ui._frm_simple:GetSizeY())
  Panel_RoseWar_MiniMapPartyList:ComputePosAllChild()
  self:refreshAlphaSlider()
  self._ui._frm_simple:UpdateContentPos()
  self._ui._frm_simple:GetVScroll():SetShow(false)
  self:ComputePanelPosition()
end
function PaGlobal_RoseWarMiniMapPartyList:deactivateAllOriginalFrameControl()
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  if self._originalFrameControlPool == nil then
    return
  end
  for index = 0, self._originalPoolCount - 1 do
    local frameControl = self._originalFrameControlPool[index]
    if frameControl ~= nil and frameControl._isSet == true then
      frameControl._bg:removeInputEvent("Mouse_LUp")
      frameControl._control:SetShow(false)
      frameControl._partyDataIndex = nil
      frameControl._isSet = false
    end
  end
end
function PaGlobal_RoseWarMiniMapPartyList:activateOriginalFrameControl(partyDataIndex)
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  if self._originalFrameControlPool == nil then
    return
  end
  local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(partyDataIndex)
  if partyDataWrapper == nil then
    return
  end
  local isSuccess = false
  for index = 0, self._originalPoolCount - 1 do
    local frameControl = self._originalFrameControlPool[index]
    if frameControl ~= nil and frameControl._isSet == false then
      local isProgressMission = partyDataWrapper:isProgressMission()
      if isProgressMission == true then
        local progressMissionDataWrapper = ToClient_GetRoseWarMissionDataWrapper(partyDataWrapper:getProgressMissionKey())
        if progressMissionDataWrapper ~= nil then
          local typeIconTextureId
          local progressMissionType = progressMissionDataWrapper:getMissionType()
          if progressMissionType == __eRoseWarMissionType_FierceAttack or progressMissionType == __eRoseWarMissionType_CastleAttack or progressMissionType == __eRoseWarMissionType_GimmikAttack then
            typeIconTextureId = "Combine_Etc_RoseWar_Command_Wight_Mission_Red"
          elseif progressMissionType == __eRoseWarMissionType_FierceDefence or progressMissionType == __eRoseWarMissionType_CastleDefence then
            typeIconTextureId = "Combine_Etc_RoseWar_Command_Wight_Mission_Blue"
          elseif progressMissionType == __eRoseWarMissionType_Kill then
            typeIconTextureId = "Combine_Etc_RoseWar_Command_Wight_Mission_Kill"
          else
            UI.ASSERT_NAME(false, "\236\158\132\235\172\180 \237\131\128\236\158\133\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \234\188\173 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
          end
          if typeIconTextureId ~= nil then
            frameControl._missionIcon:ChangeTextureInfoTextureIDAsync(typeIconTextureId)
            frameControl._missionIcon:setRenderTexture(frameControl._missionIcon:getBaseTexture())
            frameControl._missionIcon:SetShow(true)
          else
            frameControl._missionIcon:SetShow(false)
          end
        else
          frameControl._missionIcon:SetShow(false)
        end
      else
        frameControl._missionIcon:SetShow(false)
      end
      local partyMemo = partyDataWrapper:getPartyMemo()
      if partyMemo == nil or partyMemo == "" then
        partyMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_PARTY_NAME", "num", partyDataWrapper:getPartyIndex() + 1)
      end
      frameControl._partyMemberCount:SetText(partyDataWrapper:getInvitedMemberCount())
      frameControl._partyName:SetText(partyMemo)
      frameControl._bg:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarPartyList_SelectParty(" .. tostring(partyDataWrapper:getPartyDataKey()) .. ")")
      frameControl._bg:addInputEvent("Mouse_RUp", "HandleEventRUp_RoseWarPartyList_ToggleRMenu(" .. tostring(partyDataWrapper:getPartyDataKey()) .. ")")
      if frameControl._missionIcon:GetShow() == true then
        frameControl._bg:addInputEvent("Mouse_On", "HandleEventOnOut_MiniMapPartyList_ShowRMenuTooltip(true, false, " .. tostring(partyDataWrapper:getPartyDataKey()) .. ")")
        frameControl._bg:addInputEvent("Mouse_Out", "HandleEventOnOut_MiniMapPartyList_ShowRMenuTooltip(false, false, " .. tostring(partyDataWrapper:getPartyDataKey()) .. ")")
      else
        frameControl._bg:removeInputEvent("Mouse_On")
        frameControl._bg:removeInputEvent("Mouse_Out")
      end
      frameControl._control:SetShow(true)
      frameControl._partyDataIndex = partyDataIndex
      frameControl._isSet = true
      isSuccess = true
      break
    end
  end
  if isSuccess == false then
    self:createOriginalFrameControlPool(1)
    self:activateOriginalFrameControl(partyDataIndex)
  end
end
function PaGlobal_RoseWarMiniMapPartyList:updateOriginalFrameControlPosition()
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  if self._originalFrameControlPool == nil then
    return
  end
  local templateControl = UI.getChildControl(self._ui._frm_content_original, "Static_PartyInfo_Template")
  if templateControl == nil then
    return
  end
  local spanX = 0
  local spanY = 0
  local rowIndex = 0
  local colIndex = 0
  local totalCount = 0
  local templateSizeX = templateControl:GetSizeX()
  local templateSizeY = templateControl:GetSizeY()
  local rowMaxCount = math.floor(self._ui._frm_content_original:GetSizeX() / templateSizeX)
  self._ui._stc_original_guild_line:SetSpanSize(10, 5)
  self._ui._stc_original_guild_line:ComputePos()
  local guildLineSpanY = self._ui._stc_original_guild_line:GetSpanSize().y
  local guildLineSizeY = self._ui._stc_original_guild_line:GetSizeY()
  for index = 0, self._originalPoolCount - 1 do
    local frameControl = self._originalFrameControlPool[index]
    if frameControl ~= nil and frameControl._isSet == true then
      local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(frameControl._partyDataIndex)
      if partyDataWrapper ~= nil then
        local partyType = partyDataWrapper:getPartyType()
        if partyType == __eRoseWarPartyType_Guild then
          spanY = guildLineSpanY + guildLineSizeY + frameControl._control:GetSizeY() * colIndex
          rowIndex = rowIndex + 1
          frameControl._control:SetSpanSize(frameControl._control:GetSpanSize().x, spanY)
          frameControl._control:ComputePos()
          if rowMaxCount <= rowIndex then
            rowIndex = 0
            colIndex = colIndex + 1
          end
          totalCount = totalCount + 1
        end
      end
    end
  end
  self._ui._stc_original_mercenary_line:SetSpanSize(10, spanY + templateSizeY)
  self._ui._stc_original_mercenary_line:ComputePos()
  local mercenaryLineSpanY = self._ui._stc_original_mercenary_line:GetSpanSize().y
  local mercenaryLineSizeY = self._ui._stc_original_mercenary_line:GetSizeY()
  rowIndex = 0
  colIndex = 0
  for index = 0, self._originalPoolCount - 1 do
    local frameControl = self._originalFrameControlPool[index]
    if frameControl ~= nil and frameControl._isSet == true then
      local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(frameControl._partyDataIndex)
      if partyDataWrapper ~= nil then
        local partyType = partyDataWrapper:getPartyType()
        if partyType == __eRoseWarPartyType_Mercenary then
          spanY = mercenaryLineSpanY + mercenaryLineSizeY + frameControl._control:GetSizeY() * colIndex
          rowIndex = rowIndex + 1
          frameControl._control:SetSpanSize(frameControl._control:GetSpanSize().x, spanY)
          frameControl._control:ComputePos()
          if rowMaxCount <= rowIndex then
            rowIndex = 0
            colIndex = colIndex + 1
          end
          totalCount = totalCount + 1
        end
      end
    end
  end
  self._ui._frm_content_original:SetSize(self._ui._frm_content_original:GetSizeX(), spanY + templateSizeY)
  self._ui._frm_original:SetSize(self._ui._frm_original:GetSizeX(), self._ui._frm_content_original:GetSizeY())
  self._ui._stc_titleArea:SetSize(self._ui._frm_original:GetSizeX(), self._ui._stc_titleArea:GetSizeY())
  Panel_RoseWar_MiniMapPartyList:SetSize(self._ui._frm_original:GetSizeX(), self._ui._frm_original:GetSpanSize().y + self._ui._frm_original:GetSizeY())
  Panel_RoseWar_MiniMapPartyList:ComputePosAllChild()
  self:refreshAlphaSlider()
  self._ui._frm_original:UpdateContentPos()
  self._ui._frm_original:GetVScroll():SetShow(false)
  self:ComputePanelPosition()
end
function PaGlobal_RoseWarMiniMapPartyList:ComputePanelPosition()
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  local minimap_left = PaGlobalFunc_RoseWarMiniMap_GetMiniMapViewLeftTopPos().x
  local minimap_bottom = PaGlobalFunc_RoseWarMiniMap_GetMiniMapViewRightBottomPos().y
  Panel_RoseWar_MiniMapPartyList:SetPosXY(minimap_left + 10, minimap_bottom - Panel_RoseWar_MiniMapPartyList:GetSizeY() - 10)
end
function PaGlobal_RoseWarMiniMapPartyList:refreshAlphaSlider(pos)
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  if pos == nil then
    local controlPos = (self._lastAlphaSliderControlPos - 0.7) * 2
    self._ui._stc_alphaSlider:SetControlPos(controlPos * 100)
  else
    local controlPos = 0.7 + pos / 2
    if self._lastAlphaSliderControlPos == controlPos then
      return
    end
    self._lastAlphaSliderControlPos = controlPos
  end
  Panel_RoseWar_MiniMapPartyList:SetAlphaChild(self._lastAlphaSliderControlPos)
end
function PaGlobal_RoseWarMiniMapPartyList:addEffectToMissionAcceptableParty()
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  local isSimpleMode = self._ui._chk_simpleMode:IsCheck()
  if isSimpleMode == true then
    for index = 0, self._simplePoolCount - 1 do
      local frameControl = self._simpleFrameControlPool[index]
      if frameControl ~= nil and frameControl._isSet == true then
        local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(frameControl._partyDataIndex)
        if partyDataWrapper ~= nil then
          local isMercenaryGuild = partyDataWrapper:getPartyType() == __eRoseWarPartyType_Mercenary
          local isAcceptableMission = partyDataWrapper:isProgressMission() == false
          if isMercenaryGuild == true and isAcceptableMission == true then
            frameControl._classIcon:AddEffect("UI_RoseWar_Helper_Light_01A", false, 0, 0)
          else
            frameControl._classIcon:EraseAllEffect()
          end
        end
      end
    end
  else
    for index = 0, self._originalPoolCount - 1 do
      local frameControl = self._originalFrameControlPool[index]
      if frameControl ~= nil and frameControl._isSet == true then
        local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(frameControl._partyDataIndex)
        if partyDataWrapper ~= nil then
          local isMercenaryGuild = partyDataWrapper:getPartyType() == __eRoseWarPartyType_Mercenary
          local isAcceptableMission = partyDataWrapper:isProgressMission() == false
          if isMercenaryGuild == true and isAcceptableMission == true then
            frameControl._control:AddEffect("fUI_RoseWar_Helper_01A", false, 0, 0)
          else
            frameControl._control:EraseAllEffect()
          end
        end
      end
    end
  end
end
function PaGlobal_RoseWarMiniMapPartyList:openRClickMenu(partyDataKey)
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  if IsSelfPlayerRoseWarGrade_Commander() == false then
    return
  end
  local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapperByKey(partyDataKey)
  if partyDataWrapper == nil then
    return
  end
  local rClickMenuData = {_partyDataKey = partyDataKey}
  local buttonCount = 1
  local showCount = 0
  if partyDataWrapper:isProgressMission() == true then
    self._ui._btn_rClickMenu_forceComplete:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarMiniMapPartyList_ForceCompleteMission(" .. tostring(partyDataKey) .. ")")
    self._ui._btn_rClickMenu_forceComplete:SetShow(true)
    showCount = showCount + 1
  else
    self._ui._btn_rClickMenu_forceComplete:SetShow(false)
  end
  if showCount == 0 then
    if self:isOpenRClickMenu() == true then
      self:closeRClickMenu()
    end
    return
  end
  self._rClickMenuData = rClickMenuData
  self._ui._stc_rClickMenu:SetPosX(Panel_RoseWar_MiniMapPartyList:GetSizeX() + 5)
  self._ui._stc_rClickMenu:SetPosY(0)
  self._ui._stc_rClickMenu:SetShow(true)
end
function PaGlobal_RoseWarMiniMapPartyList:closeRClickMenu()
  if Panel_RoseWar_MiniMapPartyList == nil then
    return
  end
  self._rClickMenuData = nil
  self._ui._stc_rClickMenu:SetShow(false)
end
function PaGlobal_RoseWarMiniMapPartyList:isOpenRClickMenu()
  if Panel_RoseWar_MiniMapPartyList == nil then
    return false
  end
  return self._ui._stc_rClickMenu:GetShow()
end
