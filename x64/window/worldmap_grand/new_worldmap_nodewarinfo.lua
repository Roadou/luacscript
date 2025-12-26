local UI_color = Defines.Color
Panel_Win_Worldmap_NodeWarInfo:SetShow(false)
local nodeWarInfoUIPool = {}
local oceanSiegeInfoUIPool = {}
local toolTip = UI.getChildControl(Panel_Win_Worldmap_NodeWarInfo, "StaticText_Help")
local ing
local duringWarTitle = UI.getChildControl(Panel_Win_Worldmap_NodeWarInfo, "StaticText_DuringTheWar")
local endTheWarTitle = UI.getChildControl(Panel_Win_Worldmap_NodeWarInfo, "StaticText_EndTheWar")
local MAX_TERRITORY_COUNT = 7
local OCEAN_TERRITORY_KEY = 5
toolTip:SetShow(false)
duringWarTitle:addInputEvent("Mouse_On", "NodeWarScoreIconToolTip( true, \"find\")")
duringWarTitle:addInputEvent("Mouse_Out", "NodeWarScoreIconToolTip( false )")
endTheWarTitle:addInputEvent("Mouse_On", "NodeWarScoreIconToolTip( true, \"all\" )")
endTheWarTitle:addInputEvent("Mouse_Out", "NodeWarScoreIconToolTip( false )")
function NodeWarScoreIconToolTip(show, value)
  if true == show then
    if "find" == value then
      toolTip:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_NODEWARINFO_TOOLTIP_ING"))
      toolTip:SetSize(toolTip:GetTextSizeX() + 10, toolTip:GetSizeY())
      toolTip:SetPosX(duringWarTitle:GetPosX() - toolTip:GetTextSizeX())
      toolTip:SetPosY(duringWarTitle:GetPosY() - toolTip:GetSizeY())
      toolTip:SetShow(true)
    else
      toolTip:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_NODEWARINFO_TOOLTIP_END"))
      toolTip:SetSize(toolTip:GetTextSizeX() + 10, toolTip:GetSizeY())
      toolTip:SetPosX(endTheWarTitle:GetPosX() - toolTip:GetTextSizeX())
      toolTip:SetPosY(endTheWarTitle:GetPosY() - toolTip:GetSizeY())
      toolTip:SetShow(true)
    end
  else
    toolTip:SetShow(false)
  end
end
local Templete = {
  nodeWar_Name = UI.getChildControl(Panel_Win_Worldmap_NodeWarInfo, "StaticText_NodeWar_Name"),
  nodeWar_IngCount = UI.getChildControl(Panel_Win_Worldmap_NodeWarInfo, "StaticText_NodeWar_IngCount"),
  nodeWar_EndCount = UI.getChildControl(Panel_Win_Worldmap_NodeWarInfo, "StaticText_NodeWar_EndCount")
}
local nodeWar_NamePosY = Templete.nodeWar_Name:GetPosY()
local nodeWar_CountPosY = Templete.nodeWar_EndCount:GetPosY()
local nodeWar_maxPosY = 0
local siegeIcon = {
  [0] = {
    19,
    170,
    51,
    202
  },
  [1] = {
    154,
    219,
    185,
    250
  }
}
local function chanege_SiegeIcon(control, isBattle)
  if 0 == isBattle then
    control:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/default_etc_01.dds")
  else
    control:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/default_etc_00.dds")
  end
  local x1, y1, x2, y2 = setTextureUV_Func(control, siegeIcon[isBattle][1], siegeIcon[isBattle][2], siegeIcon[isBattle][3], siegeIcon[isBattle][4])
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
local function NodeWarInfo_Init()
  local line_gap = 5
  local territoryCount = getTerritoryListByAll()
  if nil == territoryCount then
    return
  end
  territoryCount = math.min(territoryCount, MAX_TERRITORY_COUNT)
  for territory_idx = 0, territoryCount - 1 do
    if OCEAN_TERRITORY_KEY ~= territory_idx then
      local territoryKey = getTerritoryByIndex(territory_idx)
      local territoryName = getTerritoryNameByKey(territoryKey)
      if nil ~= territoryKey then
        local territoryDATA = {}
        territoryDATA.Name = UI.createControl(__ePAUIControl_StaticText, Panel_Win_Worldmap_NodeWarInfo, "StaticText_NodeWar_Name_" .. territory_idx)
        CopyBaseProperty(Templete.nodeWar_Name, territoryDATA.Name)
        territoryDATA.Name:SetShow(true)
        territoryDATA.Name:SetPosY(nodeWar_NamePosY)
        territoryDATA.Name:SetText(territoryName)
        chanege_SiegeIcon(territoryDATA.Name, 0)
        territoryDATA.IngCount = UI.createControl(__ePAUIControl_StaticText, Panel_Win_Worldmap_NodeWarInfo, "StaticText_NodeWar_IngCount_" .. territory_idx)
        CopyBaseProperty(Templete.nodeWar_IngCount, territoryDATA.IngCount)
        territoryDATA.IngCount:SetShow(true)
        territoryDATA.IngCount:SetPosY(nodeWar_CountPosY)
        territoryDATA.EndCount = UI.createControl(__ePAUIControl_StaticText, Panel_Win_Worldmap_NodeWarInfo, "StaticText_NodeWar_EndCount_" .. territory_idx)
        CopyBaseProperty(Templete.nodeWar_EndCount, territoryDATA.EndCount)
        territoryDATA.EndCount:SetShow(true)
        territoryDATA.EndCount:SetPosY(nodeWar_CountPosY)
        nodeWar_NamePosY = nodeWar_NamePosY + territoryDATA.Name:GetSizeY() + 5 + line_gap
        nodeWar_CountPosY = nodeWar_CountPosY + territoryDATA.IngCount:GetSizeY() + 5 + line_gap
        nodeWar_maxPosY = math.max(nodeWar_maxPosY, nodeWar_NamePosY)
        nodeWarInfoUIPool[territory_idx] = territoryDATA
      end
    end
  end
end
local function OceanSiegeInfo_Init()
  if _ContentsGroup_OceanSiege == false then
    return
  end
  local line_gap = 5
  local territoryCount = ToClient_GetOceanSiegeTerritoryCount()
  if territoryCount == 0 then
    return
  end
  territoryCount = math.min(territoryCount, MAX_TERRITORY_COUNT)
  for territory_idx = 0, territoryCount - 1 do
    local territoryKey = ToClient_GetOceanSiegeTerritoryByIndex(territory_idx)
    if territoryKey ~= nil then
      local territoryName = getTerritoryNameByKey(territoryKey)
      if nil ~= territoryKey then
        local territoryDATA = {}
        territoryDATA.Name = UI.createControl(__ePAUIControl_StaticText, Panel_Win_Worldmap_NodeWarInfo, "StaticText_OceanSiege_Name_" .. territory_idx)
        CopyBaseProperty(Templete.nodeWar_Name, territoryDATA.Name)
        territoryDATA.Name:SetShow(true)
        territoryDATA.Name:SetPosY(nodeWar_NamePosY)
        territoryDATA.Name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_WAR_INFO_OCEAN_SIEGE_PREFIX") .. " " .. territoryName)
        chanege_SiegeIcon(territoryDATA.Name, 0)
        territoryDATA.IngCount = UI.createControl(__ePAUIControl_StaticText, Panel_Win_Worldmap_NodeWarInfo, "StaticText_OceanSiege_IngCount_" .. territory_idx)
        CopyBaseProperty(Templete.nodeWar_IngCount, territoryDATA.IngCount)
        territoryDATA.IngCount:SetShow(true)
        territoryDATA.IngCount:SetPosY(nodeWar_CountPosY)
        territoryDATA.EndCount = UI.createControl(__ePAUIControl_StaticText, Panel_Win_Worldmap_NodeWarInfo, "StaticText_OceanSiege_EndCount_" .. territory_idx)
        CopyBaseProperty(Templete.nodeWar_EndCount, territoryDATA.EndCount)
        territoryDATA.EndCount:SetShow(true)
        territoryDATA.EndCount:SetPosY(nodeWar_CountPosY)
        nodeWar_NamePosY = nodeWar_NamePosY + territoryDATA.Name:GetSizeY() + 5 + line_gap
        nodeWar_CountPosY = nodeWar_CountPosY + territoryDATA.IngCount:GetSizeY() + 5 + line_gap
        nodeWar_maxPosY = math.max(nodeWar_maxPosY, nodeWar_NamePosY)
        oceanSiegeInfoUIPool[territory_idx] = territoryDATA
      end
    end
  end
end
local function UpdatePanelSize()
  Panel_Win_Worldmap_NodeWarInfo:SetSize(Panel_Win_Worldmap_NodeWarInfo:GetSizeX(), nodeWar_maxPosY + 5)
end
function FromClient_NodeWarInfoTentCountUpdate()
  NodeWar_Info_Update()
  OceanSiege_Info_Update()
end
registerEvent("FromClient_KingOrLordTentCountUpdate", "FromClient_NodeWarInfoTentCountUpdate")
function NodeWar_Info_Update()
  local territoryCount = getTerritoryListByAll()
  if nil == territoryCount then
    return
  end
  territoryCount = math.min(territoryCount, MAX_TERRITORY_COUNT)
  for territory_idx = 0, territoryCount - 1 do
    if OCEAN_TERRITORY_KEY ~= territory_idx then
      local territoryDATA = nodeWarInfoUIPool[territory_idx]
      local territoryKey = getTerritoryByIndex(territory_idx):get()
      local nowBeingMinor = ToClient_GetVillageSiegeCountByTerritory(__eSiegeTerritoryType_Default, territoryKey, true)
      local nowFinishMinor = ToClient_GetVillageSiegeCountByTerritory(__eSiegeTerritoryType_Default, territoryKey, false)
      if nowBeingMinor > 0 then
        chanege_SiegeIcon(territoryDATA.Name, 1)
        territoryDATA.Name:SetFontColor(UI_color.C_FFE7E7E7)
        territoryDATA.IngCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_NODEWARINFO_NOWBEINGMINOR", "nowBeingMinor", tostring(nowBeingMinor)))
        territoryDATA.IngCount:SetFontColor(UI_color.C_FF40D7FD)
        territoryDATA.EndCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_NODEWARINFO_NOWENDMINOR", "nowFinishMinor", tostring(nowFinishMinor)))
        if _ContentsGroup_ChinaFontColor == true then
          territoryDATA.EndCount:SetFontColor(UI_color.C_FF6195BD)
        else
          territoryDATA.EndCount:SetFontColor(UI_color.C_FFFF4B4B)
        end
      else
        chanege_SiegeIcon(territoryDATA.Name, 0)
        territoryDATA.Name:SetFontColor(UI_color.C_FF626262)
        territoryDATA.IngCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_NODEWARINFO_ING"))
        territoryDATA.IngCount:SetFontColor(UI_color.C_FF626262)
        territoryDATA.EndCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_NODEWARINFO_END"))
        territoryDATA.EndCount:SetFontColor(UI_color.C_FF626262)
      end
    end
  end
end
function OceanSiege_Info_Update()
  if _ContentsGroup_OceanSiege == false then
    return
  end
  local territoryCount = ToClient_GetOceanSiegeTerritoryCount()
  if territoryCount == 0 then
    return
  end
  territoryCount = math.min(territoryCount, MAX_TERRITORY_COUNT)
  for territory_idx = 0, territoryCount - 1 do
    local territoryKey = ToClient_GetOceanSiegeTerritoryByIndex(territory_idx)
    if territoryKey ~= nil then
      local territoryDATA = oceanSiegeInfoUIPool[territory_idx]
      local territoryKeyRaw = territoryKey:get()
      local nowBeingMinor = ToClient_GetVillageSiegeCountByTerritory(__eSiegeTerritoryType_Ocean, territoryKeyRaw, true)
      local nowFinishMinor = ToClient_GetVillageSiegeCountByTerritory(__eSiegeTerritoryType_Ocean, territoryKeyRaw, false)
      if nowBeingMinor > 0 then
        chanege_SiegeIcon(territoryDATA.Name, 1)
        territoryDATA.Name:SetFontColor(UI_color.C_FFE7E7E7)
        territoryDATA.IngCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_NODEWARINFO_NOWBEINGMINOR", "nowBeingMinor", tostring(nowBeingMinor)))
        territoryDATA.IngCount:SetFontColor(UI_color.C_FF40D7FD)
        territoryDATA.EndCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_NODEWARINFO_NOWENDMINOR", "nowFinishMinor", tostring(nowFinishMinor)))
        if _ContentsGroup_ChinaFontColor == true then
          territoryDATA.EndCount:SetFontColor(UI_color.C_FF6195BD)
        else
          territoryDATA.EndCount:SetFontColor(UI_color.C_FFFF4B4B)
        end
      else
        chanege_SiegeIcon(territoryDATA.Name, 0)
        territoryDATA.Name:SetFontColor(UI_color.C_FF626262)
        territoryDATA.IngCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_NODEWARINFO_ING"))
        territoryDATA.IngCount:SetFontColor(UI_color.C_FF626262)
        territoryDATA.EndCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_NODEWARINFO_END"))
        territoryDATA.EndCount:SetFontColor(UI_color.C_FF626262)
      end
    end
  end
end
function FGlobal_NodeWarInfo_Open()
  if Panel_Win_Worldmap_NodeWarInfo:GetShow() then
    return
  end
  if _ContentsGroup_WorldMapMenuFilter == true then
    Panel_Win_Worldmap_NodeWarInfo:SetSpanSize(70, 50)
  else
    Panel_Win_Worldmap_NodeWarInfo:SetSpanSize(5, 75)
  end
  local isSiegeBeing_chk = false
  local territoryCount = getTerritoryListByAll()
  if territoryCount == nil then
    return
  end
  territoryCount = math.min(territoryCount, MAX_TERRITORY_COUNT)
  for territory_idx = 0, territoryCount - 1 do
    if OCEAN_TERRITORY_KEY ~= territory_idx then
      local territoryKey = getTerritoryByIndex(territory_idx):get()
      local nowBeingMinor = ToClient_GetVillageSiegeCountByTerritory(__eSiegeTerritoryType_Default, territoryKey, true)
      if nowBeingMinor > 0 then
        isSiegeBeing_chk = true
      end
    end
  end
  if isSiegeBeing_chk == false and _ContentsGroup_OceanSiege == true then
    territoryCount = math.min(ToClient_GetOceanSiegeTerritoryCount(), MAX_TERRITORY_COUNT)
    for territory_idx = 0, territoryCount - 1 do
      if OCEAN_TERRITORY_KEY ~= territory_idx then
        local territoryKeyRaw = ToClient_GetOceanSiegeTerritoryByIndex(territory_idx):get()
        local nowBeingMinor = ToClient_GetVillageSiegeCountByTerritory(__eSiegeTerritoryType_Ocean, territoryKeyRaw, true)
        if nowBeingMinor > 0 then
          isSiegeBeing_chk = true
        end
      end
    end
  end
  if isSiegeBeing_chk == true then
    Panel_Win_Worldmap_NodeWarInfo:SetShow(true)
    Panel_Win_Worldmap_WarInfo:SetShow(false)
    NodeWar_Info_Update()
    OceanSiege_Info_Update()
  end
end
function FGlobal_NodeWarInfo_Close()
  if not Panel_Win_Worldmap_NodeWarInfo:GetShow() then
    return
  end
  NodeWarScoreIconToolTip(false)
  Panel_Win_Worldmap_NodeWarInfo:SetShow(false)
end
NodeWarInfo_Init()
OceanSiegeInfo_Init()
UpdatePanelSize()
