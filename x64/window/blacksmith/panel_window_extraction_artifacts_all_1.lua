function PaGlobal_Extraction_Artifacts_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:setUiSetting()
  self:setNotice()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Extraction_Artifacts_All:controlAll_Init()
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
  local mainBg = UI.getChildControl(Panel_Window_Extraction_Artifacts_All, "Static_Artifacts_MainBG")
  local topDescArea = UI.getChildControl(mainBg, "Static_TopDescArea")
  self._ui.txt_desc = UI.getChildControl(topDescArea, "StaticText_Desc")
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(self._ui.txt_desc:GetText())
  local extractionBg = UI.getChildControl(mainBg, "Static_Crystal_ExtractionBG")
  local imagePartArea = UI.getChildControl(extractionBg, "Static_ImagePartArea")
  local extractImage = UI.getChildControl(imagePartArea, "Static_LightStoneExtractImage")
  for idx = 1, 2 do
    self._ui.stc_lightStoneInfo[idx].stc_lightStone = UI.getChildControl(extractImage, "Static_LightStoneInfo" .. idx)
    self._ui.stc_lightStoneInfo[idx].txt_name = UI.getChildControl(self._ui.stc_lightStoneInfo[idx].stc_lightStone, "StaticText_LightStoneName")
    self._ui.stc_lightStoneInfo[idx].txt_desc = UI.getChildControl(self._ui.stc_lightStoneInfo[idx].stc_lightStone, "StaticText_LightStoneDesc")
    self._ui.stc_lightStoneInfo[idx].btn_extraction = UI.getChildControl(self._ui.stc_lightStoneInfo[idx].stc_lightStone, "Button_Extraction")
    self._ui.stc_lightStoneInfo[idx].btn_delete_console = UI.getChildControl(self._ui.stc_lightStoneInfo[idx].stc_lightStone, "Button_ConsoleButtonA")
    self._ui.stc_lightStoneInfo[idx].btn_extraction_console = UI.getChildControl(self._ui.stc_lightStoneInfo[idx].stc_lightStone, "Button_ConsoleButtonY")
    local lightStoneSlotBg = UI.getChildControl(extractImage, "Static_LightStoneItemSlotBG" .. idx)
    self._ui.stc_lightStoneInfo[idx].stc_itemSlot = UI.getChildControl(lightStoneSlotBg, "Static_" .. idx)
  end
  local rightTopArea = UI.getChildControl(Panel_Window_Extraction_Artifacts_All, "Static_RightTopArea")
  self._ui.list2_extractableItem = UI.getChildControl(rightTopArea, "List2_ExtractableItemList")
  local listContent = UI.getChildControl(self._ui.list2_extractableItem, "List2_1_Content")
  local btn_list = UI.getChildControl(listContent, "RadioButton_ExtractableItem")
  local stc_itemSlotBg = UI.getChildControl(btn_list, "Static_ItemSlotBG")
  local itemlistSlot = UI.getChildControl(stc_itemSlotBg, "Static_ItemIcon")
  local slot = {}
  SlotItem.new(slot, "LightStone_Extraction", 0, itemlistSlot, self._slotConfig)
  slot:createChild()
  slot.empty = true
  slot:clearItem()
  local rightBottomArea = UI.getChildControl(Panel_Window_Extraction_Artifacts_All, "Static_RightBottomArea")
  self._ui.list2_materialItem = UI.getChildControl(rightBottomArea, "List2_ExtractionMaterialItemList")
  local listMaterialContent = UI.getChildControl(self._ui.list2_materialItem, "List2_1_Content")
  local btn_materiallist = UI.getChildControl(listMaterialContent, "RadioButton_ExtractionMaterialItem")
  local stc_materialItemSlotBg = UI.getChildControl(btn_materiallist, "Static_ItemSlotBG")
  local materialItemlistSlot = UI.getChildControl(stc_materialItemSlotBg, "Static_ItemIcon")
  self._ui.stc_materialItemSlot = UI.getChildControl(extractImage, "Static_ExtractionHammerItemSlot")
  self._ui.stc_extractionItemSlot = UI.getChildControl(extractImage, "Static_MainEquipSlot")
  self._ui.stc_extractImage = UI.getChildControl(imagePartArea, "Static_LightStoneExtractImage")
  self._ui.txt_noItem = UI.getChildControl(self._ui.list2_extractableItem, "StaticText_Desc")
end
function PaGlobal_Extraction_Artifacts_All:controlPc_Init()
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
  local titlebarArea = UI.getChildControl(Panel_Window_Extraction_Artifacts_All, "Static_TitlebarArea")
  self._ui_pc.btn_question = UI.getChildControl(titlebarArea, "Button_Question")
  self._ui_pc.btn_close = UI.getChildControl(titlebarArea, "Button_Close")
end
function PaGlobal_Extraction_Artifacts_All:controlConsole_Init()
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
  self._ui_console.stc_guideBg = UI.getChildControl(Panel_Window_Extraction_Artifacts_All, "Static_BottomConsoleButtons")
  self._ui_console.stc_iconX = UI.getChildControl(self._ui_console.stc_guideBg, "Button_Detail")
  self._ui_console.stc_iconA = UI.getChildControl(self._ui_console.stc_guideBg, "Button_Select")
  self._ui_console.stc_iconB = UI.getChildControl(self._ui_console.stc_guideBg, "Button_Cancel")
end
function PaGlobal_Extraction_Artifacts_All:setUiSetting()
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
  if false == PaGlobal_Extraction_Artifacts_All._isConsole then
    self._ui_pc.btn_question:SetShow(true)
    self._ui_pc.btn_close:SetShow(true)
    self._ui_console.stc_guideBg:SetShow(false)
    for idx = 1, 2 do
      self._ui.stc_lightStoneInfo[idx].btn_extraction:SetShow(true)
      self._ui.stc_lightStoneInfo[idx].btn_delete_console:SetShow(false)
      self._ui.stc_lightStoneInfo[idx].btn_extraction_console:SetShow(false)
    end
  else
    self._ui_pc.btn_question:SetShow(false)
    self._ui_pc.btn_close:SetShow(false)
    self._ui_console.stc_guideBg:SetShow(true)
    for idx = 1, 2 do
      self._ui.stc_lightStoneInfo[idx].btn_extraction:SetShow(false)
      self._ui.stc_lightStoneInfo[idx].btn_delete_console:SetShow(true)
      self._ui.stc_lightStoneInfo[idx].btn_extraction_console:SetShow(true)
    end
    local keyGuides = {
      self._ui_console.stc_iconX,
      self._ui_console.stc_iconA,
      self._ui_console.stc_iconB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_guideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui_console.stc_iconX:SetShow(false)
    Panel_Window_Extraction_Artifacts_All:ignorePadSnapMoveToOtherPanel()
  end
  self._ui._icon_items = {}
  SlotItem.new(self._ui._icon_items, "feeItem", nil, self._ui.stc_extractionItemSlot, self._slotConfig)
  self._ui._icon_items:createChild()
  self._ui._icon_items:clearItem()
  self._ui._icon_materialItems = {}
  SlotItem.new(self._ui._icon_materialItems, "resultItem", nil, self._ui.stc_materialItemSlot, self._slotConfig)
  self._ui._icon_materialItems:createChild()
  self._ui._icon_materialItems:clearItem()
  self._ui._icon_lightStoneItems = {
    [1] = {},
    [2] = {}
  }
  for idx = 1, 2 do
    SlotItem.new(self._ui._icon_lightStoneItems[idx], "Socket_" .. idx, idx, self._ui.stc_lightStoneInfo[idx].stc_itemSlot, self._slotConfig)
    self._ui._icon_lightStoneItems[idx]:createChild()
    self._ui._icon_lightStoneItems[idx]:clearItem()
  end
  if true == _ContentsOption_CH_Help then
    self._ui_pc.btn_question:SetShow(false)
  end
  FromClient_Extraction_Artifacts_All_ReSizePanel()
end
function PaGlobal_Extraction_Artifacts_All:registEventHandler()
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Extraction_Artifacts_All_ReSizePanel()")
  registerEvent("EventEquipmentUpdate", "FromClient_Extraction_Artifacts_All_UpdateList")
  registerEvent("FromClient_ChangeArtifactSocket", "FromClient_Extraction_Artifacts_All_ChangeArtifactSocket")
  self._ui.list2_extractableItem:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_Extraction_Artifacts_All_UpdateArtifactList")
  self._ui.list2_extractableItem:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list2_materialItem:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_Extraction_Artifacts_All_UpdateMaterialList")
  self._ui.list2_materialItem:createChildContent(__ePAUIList2ElementManagerType_List)
  if false == self._isConsole then
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Extraction_Artifacts_All_Close()")
    self._ui_pc.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowExtractionCrystal\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui_pc.btn_question, "\"PanelWindowExtractionArtifact\"")
  else
  end
end
function PaGlobal_Extraction_Artifacts_All:prepareOpen()
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
  self:setOpenUisetting()
  PaGlobal_Extraction_Artifacts_All_UpdateList()
  local posY = (getScreenSizeY() - Panel_Window_Extraction_Artifacts_All:GetSizeY() - Panel_Window_Extraction_All:GetSizeY()) * 0.5
  Panel_Window_Extraction_Artifacts_All:SetPosY(posY)
  PaGlobal_Extraction_Artifacts_All:open()
end
function PaGlobal_Extraction_Artifacts_All:open()
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
  Panel_Window_Extraction_Artifacts_All:SetShow(true)
end
function PaGlobal_Extraction_Artifacts_All:prepareClose()
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
  self:clearAllSlots()
  PaGlobal_Extraction_Artifacts_All:close()
end
function PaGlobal_Extraction_Artifacts_All:close()
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
  Panel_Window_Extraction_Artifacts_All:SetShow(false)
end
function PaGlobal_Extraction_Artifacts_All:updateExtractionList()
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
  self._ui.list2_extractableItem:getElementManager():clearKey()
  local EquipNoMin = __eEquipSlotNoRightHand
  local EquipNoMax = __eEquipSlotNoCount
  self._artifactInvenEnd = -1
  self._artifactList = {}
  local listCount = -1
  local whereType = CppEnums.ItemWhereType.eInventory
  local inventory = getSelfPlayer():get():getInventory(whereType)
  if nil == inventory then
    return
  end
  local invenMaxSize = inventory:sizeXXX()
  for slotNo = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(whereType, slotNo)
    if false == self:filterInvenArtifactItem(slotNo, itemWrapper, CppEnums.ItemWhereType.eInventory) then
      listCount = listCount + 1
      self._artifactList[listCount] = slotNo
      self._ui.list2_extractableItem:getElementManager():pushKey(toInt64(0, listCount))
    end
  end
  self._artifactInvenEnd = listCount
  for equipNo = EquipNoMin, EquipNoMax do
    local itemWrapper = ToClient_getEquipmentItem(equipNo)
    if false == self:filterEquipArtifactItem(equipNo, itemWrapper) then
      listCount = listCount + 1
      self._artifactList[listCount] = equipNo
      self._ui.list2_extractableItem:getElementManager():pushKey(toInt64(0, listCount))
    end
  end
  self._ui.txt_noItem:SetShow(listCount < 0)
end
function PaGlobal_Extraction_Artifacts_All:filterInvenArtifactItem(slotNo, itemWrapper, whereType)
  if nil == itemWrapper then
    return true
  end
  local isDuplicatedForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
  if true == isDuplicatedForDuel then
    return true
  end
  if false == itemWrapper:getStaticStatus():get():isArtifact() then
    return true
  end
  if true == ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    return true
  end
  local maxCount = itemWrapper:get():getUsableItemSocketCount()
  local blankSlot_Count = maxCount
  for sock_idx = 1, maxCount do
    local itemStaticWrapper = itemWrapper:getPushedItem(sock_idx - 1)
    if nil == itemStaticWrapper then
      blankSlot_Count = blankSlot_Count - 1
    end
  end
  if true == itemWrapper:getStaticStatus():get():doHaveSocket() and 0 ~= blankSlot_Count then
    return false
  end
end
function PaGlobal_Extraction_Artifacts_All:filterEquipArtifactItem(slotNo, itemWrapper)
  if nil == itemWrapper then
    return true
  end
  if false == itemWrapper:getStaticStatus():get():isArtifact() then
    return true
  end
  if true == ToClient_EquipSlot_CheckItemLock(slotNo, CppEnums.ItemWhereType.eEquip) then
    return true
  end
  local maxCount = itemWrapper:get():getUsableItemSocketCount()
  local blankSlot_Count = maxCount
  for sock_idx = 1, maxCount do
    local itemStaticWrapper = itemWrapper:getPushedItem(sock_idx - 1)
    if nil == itemStaticWrapper then
      blankSlot_Count = blankSlot_Count - 1
    end
  end
  if true == itemWrapper:getStaticStatus():get():doHaveSocket() and 0 ~= blankSlot_Count then
    return false
  end
end
function PaGlobal_Extraction_Artifacts_All:updateMaterialList()
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
  self._ui.list2_materialItem:getElementManager():clearKey()
  self._materialCount = 0
  self._materialList = {}
  self:setMaterialListInfo(getSelfPlayer():get():getInventory():getSlot(self._materialEnchantKey.stuffCrystalExtraction), CppEnums.ItemWhereType.eInventory, getItemEnchantStaticStatus(self._materialEnchantKey.stuffCrystalExtraction))
  local whereType = CppEnums.ItemWhereType.eInventory
  local inventory = getSelfPlayer():get():getInventory(whereType)
  if nil == inventory then
    return
  end
  local invenMaxSize = inventory:sizeXXX()
  for slotNo = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(whereType, slotNo)
    if false == self:filterMaterialItem(slotNo, whereType, itemWrapper) then
      self:setMaterialListInfo(slotNo, whereType, itemWrapper:getStaticStatus())
    end
  end
  whereType = CppEnums.ItemWhereType.eCashInventory
  local cashInven = getSelfPlayer():get():getCashInventory()
  if nil == cashInven then
    return
  end
  local invenMaxSize = cashInven:sizeXXX()
  for slotNo = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(whereType, slotNo)
    if false == self:filterMaterialItem(slotNo, whereType, itemWrapper) then
      self:setMaterialListInfo(slotNo, whereType, itemWrapper:getStaticStatus())
    end
  end
end
function PaGlobal_Extraction_Artifacts_All:filterMaterialItem(slotNo, whereType, itemWrapper)
  return true
end
function PaGlobal_Extraction_Artifacts_All:setMaterialListInfo(slotNo, whereType, itemSSW)
  if nil == itemSSW then
    return
  end
  self._materialCount = self._materialCount + 1
  self._ui.list2_materialItem:getElementManager():pushKey(toInt64(0, self._materialCount))
  self._materialList[self._materialCount] = {}
  self._materialList[self._materialCount].name = itemSSW:getName()
  self._materialList[self._materialCount].iconPath = itemSSW:getIconPath()
  self._materialList[self._materialCount].slotNo = slotNo
  self._materialList[self._materialCount].whereType = whereType
  local itemCount = 0
  if __eTInventorySlotNoUndefined ~= slotNo then
    itemCount = Int64toInt32(getInventoryItemByType(whereType, slotNo):get():getCount_s64())
  end
  self._materialList[self._materialCount].itemCount = itemCount
end
function PaGlobal_Extraction_Artifacts_All:clearArtifactSlot()
  self._artifactWhereType = nil
  self._artifactSlotNo = nil
  self._ui._icon_items:clearItem()
  self._ui._icon_items.icon:addInputEvent("Mouse_On", "")
  self._ui._icon_items.icon:addInputEvent("Mouse_Out", "")
  getSocketInformation():clearData()
end
function PaGlobal_Extraction_Artifacts_All:clearLightStoneSlots()
  for idx = 1, 2 do
    self._ui._icon_lightStoneItems[idx]:clearItem()
    self._ui._icon_lightStoneItems[idx].icon:EraseAllEffect()
    self._ui._icon_lightStoneItems[idx].icon:addInputEvent("Mouse_On", "")
    self._ui._icon_lightStoneItems[idx].icon:addInputEvent("Mouse_Out", "")
    self._ui.stc_lightStoneInfo[idx].txt_name:SetText("")
    self._ui.stc_lightStoneInfo[idx].txt_desc:SetText("")
    self._ui.stc_lightStoneInfo[index].isEmpty = true
    if false == self._isConsole then
      self._ui.stc_lightStoneInfo[idx].btn_extraction:SetEnable(false)
      self._ui.stc_lightStoneInfo[idx].btn_extraction:SetMonoTone(true)
    else
    end
  end
end
function PaGlobal_Extraction_Artifacts_All:clearMaterialSlot()
  self._materialWhereType = nil
  self._materialSlotNo = nil
  self._ui._icon_materialItems:clearItem()
  self._ui._icon_materialItems.icon:addInputEvent("Mouse_On", "")
  self._ui._icon_materialItems.icon:addInputEvent("Mouse_Out", "")
  for index = 1, 2 do
    if false == self._isConsole then
      self._ui.stc_lightStoneInfo[index].btn_extraction:SetEnable(false)
      self._ui.stc_lightStoneInfo[index].btn_extraction:SetMonoTone(true)
    elseif false == self._ui.stc_lightStoneInfo[index].isEmpty then
      self._ui.stc_lightStoneInfo[index].btn_extraction_console:SetMonoTone(true)
      self._ui.stc_lightStoneInfo[index].btn_extraction_console:SetEnable(false)
      self._ui.stc_lightStoneInfo[index].stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    else
      HandlePadEventOn_Extraction_Artifacts_All_SocketOnTextureChange(index, false)
      self._ui.stc_lightStoneInfo[index].btn_extraction_console:SetShow(false)
      self._ui.stc_lightStoneInfo[index].btn_delete_console:SetShow(false)
    end
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_hideTooltip()
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
end
function PaGlobal_Extraction_Artifacts_All:clearAllSlots()
  self:clearArtifactSlot()
  self:clearLightStoneSlots()
  self:clearMaterialSlot()
  for index = 1, 2 do
    self._ui.stc_lightStoneInfo[index].btn_extraction_console:SetMonoTone(true)
    self._ui.stc_lightStoneInfo[index].btn_extraction_console:SetEnable(false)
    self._ui.stc_lightStoneInfo[index].stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    self._ui.stc_lightStoneInfo[index].btn_extraction_console:SetShow(false)
    self._ui.stc_lightStoneInfo[index].btn_delete_console:SetShow(false)
    self._ui.stc_lightStoneInfo[index].stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    HandlePadEventOn_Extraction_Artifacts_All_SocketOnTextureChange(index, false)
  end
end
function PaGlobal_Extraction_Artifacts_All:setArtifactSlot()
  if nil == self._artifactWhereType or nil == self._artifactSlotNo then
    self:clearAllSlots()
    return
  end
  local itemWrapper = getInventoryItemByType(self._artifactWhereType, self._artifactSlotNo)
  if nil == itemWrapper then
    self:clearAllSlots()
    return
  end
  local staticStatus = itemWrapper:getStaticStatus()
  if nil == staticStatus then
    return
  end
  local success = 0 == Socket_SetItemHaveSocket(self._artifactWhereType, self._artifactSlotNo)
  if false == success then
    self:clearAllSlots()
    return
  end
  self._ui._icon_items:clearItem()
  self._ui._icon_items:setItem(itemWrapper)
  self._ui._icon_items.icon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_Artifacts_All_ShowListToolTip(false," .. self._artifactSlotNo .. "," .. self._artifactWhereType .. ",true)")
  self._ui._icon_items.icon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_Artifacts_All_ShowListToolTip(false," .. self._artifactSlotNo .. "," .. self._artifactWhereType .. ",false)")
  self._ui._icon_items.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Extraction_Artifacts_All_ClearAllSlots()")
  self:setLightStoneSlots(itemWrapper)
end
function PaGlobal_Extraction_Artifacts_All:setLightStoneSlots(itemWrapper)
  if nil == itemWrapper then
    self:clearAllSlots()
    return
  end
  local maxCount = itemWrapper:get():getUsableItemSocketCount()
  local classType = getSelfPlayer():getClassType()
  local haveCrystal = false
  for ii = 1, maxCount do
    self._ui._icon_lightStoneItems[ii]:clearItem()
    self._ui.stc_lightStoneInfo[ii].isEmpty = true
    local itemStaticWrapper = itemWrapper:getPushedItem(ii - 1)
    if nil ~= itemStaticWrapper then
      self._ui.stc_lightStoneInfo[ii].txt_name:SetMonoTone(false)
      self._ui.stc_lightStoneInfo[ii].txt_desc:SetMonoTone(false)
      self._ui._icon_lightStoneItems[ii].icon:EraseAllEffect()
      local effectName = ""
      if 1 == ii then
        effectName = "fUI_BlackExtractCrystal_02A"
      elseif 2 == ii then
        effectName = "fUI_BlackExtractCrystal_02B"
      end
      self._ui._icon_lightStoneItems[ii].icon:AddEffect(effectName, true, 0, 0)
      self._ui._icon_lightStoneItems[ii]:setItemByStaticStatus(itemStaticWrapper, 0)
      self._ui._icon_lightStoneItems[ii].icon:ComputePos()
      local text = itemStaticWrapper:getName()
      local desc = ""
      self._ui.stc_lightStoneInfo[ii].txt_name:SetText(text)
      self._ui.stc_lightStoneInfo[ii].txt_desc:SetTextMode(__eTextMode_Limit_AutoWrap)
      self._ui.stc_lightStoneInfo[ii].txt_desc:setLineCountByLimitAutoWrap(3)
      PAGlobalFunc_SetItemTextColor(self._ui.stc_lightStoneInfo[ii].txt_name, itemStaticWrapper)
      local jewelSkillStaticWrapper = itemStaticWrapper:getSkillByIdx(classType)
      if nil ~= jewelSkillStaticWrapper then
        local descTable = ""
        for buffIdx = 0, jewelSkillStaticWrapper:getBuffCount() - 1 do
          local descCurrent = jewelSkillStaticWrapper:getBuffDescription(buffIdx)
          if nil == descCurrent or "" == descCurrent then
            break
          end
          descTable = descTable .. descCurrent .. "\n"
        end
        self._ui.stc_lightStoneInfo[ii].txt_desc:SetText(descTable)
        local itemKey = itemStaticWrapper:get()._key
        if false == self._isConsole then
          self._ui._icon_lightStoneItems[ii].icon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_Artifacts_All_ShowToolTip(" .. itemKey:getItemKey() .. ",true)")
          self._ui._icon_lightStoneItems[ii].icon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_Artifacts_All_ShowToolTip(" .. itemKey:getItemKey() .. ",false)")
          self._ui._icon_lightStoneItems[ii].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Extraction_Artifacts_All_RemoveLightStone(" .. ii .. ")")
        else
          self._ui._icon_lightStoneItems[ii].icon:addInputEvent("Mouse_On", "PaGlobal_Extraction_Artifacts_All_ShowDetailKeyGuide(true, nil, " .. ii .. ")")
          self._ui._icon_lightStoneItems[ii].icon:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Artifacts_All_ShowDetailKeyGuide(false, nil, " .. ii .. ")")
          self._ui.stc_lightStoneInfo[ii].stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Extraction_Artifacts_All_ShowToolTip(" .. itemKey:getItemKey() .. ",nil)")
          self._ui.stc_lightStoneInfo[ii].btn_delete_console:SetShow(true)
          self._ui.stc_lightStoneInfo[ii].stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_Extraction_Artifacts_All_RemoveLightStone(" .. ii .. ")")
          self._ui.stc_lightStoneInfo[ii].btn_extraction_console:SetShow(true)
          self._ui.stc_lightStoneInfo[ii].btn_extraction_console:SetMonoTone(true)
          self._ui.stc_lightStoneInfo[ii].btn_extraction_console:SetEnable(false)
        end
        self._ui.stc_lightStoneInfo[ii].isEmpty = false
      end
      haveCrystal = true
    else
      self._ui.stc_lightStoneInfo[ii].txt_name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SOCKET_EMPTYSLOT"))
      self._ui.stc_lightStoneInfo[ii].txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_CRYSTAL_SLOT_EMPTY"))
      self._ui.stc_lightStoneInfo[ii].isEmpty = true
      self._ui._icon_lightStoneItems[ii].icon:EraseAllEffect()
      self._ui._icon_lightStoneItems[ii].icon:addInputEvent("Mouse_On", "PaGlobal_Extraction_Artifacts_All_ShowDetailKeyGuide(false, nil, " .. ii .. ")")
      self._ui._icon_lightStoneItems[ii].icon:addInputEvent("Mouse_Out", "")
      if false == self._isConsole then
        self._ui._icon_lightStoneItems[ii].icon:addInputEvent("Mouse_RUp", "")
      else
        PaGlobal_Extraction_Artifacts_All_ShowDetailKeyGuide(false, nil, ii)
        self._ui.stc_lightStoneInfo[ii].stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
      end
      self._ui.stc_lightStoneInfo[ii].btn_extraction_console:SetMonoTone(true)
      self._ui.stc_lightStoneInfo[ii].btn_extraction_console:SetEnable(false)
      self._ui.stc_lightStoneInfo[ii].stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      self._ui.stc_lightStoneInfo[ii].stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    end
  end
  if false == haveCrystal then
    self:clearAllSlots()
  end
end
function PaGlobal_Extraction_Artifacts_All:setMaterialSlot(itemWrapper, whereType, slotNo)
  if nil == itemWrapper or __eTInventorySlotNoUndefined == slotNo then
    self:clearMaterialSlot()
    return
  end
  local staticStatus = itemWrapper:getStaticStatus()
  if nil == staticStatus then
    return
  end
  local invenItem = getInventoryItemByType(whereType, slotNo)
  local itemCount = 0
  if nil ~= invenItem then
    itemCount = Int64toInt32(invenItem:get():getCount_s64())
  end
  self._ui._icon_materialItems:clearItem()
  self._ui._icon_materialItems:setItemByStaticStatus(staticStatus, itemCount)
  local itemKey = itemWrapper:get():getKey()
  self._ui._icon_materialItems.icon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_Artifacts_All_ShowToolTip(" .. itemKey:getItemKey() .. ",true)")
  self._ui._icon_materialItems.icon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_Artifacts_All_ShowToolTip(" .. itemKey:getItemKey() .. ",false)")
  self._ui._icon_materialItems.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Extraction_Artifacts_All_MaterialItem()")
  self._materialWhereType = whereType
  self._materialSlotNo = slotNo
  getSocketInformation():isExtractionSource(self._materialWhereType, self._materialSlotNo)
  for idx = 1, 2 do
    if false == self._ui.stc_lightStoneInfo[idx].isEmpty then
      if false == self._isConsole then
        self._ui.stc_lightStoneInfo[idx].btn_extraction:SetMonoTone(false)
        self._ui.stc_lightStoneInfo[idx].btn_extraction:SetEnable(true)
        self._ui.stc_lightStoneInfo[idx].btn_extraction:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Artifacts_All_ExtractionLightStone(" .. idx .. ")")
      else
        self._ui.stc_lightStoneInfo[idx].btn_extraction_console:SetShow(true)
        self._ui.stc_lightStoneInfo[idx].btn_extraction_console:SetMonoTone(false)
        self._ui.stc_lightStoneInfo[idx].btn_extraction_console:SetEnable(true)
        self._ui.stc_lightStoneInfo[idx].stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Extraction_Artifacts_All_ExtractionLightStone(" .. idx .. ")")
      end
    elseif false == self._isConsole then
      self._ui.stc_lightStoneInfo[idx].btn_extraction:SetMonoTone(true)
      self._ui.stc_lightStoneInfo[idx].btn_extraction:SetEnable(false)
      self._ui.stc_lightStoneInfo[idx].btn_extraction:addInputEvent("Mouse_LUp", "")
    else
      self._ui.stc_lightStoneInfo[idx].btn_extraction_console:SetShow(false)
      self._ui.stc_lightStoneInfo[idx].btn_delete_console:SetShow(false)
    end
  end
end
function PaGlobal_Extraction_Artifacts_All:validate()
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
  self:allValidate()
  self:pcValidate()
  self:consoleValidate()
end
function PaGlobal_Extraction_Artifacts_All:allValidate()
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
  self._ui.txt_desc:isValidate()
  self._ui.stc_materialItemSlot:isValidate()
  self._ui.stc_extractionItemSlot:isValidate()
  self._ui.list2_extractableItem:isValidate()
  self._ui.list2_materialItem:isValidate()
  self._ui.stc_extractImage:isValidate()
  for idx = 1, 2 do
    self._ui.stc_lightStoneInfo[idx].txt_name:isValidate()
    self._ui.stc_lightStoneInfo[idx].txt_desc:isValidate()
    self._ui.stc_lightStoneInfo[idx].btn_extraction:isValidate()
    self._ui.stc_lightStoneInfo[idx].stc_itemSlot:isValidate()
  end
end
function PaGlobal_Extraction_Artifacts_All:pcValidate()
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
  self._ui_pc.btn_question:isValidate()
  self._ui_pc.btn_close:isValidate()
end
function PaGlobal_Extraction_Artifacts_All:consoleValidate()
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
end
function PaGlobal_Extraction_Artifacts_All:setOpenUisetting()
  for idx = 1, 2 do
    if false == self._isConsole then
      self._ui.stc_lightStoneInfo[idx].btn_extraction:SetEnable(false)
      self._ui.stc_lightStoneInfo[idx].btn_extraction:SetMonoTone(true)
    else
      self._ui.stc_lightStoneInfo[idx].btn_extraction_console:SetEnable(false)
      self._ui.stc_lightStoneInfo[idx].btn_extraction_console:SetMonoTone(true)
    end
    self._ui.stc_lightStoneInfo[idx].txt_name:SetText("")
    self._ui.stc_lightStoneInfo[idx].txt_desc:SetText("")
  end
  getSocketInformation():clearData()
end
function PaGlobal_Extraction_Artifacts_All:setNotice()
  if self._ui.txt_desc:GetTextSizeY() > self._ui.txt_desc:GetSizeY() then
    local sizeY = self._ui.txt_desc:GetTextSizeY() - self._ui.txt_desc:GetSizeY()
    self._ui.txt_desc:SetSize(self._ui.txt_desc:GetSizeX(), self._ui.txt_desc:GetTextSizeY())
    Panel_Window_Extraction_Artifacts_All:SetSize(Panel_Window_Extraction_Artifacts_All:GetSizeX(), Panel_Window_Extraction_Artifacts_All:GetSizeY() + sizeY)
    local rightBottomArea = UI.getChildControl(Panel_Window_Extraction_Artifacts_All, "Static_RightBottomArea")
    rightBottomArea:SetSize(rightBottomArea:GetSizeX(), rightBottomArea:GetSizeY() + sizeY)
    self._ui.list2_materialItem:SetSize(self._ui.list2_materialItem:GetSizeX(), self._ui.list2_materialItem:GetSizeY() + sizeY)
    local leftMainArea = UI.getChildControl(Panel_Window_Extraction_Artifacts_All, "Static_Artifacts_MainBG")
    leftMainArea:SetSize(leftMainArea:GetSizeX(), leftMainArea:GetSizeY() + sizeY)
    local topDescArea = UI.getChildControl(leftMainArea, "Static_TopDescArea")
    topDescArea:SetSize(topDescArea:GetSizeX(), topDescArea:GetSizeY() + sizeY)
    rightBottomArea:ComputePos()
    leftMainArea:ComputePos()
    topDescArea:ComputePos()
    FromClient_Extraction_Artifacts_All_ReSizePanel()
  end
end
