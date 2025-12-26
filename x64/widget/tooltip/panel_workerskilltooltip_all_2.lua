function PaGlobalFunc_WorkerSkillTooltip_All_ShowTooltip(index, isAuction)
  if nil == Panel_Widget_WorkerSkillTooltip_All then
    return
  end
  if nil == index or nil == PaGlobal_WorkerSkillTooltip_All._uiBase or true == Panel_Widget_WorkerSkillTooltip_All:GetShow() then
    PaGlobal_WorkerSkillTooltip_All_Hide()
    return
  end
  local workerWrapperLua
  if true == isAuction then
    local auctionInfo = RequestGetAuctionInfo()
    workerNoRaw = auctionInfo:getWorkerAuction(index)
    workerWrapperLua = getWorkerWrapperByAuction(workerNoRaw, true)
  elseif _ContentsGroup_WorkerImprovement == true then
    workerNoRaw = PaGlobalFunc_WorkerAuction_All_getFilterWorkerNoByIndex(index)
    workerWrapperLua = getWorkerWrapper(workerNoRaw, false)
  else
    local plantKey = ToClient_convertWaypointKeyToPlantKey(getCurrentWaypointKey())
    workerNoRaw = ToClient_getPlantWaitWorkerNoRawByIndex(plantKey, index)
    workerWrapperLua = getWorkerWrapper(workerNoRaw, false)
  end
  if nil == workerWrapperLua then
    PaGlobal_WorkerSkillTooltip_All_Hide()
    return
  end
  local skillCount = workerWrapperLua:getSkillCount()
  PaGlobal_WorkerSkillTooltip_All._skillCount = skillCount
  tooltipSizeY = PaGlobal_WorkerSkillTooltip_All._ui._stc_Tooltip_Template:GetSizeY()
  Panel_Widget_WorkerSkillTooltip_All:SetSize(Panel_Widget_WorkerSkillTooltip_All:GetSizeX(), skillCount * tooltipSizeY + 10)
  if skillCount <= 0 then
    PaGlobal_WorkerSkillTooltip_All:hide()
    return
  end
  local lastValidIdx = -1
  for idx = 0, skillCount - 1 do
    if nil ~= PaGlobal_WorkerSkillTooltip_All._tooltiplist[idx] then
      local skillSSW = workerWrapperLua:getSkillSSW(idx)
      local skillSlot = PaGlobal_WorkerSkillTooltip_All._tooltiplist[idx]
      skillSlot.name:SetText(skillSSW:getName())
      skillSlot.icon:ChangeTextureInfoNameAsync(skillSSW:getIconPath())
      local x1, y1, x2, y2 = setTextureUV_Func(skillSlot.icon, 0, 0, 44, 44)
      skillSlot.icon:getBaseTexture():setUV(x1, y1, x2, y2)
      skillSlot.icon:setRenderTexture(skillSlot.icon:getBaseTexture())
      skillSlot.icon:SetShow(false)
      skillSlot.icon:SetShow(true)
      skillSlot.desc:SetText(skillSSW:getDescription())
      local textSizeX = skillSlot.desc:GetTextSizeX()
      if textSizeX > skillSlot.desc:GetSizeX() then
        skillSlot.desc:SetTextMode(__eTextMode_AutoWrap)
        skillSlot.desc:SetText(skillSSW:getDescription())
      end
      local textSizeY = skillSlot.desc:GetTextSizeY()
      local descSizeY = skillSlot.desc:GetSizeY()
      if textSizeY > descSizeY then
        skillSlot.desc:SetSize(skillSlot.desc:GetSizeX(), textSizeY)
        local gap = math.abs(skillSlot.desc:GetSizeY() - descSizeY)
        skillSlot.slot:SetSize(skillSlot.slot:GetSizeX(), skillSlot.slot:GetSizeY() + gap)
      else
        skillSlot.slot:SetSize(skillSlot.slot:GetSizeX(), skillSlot.slot:GetSizeY())
      end
      if idx > 0 then
        skillSlot.slot:SetPosY(PaGlobal_WorkerSkillTooltip_All._tooltiplist[idx - 1].slot:GetPosY() + PaGlobal_WorkerSkillTooltip_All._tooltiplist[idx - 1].slot:GetSizeY() - 1)
      end
      lastValidIdx = idx
      skillSlot.slot:SetShow(true)
      Panel_Widget_WorkerSkillTooltip_All:SetShow(true)
    end
  end
  local uiBase = PaGlobal_WorkerSkillTooltip_All._uiBase
  Panel_Widget_WorkerSkillTooltip_All:SetSpanSize(uiBase:GetSizeX() / 2 + 10, PaGlobal_WorkerSkillTooltip_All._TOOLTIPPOS_Y)
  PaGlobal_WorkerSkillTooltip_All:AudioPostEvent(1, 13, PaGlobal_WorkerSkillTooltip_All._ui._isConsole)
  local tooltipPosX = Panel_Window_WorkerAuction_All:GetPosX() + Panel_Window_WorkerAuction_All:GetSizeX() + Panel_Widget_WorkerSkillTooltip_All:GetSizeX()
  if tooltipPosX > getScreenSizeX() then
    local posX = Panel_Window_WorkerAuction_All:GetPosX() + Panel_Window_WorkerAuction_All:GetSizeX() - (tooltipPosX - getScreenSizeX())
    Panel_Widget_WorkerSkillTooltip_All:SetPosX(posX)
  else
    Panel_Widget_WorkerSkillTooltip_All:SetPosX(Panel_Window_WorkerAuction_All:GetPosX() + Panel_Window_WorkerAuction_All:GetSizeX())
  end
  local setLv40Tooltip = function(workerWrapperLua, lastValidIdx)
    if _ContentsGroup_WorkerLv40 == false then
      return
    end
    local lv40Tooltip = PaGlobal_WorkerSkillTooltip_All._tooltiplist[PaGlobal_WorkerSkillTooltip_All._MAXSLOT]
    if lv40Tooltip == nil then
      return
    end
    if workerWrapperLua == nil then
      return
    end
    local workerLevel = workerWrapperLua:getLevel()
    if workerLevel < __eWorkerPossibleLevelChangeStorage then
      return
    end
    local tooltipPosY = lv40Tooltip.slot:GetPosY()
    if lastValidIdx ~= -1 then
      local lastTooltipSlot = PaGlobal_WorkerSkillTooltip_All._tooltiplist[lastValidIdx]
      if lastTooltipSlot == nil then
        return
      end
      tooltipPosY = lastTooltipSlot.slot:GetPosY() + lastTooltipSlot.slot:GetSizeY()
    end
    lv40Tooltip.desc:SetTextMode(__eTextMode_AutoWrap)
    lv40Tooltip.name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_40_WORKERSKILL_NAME"))
    lv40Tooltip.desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_40_WORKERSKILL_TOOLTIP_ON"))
    local textSizeY = lv40Tooltip.desc:GetTextSizeY()
    local textSizeDiff = textSizeY - lv40Tooltip.originalDescSizeY
    if textSizeDiff > 0 then
      lv40Tooltip.icon:ChangeTextureInfoNameAsync("new_ui_common_forlua/skill/workerskill/2019.dds")
      lv40Tooltip.slot:SetSize(lv40Tooltip.slot:GetSizeX(), lv40Tooltip.originalSlotSizeY + textSizeDiff)
      lv40Tooltip.desc:SetSize(lv40Tooltip.desc:GetSizeX(), textSizeY)
    else
      lv40Tooltip.slot:SetSize(lv40Tooltip.slot:GetSizeX(), lv40Tooltip.originalSlotSizeY)
      lv40Tooltip.desc:SetSize(lv40Tooltip.desc:GetSizeX(), lv40Tooltip.originalDescSizeY)
    end
    lv40Tooltip.slot:SetPosY(tooltipPosY - 1)
    lv40Tooltip.slot:SetShow(true)
  end
  setLv40Tooltip(workerWrapperLua, lastValidIdx)
end
function PaGlobalFunc_WorkerSkillTooltip_All_SetUIBase(uiBase)
  if nil == Panel_Widget_WorkerSkillTooltip_All or nil == uiBase then
    return
  end
  PaGlobal_WorkerSkillTooltip_All._uiBase = uiBase
end
function PaGlobal_WorkerSkillTooltip_All_Hide()
  if nil == Panel_Widget_WorkerSkillTooltip_All then
    return
  end
  for index = 0, PaGlobal_WorkerSkillTooltip_All._MAXSLOT do
    if nil ~= PaGlobal_WorkerSkillTooltip_All._tooltiplist[index] then
      local skillSlot = PaGlobal_WorkerSkillTooltip_All._tooltiplist[index]
      skillSlot.slot:SetShow(false)
    end
  end
  Panel_Widget_WorkerSkillTooltip_All:SetShow(false)
end
