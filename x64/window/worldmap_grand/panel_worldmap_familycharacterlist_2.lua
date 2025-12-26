function PaGlobalFunc_WorldMap_FamilyCharacterList_Open()
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_WorldMap_FamilyCharacterList_Close()
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_WorldMap_FamilyCharacterList_GetShow()
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return false
  end
  return Panel_Worldmap_FamilyCharacter_List_All:GetShow()
end
function PaGlobalFunc_WorldMap_CheckEsapceWorldMap()
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return true
  end
  if PaGlobalFunc_FamilyCharacterChangeMemo_All_GetShow() == true then
    PaGlobalFunc_FamilyCharacterChangeMemo_All_Close()
    return false
  end
  if Panel_Window_SimpleInventory:GetShow() == true then
    PaGlobal_SimpleInventory:close(false)
    return false
  end
  if PaGlobalFunc_WorldMap_FamilyCharacterList_ResetBlockMode() == false then
    if self._isConsole == true then
      PaGlobalFunc_WorldMap_FamilyCharacterList_ConsoleListControlMode()
    end
    return false
  end
  if self._ui._stc_selectPlaceBg:GetShow() == true then
    HandleEventLUp_WorldMap_FamilyCharacterList_ClearSelect()
    return false
  end
  if self._selectedCharacterIndex ~= nil then
    self:clearSelectCharacter()
    return false
  end
  return true
end
function PaGlobalFunc_WorldMap_FamilyCharacterList_ResetBlockMode()
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return true
  end
  if self._ui._stc_blockBg:GetShow() == true then
    self:setBlockMode(false)
    return false
  end
  return true
end
function PaGlobalFunc_WorldMap_FamilyCharacterList_Select(regionKeyRaw, isGroupByRegion, nonNavigable)
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  PaGlobalFunc_WorldMap_FamilyCharacterList_ResetBlockMode()
  self:selectPlace(true, regionKeyRaw, isGroupByRegion, nonNavigable)
end
function HandleEventLUp_WorldMap_FamilyCharacterList_ClearSelect()
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  self:selectPlace(false, nil, false, false)
end
function PaGlobalFunc_WorldMap_FamilyCharacterList_ComputeCharacterPosition(characterData)
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return false
  end
  return self:computeCharacterPosition(characterData)
end
function HandleEventLRUp_WorldMap_FamilyCharacterList_SelectCharacter(isRClick, doOpenSubMenu, doPingAndMoveCamera, characterDataIndex, highIndex, lowIndex)
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  self:clearWorldMapBeam()
  PaGlobalFunc_WorldMapFamilyCharacterIcon_SelectCurrentCaracter(-1, false, false)
  local characterData = getCharacterDataByIndex(characterDataIndex, __ePlayerCreateNormal)
  if characterData == nil then
    return
  end
  local characterPosition = PaGlobalFunc_WorldMap_FamilyCharacterList_ComputeCharacterPosition(characterData)
  local regionInfo = getRegionInfoByPosition(characterPosition)
  if regionInfo == nil then
    return
  end
  local territoryKey = regionInfo:getTerritoryKeyRaw()
  local regionKey = regionInfo:getRegionKey()
  local isRestricted = ToClient_RestrictContentsByRegionWithKey(regionKey, __eRestrictContentsType_WorldMap)
  local showLocation = regionInfo:isLocator() == true or getSelfPlayer():isResistDesert() == true
  if doPingAndMoveCamera ~= nil and doPingAndMoveCamera == true then
    if showLocation == true and isRestricted == false then
      ToCleint_gotoWorldmapPosition(characterPosition)
      local guideParam = NavigationGuideParam()
      if _ContentsGroup_ChinaFontColor == true then
        guideParam._color = float4(1, 1, 0.6, 1)
        guideParam._bgColor = float4(0.6, 0.6, 0.2, 0.3)
        guideParam._beamColor = float4(0.4, 0.4, 0.15, 1)
        guideParam._beamTime = 1
        guideParam._isAutoErase = true
      else
        guideParam._color = float4(1, 0.8, 0.6, 1)
        guideParam._bgColor = float4(0.6, 0.2, 0.2, 0.3)
        guideParam._beamColor = float4(0.4, 0.15, 0.15, 1)
        guideParam._beamTime = 1
        guideParam._isAutoErase = true
      end
      local beamIndex = worldmap_addNavigationBeam(characterPosition, guideParam, false)
      if beamIndex ~= -1 then
        if self._beamIndexList == nil then
          self._beamIndexList = Array.new()
        end
        self._beamIndexList:push_back(beamIndex)
      end
      self:showEffectSelectedPin(territoryKey, regionKey, characterDataIndex)
    elseif isRestricted == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_FAMILYCHARACTER_UNKNOWN_AREA_LOACTION"))
    elseif showLocation == false then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_FAMILYCHARACTER_UNKNOWN_AREA_COMPASS"))
    end
  end
  local isChangeSelectTarget = self._selectedCharacterIndex ~= characterDataIndex
  self._selectedCharacterIndex = characterDataIndex
  if isRClick ~= nil and isRClick == true then
    local listManager = self._ui._lst_characterList:getElementManager()
    if listManager ~= nil then
      local listCount = Int64toInt32(listManager:getSize())
      for ii = 0, listCount - 1 do
        local key = self._ui._lst_characterList:getKeyByIndex(ii)
        local contents = self._ui._lst_characterList:GetContentByKey(key)
        if contents ~= nil then
          local lowIndex = lowFromUint64(key)
          local isAreaContents = lowIndex == self._constOffsetIndex
          if isAreaContents == false then
            local rdo_character = UI.getChildControl(contents, "RadioButton_Character")
            if rdo_character:GetShow() == true then
              rdo_character:SetCheck(lowIndex == self._selectedCharacterIndex)
            end
          end
        end
      end
    end
  end
  if isChangeSelectTarget == true and PaGlobalFunc_FamilyCharacterChangeMemo_All_GetShow() == true then
    PaGlobalFunc_FamilyCharacterChangeMemo_All_Close()
  end
  if isChangeSelectTarget == false and self:isShowSubMenu() == true then
    self:hideSubMenu()
  elseif doOpenSubMenu ~= nil and doOpenSubMenu == true then
    local contentsKey = toInt64(highIndex, lowIndex)
    self:showSubMenu(contentsKey)
  end
end
function HandleEventLUp_WorldMap_FamilyCharacterList_SubMenu(eventType)
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  self:hideSubMenu()
  if eventType == self._subMenuEventType.CHANGE then
    HandleEventLUp_GameExit_All_ChangeCharacter(self._selectedCharacterIndex)
  elseif eventType == self._subMenuEventType.MOVE then
    local characterData = getCharacterDataByIndex(self._selectedCharacterIndex, __ePlayerCreateNormal)
    if characterData == nil then
      NotifyDisplay(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCharacterStaticIsntIntegrity"))
      return
    end
    local classType = getCharacterClassType(characterData)
    if ToClient_IsCustomizeOnlyClass(classType) == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DELIVERY_PERSON_NOTCHANGE"))
      return
    end
    if characterData._level < 5 then
      NotifyDisplay(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_DONT_CHAGECHARACTER", "iLevel", 4))
      return
    end
    local removeTime = getCharacterDataRemoveTime(self._selectedCharacterIndex, __ePlayerCreateNormal)
    if removeTime ~= nil then
      NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "GAMEEXIT_TEXT_CHARACTER_DELETE"))
      return
    end
    if ToClient_CheckDuelCharacterInPrison(self._selectedCharacterIndex) == true then
      NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERTAG_PRISON_CANT_LOGIN"))
      return
    end
    if ToClient_IsDuelCharacterByCharacterNo(characterData._characterNo_s64) == true then
      NotifyDisplay(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoTagCharacterCantDelivaryPC"))
      return
    end
    local characterPosition = self:computeCharacterPosition(characterData)
    local regionInfo = getRegionInfoByPosition(characterPosition)
    if regionInfo:isLocator() == false and selfPlayer:isResistDesert() == false then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoFamilyCharacterMoveHaveCompass"))
      return
    end
    if regionInfo:isPrison() == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantMoveFamilyCharacterInPrison"))
      return
    end
    self:setBlockMode(true)
    if self._isConsole == true then
      PaGlobalFunc_WorldMap_RingMenu_Open()
      PaGlobalFunc_WorldMap_FamilyCharacterList_SwitchKeyGuide()
    end
  elseif eventType == self._subMenuEventType.INVENTORY then
    PaGlobal_SimpleInventory:requestSimpleInventory(self._selectedCharacterIndex)
  elseif eventType == self._subMenuEventType.ADDMEMO then
    PaGlobalFunc_FamilyCharacterChangeMemo_All_Open(self._selectedCharacterIndex)
  elseif eventType == self._subMenuEventType.CLEARMEMO then
    local characterData = getCharacterDataByIndex(self._selectedCharacterIndex, __ePlayerCreateNormal)
    ToClient_SetFamilyCharacterMemo(characterData._characterNo_s64, "")
    PaGlobalFunc_WorldMap_FamilyCharacterList_UpdateCharacterMemo(self._selectedCharacterIndex)
  end
end
function PaGlobalFunc_WorldMap_FamilyCharacterList_CreateContents(contents, key)
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  local highIndex = highFromUint64(key)
  local lowIndex = lowFromUint64(key)
  local isAreaContents = lowIndex == self._constOffsetIndex
  local regionWrapper = getRegionInfoWrapper(highIndex)
  if regionWrapper == nil then
    return
  end
  local stc_dotIcon = UI.getChildControl(contents, "Static_DotIcon")
  local stc_territory = UI.getChildControl(stc_dotIcon, "Static_Territory")
  local stc_territoryIcon = UI.getChildControl(stc_territory, "Static_TerritoryIcon")
  local txt_areaName = UI.getChildControl(stc_territory, "StaticText_TerritoryName")
  stc_dotIcon:SetShow(isAreaContents == true)
  local rdo_character = UI.getChildControl(contents, "RadioButton_Character")
  local stc_classIcon = UI.getChildControl(rdo_character, "StaticText_ClassIcon")
  local stc_seasonIcon = UI.getChildControl(rdo_character, "Static_SeasonIcon")
  local txt_characterName = UI.getChildControl(rdo_character, "StaticText_CharacterName")
  local txt_memo = UI.getChildControl(rdo_character, "StaticText_Memo")
  local stc_wp = UI.getChildControl(rdo_character, "Static_WP")
  local stc_stack = UI.getChildControl(rdo_character, "Static_StackCount")
  local stc_horseIcon = UI.getChildControl(rdo_character, "StaticText_Horse")
  local stc_shipIcon = UI.getChildControl(rdo_character, "StaticText_Ship")
  local stc_tagIcon = UI.getChildControl(rdo_character, "StaticText_Transition")
  local stc_deliveryBg = UI.getChildControl(rdo_character, "Static_MovingBG")
  for key, value in pairs(self._ui._characterContentsList) do
    local parentControl = value:getParent()
    if parentControl:GetKey() == contents:GetKey() then
      self._ui._characterContentsList[key] = nil
    end
  end
  rdo_character:SetShow(isAreaContents == false)
  stc_classIcon:SetShow(isAreaContents == false)
  stc_seasonIcon:SetShow(false)
  txt_characterName:SetShow(isAreaContents == false)
  stc_wp:SetShow(isAreaContents == false)
  stc_stack:SetShow(isAreaContents == false)
  stc_horseIcon:SetShow(isAreaContents == false)
  stc_shipIcon:SetShow(isAreaContents == false)
  stc_deliveryBg:SetShow(isAreaContents == false)
  local isRestricted = ToClient_RestrictContentsByRegionWithKey(regionWrapper:getRegionKey(), __eRestrictContentsType_WorldMap)
  if isAreaContents == true then
    if isRestricted == false then
      local territoryKey = regionWrapper:getTerritoryKeyRaw()
      local territoryTextureId
      if territoryKey == 0 then
        territoryTextureId = "SymbolIcon_Valenos"
      elseif territoryKey == 1 then
        territoryTextureId = "SymbolIcon_Serendia"
      elseif territoryKey == 2 then
        territoryTextureId = "SymbolIcon_Calpheon"
      elseif territoryKey == 3 then
        territoryTextureId = "SymbolIcon_Media"
      elseif territoryKey == 4 then
        territoryTextureId = "SymbolIcon_Valencia"
      elseif territoryKey == 5 then
        territoryTextureId = "SymbolIcon_Oquilla"
      elseif territoryKey == 6 then
        territoryTextureId = "SymbolIcon_Kamasylvia"
      elseif territoryKey == 7 then
        territoryTextureId = "SymbolIcon_Drieghan"
      elseif territoryKey == 8 then
        territoryTextureId = "SymbolIcon_O'dyllita"
      elseif territoryKey == 9 then
        territoryTextureId = "SymbolIcon_SnowMountain"
      elseif territoryKey == 10 then
        territoryTextureId = "SymbolIcon_MorningLand"
      elseif territoryKey == 11 then
        territoryTextureId = "SymbolIcon_Ulukita"
      elseif territoryKey == 12 then
        territoryTextureId = "SymbolIcon_Edania"
      end
      if territoryTextureId ~= nil then
        stc_territoryIcon:ChangeTextureInfoTextureIDAsync(territoryTextureId)
        stc_territoryIcon:setRenderTexture(stc_territoryIcon:getBaseTexture())
      end
      stc_territoryIcon:SetShow(true)
      txt_areaName:SetText(regionWrapper:getTerritoryName())
      txt_areaName:SetSize(txt_areaName:GetTextSizeX(), txt_areaName:GetSizeY())
      txt_areaName:SetPosX(stc_territoryIcon:GetPosX() + stc_territoryIcon:GetSizeX() + 5)
      stc_territory:SetSize(stc_territoryIcon:GetSizeX() + txt_areaName:GetSizeX() + 5, stc_territory:GetSizeY())
    else
      stc_territoryIcon:SetShow(false)
      txt_areaName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAMILYCHARACTER_UNKNOWN_AREA"))
      txt_areaName:SetSize(txt_areaName:GetTextSizeX(), txt_areaName:GetSizeY())
      txt_areaName:SetPosX(stc_territoryIcon:GetPosX())
      stc_territory:SetSize(txt_areaName:GetSizeX(), stc_territory:GetSizeY())
    end
    local stc_decoLeft = UI.getChildControl(stc_dotIcon, "Static_TerritoryDecoLeft")
    local stc_decoRight = UI.getChildControl(stc_dotIcon, "Static_TerritoryDecoRight")
    stc_territory:SetHorizonCenter()
    local nameAreaSizeX = stc_territory:GetSizeX()
    local territoryAreaSizeX = stc_dotIcon:GetSizeX()
    local remainSizeX = territoryAreaSizeX - (nameAreaSizeX + self._decoOriginalSizeX * 2 + self._decoGap)
    if remainSizeX < 0 then
      local decoSizeX = self._decoOriginalSizeX + remainSizeX / 2
      stc_decoLeft:SetSize(decoSizeX, stc_decoLeft:GetSizeY())
      stc_decoRight:SetSize(decoSizeX, stc_decoRight:GetSizeY())
      stc_decoLeft:SetHorizonLeft()
      stc_decoRight:SetHorizonRight()
    end
  else
    local characterDataIndex = lowIndex
    local characterData = getCharacterDataByIndex(characterDataIndex, __ePlayerCreateNormal)
    if characterData == nil then
      return
    end
    self._ui._characterContentsList[characterDataIndex] = rdo_character
    local classType = getCharacterClassType(characterData)
    local characterName = getCharacterName(characterData)
    local characterWP = ToClient_getWpInCharacterDataList(characterDataIndex)
    local isDuelCharacter = ToClient_IsDuelCharacterByCharacterNo(characterData._characterNo_s64)
    local serverUtc64 = getServerUtc64()
    local deliveryWaypointKey = characterData._arrivalRegionOrWaypointKey
    local isSeasonCharacter = characterData._characterSeasonType == __eCharacterSeasonType_Season
    local familyCount = getEnchantInformation():ToClient_getBonusStackCount()
    local defaultCount = characterData._enchantFailCount
    local valksCount = characterData._valuePackCount
    PaGlobalFunc_Util_ChangeTextureClass(stc_classIcon, classType)
    stc_seasonIcon:SetShow(isSeasonCharacter)
    stc_tagIcon:SetMonoTone(not isDuelCharacter)
    stc_classIcon:SetText(tostring(characterData._level))
    txt_characterName:SetText(characterName)
    self:updateCharacterMemo(characterDataIndex)
    local txt_stack = UI.getChildControl(stc_stack, "StaticText_Stack")
    txt_stack:SetText(defaultCount + valksCount + familyCount)
    txt_stack:SetSize(txt_stack:GetTextSizeX(), txt_stack:GetSizeY())
    stc_stack:SetSize(txt_stack:GetSpanSize().x + txt_stack:GetSizeX(), stc_stack:GetSizeY())
    stc_stack:SetHorizonRight()
    local txt_wp = UI.getChildControl(stc_wp, "StaticText_WP")
    txt_wp:SetText(characterWP)
    txt_wp:SetSize(txt_wp:GetTextSizeX(), txt_wp:GetSizeY())
    stc_wp:SetSize(txt_wp:GetSpanSize().x + txt_wp:GetSizeX(), stc_wp:GetSizeY())
    stc_wp:SetPosX(stc_stack:GetPosX() - stc_wp:GetSizeX() - 5)
    if deliveryWaypointKey ~= 0 and serverUtc64 < characterData._arrivalTime then
      local destination = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FAMILYCHARACTER_DESTINATION", "areaName", getRegionNameByWaypointKey(deliveryWaypointKey))
      local remainTime = characterData._arrivalTime - serverUtc64
      local remainTimeStr = PAGetString(Defines.StringSheet_RESOURCE, "WORLDMAP_WOKRPROGRESS_TXT_REMAINTIME") .. "   " .. convertStringFromDatetime(remainTime)
      local stc_destination = UI.getChildControl(stc_deliveryBg, "StaticText_Destination")
      local stc_timeLeft = UI.getChildControl(stc_deliveryBg, "StaticText_TimeLeft")
      stc_destination:SetText(destination)
      UI.setLimitTextAndAddTooltip(stc_destination)
      stc_timeLeft:SetText(remainTimeStr)
      stc_deliveryBg:SetShow(true)
    else
      stc_deliveryBg:SetShow(false)
    end
    stc_horseIcon:SetMonoTone(true)
    stc_horseIcon:SetIgnore(true)
    stc_shipIcon:SetMonoTone(true)
    stc_shipIcon:SetIgnore(true)
    for eServantIdx = 0, self._servantTypeMax do
      local briefServantInfo = ToClient_GetBriefServantInfoByCharacter(characterData, eServantIdx)
      if briefServantInfo ~= nil and briefServantInfo:isMasterlessHorse() == false then
        if eServantIdx == __eServantTypeVehicle then
          stc_horseIcon:SetMonoTone(false)
          stc_horseIcon:SetIgnore(false)
          stc_horseIcon:addInputEvent("Mouse_On", "HandleEventLOnOut_WorldMap_FamilyCharacterList_ServantTooltip(true," .. tostring(characterDataIndex) .. "," .. tostring(eServantIdx) .. ")")
          stc_horseIcon:addInputEvent("Mouse_Out", "HandleEventLOnOut_WorldMap_FamilyCharacterList_ServantTooltip(false,0,0)")
          stc_horseIcon:addInputEvent("Mouse_LUp", "HandleEventLRUp_WorldMap_FamilyCharacterList_SelectCharacter(false, false, true, " .. tostring(characterDataIndex) .. "," .. tostring(highIndex) .. "," .. tostring(lowIndex) .. ")")
          stc_horseIcon:addInputEvent("Mouse_RUp", "HandleEventLRUp_WorldMap_FamilyCharacterList_SelectCharacter(true, true, false, " .. tostring(characterDataIndex) .. "," .. tostring(highIndex) .. "," .. tostring(lowIndex) .. ")")
        elseif eServantIdx == __eServantTypeShip then
          stc_shipIcon:SetMonoTone(false)
          stc_shipIcon:SetIgnore(false)
          stc_shipIcon:addInputEvent("Mouse_On", "HandleEventLOnOut_WorldMap_FamilyCharacterList_ServantTooltip(true," .. tostring(characterDataIndex) .. "," .. tostring(eServantIdx) .. ")")
          stc_shipIcon:addInputEvent("Mouse_Out", "HandleEventLOnOut_WorldMap_FamilyCharacterList_ServantTooltip(false,0,0)")
          stc_shipIcon:addInputEvent("Mouse_LUp", "HandleEventLRUp_WorldMap_FamilyCharacterList_SelectCharacter(false, false, true, " .. tostring(characterDataIndex) .. "," .. tostring(highIndex) .. "," .. tostring(lowIndex) .. ")")
          stc_shipIcon:addInputEvent("Mouse_RUp", "HandleEventLRUp_WorldMap_FamilyCharacterList_SelectCharacter(true, true, false, " .. tostring(characterDataIndex) .. "," .. tostring(highIndex) .. "," .. tostring(lowIndex) .. ")")
        end
      end
    end
    if isSeasonCharacter == true then
      stc_seasonIcon:SetIgnore(false)
      stc_seasonIcon:addInputEvent("Mouse_On", "HandleEventLOnOut_WorldMap_FamilyCharacterList_SeasonIconTooltip(true," .. tostring(characterDataIndex) .. ")")
      stc_seasonIcon:addInputEvent("Mouse_Out", "HandleEventLOnOut_WorldMap_FamilyCharacterList_SeasonIconTooltip(false,0)")
      stc_seasonIcon:addInputEvent("Mouse_LUp", "HandleEventLRUp_WorldMap_FamilyCharacterList_SelectCharacter(false, false, true, " .. tostring(characterDataIndex) .. "," .. tostring(highIndex) .. "," .. tostring(lowIndex) .. ")")
      stc_seasonIcon:addInputEvent("Mouse_RUp", "HandleEventLRUp_WorldMap_FamilyCharacterList_SelectCharacter(true, true, false, " .. tostring(characterDataIndex) .. "," .. tostring(highIndex) .. "," .. tostring(lowIndex) .. ")")
    else
      stc_seasonIcon:SetIgnore(true)
    end
    stc_wp:SetIgnore(false)
    stc_wp:addInputEvent("Mouse_On", "HandleEventLOnOut_WorldMap_FamilyCharacterList_EnergyTooltip(true," .. tostring(characterDataIndex) .. ")")
    stc_wp:addInputEvent("Mouse_Out", "HandleEventLOnOut_WorldMap_FamilyCharacterList_EnergyTooltip(false,0)")
    stc_wp:addInputEvent("Mouse_LUp", "HandleEventLRUp_WorldMap_FamilyCharacterList_SelectCharacter(false, false, true, " .. tostring(characterDataIndex) .. "," .. tostring(highIndex) .. "," .. tostring(lowIndex) .. ")")
    stc_wp:addInputEvent("Mouse_RUp", "HandleEventLRUp_WorldMap_FamilyCharacterList_SelectCharacter(true, true, false, " .. tostring(characterDataIndex) .. "," .. tostring(highIndex) .. "," .. tostring(lowIndex) .. ")")
    stc_stack:SetIgnore(false)
    stc_stack:addInputEvent("Mouse_On", "HandleEventLOnOut_WorldMap_FamilyCharacterList_EnchantTooltip(true," .. tostring(characterDataIndex) .. ")")
    stc_stack:addInputEvent("Mouse_Out", "HandleEventLOnOut_WorldMap_FamilyCharacterList_EnchantTooltip(false,0)")
    stc_stack:addInputEvent("Mouse_LUp", "HandleEventLRUp_WorldMap_FamilyCharacterList_SelectCharacter(false, false, true, " .. tostring(characterDataIndex) .. "," .. tostring(highIndex) .. "," .. tostring(lowIndex) .. ")")
    stc_stack:addInputEvent("Mouse_RUp", "HandleEventLRUp_WorldMap_FamilyCharacterList_SelectCharacter(true, true, false, " .. tostring(characterDataIndex) .. "," .. tostring(highIndex) .. "," .. tostring(lowIndex) .. ")")
    stc_classIcon:SetIgnore(false)
    stc_classIcon:addInputEvent("Mouse_On", "HandleEventLOnOut_WorldMap_FamilyCharacterList_ClassTypeTooltip(true," .. tostring(characterDataIndex) .. "," .. tostring(classType) .. ")")
    stc_classIcon:addInputEvent("Mouse_Out", "HandleEventLOnOut_WorldMap_FamilyCharacterList_ClassTypeTooltip(false,0,0)")
    stc_classIcon:addInputEvent("Mouse_LUp", "HandleEventLRUp_WorldMap_FamilyCharacterList_SelectCharacter(false, false, true, " .. tostring(characterDataIndex) .. "," .. tostring(highIndex) .. "," .. tostring(lowIndex) .. ")")
    stc_classIcon:addInputEvent("Mouse_RUp", "HandleEventLRUp_WorldMap_FamilyCharacterList_SelectCharacter(true, true, false, " .. tostring(characterDataIndex) .. "," .. tostring(highIndex) .. "," .. tostring(lowIndex) .. ")")
    stc_tagIcon:SetIgnore(false)
    stc_tagIcon:addInputEvent("Mouse_On", "HandleEventLOnOut_WorldMap_FamilyCharacterList_TransitionTooltip(true," .. tostring(characterDataIndex) .. ")")
    stc_tagIcon:addInputEvent("Mouse_Out", "HandleEventLOnOut_WorldMap_FamilyCharacterList_TransitionTooltip(false,0)")
    stc_tagIcon:addInputEvent("Mouse_LUp", "HandleEventLRUp_WorldMap_FamilyCharacterList_SelectCharacter(false, false, true, " .. tostring(characterDataIndex) .. "," .. tostring(highIndex) .. "," .. tostring(lowIndex) .. ")")
    stc_tagIcon:addInputEvent("Mouse_RUp", "HandleEventLRUp_WorldMap_FamilyCharacterList_SelectCharacter(true, true, false, " .. tostring(characterDataIndex) .. "," .. tostring(highIndex) .. "," .. tostring(lowIndex) .. ")")
    rdo_character:SetCheck(self._selectedCharacterIndex == characterDataIndex)
    rdo_character:addInputEvent("Mouse_LUp", "HandleEventLRUp_WorldMap_FamilyCharacterList_SelectCharacter(false, false, true, " .. tostring(characterDataIndex) .. "," .. tostring(highIndex) .. "," .. tostring(lowIndex) .. ")")
    rdo_character:addInputEvent("Mouse_RUp", "HandleEventLRUp_WorldMap_FamilyCharacterList_SelectCharacter(true, true, false, " .. tostring(characterDataIndex) .. "," .. tostring(highIndex) .. "," .. tostring(lowIndex) .. ")")
  end
end
function PaGlobalFunc_WorldMap_FamilyCharacterList_ScrollEvent()
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  self:hideSubMenu()
end
local s64_tempCharacterNo
function FromClient_SelectNodeByWorldMapFamilyCharacterMoveMode(nodeBtn)
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  local node = nodeBtn:FromClient_getExplorationNodeInClient()
  if node == nil then
    NotifyDisplay(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoWorkerNotRegionSelected"))
    return
  end
  local explorationSSW = node:getStaticStatus()
  if explorationSSW == nil then
    NotifyDisplay(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoWorkerNotRegionSelected"))
    return
  end
  if self._selectedCharacterIndex == nil then
    NotifyDisplay(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoTargetIsEmpty"))
    return
  end
  local characterData = getCharacterDataByIndex(self._selectedCharacterIndex, __ePlayerCreateNormal)
  if characterData == nil then
    NotifyDisplay(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCharacterStaticIsntIntegrity"))
    return
  end
  s64_tempCharacterNo = characterData._characterNo_s64
  local function doDeliveryOtherCharacter()
    if ToClient_RequestDeliveryOtherCharacter(s64_tempCharacterNo, explorationSSW._waypointKey) == false then
      self:clearSelectCharacter()
    end
    s64_tempCharacterNo = nil
  end
  local regionInfo = explorationSSW:getRegion()
  local regionInfoWrapper = getRegionInfoWrapper(regionInfo._regionKey:get())
  if regionInfoWrapper:isLocator() == false and getSelfPlayer():isResistDesert() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoFamilyCharacterMoveHaveCompass"))
    return
  end
  local deliveryTimeSecond = Int64toInt32(ToClient_GetDeliveryOtherCharacterTimeSecond())
  local deliveryCost = Int64toInt32(ToClient_GetDeliveryOtherCharacterCost(explorationSSW))
  local descParam1 = regionInfoWrapper:getAreaName()
  local descParam2 = getCharacterName(characterData)
  local descParam3 = tostring(math.floor(deliveryTimeSecond / 60)) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE")
  local descParam4 = makeDotMoney(deliveryCost)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "Lua_deliveryPerson_Information"),
    content = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_WORLDMAP_TRANSFER_FOR_FUNCTION", "nodeName", descParam1, "charName", descParam2, "transferTime", descParam3, "price", descParam4),
    functionYes = doDeliveryOtherCharacter,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_ResponseCompleteDeliveryOtherCharacter(s64_characterNo)
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  self:clearSelectCharacter()
  local listManager = self._ui._lst_characterList:getElementManager()
  if listManager ~= nil then
    local listCount = Int64toInt32(listManager:getSize())
    for ii = 0, listCount - 1 do
      local key = self._ui._lst_characterList:getKeyByIndex(ii)
      local contents = self._ui._lst_characterList:GetContentByKey(key)
      if contents ~= nil then
        local lowIndex = lowFromUint64(key)
        local isAreaContents = lowIndex == self._constOffsetIndex
        if isAreaContents == false then
          local characterDataIndex = lowIndex
          local characterData = getCharacterDataByIndex(characterDataIndex, __ePlayerCreateNormal)
          if characterData ~= nil and characterData._characterNo_s64 == s64_characterNo then
            PaGlobalFunc_WorldMap_FamilyCharacterList_CreateContents(contents, key)
            return
          end
        end
      end
    end
  end
end
function HandleEventLPress_WorldMap_FamilyCharacterList_UpdateAlpha()
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  self:updatePanelAlpha()
end
function HandleEventLOnOut_WorldMap_FamilyCharacterList_SeasonIconTooltip(isOn, index)
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  if isOn == false or self._ui._characterContentsList[index] == nil then
    TooltipSimple_Hide()
    return
  end
  local control = UI.getChildControl(self._ui._characterContentsList[index], "Static_SeasonIcon")
  if control == nil then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_SEASONCONTENT_SEASONCHARACTER")
  TooltipSimple_Show(control, name, nil)
end
function HandleEventLOnOut_WorldMap_FamilyCharacterList_EnergyTooltip(isOn, index)
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  if isOn == false or self._ui._characterContentsList[index] == nil then
    TooltipSimple_Hide()
    return
  end
  name = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHARWP_TITLE")
  desc = PAGetString(Defines.StringSheet_GAME, "MAINSTATUS_DESC_WP")
  control = UI.getChildControl(self._ui._characterContentsList[index], "Static_WP")
  if control == nil then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLOnOut_WorldMap_FamilyCharacterList_EnchantTooltip(isOn, index)
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  if isOn == false or self._ui._characterContentsList[index] == nil then
    TooltipSimple_Hide()
    return
  end
  local characterData = getCharacterDataByIndex(index, __ePlayerCreateNormal)
  if characterData == nil then
    return
  end
  local familyCount = getEnchantInformation():ToClient_getBonusStackCount()
  local defaultCount = characterData._enchantFailCount
  local valksCount = characterData._valuePackCount
  local isValksItemCheck
  if ToClient_IsContentsGroupOpen("47") == true then
    isValksItemCheck = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ENCHANTCOUNT_TOOLTIP", "defaultCount", tostring(defaultCount), "valksCount", tostring(valksCount), "familyCount", tostring(familyCount))
  else
    isValksItemCheck = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ENCHANTCOUNT_TOOLTIP_ADDCOUNT_NONE", "defaultCount", tostring(defaultCount))
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NORMALSTACK_TOOLTIP_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NORMALSTACK_TOOLTIP_DESC") .. isValksItemCheck
  local control = UI.getChildControl(self._ui._characterContentsList[index], "Static_StackCount")
  if control == nil then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLOnOut_WorldMap_FamilyCharacterList_ServantTooltip(isOn, index, servantIndex)
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  if isOn == false or self._ui._characterContentsList[index] == nil then
    TooltipSimple_Hide()
    return
  end
  local characterData = getCharacterDataByIndex(index, __ePlayerCreateNormal)
  if characterData == nil then
    return
  end
  local briefServantInfo = ToClient_GetBriefServantInfoByCharacter(characterData, servantIndex)
  if briefServantInfo == nil then
    return
  end
  local name = briefServantInfo:getName()
  local desc = PaGlobalFunc_GameExit_All_ServantInfoText(briefServantInfo)
  local control
  if servantIndex == __eServantTypeVehicle then
    control = UI.getChildControl(self._ui._characterContentsList[index], "StaticText_Horse")
  elseif servantIndex == __eServantTypeShip then
    control = UI.getChildControl(self._ui._characterContentsList[index], "StaticText_Ship")
  end
  if control == nil then
    return
  end
  TooltipSimple_Show(control, name, desc, false)
end
function HandleEventLOnOut_WorldMap_FamilyCharacterList_ClassTypeTooltip(isOn, index, classType)
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  if isOn == false or self._ui._characterContentsList[index] == nil then
    TooltipSimple_Hide()
    return
  end
  name = NewClassData.newClass_String[classType]._classType2String
  desc = ""
  control = UI.getChildControl(self._ui._characterContentsList[index], "StaticText_ClassIcon")
  if control == nil then
    return
  end
  TooltipSimple_Show(control, name, desc, false)
end
function HandleEventLOnOut_WorldMap_FamilyCharacterList_TransitionTooltip(isOn, index)
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  if isOn == false or self._ui._characterContentsList[index] == nil then
    TooltipSimple_Hide()
    return
  end
  local characterData = getCharacterDataByIndex(index, __ePlayerCreateNormal)
  if characterData == nil then
    return
  end
  if ToClient_IsDuelCharacterByCharacterNo(characterData._characterNo_s64) == false then
    return
  end
  local duelCharacterName = ""
  local duelCharacterCount = ToClient_GetMyDuelCharacterCount()
  if duelCharacterCount <= 0 then
    return
  end
  for idx = 0, duelCharacterCount - 1 do
    local duelCharacterData = ToClient_GetDuelCharacterDataByIndex(idx)
    if duelCharacterData ~= nil and characterData._characterNo_s64 ~= duelCharacterData._characterNo_s64 then
      if duelCharacterName == "" then
        duelCharacterName = tostring(getCharacterName(duelCharacterData))
      else
        duelCharacterName = duelCharacterName .. ", " .. tostring(getCharacterName(duelCharacterData))
      end
    end
  end
  name = PAGetString(Defines.StringSheet_GAME, "LUA_GAME_DUELCHARICON_TOOLTIP_NAME")
  desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAME_DUELCHARICON_TOOLTIP_DESC", "Charactername", duelCharacterName)
  control = UI.getChildControl(self._ui._characterContentsList[index], "StaticText_Transition")
  if control == nil then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function FromClient_UpdateFamilyMovingCharacter()
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  self:updateMovingCharacter()
end
function FromClient_UpdateCharacterPinEffect()
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  self:updateCharacterPinEffect()
end
function PaGlobalFunc_WorldMap_FamilyCharacterList_SwitchKeyGuide()
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  local isRingMenuShow = PaGlobalFunc_WorldMap_RingMenu_GetShow()
  self._ui._stc_keyGuideWorldMapConsole:SetShow(isRingMenuShow)
  self._ui._stc_keyGuideListConsole:SetShow(not isRingMenuShow)
end
function PaGlobalFunc_WorldMap_FamilyCharacterList_ConsoleListControlMode()
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  if self:isBlockMode() == true then
    self:setBlockMode(false)
  end
  PaGlobalFunc_WorldMap_RingMenu_Close()
  PaGlobalFunc_WorldMap_FamilyCharacterList_SwitchKeyGuide()
end
function PaGlobalFunc_WorldMap_FamilyCharacterList_UpdatePerFrame(deltaTime)
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  local yButtonPressed = PaGlobalFunc_WorldMap_GetYButtonPressed()
  local isActiveOtherPanel = PaGlobalFunc_FamilyCharacterChangeMemo_All_GetShow() or PaGlobal_WorldMap_StableList_GetShow()
  if isPadDown(__eJoyPadInputType_Y) == true and isActiveOtherPanel == false then
    if yButtonPressed == false then
      PaGlobalFunc_WorldMap_SetYButtonPressed(true)
      PaGlobalFunc_WorldMap_TopMenu_OnYPressed(true)
      _AudioPostEvent_SystemUiForXBOX(51, 7)
    end
  elseif isPadUp(__eJoyPadInputType_Y) == true then
    PaGlobalFunc_WorldMap_SetYButtonPressed(false)
    PaGlobalFunc_WorldMap_TopMenu_OnYPressed(false)
    _AudioPostEvent_SystemUiForXBOX(51, 7)
  end
  if yButtonPressed == true then
    if isPadUp(__eJoyPadInputType_DPad_Right) == true then
      PaGlobalFunc_WorldMap_TopMenu_NextMenu(false)
    elseif isPadUp(__eJoyPadInputType_DPad_Left) == true then
      PaGlobalFunc_WorldMap_TopMenu_NextMenu(true)
    end
  elseif isPadUp(__eJoyPadInputType_DPad_Left) == true and isActiveOtherPanel == false then
    PaGlobalFunc_WorldMap_RingMenu_Open()
    PaGlobalFunc_WorldMap_FamilyCharacterList_SwitchKeyGuide()
    if self:isShowSubMenu() == true then
      self:hideSubMenu()
    end
  end
end
function PaGlobalFunc_WorldMap_FamilyCharacterList_KeyGuideCheckShow()
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  self:keyGuide_CheckShow()
end
function PaGlobalFunc_WorldMap_FamilyCharacterList_UpdateKeyGuide()
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  self:keyGuide_CheckShow()
  self:updateKeyGuidePos()
end
function PaGlobalFunc_WorldMap_FamilyCharacterList_GetShowWorldMapKeyGuide()
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil or PaGlobalFunc_WorldMap_FamilyCharacterList_GetShow() == false then
    return false
  end
  return self._ui._stc_keyGuideWorldMapConsole:GetShow()
end
function PaGlobalFunc_WorldMap_FamilyCharacterList_UpdateCharacterMemo(characterDataIndex)
  local self = PaGlobal_WorldMap_FamilyCharacterList
  if self == nil then
    return
  end
  self:updateCharacterMemo(characterDataIndex)
end
