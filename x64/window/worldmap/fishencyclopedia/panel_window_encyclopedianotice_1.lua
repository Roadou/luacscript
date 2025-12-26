function PaGlobal_EncyclopediaNotice:initialize()
  if nil == Panel_Window_EncyclopediaNotice or true == PaGlobal_EncyclopediaNotice._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlInit()
  self:setConsoleUI()
  self:registerEventHandler()
  self._initialize = true
end
function PaGlobal_EncyclopediaNotice:controlInit()
  self._ui.stc_titleArea = UI.getChildControl(Panel_Window_EncyclopediaNotice, "Static_TitleArea")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleArea, "Button_Close")
  self._ui.list2_noticeList = UI.getChildControl(Panel_Window_EncyclopediaNotice, "List2_SizeUpdateResultList")
  self._ui.stc_bg = UI.getChildControl(Panel_Window_EncyclopediaNotice, "Static_BG")
  self._ui.stc_banner = UI.getChildControl(Panel_Window_EncyclopediaNotice, "Static_Banner")
  self._ui.btn_fishEncyclopedia = UI.getChildControl(self._ui.stc_banner, "Button_Banner_FishEncyclopedia")
  local listContent = UI.getChildControl(self._ui.list2_noticeList, "List2_2_Content")
  local subContent = UI.getChildControl(listContent, "SubContent_Item")
  local stc_template = UI.getChildControl(subContent, "Static_ItemSlotBG")
  local itemSlot = UI.getChildControl(stc_template, "Static_ItemIcon")
  local slot = {}
  SlotItem.new(slot, "noticeSlot_", 0, itemSlot, self._slotConfig)
  slot:createChild()
  slot.empty = true
  slot:clearItem()
  slot.icon:SetPosX(1)
  slot.icon:SetPosY(1)
  slot.icon:SetSize(40, 40)
end
function PaGlobal_EncyclopediaNotice:setConsoleUI()
  self._ui.btn_close:SetShow(self._isConsole == false)
end
function PaGlobal_EncyclopediaNotice:registerEventHandler()
  if Panel_Window_EncyclopediaNotice == nil then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_EncyclopediaNotice_Close()")
  self._ui.btn_fishEncyclopedia:addInputEvent("Mouse_LUp", "PaGlobalFunc_FishEncyclopedia_Renewal_All_Open()")
  self._ui.list2_noticeList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_EncyclopediaNotice_CreateContent")
  self._ui.list2_noticeList:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_UpdateFishEncyclopedia", "FromClient_UpdateEncyclopediaNotice")
end
function PaGlobal_EncyclopediaNotice:prepareOpen()
  if Panel_Window_EncyclopediaNotice == nil then
    return
  end
  self:update()
  self:open()
end
function PaGlobal_EncyclopediaNotice:open()
  if Panel_Window_EncyclopediaNotice == nil or true == Panel_Window_EncyclopediaNotice:GetShow() then
    return
  end
  Panel_Window_EncyclopediaNotice:SetShow(true)
end
function PaGlobal_EncyclopediaNotice:prepareClose()
  if Panel_Window_EncyclopediaNotice == nil or false == Panel_Window_EncyclopediaNotice:GetShow() then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  ToClient_ClearEncyclopediaNoticeList()
  self:close()
end
function PaGlobal_EncyclopediaNotice:close()
  if Panel_Window_EncyclopediaNotice == nil or false == Panel_Window_EncyclopediaNotice:GetShow() then
    return
  end
  Panel_Window_EncyclopediaNotice:SetShow(false)
end
function PaGlobal_EncyclopediaNotice:update()
  if Panel_Window_EncyclopediaNotice == nil then
    return
  end
  local noticeSize = ToClient_GetEncyclopediaNoticeListSize()
  local listManager = self._ui.list2_noticeList:getElementManager()
  listManager:clearKey()
  for index = 0, noticeSize - 1 do
    listManager:pushKey(toInt64(0, index))
  end
end
function PaGlobal_EncyclopediaNotice:createContent(content, key)
  if PaGlobal_EncyclopediaNotice == nil or content == nil or key == nil then
    return
  end
  local index = Int64toInt32(key)
  local notice = ToClient_GetEncyclopediaNotice(index)
  if notice == nil then
    return
  end
  local encyclopedia = ToClient_GetFishEncyclopediaByKey(notice:getKey())
  if encyclopedia == nil then
    return
  end
  local stc_subContent = UI.getChildControl(content, "SubContent_Item")
  local stc_slotBG = UI.getChildControl(stc_subContent, "Static_ItemSlotBG")
  local stc_itemSlot = UI.getChildControl(stc_slotBG, "Static_ItemIcon")
  local txt_itemName = UI.getChildControl(stc_slotBG, "StaticText_ItemName")
  local txt_desc = UI.getChildControl(stc_slotBG, "StaticText_Desc")
  slot = {}
  SlotItem.reInclude(slot, "noticeSlot_", 0, stc_itemSlot, self._slotConfig)
  slot:clearItem()
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(encyclopedia:getItemKey()))
  slot:setItemByStaticStatus(itemSSW, 1)
  slot.icon:addInputEvent("Mouse_On", "HandleEventLUp_EncyclopediaNotice_Tooltip(" .. tostring(index) .. "," .. tostring(false) .. ")")
  slot.icon:addInputEvent("Mouse_Out", "HandleEventLUp_EncyclopediaNotice_Tooltip(" .. tostring(index) .. "," .. tostring(true) .. ")")
  local colorCode = PaGlobal_FishEncyclopedia_Renewal_All._gradeColor[encyclopedia:getGradeType()]
  txt_itemName:SetText(encyclopedia:getName())
  txt_itemName:SetFontColor(colorCode)
  local colorCodeHex = string.format("0x%x", colorCode)
  local nameText = "<PAColor" .. colorCodeHex .. ">" .. encyclopedia:getName() .. "<PAOldColor>"
  txt_desc:SetText(PAGetStringParam2(Defines.StringSheet_RESOURCE, "PANEL_FISHSIZE_UPDATE_DESC", "name", nameText, "size", string.format("%.3f", notice:getValue())))
  UI.setLimitTextAndAddTooltip(txt_desc, txt_desc:GetText(), "")
end
