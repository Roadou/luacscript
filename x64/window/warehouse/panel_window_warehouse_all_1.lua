function PaGlobal_WareHouse_All:initialize()
  if true == PaGlobal_WareHouse_All._initialize then
    return
  end
  PaGlobal_WareHouse_All:close()
  Panel_Window_Warehouse:setMaskingChild(true)
  Panel_Window_Warehouse:setGlassBackground(true)
  local stc_topBg = UI.getChildControl(Panel_Window_Warehouse, "Static_TopBg")
  local stc_rightTopBg = UI.getChildControl(Panel_Window_Warehouse, "Static_RightTopBg")
  local stc_rightBottomBg = UI.getChildControl(Panel_Window_Warehouse, "Static_RightBottomBg")
  local stc_leftBg = UI.getChildControl(Panel_Window_Warehouse, "Static_LeftBg")
  local stc_bottomBg = UI.getChildControl(Panel_Window_Warehouse, "Static_BottomBg")
  self._ui._stc_title = UI.getChildControl(stc_topBg, "StaticText_Icon_WareHouse")
  self._ui._stc_decoBg = UI.getChildControl(stc_topBg, "Static_DecoBg")
  self._ui._txt_villageName = UI.getChildControl(stc_topBg, "StaticText_VillageNameValue")
  self._ui._txt_villageName:SetShow(false)
  self._ui._pc._btn_close = UI.getChildControl(stc_topBg, "Button_Close_PCUI")
  self._ui._pc._btn_question = UI.getChildControl(stc_topBg, "Button_Question_PCUI")
  self._ui._chk_itemSort = UI.getChildControl(stc_rightTopBg, "CheckButton_ItemSort")
  self._ui._btn_sortOption = UI.getChildControl(stc_rightTopBg, "Button_Sort_Set")
  self._ui._pc._chk_horseBag = UI.getChildControl(stc_rightTopBg, "CheckButton_Horse_Bag_PCUI")
  self._ui._pc._chk_horseBag:SetTextMode(__eTextMode_LimitText)
  self._ui._pc._chk_horseBag:SetText(self._ui._pc._chk_horseBag:GetText())
  self._ui._pc._chk_horseBag:SetPosX(self._ui._btn_sortOption:GetPosX() + self._ui._btn_sortOption:GetSizeX() + 5)
  self._ui._pc._chk_horseBag:SetShow(false)
  self._ui._pc._btn_Search = UI.getChildControl(stc_rightTopBg, "Button_Search")
  self._ui._console._txt_Search = UI.getChildControl(stc_rightTopBg, "StaticText_KeyGuide_RSClick_ConsoleUI")
  self._ui._console._txt_keyGuideSort = UI.getChildControl(stc_rightTopBg, "StaticText_LSClick_ConsoleUI")
  self._ui._txt_capacity = UI.getChildControl(stc_rightTopBg, "StaticText_Capacity")
  self._ui._console._txt_keyGuideClose = UI.getChildControl(stc_bottomBg, "StaticText_B")
  self._ui._console._txt_keyGuideSelect = UI.getChildControl(stc_bottomBg, "StaticText_A")
  self._ui._console._txt_keyGuideManufacture = UI.getChildControl(stc_bottomBg, "StaticText_LT_A")
  self._ui._console._txt_keyGuideCargoSellOpen = UI.getChildControl(stc_bottomBg, "StaticText_RTY_ConsoleUI")
  self._ui._console._txt_keyGuideMarketInvenOpen = UI.getChildControl(stc_bottomBg, "StaticText_Y")
  self._ui._console._txt_keyGuideGuildPresent = UI.getChildControl(stc_bottomBg, "StaticText_LT_X")
  self._ui._console._txt_keyGuide_LTY = UI.getChildControl(stc_bottomBg, "StaticText_LTY_ConsoleUI")
  self._ui._console._txt_keyGuide_RTA = UI.getChildControl(stc_bottomBg, "StaticText_RTA_ConsoleUI")
  self._ui._console._txt_keyGuide_RTX = UI.getChildControl(stc_bottomBg, "StaticText_RTX_ConsoleUI")
  self._ui._console._txt_keyGuide_LTX = UI.getChildControl(stc_bottomBg, "StaticText_LTX_ConsoleUI")
  self._ui._stc_moneyBg = UI.getChildControl(stc_rightBottomBg, "Static_MoneyBg")
  self._ui._txt_moneyTitle = UI.getChildControl(self._ui._stc_moneyBg, "StaticText_MoneyTitle")
  self._ui._txt_assetTitle = UI.getChildControl(self._ui._stc_moneyBg, "StaticText_AssetTitle")
  self._ui._txt_valueMoney = UI.getChildControl(self._ui._stc_moneyBg, "StaticText_Value_Money")
  self._ui._txt_valueAsset = UI.getChildControl(self._ui._stc_moneyBg, "StaticText_Value_Asset")
  self._ui._btn_money = UI.getChildControl(self._ui._stc_moneyBg, "Button_Money")
  self._ui._btn_asset = UI.getChildControl(self._ui._stc_moneyBg, "Button_Asset")
  self._ui._btn_present = UI.getChildControl(stc_rightBottomBg, "Button_Present")
  self._ui._btn_wareHouseHistory = UI.getChildControl(stc_rightBottomBg, "Button_LogView")
  self._ui._blockWarehouseBg = UI.getChildControl(Panel_Window_Warehouse, "Static_BlockWarehouseBG")
  self._ui._txt_blockWarehouseDesc = UI.getChildControl(self._ui._blockWarehouseBg, "StaticText_Desc")
  self._ui._stc_itemSlotFrame = UI.getChildControl(stc_rightBottomBg, "Static_ItemSlotFrame")
  self._ui._stc_itemSlotBg = UI.getChildControl(self._ui._stc_itemSlotFrame, "Static_ItemSlotBg_Template")
  self._ui._stc_lockIcon = UI.getChildControl(self._ui._stc_itemSlotFrame, "Static_ItemSlotBg_LockIcon")
  self._ui._stc_multipleSelect = UI.getChildControl(self._ui._stc_itemSlotFrame, "Static_MultipleSelect")
  self._ui._scroll_warehouse = UI.getChildControl(stc_rightBottomBg, "Scroll_Warehouse")
  self._ui._btn_deliveryInfomation = UI.getChildControl(stc_rightBottomBg, "Button_DeliveryInformation")
  self._ui._btn_itemMarketRegist = UI.getChildControl(stc_rightBottomBg, "Button_ItemMarketRegist")
  self._ui._btn_manufacture = UI.getChildControl(stc_rightBottomBg, "Button_Manufacture")
  self._ui._btn_guildUpdate = UI.getChildControl(stc_rightBottomBg, "Button_GuildUpdate")
  self._ui._btn_guildLog = UI.getChildControl(stc_rightBottomBg, "Button_GuildLog")
  self._ui._btn_cargoCell = UI.getChildControl(stc_rightBottomBg, "Button_CargoSell")
  self._ui._btn_wareHouseHistory = UI.getChildControl(stc_rightBottomBg, "Button_LogView")
  self._ui._txt_ItemShare_Desc = UI.getChildControl(stc_rightBottomBg, "StaticText_ItemShare_Desc")
  self._ui._txt_ItemShare_Desc:SetShow(false)
  if true == _ContentsGroup_GuildShareItemWareHouse then
    self._ui._txt_ItemShare_Desc:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_ItemShare_Desc:SetSize(self._ui._txt_ItemShare_Desc:GetSizeX(), self._ui._txt_ItemShare_Desc:GetTextSizeY() + 10)
  end
  self._ui._list2_serchWareHouse = UI.getChildControl(stc_leftBg, "List2_WareHouse")
  self._ui._txt_notAvaliable = UI.getChildControl(stc_leftBg, "StaticText_NotAvaliable")
  self._ui._stc_topBg = stc_topBg
  self._ui._stc_rightTopBg = stc_rightTopBg
  self._ui._stc_rightBottomBg = stc_rightBottomBg
  self._ui._stc_leftBg = stc_leftBg
  self._ui._stc_bottomBg = stc_bottomBg
  self._ui._list2_serchWareHouse:changeAnimationSpeed(10)
  self._ui._list2_serchWareHouse:setMinScrollBtnSize(float2(10, 50))
  self._ui._list2_serchWareHouse:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_Warehouse_All_UpdateSearchMenuList")
  self._ui._list2_serchWareHouse:createChildContent(__ePAUIList2ElementManagerType_Tree)
  PaGlobal_WareHouse_All:SetShowSearchMenuWareHouse(false)
  self._isConsole = _ContentsGroup_UsePadSnapping
  local isPc = false == self._isConsole
  for k, control in pairs(self._ui._pc) do
    control:SetShow(isPc)
  end
  self._ui._btn_deliveryInfomation:SetShow(isPc)
  self._ui._btn_itemMarketRegist:SetShow(isPc)
  self._ui._btn_manufacture:SetShow(isPc)
  self._ui._btn_cargoCell:SetShow(isPc)
  self._ui._btn_guildUpdate:SetShow(isPc)
  self._ui._btn_guildLog:SetShow(isPc)
  self._ui._btn_present:SetShow(isPc)
  self._ui._btn_wareHouseHistory:SetShow(isPc)
  self._ui._txt_blockWarehouseDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDPRESENT_NOITEM"))
  if dialog_isEventWarehouseNpc() == true then
    self._ui._btn_cargoCell:SetShow(false)
  end
  self._ui._console._txt_keyGuideMarketInvenOpen:SetShow(self._isConsole)
  self._ui._console._txt_keyGuide_RTA:SetShow(false)
  self._ui._console._txt_keyGuide_RTX:SetShow(false)
  self._ui._console._txt_keyGuide_LTX:SetShow(false)
  self._ui._console._txt_keyGuide_LTY:SetShow(false)
  for k, control in pairs(self._ui._console) do
    control:SetShow(self._isConsole)
  end
  self._ui._stc_bottomBg:SetShow(self._isConsole)
  if true == self._isConsole then
    local capacityGapX = self._ui._console._txt_Search:GetSizeX() + self._ui._console._txt_Search:GetTextSizeX() + 20
    self._ui._txt_capacity:SetSpanSize(capacityGapX, self._ui._txt_capacity:GetSpanSize().y)
    self._ui._stc_itemSlotBg:ChangeOnTextureInfoNameAsync("renewal/frame/console_frame_00.dds")
    local x1, y1, x2, y2 = setTextureUV_FuncByTextureType(self._ui._stc_itemSlotBg, 50, 195, 94, 239, __eUITextureTypeOn)
    self._ui._stc_itemSlotBg:getOnTexture():setUV(x1, y1, x2, y2)
  end
  self._keyGuide = {
    self._ui._console._txt_keyGuideGuildPresent,
    self._ui._console._txt_keyGuideMarketInvenOpen,
    self._ui._console._txt_keyGuideManufacture,
    self._ui._console._txt_keyGuideCargoSellOpen,
    self._ui._console._txt_keyGuide_LTX,
    self._ui._console._txt_keyGuide_LTY,
    self._ui._console._txt_keyGuideSelect,
    self._ui._console._txt_keyGuideClose
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuide, self._ui._stc_bottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  if true == self._isConsole then
    self._ui._pc._btn_Search:SetShow(false)
    self._ui._console._txt_Search:SetShow(true)
  else
    self._ui._pc._btn_Search:SetShow(true)
    self._ui._console._txt_Search:SetShow(false)
  end
  self._defaultRightBgSize.x = self._ui._stc_rightBottomBg:GetSizeX()
  self._defaultRightBgSize.y = self._ui._stc_rightBottomBg:GetSizeY()
  self._defaultMoneyBgSize.x = self._ui._stc_moneyBg:GetSizeX()
  self._defaultMoneyBgSize.y = self._ui._stc_moneyBg:GetSizeY()
  self._btnMarketRegistSizeX = self._ui._btn_itemMarketRegist:GetSizeX()
  self._btnMarketRegSpanSizeY = self._ui._btn_itemMarketRegist:GetSpanSize().y
  self._panelSizeY = Panel_Window_Warehouse:GetSizeY()
  self._assetTitlePosY = self._ui._txt_assetTitle:GetPosY()
  self._assetValuePosY = self._ui._txt_valueAsset:GetPosY()
  self._staticCapacityPosY = self._ui._txt_capacity:GetPosY()
  self._moneyValuePosY = self._ui._txt_valueMoney:GetPosY()
  self._config.slotRows = math.floor(self._config.slotCount / self._config.slotCols)
  self._ui._btn_itemMarketRegist:SetShow(false)
  if _ContentsGroup_RenewUI_ItemMarketPlace_Only then
    self._ui._btn_itemMarketRegist:addInputEvent("Mouse_LUp", "PaGlobalFunc_MarketWallet_Open(" .. CppEnums.ItemWhereType.eWarehouse .. ")")
  else
    self._ui._btn_itemMarketRegist:addInputEvent("Mouse_LUp", "HandleEventLUp_Warehouse_All_MarketRegistOpen()")
  end
  self._ui._scroll_warehouse:SetShow(true)
  self._ui._btn_manufacture:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WAREHOUSE_BTNTEXT_1"))
  self._ui._btn_itemMarketRegist:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WAREHOUSE_BTNTEXT_2"))
  PaGlobalFunc_AutoSortFunctionPanel_LinkPanel(InvenSortLinkPanelIndex.WareHouse, Panel_Window_Warehouse, self._ui._btn_sortOption, self._ui._chk_itemSort, nil, nil)
  self:updateSortText_console()
  if true == _ContentsGroup_NewDelivery then
    self:update()
  end
  self._memoryPanelSizeX = 1010
  self:createSlot()
  PaGlobal_WareHouse_All:registEventHandler()
  PaGlobal_WareHouse_All:validate()
  self._ui._stc_rightBottomBg:SetIgnore(true)
  PaGlobal_WareHouse_All._initialize = true
end
function PaGlobal_WareHouse_All:registEventHandler()
  if nil == Panel_Window_Warehouse then
    return
  end
  Panel_Window_Warehouse:RegisterShowEventFunc(true, "PaGloabl_WareHouse_All_ShowAni()")
  Panel_Window_Warehouse:RegisterShowEventFunc(false, "PaGloabl_WareHouse_All_HideAni()")
  self._ui._btn_manufacture:addInputEvent("Mouse_LUp", "HandleEventLUp_Warehouse_All_ManufactureOpen()")
  self._ui._btn_guildUpdate:addInputEvent("Mouse_LUp", "HandleEventLUp_Warehouse_All_GuildWareHouseUpdate()")
  self._ui._btn_cargoCell:addInputEvent("Mouse_LUp", "HandleEvent_Warehouse_All_CargoSellOpen()")
  self._ui._btn_wareHouseHistory:addInputEvent("Mouse_LUp", "HandleEvent_Warehouse_All_HistoryOpen()")
  self._ui._btn_guildLog:addInputEvent("Mouse_LUp", "HandleEventLUp_Warehouse_All_GuildWareHouseHistory()")
  self._ui._btn_sortOption:addInputEvent("Mouse_LUp", "HandleEventLUp_Warehouse_All_ShowSortOption()")
  UIScroll.InputEvent(self._ui._scroll_warehouse, "HandleEvent_Warehouse_All_Scroll")
  UIScroll.InputEventByControl(Panel_Window_Warehouse, "HandleEvent_Warehouse_All_Scroll")
  self._ui._pc._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Warehouse_All_Close()")
  self._ui._btn_money:addInputEvent("Mouse_LUp", "HandleEventLUp_Warehouse_All_PopMoney()")
  if true == self._isConsole then
    Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_RSClick, "HandleEventLUp_Warehouse_All_TotalSearch()")
  else
    self._ui._pc._btn_Search:addInputEvent("Mouse_LUp", "HandleEventLUp_Warehouse_All_TotalSearch()")
  end
  self._ui._pc._btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"WareHouse\" )")
  PaGlobal_Util_RegistHelpTooltipEvent(self._ui._pc._btn_question, "\"WareHouse\"")
  self._ui._btn_deliveryInfomation:addInputEvent("Mouse_LUp", "HandleEventLUp_WareHouse_All_OpenDelivery()")
  self._ui._pc._chk_horseBag:addInputEvent("Mouse_On", "HandleEventOnOut_WareHouse_All_ShowToggleHorseBagToolTip(true)")
  self._ui._pc._chk_horseBag:addInputEvent("Mouse_Out", "HandleEventOnOut_WareHouse_All_ShowToggleHorseBagToolTip(false)")
  self._ui._pc._chk_horseBag:addInputEvent("Mouse_LUp", "HandleEventLUp_WareHouse_All_ShowToggleHorseBag()")
  if _ContentsGroup_SiegeGuildPresentation == true then
    local selfPlayer = getSelfPlayer()
    local isGuildMaster = false
    if selfPlayer == nil then
      isGuildMaster = false
    else
      isGuildMaster = selfPlayer:get():isGuildMaster()
    end
    if isGuildMaster == true then
      self._ui._btn_present:addInputEvent("Mouse_LUp", "HandleEventLUp_WareHouse_All_OpenGuildPresent()")
    end
  end
  Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_LSClick, "HandleEventLUp_WareHouse_All_ToggleCheckSortButton()")
  if true == _ContentsGroup_UsePadSnapping and false == _ContentsGroup_RenewUI then
    Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEvent_Warehouse_All_HistoryOpen()")
    Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_MarketWallet_Open(" .. CppEnums.ItemWhereType.eWarehouse .. ")")
  end
  if true == _ContentsGroup_UsePadSnapping and false == _ContentsGroup_RenewUI and true == _ContentsGroup_CargoSell then
    Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "HandleEvent_Warehouse_All_CargoSellOpen()")
  end
  registerEvent("FromClient_WarehouseOpenByInstallation", "FromClient_Warehouse_All_OpenByInstallation")
  registerEvent("EventWarehouseUpdate", "FromClient_Warehouse_All_Update")
  registerEvent("FromClient_WarehouseClose", "FromClient_Warehouse_All_Close")
  registerEvent("EventGuildWarehouseUpdate", "FromClient_Warehouse_All_GuildUpdate")
  registerEvent("FromClient_FurnitureWarehouseUpdate", "FromClient_Warehouse_All_FurnitureUpdate")
  registerEvent("FromClient_UpdateInventoryBag", "PaGlobal_Warehouse_All_UpdateInventoryBag")
  registerEvent("FromClient_InventoryUpdate", "PaGlobal_Warehouse_All_UpdateInventory")
  registerEvent("FromClient_WarehouseUpdate", "FromClient_Warehouse_All_Update")
  registerEvent("FromClient_RemoveAllGuildBuffInstallation", "FromClient_RemoveAllGuildBuffInstallation")
  registerEvent("EventWarehouseUpdate", "PaGlobal_Warehouse_All_UpdateSearchMenuWarehouse")
end
function PaGlobal_WareHouse_All:prepareOpen()
  if nil == Panel_Window_Warehouse or true == Panel_Window_Warehouse:GetShow() then
    return
  end
  if true == _ContentsGroup_FamilyInventory then
    PaGlobalFunc_Inventory_All_familyInventoryButtonActive(false)
  end
  if PaGlobalFunc_Inventory_All_EnchantInventoryButtonActive ~= nil then
    PaGlobalFunc_Inventory_All_EnchantInventoryButtonActive(false)
  end
  ToClient_loadExceptionMoveItemKey()
  self:setInventoryItemMoveEvent(false)
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  self._ui._pc._chk_horseBag:SetShow(false)
  self:setGuildPresentButton()
  PaGlobal_WareHouse_All:setPanelPosition()
  PaGlobal_WareHouse_All:open()
end
function PaGlobal_WareHouse_All:open()
  if nil == Panel_Window_Warehouse then
    return
  end
  Panel_Window_Warehouse:SetShow(true, true)
  PaGlobalFunc_Inventory_All_CloseSideUI(-1)
end
function PaGlobal_WareHouse_All:setPanelPosition()
  if self._selectWaypointKey < 0 then
    self._isSetPanelPosition = false
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local dialogSizeY = Panel_Npc_Dialog_All:GetSizeY()
  local isCurrentTownsWarehouse = self._selectWaypointKey == getCurrentWaypointKey() and self._fromType == CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc
  if dialog_isEventWarehouseNpc() == true and self._selectWaypointKey == warehouse_getEventWarehouseWaypointKey() then
    isCurrentTownsWarehouse = true
  end
  if isCurrentTownsWarehouse then
    if not ToClient_WorldMapIsShow() then
      if true == self._isConsole then
        Panel_Window_Warehouse:SetVerticalTop()
        Panel_Window_Warehouse:SetHorizonRight()
        Panel_Window_Warehouse:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_Warehouse:GetSizeX() - 5)
        Panel_Window_Warehouse:SetPosY(0)
      else
        Panel_Window_Warehouse:SetPosX(screenSizeX - Panel_Window_Warehouse:GetSizeX() - Panel_Window_Inventory_All:GetSizeX() - 15)
        Panel_Window_Warehouse:SetPosY((screenSizeY - dialogSizeY) / 2 - Panel_Window_Warehouse:GetSizeY() / 2)
      end
    else
      local fromType = self._fromType
      if CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid == fromType or CppEnums.WarehoouseFromType.eWarehoouseFromType_Installation == fromType then
        if self._isConsole == true then
          Panel_Window_Warehouse:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_Warehouse:GetSizeX() - 5)
          Panel_Window_Warehouse:SetPosY((getOriginScreenSizeY() - Panel_Window_Warehouse:GetSizeY()) * 0.5)
        else
          if _ContentsGroup_NewUI_Inventory_All == true then
            Panel_Window_Warehouse:SetPosX(getScreenSizeX() - Panel_Window_Inventory_All:GetSizeX() - Panel_Window_Warehouse:GetSizeX() - Panel_Window_Inventory_All:GetSpanSize().x - 10)
          else
            Panel_Window_Warehouse:SetPosX(getScreenSizeX() - Panel_Window_Inventory:GetSizeX() - Panel_Window_Warehouse:GetSizeX())
          end
          Panel_Window_Warehouse:SetPosY(getScreenSizeY() * 0.5 - Panel_Window_Warehouse:GetSizeY() * 0.5)
        end
      elseif CppEnums.WarehoouseFromType.eWarehoouseFromType_Manufacture == fromType then
        PaGlobal_Manufacture_All_OpenFromWareHouseSetPos()
        Panel_Window_Warehouse:SetPosX(Panel_Window_Manufacture_All:GetPosX() + Panel_Window_Manufacture_All:GetSizeX() + 10)
      end
    end
  else
    local fromType = self._fromType
    if CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid == fromType or CppEnums.WarehoouseFromType.eWarehoouseFromType_Installation == fromType then
      if self._isConsole == true then
        Panel_Window_Warehouse:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_Warehouse:GetSizeX() - 5)
        Panel_Window_Warehouse:SetPosY((getOriginScreenSizeY() - Panel_Window_Warehouse:GetSizeY()) * 0.5)
      elseif _ContentsGroup_NewUI_Inventory_All == true then
        Panel_Window_Warehouse:SetPosX(screenSizeX - Panel_Window_Warehouse:GetSizeX() - Panel_Window_Inventory_All:GetSizeX() - 15)
        Panel_Window_Warehouse:SetPosY(screenSizeY / 2 - Panel_Window_Warehouse:GetSizeY() / 2)
      else
        Panel_Window_Warehouse:SetPosX(getScreenSizeX() - Panel_Window_Inventory:GetSizeX() - Panel_Window_Warehouse:GetSizeX())
        Panel_Window_Warehouse:SetPosY(getScreenSizeY() * 0.5 - Panel_Window_Warehouse:GetSizeY() * 0.5)
      end
    elseif CppEnums.WarehoouseFromType.eWarehoouseFromType_Manufacture == fromType then
      PaGlobal_Manufacture_All_OpenFromWareHouseSetPos()
      Panel_Window_Warehouse:SetPosX(Panel_Window_Manufacture_All:GetPosX() + Panel_Window_Manufacture_All:GetSizeX() + 10)
    end
  end
  if false == self._isConsole and true == _ContentsGroup_NewUI_Inventory_All then
    PaGlobalFunc_Inventory_All_InventorySetPosWithWarehouse()
  end
  if Panel_Window_Warehouse:GetShow() then
    self._isSetPanelPosition = true
  end
end
function PaGlobal_WareHouse_All:prepareClose()
  if nil == Panel_Window_Warehouse then
    return
  end
  if false == Panel_Window_Warehouse:GetShow() then
    return
  end
  if self._isConsole == true and Panel_WareHouseFunctionPanel_All ~= nil and Panel_WareHouseFunctionPanel_All:GetShow() == true then
    PaGlobalFunc_WareHouseFunctionPanel_All_Close()
  end
  if Panel_Window_WareHouseHistory ~= nil and Panel_Window_WareHouseHistory:GetShow() == true then
    PaGlobal_WareHouseHistory:close()
  end
  if Panel_AutoMove_Result_All ~= nil and Panel_AutoMove_Result_All:GetShow() == true then
    PaGlobal_AutoMove_Result_All:prepareClose()
  end
  if _ContentsOption_CH_GameType == true then
    self._ui._pc._btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"WareHouse\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui._pc._btn_question, "\"WareHouse\"")
  end
  if nil ~= Panel_Window_ServantInventory and true == Panel_Window_ServantInventory:GetShow() then
    ServantInventory_Close()
    return
  end
  if Panel_Window_GuildPresent:GetShow() == true then
    return
  end
  if PaGlobalFunc_AutoSortFunctionPanel_GetShow(InvenSortLinkPanelIndex.WareHouse) == true then
    PaGlobalFunc_AutoSortFunctionPanel_Hide()
  end
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  if ToClient_isConsole() == true then
    if true == PaGlobalFunc_PanelDelivery_GetShow() then
      DeliveryRequestWindow_Close()
    end
  elseif Panel_Window_Delivery_All:GetShow() then
    PaGlobal_Delivery_All:prepareClose()
  end
  local isInvenOpen = false
  if true == _ContentsGroup_NewUI_Inventory_All then
    isInvenOpen = Panel_Window_Inventory_All:GetShow()
    PaGlobal_Inventory_All._openedUIMode = PaGlobal_Inventory_All._bottomBG_UIMode.Normal
    PaGlobal_Inventory_All:reloadBottomBgFromMode(PaGlobal_Inventory_All._openedUIMode)
  else
    isInvenOpen = Panel_Window_Inventory:GetShow()
  end
  if true == _ContentsGroup_FamilyInventory then
    PaGlobalFunc_Inventory_All_familyInventoryButtonActive(true)
  end
  if PaGlobalFunc_Inventory_All_EnchantInventoryButtonActive ~= nil then
    PaGlobalFunc_Inventory_All_EnchantInventoryButtonActive(true)
  end
  if true == isInvenOpen then
    if CppEnums.WarehoouseFromType.eWarehoouseFromType_Installation ~= PaGlobal_WareHouse_All._fromType and CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid ~= PaGlobal_WareHouse_All._fromType then
      if true == _ContentsGroup_ItemMove then
        if false == Panel_Window_ItemMoveSet:GetShow() then
          InventoryWindow_Close()
        end
      else
        InventoryWindow_Close()
      end
    else
      self._fromType = CppEnums.WarehoouseFromType.eWarehoouseFromType_Worldmap
      InventoryWindow_Show()
      Inventory_SetFunctor(nil, nil, nil, nil)
    end
    if PaGlobalFunc_Inventory_RemoteWareHouseDescShow ~= nil then
      PaGlobalFunc_Inventory_RemoteWareHouseDescShow(false)
    end
  end
  if true == _ContentsGroup_isAllWarehouse then
    PaGlobal_WareHouse_All:searchMenuClose()
  end
  PaGlobal_WareHouse_All._fromType = CppEnums.WarehoouseFromType.eWarehoouseFromType_Worldmap
  if nil ~= PaGlobal_WareHouse_All.itemMarketFilterFunc then
    PaGlobal_WareHouse_All.itemMarketFilterFunc = nil
    PaGlobal_WareHouse_All.itemMarketRclickFunc = nil
  end
  if nil ~= PaGlobal_WareHouse_All.manufactureRclickFunc then
    PaGlobal_WareHouse_All.manufactureFilterFunc = nil
    PaGlobal_WareHouse_All.manufactureRclickFunc = nil
  end
  if nil ~= PaGlobal_WareHouse_All.guildWareHouseFilterFunc then
    PaGlobal_WareHouse_All.guildWareHouseFilterFunc = nil
  end
  self._ui._pc._chk_horseBag:SetShow(false)
  if ToClient_WorldMapIsShow() then
    WorldMapPopupManager:pop()
  else
    PaGlobal_WareHouse_All:close()
  end
  Panel_Window_Warehouse:ChangeSpecialTextureInfoName("")
  local isManufactureOpen = false
  if nil ~= Panel_Window_Manufacture_All then
    isManufactureOpen = Panel_Window_Manufacture_All:GetShow()
  end
  if nil ~= Panel_Window_MarketPlace_MyInventory and false == Panel_Window_MarketPlace_MyInventory:GetShow() and false == isManufactureOpen then
    PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  end
  if true == isManufactureOpen and self._isConsole then
    PaGlobalFunc_InterestKnowledge_All_Close()
  end
  if ToClient_CheckExistSummonMaid() then
    ToClient_CallHandlerMaid("_maidLogOut")
  end
  if Panel_Window_GuildPresent:GetShow() == true then
    PaGlobal_GuildPresent_All_Close_FromWarehouse()
  end
  if PaGlobalFunc_TotalSearch_GetShow ~= nil and PaGlobalFunc_TotalSearch_GetShow() == true and PaGlobalFunc_TotalSearch_Close ~= nil then
    PaGlobalFunc_TotalSearch_Close()
  end
  Panel_Tooltip_Item_hideTooltip()
  if Panel_Window_WareHouseHistory ~= nil then
    PaGlobal_WareHouseHistory:close()
  end
  if Panel_WareHouseFunctionPanel_All ~= nil then
    PaGlobalFunc_WareHouseFunctionPanel_All_Close()
    return
  end
  TooltipSimple_Hide()
  self._isUseMultiMaid = false
  self._isSetPanelPosition = false
  PaGlobal_MaidList_All_resettingInvenFunc()
end
function PaGlobal_WareHouse_All:close()
  if nil == Panel_Window_Warehouse then
    return
  end
  if Panel_Window_TotalSearch ~= nil and PaGlobalFunc_TotalSearch_GetShow() == true then
    PaGlobalFunc_TotalSearch_Close()
  end
  PaGlobal_WareHouseHistory:close()
  Panel_Window_Warehouse:SetShow(false, false)
end
function PaGlobal_WareHouse_All:update()
  if nil == Panel_Window_Warehouse then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  local warehouseWrapper = self:getWarehouse()
  if nil == warehouseWrapper then
    return
  end
  local addSizeY = 0
  if self:isNpc() then
    addSizeY = self.addSizeY
  end
  local useStartSlot = 1
  local itemCount = warehouseWrapper:getSize()
  local useMaxCount = warehouseWrapper:getUseMaxCount()
  local freeCount = warehouseWrapper:getFreeCount()
  local money_s64 = warehouseWrapper:getMoney_s64()
  local maxCount = warehouseWrapper:getMaxCount()
  if itemCount < useMaxCount - useStartSlot then
    self._ui._txt_capacity:SetFontColor(Defines.Color.C_FFDDC39E)
  else
    self._ui._txt_capacity:SetFontColor(Defines.Color.C_FFD05D48)
  end
  if itemCount > useMaxCount - useStartSlot then
    self._ui._txt_capacity:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "Lua_WareHouse_OverCapacity", "HaveCount", tostring(itemCount), "FullCount", tostring(useMaxCount - useStartSlot)))
  else
    self._ui._txt_capacity:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "Lua_WareHouse_Capacity", "HaveCount", tostring(itemCount), "FullCount", tostring(useMaxCount - useStartSlot)))
  end
  self._ui._txt_valueMoney:SetText(makeDotMoney(money_s64))
  local slotNoList = Array.new()
  slotNoList:fill(useStartSlot, maxCount - 1)
  local isGuildWare = CppEnums.WarehoouseFromType.eWarehoouseFromType_GuildItemShare == PaGlobal_WareHouse_All._fromType or CppEnums.WarehoouseFromType.eWarehoouseFromType_GuildHouse == PaGlobal_WareHouse_All._fromType
  if PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.WareHouse) == true then
    PaGlobalFunc_AutoSortFunctionPanel_LoadSortOptionAndDoSort(InvenSortLinkPanelIndex.WareHouse, false)
    for sortIndex = useStartSlot, maxCount - 1 do
      slotNoList[sortIndex] = selfPlayer:getRealInventorySlotNoNew(__eInventorySortWhereType_WareHouse, sortIndex)
    end
  end
  self:updateInitSlot(useMaxCount, maxCount, useStartSlot)
  self:updateAssetManagement(slotNoList, useMaxCount, money_s64)
  self:updateSlot(slotNoList)
  self._ui._txt_moneyTitle:SetShow(true)
  self._ui._txt_valueMoney:SetShow(true)
  self._ui._btn_money:SetShow(true)
  if true == self:isGuildHouse() or true == self:isFurnitureWareHouse() then
    self._ui._txt_moneyTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ITEMMARKET_ICON_MONEY3"))
    self._ui._txt_assetTitle:SetShow(false)
    self._ui._txt_valueAsset:SetShow(false)
    self._ui._btn_asset:SetShow(false)
  elseif true == self:isGuildItemShare() or true == self:isGuildSafe() then
    self._ui._txt_assetTitle:SetShow(false)
    self._ui._txt_valueAsset:SetShow(false)
    self._ui._btn_asset:SetShow(false)
  else
    self._ui._txt_moneyTitle:SetShow(false)
    self._ui._txt_valueMoney:SetShow(false)
    self._ui._btn_money:SetShow(false)
    self._ui._txt_assetTitle:SetShow(true)
    self._ui._txt_valueAsset:SetShow(true)
    self._ui._btn_asset:SetShow(true)
  end
end
function PaGlobal_WareHouse_All:createSlot()
  local maxRowsIdx = self._config.slotRows - 1
  for ii = 0, self._config.slotCount - 1 do
    local blankSlot
    if nil == self._blankSlots[ii] then
      local slotNo = ii + 1
      local slot = {}
      slot.empty = UI.createAndCopyBasePropertyControl(self._ui._stc_itemSlotFrame, "Static_ItemSlotBg_Template", self._ui._stc_itemSlotFrame, "Warehouse_Slot_Base_" .. ii)
      UIScroll.InputEventByControl(slot.empty, "HandleEvent_Warehouse_All_Scroll")
      local row = math.floor(ii / self._config.slotCols)
      local column = ii % self._config.slotCols
      slot.empty:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      slot.empty:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      if true == _ContentsGroup_RenewUI_Tooltip then
        slot.empty:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventRUp_Warehouse_All_ShowDetailTooltip(" .. ii .. ", true)")
      end
      if true == self._isConsole then
        if 0 == row then
          slot.empty:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEvent_Warehouse_All_Scroll(true)")
        elseif maxRowsIdx == row then
          slot.empty:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEvent_Warehouse_All_Scroll(false)")
        end
      end
      self._blankSlots[ii] = slot
    end
    blankSlot = self._blankSlots[ii]
    if nil == self._slots[ii] then
      local slot = {}
      SlotItem.new(slot, "ItemIcon_" .. ii, ii, self._ui._stc_itemSlotFrame, self._slotConfig)
      slot:createChild()
      local row = math.floor(ii / self._config.slotCols)
      local column = ii % self._config.slotCols
      slot.icon:SetPosX(self._config.slotStartX + self._config.slotGapX * column + 1)
      slot.icon:SetPosY(self._config.slotStartY + self._config.slotGapY * row + 1)
      slot.icon:SetEnableDragAndDrop(true)
      slot.icon:SetAutoDisableTime(0.2)
      if true == self._isConsole then
        slot.icon:addInputEvent("Mouse_LUp", "HandleEventRUp_Warehouse_All_Item(" .. ii .. ")")
      else
        slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Warehouse_All_Item(" .. ii .. ")")
        slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Warehouse_All_DropHandler(" .. ii .. ")")
        slot.icon:addInputEvent("Mouse_PressMove", "HandleEventPMove_Warehouse_All_SlotDrag(" .. ii .. ")")
      end
      slot.icon:addInputEvent("Mouse_On", "HandleEventMOn_Warehouse_All_IconOver(" .. ii .. ")")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventMOut_Warehouse_All_IconOut(" .. ii .. ")")
      UIScroll.InputEventByControl(slot.icon, "HandleEvent_Warehouse_All_Scroll")
      Panel_Tooltip_Item_SetPosition(ii, slot, "WareHouse")
      self._slots[ii] = slot
    end
    if nil ~= blankSlot then
      blankSlot.lock = UI.createAndCopyBasePropertyControl(self._ui._stc_itemSlotFrame, "Static_ItemSlotBg_LockIcon", self._ui._stc_itemSlotFrame, "Warehouse_Slot_Lock_" .. ii)
      blankSlot.plus = UI.createAndCopyBasePropertyControl(self._ui._stc_itemSlotFrame, "Static_MultipleSelect", self._ui._stc_itemSlotFrame, "Warehouse_Slot_Plus_" .. ii)
      blankSlot.onlyPlus = UI.createAndCopyBasePropertyControl(self._ui._stc_itemSlotFrame, "Static_ItemSlotBg_Plus", self._ui._stc_itemSlotFrame, "Warehouse_Slot_OnlyPlus_" .. ii)
      local row = math.floor(ii / self._config.slotCols)
      local column = ii % self._config.slotCols
      blankSlot.lock:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      blankSlot.lock:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      blankSlot.plus:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      blankSlot.plus:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      blankSlot.onlyPlus:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      blankSlot.onlyPlus:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      blankSlot.lock:SetShow(true)
      blankSlot.plus:SetShow(false)
      blankSlot.onlyPlus:SetShow(false)
    end
  end
end
function PaGlobal_WareHouse_All:updateInitSlot(useMaxCount, maxCount, useStartSlot)
  for ii = 0, self._config.slotCount - 1 do
    local slot = self._blankSlots[ii]
    self._slots[ii].icon:SetShow(true)
    slot.empty:SetShow(true)
    slot.lock:SetShow(false)
    slot.plus:SetShow(false)
    slot.onlyPlus:SetShow(false)
    if ii < useMaxCount - useStartSlot - self._startSlotIndex then
      slot.empty:SetShow(true)
    elseif ii == useMaxCount - useStartSlot - self._startSlotIndex and ii < maxCount - useStartSlot - self._startSlotIndex then
      if self._slots[ii].icon:GetShow() then
        local isBuyalbe = false
        if true == self:isNpc() then
          for wIndex = 0, #self._warehouseProductWaypoint do
            if PaGlobal_Warehouse_All_CurrentWaypointKey() == self._warehouseProductWaypoint[wIndex] then
              isBuyalbe = true
              break
            end
          end
        end
        if isBuyalbe and false == self._isConsole and _ContentsGroup_EasyBuy then
          slot.onlyPlus:SetShow(true)
          slot.onlyPlus:addInputEvent("Mouse_LUp", "HandleEventLUp_Warehouse_All_LDownClick(" .. ii .. ")")
        else
          slot.lock:SetShow(true)
        end
      else
        slot.plus:SetShow(true)
      end
      Panel_Window_Warehouse:SetChildIndex(slot.plus, 15099)
      Panel_Window_Warehouse:SetChildIndex(slot.onlyPlus, 15100)
    elseif ii >= maxCount - useStartSlot - self._startSlotIndex then
      self._slots[ii].icon:SetShow(false)
      slot.empty:SetShow(false)
    else
      slot.lock:SetShow(true)
    end
  end
  UIScroll.SetButtonSize(self._ui._scroll_warehouse, self._config.slotCount, maxCount - useStartSlot)
  for ii = 0, self._config.slotCount - 1 do
    local slot = self._slots[ii]
    slot:clearItem()
    slot.icon:SetEnable(true)
    if false == _ContentsGroup_NewDelivery then
      slot.icon:SetMonoTone(true)
    end
  end
end
function PaGlobal_WareHouse_All:updateAssetManagement(slotNoList, useMaxCount, money_s64)
  if true == self:isGuildHouse() or true == self:isGuildItemShare() or true == self:isGuildSafe() then
    return
  end
  local warehouseWrapper = self:getWarehouse()
  if nil == warehouseWrapper then
    return
  end
  self._myAsset = toInt64(0, 0)
  if useMaxCount >= 2 then
    for ii = 0, useMaxCount - 2 do
      local slotNo = slotNoList[1 + ii + 0]
      local itemWrapper = warehouseWrapper:getItem(slotNo)
      if nil ~= itemWrapper then
        local itemSSW = itemWrapper:getStaticStatus()
        local itemEnchantKey = itemSSW:get()._key:get()
        local itemCount_s64 = itemWrapper:get():getCount_s64()
        local npcSellPrice_s64 = itemSSW:get()._sellPriceToNpc_s64
        if true == _ContentsGroup_RenewUI_ItemMarketPlace_Only then
          local marketPriceByWarehouse = ToClient_getWorldMarketPriceToWareHouse(itemEnchantKey)
          if marketPriceByWarehouse > toInt64(0, 0) then
            self._myAsset = self._myAsset + marketPriceByWarehouse * itemCount_s64
          else
            self._myAsset = self._myAsset + npcSellPrice_s64 * itemCount_s64
          end
        else
          local tradeInfo
          local tradeSummaryInfo = getItemMarketSummaryInClientByItemEnchantKey(itemEnchantKey)
          local tradeMasterInfo = getItemMarketMasterByItemEnchantKey(itemEnchantKey)
          if nil ~= tradeSummaryInfo then
            tradeInfo = tradeSummaryInfo
          elseif nil ~= tradeMasterInfo then
            tradeInfo = tradeMasterInfo
          else
            tradeInfo = nil
          end
          if nil ~= tradeInfo then
            if nil ~= tradeSummaryInfo and toInt64(0, 0) ~= tradeSummaryInfo:getDisplayedTotalAmount() then
              self._myAsset = self._myAsset + (tradeInfo:getDisplayedLowestOnePrice() + tradeInfo:getDisplayedHighestOnePrice()) / toInt64(0, 2) * itemCount_s64
            else
              self._myAsset = self._myAsset + (tradeMasterInfo:getMinPrice() + tradeMasterInfo:getMaxPrice()) / toInt64(0, 2) * itemCount_s64
            end
          else
            self._myAsset = self._myAsset + npcSellPrice_s64 * itemCount_s64
          end
        end
      end
    end
  end
  self._ui._txt_assetTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WAREHOUSE_ASSETS"))
  self._ui._txt_valueAsset:SetText(makeDotMoney(self._myAsset + money_s64))
end
function PaGlobal_WareHouse_All:updateSlot(slotNoList)
  local warehouseWrapper = self:getWarehouse()
  if nil == warehouseWrapper then
    return
  end
  local isOpenGuildPresentPanel = Panel_Window_GuildPresent:GetShow()
  self._maxFindItemCnt = 0
  self._findItemIdx = {}
  for ii = 0, self._config.slotCount - 1 do
    local slot = self._slots[ii]
    local slotNo = slotNoList[1 + ii + self._startSlotIndex]
    slot.slotNo = slotNo
    slot.icon:EraseAllEffect()
    slot._isLockedItem = false
    local row = math.floor(ii / self._config.slotCols)
    local column = ii % self._config.slotCols
    slot.icon:SetPosX(self._config.slotStartX + self._config.slotGapX * column + 1)
    slot.icon:SetPosY(self._config.slotStartY + self._config.slotGapY * row + 1)
    slot.icon:SetMonoTone(false)
    slot.count:SetShow(false)
    local itemExist = false
    if nil == slotNo then
      slot:clearItem()
      slot.icon:SetEnableDragAndDrop(false)
    else
      local itemWrapper = warehouseWrapper:getItem(slotNo)
      if nil ~= itemWrapper then
        slot:setItem(itemWrapper, slotNo, nil, warehouseWrapper)
        if true == itemWrapper:isSoulCollector() then
          local curSoulCount = itemWrapper:getSoulCollectorCount()
          local maxSoulCount = itemWrapper:getSoulCollectorMaxCount()
          local itemIconPath = itemWrapper:getStaticStatus():getIconPath()
          if curSoulCount == 0 then
            slot.icon:ChangeTextureInfoNameAsync("icon/" .. itemIconPath)
          elseif curSoulCount > 0 and curSoulCount < maxSoulCount then
            slot.icon:ChangeTextureInfoNameAsync("New_UI_Common_forLua/ExceptionIcon/00040351_1.dds")
          else
            slot.icon:ChangeTextureInfoNameAsync("New_UI_Common_forLua/ExceptionIcon/00040351_2.dds")
          end
          local x1, y1, x2, y2 = setTextureUV_Func(slot.icon, 0, 0, 42, 42)
          slot.icon:getBaseTexture():setUV(x1, y1, x2, y2)
          slot.icon:setRenderTexture(slot.icon:getBaseTexture())
        end
        local itemKey = itemWrapper:getStaticStatus():getItemKey()
        local isExistSearchResult = ToClient_isExistUserBaseItemSearchResult(itemKey)
        if isExistSearchResult == true then
          slot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
          self._maxFindItemCnt = self._maxFindItemCnt + 1
          self._findItemIdx[self._maxFindItemCnt] = ii
        end
        local itemCountZero = false
        if true == _ContentsGroup_NewDelivery then
          local itemStatic = itemWrapper:getStaticStatus()
          if nil ~= itemStatic then
            local item = itemStatic:get()
            local warehouseItemCount = Int64toInt32(itemWrapper:get():getCount_s64())
            local packListItemCount = ToClient_NewDeliveryGetPackItemCountBySlotNo(slotNo)
            local warehouseRemainedItemCount = warehouseItemCount - packListItemCount
            if 0 == warehouseRemainedItemCount then
              itemCountZero = true
            end
          end
        end
        if nil ~= self.itemMarketFilterFunc then
          if false == self.itemMarketFilterFunc(slot.icon, itemWrapper) then
            if self._slotFilterEffect[ii] then
              slot.icon:EraseEffect(self._slotFilterEffect[ii])
              self._slotFilterEffect[ii] = nil
            end
            self._slotFilterEffect[ii] = slot.icon:AddEffect("UI_Inventory_Filtering", true, 0, 0)
            slot.icon:SetMonoTone(false)
            slot.icon:SetEnable(true)
            slot.icon:SetIgnore(false)
          else
            if self._slotFilterEffect[ii] then
              slot.icon:EraseEffect(self._slotFilterEffect[ii])
              self._slotFilterEffect[ii] = nil
            end
            slot.icon:SetMonoTone(true)
            slot.icon:SetEnable(false)
            slot.icon:SetIgnore(true)
          end
        elseif nil ~= self.manufactureFilterFunc then
          if false == self.manufactureFilterFunc(slot.slotNo, itemWrapper) then
            if self._slotFilterEffect[ii] then
              slot.icon:EraseEffect(self._slotFilterEffect[ii])
              self._slotFilterEffect[ii] = nil
            end
            self._slotFilterEffect[ii] = slot.icon:AddEffect("UI_Inventory_Filtering", true, 0, 0)
            slot.icon:SetMonoTone(false)
            slot.icon:SetEnable(true)
            slot.icon:SetIgnore(false)
          else
            if self._slotFilterEffect[ii] then
              slot.icon:EraseEffect(self._slotFilterEffect[ii])
              self._slotFilterEffect[ii] = nil
            end
            slot.icon:SetMonoTone(true)
            slot.icon:SetEnable(false)
            slot.icon:SetIgnore(true)
          end
        elseif nil ~= self.guildWareHouseFilterFunc then
          if false == self.guildWareHouseFilterFunc(itemWrapper) then
            if self._slotFilterEffect[ii] then
              slot.icon:EraseEffect(self._slotFilterEffect[ii])
              self._slotFilterEffect[ii] = nil
            end
            self._slotFilterEffect[ii] = slot.icon:AddEffect("UI_Inventory_Filtering", true, 0, 0)
            slot.icon:SetMonoTone(false)
            slot.icon:SetEnable(true)
            slot.icon:SetIgnore(false)
          else
            if self._slotFilterEffect[ii] then
              slot.icon:EraseEffect(self._slotFilterEffect[ii])
              self._slotFilterEffect[ii] = nil
            end
            slot.icon:SetMonoTone(true)
            slot.icon:SetEnable(false)
            slot.icon:SetIgnore(true)
          end
        else
          if self._slotFilterEffect[ii] then
            slot.icon:EraseEffect(self._slotFilterEffect[ii])
            self._slotFilterEffect[ii] = nil
          end
          if true == _ContentsGroup_NewDelivery then
            if true == itemCountZero then
              slot.icon:SetMonoTone(true)
              slot.count:SetText("")
            else
              slot.icon:SetMonoTone(false)
            end
            slot.icon:SetEnable(true)
            slot.icon:SetIgnore(false)
          else
            slot.icon:SetMonoTone(false)
            slot.icon:SetEnable(true)
            slot.icon:SetIgnore(false)
          end
        end
        if nil == self.itemMarketFilterFunc then
          local packingCount_s64 = 0
          if true == _ContentsGroup_NewDelivery then
            packingCount_s64 = ToClient_NewDeliveryGetPackItemCountBySlotNo(slotNo)
          else
            packingCount_s64 = delivery_getPackItemCount(slotNo)
          end
          if Defines.s64_const.s64_0 == itemWrapper:get():getCount_s64() then
            slot.icon:SetMonoTone(true)
          else
            slot.count:SetShow(true)
          end
        end
        if isOpenGuildPresentPanel == true then
          if itemWrapper:getStaticStatus():getContentsEventType() ~= __eContentsType_GuildPresentationItem then
            if self._slotFilterEffect[ii] then
              slot.icon:EraseEffect(self._slotFilterEffect[ii])
              self._slotFilterEffect[ii] = nil
            end
            slot.icon:SetMonoTone(true)
            if self._isConsole == false then
              slot.icon:SetEnable(false)
              slot.icon:SetIgnore(true)
            end
          else
            slot.icon:SetMonoTone(false)
            slot.icon:SetEnable(true)
            slot.icon:SetIgnore(false)
          end
        end
        itemExist = true
        slot.checkBox:SetShow(false)
      else
        if nil ~= self._slotFilterEffect[ii] then
          slot.icon:EraseEffect(self._slotFilterEffect[ii])
          self._slotFilterEffect[ii] = nil
        end
        slot.icon:SetMonoTone(false)
        slot.icon:SetEnable(true)
        slot.icon:SetIgnore(false)
      end
    end
    if not itemExist then
      slot:clearItem()
      slot.icon:SetEnable(true)
      slot.icon:SetMonoTone(true)
      slot.icon:SetIgnore(false)
    elseif self._blankSlots[ii].lock ~= nil and self._blankSlots[ii].lock:GetShow() == true then
      slot.icon:SetAlpha(0.5)
      slot.icon:SetMonoTone(true)
      slot.icon:EraseAllEffect()
      slot._isLockedItem = true
    end
    slot.icon:SetEnableDragAndDrop(self:isNpc() or self:isMaid())
  end
  if PaGlobal_WareHouse_All:isGuildHouse() == true then
    if warehouseWrapper:isExistGuildPresentItem() == false and Panel_Window_GuildPresent:GetShow() == true then
      self._ui._blockWarehouseBg:SetShow(true)
      local posX = self._ui._stc_rightBottomBg:GetPosX()
      local posY = self._ui._stc_rightBottomBg:GetPosY()
      local sizeX = self._ui._stc_itemSlotFrame:GetSizeX()
      local sizeY = self._ui._stc_itemSlotFrame:GetSizeY()
      self._ui._blockWarehouseBg:SetPosX(posX)
      self._ui._blockWarehouseBg:SetPosY(posY)
      self._ui._blockWarehouseBg:SetSize(sizeX, sizeY)
    else
      self._ui._blockWarehouseBg:SetShow(false)
    end
  else
    self._ui._blockWarehouseBg:SetShow(false)
  end
end
function PaGlobal_WareHouse_All:validate()
  if nil == Panel_Window_Warehouse then
    return
  end
  self._ui._pc._btn_close:isValidate()
  self._ui._pc._btn_question:isValidate()
  self._ui._pc._chk_horseBag:isValidate()
  self._ui._console._txt_keyGuideSort:isValidate()
  self._ui._console._txt_keyGuideClose:isValidate()
  self._ui._console._txt_keyGuideSelect:isValidate()
  self._ui._console._txt_keyGuideMarketInvenOpen:isValidate()
  self._ui._console._txt_keyGuideGuildPresent:isValidate()
  self._ui._console._txt_keyGuide_RTA:isValidate()
  self._ui._console._txt_keyGuide_RTX:isValidate()
  self._ui._chk_itemSort:isValidate()
  self._ui._btn_sortOption:isValidate()
  self._ui._stc_decoBg:isValidate()
  self._ui._txt_villageName:isValidate()
  self._ui._txt_valueMoney:isValidate()
  self._ui._txt_valueAsset:isValidate()
  self._ui._txt_capacity:isValidate()
  self._ui._stc_itemSlotFrame:isValidate()
  self._ui._stc_itemSlotBg:isValidate()
  self._ui._stc_lockIcon:isValidate()
  self._ui._stc_multipleSelect:isValidate()
  self._ui._scroll_warehouse:isValidate()
  self._ui._btn_deliveryInfomation:isValidate()
  self._ui._btn_itemMarketRegist:isValidate()
  self._ui._btn_manufacture:isValidate()
  self._ui._txt_notAvaliable:isValidate()
  self._ui._list2_serchWareHouse:isValidate()
  self._ui._stc_topBg:isValidate()
  self._ui._stc_rightTopBg:isValidate()
  self._ui._stc_rightBottomBg:isValidate()
  self._ui._stc_leftBg:isValidate()
  self._ui._stc_bottomBg:isValidate()
  self._ui._blockWarehouseBg:isValidate()
end
function PaGlobal_WareHouse_All:isNpc()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc == self._fromType
end
function PaGlobal_WareHouse_All:isInstallation()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_Installation == self._fromType
end
function PaGlobal_WareHouse_All:isWorldMapNode()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_Worldmap == self._fromType
end
function PaGlobal_WareHouse_All:isGuildHouse()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_GuildHouse == self._fromType
end
function PaGlobal_WareHouse_All:isMaid()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid == self._fromType
end
function PaGlobal_WareHouse_All:isManufacture()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_Manufacture == self._fromType
end
function PaGlobal_WareHouse_All:isGuildSafe()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_GuildSafe == self._fromType
end
function PaGlobal_WareHouse_All:isFurnitureWareHouse()
  if true == _ContentsGroup_isFurnitureWarehouse then
    return CppEnums.WarehoouseFromType.eWarehoouseFromType_Furniture == self._fromType
  else
    return false
  end
end
function PaGlobal_WareHouse_All:isGuildItemShare()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_GuildItemShare == self._fromType
end
function PaGlobal_WareHouse_All:isDeliveryWindow()
  return PaGlobalFunc_PanelDelivery_GetShow()
end
function PaGlobal_WareHouse_All:getWarehouse()
  local warehouseWrapper
  if PaGlobal_WareHouse_All:isGuildHouse() then
    warehouseWrapper = warehouse_getGuild()
  elseif PaGlobal_WareHouse_All:isFurnitureWareHouse() then
    warehouseWrapper = ToClient_getFurniturewarehouse()
  elseif PaGlobal_WareHouse_All:isGuildItemShare() then
    warehouseWrapper = warehouse_getGuild()
  elseif PaGlobal_WareHouse_All:isGuildSafe() then
    warehouseWrapper = warehouse_getGuild()
  elseif 0 ~= self._currentWaypointKey then
    warehouseWrapper = warehouse_get(self._currentWaypointKey)
  end
  return warehouseWrapper
end
function PaGlobal_WareHouse_All:resizePanelChange(isNpc)
  local bigSizeY
  if isNpc then
    bigSizeY = self.addSizeY
  else
    bigSizeY = 0
    self._ui._txt_capacity:SetPosY(self._staticCapacityPosY + bigSizeY)
  end
  PaGlobal_WareHouse_All._ui._stc_moneyBg:SetShow(true)
  PaGlobal_WareHouse_All._ui._txt_ItemShare_Desc:SetShow(false)
  if not self:isGuildHouse() and not self:isGuildItemShare() and not self:isGuildSafe() then
    local moneybgSizeY = self._defaultMoneyBgSize.y * 0.6
    local halfSizeY = self._defaultMoneyBgSize.y - moneybgSizeY
    local btn_historySize = 10
    if PaGlobal_WareHouse_All:isMaid() == false then
      btn_historySize = self._ui._btn_wareHouseHistory:GetSizeY() + 10
    end
    Panel_Window_Warehouse:SetSize(Panel_Window_Warehouse:GetSizeX(), self._panelSizeY - bigSizeY - halfSizeY + btn_historySize)
    self._ui._stc_rightBottomBg:SetSize(self._defaultRightBgSize.x, self._defaultRightBgSize.y - halfSizeY)
    self._ui._stc_moneyBg:SetSize(self._defaultMoneyBgSize.x, moneybgSizeY)
    if nil ~= Panel_Window_Inventory_All and not ToClient_WorldMapIsShow() then
      Panel_Window_Warehouse:SetPosX(getScreenSizeX() - Panel_Window_Warehouse:GetSizeX() - Panel_Window_Inventory_All:GetSizeX() - 15)
      Panel_Window_Warehouse:SetPosY(getScreenSizeY() / 2 - Panel_Window_Warehouse:GetSizeY() / 2)
    end
    if true == _ContentsGroup_isAllWarehouse then
      self._ui._stc_leftBg:SetSize(self._ui._stc_leftBg:GetSizeX(), self._panelSizeY - halfSizeY * 3.2)
      self._ui._list2_serchWareHouse:SetSize(self._ui._list2_serchWareHouse:GetSizeX(), self._panelSizeY - halfSizeY * 3.2)
    end
    self._ui._txt_assetTitle:SetPosY(self._assetTitlePosY - self._defaultMoneyBgSize.y + moneybgSizeY)
    self._ui._txt_valueAsset:SetPosY(self._assetValuePosY - self._defaultMoneyBgSize.y + moneybgSizeY)
    self._ui._btn_asset:SetPosY(self._assetValuePosY - self._defaultMoneyBgSize.y + moneybgSizeY - 10)
    if self._ui._btn_wareHouseHistory:GetShow() == true and PaGlobal_WareHouse_All:isMaid() == false then
      self._ui._stc_leftBg:SetSize(self._ui._stc_leftBg:GetSizeX(), self._panelSizeY - halfSizeY * 3.2 + self._ui._btn_wareHouseHistory:GetSizeY())
      self._ui._list2_serchWareHouse:SetSize(self._ui._list2_serchWareHouse:GetSizeX(), self._panelSizeY - halfSizeY * 3.2 + self._ui._btn_wareHouseHistory:GetSizeY())
    end
  elseif true == self:isGuildItemShare() and true == _ContentsGroup_GuildShareItemWareHouse then
    PaGlobal_WareHouse_All._ui._stc_moneyBg:SetShow(false)
    PaGlobal_WareHouse_All._ui._txt_ItemShare_Desc:SetShow(true)
    self._ui._txt_ItemShare_Desc:SetSpanSize(self._ui._txt_ItemShare_Desc:GetSpanSize().x, self._ui._stc_moneyBg:GetSpanSize().y + 5)
    local descSizeY = self._ui._txt_ItemShare_Desc:GetSizeY()
    local moneybgSizeY = self._defaultMoneyBgSize.y * 0.6
    local halfSizeY = self._defaultMoneyBgSize.y - moneybgSizeY
    self._ui._stc_rightBottomBg:SetSize(self._defaultRightBgSize.x, self._defaultRightBgSize.y - moneybgSizeY + descSizeY)
    Panel_Window_Warehouse:SetSize(Panel_Window_Warehouse:GetSizeX(), self._panelSizeY - moneybgSizeY + descSizeY)
  else
    local moneybgSizeY = self._defaultMoneyBgSize.y * 0.6
    local halfSizeY = self._defaultMoneyBgSize.y - moneybgSizeY
    Panel_Window_Warehouse:SetSize(Panel_Window_Warehouse:GetSizeX(), self._panelSizeY - bigSizeY - halfSizeY)
    self._ui._stc_rightBottomBg:SetSize(self._defaultRightBgSize.x, self._defaultRightBgSize.y - halfSizeY)
    self._ui._stc_moneyBg:SetSize(self._defaultMoneyBgSize.x, moneybgSizeY)
  end
  self._ui._stc_leftBg:ComputePos()
  self._ui._stc_bottomBg:ComputePos()
  if false == self._isConsole and CppEnums.WarehoouseFromType.eWarehoouseFromType_Manufacture == self._fromType then
    Panel_Window_Warehouse:SetSize(Panel_Window_Warehouse:GetSizeX(), Panel_Window_Warehouse:GetSizeY() - self._ui._btn_itemMarketRegist:GetSizeY() - 5)
  end
  self._ui._btn_deliveryInfomation:ComputePos()
  self._ui._btn_itemMarketRegist:ComputePos()
  self._ui._btn_manufacture:ComputePos()
  self._ui._btn_guildUpdate:ComputePos()
  self._ui._btn_guildLog:ComputePos()
  self:setGuildPresentButton()
end
function PaGlobal_WareHouse_All:pushFromInventoryItem(s64_count, slotNo, whereType)
  local itemSSW = PaGlobal_WareHouse_All:getInventoryItemStaticStatus(slotNo, whereType)
  if itemSSW == nil then
    return
  end
  local isMoveUnstackableItemByOnce = PaGlobal_WareHouse_All:checkMoveUnstackableItemByOnce(s64_count, itemSSW)
  if self:isNpc() == true then
    if dialog_isEventWarehouseNpc() == true then
      warehouse_requestInfo(warehouse_getEventWarehouseWaypointKey())
    else
      warehouse_requestInfo(self._currentWaypointKey)
    end
    if isMoveUnstackableItemByOnce == true then
      ToClient_pushNonStackItemToWareHouse(PaGlobal_WareHouse_All._targetActorKeyRaw, false, whereType, s64_count, PaGlobal_WareHouse_All._currentWaypointKey)
    else
      warehouse_pushFromInventoryItemByNpc(whereType, slotNo, s64_count, PaGlobal_WareHouse_All._targetActorKeyRaw, PaGlobal_WareHouse_All._currentWaypointKey)
    end
  elseif PaGlobal_WareHouse_All:isInstallation() then
    warehouse_pushFromInventoryItemByInstallation(PaGlobal_WareHouse_All._installationActorKeyRaw, whereType, slotNo, s64_count, PaGlobal_WareHouse_All._targetActorKeyRaw, PaGlobal_WareHouse_All._currentWaypointKey, isMoveUnstackableItemByOnce)
  elseif PaGlobal_WareHouse_All:isGuildHouse() then
    if ToClient_checkGuildWarehouseUseMaid() == true then
      local function acceptFunction()
        warehouse_pushFromInventoryItemByGuildHouse(whereType, slotNo, s64_count, PaGlobal_WareHouse_All._targetActorKeyRaw, isMoveUnstackableItemByOnce)
      end
      local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_OTHERINVENTORY_ITEM_MOVE_TO_GUILDWAREHOUSE_MESSAGE", "count", tostring(ToClient_getUsableMaidCountByType(false)))
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
        content = messageBoxMemo,
        functionYes = acceptFunction,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    else
      warehouse_pushFromInventoryItemByGuildHouse(whereType, slotNo, s64_count, PaGlobal_WareHouse_All._targetActorKeyRaw, isMoveUnstackableItemByOnce)
    end
  elseif PaGlobal_WareHouse_All:isGuildSafe() then
    ToClient_pushFromInventoryItemByGuildSafe(whereType, slotNo, s64_count, PaGlobal_WareHouse_All._targetActorKeyRaw)
  elseif PaGlobal_WareHouse_All:isFurnitureWareHouse() then
    ToClient_pushFromInventoryItemByFurnitureWarehouse(whereType, slotNo)
  elseif PaGlobal_WareHouse_All:isMaid() then
    if getRegionInfoByPosition(getSelfPlayer():get():getPosition()) == nil then
      return
    end
    if checkMaid_WarehouseIn(true) == true then
      local moveCountWhenUseMaid = ToClient_getMoveCountWhenUseMaid(itemSSW:getItemKey(), s64_count, false)
      if moveCountWhenUseMaid == Defines.s64_const.s64_0 then
        return
      end
      local moveCountOnce = toInt64(0, 0)
      if true == _ContentsGroup_UseMultiMaid and true == self._isUseMultiMaid then
        if isMoveUnstackableItemByOnce == true then
          ToClient_pushNonStackItemToWareHouse(PaGlobal_WareHouse_All._targetActorKeyRaw, true, whereType, s64_count, PaGlobal_WareHouse_All._currentWaypointKey)
          return
        end
        local weight = Int64toInt32(itemSSW:get()._weight) / 10000
        if false == itemSSW:isMoney() then
          local dividedByWeight = 0
          if weight > 0 then
            dividedByWeight = math.floor(100 / weight)
          end
          moveCountOnce = toInt64(0, math.min(dividedByWeight, Int64toInt32(s64_count)))
        end
        if ToClient_getUsableMaidCountByType(false) == 0 then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantFindUseableMaid"))
          return
        end
      end
      warehouse_pushFromInventoryItemByMaid(whereType, slotNo, moveCountWhenUseMaid, PaGlobal_WareHouse_All._targetActorKeyRaw, moveCountOnce, PaGlobal_WareHouse_All._currentWaypointKey)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_COOLTIME"))
    end
  elseif true == PaGlobal_WareHouse_All:isGuildItemShare() then
    if false == _ContentsGroup_GuildShareItemWareHouse then
      return
    end
    local function msgFunc_PushGuildItem()
      ToClient_PushGuildRentalItem(whereType, slotNo)
    end
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ITEMSHARE_RENT_RESIST"),
      functionYes = msgFunc_PushGuildItem,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData, "middle", false, false)
  end
end
function PaGlobal_WareHouse_All:popToSomewhere(s64_count, slotNo)
  if nil == slotNo then
    return
  end
  local itemSSW = PaGlobal_WareHouse_All:getWarehouseItemStaticStatus(slotNo)
  if itemSSW == nil then
    return
  end
  local itemKey = itemSSW:getItemKey()
  local weight = itemSSW:getWeight() / 10000
  local isMoveUnstackableItemByOnce = PaGlobal_WareHouse_All:checkMoveUnstackableItemByOnce(s64_count, itemSSW)
  local invenIsShow = false
  if true == _ContentsGroup_RenewUI_InventoryEquip then
    invenIsShow = PaGlobalFunc_InventoryInfo_GetShow()
  elseif true == _ContentsGroup_NewUI_Inventory_All then
    invenIsShow = Panel_Window_Inventory_All:GetShow()
  else
    invenIsShow = Panel_Window_Inventory:GetShow()
  end
  if invenIsShow and GetUIMode() ~= Defines.UIMode.eUIMorwrde_WorldMap then
    if self:isDeliveryWindow() == true then
      DeliveryRequest_PushPackingItem(slotNo, s64_count)
    elseif self:isNpc() == true then
      if dialog_isEventWarehouseNpc() == true then
        warehouse_requestInfo(warehouse_getEventWarehouseWaypointKey())
      else
        warehouse_requestInfo(self._currentWaypointKey)
      end
      if isMoveUnstackableItemByOnce == true then
        ToClient_popNonStackItemFromWarehouse(self._targetActorKeyRaw, false, s64_count, PaGlobal_WareHouse_All._currentWaypointKey)
        return
      end
      warehouse_popToInventoryByNpc(slotNo, s64_count, self._targetActorKeyRaw, self._currentWaypointKey)
    elseif self:isInstallation() then
      warehouse_popToInventoryByInstallation(self._installationActorKeyRaw, slotNo, s64_count, self._targetActorKeyRaw, PaGlobal_WareHouse_All._currentWaypointKey, isMoveUnstackableItemByOnce)
    elseif self:isGuildHouse() then
      if ToClient_checkGuildWarehouseUseMaid() == true then
        do
          local moveCountWhenUseMaid = ToClient_getMoveCountWhenUseMaid(itemKey, s64_count, true)
          if moveCountWhenUseMaid == Defines.s64_const.s64_0 then
            return
          end
          local function acceptFunction()
            warehouse_popToInventoryByGuildHouse(slotNo, moveCountWhenUseMaid, self._targetActorKeyRaw, isMoveUnstackableItemByOnce)
          end
          local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_OTHERINVENTORY_ITEM_MOVE_MESSAGE", "count", tostring(ToClient_getUsableMaidCountByType(false)))
          local messageBoxData = {
            title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
            content = messageBoxMemo,
            functionYes = acceptFunction,
            functionNo = MessageBox_Empty_function,
            priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
          }
          MessageBox.showMessageBox(messageBoxData)
        end
      else
        warehouse_popToInventoryByGuildHouse(slotNo, s64_count, self._targetActorKeyRaw, isMoveUnstackableItemByOnce)
      end
    elseif self:isGuildSafe() then
      ToClient_popToInventoryByGuildSafe(slotNo, s64_count, self._targetActorKeyRaw)
    elseif self:isFurnitureWareHouse() then
      ToClient_popToInventoryByFurnitureWarehouse(slotNo)
    elseif self:isMaid() then
      local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
      if nil == regionInfo then
        return
      end
      local warehouseOutMaid = checkMaid_WarehouseOut(true)
      if warehouseOutMaid then
        local moveCountWhenUseMaid = ToClient_getMoveCountWhenUseMaid(itemKey, s64_count, false)
        if moveCountWhenUseMaid == Defines.s64_const.s64_0 then
          return
        end
        warehouse_requestInfo(self._currentWaypointKey)
        local moveCountOnce = toInt64(0, 0)
        if true == _ContentsGroup_UseMultiMaid and true == self._isUseMultiMaid then
          if false == itemSSW:isMoney() then
            if isMoveUnstackableItemByOnce == true then
              ToClient_popNonStackItemFromWarehouse(self._targetActorKeyRaw, true, s64_count, PaGlobal_WareHouse_All._currentWaypointKey)
              return
            end
            if 0 > Int64toInt32(s64_count) then
              s64_count = toInt64(0, 2147483647)
            end
            local dividedByWeight = 0
            if weight > 0 then
              dividedByWeight = math.floor(100 / weight)
            end
            moveCountOnce = toInt64(0, math.min(math.floor(dividedByWeight), Int64toInt32(s64_count)))
          end
          warehouse_popToInventoryByMaid(slotNo, moveCountWhenUseMaid, self._targetActorKeyRaw, moveCountOnce, self._currentWaypointKey)
        else
          warehouse_popToInventoryByMaid(slotNo, moveCountWhenUseMaid, self._targetActorKeyRaw, moveCountOnce, self._currentWaypointKey)
        end
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_COOLTIME"))
      end
    elseif true == self:isGuildItemShare() then
      PaGlobalFunc_Warehouse_All_RequestGuildItemShare(slotNo)
    end
  elseif self:isDeliveryWindow() == true then
    DeliveryRequest_PushPackingItem(slotNo, s64_count)
  end
end
function PaGlobal_WareHouse_All:openPanelFromDialog()
  warehouse_clearSellToSystem()
  if true == _ContentsGroup_RenewUI_ItemMarketPlace_Only and PaGlobalFunc_MarketWallet_GetShow() then
    PaGlobalFunc_MarketWallet_ForceClose()
  end
  if true == _ContentsGroup_isAllWarehouse then
    PaGlobal_WareHouse_All:searchMenuOpen()
  end
  if dialog_isEventWarehouseNpc() == true then
    self:openPanel(warehouse_getEventWarehouseWaypointKey(), CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc)
  else
    self:openPanel(getCurrentWaypointKey(), CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc)
  end
  PaGlobal_Warehouse_All_SetIgnoreMoneyButton(false)
  if true == self._isConsole then
    Panel_Window_Warehouse:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_Warehouse:GetSizeX() - 5)
  end
  self:openWithInventory(PaGlobal_Warehouse_All_BasicItemFilter)
  if PaGlobalFunc_ItemMarketRegistItem_GetShow() then
    FGlobal_ItemMarketRegistItem_Close()
  end
end
function PaGlobal_WareHouse_All:openPanelFromDialogWithoutInventory(waypointKey, fromType)
  self:openPanel(waypointKey, fromType)
  PaGlobal_Warehouse_All_SetIgnoreMoneyButton(true)
  if ToClient_WorldMapIsShow() then
    Panel_Window_Warehouse:SetVerticalMiddle()
    Panel_Window_Warehouse:SetHorizonRight()
    Panel_Window_Warehouse:SetSpanSize(10, 0)
  end
end
function PaGlobal_WareHouse_All:openPanelFromWorldmap(waypointKey, fromType)
  if ToClient_WorldMapIsShow() then
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Window_Warehouse, true)
    Panel_Window_Warehouse:SetHorizonRight()
    Panel_Window_Warehouse:SetVerticalMiddle()
    Panel_Window_Warehouse:SetSpanSize(10, 0)
  end
  self:openPanel(waypointKey, fromType)
  PaGlobal_Warehouse_All_SetIgnoreMoneyButton(true)
  PaGlobal_Warehouse_All_OtherWaypointKey(waypointKey)
  if false == PaGlobal_Warehouse_All_IsMoveItem() then
    DeliveryRequestWindow_Close()
  end
  if true == self._ui._btn_itemMarketRegist:GetShow() then
    self._ui._btn_itemMarketRegist:SetShow(false)
  end
  self._buttonData.marketRegist = false
  if _ContentsGroup_SellItemInOtherWarehouse == true and fromType == CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc and ToClient_ablePushOrPopOtherWareHouse(self._currentWaypointKey) == true then
    self._buttonData.marketRegist = true
    self._buttonData.cargosell = true
    self._buttonData.delivery = false
  end
  if self._isConsole == true and self._buttonData.autoMove == false then
    Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
  end
  self:setInventoryItemMoveEvent(false)
end
function PaGlobal_WareHouse_All:openPanelFromMaid(isMultiUseMaid)
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if nil == regionInfo then
    return
  end
  local regionInfoWrapper = getRegionInfoWrapper(regionInfo:getAffiliatedTownRegionKey())
  local plantWayKey = regionInfoWrapper:getPlantKeyByWaypointKey():getWaypointKey()
  local regionKey = regionInfoWrapper:getRegionKey()
  if ToClient_IsAccessibleRegionKey(regionKey) == false then
    plantWayKey = ToClient_GetOtherRegionKey_NeerByTownRegionKey()
    if 0 == plantWayKey then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CANTFIND_WAREHOUSE_INTERRITORY"))
      return
    end
  end
  if nil == isMultiUseMaid then
    isMultiUseMaid = false
  end
  self._isUseMultiMaid = isMultiUseMaid
  self._currentWaypointKey = plantWayKey
  self:openPanel(plantWayKey, CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid)
  PaGlobal_Warehouse_All_SetIgnoreMoneyButton(false)
  if _ContentsGroup_isAllWarehouse == true then
    PaGlobal_WareHouse_All:searchMenuOpen()
  else
    self:openWithInventory(PaGlobal_Warehouse_All_BasicItemFilter)
  end
  if PaGlobalFunc_Inventory_UpdateInventoryBottomBG ~= nil then
    PaGlobalFunc_Inventory_UpdateInventoryBottomBG()
  end
end
function PaGlobal_WareHouse_All:openPanel(waypointKey, fromType)
  self._currentWaypointKey = waypointKey
  self._fromType = fromType
  self._currentRegionName = getRegionNameByWaypointKey(self._currentWaypointKey)
  local selfPlayerCurrentWayPointKey = getCurrentWaypointKey()
  if CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid ~= fromType then
    self._isUseMultiMaid = false
  end
  if self:isGuildHouse() == true or self:isFurnitureWareHouse() == true then
    self._ui._stc_title:SetText(self._warehouseTitle)
  elseif self:isGuildItemShare() == true then
    self._ui._stc_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ITEMSHARE_TITLE"))
  else
    self._ui._stc_title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WAREHOUSE_ALL_TITLE_VILLAGE", "vilageName", self._currentRegionName))
  end
  PaGlobalFunc_AutoSortFunctionPanel_LoadSortOptionAndDoSort(InvenSortLinkPanelIndex.WareHouse)
  self:initButtonData()
  if self:isWorldMapNode() == true then
    local regionInfoWrapper = ToClient_getRegionInfoWrapperByWaypoint(waypointKey)
    if regionInfoWrapper ~= nil then
      if _ContentsGroup_NewDelivery == true and regionInfoWrapper:getRegionKey() ~= 821 and regionInfoWrapper:getRegionKey() ~= 694 and regionInfoWrapper:getRegionKey() ~= 693 then
        self._buttonData.delivery = true
      elseif regionInfoWrapper:get():hasDeliveryNpc() == true then
        self._buttonData.delivery = true
      end
    end
    self._ui._pc._chk_horseBag:SetShow(false)
  elseif self:isNpc() == true and selfPlayerCurrentWayPointKey ~= self._currentWaypointKey then
    local regionInfoWrapper = ToClient_getRegionInfoWrapperByWaypoint(waypointKey)
    if _ContentsGroup_NewDelivery == true and regionInfoWrapper:getRegionKey() ~= 821 and regionInfoWrapper:getRegionKey() ~= 694 and regionInfoWrapper:getRegionKey() ~= 693 then
      self._buttonData.delivery = true
    end
  end
  ToClient_NewDeliveryClearPack()
  self._buttonData.manufacture = false
  self._buttonData.cargosell = false
  if (CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc == self._fromType or CppEnums.WarehoouseFromType.eWarehoouseFromType_Manufacture == self._fromType) and ToClient_isPossibleManufactureAtWareHouse() == true and selfPlayerCurrentWayPointKey == self._currentWaypointKey then
    if self._isConsole == true then
      local isManufactureOpen = Panel_Window_Manufacture_All:GetShow()
      if isManufactureOpen == false and self:isDeliveryWindow() == false then
        self._buttonData.manufacture = true
      end
    else
      self._buttonData.manufacture = true
    end
  end
  if CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc == self._fromType and true == _ContentsGroup_CargoSell and selfPlayerCurrentWayPointKey == self._currentWaypointKey then
    self._buttonData.cargosell = true
  end
  if self:isGuildHouse() == false and self:isFurnitureWareHouse() == false then
    if ToClient_isConsole() == false then
      self._buttonData.warehouseHistory = true
    else
      self._buttonData.warehouseHistory = false
    end
  end
  local myRegionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local hasItemMarket = myRegionInfo:get():hasItemMarketNpc()
  if _ContentsGroup_SellItemInOtherWarehouse == true then
    hasItemMarket = true
  end
  if hasItemMarket == true and nil ~= dialog_getTalker() and dialog_isTalking() == true and not self:isGuildHouse() and not self:isGuildItemShare() and CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc == self._fromType then
    self._buttonData.marketRegist = true
  else
    self._buttonData.marketRegist = false
  end
  if _ContentsGroup_RenewUI == true and self:isInstallation() == true then
    self._buttonData.marketRegist = false
  end
  self._buttonData.sendMoney = false
  if PaGlobal_Warehouse_All_IsMoveItem() == true and self._isConsole == true and self:isDeliveryWindow() == false then
    PaGlobal_Warehouse_All_SetIgnoreMoneyButton(false)
  end
  self._buttonData.autoMove = false
  if _ContentsGroup_ItemMove == true and (CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc == self._fromType or CppEnums.WarehoouseFromType.eWarehoouseFromType_Installation == self._fromType or CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid == self._fromType) then
    local ablePushOrPopOtherWarehouse = ToClient_ablePushOrPopOtherWareHouse(self._currentWaypointKey)
    if selfPlayerCurrentWayPointKey == self._currentWaypointKey or ablePushOrPopOtherWarehouse == true then
      self._buttonData.autoMove = true
      if self._isConsole == true then
        Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobalFunc_WareHouseFunctionPanel_All_Open()")
      end
    end
  end
  self._buttonData.guildUpdate = false
  if self._isSetPanelPosition == false then
    self:resizePanelChange(self:isNpc())
  end
  Panel_Window_Warehouse:ChangeSpecialTextureInfoName("")
  self._startSlotIndex = 0
  self._ui._scroll_warehouse:SetControlTop()
  self._ui._scroll_warehouse:SetControlPos(0)
  warehouse_requestInfo(self._currentWaypointKey)
  PaGlobalFunc_InterestKnowledge_All_Close()
  self:update()
  self:updateButtonInfo()
  if CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc == self._fromType then
    local buttonSizeGap = 10
    if self._ui._btn_itemMarketRegist:GetShow() == true then
      if self._ui._btn_manufacture:GetShow() == true then
        if _ContentsGroup_CargoSell == true then
          local buttonSizeX = (self._ui._stc_moneyBg:GetSizeX() - buttonSizeGap * 2) / 3
          self._ui._btn_itemMarketRegist:SetSize(buttonSizeX, self._ui._btn_itemMarketRegist:GetSizeY())
          self._ui._btn_manufacture:SetSize(buttonSizeX, self._ui._btn_itemMarketRegist:GetSizeY())
          self._ui._btn_manufacture:SetSpanSize(buttonSizeX + buttonSizeGap, self._btnMarketRegSpanSizeY + self.addSizeY)
          self._ui._btn_cargoCell:SetSize(buttonSizeX, self._ui._btn_itemMarketRegist:GetSizeY())
          self._ui._btn_cargoCell:SetSpanSize(2, self._btnMarketRegSpanSizeY + self.addSizeY)
          self._ui._btn_cargoCell:SetShow(true)
          self._ui._btn_itemMarketRegist:SetSpanSize(buttonSizeGap * 2 + buttonSizeX * 2, self._btnMarketRegSpanSizeY + self.addSizeY)
        else
          local buttonSizeX = (self._ui._stc_moneyBg:GetSizeX() - buttonSizeGap) / 2
          self._ui._btn_itemMarketRegist:SetSize(buttonSizeX, self._ui._btn_itemMarketRegist:GetSizeY())
          self._ui._btn_manufacture:SetSize(buttonSizeX, self._ui._btn_itemMarketRegist:GetSizeY())
          self._ui._btn_manufacture:SetSpanSize(2, self._btnMarketRegSpanSizeY + self.addSizeY)
          self._ui._btn_itemMarketRegist:SetSpanSize(buttonSizeX + buttonSizeGap, self._btnMarketRegSpanSizeY + self.addSizeY)
          self._ui._btn_cargoCell:SetShow(false)
        end
      elseif _ContentsGroup_CargoSell == true then
        local buttonSizeX = (self._ui._stc_moneyBg:GetSizeX() - buttonSizeGap) / 2
        self._ui._btn_itemMarketRegist:SetSize(buttonSizeX, self._ui._btn_itemMarketRegist:GetSizeY())
        self._ui._btn_cargoCell:SetSize(buttonSizeX, self._ui._btn_itemMarketRegist:GetSizeY())
        self._ui._btn_cargoCell:SetSpanSize(2, self._btnMarketRegSpanSizeY + self.addSizeY)
        self._ui._btn_cargoCell:SetShow(true)
        self._ui._btn_itemMarketRegist:SetSpanSize(buttonSizeX + buttonSizeGap, self._btnMarketRegSpanSizeY + self.addSizeY)
      else
        self._ui._btn_cargoCell:SetShow(false)
        self._ui._btn_itemMarketRegist:SetSize(self._ui._stc_moneyBg:GetSizeX(), self._ui._btn_itemMarketRegist:GetSizeY())
        self._ui._btn_itemMarketRegist:SetSpanSize(2, self._btnMarketRegSpanSizeY + self.addSizeY)
      end
    elseif self._ui._btn_manufacture:GetShow() == true then
      if _ContentsGroup_CargoSell == true then
        local buttonSizeX = (self._ui._stc_moneyBg:GetSizeX() - buttonSizeGap) / 2
        self._ui._btn_cargoCell:SetSize(buttonSizeX, self._ui._btn_itemMarketRegist:GetSizeY())
        self._ui._btn_manufacture:SetSize(buttonSizeX, self._ui._btn_itemMarketRegist:GetSizeY())
        self._ui._btn_manufacture:SetSpanSize(2, self._btnMarketRegSpanSizeY + self.addSizeY)
        self._ui._btn_cargoCell:SetSpanSize(buttonSizeX + buttonSizeGap, self._btnMarketRegSpanSizeY + self.addSizeY)
      end
    elseif _ContentsGroup_CargoSell == true then
      self._ui._btn_cargoCell:SetSize(self._ui._stc_moneyBg:GetSizeX(), self._ui._btn_itemMarketRegist:GetSizeY())
      self._ui._btn_cargoCell:SetSpanSize(2, self._btnMarketRegSpanSizeY + self.addSizeY)
    end
  else
    self._ui._btn_manufacture:SetShow(false)
    self._ui._btn_itemMarketRegist:SetShow(false)
    self._ui._btn_cargoCell:SetShow(false)
  end
  self._ui._btn_manufacture:SetTextSpan((self._ui._btn_manufacture:GetSizeX() + 26) * 0.5 - self._ui._btn_manufacture:GetTextSizeX() * 0.5, self._ui._btn_manufacture:GetSizeY() * 0.5 - self._ui._btn_manufacture:GetTextSizeY() * 0.5)
  self._ui._btn_itemMarketRegist:SetTextSpan((self._ui._btn_itemMarketRegist:GetSizeX() + 26) * 0.5 - self._ui._btn_itemMarketRegist:GetTextSizeX() * 0.5, self._ui._btn_itemMarketRegist:GetSizeY() * 0.5 - self._ui._btn_itemMarketRegist:GetTextSizeY() * 0.5)
  if dialog_isEventWarehouseNpc() == true then
    self._ui._btn_cargoCell:SetShow(false)
  end
  self:setPanelPosition()
  self:prepareOpen()
end
function PaGlobal_WareHouse_All:openWithInventory(filterFunc, isScrollHold)
  if PaGlobalFunc_Inventory_RemoteWareHouseDescShow ~= nil then
    PaGlobalFunc_Inventory_RemoteWareHouseDescShow(false)
  end
  Inventory_SetFunctor(filterFunc, FGlobal_PopupMoveItem_InitByInventory, PaGlobal_Warehouse_All_Close, nil)
  if true == _ContentsGroup_NewUI_Inventory_All then
    if (false == Panel_Window_Inventory_All:GetShow() or Panel_Window_Inventory_All:IsUISubApp()) and nil ~= InventoryWindow_Show then
      InventoryWindow_Show()
    end
  elseif (false == Panel_Window_Inventory:GetShow() or Panel_Window_Inventory:IsUISubApp()) and nil ~= InventoryWindow_Show then
    InventoryWindow_Show()
  end
  if nil == isScrollHold or false == isScrollHold then
    self._startSlotIndex = 0
    self._ui._scroll_warehouse:SetControlTop()
  end
  if false == self._isConsole then
    for ii = 0, __eServantTypeCount - 1 do
      if true == servant_checkDistance(ii) then
        if false == self._isConsole then
          self._isHideHorseBag = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eHideHorseBagByWareHouse)
          self._ui._pc._chk_horseBag:SetCheck(not self._isHideHorseBag)
        end
        self._ui._pc._chk_horseBag:SetShow(true)
        break
      end
    end
    if false == self._isHideHorseBag and nil == isScrollHold or false == isScrollHold then
      ServantInventory_OpenAll()
    end
    if true == _ContentsGroup_NewUI_Inventory_All then
      if false == Panel_Window_Inventory_All:GetShow() then
        PaGlobalFunc_Inventory_All_InventorySetPosWithWarehouse()
      end
    else
      FGlobal_InventorySetPos_WithWarehouse()
    end
  end
end
function PaGlobal_WareHouse_All:setfunctor(filterFunc, rClickFunc)
  if nil ~= filterFunc and "function" ~= type(filterFunc) then
    filterFunc = nil
    UI.ASSERT(false, "Param 1 must be Function type")
  end
  if nil ~= rClickFunc and "function" ~= type(rClickFunc) then
    rClickFunc = nil
    UI.ASSERT(false, "Param 2 must be Function type")
  end
  self.manufactureFilterFunc = filterFunc
  self.manufactureRclickFunc = rClickFunc
end
function PaGlobal_WareHouse_All:resetFilter()
  if true == _ContentsGroup_isAllWarehouse then
    PaGlobal_WareHouse_All:searchMenuOpen()
  end
  if nil ~= self.itemMarketFilterFunc then
    self.itemMarketFilterFunc = nil
    self.itemMarketRclickFunc = nil
    self.guildWareHouseFilterFunc = nil
  end
  self:update()
end
function PaGlobal_WareHouse_All:searchMenuTerritoryOpen(territoryKey, isFirstOpen)
  local isMuzgalFound = false
  local tree2 = self._ui._list2_serchWareHouse
  for index = 0, self._maxTerritoryKeyCount - 1 do
    if nil ~= self._warehouseInfo._territoryGroup[index] and self._territoryContentsOption[index] == true and territoryKey == index then
      local keyElement = tree2:getElementManager():getByKey(toInt64(0, territoryKey), false)
      local uiContent = self._ui._list2_serchWareHouse:GetContentByKey(toInt64(0, territoryKey))
      if nil ~= uiContent then
        UI.getChildControl(uiContent, "RadioButton_Territory"):SetCheck(self._selectIndex == territoryKey)
      end
      tree2:getElementManager():toggle(toInt64(0, territoryKey))
      if self._selectIndex == territoryKey then
        self._selectIndex = -2
        do return end
        break
      end
      do
        local maxTerritoryWarehouseCount = self._warehouseInfo._territoryGroup[index]._count
        for wIndex = 1, maxTerritoryWarehouseCount do
          warehouse_requestInfo(self._warehouseInfo._territoryGroup[index][wIndex])
          if self._warehouseInfo._territoryGroup[index][wIndex] == 1834 then
            isMuzgalFound = true
          end
        end
        self._selectIndex = territoryKey
        local heightIndex = tree2:getIndexByKey(toInt64(0, territoryKey))
        tree2:moveIndex(heightIndex)
      end
      break
    end
  end
  if isFirstOpen then
    if dialog_isEventWarehouseNpc() == true then
      self._selectWaypointKey = warehouse_getEventWarehouseWaypointKey()
      self:otherTownsWareHouse(self._selectWaypointKey)
      tree2:getElementManager():refillKeyList()
      return
    else
      local currentWaypointKey = getCurrentWaypointKey()
      if self._fromType == CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid or self._fromType == CppEnums.WarehoouseFromType.eWarehoouseFromType_Installation then
        currentWaypointKey = self._currentWaypointKey
        if currentWaypointKey == 1834 and isMuzgalFound == true then
          currentWaypointKey = 1843
        end
      end
      self._selectWaypointKey = currentWaypointKey
      self:otherTownsWareHouse(currentWaypointKey)
      tree2:getElementManager():refillKeyList()
      return
    end
  end
  if 0 <= self._selectIndex then
    if dialog_isEventWarehouseNpc() == true then
      self._selectWaypointKey = warehouse_getEventWarehouseWaypointKey()
      self:otherTownsWareHouse(self._selectWaypointKey)
    else
      self._selectWaypointKey = self._warehouseInfo._territoryGroup[self._selectIndex][1]
      self:otherTownsWareHouse(self._selectWaypointKey)
    end
  end
  tree2:getElementManager():refillKeyList()
end
function PaGlobal_WareHouse_All:searchMenuTerritoryOpen2(territoryKey)
  self._ui._list2_serchWareHouse:getElementManager():clearKey()
  for index = 0, self._maxTerritoryKeyCount - 1 do
    if nil ~= self._warehouseInfo._territoryGroup[index] and self._territoryContentsOption[index] == true then
      self._ui._list2_serchWareHouse:getElementManager():pushKey(toInt64(0, index))
      if index == territoryKey then
        if self._selectIndex == territoryKey then
          self._selectIndex = -2
          self._warehouseInfo._territoryGroup[index]._isTerritoryGroupOpen = false
        else
          self._selectIndex = territoryKey
          self._warehouseInfo._territoryGroup[index]._isTerritoryGroupOpen = true
        end
      end
      if self._warehouseInfo._territoryGroup[index]._isTerritoryGroupOpen == true then
        local maxTerritoryWarehouseCount = self._warehouseInfo._territoryGroup[index]._count
        for wIndex = 1, maxTerritoryWarehouseCount do
          warehouse_requestInfo(self._warehouseInfo._territoryGroup[index][wIndex])
          local waypointKey = self._warehouseInfo._territoryGroup[index][wIndex] + self._separatorNumber
          self._ui._list2_serchWareHouse:getElementManager():pushKey(toInt64(0, waypointKey))
        end
      end
    end
  end
  if 0 <= self._selectIndex then
    if dialog_isEventWarehouseNpc() == true then
      self._selectWaypointKey = warehouse_getEventWarehouseWaypointKey()
      self:otherTownsWareHouse(self._selectWaypointKey)
    else
      self._selectWaypointKey = self._warehouseInfo._territoryGroup[self._selectIndex][1]
      self:otherTownsWareHouse(self._selectWaypointKey)
    end
  end
end
function PaGlobal_WareHouse_All:checkOpenWithInventoryWhenOtherTown()
  if self._fromType == CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid then
    local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
    if nil == regionInfo then
      return false
    end
    local regionInfoWrapper = getRegionInfoWrapper(regionInfo:getAffiliatedTownRegionKey())
    local plantWayKey = regionInfoWrapper:getPlantKeyByWaypointKey():getWaypointKey()
    if _ContentsGroup_ProjectAbyssOne == false and isGameServiceTypeConsole() == false and plantWayKey ~= self._currentWaypointKey then
      return false
    end
    if plantWayKey == self._currentWaypointKey then
      PaGlobal_Warehouse_All_SetIgnoreMoneyButton(false)
      self:openWithInventory(PaGlobal_Warehouse_All_BasicItemFilter)
      return true
    end
  end
  if self._fromType == CppEnums.WarehoouseFromType.eWarehoouseFromType_Installation and ToClient_GetNearBySpawnWaypointKey(CppEnums.SpawnType.eSpawnType_WareHouse) == self._currentWaypointKey then
    PaGlobal_Warehouse_All_SetIgnoreMoneyButton(false)
    self:openWithInventory(PaGlobal_Warehouse_All_BasicItemFilter)
    return true
  end
  if _ContentsGroup_ProjectAbyssOne == false and isGameServiceTypeConsole() == false then
    return false
  end
  if ToClient_ablePushOrPopOtherWareHouse(self._currentWaypointKey) == true then
    self:openWithInventory(PaGlobal_Warehouse_All_OtherTownWareHouseItemFilter)
    PaGlobal_Warehouse_All_SetIgnoreMoneyButton(false)
    return true
  else
    self:openWithInventory(PaGlobal_Warehouse_All_CanNotMovableOtherHouseItemFilter)
    PaGlobal_Warehouse_All_SetIgnoreMoneyButton(true)
    if PaGlobalFunc_Inventory_RemoteWareHouseDescShow ~= nil then
      PaGlobalFunc_Inventory_RemoteWareHouseDescShow(true)
      return true
    end
  end
  return false
end
function PaGlobal_WareHouse_All:otherTownsWareHouse(waypointKey)
  local isCurrentTownsWarehouse = waypointKey == getCurrentWaypointKey() and self._fromType == CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc
  if dialog_isEventWarehouseNpc() == true and waypointKey == warehouse_getEventWarehouseWaypointKey() then
    isCurrentTownsWarehouse = true
  end
  if isCurrentTownsWarehouse then
    self:openPanelFromDialog()
  else
    if self._fromType == CppEnums.WarehoouseFromType.eWarehoouseFromType_Installation then
      self:openPanelFromWorldmap(waypointKey, CppEnums.WarehoouseFromType.eWarehoouseFromType_Installation)
    elseif self._fromType == CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid then
      self:openPanelFromWorldmap(waypointKey, CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid)
    elseif self._fromType == CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc then
      self:openPanelFromWorldmap(waypointKey, CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc)
    else
      self:openPanelFromWorldmap(waypointKey, CppEnums.WarehoouseFromType.eWarehoouseFromType_Worldmap)
    end
    local canWareHouseOpen = self:checkOpenWithInventoryWhenOtherTown()
    if canWareHouseOpen == false then
      if true == _ContentsGroup_NewUI_Inventory_All then
        if Panel_Window_Inventory_All:IsUISubApp() then
          Panel_Window_Inventory_All:CloseUISubApp()
        end
        Panel_Window_Inventory_All:SetShow(false)
      else
        if Panel_Window_Inventory:IsUISubApp() then
          Panel_Window_Inventory:CloseUISubApp()
        end
        Panel_Window_Inventory:SetShow(false)
        if nil ~= Panel_Window_PreOrder and true == Panel_Window_PreOrder:GetShow() then
          PaGlobalFunc_PreOrder_Close(Panel_Window_Inventory)
        end
      end
    end
    if false == _ContentsGroup_RenewUI_InventoryEquip then
      if true == _ContentsGroup_NewUI_Equipment_All then
        if Panel_Window_Equipment_All:IsUISubApp() then
          Panel_Window_Equipment_All:CloseUISubApp()
        end
        Panel_Window_Equipment_All:SetShow(false)
      else
        if Panel_Equipment:IsUISubApp() then
          Panel_Equipment:CloseUISubApp()
        end
        Panel_Equipment:SetShow(false)
      end
    end
  end
  PaGlobal_Warehouse_All_OtherWaypointKey(waypointKey)
  local beforeWaypointKey = self._selectWaypointKey
  self._selectWaypointKey = waypointKey
  self._ui._list2_serchWareHouse:requestUpdateVisible()
  if nil ~= Panel_Popup_MoveItem and true == Panel_Popup_MoveItem:GetShow() and nil ~= PopupMoveItem_Close then
    PopupMoveItem_Close()
  end
end
function PaGlobal_WareHouse_All:searchMenuOpen()
  if true == self._ui._stc_leftBg:GetShow() or not _ContentsGroup_isAllWarehouse then
    return
  end
  self:SetShowSearchMenuWareHouse(true)
  local warehouseCount = ToClient_FindWareHouse(getCurrentWaypointKey())
  if 0 == warehouseCount then
    return
  end
  local currentWaypointKey = getCurrentWaypointKey()
  if self._fromType == CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid or self._fromType == CppEnums.WarehoouseFromType.eWarehoouseFromType_Installation then
    currentWaypointKey = self._currentWaypointKey
  end
  local currentRegionInfoWrapper = ToClient_getRegionInfoWrapperByWaypoint(currentWaypointKey)
  if dialog_isEventWarehouseNpc() == true then
    currentWaypointKey = warehouse_getEventWarehouseWaypointKey()
    currentRegionInfoWrapper = ToClient_getRegionInfoWrapperByWaypoint(currentWaypointKey)
  end
  if currentRegionInfoWrapper == nil then
    return
  end
  local currentTerritoryKey = currentRegionInfoWrapper:getTerritoryKeyRaw()
  self._warehouseInfo._territoryCount = 0
  self._warehouseInfo._territoryGroup = {}
  self._ui._list2_serchWareHouse:getElementManager():clearKey()
  for index = 0, warehouseCount - 1 do
    local waypointKey = ToClient_getWareHouseWaypointKey(index)
    local regionInfoWrapper = ToClient_getRegionInfoWrapperByWaypoint(waypointKey)
    local territoryKey = regionInfoWrapper:getTerritoryKeyRaw()
    if nil == self._warehouseInfo._territoryGroup[territoryKey] then
      self._warehouseInfo._territoryCount = self._warehouseInfo._territoryCount + 1
      self._warehouseInfo._territoryGroup[territoryKey] = {}
      self._warehouseInfo._territoryGroup[territoryKey]._count = 1
      self._warehouseInfo._territoryGroup[territoryKey][1] = waypointKey
      self._territoryNameInfo[territoryKey] = regionInfoWrapper:getTerritoryName()
      local treeElement = self._ui._list2_serchWareHouse:getElementManager():getMainElement():createChild(toInt64(0, territoryKey))
      treeElement:setIsOpen(false)
      local subTreeElement = treeElement:createChild(toInt64(0, waypointKey + PaGlobal_WareHouse_All._separatorNumber))
    else
      self._warehouseInfo._territoryGroup[territoryKey]._count = self._warehouseInfo._territoryGroup[territoryKey]._count + 1
      self._warehouseInfo._territoryGroup[territoryKey][self._warehouseInfo._territoryGroup[territoryKey]._count] = waypointKey
      local treeElement = self._ui._list2_serchWareHouse:getElementManager():getByKey(toInt64(0, territoryKey), false)
      local subTreeElement = treeElement:createChild(toInt64(0, waypointKey + PaGlobal_WareHouse_All._separatorNumber))
    end
  end
  self._selectIndex = -1
  self._selectWaypointKey = -1
  self:searchMenuTerritoryOpen(currentTerritoryKey, true)
  self._ui._stc_leftBg:ComputePos()
end
function PaGlobal_WareHouse_All:searchMenuClose()
  if false == self._ui._stc_leftBg:GetShow() then
    return
  end
  self:SetShowSearchMenuWareHouse(false)
end
function PaGlobal_WareHouse_All:townListCheck()
  if ToClient_WorldMapIsShow() then
    return
  end
  if PaGlobalFunc_PanelDelivery_GetShow() or not _ContentsGroup_isAllWarehouse then
    self:SetShowSearchMenuWareHouse(false)
  else
    self:SetShowSearchMenuWareHouse(true)
  end
end
function PaGlobal_WareHouse_All:SetShowSearchMenuWareHouse(isShow)
  if isShow == self._ui._stc_leftBg:GetShow() then
    return
  end
  self._ui._stc_leftBg:SetShow(isShow)
  self._ui._txt_notAvaliable:SetShow(false)
  if true == isShow then
    Panel_Window_Warehouse:SetSize(self._beforePanelSizeX, Panel_Window_Warehouse:GetSizeY())
    self._ui._stc_topBg:SetSize(self._beforePanelSizeX, self._ui._stc_topBg:GetSizeY())
    self._ui._stc_bottomBg:SetSize(self._beforePanelSizeX, self._ui._stc_bottomBg:GetSizeY())
  else
    self._beforePanelSizeX = Panel_Window_Warehouse:GetSizeX()
    local sizeX = self._ui._stc_rightBottomBg:GetSizeX() + 26
    Panel_Window_Warehouse:SetSize(sizeX, Panel_Window_Warehouse:GetSizeY())
    self._ui._stc_topBg:SetSize(sizeX, self._ui._stc_topBg:GetSizeY())
    self._ui._stc_bottomBg:SetSize(sizeX, self._ui._stc_bottomBg:GetSizeY())
  end
  self._ui._stc_rightTopBg:ComputePos()
  self._ui._stc_rightBottomBg:ComputePos()
  self._ui._stc_decoBg:ComputePos()
  self._ui._txt_villageName:ComputePos()
  self._ui._pc._btn_close:ComputePos()
  self._ui._pc._btn_question:ComputePos()
end
function PaGlobal_WareHouse_All:updateSortText_console()
  if false == self._isConsole then
    return
  end
  local keyGuidePosSize = self._ui._console._txt_keyGuideSort:GetPosX() + self._ui._console._txt_keyGuideSort:GetSizeX()
  self._ui._chk_itemSort:SetPosX(keyGuidePosSize)
  self._ui._btn_sortOption:SetPosX(keyGuidePosSize)
end
function PaGlobal_WareHouse_All:updateButtonInfo()
  if true == self._isConsole then
    self._ui._console._txt_keyGuideSelect:SetShow(self._buttonData.selectItem)
    self._ui._console._txt_keyGuideMarketInvenOpen:SetShow(self._buttonData.sendMoney or self._buttonData.guildLog)
    self._ui._console._txt_keyGuideManufacture:SetShow(self._buttonData.manufacture)
    self._ui._console._txt_keyGuideCargoSellOpen:SetShow(self._buttonData.cargosell)
    self._ui._btn_cargoCell:SetShow(false)
    if true == self._buttonData.manufacture then
      Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "HandleEventLUp_Warehouse_All_ManufactureOpen()")
    else
      Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "")
    end
    if true == self._buttonData.cargosell then
      Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "HandleEvent_Warehouse_All_CargoSellOpen()")
    else
      Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "")
    end
    if true == self._buttonData.warehouseHistory then
      Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEvent_Warehouse_All_HistoryOpen()")
    elseif true == PaGlobal_WareHouse_All._buttonData.guildLog then
      Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_Warehouse_All_GuildWareHouseHistory()")
    else
      Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "")
    end
    if true == self:isGuildHouse() or true == self:isMaid() or true == _ContentsGroup_RenewUI and true == ToClient_WorldMapIsShow() then
      Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    elseif false == _ContentsGroup_RenewUI then
      Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_MarketWallet_Open(" .. CppEnums.ItemWhereType.eWarehouse .. ")")
    elseif Defines.UIMode.eUIMode_NpcDialog == GetUIMode() then
      if _ContentsOption_CH_CreditPoint == true then
        Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_MarketPlace_CheckCreditPointNpc()")
      else
        Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_MarketPlace_OpenFromDialog()")
      end
    else
      Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_MarketPlace_Open()")
    end
    if false == self._buttonData.marketRegist then
      Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    end
    self._ui._console._txt_keyGuideMarketInvenOpen:SetShow(self._buttonData.marketRegist)
    self:setInventoryItemMoveEvent(self._buttonData.autoMove)
  else
    self._ui._btn_itemMarketRegist:SetShow(self._buttonData.marketRegist)
    self._ui._btn_manufacture:SetShow(self._buttonData.manufacture)
    self._ui._btn_cargoCell:SetShow(self._buttonData.cargosell)
    if dialog_isEventWarehouseNpc() == true then
      self._ui._btn_cargoCell:SetShow(false)
    end
    self._ui._btn_deliveryInfomation:SetShow(self._buttonData.delivery)
    self._ui._btn_guildUpdate:SetShow(self._buttonData.guildUpdate)
    self._ui._btn_guildLog:SetShow(self._buttonData.guildUpdate)
    self._ui._btn_wareHouseHistory:SetShow(self._buttonData.warehouseHistory)
    if (self._ui._btn_deliveryInfomation:GetShow() == true or self._ui._btn_manufacture:GetShow() == true or self._ui._btn_cargoCell:GetShow() == true) and CppEnums.WarehoouseFromType.eWarehoouseFromType_Manufacture ~= self._fromType then
      self._ui._btn_wareHouseHistory:SetSpanSize(0, -(self._ui._btn_deliveryInfomation:GetSizeY() + self.addSizeY))
    else
      self._ui._btn_wareHouseHistory:SetSpanSize(0, 0)
    end
  end
end
function PaGlobal_WareHouse_All:initButtonData()
  self._buttonData.selectItem = false
  self._buttonData.marketRegist = false
  self._buttonData.manufacture = false
  self._buttonData.delivery = false
  self._buttonData.guildUpdate = false
  self._buttonData.sendMoney = false
  self._buttonData.guildLog = false
  self._buttonData.cargosell = false
  self._buttonData.autoMove = false
  self._buttonData.warehouseHistory = false
end
function PaGlobal_WareHouse_All:setInventoryItemMoveEvent(isSet)
  if false == self._isConsole then
    return
  end
  if false == _ContentsGroup_ItemMove then
    return
  end
  if true == isSet then
    local isInvenShow = false
    if true == _ContentsGroup_NewUI_Inventory_All then
      isInvenShow = Panel_Window_Inventory_All:GetShow()
    else
      isInvenShow = Panel_Window_Inventory:GetShow()
    end
    self._ui._console._txt_keyGuide_RTA:SetShow(false)
    self._ui._console._txt_keyGuide_RTX:SetShow(false)
    self._ui._console._txt_keyGuide_LTX:SetShow(isInvenShow)
  else
    Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "")
    Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_RTPress_A, "")
    self._ui._console._txt_keyGuide_RTA:SetShow(false)
    self._ui._console._txt_keyGuide_RTX:SetShow(false)
    self._ui._console._txt_keyGuide_LTX:SetShow(false)
  end
  if ToClient_isConsole() == true and self:isGuildHouse() == false then
    self._ui._console._txt_keyGuide_LTY:SetShow(false)
  else
    self._ui._console._txt_keyGuide_LTY:SetShow(true)
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuide, self._ui._stc_bottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_WareHouse_All:setTerritoryIcon(control, territoryIndex)
  if control == nil or territoryIndex == nil then
    return
  end
  local textureName
  if territoryIndex == 0 then
    textureName = "Combine_Etc_DropItem_Icon_Tab_04_Over"
  elseif territoryIndex == 1 then
    textureName = "Combine_Etc_DropItem_Icon_Tab_02_Over"
  elseif territoryIndex == 2 then
    textureName = "Combine_Etc_DropItem_Icon_Tab_01_Over"
  elseif territoryIndex == 3 then
    textureName = "Combine_Etc_DropItem_Icon_Tab_03_Over"
  elseif territoryIndex == 4 then
    textureName = "Combine_Etc_DropItem_Icon_Tab_05_Over"
  elseif territoryIndex == 5 then
    textureName = "Combine_Etc_DropItem_Icon_Tab_00_Over"
  elseif territoryIndex == 6 then
    textureName = "Combine_Etc_DropItem_Icon_Tab_06_Over"
  elseif territoryIndex == 7 then
    textureName = "Combine_Etc_DropItem_Icon_Tab_07_Over"
  elseif territoryIndex == 8 then
    textureName = "Combine_Etc_DropItem_Icon_Tab_08_Over"
  elseif territoryIndex == 9 then
    textureName = "Combine_Etc_DropItem_Icon_Tab_09_Over"
  elseif territoryIndex == 10 then
    textureName = "Combine_Etc_DropItem_Icon_Tab_10_Over"
  elseif territoryIndex == 11 then
    textureName = "Combine_Etc_DropItem_Icon_Tab_11_Over"
  elseif territoryIndex == 12 then
    textureName = "Combine_Etc_DropItem_Icon_Tab_12_Over"
  end
  if textureName == nil then
    return
  end
  control:ChangeTextureInfoTextureIDAsync(textureName, 0)
  control:setRenderTexture(control:getBaseTexture())
  control:SetShow(true)
end
function PaGlobal_WareHouse_All:setGuildPresentButton()
  local canUseGuildPresent = true
  if _ContentsGroup_SiegeGuildPresentation == false then
    canUseGuildPresent = false
  end
  if self:isGuildHouse() == false then
    canUseGuildPresent = false
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    canUseGuildPresent = false
  end
  local isGuildMaster = selfPlayer:get():isGuildMaster()
  if isGuildMaster == false then
    canUseGuildPresent = false
  end
  if self._isConsole == true then
    if canUseGuildPresent == true then
      local desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDPRESENT_DOPRESENT")
      self._ui._console._txt_keyGuideGuildPresent:SetText(desc)
      self._ui._console._txt_keyGuideGuildPresent:SetShow(true)
      Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventLUp_WareHouse_All_OpenGuildPresent()")
    else
      self._ui._console._txt_keyGuideGuildPresent:SetShow(false)
      if self._buttonData.autoMove == true then
        Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobalFunc_WareHouseFunctionPanel_All_Open()")
      else
        Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
      end
    end
  elseif canUseGuildPresent == true then
    local newSizeX = self._ui._stc_rightBottomBg:GetSizeX() / 3
    local newSizeY = self._ui._btn_guildLog:GetSizeY()
    self._ui._btn_present:ComputePos()
    self._ui._btn_present:SetShow(true)
    self._ui._btn_guildLog:SetSize(newSizeX, newSizeY)
    self._ui._btn_guildLog:SetPosX(0)
    self._ui._btn_guildUpdate:SetSize(newSizeX, newSizeY)
    self._ui._btn_guildUpdate:SetPosX(newSizeX + 2)
    self._ui._btn_present:SetSize(newSizeX, newSizeY)
    self._ui._btn_present:SetPosX(self._ui._btn_guildUpdate:GetPosX() + newSizeX + 2)
  else
    self._ui._btn_present:SetShow(false)
  end
end
function PaGlobal_WareHouse_All:getInventoryItemStaticStatus(slotNo, whereType)
  local itemWrapper
  if true == (CppEnums.ItemWhereType.eServantInventory == whereType) then
    itemWrapper = getServantInventoryItemBySlotNo(PaGlobal_WareHouse_All._targetActorKeyRaw, slotNo)
  else
    itemWrapper = getInventoryItemByType(whereType, slotNo)
  end
  if nil == itemWrapper then
    return nil
  end
  return itemWrapper:getStaticStatus()
end
function PaGlobal_WareHouse_All:getWarehouseItemStaticStatus(slotNo)
  local warehouseWrapper = PaGlobal_WareHouse_All:getWarehouse()
  local itemWrapper = warehouseWrapper:getItem(slotNo)
  if itemWrapper == nil then
    return nil
  end
  return itemWrapper:getStaticStatus()
end
function PaGlobal_WareHouse_All:checkMoveUnstackableItemByOnce(s64_count, itemSSW)
  if itemSSW == nil then
    return false
  end
  return _ContentsGroup_MoveNonStackItem == true and itemSSW:isStackable() == false and s64_count > toInt64(0, 1)
end
