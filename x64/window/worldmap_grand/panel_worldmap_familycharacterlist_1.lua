function PaGlobal_WorldMap_FamilyCharacterList:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_titleBg = UI.getChildControl(Panel_Worldmap_FamilyCharacter_List_All, "Static_TitleBg")
  self._ui._txt_title = UI.getChildControl(self._ui._stc_titleBg, "StaticText_Title")
  self._ui._txt_chracterCount = UI.getChildControl(self._ui._stc_titleBg, "StaticText_CharacterCount")
  self._ui._prg_alpha = UI.getChildControl(self._ui._stc_titleBg, "Progress2_Alpha")
  self._ui._sld_alpha = UI.getChildControl(self._ui._stc_titleBg, "Slider_Alpha")
  self._ui._stc_decalBg = UI.getChildControl(Panel_Worldmap_FamilyCharacter_List_All, "Static_Decal")
  self._ui._stc_selectPlaceBg = UI.getChildControl(Panel_Worldmap_FamilyCharacter_List_All, "Static_SelectPlaceBg")
  self._ui._txt_selectPlace = UI.getChildControl(self._ui._stc_selectPlaceBg, "StaticText_Place")
  self._ui._btn_selectClear = UI.getChildControl(self._ui._stc_selectPlaceBg, "Button_Back")
  self._ui._lst_characterList = UI.getChildControl(Panel_Worldmap_FamilyCharacter_List_All, "List2_CharacterList")
  self._ui._stc_listBg = UI.getChildControl(Panel_Worldmap_FamilyCharacter_List_All, "Static_Bg")
  self._ui._stc_keyGuideMouseL = UI.getChildControl(Panel_Worldmap_FamilyCharacter_List_All, "StaticText_IconHelp_MouseL")
  self._ui._stc_keyGuideMouseR = UI.getChildControl(Panel_Worldmap_FamilyCharacter_List_All, "StaticText_IconHelp_MouseR")
  self._ui._stc_keyGuideListConsole = UI.getChildControl(Panel_Worldmap_FamilyCharacter_List_All, "StaticText_KeyGuideBg_ConsoleUIRight")
  self._ui._stc_keyGuideWorldMapConsole = UI.getChildControl(Panel_Worldmap_FamilyCharacter_List_All, "StaticText_KeyGuideBg_ConsoleUIRight2")
  self._ui._stc_subMenuBg = UI.getChildControl(Panel_Worldmap_FamilyCharacter_List_All, "Static_SubMenuBg")
  self._ui._btn_subMenuBtnTemplate = UI.getChildControl(self._ui._stc_subMenuBg, "Button_SubMenu_Template")
  self._ui._subMenuButtonList = nil
  self._ui._stc_blockBg = UI.getChildControl(Panel_Worldmap_FamilyCharacter_List_All, "Static_BlockBG")
  self._ui._stc_blockBg:SetAlpha(0.9)
  local blockBgText = UI.getChildControl(self._ui._stc_blockBg, "MultilineText_1")
  local blockBgTextConsole = UI.getChildControl(self._ui._stc_blockBg, "MultilineText_2")
  blockBgText:SetShow(not self._isConsole)
  blockBgTextConsole:SetShow(self._isConsole)
  self._ui._sld_alpha:SetControlPos(100)
  local listContents = UI.getChildControl(self._ui._lst_characterList, "List2_1_Content")
  local stc_territory = UI.getChildControl(listContents, "Static_DotIcon")
  local stc_decoLeft = UI.getChildControl(stc_territory, "Static_TerritoryDecoLeft")
  self._decoOriginalSizeX = stc_decoLeft:GetSizeX()
  self._ui._stc_keyGuideMouseL:SetShow(not self._isConsole)
  self._ui._stc_keyGuideMouseR:SetShow(not self._isConsole)
  self:makeSubMenuButtonList()
  self:registerEventHandler()
  self._initialize = true
  if self._isConsole == true then
    self._keyGuideList[self._keyGuideConfig._B] = UI.getChildControl(self._ui._stc_keyGuideWorldMapConsole, "StaticText_B")
    self._keyGuideList[self._keyGuideConfig._X_Hold] = UI.getChildControl(self._ui._stc_keyGuideWorldMapConsole, "StaticText_X_Hold")
    self._keyGuideList[self._keyGuideConfig._X] = UI.getChildControl(self._ui._stc_keyGuideWorldMapConsole, "StaticText_X")
    self._keyGuideList[self._keyGuideConfig._LTPlusX] = UI.getChildControl(self._ui._stc_keyGuideWorldMapConsole, "StaticText_LTPlusX")
    self._keyGuideList[self._keyGuideConfig._LTPlusStick] = UI.getChildControl(self._ui._stc_keyGuideWorldMapConsole, "StaticText_LTPlusStick")
    self._keyGuideList[self._keyGuideConfig._RS] = UI.getChildControl(self._ui._stc_keyGuideWorldMapConsole, "StaticText_RS")
    self._keyGuideList[self._keyGuideConfig._LS] = UI.getChildControl(self._ui._stc_keyGuideWorldMapConsole, "StaticText_LS")
    self._keyGuideList[self._keyGuideConfig._LS_Hold] = UI.getChildControl(self._ui._stc_keyGuideWorldMapConsole, "StaticText_LS_Hold")
    self._keyGuideList[self._keyGuideConfig._LSC] = UI.getChildControl(self._ui._stc_keyGuideWorldMapConsole, "StaticText_LSC")
    self._keyGuideList[self._keyGuideConfig._RSC] = UI.getChildControl(self._ui._stc_keyGuideWorldMapConsole, "StaticText_RSC")
    self._keyGuideList[self._keyGuideConfig._DpadDown] = UI.getChildControl(self._ui._stc_keyGuideWorldMapConsole, "StaticText_DpadDown")
    self._keyGuideList[self._keyGuideConfig._DpadUp] = UI.getChildControl(self._ui._stc_keyGuideWorldMapConsole, "StaticText_DpadUp")
    self._keyGuideList[self._keyGuideConfig._DpadLeft] = UI.getChildControl(self._ui._stc_keyGuideWorldMapConsole, "StaticText_DpadLeft")
    self._keyGuideList[self._keyGuideConfig._DpadRight] = UI.getChildControl(self._ui._stc_keyGuideWorldMapConsole, "StaticText_DpadRight")
    local text_LS_Hold = UI.getChildControl(self._keyGuideList[self._keyGuideConfig._LS_Hold], "Static_Text")
    text_LS_Hold:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_KEYGUIDE_GUILD_PINGTYPE_SELECT"))
  end
end
function PaGlobal_WorldMap_FamilyCharacterList:makeSubMenuButtonList()
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  self._ui._subMenuButtonList = {}
  local btnMaxSizeX = 0
  local btnMaxSizeY = 0
  for ii = 0, self._subMenuEventType.COUNT - 1 do
    self._ui._subMenuButtonList[ii] = UI.cloneControl(self._ui._btn_subMenuBtnTemplate, self._ui._stc_subMenuBg, "Button_SubMenu_" .. tostring(ii))
    self._ui._subMenuButtonList[ii]:SetIgnore(false)
    self._ui._subMenuButtonList[ii]:SetShow(true)
    local btnString = ""
    if ii == self._subMenuEventType.CHANGE then
      btnString = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_FAMILY_CHARACTERLIST_BUTTON_CHANGE")
    elseif ii == self._subMenuEventType.MOVE then
      btnString = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_FAMILY_CHARACTERLIST_BUTTON_MOVE")
    elseif ii == self._subMenuEventType.INVENTORY then
      btnString = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_FAMILY_CHARACTERLIST_BUTTON_INVENTORY")
    elseif ii == self._subMenuEventType.ADDMEMO then
      btnString = PAGetString(Defines.StringSheet_GAME, "LUA_MEMO_ADD")
    elseif ii == self._subMenuEventType.CLEARMEMO then
      btnString = PAGetString(Defines.StringSheet_GAME, "LUA_MEMOLIST_DELETE")
    end
    self._ui._subMenuButtonList[ii]:SetText(btnString)
    local btnSizeX = self._ui._subMenuButtonList[ii]:GetTextSizeX() + 10
    local btnSizeY = self._ui._subMenuButtonList[ii]:GetTextSizeY() + 10
    if btnMaxSizeX < btnSizeX then
      btnMaxSizeX = btnSizeX
    end
    if btnMaxSizeY < btnSizeY then
      btnMaxSizeY = btnSizeY
    end
    self._ui._subMenuButtonList[ii]:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldMap_FamilyCharacterList_SubMenu(" .. tostring(ii) .. ")")
  end
  local offsetY = 5
  local lastSpanY = 0
  for ii = 0, self._subMenuEventType.COUNT - 1 do
    self._ui._subMenuButtonList[ii]:SetSize(btnMaxSizeX, btnMaxSizeY)
    lastSpanY = offsetY + (btnMaxSizeY + offsetY) * ii
    self._ui._subMenuButtonList[ii]:SetSpanSize(0, lastSpanY)
  end
  self._ui._stc_subMenuBg:SetSize(btnMaxSizeX + 10, lastSpanY + btnMaxSizeY + offsetY)
  self._ui._stc_subMenuBg:ComputePosAllChild()
  UI.deleteControl(self._ui._btn_subMenuBtnTemplate)
end
function PaGlobal_WorldMap_FamilyCharacterList:registerEventHandler()
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  local alphaButton = UI.getChildControl(self._ui._sld_alpha, "Slider_Hp_Button")
  self._ui._lst_characterList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_WorldMap_FamilyCharacterList_CreateContents")
  self._ui._lst_characterList:registEvent(__ePAUIList2EventType_Scrolling, "PaGlobalFunc_WorldMap_FamilyCharacterList_ScrollEvent")
  self._ui._btn_selectClear:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldMap_FamilyCharacterList_ClearSelect()")
  alphaButton:addInputEvent("Mouse_LPress", "HandleEventLPress_WorldMap_FamilyCharacterList_UpdateAlpha()")
  alphaButton:addInputEvent("Mouse_LUp", "HandleEventLPress_WorldMap_FamilyCharacterList_UpdateAlpha()")
  self._ui._sld_alpha:addInputEvent("Mouse_LUp", "HandleEventLPress_WorldMap_FamilyCharacterList_UpdateAlpha()")
  self._ui._sld_alpha:addInputEvent("Mouse_LPress", "HandleEventLPress_WorldMap_FamilyCharacterList_UpdateAlpha()")
  registerEvent("FromClient_SelectNodeByWorldMapFamilyCharacterMoveMode", "FromClient_SelectNodeByWorldMapFamilyCharacterMoveMode")
  registerEvent("FromClient_ResponseCompleteDeliveryOtherCharacter", "FromClient_ResponseCompleteDeliveryOtherCharacter")
  registerEvent("FromClient_UpdateFamilyMovingCharacter", "FromClient_UpdateFamilyMovingCharacter")
  registerEvent("FromClient_UpdateFamilyMovingCharacter", "FromClient_UpdateCharacterPinEffect")
end
function PaGlobal_WorldMap_FamilyCharacterList:prepareKeyGuide()
  if Panel_Worldmap_FamilyCharacter_List_All == nil or self._isConsole == false then
    return
  end
  self._ui._stc_keyGuideListConsole:SetShow(false)
  self._ui._stc_keyGuideWorldMapConsole:SetShow(true)
  local selfProxyWrapper = getSelfPlayer()
  local nickName = ""
  if selfProxyWrapper ~= nil then
    nickName = selfProxyWrapper:getUserNickname()
  end
  local textControl = UI.getChildControl(self._keyGuideList[self._keyGuideConfig._DpadLeft], "Static_Text")
  textControl:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_TOTALSTABLE", "name", nickName))
  PaGlobalFunc_WorldMap_FamilyCharacterList_UpdateKeyGuide()
end
function PaGlobal_WorldMap_FamilyCharacterList:prepareOpen()
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  self:hideSubMenu()
  self:setBlockMode(false)
  self:setPanelPosition()
  self:selectPlace(false, nil, false, false)
  self:updatePanelAlpha()
  self:open()
  self:prepareKeyGuide()
end
function PaGlobal_WorldMap_FamilyCharacterList:open()
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  Panel_Worldmap_FamilyCharacter_List_All:SetShow(true)
end
function PaGlobal_WorldMap_FamilyCharacterList:prepareClose()
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  self:setBlockMode(false)
  self:clearWorldMapBeam()
  self:close()
end
function PaGlobal_WorldMap_FamilyCharacterList:close()
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  Panel_Worldmap_FamilyCharacter_List_All:SetShow(false)
end
function PaGlobal_WorldMap_FamilyCharacterList:setPanelPosition()
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  Panel_Worldmap_FamilyCharacter_List_All:SetPosX(getScreenSizeX() - Panel_Worldmap_FamilyCharacter_List_All:GetSizeX())
  Panel_Worldmap_FamilyCharacter_List_All:SetPosY(105)
end
function PaGlobal_WorldMap_FamilyCharacterList:setTitleText(characterCount)
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  self._ui._txt_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_FAMILY_CHARACTERLIST_TITLE_COUNT"))
  UI.setLimitTextAndAddTooltip(self._ui._txt_title)
  local countText = "<PAColor0xFFFFb400>(" .. tostring(characterCount) .. ")<PAOldColor>"
  self._ui._txt_chracterCount:SetText(countText)
  self._ui._txt_chracterCount:SetPosX(self._ui._txt_title:GetTextSizeX() + 20)
end
function PaGlobal_WorldMap_FamilyCharacterList:selectPlace(isSelected, regionKeyRaw, isGroupByRegion, nonNavigable)
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  self._isSelected = isSelected
  self._selectedRegionKeyRaw = regionKeyRaw
  self._isGroupByRegion = isGroupByRegion
  self._currentIsGroupByRegion = isGroupByRegion
  self._isNonNavigable = nonNavigable
  self._ui._stc_selectPlaceBg:SetShow(self._isSelected)
  local listBgSizeY = Panel_Worldmap_FamilyCharacter_List_All:GetSizeY() - self._ui._stc_titleBg:GetSizeY()
  local keyGuideSizeY = 0
  if self._isConsole == false then
    keyGuideSizeY = keyGuideSizeY + self._ui._stc_keyGuideMouseL:GetSizeY()
    keyGuideSizeY = keyGuideSizeY + self._ui._stc_keyGuideMouseR:GetSizeY()
  end
  if self._isSelected == true then
    local selectAreaName = ""
    local regionWrapper = getRegionInfoWrapper(regionKeyRaw)
    if regionWrapper == nil then
      return
    end
    if self._isGroupByRegion == true then
      selectAreaName = regionWrapper:getAreaName()
    else
      selectAreaName = regionWrapper:getTerritoryName()
    end
    self._ui._txt_selectPlace:SetText(selectAreaName)
    self._ui._lst_characterList:SetSize(self._ui._lst_characterList:GetSizeX(), listBgSizeY - self._ui._stc_selectPlaceBg:GetSizeY() - keyGuideSizeY)
    self._ui._lst_characterList:SetSpanSize(self._ui._lst_characterList:GetSpanSize().x, self._ui._stc_selectPlaceBg:GetSpanSize().y + self._ui._stc_selectPlaceBg:GetSizeY())
    self._ui._lst_characterList:ComputePosAllChild()
    self._ui._lst_characterList:createChildContent(__ePAUIList2ElementManagerType_List)
    self:setCharacterList(regionWrapper:getTerritoryKeyRaw(), regionKeyRaw, nonNavigable)
  else
    self._ui._lst_characterList:SetSize(self._ui._lst_characterList:GetSizeX(), listBgSizeY - keyGuideSizeY)
    self._ui._lst_characterList:SetSpanSize(self._ui._lst_characterList:GetSpanSize().x, self._ui._stc_selectPlaceBg:GetSpanSize().y)
    self._ui._lst_characterList:ComputePosAllChild()
    self._ui._lst_characterList:createChildContent(__ePAUIList2ElementManagerType_List)
    self:setCharacterList(nil, nil, false)
  end
  self._ui._stc_decalBg:SetPosY(Panel_Worldmap_FamilyCharacter_List_All:GetSizeY() - self._ui._stc_decalBg:GetSizeY() - keyGuideSizeY - 1)
  self._ui._stc_blockBg:SetSize(Panel_Worldmap_FamilyCharacter_List_All:GetSizeX(), listBgSizeY)
  self._ui._stc_listBg:SetSize(Panel_Worldmap_FamilyCharacter_List_All:GetSizeX(), listBgSizeY)
  self._ui._stc_blockBg:ComputePos()
end
function PaGlobal_WorldMap_FamilyCharacterList:setCharacterList(territoryKeyRaw, regionKeyRaw, nonNavigable)
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  local listManager = self._ui._lst_characterList:getElementManager()
  if listManager == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  self._selectedCharacterIndex = nil
  listManager:clearKey()
  self:clearCharacterData()
  self:hideSubMenu()
  local characterCount = getCharacterDataCount(__ePlayerCreateNormal)
  for index = 0, characterCount - 1 do
    local characterData = getCharacterDataByIndex(index, __ePlayerCreateNormal)
    if characterData ~= nil and selfPlayer:getCharacterNo_64() ~= characterData._characterNo_s64 then
      local characterPosition = self:computeCharacterPosition(characterData)
      local regionInfo = getRegionInfoByPosition(characterPosition)
      if regionInfo ~= nil then
        local regionKey = regionInfo:getRegionKey()
        local isRestricted = ToClient_RestrictContentsByRegionWithKey(regionKey, __eRestrictContentsType_WorldMap)
        if isRestricted == false then
          self:pushCharacterData(regionInfo:getTerritoryKeyRaw(), regionKey, index)
        else
          self:pushCharacterData(self._territoryKeyCountMax, regionKey, index)
        end
      end
    end
  end
  local characterCount = 0
  if territoryKeyRaw ~= nil and regionKeyRaw ~= nil then
    if self._isGroupByRegion == true then
      if self._characterDataContainer[territoryKeyRaw][regionKeyRaw] ~= nil then
        for key3, value3 in pairs(self._characterDataContainer[territoryKeyRaw][regionKeyRaw]) do
          if value3 ~= nil then
            listManager:pushKey(toInt64(regionKeyRaw, value3))
            characterCount = characterCount + 1
          end
        end
      end
    else
      for key, value in pairs(self._characterDataContainer) do
        if key == territoryKeyRaw and value ~= nil then
          for key2, value2 in pairs(value) do
            if value2 ~= nil then
              local regionWrapper = getRegionInfoWrapper(key2)
              if regionWrapper ~= nil then
                local isLocator = regionWrapper:isLocator()
                if nonNavigable == false or nonNavigable == true and isLocator == false then
                  for key3, value3 in pairs(value2) do
                    if value3 ~= nil then
                      listManager:pushKey(toInt64(key2, value3))
                      characterCount = characterCount + 1
                    end
                  end
                end
              end
            end
          end
          break
        end
      end
    end
  else
    if self._characterDataContainer[0] ~= nil then
      local isTop = true
      for key2, value2 in pairs(self._characterDataContainer[0]) do
        if isTop == true then
          listManager:pushKey(toInt64(key2, self._constOffsetIndex))
          isTop = false
        end
        if value2 ~= nil then
          for key3, value3 in pairs(value2) do
            if value3 ~= nil then
              listManager:pushKey(toInt64(key2, value3))
              characterCount = characterCount + 1
            end
          end
        end
      end
    end
    for key, value in ipairs(self._characterDataContainer) do
      if value ~= nil then
        local isTop = true
        for key2, value2 in pairs(value) do
          if isTop == true then
            listManager:pushKey(toInt64(key2, self._constOffsetIndex))
            isTop = false
          end
          if value2 ~= nil then
            for key3, value3 in pairs(value2) do
              if value3 ~= nil then
                listManager:pushKey(toInt64(key2, value3))
                characterCount = characterCount + 1
              end
            end
          end
        end
      end
    end
  end
  self:setTitleText(characterCount)
end
function PaGlobal_WorldMap_FamilyCharacterList:clearCharacterData()
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  self._characterDataContainer = nil
  self._characterDataContainer = {}
  for ii = 0, self._territoryKeyCountMax do
    if self._characterDataContainer[ii] == nil then
      self._characterDataContainer[ii] = {}
    end
  end
end
function PaGlobal_WorldMap_FamilyCharacterList:pushCharacterData(territoryKeyRaw, regionKeyRaw, index)
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  if self._characterDataContainer == nil then
    self:clearCharacterData()
  end
  local isFindTerritoryKey = false
  local isFindRegionKey = false
  for key, value in pairs(self._characterDataContainer) do
    if key == territoryKeyRaw then
      isFindTerritoryKey = true
      if value ~= nil then
        for key2, value2 in pairs(value) do
          if key2 == regionKeyRaw then
            isFindRegionKey = true
            break
          end
        end
      end
      break
    end
  end
  if isFindTerritoryKey == false then
    self._characterDataContainer[territoryKeyRaw] = {}
  end
  if isFindRegionKey == false then
    self._characterDataContainer[territoryKeyRaw][regionKeyRaw] = Array.new()
  end
  self._characterDataContainer[territoryKeyRaw][regionKeyRaw]:push_back(index)
end
function PaGlobal_WorldMap_FamilyCharacterList:isShowSubMenu()
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return false
  end
  return self._ui._stc_subMenuBg:GetShow()
end
function PaGlobal_WorldMap_FamilyCharacterList:showSubMenu(contentsKey)
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  local contents = self._ui._lst_characterList:GetContentByKey(contentsKey)
  if contents == nil then
    return
  end
  local posX = contents:GetPosX() - self._ui._stc_subMenuBg:GetSizeX() - 5
  local posY = self._ui._lst_characterList:GetPosY() + contents:GetPosY()
  self._ui._stc_subMenuBg:SetPosX(posX)
  self._ui._stc_subMenuBg:SetPosY(posY)
  self._ui._stc_subMenuBg:SetShow(true)
  if self._ui._subMenuButtonList[0] ~= nil then
    ToClient_padSnapChangeToTarget(self._ui._subMenuButtonList[0])
  end
end
function PaGlobal_WorldMap_FamilyCharacterList:hideSubMenu()
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  self._ui._stc_subMenuBg:SetShow(false)
end
function PaGlobal_WorldMap_FamilyCharacterList:setBlockMode(isBlock)
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  self._ui._stc_blockBg:SetShow(isBlock)
  self._ui._stc_blockBg:SetIgnore(isBlock == false)
  ToClient_SetFamilyCharacterMoveMode(isBlock)
end
function PaGlobal_WorldMap_FamilyCharacterList:isBlockMode()
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return false
  end
  return self._ui._stc_blockBg:GetShow() == true
end
function PaGlobal_WorldMap_FamilyCharacterList:clearSelectCharacter()
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  self._selectedCharacterIndex = nil
  self:setBlockMode(false)
  self:hideSubMenu()
  local listManager = self._ui._lst_characterList:getElementManager()
  if listManager ~= nil then
    local listCount = Int64toInt32(listManager:getSize())
    for ii = 0, listCount - 1 do
      local key = self._ui._lst_characterList:getKeyByIndex(ii)
      local contents = self._ui._lst_characterList:GetContentByKey(key)
      if contents ~= nil then
        local rdo_character = UI.getChildControl(contents, "RadioButton_Character")
        if rdo_character:GetShow() == true and rdo_character:IsCheck() == true then
          rdo_character:SetCheck(false)
        end
      end
    end
  end
  self:clearWorldMapBeam()
  PaGlobalFunc_WorldMapFamilyCharacterIcon_SelectCurrentCaracter(-1, false, false)
end
function PaGlobal_WorldMap_FamilyCharacterList:clearWorldMapBeam()
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  if self._beamIndexList ~= nil then
    for key, value in pairs(self._beamIndexList) do
      if value ~= nil then
        ToClient_DeleteNaviGuide(value)
      end
    end
    self._beamIndexList = nil
  end
end
function PaGlobal_WorldMap_FamilyCharacterList:updatePanelAlpha()
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  local alpha = self._minAlpha + (1 - self._minAlpha) * self._ui._sld_alpha:GetControlPos()
  Panel_Worldmap_FamilyCharacter_List_All:SetAlphaExtraChild(alpha)
  self._ui._stc_blockBg:SetAlpha(0.9)
end
function PaGlobal_WorldMap_FamilyCharacterList:updateMovingCharacter()
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  local needUpdateList = false
  for key, value in pairs(self._ui._characterContentsList) do
    local characterData = getCharacterDataByIndex(key, __ePlayerCreateNormal)
    if characterData ~= nil then
      local deliveryWaypointKey = characterData._arrivalRegionOrWaypointKey
      local serverUtc64 = getServerUtc64()
      local stc_deliveryBg = UI.getChildControl(value, "Static_MovingBG")
      if deliveryWaypointKey ~= 0 and stc_deliveryBg:GetShow() == true then
        if serverUtc64 < characterData._arrivalTime then
          local remainTime = characterData._arrivalTime - serverUtc64
          local remainTimeStr = PAGetString(Defines.StringSheet_RESOURCE, "WORLDMAP_WOKRPROGRESS_TXT_REMAINTIME") .. "   " .. convertStringFromDatetime(remainTime)
          local stc_timeLeft = UI.getChildControl(stc_deliveryBg, "StaticText_TimeLeft")
          stc_timeLeft:SetText(remainTimeStr)
        else
          stc_deliveryBg:SetShow(false)
          needUpdateList = true
        end
      end
    end
  end
  if needUpdateList == true then
    self:selectPlace(self._isSelected, self._selectedRegionKeyRaw, self._isGroupByRegion, self._isNonNavigable)
  end
end
function PaGlobal_WorldMap_FamilyCharacterList:computeCharacterPosition(characterData)
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  local characterPosition = characterData._currentPosition
  local deliveryWaypointKey = characterData._arrivalRegionOrWaypointKey
  if deliveryWaypointKey ~= 0 and characterData._arrivalTime <= getServerUtc64() then
    local nodeBtn = ToClient_FindNodeButtonByWaypointKey(deliveryWaypointKey)
    if nodeBtn ~= nil then
      local node = nodeBtn:FromClient_getExplorationNodeInClient()
      if node ~= nil then
        local nodeStaticStatus = node:getStaticStatus()
        if nodeStaticStatus ~= nil then
          characterPosition = nodeStaticStatus:getPosition()
        end
      end
    end
  end
  return characterPosition
end
function PaGlobal_WorldMap_FamilyCharacterList:showEffectSelectedPin(territoryKey, regionKey, characterDataIndex)
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  local controlIndex
  if self._currentIsGroupByRegion == true then
    if self._characterDataContainer[territoryKey][regionKey] == nil then
      return
    end
    local characterCount = 0
    for characterIndex, characterValue in pairs(self._characterDataContainer[territoryKey][regionKey]) do
      characterCount = characterCount + 1
    end
    if characterCount <= 0 then
      return
    end
    if characterCount > 1 then
      for characterIndex, characterValue in pairs(self._characterDataContainer[territoryKey][regionKey]) do
        if controlIndex == nil or characterValue < controlIndex then
          controlIndex = characterValue
        end
      end
      PaGlobalFunc_WorldMapFamilyCharacterIcon_SelectCurrentCaracter(controlIndex, true, true)
    else
      PaGlobalFunc_WorldMapFamilyCharacterIcon_SelectCurrentCaracter(characterDataIndex, true, false)
    end
  else
    if territoryKey == nil then
      return
    end
    for regionIndex, regionValue in pairs(self._characterDataContainer[territoryKey]) do
      for characterIndex, characterValue in pairs(regionValue) do
        if controlIndex == nil or characterValue < controlIndex then
          controlIndex = characterValue
        end
      end
    end
    PaGlobalFunc_WorldMapFamilyCharacterIcon_SelectCurrentCaracter(controlIndex, true, true)
  end
end
function PaGlobal_WorldMap_FamilyCharacterList:updateCharacterPinEffect()
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  if self._selectedCharacterIndex == nil then
    return
  end
  local isGroupByRegion = ToClient_getWorldMapCameraDistanceRatio() <= 0.5
  if self._currentIsGroupByRegion ~= isGroupByRegion then
    self._currentIsGroupByRegion = isGroupByRegion
    local characterData = getCharacterDataByIndex(self._selectedCharacterIndex, __ePlayerCreateNormal)
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
    self:showEffectSelectedPin(territoryKey, regionKey, self._selectedCharacterIndex)
  end
end
function PaGlobal_WorldMap_FamilyCharacterList:keyGuide_CheckShow()
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  local config = self._keyGuideConfig
  if PaGlobalFunc_WorldMap_BottomMenu_GetMode ~= nil and PaGlobalFunc_WorldMap_BottomMenu_GetMode() == 0 then
    self._keyGuideList[config._X_Hold]:SetShow(true)
  else
    self._keyGuideList[config._X_Hold]:SetShow(false)
  end
  if PaGlobalFunc_WorldMap_GetFocusedBookMarkIndex ~= nil and PaGlobalFunc_WorldMap_GetFocusedBookMarkIndex() == -1 then
    local textControl = UI.getChildControl(self._keyGuideList[config._X_Hold], "Static_Text")
    textControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_KEYGUIDE_REGISTBOOKMARK"))
  else
    local textControl = UI.getChildControl(self._keyGuideList[config._X_Hold], "Static_Text")
    textControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_KEYGUIDE_UNREGISTBOOKMARK"))
  end
end
function PaGlobal_WorldMap_FamilyCharacterList:updateKeyGuidePos()
  if Panel_Worldmap_FamilyCharacter_List_All == nil then
    return
  end
  local currentPosY = self._keyGuideList[self._keyGuideConfig._B]:GetPosY()
  for index = 0, self._keyGuideConfig._keyGuideCount - 1 do
    if self._keyGuideList[index]:GetShow() == true then
      self._keyGuideList[index]:SetPosY(currentPosY)
      currentPosY = currentPosY - self._keyGuideConfig._yGap
    end
  end
end
function PaGlobal_WorldMap_FamilyCharacterList:updateCharacterMemo(characterIndex)
  if Panel_Worldmap_FamilyCharacter_List_All == nil or self._ui._characterContentsList[characterIndex] == nil then
    return
  end
  local rdo_character = self._ui._characterContentsList[characterIndex]
  local txt_characterName = UI.getChildControl(rdo_character, "StaticText_CharacterName")
  local txt_memo = UI.getChildControl(rdo_character, "StaticText_Memo")
  local stc_seasonIcon = UI.getChildControl(rdo_character, "Static_SeasonIcon")
  local characterData = getCharacterDataByIndex(characterIndex, __ePlayerCreateNormal)
  local characterMemo = ToClient_GetFamilyCharacterMemo(characterData._characterNo_s64)
  local isSeasonCharacter = characterData._characterSeasonType == __eCharacterSeasonType_Season
  if characterMemo == "" then
    txt_memo:SetShow(false)
    txt_characterName:SetVerticalMiddle()
    stc_seasonIcon:SetVerticalMiddle()
  else
    txt_memo:SetTextMode(__eTextMode_LimitText)
    txt_memo:SetText(characterMemo)
    txt_memo:SetFontColor(Defines.Color.C_FFEF9C7F)
    local centerPosition = rdo_character:GetSizeY() / 2
    local yGap = 2
    txt_memo:SetPosY(centerPosition - txt_memo:GetSizeY() - yGap)
    txt_characterName:SetPosY(centerPosition + yGap)
    stc_seasonIcon:SetPosY(txt_characterName:GetPosY())
    txt_memo:SetShow(true)
  end
  if isSeasonCharacter == true then
    txt_characterName:SetPosX(stc_seasonIcon:GetPosX() + 25)
  else
    txt_characterName:SetPosX(stc_seasonIcon:GetPosX())
  end
end
