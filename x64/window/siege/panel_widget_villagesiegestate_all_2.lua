function PaGlobalFunc_VillageSiegeStateWidget_Open()
  local self = PaGlobal_VillageSiegeStateWidget
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_VillageSiegeStateWidget_Close()
  local self = PaGlobal_VillageSiegeStateWidget
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_VillageSiegeStateWidget_IsShow()
  local panel = Panel_Widget_VillageSiegeState_All
  if panel == nil then
    return false
  end
  return panel:GetShow()
end
function PaGlobalFunc_VillageSiegeStateWidget_UpdatePanelPosition()
  local self = PaGlobal_VillageSiegeStateWidget
  if self == nil then
    return
  end
  self:updatePanelPosition()
end
function PaGlobalFunc_VillageSiegeStateWidget_Update(deltaTime)
  local self = PaGlobal_VillageSiegeStateWidget
  if self == nil then
    return
  end
  self._accumulatedDeltaTime = self._accumulatedDeltaTime + deltaTime
  if self._accumulatedDeltaTime > 5 then
    self._accumulatedDeltaTime = 0
    self:update(deltaTime)
  end
end
function PaGlobalFunc_VillageSiegeStateWidget_CreateSiegeTentListContent(content, key)
  local self = PaGlobal_VillageSiegeStateWidget
  if self == nil then
    return
  end
  self:createSiegeTentListContent(content, key)
end
function HandleEventLUp_VillageSiegeStateWidget_OnOutTentContent(isOn, siegeTentIndex)
  local self = PaGlobal_VillageSiegeStateWidget
  if self == nil then
    return
  end
  if isOn == false then
    TooltipSimple_Hide()
    return
  end
  local contentKey = toInt64(0, siegeTentIndex)
  local content = self._ui._lst_siegeTentList:GetContentByKey(contentKey)
  if content == nil then
    return
  end
  local siegeTentWrapper = ToClient_GetBuildingInfoWrapperSiege2024(siegeTentIndex)
  if siegeTentWrapper == nil then
    return
  end
  local stc_progressBg = UI.getChildControl(content, "Static_ProgressBg")
  local stc_progressIcon = UI.getChildControl(stc_progressBg, "Static_Icon")
  local txt_tentName = UI.getChildControl(content, "StaticText_NodeName")
  local prg_hp = UI.getChildControl(content, "Progress2_Hp")
  local endState = siegeTentWrapper:getEndState()
  local isHideSiege = siegeTentWrapper:isHideSiege()
  local name = txt_tentName:GetText()
  local desc
  if endState == __eBuildingInfoStateSiege2024_NotEnd then
    local hpRate = math.ceil(siegeTentWrapper:getHPRate() * 100)
    local hpRatString = ""
    if hpRate >= 75 then
      hpRatString = "<PAColor0xffffd156>" .. tostring(hpRate) .. "<PAOldColor>"
    elseif hpRate >= 50 then
      hpRatString = "<PAColor0xffe8c231>" .. tostring(hpRate) .. "<PAOldColor>"
    elseif hpRate >= 25 then
      hpRatString = "<PAColor0xffdc9b11>" .. tostring(hpRate) .. "<PAOldColor>"
    elseif hpRate >= 10 then
      hpRatString = "<PAColor0xffd97a00>" .. tostring(hpRate) .. "<PAOldColor>"
    elseif hpRate >= 5 then
      hpRatString = "<PAColor0xffbe4a00>" .. tostring(hpRate) .. "<PAOldColor>"
    else
      hpRatString = "<PAColor0xffec4f2d>" .. tostring(hpRate) .. "<PAOldColor>"
    end
    if isHideSiege == true then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_STATE_TOOLTIP_2024_0")
    else
      local remainTime_s64 = siegeTentWrapper:getRemainTime()
      local remainTime = PATime(remainTime_s64)
      local remainTimeRate = siegeTentWrapper:getRemainTimeRate() * 100
      local remainTimeString = ""
      local min = remainTime:GetMinute()
      local sec = remainTime:GetSecond()
      if remainTimeRate >= 50 then
        remainTimeString = "<PAColor0xff57c299>" .. tostring(remainTime:GetMinute()) .. "<PAOldColor>"
      else
        remainTimeString = "<PAColor0xffa0ae4e>" .. tostring(remainTime:GetMinute()) .. "<PAOldColor>"
      end
      if min == 0 then
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_STATE_TOOLTIP_2024_1")
      else
        desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_STATE_TOOLTIP_2024_2", "minute", remainTimeString)
      end
    end
    desc = desc .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SIEGE_CASTLEHP", "hp", hpRatString)
  elseif endState == __eBuildingInfoStateSiege2024_OccupyEnd then
    if siegeTentWrapper:getGuildName() ~= "" then
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_STATE_TOOLTIP_2024_3", "name", siegeTentWrapper:getGuildName())
    else
      local regionKeyRaw = siegeTentWrapper:getRegionKeyRaw()
      local siegeWrapper = ToClient_GetSiegeWrapperByRegionKey(regionKeyRaw)
      if siegeWrapper ~= nil then
        desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_STATE_TOOLTIP_2024_3", "name", siegeWrapper:getGuildName())
      end
    end
  elseif endState == __eBuildingInfoStateSiege2024_ReleaseEnd then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_STATE_TOOLTIP_2024_4")
  else
    return
  end
  TooltipSimple_Show(stc_progressBg, name, desc, stc_progressIcon)
end
function HandleEventLUp_VillageSiegeStateWidget_OnClickedNaviButton(siegeTentIndex)
  local self = PaGlobal_VillageSiegeStateWidget
  if self == nil then
    return
  end
  local siegeTentWrapper = ToClient_GetBuildingInfoWrapperSiege2024(siegeTentIndex)
  if siegeTentWrapper == nil then
    return
  end
  if ToClient_IsShowNaviGuideGroup(0) == true then
    ToClient_clearShowAALineList()
    ToClient_DeleteNaviGuideByGroup(0)
  end
  local drawNaviKey = ToClient_WorldMapNaviStart(siegeTentWrapper:getPosition(), NavigationGuideParam(), false, false)
  if drawNaviKey ~= -1 then
    audioPostEvent_SystemUi(0, 14)
    _AudioPostEvent_SystemUiForXBOX(0, 14)
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PROCMESSAGE_QUEST_ALEADY_FINDWAY"))
  end
end
function FromClient_VillageSiegeStateUI_OnOff(isOn)
  if isOn == nil then
    return
  end
  if isOn == true then
    if PaGlobalFunc_VillageSiegeStateWidget_IsShow() == false then
      PaGlobalFunc_VillageSiegeStateWidget_Open()
    end
  elseif PaGlobalFunc_VillageSiegeStateWidget_IsShow() == true then
    PaGlobalFunc_VillageSiegeStateWidget_Close()
  end
end
function FromClient_VillageSiegeStateUI_ChangedParticipateSiege(isParticipant, isSelf)
  if isParticipant == nil or isSelf == nil or isSelf == false then
    return
  end
  FromClient_VillageSiegeStateUI_OnOff(isParticipant)
end
