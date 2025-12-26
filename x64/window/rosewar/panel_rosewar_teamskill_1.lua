function PaGlobal_RoseWarTeamSkill:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_bg = UI.getChildControl(Panel_RoseWar_TeamSkill, "Static_BG")
  self._ui._stc_skillTemplate = UI.getChildControl(Panel_RoseWar_TeamSkill, "Static_SkillSlotBg")
  self._ui._stc_partyList = UI.getChildControl(Panel_RoseWar_TeamSkill, "Frame_PartyList")
  self._ui._stc_partyListBg = UI.getChildControl(self._ui._stc_partyList, "Frame_1_Content")
  self._ui._stc_effectTemplate = UI.getChildControl(Panel_RoseWar_TeamSkill, "Static_SkillEffectBg")
  self._ui._stc_lineDeco = UI.getChildControl(Panel_RoseWar_TeamSkill, "Static_LineDeco")
  self._partyDataList = {}
  self._partyDataListReady = false
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_RoseWarTeamSkill:getSkillIconPath(skillType)
  skillStatic = getSkillStaticStatus(ToClient_GetRoseWarSkillKey(skillType), 1)
  if skillStatic == nil then
    return nil
  end
  local skillTypeSSW = skillStatic:getSkillTypeStaticStatusWrapper()
  if skillTypeSSW == nil then
    return nil
  end
  return skillTypeSSW:getIconPath()
end
function PaGlobal_RoseWarTeamSkill:makeSkillButton()
  self._ui._stc_skillBgList = {}
  local slotPos = 14
  local slotSize = 40
  for idx, value in ipairs(PaGlobal_RoseWarSkillList) do
    self._ui._stc_skillBgList[value] = {}
    self._ui._stc_skillBgList[value].bg = UI.cloneControl(self._ui._stc_skillTemplate, self._ui._stc_bg, "Static_SkillSlot" .. tostring(value))
    self._ui._stc_skillBgList[value].slot = {}
    SlotSkill.new(self._ui._stc_skillBgList[value].slot, ToClient_GetRoseWarSkillKey(value), self._ui._stc_skillBgList[value].bg, self._skillSlotConfig)
    self._ui._stc_skillBgList[value].slot.icon:SetPosXY(slotPos, slotPos)
    self._ui._stc_skillBgList[value].slot.icon:SetSize(slotSize, slotSize)
    self._ui._stc_skillBgList[value].slot.icon:SetShow(true)
    self._ui._stc_skillBgList[value].slot.icon:SetIgnore(false)
    self._ui._stc_skillBgList[value].slot.cooltime:SetPosXY(slotPos, slotPos)
    self._ui._stc_skillBgList[value].slot.cooltime:SetSize(slotSize, slotSize)
    self._ui._stc_skillBgList[value].slot.cooltimeText:SetPosXY(slotPos, slotPos)
    self._ui._stc_skillBgList[value].slot.cooltimeText:SetSize(slotSize, slotSize)
    local iconPath = self:getSkillIconPath(value)
    if iconPath ~= nil then
      self._ui._stc_skillBgList[value].slot.icon:ChangeTextureInfoNameAsync("icon/" .. iconPath)
    end
    self._ui._stc_skillBgList[value].toggle = UI.getChildControl(self._ui._stc_skillBgList[value].bg, "Static_SkillToggle")
    self._ui._stc_skillBgList[value].txt = UI.getChildControl(self._ui._stc_skillBgList[value].bg, "StaticText_1")
    self._ui._stc_skillBgList[value].txt:SetText(tostring(idx))
    self._ui._stc_skillBgList[value].effect = UI.cloneControl(self._ui._stc_effectTemplate, self._ui._stc_bg, "Static_TeamSkillEffect" .. tostring(value))
    self._ui._stc_skillBgList[value].effect:SetShow(false)
    self._ui._stc_skillBgList[value].slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarTeamSkill_SelectSkillType(" .. tostring(value) .. ")")
    self._ui._stc_skillBgList[value].slot.icon:addInputEvent("Mouse_RUp", "HandleEventLUp_RoseWarTeamSkill_UnSelectSkillType(" .. tostring(value) .. ")")
    self._ui._stc_skillBgList[value].slot.icon:addInputEvent("Mouse_On", "InputEventMOn_RoseWarTeamSkill_ShowSkillTooltip(" .. tostring(value) .. ")")
    self._ui._stc_skillBgList[value].slot.icon:addInputEvent("Mouse_Out", "InputEventMOn_RoseWarTeamSkill_HideSkillTooltip()")
    self._ui._stc_skillBgList[value].bg:isValidate()
  end
  self._ui._stc_skillTemplate:SetShow(false)
  self._ui._stc_effectTemplate:SetShow(false)
  self._isMakeSkillButton = true
end
function PaGlobal_RoseWarTeamSkill:registEventHandler()
  Panel_RoseWar_TeamSkill:RegisterUpdateFunc("PaGlobalFunc_RoseWarTeamSkill_Update")
  registerEvent("FromClient_ResponseRoseWarUseSkillAck", "FromClient_ResponseRoseWarUseSkillAck")
  registerEvent("onScreenResize", "FromClient_PaGlobal_RoseWarTeamSkill_OnScreenResize")
end
function PaGlobal_RoseWarTeamSkill:update(deltaTime)
  local selectedSkillType = PaGlobalFunc_RoseWarTeamSkillManager_GetSelectedSkillType()
  for _, value in ipairs(PaGlobal_RoseWarSkillList) do
    self._ui._stc_skillBgList[value].toggle:SetShow(value == selectedSkillType)
    local coolTime = ToClient_GetRoseWarSkillCooltime(value)
    local coolTimeRate = ToClient_GetRoseWarSkillCooltimeRate(value)
    local coolTimeExist = coolTime > 0
    self._ui._stc_skillBgList[value].slot.cooltime:SetShow(coolTimeExist)
    self._ui._stc_skillBgList[value].slot.cooltimeText:SetShow(coolTimeExist)
    if coolTimeExist == true then
      self._ui._stc_skillBgList[value].slot.cooltime:UpdateCoolTime(coolTimeRate)
      self._ui._stc_skillBgList[value].slot.cooltimeText:SetText(Time_Formatting_ShowTop(coolTime))
    end
  end
  PaGlobalFunc_RoseWarTeamSkillManager_Update(deltaTime)
end
function PaGlobal_RoseWarTeamSkill:validate()
  self._ui._stc_bg:isValidate()
end
function PaGlobal_RoseWarTeamSkill:prepareOpen(openInfo)
  if self._isMakeSkillButton == false then
    self:makeSkillButton()
  end
  PaGlobalFunc_RoseWarTeamSkillManager_Initialize()
  self:resize()
  if openInfo._align == "RT" then
    openInfo._x = openInfo._x - Panel_RoseWar_TeamSkill:GetSizeX() - 5
    openInfo._y = openInfo._y + 5
  else
    if openInfo._align == "CB" then
      openInfo._x = openInfo._x - Panel_RoseWar_TeamSkill:GetSizeX() / 2
      openInfo._y = openInfo._y - Panel_RoseWar_TeamSkill:GetSizeY() - 25
    else
    end
  end
  Panel_RoseWar_TeamSkill:SetPosXY(openInfo._x, openInfo._y)
  self:open()
end
function PaGlobal_RoseWarTeamSkill:open()
  Panel_RoseWar_TeamSkill:SetShow(true)
end
function PaGlobal_RoseWarTeamSkill:prepareClose()
  self:hideTooltip()
  self:close()
end
function PaGlobal_RoseWarTeamSkill:close()
  Panel_RoseWar_TeamSkill:SetShow(false)
end
function PaGlobal_RoseWarTeamSkill:resize()
  if self._isMakeSkillButton == false then
    return
  end
  local iconSize = {
    x = self._ui._stc_skillTemplate:GetSizeX(),
    y = self._ui._stc_skillTemplate:GetSizeY()
  }
  local currentPosX = 5
  for _, value in ipairs(PaGlobal_RoseWarSkillList) do
    self._ui._stc_skillBgList[value].bg:SetPosX(currentPosX)
    self._ui._stc_skillBgList[value].bg:SetPosY(5)
    currentPosX = currentPosX + iconSize.x + 10
  end
  local skillCount = #PaGlobal_RoseWarSkillList
  local PanelTotalSizeX = (5 + self._ui._stc_skillTemplate:GetSizeX() + 5) * skillCount
  local PanelTotalSizeY = 5 + self._ui._stc_skillTemplate:GetSizeY() + 5
  self._ui._stc_bg:SetSize(PanelTotalSizeX, PanelTotalSizeY)
  Panel_RoseWar_TeamSkill:SetSize(PanelTotalSizeX, PanelTotalSizeY)
  self._ui._stc_lineDeco:ComputePos()
end
function PaGlobal_RoseWarTeamSkill:hideTooltip()
  Panel_SkillTooltip_Hide()
end
function PaGlobal_RoseWarTeamSkill:showTooltip(skillType)
  if PaGlobal_TooltipSkill_All == nil then
    return
  end
  if self._ui._stc_skillBgList == nil then
    return
  end
  if self._ui._stc_skillBgList[skillType] == nil or self._ui._stc_skillBgList[skillType].bg == nil then
    return
  end
  local currentPanel = self._ui._stc_skillBgList[skillType].bg
  local tooltipPanel = PaGlobal_TooltipSkill_All.TooltipSkillGroup.main
  Panel_SkillTooltip_Show(ToClient_GetRoseWarSkillKey(skillType), false, "RoseWarSkill")
  tooltipPanel:SetPosX(currentPanel:GetParentPosX())
  tooltipPanel:SetPosY(currentPanel:GetParentPosY() - tooltipPanel:GetSizeY())
end
function HandleEventLUp_RoseWarTeamSkill_SelectParty(partyDataKey)
  PaGlobalFunc_RoseWarTeamSkillManager_UpdatePartyDataKey(partyDataKey)
  PaGlobalFunc_RoseWarTeamSkillManager_UseRoseWarSkill(__eRoseWarSkillType_Recall)
end
function PaGlobal_RoseWarTeamSkill:prepareOpenPartyList()
  local templateControl = UI.getChildControl(self._ui._stc_partyListBg, "Static_PartyInfo_Template")
  local partyCount = ToClient_GetRoseWarPartyDataCount()
  local loopEnd = partyCount
  if partyCount < #self._partyDataList then
    loopEnd = #self._partyDataList
  end
  for index = 1, loopEnd do
    if self._partyDataList[index] == nil then
      local newControl = UI.cloneControl(templateControl, self._ui._stc_partyListBg, "Static_PartyInfo_" .. tostring(index))
      if newControl ~= nil then
        local controlBg = UI.getChildControl(newControl, "Static_PartyInfoBG")
        newControl:SetShow(false)
        newControl:SetIgnore(true)
        controlBg:SetIgnore(false)
        local partyData = {
          _control = newControl,
          _bg = controlBg,
          _partyName = UI.getChildControl(controlBg, "StaticText_PartyName"),
          _missionIcon = UI.getChildControl(controlBg, "Static_MissionIcon"),
          _partyMemberCount = UI.getChildControl(controlBg, "StaticText_PartyMemCount"),
          _partyType = nil
        }
        self._partyDataList[index] = partyData
      end
    end
    if self._partyDataList[index] ~= nil then
      self._partyDataList[index]._bg:addInputEvent("Mouse_LUp", "")
      self._partyDataList[index]._control:SetShow(false)
      self._partyDataList[index]._partyType = nil
      self._partyDataList[index]._missionIcon:SetShow(false)
      if index <= partyCount then
        local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(index - 1)
        if partyDataWrapper ~= nil and partyDataWrapper:isMadeParty() == true and partyDataWrapper:getInvitedMemberCount() > 0 then
          self._partyDataList[index]._bg:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarTeamSkill_SelectParty(" .. tostring(partyDataWrapper:getPartyDataKey()) .. ")")
          self._partyDataList[index]._control:SetShow(true)
          self._partyDataList[index]._partyType = partyDataWrapper:getPartyType()
          local partyMemo = partyDataWrapper:getPartyMemo()
          if partyMemo == nil or partyMemo == "" then
            partyMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_PARTY_NAME", "num", partyDataWrapper:getPartyIndex() + 1)
          end
          self._partyDataList[index]._partyMemberCount:SetText(partyDataWrapper:getInvitedMemberCount())
          self._partyDataList[index]._partyName:SetText(partyMemo)
          if partyDataWrapper:isProgressMission() == true then
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
                self._partyDataList[index]._missionIcon:ChangeTextureInfoTextureIDAsync(typeIconTextureId)
                self._partyDataList[index]._missionIcon:setRenderTexture(self._partyDataList[index]._missionIcon:getBaseTexture())
                self._partyDataList[index]._missionIcon:SetShow(true)
              end
            end
          end
        end
      end
    end
  end
  if self:rearragePartyList() == true then
    self._partyDataListReady = true
  end
end
function PaGlobal_RoseWarTeamSkill:closePartyList()
  self._partyDataListReady = false
  self._ui._stc_partyList:SetShow(false)
end
function PaGlobal_RoseWarTeamSkill:showPartyList(fierceBattleKeyRaw)
  if self._partyDataListReady ~= true or fierceBattleKeyRaw == nil then
    return
  end
  local posLT = PaGlobalFunc_RoseWarMiniMap_GetFierceBattleObjectIconCenterPos(fierceBattleKeyRaw)
  if posLT == nil then
    return
  end
  local minimapLTRB = PaGlobalFunc_RoseWarMiniMap_GetMiniMapLTRB()
  if minimapLTRB == nil then
    return
  end
  if posLT.x < minimapLTRB.left or posLT.x > minimapLTRB.right or posLT.y < minimapLTRB.top or posLT.y > minimapLTRB.bottom then
    self:closePartyList()
    return
  end
  local posRB = {
    x = posLT.x + self._ui._stc_partyList:GetSizeX(),
    y = posLT.y + self._ui._stc_partyList:GetSizeY()
  }
  local showPos = posLT
  if posRB.x > minimapLTRB.right then
    showPos.x = showPos.x - (posRB.x - minimapLTRB.right)
  end
  if posRB.y > minimapLTRB.bottom then
    showPos.y = showPos.y - (posRB.y - minimapLTRB.bottom)
  end
  self._ui._stc_partyList:SetPosXY(showPos.x - self._ui._stc_bg:GetParentPosX(), showPos.y - self._ui._stc_bg:GetParentPosY())
  self._ui._stc_partyList:SetShow(true)
end
function PaGlobal_RoseWarTeamSkill:rearragePartyList()
  local guildLine = UI.getChildControl(self._ui._stc_partyListBg, "StaticText_GuildParty")
  local mercenaryLine = UI.getChildControl(self._ui._stc_partyListBg, "StaticText_MercenaryParty")
  local currentPosY = 0
  local totalCount = 0
  guildLine:SetSpanSize(10, 5)
  guildLine:ComputePos()
  currentPosY = guildLine:GetSpanSize().y + guildLine:GetSizeY()
  local subCount = 0
  for index, partyData in ipairs(self._partyDataList) do
    if partyData ~= nil and partyData._partyType == __eRoseWarPartyType_Guild then
      partyData._control:SetSpanSize(partyData._control:GetSpanSize().x, currentPosY)
      partyData._control:ComputePos()
      currentPosY = currentPosY + partyData._control:GetSizeY()
      subCount = subCount + 1
    end
  end
  totalCount = totalCount + subCount
  if subCount == 0 then
    guildLine:SetShow(false)
    currentPosY = currentPosY - (guildLine:GetSpanSize().y + guildLine:GetSizeY())
  end
  mercenaryLine:SetSpanSize(10, currentPosY)
  mercenaryLine:ComputePos()
  currentPosY = mercenaryLine:GetSpanSize().y + mercenaryLine:GetSizeY()
  local subCount = 0
  for index, partyData in ipairs(self._partyDataList) do
    if partyData ~= nil and partyData._partyType == __eRoseWarPartyType_Mercenary then
      partyData._control:SetSpanSize(partyData._control:GetSpanSize().x, currentPosY)
      partyData._control:ComputePos()
      currentPosY = currentPosY + partyData._control:GetSizeY()
      subCount = subCount + 1
    end
  end
  totalCount = totalCount + subCount
  if subCount == 0 then
    guildLine:SetShow(false)
    currentPosY = currentPosY - (mercenaryLine:GetSpanSize().y + mercenaryLine:GetSizeY())
  end
  if totalCount == 0 then
    return false
  end
  currentPosY = currentPosY + 5
  self._ui._stc_partyList:SetSize(self._ui._stc_partyList:GetSizeX(), currentPosY)
  self._ui._stc_partyListBg:SetSize(self._ui._stc_partyList:GetSizeX(), currentPosY)
  self._ui._stc_partyList:GetVScroll():SetShow(false)
  return true
end
function PaGlobal_RoseWarTeamSkill:showSkillEffect(skillType, skillUseInfo)
  if skillType == nil or skillUseInfo == nil or skillUseInfo.castPos == nil then
    return
  end
  if self._ui._stc_skillBgList == nil then
    return
  end
  local skillIconInfo = self._ui._stc_skillBgList[skillType]
  if skillIconInfo == nil or skillIconInfo.effect == nil then
    return
  end
  if skillUseInfo.effectName ~= nil then
    skillIconInfo.effect:AddEffect(skillUseInfo.effectName, false, 0, 0)
  end
  skillIconInfo.effect:SetPosXY(skillUseInfo.castPos.x - self._ui._stc_bg:GetParentPosX() - skillIconInfo.effect:GetSizeX() / 2, skillUseInfo.castPos.y - self._ui._stc_bg:GetParentPosY() - skillIconInfo.effect:GetSizeY() / 2 - 40)
  skillIconInfo.effect:SetShow(true)
end
function PaGlobal_RoseWarTeamSkill:hideSkillEffect(skillType)
  if skillType == nil then
    return
  end
  if self._ui._stc_skillBgList == nil then
    return
  end
  local skillIconInfo = self._ui._stc_skillBgList[skillType]
  if skillIconInfo == nil or skillIconInfo.effect == nil then
    return
  end
  skillIconInfo.effect:EraseAllEffect()
  skillIconInfo.effect:SetShow(false)
end
