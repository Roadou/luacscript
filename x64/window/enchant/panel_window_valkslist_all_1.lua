function PaGlobal_ValksList_All:initialize()
  if Panel_Window_ValksList_All == nil or PaGlobal_ValksList_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlInit()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ValksList_All:controlInit()
  if Panel_Window_ValksList_All == nil then
    return
  end
  self._ui.stc_titleArea = UI.getChildControl(Panel_Window_ValksList_All, "Static_TitleArea")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleArea, "Button_Close")
  self._ui.stc_mainSlotBG = UI.getChildControl(Panel_Window_ValksList_All, "Static_MainSlotBG")
  self._ui.stc_listArea = UI.getChildControl(self._ui.stc_mainSlotBG, "Static_ListArea")
  self._ui.frame_itemList = UI.getChildControl(self._ui.stc_listArea, "Frame_TotalReward_Import")
  self._ui.frame_content = UI.getChildControl(self._ui.frame_itemList, "Frame_1_Content")
  self._ui.scroll_vertical = UI.getChildControl(self._ui.frame_itemList, "Frame_1_VerticalScroll")
  self._ui.stc_keyGuide = UI.getChildControl(Panel_Window_ValksList_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_keyGuide_B = UI.getChildControl(self._ui.stc_keyGuide, "StaticText_KeyGuide_B_ConsoleUI")
  self._ui.btn_close:SetShow(self._isConsole == false)
end
function PaGlobal_ValksList_All:prepareOpen()
  if Panel_Window_ValksList_All == nil then
    return
  end
  if self._isConsole == true then
    if Panel_Window_Inventory ~= nil then
      local inventoryPanelPosX = Panel_Window_Inventory:GetPosX()
      local inventoryPanelPosY = Panel_Window_Inventory:GetPosY()
      Panel_Window_ValksList_All:SetPosX(inventoryPanelPosX - Panel_Window_ValksList_All:GetSizeX() - 5)
      Panel_Window_ValksList_All:SetPosY(inventoryPanelPosY)
    end
    self._ui.stc_keyGuide:SetShow(true)
    local keyGuides = {
      self._ui.stc_keyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
    if Panel_Window_Inventory_All ~= nil and false == Panel_Window_Inventory_All:IsUISubApp() then
      local inventoryPanelPosX = Panel_Window_Inventory_All:GetPosX()
      local inventoryPanelPosY = Panel_Window_Inventory_All:GetPosY()
      local posX = inventoryPanelPosX - Panel_Window_ValksList_All:GetSizeX() - 5
      if posX < 0 then
        posX = inventoryPanelPosX + Panel_Window_Inventory_All:GetSizeX() + 5
      end
      Panel_Window_ValksList_All:SetPosX(posX)
      Panel_Window_ValksList_All:SetPosY(inventoryPanelPosY)
    end
    if _ContentsGroup_NewUI_Inventory_All == true then
      if Panel_Window_Inventory_All:GetShow() == false then
        Panel_Window_Inventory_All:SetShow(true)
      end
    elseif Panel_Window_Inventory:GetShow() == false then
      Panel_Window_Inventory:SetShow(true)
    end
    self._ui.stc_keyGuide:SetShow(false)
  end
  self:update()
  self:open()
end
function PaGlobal_ValksList_All:open()
  if Panel_Window_ValksList_All == nil then
    return
  end
  Panel_Window_ValksList_All:SetShow(true)
end
function PaGlobal_ValksList_All:prepareClose()
  if Panel_Window_ValksList_All == nil then
    return
  end
  if self._isConsole == true then
  elseif _ContentsGroup_NewUI_Inventory_All == true then
    PaGlobalFunc_Inventory_All_ShowEquipUI()
  else
    Inventory_ShowEquipUI()
  end
  HandleEventOn_ValksList_ShowTooltip(0, false)
  self:close()
end
function PaGlobal_ValksList_All:close()
  if Panel_Window_ValksList_All == nil then
    return
  end
  Panel_Window_ValksList_All:SetShow(false)
end
function PaGlobal_ValksList_All:update()
  if Panel_Window_ValksList_All == nil then
    return
  end
  local valksListCount = ToClient_GetInventoryEnchantMaterialSize()
  for index = 0, valksListCount do
    local itemSSW = ToClient_GetInventoryEnchantMaterial(index)
    if itemSSW ~= nil then
      if self._listItemSlots[index] == nil then
        self._listItemSlots[index] = self:createSlot(index)
      end
      local slot = self._listItemSlots[index]
      local row = math.floor(index / self.COLUMN_PER_ROW)
      local col = index % self.COLUMN_PER_ROW
      local itemPosY = row * (slot.iconBg:GetSizeY() + 7) + 10
      slot.iconBg:SetPosX(self.SLOT_OFFSET + self.SLOT_SIZE * col)
      slot.iconBg:SetPosY(itemPosY)
      slot.iconBg:SetShow(true)
      slot:clearItem(true)
      slot:setItemByStaticStatus(itemSSW, ToClient_GetInventoryEnchantMaterialCount(index))
      slot.icon:addInputEvent("Mouse_On", "HandleEventOn_ValksList_ShowTooltip(" .. index .. ", true)")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_ValksList_ShowTooltip(" .. index .. ", false)")
      self._ui.frame_content:SetSize(self._ui.frame_content:GetSizeX(), itemPosY + 100)
    end
  end
  self._ui.frame_itemList:UpdateContentScroll()
  self._ui.scroll_vertical:SetControlTop()
  self._ui.frame_itemList:UpdateContentPos()
end
function PaGlobal_ValksList_All:createSlot(index)
  local itemSlotBg = UI.createAndCopyBasePropertyControl(self._ui.frame_content, "Static_ItemSlotBg", self._ui.frame_content, "ValksSlotBG" .. tostring(index))
  local itemSlot = {}
  SlotItem.new(itemSlot, "ValksSlotBG" .. tostring(index), index, itemSlotBg, self._slotConfig)
  itemSlot:createChild()
  itemSlot.iconBg = itemSlotBg
  itemSlotBg:SetShow(true)
  itemSlotBg:SetIgnore(false)
  itemSlot.icon:SetAutoDisableTime(0.5)
  return itemSlot
end
function PaGlobal_ValksList_All:registEventHandler()
  if Panel_Window_ValksList_All == nil then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ValksList_All_Close()")
  registerEvent("FromClient_EnchantMaterialAdded", "PaGlobalFunc_ValksList_All_Update()")
end
function PaGlobal_ValksList_All:validate()
  if Panel_Window_ValksList_All == nil then
    return
  end
  self._ui.stc_titleArea:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_mainSlotBG:isValidate()
  self._ui.stc_listArea:isValidate()
  self._ui.frame_itemList:isValidate()
  self._ui.frame_content:isValidate()
  self._ui.scroll_vertical:isValidate()
end
