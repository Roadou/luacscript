local UI_Color = Defines.Color
local positionTarget = UI.getChildControl(Panel_NodeMenu, "MainMenu_Bg")
Panel_NodeOwnerInfo:SetShow(false)
local nodeOwnerInfo = {
  ui = {
    _static_NodeInfoBG = UI.getChildControl(Panel_NodeOwnerInfo, "NodeInfo_Bg"),
    _static_GuildMarkBG = UI.getChildControl(Panel_NodeOwnerInfo, "NodeInfo_Static_GuildMarkBG"),
    _static_GuildMark = UI.getChildControl(Panel_NodeOwnerInfo, "NodeInfo_Static_GuildMark"),
    _txt_GuildName_Title = UI.getChildControl(Panel_NodeOwnerInfo, "NodeInfo_StaticText_GuildName"),
    _txt_GuildName_Value = UI.getChildControl(Panel_NodeOwnerInfo, "NodeInfo_StaticText_GuildName_Value"),
    _txt_GuildMaster_Title = UI.getChildControl(Panel_NodeOwnerInfo, "NodeInfo_StaticText_GuildMaster"),
    _txt_GuildMaster_Value = UI.getChildControl(Panel_NodeOwnerInfo, "NodeInfo_StaticText_GuildMaster_Value"),
    _txt_HasDate_Title = UI.getChildControl(Panel_NodeOwnerInfo, "NodeInfo_StaticText_HasDate"),
    _txt_HasDate_Value = UI.getChildControl(Panel_NodeOwnerInfo, "NodeInfo_StaticText_HasDate_Value"),
    _txt_NodeBonus_Title = UI.getChildControl(Panel_NodeOwnerInfo, "NodeInfo_NodeBonus"),
    _txt_NodeBonus_Value = UI.getChildControl(Panel_NodeOwnerInfo, "NodeInfo_NodeBonus_Value"),
    _txt_NowWar = UI.getChildControl(Panel_NodeOwnerInfo, "NodeInfo_StaticText_NowWar")
  },
  config = {}
}
if _ContentsGroup_WorldMapMenuFilter == true then
  nodeOwnerInfo.ui._static_NodeInfoBG:SetPosY(55)
  nodeOwnerInfo.ui._static_GuildMarkBG:SetSpanSize(nodeOwnerInfo.ui._static_GuildMarkBG:GetSpanSize().x, 112)
  nodeOwnerInfo.ui._static_GuildMark:SetSpanSize(nodeOwnerInfo.ui._static_GuildMark:GetSpanSize().x, 112)
  nodeOwnerInfo.ui._txt_GuildName_Title:SetSpanSize(nodeOwnerInfo.ui._txt_GuildName_Title:GetSpanSize().x, 121)
  nodeOwnerInfo.ui._txt_GuildName_Value:SetSpanSize(nodeOwnerInfo.ui._txt_GuildName_Value:GetSpanSize().x, 123)
  nodeOwnerInfo.ui._txt_GuildMaster_Title:SetSpanSize(nodeOwnerInfo.ui._txt_GuildMaster_Title:GetSpanSize().x, 169)
  nodeOwnerInfo.ui._txt_GuildMaster_Value:SetSpanSize(nodeOwnerInfo.ui._txt_GuildMaster_Value:GetSpanSize().x, 169)
  nodeOwnerInfo.ui._txt_HasDate_Title:SetSpanSize(nodeOwnerInfo.ui._txt_HasDate_Title:GetSpanSize().x, 190)
  nodeOwnerInfo.ui._txt_HasDate_Value:SetSpanSize(nodeOwnerInfo.ui._txt_HasDate_Value:GetSpanSize().x, 190)
  nodeOwnerInfo.ui._txt_NodeBonus_Title:SetSpanSize(nodeOwnerInfo.ui._txt_NodeBonus_Title:GetSpanSize().x, 220)
  nodeOwnerInfo.ui._txt_NodeBonus_Value:SetSpanSize(nodeOwnerInfo.ui._txt_NodeBonus_Value:GetSpanSize().x, 250)
  nodeOwnerInfo.ui._txt_NowWar:SetSpanSize(nodeOwnerInfo.ui._txt_NowWar:GetSpanSize().x, 175)
end
nodeOwnerInfo.ui._static_MainMenuInsideBG = UI.getChildControl(nodeOwnerInfo.ui._static_NodeInfoBG, "Static_MainMenuInsideBg")
nodeOwnerInfo.ui._txt_NodeBonus_Title:SetFontColor(UI_Color.C_FFFFD46D)
nodeOwnerInfo.ui._txt_NodeBonus_Value:SetFontColor(UI_Color.C_FFEDE699)
function nodeOwnerInfo:SetFontColor(isSiegeBeing, hasOccupant)
  if true == isSiegeBeing then
    if true == _ContentsGroup_ChinaFontColor then
      self.ui._txt_GuildName_Title:SetFontColor(UI_Color.C_FFD7986E)
      self.ui._txt_GuildMaster_Title:SetFontColor(UI_Color.C_FFD7986E)
      self.ui._txt_HasDate_Title:SetFontColor(UI_Color.C_FFD7986E)
    else
      self.ui._txt_GuildName_Title:SetFontColor(UI_Color.C_FFD20000)
      self.ui._txt_GuildMaster_Title:SetFontColor(UI_Color.C_FFD20000)
      self.ui._txt_HasDate_Title:SetFontColor(UI_Color.C_FFD20000)
    end
  elseif true == hasOccupant then
    self.ui._txt_GuildName_Title:SetFontColor(UI_Color.C_FF00C0D7)
    self.ui._txt_GuildMaster_Title:SetFontColor(UI_Color.C_FF00C0D7)
    self.ui._txt_HasDate_Title:SetFontColor(UI_Color.C_FF00C0D7)
  else
    self.ui._txt_GuildName_Title:SetFontColor(UI_Color.C_FFEFEFEF)
    self.ui._txt_GuildMaster_Title:SetFontColor(UI_Color.C_FFEFEFEF)
    self.ui._txt_HasDate_Title:SetFontColor(UI_Color.C_FFEFEFEF)
  end
end
function nodeOwnerInfo:SetShowText(siegeTerritoryType, isSiegeBeing)
  self.ui._txt_GuildMaster_Title:SetShow(not isSiegeBeing)
  self.ui._txt_GuildMaster_Value:SetShow(not isSiegeBeing)
  self.ui._txt_HasDate_Title:SetShow(not isSiegeBeing)
  self.ui._txt_HasDate_Value:SetShow(not isSiegeBeing)
  self.ui._txt_NowWar:SetShow(isSiegeBeing == true and siegeTerritoryType == __eSiegeTerritoryType_Default)
end
function nodeOwnerInfo:Update(nodeStaticStatus)
  local regionInfo = nodeStaticStatus:getMinorSiegeRegion()
  if nil ~= regionInfo then
    local regionKey = regionInfo._regionKey
    local regionWrapper = getRegionInfoWrapper(regionKey:get())
    local minorSiegeWrapper = regionWrapper:getMinorSiegeWrapper()
    local siegeWrapper = ToClient_GetSiegeWrapperByRegionKey(regionKey:get())
    local siegeTentCount = ToClient_GetCompleteSiegeTentCount(regionKey:get())
    local siegeTerritoryType = ToClinet_GetSiegeTerritoryTypeByRegionKey(regionKey:get())
    local dropType = regionInfo:getDropGroupRerollCountOfSieger()
    local nodeTaxType = regionInfo:getTaxLevelSiege2024()
    if nil ~= siegeWrapper then
      local paDate = siegeWrapper:getOccupyingDate()
      local year = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_YEAR", "year", tostring(paDate:GetYear()))
      local month = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_MONTH", "month", tostring(paDate:GetMonth()))
      local day = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_DAY", "day", tostring(paDate:GetDay()))
      local hour = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_HOUR", "hour", tostring(paDate:GetHour()))
      local dropTypeValue = ""
      local isSiegeBeing = minorSiegeWrapper:isSiegeBeing()
      local hasOccupantExist = siegeWrapper:doOccupantExist()
      self:SetShowText(siegeTerritoryType, isSiegeBeing)
      self:SetFontColor(isSiegeBeing, hasOccupantExist)
      if true == isSiegeBeing then
        local isSiegeChannel = ToClient_doMinorSiegeInTerritory(regionWrapper:getTerritoryKeyRaw())
        if true == isSiegeChannel then
          if siegeTerritoryType == __eSiegeTerritoryType_Default then
            self.ui._txt_NowWar:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_NODEWAR_COUNT", "siegeTentCount", siegeTentCount))
          end
        elseif true == _ContentsGroup_ChinaFontColor then
          self.ui._txt_NowWar:SetText("<PAColor0xffd7986e>" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODEOWNERINFO_NOT_NODEWAR") .. "<PAOldColor>")
        else
          self.ui._txt_NowWar:SetText("<PAColor0xfff26a6a>" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODEOWNERINFO_NOT_NODEWAR") .. "<PAOldColor>")
        end
        if true == _ContentsGroup_ChinaFontColor then
          self.ui._txt_GuildName_Value:SetText("<PAColor0xffd7986e>" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODEOWNERINFO_WAR") .. "<PAOldColor>")
        else
          self.ui._txt_GuildName_Value:SetText("<PAColor0xfff26a6a>" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODEOWNERINFO_WAR") .. "<PAOldColor>")
        end
        local nodeTaxLevel = nodeTaxType + 1
        if 0 == dropType and nodeTaxLevel >= 1 then
          dropTypeValue = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_NODEWAR_BENEFITS_TAX", "nodeTaxType", nodeTaxLevel)
        elseif dropType >= 1 and 0 == nodeTaxType then
          dropTypeValue = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_NODEWAR_BENEFITS_LIFE", "dropType", dropType + 1)
        elseif dropType >= 1 and nodeTaxType >= 1 then
          dropTypeValue = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_NODEWAR_BENEFITS_BOTH", "nodeTaxType", tostring(nodeTaxLevel), "dropType", tostring(dropType + 1))
        else
          dropTypeValue = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_NODEWAR_BENEFITS_NOT")
        end
        self.ui._txt_NodeBonus_Value:SetText(dropTypeValue)
      elseif true == hasOccupantExist then
        local isAlliance = siegeWrapper:isOccupantGuildAlliance()
        local isSet = false
        if false == _ContentsOption_CH_NoCustomGuildMark then
          if true == isAlliance then
            isSet = setGuildTextureByAllianceNo(siegeWrapper:getGuildNo(), self.ui._static_GuildMark)
          else
            isSet = setGuildTextureByGuildNo(siegeWrapper:getGuildNo(), self.ui._static_GuildMark)
          end
          if not isSet then
            self.ui._static_GuildMark:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/Default_Buttons.dds")
            local x1, y1, x2, y2 = setTextureUV_Func(self.ui._static_GuildMark, 183, 1, 188, 6)
            self.ui._static_GuildMark:getBaseTexture():setUV(x1, y1, x2, y2)
            self.ui._static_GuildMark:setRenderTexture(self.ui._static_GuildMark:getBaseTexture())
          end
        elseif nil ~= PaGlobalFunc_ConsoleGuildMarkSet then
          PaGlobalFunc_ConsoleGuildMarkSet(siegeWrapper:getGuildNo(), self.ui._static_GuildMark, self.ui._static_GuildMarkBG)
        end
        self.ui._txt_GuildName_Value:SetText("<PAColor0xff00c0d7>" .. siegeWrapper:getGuildName() .. "<PAOldColor>")
        self.ui._txt_GuildMaster_Value:SetText("<PAColor0xff96d4fc>" .. siegeWrapper:getGuildMasterName() .. "<PAOldColor>")
        self.ui._txt_HasDate_Value:SetText("<PAColor0xff96d4fc>" .. year .. " " .. month .. " " .. day .. " " .. hour .. "<PAOldColor>")
        local nodeTaxLevel = nodeTaxType + 1
        if 0 == dropType and nodeTaxLevel >= 1 then
          dropTypeValue = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_NODEWAR_BENEFITS_TAX", "nodeTaxType", nodeTaxLevel)
        elseif dropType >= 1 and 0 == nodeTaxType then
          dropTypeValue = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_NODEWAR_BENEFITS_LIFE", "dropType", dropType + 1)
        elseif dropType >= 1 and nodeTaxType >= 1 then
          dropTypeValue = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_NODEWAR_BENEFITS_BOTH", "nodeTaxType", tostring(nodeTaxLevel), "dropType", tostring(dropType + 1))
        else
          dropTypeValue = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_NODEWAR_BENEFITS_NOT")
        end
        self.ui._txt_NodeBonus_Value:SetText(dropTypeValue)
      else
        self.ui._static_GuildMark:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/Default_Buttons.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(self.ui._static_GuildMark, 0, 0, 0, 0)
        self.ui._static_GuildMark:getBaseTexture():setUV(x1, y1, x2, y2)
        self.ui._static_GuildMark:setRenderTexture(self.ui._static_GuildMark:getBaseTexture())
        if true == _ContentsGroup_ChinaFontColor then
          self.ui._txt_GuildName_Value:SetText("<PAColor0xffd7986e>" .. PAGetString(Defines.StringSheet_GAME, "LUA_GRAND_WORLDMAP_NODEOWNERINFO_NOWAR") .. "<PAOldColor>")
        else
          self.ui._txt_GuildName_Value:SetText("<PAColor0xfff26a6a>" .. PAGetString(Defines.StringSheet_GAME, "LUA_GRAND_WORLDMAP_NODEOWNERINFO_NOWAR") .. "<PAOldColor>")
        end
        self.ui._txt_GuildMaster_Value:SetText("<PAColor0xff515151>-<PAOldColor>")
        self.ui._txt_HasDate_Value:SetText("<PAColor0xff515151>-<PAOldColor>")
        local nodeTaxLevel = nodeTaxType + 1
        if 0 == dropType and nodeTaxLevel >= 1 then
          dropTypeValue = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_NODEWAR_BENEFITS_TAX", "nodeTaxType", nodeTaxLevel)
        elseif dropType >= 1 and 0 == nodeTaxType then
          dropTypeValue = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_NODEWAR_BENEFITS_LIFE", "dropType", dropType + 1)
        elseif dropType >= 1 and nodeTaxType >= 1 then
          dropTypeValue = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_NODEWAR_BENEFITS_BOTH", "nodeTaxType", tostring(nodeTaxLevel), "dropType", tostring(dropType + 1))
        else
          dropTypeValue = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_NODEWAR_BENEFITS_NOT")
        end
        self.ui._txt_NodeBonus_Value:SetText(dropTypeValue)
      end
      local panelSizeX = self.ui._static_NodeInfoBG:GetSizeX()
      local guildNameSize = self.ui._txt_GuildName_Value:GetSpanSize().x + self.ui._txt_GuildName_Value:GetTextSizeX() + self.ui._static_GuildMarkBG:GetSpanSize().x
      if panelSizeX < guildNameSize then
        panelSizeX = guildNameSize
      end
      self.ui._txt_GuildMaster_Value:SetSpanSize(self.ui._txt_GuildMaster_Title:GetSpanSize().x + self.ui._txt_GuildMaster_Title:GetTextSizeX() + 5, self.ui._txt_GuildMaster_Value:GetSpanSize().y)
      local guildMasterNameSize = self.ui._txt_GuildMaster_Value:GetSpanSize().x + self.ui._txt_GuildMaster_Value:GetTextSizeX() + self.ui._txt_GuildMaster_Title:GetSpanSize().x
      if panelSizeX < guildMasterNameSize then
        panelSizeX = guildMasterNameSize
      end
      self.ui._txt_HasDate_Value:SetSpanSize(self.ui._txt_HasDate_Title:GetSpanSize().x + self.ui._txt_HasDate_Title:GetTextSizeX() + 5, self.ui._txt_HasDate_Value:GetSpanSize().y)
      local hasDateSize = self.ui._txt_HasDate_Value:GetSpanSize().x + self.ui._txt_HasDate_Value:GetTextSizeX() + self.ui._txt_HasDate_Title:GetSpanSize().x
      if panelSizeX < hasDateSize then
        panelSizeX = hasDateSize
      end
      self.ui._static_NodeInfoBG:SetSize(panelSizeX, self.ui._static_NodeInfoBG:GetSizeY())
      if nil ~= self.ui._static_MainMenuInsideBG then
        self.ui._static_MainMenuInsideBG:SetSize(panelSizeX - 6, self.ui._static_MainMenuInsideBG:GetSizeY())
      end
    else
      nodeOwnerInfo:Close()
    end
  end
end
function FGlobal_nodeOwnerInfo_SetInfo(nodeStaticStatus)
  nodeOwnerInfo:Update(nodeStaticStatus)
end
function nodeOwnerInfo:Close()
  Panel_NodeOwnerInfo:SetShow(false)
end
function FGlobal_nodeOwnerInfo_SetPosition()
  Panel_NodeOwnerInfo:SetPosX(positionTarget:GetSpanSize().x + positionTarget:GetSizeX() + 10)
  Panel_NodeOwnerInfo:SetPosY(positionTarget:GetSpanSize().y)
end
function FGlobal_nodeOwnerInfo_Close()
  nodeOwnerInfo:Close()
end
