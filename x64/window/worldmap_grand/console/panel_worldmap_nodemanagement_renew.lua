local Window_WorldMap_NodeManagementInfo = {
  _ui = {
    _static_TopBg = UI.getChildControl(Panel_Worldmap_NodeManagement, "Static_TopBg"),
    _static_NodeManagementBg = UI.getChildControl(Panel_Worldmap_NodeManagement, "Static_NodeManagementBg"),
    _static_NodeInvestmentBg = UI.getChildControl(Panel_Worldmap_NodeManagement, "Static_NodeInvestmentBg"),
    _static_SubNodeBg = UI.getChildControl(Panel_Worldmap_NodeManagement, "Static_SubNodeBg"),
    _static_BottomBg = UI.getChildControl(Panel_Worldmap_NodeManagement, "Static_BottomBg"),
    _stc_NodeResultTooltip = nil,
    _stc_NodeResultTooltipTitle = nil,
    _stcTxt_NodeProductTitle = nil,
    _stc_NodeProductDesc = nil,
    _stc_NodeProductTitle_Template = nil
  },
  _nodeResultIconBG = {},
  _nodeResultIcon = {},
  _nodeResultIconName = {},
  _productNodeTitle = {},
  _subNodeIconTexture = "renewal/ui_icon/console_icon_worldmap_00.dds",
  _config = {_defaultPanelSizeY = 0, _defaultPanelPosY = 0},
  _subNodeIconUV = {
    [4] = {
      _x1 = 1,
      _y1 = 457,
      _x2 = 55,
      _y2 = 511
    },
    [__eExplorationNodeType_Collect] = {
      _x1 = 1,
      _y1 = 457,
      _x2 = 55,
      _y2 = 511
    },
    [__eExplorationNodeType_Quarry] = {
      _x1 = 56,
      _y1 = 457,
      _x2 = 110,
      _y2 = 511
    },
    [__eExplorationNodeType_Logging] = {
      _x1 = 111,
      _y1 = 457,
      _x2 = 165,
      _y2 = 511
    },
    [__eExplorationNodeType_FishTrap] = {
      _x1 = 331,
      _y1 = 457,
      _x2 = 385,
      _y2 = 511
    },
    [__eExplorationNodeType_MonopolyFarm] = {
      _x1 = 166,
      _y1 = 457,
      _x2 = 220,
      _y2 = 511
    },
    [__eExplorationNodeType_Craft] = {
      _x1 = 221,
      _y1 = 457,
      _x2 = 275,
      _y2 = 511
    },
    [__eExplorationNodeType_Excavation] = {
      _x1 = 276,
      _y1 = 457,
      _x2 = 330,
      _y2 = 511
    },
    [__eExplorationNodeType_Finance] = {
      _x1 = 386,
      _y1 = 457,
      _x2 = 440,
      _y2 = 511
    }
  },
  _currentNodeData = nil,
  _currentSubNodeIndex = 0,
  _subNodeInfoList = {},
  _deleteNodeKey = nil,
  _lastKey = nil,
  _currentWorldNode = nil,
  _isMaxSubNode = false,
  _isTown = false,
  _keyGuideAlign = {},
  lastFindNodeKey = nil
}
function Window_WorldMap_NodeManagementInfo:SetTownManagementUI()
  self._ui._static_SubNodeBg:SetShow(false)
  self._ui._static_NodeManagementBg:SetShow(false)
  self._ui._static_NodeInvestmentBg:SetPosY(self._ui._static_TopBg:GetPosY() + self._ui._static_TopBg:GetSizeY() + 15)
  local offsetY = self._ui._static_SubNodeBg:GetSizeY() + self._ui._static_NodeManagementBg:GetSizeY() + 40
  Panel_Worldmap_NodeManagement:SetSize(Panel_Worldmap_NodeManagement:GetSizeX(), self._config._defaultPanelSizeY - offsetY)
  Panel_Worldmap_NodeManagement:ComputePos()
  self._ui._static_BottomBg:ComputePos()
end
function Window_WorldMap_NodeManagementInfo:SetNoneTownManagementUI()
  self._ui._static_SubNodeBg:SetShow(true)
  self._ui._static_NodeManagementBg:SetShow(true)
  self._ui._static_NodeInvestmentBg:SetPosY(self._ui._static_NodeManagementBg:GetPosY() + self._ui._static_NodeManagementBg:GetSizeY() + 15)
  Panel_Worldmap_NodeManagement:SetSize(Panel_Worldmap_NodeManagement:GetSizeX(), self._config._defaultPanelSizeY)
  Panel_Worldmap_NodeManagement:ComputePos()
  self._ui._static_BottomBg:ComputePos()
  if 0 == self._currentSubNodeIndex then
    self:WithOutSubNode()
  else
    self:WithSubNode()
  end
end
function Window_WorldMap_NodeManagementInfo:WithOutSubNode()
  self._ui._static_SubNodeBg:SetShow(false)
  local offsetY = self._ui._static_SubNodeBg:GetSizeY() + 20
  Panel_Worldmap_NodeManagement:SetSize(Panel_Worldmap_NodeManagement:GetSizeX(), self._config._defaultPanelSizeY - offsetY)
  Panel_Worldmap_NodeManagement:ComputePos()
  self._ui._static_BottomBg:ComputePos()
end
function Window_WorldMap_NodeManagementInfo:WithSubNode()
  self._ui._static_SubNodeBg:SetShow(true)
  Panel_Worldmap_NodeManagement:SetSize(Panel_Worldmap_NodeManagement:GetSizeX(), self._config._defaultPanelSizeY)
  Panel_Worldmap_NodeManagement:ComputePos()
  self._ui._static_BottomBg:ComputePos()
end
function Window_WorldMap_NodeManagementInfo:SetTopTitle()
  if nil == self._currentNodeData then
    return
  end
  local nodeStaticStatus = self._currentNodeData._nodeSS
  self._ui._staticText_NodeName:SetText(getExploreNodeName(nodeStaticStatus))
  self._ui._staticText_NodeNpcValue:SetText(requestNodeManagerName(self._currentNodeData._wayPointKey))
  local titlePosX = self._ui._staticText_NodeContributeTitle:GetPosX() + self._ui._staticText_NodeContributeTitle:GetSizeX() - self._ui._staticText_NodeContributeTitle:GetTextSizeX()
  if titlePosX < self._ui._staticText_NodeNpcValue:GetPosX() + self._ui._staticText_NodeNpcValue:GetTextSizeX() then
    self._ui._staticText_NodeContributeTitle:SetShow(false)
  else
    self._ui._staticText_NodeContributeTitle:SetShow(true)
  end
end
function Window_WorldMap_NodeManagementInfo:SetContribute()
  if nil == self._currentNodeData then
    return
  end
  local nodeKey = self._currentNodeData._wayPointKey
  local nodeStaticStatus = self._currentNodeData._nodeSS
  local isPurchased = self._currentNodeData._isPurchased
  local isPurchased = self._currentNodeData._isPurchased
  local needPoint = nodeStaticStatus._needPoint
  self._ui._button_Contribute:addInputEvent("Mouse_LUp", "")
  self._ui.txt_ContributeValue:SetText(needPoint)
  self._ui.txt_ContributeValue:SetShow(true)
  self._ui._button_Contribute:SetCheck(false)
  self._ui._static_ToolTip:SetShow(false)
  self._ui._button_Contribute:SetIgnore(false)
  self._ui._button_Contribute:SetMonoTone(false)
  if true == isExploreUpgradable(nodeKey) then
    self._ui._staticText_ContributeTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "WORLDMAP_NODE_BTN_REQUIRE"))
    self._ui._staticText_ContributeDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_NODEMANAGEMENT_CONTRIBUTE_DESC"))
    if self._isTown == true and self._currentSubNodeIndex > 0 then
      self._ui._button_Contribute:SetMonoTone(true)
      self._ui._button_Contribute:SetText(PAGetString(Defines.StringSheet_RESOURCE, "WORLDMAP_NODE_BTN_WITHDRAW"))
      self._ui._staticText_ContributeDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_NODEMANAGEMENT_CONTRIBUTE_DESC"))
      self._ui._button_Contribute:SetIgnore(true)
      self._ui.txt_ContributeValue:SetShow(false)
    elseif isPurchased == false then
      self._ui._button_Contribute:SetText(PAGetString(Defines.StringSheet_RESOURCE, "WORLDMAP_NODE_BTN_REQUIRE"))
      self._ui._button_Contribute:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldMap_NodeManagement_NodeUpgradeClick(" .. tostring(nodeKey) .. ")")
      Panel_Worldmap_NodeManagement:registerPadEvent(__eConsoleUIPadEvent_X, "")
    else
      local currentNodeBuffPercent = ToClient_getNodeIncreaseItemDropPercent() * ToClient_GetNodeLevel(nodeKey)
      currentNodeBuffPercent = currentNodeBuffPercent / 10000
      local selfplayerActorProxyWrapper = getSelfPlayer()
      if selfplayerActorProxyWrapper ~= nil then
        local guildNoOrAllianceNo = selfplayerActorProxyWrapper:getGuildNo_s64()
        if selfplayerActorProxyWrapper:isGuildAllianceMember() == true then
          guildNoOrAllianceNo = selfplayerActorProxyWrapper:getGuildAllianceNo_s64()
        end
        local minorSiegeRegionKey = ToClient_GetSiegeRegionKeyRawByWaypointKey(nodeKey)
        local regionKey = ToClient_GetRegionKeyRawByWaypointKey(nodeKey)
        local siegeWrapper = ToClient_GetSiegeWrapperByRegionKey(minorSiegeRegionKey)
        if ToClient_IsAppliedDropRateBuffSiege2024ByRegionKey(minorSiegeRegionKey) == true then
          currentNodeBuffPercent = currentNodeBuffPercent * ToClient_getNodeIncreaseItemDropOccupyMinorSiegePercent() / 1000000
        elseif ToClient_IsAppliedDropRateBuffSiege2024ByRegionKey(regionKey) == true then
          currentNodeBuffPercent = currentNodeBuffPercent * ToClient_getNodeIncreaseItemDropOccupyMinorSiegePercent() / 1000000
        end
      end
      local percent
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODEMANAGEMENT_TOOLTIP", "percent", currentNodeBuffPercent)
      local huntingGroundNameList = ToClient_getHuntingGroundNameByWaypointKey(nodeKey)
      if huntingGroundNameList ~= "" then
        desc = desc .. [[


]] .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_DROPRATETOOLTIP_DESC_2", "name", huntingGroundNameList)
      end
      self._currentNodeData._tooltipDesc = desc
      Panel_Worldmap_NodeManagement:registerPadEvent(__eConsoleUIPadEvent_X, "PaGlobal_WorldMap_NodeManagement_ShowTooltip()")
      self._ui._static_ToolTip:SetShow(true)
      self._ui._button_Contribute:SetCheck(true)
      if true == isWithdrawablePlant(nodeKey) then
        self._ui._button_Contribute:SetText(PAGetString(Defines.StringSheet_RESOURCE, "WORLDMAP_NODE_BTN_WITHDRAW"))
        self._ui.txt_ContributeValue:SetText(needPoint)
        self._ui._button_Contribute:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldMap_NodeManagement_TakeContribute( " .. tostring(nodeKey) .. ")")
      else
        self._ui._button_Contribute:SetText(PAGetString(Defines.StringSheet_RESOURCE, "WORLDMAP_NODE_BTN_WITHDRAW"))
        self._ui.txt_ContributeValue:SetText(needPoint)
        self._ui._button_Contribute:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldMap_NodeManagement_ShowReason(" .. tostring(nodeKey) .. ")")
      end
    end
  else
    self._ui._button_Contribute:SetTextHorizonCenter()
    self._ui._button_Contribute:SetText(PAGetString(Defines.StringSheet_RESOURCE, "WORLDMAP_NODE_BTN_NEARNODE"))
    self._ui.txt_ContributeValue:SetShow(false)
    self._ui._staticText_ContributeTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "WORLDMAP_NODE_BTN_NEARNODE"))
    self._ui._staticText_ContributeDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_NODENOTUPGRADE"))
    self._ui._button_Contribute:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldMap_NodeManagement_NearNodeClick(" .. tostring(nodeKey) .. ")")
  end
end
function Window_WorldMap_NodeManagementInfo:SetEnergyInvest()
  if nil == self._currentNodeData then
    return
  end
  local nodeKey = self._currentNodeData._wayPointKey
  local isPurchased = self._currentNodeData._isPurchased
  local isPurchased = self._currentNodeData._isPurchased
  if true == isExploreUpgradable(nodeKey) then
    if isPurchased == false then
      self._ui._button_EnergyInvest:SetMonoTone(true)
      self._ui._button_EnergyInvest:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldMap_NodeManagement_Update()")
    else
      self._ui._button_EnergyInvest:SetMonoTone(false)
      self._ui._button_EnergyInvest:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldMap_NodeManagement_InvestNodeLevelNumpad(" .. tostring(nodeKey) .. ")")
    end
  else
    self._ui._button_EnergyInvest:SetMonoTone(true)
    self._ui._button_EnergyInvest:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldMap_NodeManagement_Update()")
  end
end
function PaGlobalFunc_WorldMap_NodeManagement_Update()
  local self = Window_WorldMap_NodeManagementInfo
  Window_WorldMap_NodeManagementInfo:Update()
  for i = 0, self._currentSubNodeIndex - 1 do
    self._ui._list2_SubNode:requestUpdateByKey(toInt64(0, i))
  end
end
function Window_WorldMap_NodeManagementInfo:Update()
  self:SetExplorePoint()
  self:SetTopTitle()
  self:SetContribute()
  self:SetEnergyInvest()
end
function Window_WorldMap_NodeManagementInfo:SetExplorePoint()
  local contribution = ToClient_getExplorePoint()
  if nil ~= contribution then
    local remainContribution = contribution:getRemainedPoint()
    local aquiredContribution = contribution:getAquiredPoint()
    self._ui._staticText_NodeContributeValue:SetText(tostring(remainContribution) .. " / " .. tostring(aquiredContribution))
    self._ui._staticText_NodeContributeValue:SetSize(self._ui._staticText_NodeContributeValue:GetTextSizeX(), self._ui._staticText_NodeContributeValue:GetTextSizeY())
    self._ui._staticText_NodeContributeValue:SetPosX(self._ui._static_TopBg:GetSizeX() - self._ui._staticText_NodeContributeValue:GetSizeX())
    self._ui._staticText_NodeContributeIcon:SetPosX(self._ui._staticText_NodeContributeValue:GetPosX() - self._ui._staticText_NodeContributeIcon:GetSizeX() - 5)
    self._ui._staticText_NodeContributeTitle:SetPosX(self._ui._staticText_NodeContributeIcon:GetPosX() - self._ui._staticText_NodeContributeTitle:GetSizeX() - 25)
  end
end
function Window_WorldMap_NodeManagementInfo:CreateNodeIcon(control, nodeType)
  local iconUV = self._subNodeIconUV[nodeType]
  if nil == iconUV then
    return
  end
  control:ChangeTextureInfoNameAsync(self._subNodeIconTexture)
  control:getBaseTexture():setUV(setTextureUV_Func(control, iconUV._x1, iconUV._y1, iconUV._x2, iconUV._y2))
  control:setRenderTexture(control:getBaseTexture())
end
function Window_WorldMap_NodeManagementInfo:SetNodeData(nodeData)
  self._ui._list2_SubNode:getElementManager():clearKey()
  self._currentSubNodeIndex = 0
  self._subNodeInfoList = {}
  self._currentNodeData = {}
  self._currentNodeData._nodeSS = nodeData:getStaticStatus()
  self._currentNodeData._plantKey = nodeData:getPlantKey()
  self._currentNodeData._wayPointKey = self._currentNodeData._plantKey:getWaypointKey()
  self._currentNodeData._territoryKeyRaw = getNodeTerritoryKeyRaw(nodeData:getStaticStatus())
  self._currentNodeData._territoryInfo = getNodeTerritoryInfo(nodeData:getStaticStatus())
  self._currentNodeData._isPurchased = nodeData:isPurchased()
  self._currentNodeData._isPurchased = nodeData:isPurchased()
  self._isMaxSubNode = false
  ToClient_FindSubNode(nodeData:getPlantKey())
end
function Window_WorldMap_NodeManagementInfo:InitControl()
  self._ui._staticText_NodeName = UI.getChildControl(self._ui._static_TopBg, "StaticText_NodeName")
  self._ui._staticText_NodeNpcTitle = UI.getChildControl(self._ui._static_TopBg, "StaticText_NodeNpcTitle")
  self._ui._staticText_NodeNpcTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_NODE_MANAGER"))
  self._ui._staticText_NodeNpcValue = UI.getChildControl(self._ui._static_TopBg, "StaticText_NodeNpcValue")
  self._ui._staticText_NodeContributeTitle = UI.getChildControl(self._ui._static_TopBg, "StaticText_NodeContributeTitle")
  self._ui._staticText_NodeContributeIcon = UI.getChildControl(self._ui._static_TopBg, "StaticText_NodeContributeIcon")
  self._ui._staticText_NodeContributeValue = UI.getChildControl(self._ui._static_TopBg, "StaticText_NodeContributeValue")
  self._ui._staticText_ContributeTitle = UI.getChildControl(self._ui._static_NodeManagementBg, "StaticText_Title")
  self._ui._staticText_ContributeDesc = UI.getChildControl(self._ui._static_NodeManagementBg, "StaticText_Desc")
  self._ui._staticText_ContributeDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._staticText_ContributeDesc:SetText(self._ui._staticText_ContributeDesc:GetText())
  self._ui._button_Contribute = UI.getChildControl(self._ui._static_NodeManagementBg, "Button_Contribute")
  self._ui._button_Contribute:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_ContributeValue = UI.getChildControl(self._ui._button_Contribute, "StaticText_ContributePoint")
  self._ui._staticText_NodeTitle = UI.getChildControl(self._ui._static_NodeInvestmentBg, "StaticText_Title")
  self._ui._staticText_NodeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_2"))
  self._ui._staticText_NodeDesc = UI.getChildControl(self._ui._static_NodeInvestmentBg, "StaticText_Desc")
  self._ui._staticText_NodeDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._staticText_NodeDesc:SetText(self._ui._staticText_NodeDesc:GetText())
  local bgSizeY = self._ui._static_NodeInvestmentBg:GetSizeY()
  local sizeY = self._ui._staticText_NodeDesc:GetPosY() + self._ui._staticText_NodeDesc:GetTextSizeY()
  if bgSizeY < sizeY then
    self._ui._static_NodeInvestmentBg:SetSize(self._ui._static_NodeInvestmentBg:GetSizeX(), sizeY)
    self._ui._static_NodeInvestmentBg:ComputePosAllChild()
    Panel_Worldmap_NodeManagement:SetSize(Panel_Worldmap_NodeManagement:GetSizeX(), Panel_Worldmap_NodeManagement:GetSizeY() + sizeY - bgSizeY)
    local defaultSpanSize = self._ui._static_SubNodeBg:GetSpanSize()
    self._ui._static_SubNodeBg:SetSpanSize(defaultSpanSize.x, defaultSpanSize.y + sizeY - bgSizeY)
  end
  self._ui._staticText_NodeDesc:SetText(self._ui._staticText_NodeDesc:GetText())
  self._ui._button_EnergyInvest = UI.getChildControl(self._ui._static_NodeInvestmentBg, "Button_Invest")
  self._ui._button_EnergyInvest:SetTextMode(__eTextMode_AutoWrap)
  self._ui._button_EnergyInvest:SetText(self._ui._button_EnergyInvest:GetText())
  self._ui._staticText_SubNodeTitle = UI.getChildControl(self._ui._static_SubNodeBg, "StaticText_Title")
  self._ui._staticText_SubNodeDesc = UI.getChildControl(self._ui._static_SubNodeBg, "StaticText_Desc")
  self._ui._staticText_SubNodeDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._staticText_SubNodeDesc:SetText(self._ui._staticText_SubNodeDesc:GetText())
  self._ui._list2_SubNode = UI.getChildControl(self._ui._static_SubNodeBg, "List2_SubNode")
  self._config._defaultPanelSizeY = Panel_Worldmap_NodeManagement:GetSizeY()
  self._config._defaultPanelPosY = Panel_Worldmap_NodeManagement:GetPosY()
  self._ui._static_Confirm = UI.getChildControl(self._ui._static_BottomBg, "StaticText_A_ConsoleUI")
  self._ui._static_Exit = UI.getChildControl(self._ui._static_BottomBg, "StaticText_B_ConsoleUI")
  self._ui._static_ToolTip = UI.getChildControl(self._ui._static_BottomBg, "StaticText_X_ConsoleUI")
  self._ui._stc_NodeProduct = UI.getChildControl(Panel_Worldmap_NodeManagement, "Static_ProductBg")
  self._ui._stcTxt_NodeProductTitle = UI.getChildControl(self._ui._stc_NodeProduct, "StaticText_Title")
  self._ui._stc_NodeProductDesc = UI.getChildControl(self._ui._stc_NodeProduct, "Static_ProductDesc")
  self._ui._stc_NodeProductTitle_Template = UI.getChildControl(self._ui._stc_NodeProductDesc, "StaticText_ProductNodeTitle")
  self._ui._stc_NodeProductTitle_Template:SetShow(false)
  self._ui._stc_NodeResultTooltip = UI.getChildControl(Panel_Worldmap_NodeManagement, "Static_Tooltip")
  self._ui._stc_NodeResultTooltipTitle = UI.getChildControl(self._ui._stc_NodeResultTooltip, "StaticText_IconName")
  local uIData = PaGlobal_WorldMap_NodeResultTooltip_Initialize(self._ui._stc_NodeResultTooltip, self._nodeResultIconBG, self._nodeResultIcon, self._nodeResultIconName)
  self._nodeResultIconBG = uIData._nodeResultIconBG
  self._nodeResultIcon = uIData._nodeResultIcon
  self._nodeResultIconName = uIData._nodeResultIconName
  self._keyGuideAlign = {
    self._ui._static_ToolTip,
    self._ui._static_Confirm,
    self._ui._static_Exit
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuideAlign, self._ui._static_BottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self._ui._staticText_NodeContributeTitle:SetSize(self._ui._staticText_NodeContributeTitle:GetSizeX(), self._ui._staticText_NodeContributeTitle:GetSizeY())
end
function Window_WorldMap_NodeManagementInfo:InitEvent()
  self._ui._list2_SubNode:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_WorldMap_NodeManagement_List2EventControlCreate")
  self._ui._list2_SubNode:createChildContent(__ePAUIList2ElementManagerType_List)
end
function Window_WorldMap_NodeManagementInfo:InitRegister()
  registerEvent("FromClient_FindSubNode", "PaGlobalFunc_FromCLient_WorldMap_NodeManagement_FindSubNode")
  registerEvent("FromClient_FindSubNodeFinish", "PaGlobalFunc_FromCLient_WorldMap_NodeManagement_FindSubNodeFinish")
  registerEvent("FromClint_EventChangedExplorationNode", "PaGlobalFunc_FromClient_WorldMap_NodeManagement_ChangedExplorationNode")
  registerEvent("FromClint_EventUpdateExplorationNode", "PaGlobalFunc_FromClient_WorldMap_NodeManagement_UpdateExplorationNode")
  registerEvent("FromClient_FillNodeInfo", "PaGlobal_FromClient_ShowInfoNodeMenuPanel")
  registerEvent("FromClint_EventUpdateExplorationNode", "PaGlobal_WorldMap_RefreshWayPoint")
end
function Window_WorldMap_NodeManagementInfo:Initialize()
  self:InitControl()
  self:InitEvent()
  self:InitRegister()
end
function PaGlobal_FromClient_ShowInfoNodeMenuPanel(nodeData)
  local self = Window_WorldMap_NodeManagementInfo
  self:Update()
  local plantKey = nodeData:getPlantKey()
  local isPurchased = nodeData:isPurchased()
  local isPurchased = nodeData:isPurchased()
  local plantKeyActual = plantKey:get()
  if isPurchased == true then
    for _, param in pairs(CppEnums.MiniGameParam) do
      if plantKeyActual == param then
        FGlobal_MiniGame_RequestPlantInvest(plantKeyActual)
      end
    end
  end
end
function PaGlobalFunc_FromClient_WorldMap_NodeManagement_ChangedExplorationNode()
  local self = Window_WorldMap_NodeManagementInfo
  if nil ~= self._deleteNodeKey then
    ToClient_WorldMapRequestWithdrawPlant(self._deleteNodeKey)
    self._deleteNodeKey = nil
  end
  local nodeData = self._currentWorldNode
  if nil == nodeData then
    return
  end
  self:SetNodeData(nodeData)
  self:Update()
  local plantKey = nodeData:getPlantKey()
  local isPurchased = nodeData:isPurchased()
  local plantKeyActual = plantKey:get()
  if isPurchased == true then
    for _, param in pairs(CppEnums.MiniGameParam) do
      if plantKeyActual == param then
        FGlobal_MiniGame_RequestPlantInvest(plantKeyActual)
      end
    end
  end
end
function PaGlobalFunc_FromClient_WorldMap_NodeManagement_UpdateExplorationNode()
  local self = Window_WorldMap_NodeManagementInfo
  local isCanDelete = false
  if self._lastKey == nil then
    isCanDelete = true
  elseif isWithdrawablePlant(self._lastKey) == false then
    isCanDelete = true
  end
  if self._deleteNodeKey ~= nil and isCanDelete == true then
    ToClient_WorldMapRequestWithdrawPlant(self._deleteNodeKey)
    self._deleteNodeKey = nil
    self._lastKey = nil
  end
  local nodeData = self._currentWorldNode
  if nil == nodeData then
    return
  end
  self:SetNodeData(nodeData)
  self:Update()
  local plantKey = nodeData:getPlantKey()
  local isPurchased = nodeData:isPurchased()
  local plantKeyActual = plantKey:get()
  if isPurchased == true then
    for _, param in pairs(CppEnums.MiniGameParam) do
      if plantKeyActual == param then
        FGlobal_MiniGame_RequestPlantInvest(plantKeyActual)
      end
    end
  end
end
function PaGlobalFunc_WorldMap_ProductNodeInfoTooltip_Show()
  local self = Window_WorldMap_NodeManagementInfo
  for nodeTitleIdx = 1, #self._productNodeTitle do
    if nil ~= self._productNodeTitle[nodeTitleIdx] then
      UI.deleteControl(self._productNodeTitle[nodeTitleIdx])
    end
  end
  self._productNodeTitle = {}
  local isSatellitePlantExist = false
  local satelliteExplorationList = self._currentWorldNode:getSatelliteExplorationList()
  for idx = 0, #satelliteExplorationList do
    local explorationSS = satelliteExplorationList[idx]
    if PaGlobalFunc_WorldMap_ProductNodeInfoTooltip_SetProductTitle(explorationSS) == true then
      isSatellitePlantExist = true
    end
  end
  if isSatellitePlantExist == true then
    local productDescSizeY = 0
    for idx2 = 1, #self._productNodeTitle do
      productDescSizeY = productDescSizeY + self._productNodeTitle[idx2]:GetTextSizeY() + 5
    end
    self._ui._stc_NodeProductDesc:SetSize(self._ui._stc_NodeProduct:GetSizeX(), productDescSizeY + 15)
    self._ui._stc_NodeProduct:SetSize(self._ui._stc_NodeProduct:GetSizeX(), self._ui._stc_NodeProductDesc:GetSizeY() + self._ui._stcTxt_NodeProductTitle:GetTextSizeY() + 15)
    local pos = {
      x = Panel_Worldmap_NodeManagement:GetSizeX(),
      y = Panel_Worldmap_NodeManagement:GetSizeY() - self._ui._stc_NodeProduct:GetSizeY() - 5
    }
    self._ui._stc_NodeProduct:SetPosXY(pos.x, pos.y)
  end
  self._ui._stc_NodeProduct:SetShow(isSatellitePlantExist)
end
function PaGlobalFunc_WorldMap_ProductNodeInfoTooltip_Close()
  local self = Window_WorldMap_NodeManagementInfo
  self._ui._stc_NodeProduct:SetShow(false)
end
function PaGlobalFunc_WorldMap_ProductNodeInfoTooltip_SetProductTitle(explorationSS)
  local self = Window_WorldMap_NodeManagementInfo
  if explorationSS == nil then
    return false
  end
  local satellitePlantKey = ToClient_convertWaypointKeyToPlantKey(explorationSS._waypointKey)
  local satellitePlant = getPlant(satellitePlantKey)
  if satellitePlant == nil or satellitePlant:getType() ~= CppEnums.PlantType.ePlantType_Zone then
    return false
  end
  local satellitePlantWorkListCount = ToClinet_getPlantWorkListCount(explorationSS._waypointKey, 0)
  if satellitePlantWorkListCount <= 0 then
    return false
  end
  local satelliteItemExchangeSourceSS = ToClient_getPlantWorkableItemExchangeByIndex(satellitePlantKey, 0)
  if satelliteItemExchangeSourceSS == nil then
    return false
  end
  local satelliteDropGroupCount = satelliteItemExchangeSourceSS:getDropGroupCount()
  if satelliteDropGroupCount <= 0 then
    return false
  end
  local nextUIIdx = #self._productNodeTitle + 1
  self._productNodeTitle[nextUIIdx] = UI.createControl(__ePAUIControl_StaticText, self._ui._stc_NodeProductDesc, "StaticText_ProductNodeTitle_" .. tostring(nextUIIdx))
  CopyBaseProperty(self._ui._stc_NodeProductTitle_Template, self._productNodeTitle[nextUIIdx])
  self._productNodeTitle[nextUIIdx]:SetShow(true)
  if nextUIIdx > 1 then
    local previousIdx = nextUIIdx - 1
    local previousTitle = self._productNodeTitle[previousIdx]
    local currentPosY = previousTitle:GetPosY() + previousTitle:GetTextSizeY() + 5
    self._productNodeTitle[nextUIIdx]:SetPosY(currentPosY)
  end
  local productNodeName = explorationSS:getName()
  local productNodeInfo = productNodeName .. "(" .. tostring(explorationSS._needPoint) .. ") : "
  for idx = 1, satelliteDropGroupCount do
    local itemGroupValue = satelliteItemExchangeSourceSS:getDropGroupByIndex(idx - 1)
    if itemGroupValue ~= nil then
      local itemSS = itemGroupValue:getItemStaticStatus()
      local itemName = getItemName(itemSS)
      if idx == satelliteDropGroupCount then
        productNodeInfo = productNodeInfo .. itemName
      else
        productNodeInfo = productNodeInfo .. itemName .. ", "
      end
    end
  end
  self._productNodeTitle[nextUIIdx]:SetTextMode(__eTextMode_AutoWrap)
  self._productNodeTitle[nextUIIdx]:SetText(productNodeInfo)
  self._productNodeTitle[nextUIIdx]:SetTextVerticalTop()
  return true
end
function PaGlobalFunc_WorldMap_NodeResultTooltip_Show(waypointKey)
  local self = Window_WorldMap_NodeManagementInfo
  local exploreLevel = ToClient_GetNodeLevel(waypointKey)
  local plantKey = ToClient_convertWaypointKeyToPlantKey(waypointKey)
  local plant = getPlant(plantKey)
  local nodeName = ToClient_GetNodeNameByWaypointKey(waypointKey)
  self._ui._stc_NodeResultTooltipTitle:SetText(nodeName)
  if exploreLevel < 0 or plant == nil or plant:getType() ~= CppEnums.PlantType.ePlantType_Zone then
    return
  end
  local workCnt = ToClinet_getPlantWorkListCount(waypointKey, 0)
  if workCnt == 0 then
    return
  end
  local itemExchangeSourceSS = ToClient_getPlantWorkableItemExchangeByIndex(plantKey, 0)
  PaGlobalFunc_ShowNodeResultTooltip(itemExchangeSourceSS, self._nodeResultIconBG, self._nodeResultIcon, self._nodeResultIconName)
  PaGlobalFunc_WorldMap_setAdjustSizeDropGroupTooltip(itemExchangeSourceSS:getDropGroupCount())
  local pos = {
    x = Panel_Worldmap_NodeManagement:GetSizeX(),
    y = Panel_Worldmap_NodeManagement:GetSizeY() - self._ui._stc_NodeResultTooltip:GetSizeY()
  }
  self._ui._stc_NodeResultTooltip:SetPosXY(pos.x, pos.y)
  self._ui._stc_NodeResultTooltip:SetShow(true)
end
function PaGlobalFunc_WorldMap_NodeResultTooltip_Close()
  local self = Window_WorldMap_NodeManagementInfo
  self._ui._stc_NodeResultTooltip:SetShow(false)
end
function PaGlobalFunc_WorldMap_setAdjustSizeDropGroupTooltip(dropGroupCount)
  if -1 == dropGroupCount then
    _PA_ASSERT(false, "getDropGroupCount()\236\157\152 \234\176\146\236\157\180 \236\158\152\235\170\187\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    return
  end
  local self = Window_WorldMap_NodeManagementInfo
  local nodeIconNameTotalSizeX = self._ui._stc_NodeResultTooltipTitle:GetPosX() + self._ui._stc_NodeResultTooltipTitle:GetTextSizeX()
  local nodeIconNameTotalSizeY = self._ui._stc_NodeResultTooltipTitle:GetSizeY()
  local longestTextControl = PaGlobalFunc_FindLongestTextControl(self._nodeResultIconName)
  local longestTextControlTotalSizeX = longestTextControl:GetPosX() + longestTextControl:GetTextSizeX()
  local totalTooltipSizeX = 0
  local totalTooltipSizeY = 0
  if nodeIconNameTotalSizeX <= longestTextControlTotalSizeX then
    totalTooltipSizeX = longestTextControlTotalSizeX
  else
    totalTooltipSizeX = nodeIconNameTotalSizeX
  end
  totalTooltipSizeY = totalTooltipSizeY + self._ui._stc_NodeResultTooltipTitle:GetPosY() + self._ui._stc_NodeResultTooltipTitle:GetTextSizeY()
  for ii = 1, dropGroupCount do
    totalTooltipSizeY = totalTooltipSizeY + self._nodeResultIconName[ii]:GetSizeY() + 1
  end
  local sizeGap = 10
  self._ui._stc_NodeResultTooltip:SetSize(totalTooltipSizeX + sizeGap, totalTooltipSizeY + sizeGap * dropGroupCount + 10)
end
function PaGlobalFunc_WorldMap_NodeManagement_SwitchNodeResultTooltip(isShowProductNodeInfo, nodeKey)
  if isShowProductNodeInfo == true then
    PaGlobalFunc_WorldMap_NodeResultTooltip_Close()
    PaGlobalFunc_WorldMap_ProductNodeInfoTooltip_Show()
  else
    PaGlobalFunc_WorldMap_NodeResultTooltip_Show(nodeKey)
    PaGlobalFunc_WorldMap_ProductNodeInfoTooltip_Close()
  end
end
function PaGlobalFunc_WorldMap_NodeManagement_List2EventControlCreate(list_content, key)
  local self = Window_WorldMap_NodeManagementInfo
  local id = Int64toInt32(key)
  local nodeInfo = self._subNodeInfoList[id]
  if nil == nodeInfo then
    _PA_LOG("\236\157\180\237\152\184\236\132\156", "\235\133\184\235\147\156 \236\160\149\235\179\180\234\176\128 \236\157\180\236\131\129\237\149\169\235\139\136\235\139\164.")
    return
  end
  local bg = UI.getChildControl(list_content, "Static_Bg")
  bg:SetPosX(35)
  local nodeName = UI.getChildControl(list_content, "StaticText_SubNodeType")
  local nodeIcon = UI.getChildControl(list_content, "Static_NodeTypeIcon")
  local button = UI.getChildControl(list_content, "Button_Invest")
  local energyValue = UI.getChildControl(button, "StaticText_ContributePoint")
  nodeName:SetText(nodeInfo._name)
  energyValue:SetText(nodeInfo._needPoint)
  local nodeKey = nodeInfo._wayPointKey
  local nodeStaticStatus = nodeInfo._nodeSS
  local isPurchased = nodeInfo._isPurchased
  local needPoint = nodeStaticStatus._needPoint
  local isPurchased = nodeInfo._isPurchased
  local parentNodeKey = self._currentNodeData._wayPointKey
  local parentIsPurchased = self._currentNodeData._isPurchased
  local parentIsPurchased = self._currentNodeData._isPurchased
  PaGlobalFunc_WorldMap_NodeResultTooltip_Close()
  PaGlobalFunc_WorldMap_ProductNodeInfoTooltip_Show()
  button:SetCheck(false)
  button:SetIgnore(true)
  button:addInputEvent("Mouse_On", "PaGlobalFunc_WorldMap_NodeManagement_SwitchNodeResultTooltip(false, " .. tostring(nodeKey) .. ")")
  button:addInputEvent("Mouse_Out", "PaGlobalFunc_WorldMap_NodeManagement_SwitchNodeResultTooltip(true, nil)")
  if true == isExploreUpgradable(parentNodeKey) then
    if false == parentIsPurchased then
      button:SetMonoTone(true)
      button:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_NODE_INVEST_TITLE"))
      button:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldMap_NodeManagement_Update")
    else
      button:SetIgnore(false)
      if false == isPurchased then
        button:SetMonoTone(false)
        button:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_NODE_INVEST_TITLE"))
        button:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldMap_NodeManagement_NodeUpgradeClick(" .. tostring(nodeKey) .. ")")
      else
        button:SetCheck(true)
        if true == isWithdrawablePlant(nodeKey) then
          button:SetText(PAGetString(Defines.StringSheet_RESOURCE, "WORLDMAP_NODE_BTN_WITHDRAW"))
          button:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldMap_NodeManagement_TakeContribute( " .. tostring(nodeKey) .. ")")
          self._isMaxSubNode = true
        else
          button:SetText(PAGetString(Defines.StringSheet_RESOURCE, "WORLDMAP_NODE_BTN_WITHDRAW"))
          button:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldMap_NodeManagement_ShowReason()")
        end
      end
    end
  else
    button:SetMonoTone(true)
    button:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_NODE_INVEST_TITLE"))
    button:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldMap_NodeManagement_Update")
  end
  self:CreateNodeIcon(nodeIcon, nodeInfo._nodeType)
end
function PaGlobalFunc_WorldMap_NodeManagement_ShowReason()
  if true == Window_WorldMap_NodeManagementInfo._isMaxSubNode then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_XBOX_WORLDMAP_CANTRETURN_CONT_NODE"))
    PaGlobalFunc_WorldMap_NodeManagement_Update()
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_XBOX_WORLDMAP_CANTRETURN_CONT_NODE"))
  PaGlobalFunc_WorldMap_NodeManagement_Update()
end
function PaGlobalFunc_WorldMap_NodeManagement_InvestNodeLevelNumpad(wayPointKey)
  if false == ToClient_WorldMapIsShow() then
    return
  end
  if _ContentsGroup_UseCharacterWp == true and PaGlobalFunc_UseCharacterWp_All_Open ~= nil then
    PaGlobalFunc_UseCharacterWp_All_Open(PaGlobal_UseCharacterWp_All._openType._investNode, wayPointKey)
  else
    PaGlobalFunc_WorldMap_NodeLevel_Show(PaGlobalFunc_WorldMap_NodeManagement_ShowNumberPad, wayPointKey)
  end
end
function PaGlobalFunc_WorldMap_NodeManagement_ShowNumberPad(wayPointKey, characterIdx, wp)
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  local wpCalc = math.floor(ToClient_getWpInCharacterDataList(characterIdx) / 10)
  local s64_maxNumber = tonumber64(wpCalc)
  Panel_NumberPad_Show(true, s64_maxNumber, wayPointKey, PaGlobalFunc_WorldMap_NodeManagement_InvestNodeLevelExecute, false, characterIdx)
end
function PaGlobalFunc_WorldMap_NodeManagement_InvestNodeLevelExecute(inputNumber, param1, param2)
  local wpCount = Int64toInt32(inputNumber) * 10
  local nodeName = ToClient_GetNodeNameByWaypointKey(param1)
  local function InvestNodeLevelFunc()
    ToClient_RequestIncreaseExperienceNodeByCharacterIndex(param1, param2, wpCount)
  end
  local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NODELEVEL_CONFIRM", "regionName", nodeName, "energy", wpCount)
  local messageBoxData = {
    title = "",
    content = messageBoxMemo,
    functionYes = InvestNodeLevelFunc,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_WorldMap_NodeManagement_TakeContribute(nodeKey)
  local self = Window_WorldMap_NodeManagementInfo
  local function NodeWithdrawExecute()
    _AudioPostEvent_SystemUiForXBOX(50, 1)
    ToClient_WorldMapRequestWithdrawPlant(nodeKey)
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_WORLDMAP_NODE_WITHDRAWCONFIRM")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = NodeWithdrawExecute,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "top")
  PaGlobalFunc_WorldMap_NodeManagement_Update()
end
function PaGlobalFunc_WorldMap_NodeManagement_TakeAll(nodeData)
  local self = Window_WorldMap_NodeManagementInfo
  self:SetNodeData(nodeData)
  PaGlobal_ConsoleWorldMapKeyGuide_SetShow(false)
  PaGlobalFunc_WorldMap_TopMenu_Close()
  PaGlobalFunc_WorldMap_BottomMenu_Close()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_WORLDMAP_NODE_WITHDRAWCONFIRM")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = PaGlobalFunc_WorldMap_NodeManagement_TakeAllContinue,
    functionNo = PaGlobalFunc_WorldMap_NodeManagement_TakeAllCancel,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "top")
  ToClient_SetIsIgnoreLStick(true)
end
function PaGlobalFunc_WorldMap_NodeManagement_TakeAllContinue()
  local self = Window_WorldMap_NodeManagementInfo
  local parentTakeAble = true
  for index = 0, self._currentSubNodeIndex - 1 do
    if true == isWithdrawablePlant(self._subNodeInfoList[index]._wayPointKey) then
      ToClient_WorldMapRequestWithdrawPlant(self._subNodeInfoList[index]._wayPointKey)
      self._lastKey = self._subNodeInfoList[index]._wayPointKey
      parentTakeAble = false
    end
  end
  self._deleteNodeKey = self._currentNodeData._wayPointKey
  if true == parentTakeAble then
    ToClient_WorldMapRequestWithdrawPlant(self._deleteNodeKey)
    self._deleteNodeKey = nil
  end
  PaGlobalFunc_WorldMap_TopMenu_Open()
  PaGlobalFunc_WorldMap_BottomMenu_Open()
  PaGlobal_ConsoleWorldMapKeyGuide_SetShow(true)
  ToClient_SetIsIgnoreLStick(false)
end
function PaGlobalFunc_WorldMap_NodeManagement_TakeAllCancel()
  PaGlobalFunc_WorldMap_TopMenu_Open()
  PaGlobalFunc_WorldMap_BottomMenu_Open()
  PaGlobal_ConsoleWorldMapKeyGuide_SetShow(true)
  ToClient_SetIsIgnoreLStick(false)
  FGlobal_Plant_WorkManager_ReOpen()
end
function PaGlobalFunc_WorldMap_NodeManagement_NearNodeClick(nodeKey)
  ToClient_DeleteNaviGuideByGroup(0)
  ToClient_WorldMapFindNearNode(nodeKey, NavigationGuideParam())
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  PaGlobalFunc_SetLastFindNodeKey(nodeKey)
end
function PaGlobalFunc_WorldMap_NodeManagement_NodeUpgradeClick(nodeKey)
  local self = Window_WorldMap_NodeManagementInfo
  if false == ToClient_isAbleInvestnWithdraw(nodeKey) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "PANEL_WORLDMAP_FINDNODEMANAGER"))
    PaGlobalFunc_WorldMap_NodeManagement_Update()
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  ToClient_WorldMapRequestUpgradeExplorationNode(nodeKey)
  PaGlobalFunc_WorldMap_NodeManagement_Update()
end
function PaGlobalFunc_FromCLient_WorldMap_NodeManagement_FindSubNode(explorationNodeInClient)
  local self = Window_WorldMap_NodeManagementInfo
  self._subNodeInfoList[self._currentSubNodeIndex] = {}
  self._subNodeInfoList[self._currentSubNodeIndex]._explorationNodeInClient = explorationNodeInClient
  self._subNodeInfoList[self._currentSubNodeIndex]._nodeSS = explorationNodeInClient:getStaticStatus()
  self._subNodeInfoList[self._currentSubNodeIndex]._plantKey = explorationNodeInClient:getPlantKey()
  self._subNodeInfoList[self._currentSubNodeIndex]._wayPointKey = explorationNodeInClient:getPlantKey():getWaypointKey()
  self._subNodeInfoList[self._currentSubNodeIndex]._name = getExploreNodeName(explorationNodeInClient:getStaticStatus())
  self._subNodeInfoList[self._currentSubNodeIndex]._needPoint = explorationNodeInClient:getStaticStatus()._needPoint
  self._subNodeInfoList[self._currentSubNodeIndex]._isMaxLevel = explorationNodeInClient:isMaxLevel()
  self._subNodeInfoList[self._currentSubNodeIndex]._isPurchased = explorationNodeInClient:isPurchased()
  self._subNodeInfoList[self._currentSubNodeIndex]._nodeType = explorationNodeInClient:getStaticStatus()._nodeType
  self._subNodeInfoList[self._currentSubNodeIndex]._isPurchased = explorationNodeInClient:isPurchased()
  if true == PaGlobalFunc_WorldMap_NodeManagement_GetShow() then
    self._ui._list2_SubNode:getElementManager():pushKey(toInt64(0, self._currentSubNodeIndex))
    self._ui._list2_SubNode:requestUpdateByKey(toInt64(0, self._currentSubNodeIndex))
  end
  self._currentSubNodeIndex = self._currentSubNodeIndex + 1
end
function PaGlobalFunc_FromCLient_WorldMap_NodeManagement_FindSubNodeFinish()
  local self = Window_WorldMap_NodeManagementInfo
  if self._isTown == true and self._currentSubNodeIndex <= 0 then
    self:SetTownManagementUI()
  else
    self:SetNoneTownManagementUI()
  end
end
function PaGlobalFunc_WorldMap_NodeManagement_GetShow()
  return Panel_Worldmap_NodeManagement:GetShow()
end
function PaGlobalFunc_WorldMap_NodeManagement_SetShow(isShow, isAni)
  Panel_Worldmap_NodeManagement:SetShow(isShow, isAni)
end
function PaGlobalFunc_WorldMap_NodeManagement_Open(nodeData)
  local self = Window_WorldMap_NodeManagementInfo
  if true == PaGlobalFunc_WorldMap_NodeManagement_GetShow() then
    return
  end
  if nil == nodeData then
    _PA_ASSERT(false, "WorldMap NodeInfo\236\151\144 nodeData\235\138\148 \237\149\132\236\136\152 \236\158\133\235\139\136\235\139\164.")
    return
  end
  PaGlobalFunc_WorldMap_NodeManagement_SetShow(true, false)
  local isTown = nodeData:getStaticStatus():getRegion():isMainOrMinorTown()
  local hasNeed = nodeData:getStaticStatus():hasNeed()
  self._isTown = true == isTown and false == hasNeed
  self._currentWorldNode = nodeData
  PaGlobalFunc_WorldMap_RingMenu_Close()
  self:SetNodeData(nodeData)
  self:Update()
  PaGlobalFunc_WorldMap_TopMenu_Close()
  PaGlobalFunc_WorldMap_BottomMenu_Close()
  PaGlobalFunc_WorldMap_ProductNodeInfoTooltip_Close()
  PaGlobalFunc_WorldMap_NodeResultTooltip_Close()
end
function PaGlobalFunc_WorldMap_NodeManagement_Close()
  if false == PaGlobalFunc_WorldMap_NodeManagement_GetShow() then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  PaGlobalFunc_WorldMap_TopMenu_Open()
  PaGlobalFunc_WorldMap_RingMenu_Open()
  PaGlobalFunc_WorldMap_BottomMenu_Open()
  PaGlobalFunc_WorldMap_NodeManagement_SetShow(false, false)
  TooltipSimple_Hide()
end
function PaGlobalFunc_FromClient_WorldMap_NodeManagement_luaLoadComplete()
  local self = Window_WorldMap_NodeManagementInfo
  self:Initialize()
end
function PaGlobalFunc_SetLastFindNodeKey(nodeKey)
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  lastFindNodeKey = nodeKey
end
function PaGlobal_WorldMap_RefreshWayPoint()
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  if nil == lastFindNodeKey then
    return
  end
  if false == ToClient_WorldMapIsShow() then
    return
  end
  ToClient_DeleteNaviGuideByGroup(0)
  ToClient_WorldMapFindNearNode(lastFindNodeKey, NavigationGuideParam())
  local isNodeLink = checkSelfplayerNode(lastFindNodeKey, true)
  if true == isNodeLink then
    lastFindNodeKey = nil
  end
end
function PaGlobal_WorldMap_NodeManagement_ShowTooltip()
  if Panel_Tooltip_SimpleText:GetShow() == true then
    TooltipSimple_Hide()
    return
  end
  local pos = {
    x = Panel_Worldmap_NodeManagement:GetParentPosX() + Panel_Worldmap_NodeManagement:GetSizeX(),
    y = Panel_Worldmap_NodeManagement:GetParentPosY()
  }
  TooltipSimple_ShowSetSetPos_Console(pos, "", Window_WorldMap_NodeManagementInfo._currentNodeData._tooltipDesc)
end
registerEvent("FromClient_luaLoadComplete", "PaGlobalFunc_FromClient_WorldMap_NodeManagement_luaLoadComplete")
