function PaGlobal_ClothInventory_Renew_All:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_titleBg = UI.getChildControl(Panel_Window_ClothInventory_Renew_All, "Static_TitleBg")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleBg, "Button_Close_PCUI")
  self._ui._stc_bg = UI.getChildControl(Panel_Window_ClothInventory_Renew_All, "Static_BG")
  self._ui._stc_descBg = UI.getChildControl(Panel_Window_ClothInventory_Renew_All, "Static_DescBg")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_descBg, "StaticText_Desc")
  self._ui._btn_changeAll = UI.getChildControl(Panel_Window_ClothInventory_Renew_All, "Button_ChangeAll_PCUI")
  self._ui._stc_keyguideBg = UI.getChildControl(Panel_Window_ClothInventory_Renew_All, "Static_KeyGuideBg_ConsoleUI")
  self._ui._txt_tooltip = UI.getChildControl(Panel_Window_ClothInventory_Renew_All, "StaticText_Tooltip")
  for index = 0, 7 do
    self._ui._slotBg[index] = UI.getChildControl(self._ui._stc_bg, "Static_SlotBg_" .. index)
    self._ui._slot[index] = {}
    SlotItem.new(self._ui._slot[index], "ClothInventory_", index, self._ui._slotBg[index], self._config)
    self._ui._slot[index]:createChild()
  end
  local titleText = UI.getChildControl(self._ui._stc_titleBg, "StaticText_Title")
  titleText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MERV_PORTABLEBAG"))
  self._isPadSnapping = _ContentsGroup_UsePadSnapping
  self._ui._btn_close:SetShow(self._isPadSnapping == false)
  self._ui._btn_changeAll:SetShow(self._isPadSnapping == false)
  self._ui._stc_keyguideBg:SetShow(self._isPadSnapping == true)
  self:setKeyGuide()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ClothInventory_Renew_All:registEventHandler()
  if Panel_Window_ClothInventory_Renew_All == nil then
    return
  end
  self._ui._btn_changeAll:addInputEvent("Mouse_LUp", "PaGlobalFunc_ClothInventory_Renew_All_ChangeAllItem()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ClothInventory_All_Close()")
  if self._isPadSnapping == true then
    Panel_Window_ClothInventory_Renew_All:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobalFunc_ClothInventory_Renew_All_ChangeAllItem()")
    if _ContentsGroup_RenewUI_Tooltip == true then
      Panel_Window_ClothInventory_Renew_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_ClothInventory_Renew_All_ShowDetailToolTip()")
    end
  end
  registerEvent("FromClient_ShowInventoryBag", "FromClient_ClothInventory_Renew_All_ShowInventoryBag")
  registerEvent("FromClient_UpdateInventoryBag", "PaGlobalFunc_ClothInventory_Renew_All_UpdateInventoryBag")
  registerEvent("EventEquipItem", "PaGlobalFunc_ClothInventory_Renew_All_UpdateInventoryBag")
  registerEvent("EventUnEquipItemToInventory", "PaGlobalFunc_ClothInventory_Renew_All_UpdateInventoryBag")
  registerEvent("FromClient_ChangeItemExpirationDate", "PaGlobalFunc_ClothInventory_Renew_All_UpdateInventoryBag")
  for index = 0, 7 do
    local iconUI = UI.getChildControl(self._ui._slotBg[index], "Static_Slot_BG")
    iconUI:addInputEvent("Mouse_On", "HandleEventOnOut_ClothInventory_Renew_All_EmptySlotTooltip(" .. index .. ",true)")
    iconUI:addInputEvent("Mouse_Out", "HandleEventOnOut_ClothInventory_Renew_All_EmptySlotTooltip(" .. index .. ",false)")
  end
end
function PaGlobal_ClothInventory_Renew_All:updateDescText()
  if Panel_Window_ClothInventory_Renew_All == nil then
    return
  end
  if self._ui._txt_desc:GetShow() == false then
    return
  end
  local descStr = ""
  if self._isPadSnapping == true then
    descStr = PAGetString(Defines.StringSheet_GAME, "LUA_CLOTHINVENTORY_CONSOLE_DESC")
  else
    descStr = PAGetString(Defines.StringSheet_GAME, "LUA_CLOTHINVENTORY_DESC")
  end
  self._ui._txt_desc:SetText(descStr)
  self._ui._txt_desc:ComputePos()
end
function PaGlobal_ClothInventory_Renew_All:setKeyGuide()
  if Panel_Window_ClothInventory_Renew_All == nil then
    return
  end
  if self._isPadSnapping == false then
    return
  end
  local bottomKeyGuideA = UI.getChildControl(self._ui._stc_keyguideBg, "StaticText_A_ConsoleUI")
  local bottomKeyGuideB = UI.getChildControl(self._ui._stc_keyguideBg, "StaticText_B_ConsoleUI")
  local bottomKeyGuideY = UI.getChildControl(self._ui._stc_keyguideBg, "StaticText_Y_ConsoleUI")
  local keyGuideAlignY = {bottomKeyGuideY}
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideAlignY, self._ui._stc_keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  bottomKeyGuideA:SetPosY(bottomKeyGuideY:GetPosY() + bottomKeyGuideY:GetTextSizeY() + 10)
  bottomKeyGuideB:SetPosY(bottomKeyGuideY:GetPosY() + bottomKeyGuideY:GetTextSizeY() + 10)
  local keyGuideAlign = {bottomKeyGuideA, bottomKeyGuideB}
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideAlign, self._ui._stc_keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_ClothInventory_Renew_All:resize()
  if Panel_Window_ClothInventory_Renew_All == nil then
    return
  end
  local panelSizeY = self._ui._stc_bg:GetPosY() + self._ui._stc_bg:GetSizeY() + self._ui._txt_desc:GetTextSizeY() + 20
  if self._isPadSnapping == false then
    panelSizeY = panelSizeY + self._ui._btn_changeAll:GetSizeY() + 10
  end
  Panel_Window_ClothInventory_Renew_All:SetSize(Panel_Window_ClothInventory_Renew_All:GetSizeX(), panelSizeY)
  self._ui._stc_descBg:SetSize(self._ui._stc_descBg:GetSizeX(), self._ui._txt_desc:GetTextSizeY())
  self._ui._stc_descBg:SetSpanSize(0, self._ui._btn_changeAll:GetSizeY() + 20)
  if self._isPadSnapping == true then
    self._ui._stc_descBg:SetSpanSize(0, 10)
  end
  self._ui._txt_desc:ComputePos()
  self._ui._btn_changeAll:ComputePos()
  if self._isPadSnapping == true then
    self._ui._stc_keyguideBg:SetSize(Panel_Window_ClothInventory_Renew_All:GetSizeX(), self._ui._stc_keyguideBg:GetSizeY())
    self._ui._stc_keyguideBg:ComputePos()
  end
  Panel_Window_ClothInventory_Renew_All:ComputePosAllChild()
end
function PaGlobal_ClothInventory_Renew_All:prepareOpen()
  if Panel_Window_ClothInventory_Renew_All == nil then
    return
  end
  if self._isPadSnapping == false then
    self:setOpenPos()
    PaGlobalFunc_Equipment_All_SetShow(false)
  end
  self:open()
end
function PaGlobal_ClothInventory_Renew_All:open()
  if Panel_Window_ClothInventory_Renew_All == nil then
    return
  end
  Panel_Window_ClothInventory_Renew_All:SetShow(true)
end
function PaGlobal_ClothInventory_Renew_All:prepareClose()
  if Panel_Window_ClothInventory_Renew_All == nil then
    return
  end
  if Panel_Window_ClothInventory_Renew_All:GetShow() == false then
    return
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  Panel_Tooltip_Item_hideTooltip()
  if self._isPadSnapping == true then
    PaGlobalFunc_FloatingTooltip_Close()
  else
    PaGlobalFunc_Equipment_All_SetShow(true)
  end
  self:close()
end
function PaGlobal_ClothInventory_Renew_All:close()
  if Panel_Window_ClothInventory_Renew_All == nil then
    return
  end
  Panel_Window_ClothInventory_Renew_All:SetShow(false)
end
function PaGlobal_ClothInventory_Renew_All:setOpenPos()
  if Panel_Window_ClothInventory_Renew_All == nil then
    return
  end
  if _ContentsGroup_NewUI_Inventory_All == true then
    if Panel_Window_Inventory_All:IsUISubApp() == true then
      Panel_Window_ClothInventory_Renew_All:SetPosXY(getScreenSizeX() * 0.5, getScreenSizeY() * 0.5)
    else
      local posX = Panel_Window_Inventory_All:GetPosX() - Panel_Window_ClothInventory_Renew_All:GetSizeX() - 5
      if posX < 0 then
        posX = Panel_Window_Inventory_All:GetPosX() + Panel_Window_Inventory_All:GetSizeX() + 5
      end
      Panel_Window_ClothInventory_Renew_All:SetPosX(posX)
      Panel_Window_ClothInventory_Renew_All:SetPosY(Panel_Window_Inventory_All:GetPosY())
    end
  else
    Panel_Window_ClothInventory_Renew_All:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_ClothInventory_Renew_All:GetSizeX() - 5)
    Panel_Window_ClothInventory_Renew_All:SetPosY(Panel_Window_Inventory:GetPosY())
  end
end
function PaGlobal_ClothInventory_Renew_All:showInventoryBag(bagType, bagSize, fromWhereType, fromSlotNo)
  if Panel_Window_ClothInventory_Renew_All == nil then
    return
  end
  self._bagSize = bagSize
  self._inventoryBagType = bagType
  self._fromWhereType = fromWhereType
  self._fromSlotNo = fromSlotNo
  self._bagType = CppEnums.ItemWhereType.eCashInventory
  local extendedSlotInfoArray = {}
  local checkExtendedSlot = false
  for index = 0, self._bagSize - 1 do
    local iconUI = UI.getChildControl(self._ui._slotBg[index], "Static_Slot_BG")
    local itemWrapper = getInventoryBagItemByType(fromWhereType, fromSlotNo, index)
    if itemWrapper ~= nil then
      iconUI:SetShow(false)
      self._ui._slot[index].icon:SetShow(true)
      self._ui._slot[index]:setItem(itemWrapper, index)
      self._ui._slot[index].icon:SetMonoTone(false)
      if self._isPadSnapping == true then
        self._ui._slot[index].icon:addInputEvent("Mouse_LUp", "HandleEventRUp_ClothInventory_Renew_All_ClothInvenRClick(" .. fromWhereType .. ", " .. fromSlotNo .. ", " .. index .. ", " .. self._bagType .. ")")
      else
        self._ui._slot[index].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_ClothInventory_Renew_All_ClothInvenRClick(" .. fromWhereType .. ", " .. fromSlotNo .. ", " .. index .. ", " .. self._bagType .. ")")
      end
      local itemEnchantWrapper = itemWrapper:getStaticStatus()
      if itemEnchantWrapper ~= nil then
        local extendSlotNoMax = itemEnchantWrapper:getExtendedSlotCount()
        for i = 1, extendSlotNoMax do
          local extendEquipSlotNo = itemEnchantWrapper:getExtendedSlotIndex(i - 1)
          if extendSlotNoMax ~= extendEquipSlotNo then
            extendInventorySlotNo = ToClient_getInventoryBagCashRenewSlotNo(extendEquipSlotNo)
            if extendInventorySlotNo ~= __eTInventorySlotNoUndefined then
              extendedSlotInfoArray[extendInventorySlotNo] = index
              checkExtendedSlot = true
            end
          end
        end
      end
    else
      self._ui._slot[index]:clearItem()
      self._ui._slot[index].icon:removeInputEvent("Mouse_LUp")
      self._ui._slot[index].icon:removeInputEvent("Mouse_RUp")
      iconUI:SetShow(true)
      self._ui._slot[index].icon:SetShow(false)
    end
    self._ui._slot[index].icon:addInputEvent("Mouse_On", "PaGlobalFunc_ClothInventory_Renew_All_ShowTooltip(true, " .. fromWhereType .. ", " .. fromSlotNo .. ", " .. index .. ")")
    self._ui._slot[index].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ClothInventory_Renew_All_ShowTooltip(false)")
  end
  if checkExtendedSlot == true then
    for extendInventorySlotNo, originInventorySlotNo in pairs(extendedSlotInfoArray) do
      local itemWrapper = getInventoryBagItemByType(self._fromWhereType, self._fromSlotNo, originInventorySlotNo)
      self._ui._slot[extendInventorySlotNo]:setItem(itemWrapper, originInventorySlotNo)
      self._ui._slot[extendInventorySlotNo].icon:SetMonoTone(true)
      self._ui._slot[extendInventorySlotNo].icon:SetShow(true)
      local iconUI = UI.getChildControl(self._ui._slotBg[extendInventorySlotNo], "Static_Slot_BG")
      iconUI:SetShow(false)
    end
  end
  Inventory_SetFunctor(PaGloablFunc_ClothInventory_Renew_All_SetFilter, HandleEventRUp_ClothInventory_Renew_All_InvenRClick, nil, nil)
  Panel_Tooltip_Item_hideTooltip()
  if self._isPadSnapping == true then
    PaGlobalFunc_FloatingTooltip_Close()
  end
  self:updateDescText()
  self:resize()
  self:setKeyGuide()
  self:prepareOpen()
end
function PaGlobal_ClothInventory_Renew_All:updateInventoryBag()
  if Panel_Window_ClothInventory_Renew_All == nil then
    return
  end
  if self._bagSize == nil then
    return
  end
  local extendedSlotInfoArray = {}
  local checkExtendedSlot = false
  for index = 0, self._bagSize - 1 do
    local iconUI = UI.getChildControl(self._ui._slotBg[index], "Static_Slot_BG")
    self._ui._slot[index]:clearItem()
    local itemWrapper = getInventoryBagItemByType(self._fromWhereType, self._fromSlotNo, index)
    if itemWrapper ~= nil then
      iconUI:SetShow(false)
      self._ui._slot[index].icon:SetShow(true)
      self._ui._slot[index]:setItem(itemWrapper, index)
      self._ui._slot[index].icon:SetMonoTone(false)
      if self._isPadSnapping == true then
        self._ui._slot[index].icon:addInputEvent("Mouse_LUp", "HandleEventRUp_ClothInventory_Renew_All_ClothInvenRClick(" .. self._fromWhereType .. ", " .. self._fromSlotNo .. ", " .. index .. ", " .. self._bagType .. ")")
      else
        self._ui._slot[index].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_ClothInventory_Renew_All_ClothInvenRClick(" .. self._fromWhereType .. ", " .. self._fromSlotNo .. ", " .. index .. ", " .. self._bagType .. ")")
      end
      local itemEnchantWrapper = itemWrapper:getStaticStatus()
      if itemEnchantWrapper ~= nil then
        local extendSlotNoMax = itemEnchantWrapper:getExtendedSlotCount()
        for i = 1, extendSlotNoMax do
          local extendEquipSlotNo = itemEnchantWrapper:getExtendedSlotIndex(i - 1)
          if extendSlotNoMax ~= extendEquipSlotNo then
            extendInventorySlotNo = ToClient_getInventoryBagCashRenewSlotNo(extendEquipSlotNo)
            if extendInventorySlotNo ~= __eTInventorySlotNoUndefined then
              extendedSlotInfoArray[extendInventorySlotNo] = index
              checkExtendedSlot = true
            end
          end
        end
      end
    else
      iconUI:SetShow(true)
      self._ui._slot[index].icon:SetShow(false)
      self._currSlotInfo.index = nil
      self._ui._slot[index]:clearItem()
      self._ui._slot[index].icon:removeInputEvent("Mouse_LUp")
      self._ui._slot[index].icon:removeInputEvent("Mouse_RUp")
    end
    self._ui._slot[index].icon:addInputEvent("Mouse_On", "PaGlobalFunc_ClothInventory_Renew_All_ShowTooltip(true, " .. self._fromWhereType .. ", " .. self._fromSlotNo .. ", " .. index .. ")")
    self._ui._slot[index].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ClothInventory_Renew_All_ShowTooltip(false)")
  end
  if checkExtendedSlot == true then
    for extendInventorySlotNo, originInventorySlotNo in pairs(extendedSlotInfoArray) do
      local itemWrapper = getInventoryBagItemByType(self._fromWhereType, self._fromSlotNo, originInventorySlotNo)
      self._ui._slot[extendInventorySlotNo]:setItem(itemWrapper, originInventorySlotNo)
      self._ui._slot[extendInventorySlotNo].icon:SetMonoTone(true)
      self._ui._slot[extendInventorySlotNo].icon:SetShow(true)
      local iconUI = UI.getChildControl(self._ui._slotBg[extendInventorySlotNo], "Static_Slot_BG")
      iconUI:SetShow(false)
    end
  end
  if _ContentsGroup_NewUI_Inventory_All == true then
    PaGlobalFunc_Inventory_All_UpdateInventoryWeight()
  else
    FGlobal_UpdateInventoryWeight()
  end
end
function PaGlobal_ClothInventory_Renew_All:validate()
  if Panel_Window_ClothInventory_Renew_All == nil then
    return
  end
  self._ui._stc_titleBg:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._stc_bg:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._btn_changeAll:isValidate()
  self._ui._stc_keyguideBg:isValidate()
end
