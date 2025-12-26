PaGlobal_ItemAcquireHelper = {
  _messageBox = {
    _functionYes = nil,
    _functionNo = nil,
    _functionApply = nil,
    _content = nil
  },
  _cashShop = {_mainTabIndex = nil, _subTabIndex = nil},
  _itemMarket = {_mainCategoryIndex = nil, _subCategoryIndex = nil},
  _spawnType = nil,
  _marketCategoryTable = nil
}
registerEvent("FromClient_luaLoadComplete", "FromClient_ItemAcquireHelper_Init")
function FromClient_ItemAcquireHelper_Init()
  PaGlobal_ItemAcquireHelper:initialize()
end
function PaGlobal_ItemAcquireHelper:initialize()
  self:resetMessageBoxData()
end
function PaGlobal_ItemAcquireHelper:resetMessageBoxData()
  self._messageBox = {
    _functionYes = nil,
    _functionNo = MessageBox_Empty_function,
    _functionApply = nil,
    _content = nil
  }
end
function PaGlobal_ItemAcquireHelper:openMessageBox()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = self._messageBox._content,
    functionYes = self._messageBox._functionYes,
    functionNo = self._messageBox._functionNo,
    functionApply = self._messageBox._functionApply,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  self:resetMessageBoxData()
end
function PaGlobal_ItemAcquireHelper_SetCashShopData(mainTabIndex, subTabIndex, description)
  local self = PaGlobal_ItemAcquireHelper
  if ToClient_HardCoreChannelWithContensOption() == true then
    return
  end
  self._cashShop._mainTabIndex = mainTabIndex
  self._cashShop._subTabIndex = subTabIndex
  self._messageBox._functionYes = PaGlobal_ItemAcquireHelper_openCashShop
  self._messageBox._content = description
  self:openMessageBox()
end
function PaGlobal_ItemAcquireHelper_openCashShop()
  local self = PaGlobal_ItemAcquireHelper
  PaGlobal_InGameCashShop_OpenByIndex(self._cashShop._mainTabIndex, self._cashShop._subTabIndex)
end
function PaGlobal_ItemAcquireHelper_SetItemMarketData(mainCategoryIndex, subCategoryIndex, description)
  local self = PaGlobal_ItemAcquireHelper
  if ToClient_HardCoreChannelWithContensOption() == true then
    return
  end
  self._itemMarket._mainCategoryIndex = mainCategoryIndex
  self._itemMarket._subCategoryIndex = subCategoryIndex
  self._messageBox._functionYes = PaGlobal_ItemAcquireHelper_openItemMarket
  self._messageBox._content = description
  self:openMessageBox()
end
function PaGlobal_ItemAcquireHelper_openItemMarket()
  local self = PaGlobal_ItemAcquireHelper
  PaGlobal_ItemMarket_OpenByIndex(self._itemMarket._mainCategoryIndex, self._itemMarket._subCategoryIndex)
end
function PaGlobal_ItemAcquireHelper_SetSpawnType(spawnType, description)
  local self = PaGlobal_ItemAcquireHelper
  if ToClient_HardCoreChannelWithContensOption() == true then
    return
  end
  self._spawnType = spawnType
  self._messageBox._functionYes = PaGlobal_ItemAcquireHelper_StartNavigation
  self._messageBox._content = description
  self:openMessageBox()
end
function PaGlobal_ItemAcquireHelper_StartNavigation()
  local self = PaGlobal_ItemAcquireHelper
  HandleEventLUp_NpcNaviAll_NaviStart(self._spawnType)
end
function PaGlobal_ItemAcquireHelper_ShowOnlyDescription(description)
  local self = PaGlobal_ItemAcquireHelper
  if ToClient_HardCoreChannelWithContensOption() == true then
    return
  end
  self._messageBox._content = description
  self._messageBox._functionNo = nil
  self._messageBox._functionApply = MessageBox_Empty_function
  self:openMessageBox()
end
function PaGlobal_ItemAcquireHelper_OpenBigShipWebHelper(description)
  local self = PaGlobal_ItemAcquireHelper
  self._messageBox._content = description
  self._messageBox._functionYes = PaGlobal_ShipInfo_All_OpenBigShipWebHelper
  self:openMessageBox()
end
function PaGlobal_ItemAcquireHelper_OpenGuildVehicleWebHelper(description)
  local self = PaGlobal_ItemAcquireHelper
  self._messageBox._content = description
  self._messageBox._functionYes = PaGlobal_ShipInfo_All_OpenGuildVehicleWebHelper
  self:openMessageBox()
end
function PaGlobal_Equipment_All_FindItemMarketCategoryIndex(slotNo)
  if nil == getSelfPlayer() then
    return
  end
  local self = PaGlobal_ItemAcquireHelper
  if nil == self._marketCategoryTable then
    self._marketCategoryTable = PaGlobalFunc_getItemMarketCategoryListAndSetUI(nil)
  end
  if self._marketCategoryTable == nil then
    return
  end
  local marketMainIndexFromSheet = 0
  if __eEquipSlotNoRightHand == slotNo then
    marketMainIndexFromSheet = 1
  elseif __eEquipSlotNoLeftHand == slotNo then
    marketMainIndexFromSheet = 5
  elseif __eEquipSlotNoAwakenWeapon == slotNo then
    marketMainIndexFromSheet = 10
  elseif __eEquipSlotNoChest == slotNo or __eEquipSlotNoGlove == slotNo or __eEquipSlotNoBoots == slotNo or __eEquipSlotNoHelm == slotNo then
    marketMainIndexFromSheet = 15
  elseif __eEquipSlotNoNecklace == slotNo or __eEquipSlotNoRing1 == slotNo or __eEquipSlotNoRing2 == slotNo or __eEquipSlotNoEaring1 == slotNo or __eEquipSlotNoEaring2 == slotNo or __eEquipSlotNoBelt == slotNo or __eEquipSlotNoSubTool == slotNo then
    marketMainIndexFromSheet = 20
  elseif __eEquipSlotNoAlchemyStone == slotNo then
    marketMainIndexFromSheet = 45
  end
  local marketSubIndexFromSheet = -1
  local classType = getSelfPlayer():getClassType()
  if __eEquipSlotNoRightHand == slotNo then
    if NewClassData.newClass_CategoryType[classType]._weaponCategory ~= nil then
      marketSubIndexFromSheet = NewClassData.newClass_CategoryType[classType]._weaponCategory
    end
  elseif __eEquipSlotNoLeftHand == slotNo then
    if NewClassData.newClass_CategoryType[classType]._subWeaponCategory ~= nil then
      marketSubIndexFromSheet = NewClassData.newClass_CategoryType[classType]._subWeaponCategory
    end
  elseif __eEquipSlotNoAwakenWeapon == slotNo then
    if NewClassData.newClass_CategoryType[classType]._awakenWeaponCategory ~= nil then
      marketSubIndexFromSheet = NewClassData.newClass_CategoryType[classType]._awakenWeaponCategory
    end
  elseif __eEquipSlotNoHelm == slotNo then
    marketSubIndexFromSheet = 1
  elseif __eEquipSlotNoChest == slotNo then
    marketSubIndexFromSheet = 2
  elseif __eEquipSlotNoGlove == slotNo then
    marketSubIndexFromSheet = 3
  elseif __eEquipSlotNoBoots == slotNo then
    marketSubIndexFromSheet = 4
  elseif __eEquipSlotNoRing1 == slotNo or __eEquipSlotNoRing2 == slotNo then
    marketSubIndexFromSheet = 1
  elseif __eEquipSlotNoNecklace == slotNo then
    marketSubIndexFromSheet = 2
  elseif __eEquipSlotNoEaring1 == slotNo or __eEquipSlotNoEaring2 == slotNo then
    marketSubIndexFromSheet = 3
  elseif __eEquipSlotNoBelt == slotNo then
    marketSubIndexFromSheet = 4
  elseif __eEquipSlotNoAlchemyStone == slotNo then
    marketSubIndexFromSheet = 1
  end
  local mainIndex, subIndex
  for idx = 0, #self._marketCategoryTable do
    if self._marketCategoryTable[idx] ~= nil and marketMainIndexFromSheet == self._marketCategoryTable[idx]._categoryNo then
      if self._marketCategoryTable[idx]._isMain == true then
        mainIndex = idx
      elseif marketSubIndexFromSheet == self._marketCategoryTable[idx]._subCategoryNo then
        subIndex = idx
      end
    end
  end
  return mainIndex, subIndex
end
function PaGlobalFunc_ItemAcquireHelper_FindItemMarketCategoryIndex(marketMainIndexFromSheet, marketSubIndexFromSheet)
  if getSelfPlayer() == nil then
    return
  end
  local self = PaGlobal_ItemAcquireHelper
  if self._marketCategoryTable == nil then
    self._marketCategoryTable = PaGlobalFunc_getItemMarketCategoryListAndSetUI(nil)
  end
  if self._marketCategoryTable == nil then
    return
  end
  local mainIndex, subIndex
  for idx = 0, #self._marketCategoryTable do
    if self._marketCategoryTable[idx] ~= nil and marketMainIndexFromSheet == self._marketCategoryTable[idx]._categoryNo then
      if self._marketCategoryTable[idx]._isMain == true then
        mainIndex = idx
      elseif marketSubIndexFromSheet == self._marketCategoryTable[idx]._subCategoryNo then
        subIndex = idx
      end
    end
  end
  return mainIndex, subIndex
end
function HandleEventLUp_Equipment_All_ItemAcquireHelper(slotNo)
  if nil == slotNo then
    return
  end
  if ToClient_isConsole() == true then
    return
  end
  if Panel_Dialog_Repair_Function_All ~= nil and Panel_Dialog_Repair_Function_All:GetShow() == true then
    return
  end
  if __eEquipSlotNoRightHand == slotNo or __eEquipSlotNoLeftHand == slotNo or __eEquipSlotNoChest == slotNo or __eEquipSlotNoGlove == slotNo or __eEquipSlotNoBoots == slotNo or __eEquipSlotNoHelm == slotNo or __eEquipSlotNoNecklace == slotNo or __eEquipSlotNoRing1 == slotNo or __eEquipSlotNoRing2 == slotNo or __eEquipSlotNoEaring1 == slotNo or __eEquipSlotNoEaring2 == slotNo or __eEquipSlotNoBelt == slotNo or __eEquipSlotNoAlchemyStone == slotNo then
    if ToClient_isConsole() == true then
      return
    end
    local mainCategoryIndex, subCategoryIndex = PaGlobal_Equipment_All_GetItemMarketIndex(slotNo)
    PaGlobal_ItemAcquireHelper_SetItemMarketData(mainCategoryIndex, subCategoryIndex, PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EMPTYSLOT_EQUIP_NORNAL"))
    return
  end
  if __eEquipSlotNoSubTool == slotNo then
    PaGlobal_ItemAcquireHelper_SetSpawnType(CppEnums.SpawnType.eSpawnType_Collect, PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EMPTYSLOT_EQUIP_LIFE"))
    return
  end
  if __eEquipSlotNoAvatarChest == slotNo or __eEquipSlotNoAvatarGlove == slotNo or __eEquipSlotNoAvatarBoots == slotNo or __eEquipSlotNoAvatarHelm == slotNo then
    local mainTabIndex, subTabIndex = PaGlobal_Equipment_All_GetCashShopIndex(slotNo)
    PaGlobal_ItemAcquireHelper_SetCashShopData(mainTabIndex, subTabIndex, PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EMPTYSLOT_CLOTH_NORMAL"))
    return
  end
  if __eEquipSlotNoAvatarWeapon == slotNo or __eEquipSlotNoAvatarSubWeapon == slotNo or __eEquipSlotNoAvatarAwakenWeapon == slotNo or __eEquipSlotNoAvatarUnderwear == slotNo or __eEquipSlotNoAvatarBody == slotNo then
    local mainTabIndex, subTabIndex = PaGlobal_Equipment_All_GetCashShopIndex(slotNo)
    PaGlobal_ItemAcquireHelper_SetCashShopData(mainTabIndex, subTabIndex, PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EMPTYSLOT_CLOTH_WEAPON"))
    return
  end
  if __eEquipSlotNoFaceDecoration1 == slotNo or __eEquipSlotNoFaceDecoration2 == slotNo or __eEquipSlotNoFaceDecoration3 == slotNo or __eEquipSlotNoTemp == slotNo then
    local mainTabIndex, subTabIndex = PaGlobal_Equipment_All_GetCashShopIndex(slotNo)
    PaGlobal_ItemAcquireHelper_SetCashShopData(mainTabIndex, subTabIndex, PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EMPTYSLOT_CLOTH_FACE"))
    return
  end
  if __eEquipSlotNoAwakenWeapon == slotNo then
    if __eClassType_ShyWaman == getSelfPlayer():getClassType() then
      PaGlobal_ItemAcquireHelper_ShowOnlyDescription(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EMPTYSLOT_EQUIP_TALENT"))
      return
    end
    if ToClient_isConsole() == true then
      return
    end
    local mainCategoryIndex, subCategoryIndex = PaGlobal_Equipment_All_GetItemMarketIndex(slotNo)
    PaGlobal_ItemAcquireHelper_SetItemMarketData(mainCategoryIndex, subCategoryIndex, PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EMPTYSLOT_EQUIP_AWAKEN"))
    return
  end
  if __eEquipSlotNoQuestBook == slotNo then
    PaGlobal_ItemAcquireHelper_ShowOnlyDescription(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EMPTYSLOT_BOOK"))
    return
  end
  if __eEquipSlotNoArtifact1 == slotNo or __eEquipSlotNoArtifact2 == slotNo then
    PaGlobal_ItemAcquireHelper_ShowOnlyDescription(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EMPTYSLOT_EQUIP_ARTIFACTS"))
    return
  end
end
function PaGlobal_Equipment_All_GetItemMarketIndex(slotNo)
  local self = PaGlobal_ItemAcquireHelper
  local mainCategoryIndex, subCategoryIndex
  if __eEquipSlotNoRightHand == slotNo or __eEquipSlotNoLeftHand == slotNo or __eEquipSlotNoAwakenWeapon == slotNo or __eEquipSlotNoChest == slotNo or __eEquipSlotNoGlove == slotNo or __eEquipSlotNoBoots == slotNo or __eEquipSlotNoHelm == slotNo or __eEquipSlotNoNecklace == slotNo or __eEquipSlotNoRing1 == slotNo or __eEquipSlotNoRing2 == slotNo or __eEquipSlotNoEaring1 == slotNo or __eEquipSlotNoEaring2 == slotNo or __eEquipSlotNoBelt == slotNo or __eEquipSlotNoAlchemyStone == slotNo then
    mainCategoryIndex, subCategoryIndex = PaGlobal_Equipment_All_FindItemMarketCategoryIndex(slotNo)
  end
  return mainCategoryIndex, subCategoryIndex
end
function PaGlobal_Equipment_All_GetCashShopIndex(slotNo)
  local self = PaGlobal_ItemAcquireHelper
  if __eEquipSlotNoAvatarChest == slotNo or __eEquipSlotNoAvatarGlove == slotNo or __eEquipSlotNoAvatarWeapon == slotNo or __eEquipSlotNoAvatarSubWeapon == slotNo or __eEquipSlotNoAvatarAwakenWeapon == slotNo or __eEquipSlotNoAvatarBoots == slotNo or __eEquipSlotNoAvatarHelm == slotNo then
    return __eInGameCashShopMainTab_Clothes, nil
  end
  if __eEquipSlotNoAvatarUnderwear == slotNo then
    if isGameTypeCH() == true then
      return __eInGameCashShopMainTab_Mileage, nil
    end
    return __eInGameCashShopMainTab_Clothes, __eInGameCashShopSubTab_Underwear
  end
  if __eEquipSlotNoFaceDecoration1 == slotNo or __eEquipSlotNoFaceDecoration2 == slotNo or __eEquipSlotNoFaceDecoration3 == slotNo or __eEquipSlotNoTemp == slotNo then
    return __eInGameCashShopMainTab_Clothes, __eInGameCashShopSubTab_Accessory
  end
end
function PaGlobal_ShipInfo_All_FindItemMarketCategoryIndex(slotNo, vehicleType)
  if nil == getSelfPlayer() then
    return
  end
  local self = PaGlobal_ItemAcquireHelper
  if nil == self._marketCategoryTable then
    self._marketCategoryTable = PaGlobalFunc_getItemMarketCategoryListAndSetUI(nil)
  end
  if self._marketCategoryTable == nil then
    return
  end
  local marketMainIndexFromSheet, marketSubIndexFromSheet
  if PaGlobalFunc_Util_IsBigShip(vehicleType) == true then
    marketMainIndexFromSheet = 70
    if slotNo == __eEquipSlotNoChest then
      marketSubIndexFromSheet = 7
    elseif slotNo == __eEquipSlotNoGlove then
      marketSubIndexFromSheet = 6
    elseif slotNo == __eEquipSlotNoBoots then
      marketSubIndexFromSheet = 8
    elseif slotNo == __eEquipSlotNoBelt then
      marketSubIndexFromSheet = nil
    elseif slotNo == __eEquipSlotNoBody then
      marketSubIndexFromSheet = 9
    elseif slotNo == __eEquipSlotNoNecklace then
      marketMainIndexFromSheet = 40
      marketSubIndexFromSheet = 7
    end
  else
    marketMainIndexFromSheet = 70
    if slotNo == __eEquipSlotNoGlove then
      marketSubIndexFromSheet = 3
    elseif slotNo == __eEquipSlotNoBoots then
      marketSubIndexFromSheet = 2
    elseif slotNo == __eEquipSlotNoHelm then
      marketSubIndexFromSheet = 5
    elseif slotNo == __eEquipSlotNoBody then
      marketSubIndexFromSheet = 4
    end
  end
  UI.ASSERT(marketMainIndexFromSheet ~= nil and marketSubIndexFromSheet ~= nil, "\235\140\128\236\157\145 \235\144\152\236\167\128 \236\149\138\236\157\128 \236\132\160\235\176\149\236\157\152 slotNo\236\158\133\235\139\136\235\139\164. slotNo : " .. slotNo .. ", vehicleType : " .. vehicleType)
  local mainIndex, subIndex
  for idx = 0, #self._marketCategoryTable do
    if self._marketCategoryTable[idx] ~= nil and marketMainIndexFromSheet == self._marketCategoryTable[idx]._categoryNo then
      if self._marketCategoryTable[idx]._isMain == true then
        mainIndex = idx
      elseif marketSubIndexFromSheet == self._marketCategoryTable[idx]._subIndex + 1 then
        subIndex = idx
      end
    end
  end
  return mainIndex, subIndex
end
function PaGlobal_ShipInfo_All_ItemAcquireHelper(slotNo, vehicleType, isCashSlot)
  if ToClient_isConsole() == true then
    return
  end
  if isCashSlot == true then
    PaGlobal_ItemAcquireHelper_SetCashShopData(__eInGameCashShopMainTab_Vehicle, __eInGameCashShopSubTab_Ship, PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEINFO_GOTOPEARLSHOP"))
    return
  elseif PaGlobalFunc_Util_IsBigShip(vehicleType) == true then
    if vehicleType == __eVehicleType_GalleyShip then
      if slotNo == __eEquipSlotNoBelt then
        PaGlobal_ItemAcquireHelper_ShowOnlyDescription(PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEINFO_GALLEYSHIP_EMPLOYEE"))
        return
      end
      PaGlobal_ItemAcquireHelper_OpenGuildVehicleWebHelper(PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEINFO_GALLEYSHIP_MAKE"))
      return
    end
    if slotNo == __eEquipSlotNoBelt then
      PaGlobal_ItemAcquireHelper_ShowOnlyDescription(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_EMPTYEMPLOYEELIST"))
      return
    end
    if vehicleType == __eVehicleType_Carrack or vehicleType == __eVehicleType_PersonalTradeShip or vehicleType == __eVehicleType_PersonalBattleShip then
      if ToClient_isConsole() == true then
        return
      end
      if slotNo == __eEquipSlotNoNecklace then
        local messageboxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
        local messageboxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SHIPINFO_FISHING_EQUIP_MSG")
        local messageboxData = {
          title = messageboxTitle,
          content = messageboxMemo,
          functionApply = MessageBox_Empty_function
        }
        MessageBox.showMessageBox(messageboxData)
      else
        local infoString = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEINFO_GOTOITEMMARKET")
        local mainCategoryIndex, subCategoryIndex = PaGlobal_ShipInfo_All_FindItemMarketCategoryIndex(slotNo, vehicleType)
        PaGlobal_ItemAcquireHelper_SetItemMarketData(mainCategoryIndex, subCategoryIndex, infoString)
      end
    elseif vehicleType == __eVehicleType_CashPersonalTradeShip then
      local messageboxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
      local messageboxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEINFO_EPHERIA_GALLEON_EQUIP")
      local messageboxData = {
        title = messageboxTitle,
        content = messageboxMemo,
        functionApply = MessageBox_Empty_function
      }
      if true == self._isConsole then
        messageboxData.functionApply = SetSnapToList
      end
      MessageBox.showMessageBox(messageboxData)
    elseif vehicleType == __eVehicleType_CashPersonalBattleShip then
      PaGlobal_ItemAcquireHelper_OpenBigShipWebHelper(PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEINFO_PANOKSEON_MAKE"))
    else
      PaGlobal_ItemAcquireHelper_OpenBigShipWebHelper(PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEINFO_BIGSHIP_MAKE"))
    end
  else
    if ToClient_isConsole() == true then
      return
    end
    local mainCategoryIndex, subCategoryIndex = PaGlobal_ShipInfo_All_FindItemMarketCategoryIndex(slotNo, vehicleType)
    PaGlobal_ItemAcquireHelper_SetItemMarketData(mainCategoryIndex, subCategoryIndex, PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEINFO_GOTOITEMMARKET"))
  end
end
function PaGlobalFunc_getItemMarketCategoryListAndSetUI(mainElement)
  local categoryCount = ToClient_GetItemMarketCategoryListCount()
  local keyIdx = 0
  if mainElement ~= nil then
    mainElement:createChild(toInt64(0, 9999))
    mainElement:createChild(toInt64(0, 8999))
  end
  local categoryIndexMap = {}
  categoryIndexMap[9999] = {_isMain = true, _index = 9999}
  categoryIndexMap[8999] = {_isMain = true, _index = 8999}
  if _ContentsGroup_ServantWorldMarket == true then
    if mainElement ~= nil then
      local servantTree = mainElement:createChild(toInt64(0, 9998))
      servantTree:createChild(toInt64(0, 9997))
    end
    categoryIndexMap[9998] = {_isMain = true, _index = 9998}
    categoryIndexMap[9997] = {
      _isMain = false,
      _index = 9998,
      _subIndex = 0
    }
  end
  for mainIdx = 0, categoryCount - 1 do
    local categoryInfo = ToClient_GetItemMarketCategoryAt(mainIdx)
    local mainValue = categoryInfo:getMainCategoryValue()
    categoryIndexMap[keyIdx] = {
      _isMain = true,
      _index = mainIdx,
      _categoryNo = mainValue:getCategoryNo()
    }
    local treeElement
    if mainElement ~= nil then
      treeElement = mainElement:createChild(toInt64(0, keyIdx))
      treeElement:setIsOpen(false)
    end
    keyIdx = keyIdx + 1
    local subCategoryCount = categoryInfo:getSubCategoryListCount()
    for subIdx = 0, subCategoryCount - 1 do
      local subValue = categoryInfo:getSubCategoryAt(subIdx)
      categoryIndexMap[keyIdx] = {
        _isMain = false,
        _index = mainIdx,
        _categoryNo = mainValue:getCategoryNo(),
        _subIndex = subIdx,
        _subCategoryNo = subValue:getCategoryNo()
      }
      if treeElement ~= nil then
        local subTreeElement = treeElement:createChild(toInt64(0, keyIdx))
      end
      keyIdx = keyIdx + 1
    end
  end
  return categoryIndexMap
end
function PaGlobal_ItemMarket_OpenByIndex(mainCategoryIndex, subCategoryIndex)
  if nil ~= mainCategoryIndex then
    PaGlobalFunc_ItemMarket_SetIsEquipmentOpen(true)
    if PaGlobalFunc_MarketPlace_Open(true) == true then
      InputMLUp_ItemMarket_MainCategoryList(mainCategoryIndex)
    end
  end
  if nil ~= subCategoryIndex then
    InputMLUp_ItemMarket_SubCategoryList(subCategoryIndex)
  end
  PaGlobalFunc_ItemMarket_SetIsEquipmentOpen(false)
end
function PaGlobal_ShipInfo_All_OpenBigShipWebHelper()
  Panel_WebHelper_ShowToggle("Carrack_Vehicle")
end
function PaGlobal_ShipInfo_All_OpenGuildVehicleWebHelper()
  Panel_WebHelper_ShowToggle("Guild_Vehicle")
end
