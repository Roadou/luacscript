local _panel = Panel_Worldmap_NodeSiegeTooltip
local UI_VT = CppEnums.VillageSiegeType
local dayString = {
  [UI_VT.eVillageSiegeType_Sunday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SUNDAY"),
  [UI_VT.eVillageSiegeType_Monday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_MONDAY"),
  [UI_VT.eVillageSiegeType_Tuesday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_TUESDAY"),
  [UI_VT.eVillageSiegeType_Wednesday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_WEDNESDAY"),
  [UI_VT.eVillageSiegeType_Thursday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_THUSDAY"),
  [UI_VT.eVillageSiegeType_Friday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_FRIDAY"),
  [UI_VT.eVillageSiegeType_Saturday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SATURDAY")
}
local nodeSiegeInfo = {
  _ui = {
    stc_TitleGroup = UI.getChildControl(Panel_Worldmap_NodeSiegeTooltip, "Static_TitleGroup"),
    stc_GuildGroup = UI.getChildControl(Panel_Worldmap_NodeSiegeTooltip, "Static_OccupiersGuildGroup"),
    stc_NodeStateGroup = UI.getChildControl(Panel_Worldmap_NodeSiegeTooltip, "Static_NodeStateGroup"),
    txt_JoinNodeWarCount = UI.getChildControl(Panel_Worldmap_NodeSiegeTooltip, "MultilineText_JoinNodeWarCount"),
    txt_TaxGrade = UI.getChildControl(Panel_Worldmap_NodeSiegeTooltip, "StaticText_TaxGrade"),
    txt_GuildWarDay = UI.getChildControl(Panel_Worldmap_NodeSiegeTooltip, "StaticText_GuildWarDay")
  },
  originalPanelSizeX = Panel_Worldmap_NodeSiegeTooltip:GetSizeX(),
  originalPanelSizeY = Panel_Worldmap_NodeSiegeTooltip:GetSizeY(),
  originalPanelPosX = Panel_Worldmap_NodeSiegeTooltip:GetPosX(),
  originalNodeStateSizeX = 0,
  originalJoinCountSizeY = 0,
  originalWarDaySizeY = 0
}
function nodeSiegeInfo:init()
  self._ui.txt_title = UI.getChildControl(self._ui.stc_TitleGroup, "StaticText_GuildWarTitle")
  self._ui.txt_guildName = UI.getChildControl(self._ui.stc_GuildGroup, "StaticText_GuildName")
  self._ui.stc_guildIconFirstImage = UI.getChildControl(self._ui.stc_GuildGroup, "Static_GuildMark_First")
  self._ui.stc_guildIconSecondImage = UI.getChildControl(self._ui.stc_GuildGroup, "Static_GuildMark_Second")
  self._ui.stc_guildIconBG = UI.getChildControl(self._ui.stc_GuildGroup, "Static_GuildMarkBG")
  self._ui.txt_guildMasterName = UI.getChildControl(self._ui.stc_GuildGroup, "StaticText_GuildMaster")
  self._ui.txt_benefits = UI.getChildControl(self._ui.stc_GuildGroup, "StaticText_Benefits")
  self._ui.txt_lastWeek = UI.getChildControl(self._ui.stc_GuildGroup, "StaticText_LastWeek")
  self._ui.txt_nodeState = UI.getChildControl(self._ui.stc_NodeStateGroup, "StaticText_NodeState")
  self._ui.txt_nodeStateDesc = UI.getChildControl(self._ui.stc_NodeStateGroup, "StaticText_StateDesc")
  originalNodeStateSizeX = self._ui.stc_NodeStateGroup:GetSizeX()
  self.originalJoinCountSizeY = self._ui.txt_JoinNodeWarCount:GetTextSizeY()
  self.originalWarDaySizeY = self._ui.txt_GuildWarDay:GetTextSizeY()
end
function nodeSiegeInfo:open()
  _panel:SetShow(true)
end
function nodeSiegeInfo:close()
  _panel:SetShow(false)
end
function nodeSiegeInfo:resetSize()
  _panel:SetSize(self.originalPanelSizeX, self.originalPanelSizeY)
  local screenSizeX = getScreenSizeX()
  local gapX = 70
  if screenSizeX / 2 - gapX < self.originalPanelPosX + self.originalPanelSizeX then
    _panel:SetPosX(screenSizeX / 2 - self.originalPanelSizeX - gapX)
  else
    _panel:SetPosX(self.originalPanelPosX)
  end
  self._ui.stc_NodeStateGroup:SetSize(350, 205)
  nodeSiegeInfo:updateComputePos()
end
function nodeSiegeInfo:updateComputePos()
  _panel:ComputePos()
  self._ui.stc_NodeStateGroup:ComputePos()
  self._ui.txt_JoinNodeWarCount:ComputePos()
  self._ui.txt_TaxGrade:ComputePos()
  self._ui.txt_GuildWarDay:ComputePos()
  self._ui.txt_nodeState:ComputePos()
  self._ui.txt_nodeStateDesc:ComputePos()
end
function FromClient_luaLoadComplete_nodeSiegeInfo_Init()
  local self = nodeSiegeInfo
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : nodeSiegeInfo")
    return
  end
  self:init()
end
function FromClient_WorldMapNode_Show(nodeBtn)
  local self = nodeSiegeInfo
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : nodeSiegeInfo")
    return
  end
  if true == Panel_Worldmap_NodeInfo:GetShow() then
    return
  end
  nodeSiegeInfo:resetSize()
  local nodeInfo = nodeBtn:FromClient_getExplorationNodeInClient()
  local plantKey = nodeInfo:getPlantKey()
  local nodeName = ""
  nodeName = ToClient_getNodeName(nodeInfo)
  local nodeNameOri = nodeName
  local waypointKey = plantKey:getWaypointKey()
  local regionInfo = ToClient_getRegionInfoWrapperByWaypoint(waypointKey)
  if regionInfo ~= nil then
    ToClient_createBuildingLineInVillageSiege(waypointKey)
  end
  self._ui.txt_title:SetText(nodeNameOri)
  if _panel:GetSizeX() - 45 < self._ui.txt_title:GetTextSizeX() then
    _panel:SetSize(self._ui.txt_title:GetTextSizeX() + 60, _panel:GetSizeY())
    local rePosX = self._ui.txt_title:GetTextSizeX() - (self.originalPanelSizeX - 45) + 20
    _panel:SetPosX(_panel:GetPosX() - rePosX)
    self._ui.stc_NodeStateGroup:SetSize(self._ui.txt_title:GetTextSizeX() + 60, self._ui.stc_NodeStateGroup:GetSizeY())
    nodeSiegeInfo:updateComputePos()
  end
  local villageSiegeType = nodeBtn:getVillageSiegeType()
  local siegeNode = nodeBtn:FromClient_getExplorationNodeInClient():getStaticStatus():getMinorSiegeRegion()
  local siegeTerritoryOptionWrapper
  if siegeNode ~= nil then
    if ToClinet_GetSiegeTerritoryTypeByRegionKey(siegeNode._regionKey:get()) == __eSiegeTerritoryType_Ocean then
      siegeTerritoryOptionWrapper = ToClient_GetOceanSiegeTerritoryOptionStaticStatusWrapperByRegionKey(siegeNode._regionKey:get())
    elseif ToClient_GetMinorSiegeModeByRegionKey(siegeNode._regionKey:get()) == __eMinorSiegeModeOccupy then
      siegeTerritoryOptionWrapper = ToClient_GetSiegeTerritoryOptionStaticStatusWrapperByRegionKey(siegeNode._regionKey:get())
    end
  end
  if nil ~= siegeNode then
    local taxGrade = siegeNode:getTaxLevel()
    local tempString = "LUA_NODEGRADE_"
    tempString = PAGetString(Defines.StringSheet_GAME, tempString .. tostring(taxGrade + 1))
    if taxGrade == 0 then
      local regionKey = siegeNode._regionKey
      local regionWrapper = getRegionInfoWrapper(regionKey:get())
      local grade = regionWrapper:getSiegeOptionTypeByRegion()
      tempString = "LUA_NODEGRADE_"
      tempString = PAGetString(Defines.StringSheet_GAME, tempString .. tostring(grade))
    end
    local minMemberAtSiege = siegeNode:getMinMemberAtSiege()
    local maxMemberAtSiege = 0
    if siegeTerritoryOptionWrapper ~= nil then
      local day = ToClient_GetDayOfWeekByVillageSiege()
      maxMemberAtSiege = siegeTerritoryOptionWrapper:getLimitMemberCount(day)
    else
      maxMemberAtSiege = siegeNode:getMaxMemberAtSiege()
    end
    if 0 ~= maxMemberAtSiege then
      local str = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SIEGENODE_MINMAX_PARTICIPANT", "MaxMember", tostring(maxMemberAtSiege))
      tempString = tempString .. "(" .. str .. ")"
    end
    self._ui.txt_TaxGrade:SetText(tempString)
    if true == ToClient_GetGuildMode() then
      PaGlobal_WorldMapNodeTooltip_VillageWar_Open(nodeBtn, true)
    else
      self:open()
    end
  else
    self:close()
  end
  if siegeTerritoryOptionWrapper ~= nil then
    local cutDayCount = 4
    local dayCount = siegeTerritoryOptionWrapper:getStartDayListCount()
    if dayCount == 0 then
      villageWar.nodeGuildWarDay:SetShow(false)
    else
      local isIncludeDayString = true
      local eraseComma = true
      local resultDayList = Array.new()
      local addedDayString = ""
      if cutDayCount > dayCount then
        isIncludeDayString = true
        for index = 0, dayCount - 1 do
          local day = siegeTerritoryOptionWrapper:getStartDay(index)
          if day ~= __eVillageSiegeType_Count then
            resultDayList:push_back(day)
          end
        end
      else
        isIncludeDayString = false
        for dayIndex = 0, __eVillageSiegeType_Count - 1 do
          resultDayList:push_back(dayIndex)
        end
        for index = 0, dayCount - 1 do
          local day = siegeTerritoryOptionWrapper:getStartDay(index)
          if day ~= __eVillageSiegeType_Count then
            for dayIndex = #resultDayList, 1, -1 do
              if resultDayList[dayIndex] == day then
                table.remove(resultDayList, dayIndex)
                break
              end
            end
          end
        end
      end
      for key, dayValue in pairs(resultDayList) do
        if dayValue ~= nil then
          local dayStr = dayString[dayValue]
          if dayStr ~= nil then
            if eraseComma == true then
              eraseComma = false
              addedDayString = addedDayString .. dayStr
            else
              addedDayString = addedDayString .. ", " .. dayStr
            end
          else
            UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 \237\131\128\236\158\133\236\158\133\235\139\136\235\139\164! VillageSiegeType \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 \236\151\172\234\184\176\235\143\132 \236\158\145\236\151\133\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.", "\236\157\180\236\163\188")
          end
        end
      end
      local resultDayString = ""
      if isIncludeDayString == true then
        resultDayString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOOLTIP_GUILDWARDAY", "day", addedDayString)
      else
        resultDayString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOOLTIP_GUILDWARDAY_EXCEPT", "day", addedDayString)
      end
      self._ui.txt_GuildWarDay:SetShow(true)
      self._ui.txt_GuildWarDay:SetText(resultDayString)
      self._ui.txt_GuildWarDay:SetSize(self._ui.txt_GuildWarDay:GetSizeX(), self._ui.txt_GuildWarDay:GetTextSizeY())
      self._ui.txt_GuildWarDay:ComputePos()
    end
  else
    local _dayString = ""
    if villageSiegeType >= 0 and villageSiegeType < 7 then
      _dayString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOOLTIP_GUILDWARDAY", "day", dayString[villageSiegeType])
      self._ui.txt_GuildWarDay:SetText(_dayString)
      self._ui.txt_GuildWarDay:SetShow(true)
    end
    if nil ~= siegeNode then
      _dayString = ""
      local regionKey = siegeNode._regionKey
      local regionWrapper = getRegionInfoWrapper(regionKey:get())
      if nil ~= regionWrapper then
        local villageSiegeType = regionWrapper:getVillageSiegeType()
        if _ContentsGroup_MinorSiege2022 == true then
          _dayString = dayString[villageSiegeType]
        else
          local territoryKey = regionWrapper:getTerritoryKeyRaw()
          for i = 0, UI_VT.eVillageSiegeType_Count - 1 do
            if true == ToClient_checkSiegeDayByRawKey(territoryKey, i) then
              _dayString = _dayString .. dayString[i] .. "/"
            end
          end
          if 0 ~= string.len(_dayString) then
            _dayString = string.sub(_dayString, 1, string.len(_dayString) - 1)
          end
        end
      end
      if "" ~= _dayString then
        _dayString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOOLTIP_GUILDWARDAY", "day", _dayString)
        self._ui.txt_GuildWarDay:SetTextMode(__eTextMode_AutoWrap)
        self._ui.txt_GuildWarDay:SetText(_dayString)
        self._ui.txt_GuildWarDay:SetShow(true)
        self._ui.txt_GuildWarDay:ComputePos()
      else
        self._ui.txt_GuildWarDay:SetShow(false)
      end
    end
  end
  local nodeStaticStatus = nodeInfo:getStaticStatus()
  local regionInfo = nodeStaticStatus:getMinorSiegeRegion()
  if nil ~= regionInfo then
    local regionKey = regionInfo._regionKey
    local regionWrapper = getRegionInfoWrapper(regionKey:get())
    local minorSiegeWrapper = regionWrapper:getMinorSiegeWrapper()
    local siegeWrapper = ToClient_GetSiegeWrapperByRegionKey(regionKey:get())
    local siegeTentCount = ToClient_GetCompleteSiegeTentCount(regionKey:get())
    local siegeTerritoryType = ToClinet_GetSiegeTerritoryTypeByRegionKey(regionKey:get())
    local isShowTentCount = siegeTentCount ~= -1
    if nil ~= minorSiegeWrapper then
      if minorSiegeWrapper:isSiegeBeing() then
        self._ui.stc_GuildGroup:SetShow(false)
        self._ui.stc_NodeStateGroup:SetShow(true)
        self._ui.txt_nodeState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_MINUSIEGETOOLTIP_ISBEIGN"))
        local minorSiegeDoing = ToClient_doMinorSiegeInTerritory(regionWrapper:getTerritoryKeyRaw())
        if minorSiegeDoing == true and siegeTerritoryType == __eSiegeTerritoryType_Default then
          self._ui.txt_nodeStateDesc:SetShow(true)
          self._ui.txt_nodeStateDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_MINUSIEGETOOLTIP_JOINGUILD", "count", siegeTentCount))
        else
          self._ui.txt_nodeStateDesc:SetShow(false)
        end
        self._ui.txt_JoinNodeWarCount:SetShow(false)
      elseif true == siegeWrapper:doOccupantExist() then
        local markData = getGuildMarkIndexByGuildNoForXBox(siegeWrapper:getGuildNo())
        if nil ~= markData then
          self._ui.stc_guildIconFirstImage:ChangeTextureInfoNameAsync("renewal/commonicon/guildmark/console_icon_guildmark_00.dds")
          local bgx1, bgy1, bgx2, bgy2 = PaGlobalFunc_GuildMark_GetBackGroundUV(markData:getBackGroundIdx())
          local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_guildIconFirstImage, bgx1, bgy1, bgx2, bgy2)
          self._ui.stc_guildIconFirstImage:getBaseTexture():setUV(x1, y1, x2, y2)
          self._ui.stc_guildIconFirstImage:setRenderTexture(self._ui.stc_guildIconFirstImage:getBaseTexture())
          self._ui.stc_guildIconSecondImage:ChangeTextureInfoNameAsync("renewal/commonicon/guildmark/console_icon_guildmark_00.dds")
          local iconx1, icony1, iconx2, icony2 = PaGlobalFunc_GuildMark_GetIconUV(markData:getIconIdx())
          local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_guildIconSecondImage, iconx1, icony1, iconx2, icony2)
          self._ui.stc_guildIconSecondImage:getBaseTexture():setUV(x1, y1, x2, y2)
          self._ui.stc_guildIconSecondImage:setRenderTexture(self._ui.stc_guildIconSecondImage:getBaseTexture())
        end
        self._ui.txt_guildName:SetText(siegeWrapper:getGuildName())
        if 0 == siegeTentCount then
          self._ui.txt_JoinNodeWarCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOLTIP_JOINNODEWAR_NO"))
        else
          self._ui.txt_JoinNodeWarCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOLTIP_JOINNODEWAR_COUNT", "siegeTentCount", siegeTentCount))
        end
        if isShowTentCount == false then
          self._ui.txt_JoinNodeWarCount:SetTextMode(__eTextMode_AutoWrap)
          self._ui.txt_JoinNodeWarCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPTOOPTIP_BUILDLOCK"))
        end
        self._ui.txt_JoinNodeWarCount:SetShow(siegeTerritoryType == __eSiegeTerritoryType_Default and ToClient_GetMinorSiegeModeByRegionKey(regionKey:get()) == __eMinorSiegeModeBuilding)
        local isAlliance = siegeWrapper:isOccupantGuildAlliance()
        if false == isGameServiceTypeConsole() and false == _ContentsOption_CH_NoCustomGuildMark then
          self._ui.stc_guildIconSecondImage:getBaseTexture():setUV(0, 0, 1, 1)
          if true == isAlliance then
            setGuildTextureByAllianceNo(siegeWrapper:getGuildNo(), self._ui.stc_guildIconSecondImage)
          else
            setGuildTextureByGuildNo(siegeWrapper:getGuildNo(), self._ui.stc_guildIconSecondImage)
          end
        end
        self._ui.txt_nodeStateDesc:SetShow(false)
        self._ui.txt_guildMasterName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_MINUSIEGETOOLTIP_GUILDMASTER", "name", siegeWrapper:getGuildMasterName()))
        local paDate = siegeWrapper:getOccupyingDate()
        local year = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_YEAR", "year", tostring(paDate:GetYear()))
        local month = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_MONTH", "month", tostring(paDate:GetMonth()))
        local day = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_DAY", "day", tostring(paDate:GetDay()))
        local hour = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_HOUR", "hour", tostring(paDate:GetHour()))
        local d_date = year .. month .. day .. hour
        self._ui.txt_benefits:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_MINUSIEGETOOLTIP_OCCUPYINGDATE", "date", d_date))
        self._ui.txt_lastWeek:SetShow(false)
        self._ui.stc_GuildGroup:SetShow(true)
        self._ui.stc_NodeStateGroup:SetShow(false)
      else
        if 0 == siegeTentCount then
          self._ui.txt_JoinNodeWarCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOLTIP_JOINNODEWAR_NO"))
        else
          self._ui.txt_JoinNodeWarCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOLTIP_JOINNODEWAR_COUNT", "siegeTentCount", siegeTentCount))
        end
        if isShowTentCount == false then
          self._ui.txt_JoinNodeWarCount:SetTextMode(__eTextMode_AutoWrap)
          self._ui.txt_JoinNodeWarCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPTOOPTIP_BUILDLOCK"))
        end
        self._ui.txt_JoinNodeWarCount:SetShow(siegeTerritoryType == __eSiegeTerritoryType_Default and ToClient_GetMinorSiegeModeByRegionKey(regionKey:get()) == __eMinorSiegeModeBuilding)
        self._ui.txt_nodeState:SetTextMode(__eTextMode_AutoWrap)
        self._ui.txt_nodeState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_MINUSIEGETOOLTIP_NOTYETOCCUPY"))
        self._ui.stc_GuildGroup:SetShow(false)
        self._ui.stc_NodeStateGroup:SetShow(true)
      end
    end
  end
  local textSize = self._ui.txt_JoinNodeWarCount:GetTextSizeY() - self.originalJoinCountSizeY
  if textSize < 0 then
    textSize = 0
  end
  local warDayTexttSize = self._ui.txt_GuildWarDay:GetTextSizeY() - self.originalWarDaySizeY
  if warDayTexttSize < 0 then
    warDayTexttSize = 0
  end
  self._ui.txt_TaxGrade:SetPosY(self._ui.txt_TaxGrade:GetPosY() + textSize)
  self._ui.txt_GuildWarDay:SetPosY(self._ui.txt_GuildWarDay:GetPosY() + textSize + warDayTexttSize / 2)
  Panel_Worldmap_NodeSiegeTooltip:SetSize(Panel_Worldmap_NodeSiegeTooltip:GetSizeX(), Panel_Worldmap_NodeSiegeTooltip:GetSizeY() + textSize + warDayTexttSize)
end
function FromClient_WorldMapNode_Hide(nodeBtn)
  PaGlobal_WorldMapNodeTooltip_VillageWar_Close()
  nodeSiegeInfo:close()
  ToClient_clearBuildingLineInVillageSiege()
end
function PaGlobalFunc_nodeSiegeInfo_Close()
  local self = nodeSiegeInfo
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : nodeSiegeInfo")
    return
  end
  self:close()
end
registerEvent("FromClient_OnWorldMapNode", "FromClient_WorldMapNode_Show")
registerEvent("FromClient_OutWorldMapNode", "FromClient_WorldMapNode_Hide")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_nodeSiegeInfo_Init")
