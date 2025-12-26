function PaGlobal_EnchantProtector_All:initialize()
  if Panel_Window_EnchantProtector_All == nil or PaGlobal_EnchantProtector_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlInit()
  self:setConsoleUI()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_EnchantProtector_All:controlInit()
  if nil == Panel_Window_EnchantProtector_All then
    return
  end
  self._ui.stc_titlebar = UI.getChildControl(Panel_Window_EnchantProtector_All, "Static_TitleBar")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titlebar, "Static_CloseIcon")
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_EnchantProtector_All, "Static_MainBG_Stack_Normal")
  self._ui.list2_protectorList = UI.getChildControl(self._ui.stc_mainBg, "List2_ProtectorList")
  self._ui.btn_apply = UI.getChildControl(Panel_Window_EnchantProtector_All, "Button_Apply")
  self._ui.stc_keyGuide = UI.getChildControl(Panel_Window_EnchantStack_All, "Static_ConsoleKeyGuide")
  self._ui.txt_guideIconB = UI.getChildControl(self._ui.stc_keyGuide, "StaticText_CancelButton_C")
  local listContent = UI.getChildControl(self._ui.list2_protectorList, "List2_1_Content")
  local btn_protector = UI.getChildControl(listContent, "RadioButton_Protector")
  local itemSlot = UI.getChildControl(btn_protector, "Static_SlotBg")
  local slot = {}
  SlotItem.new(slot, "protectorSlot_", 0, itemSlot, self._slotConfig)
  slot:createChild()
  slot.empty = true
  slot:clearItem()
  slot.icon:SetPosX(2)
  slot.icon:SetPosY(2)
  slot.icon:SetSize(40, 40)
end
function PaGlobal_EnchantProtector_All:setConsoleUI()
  if nil == PaGlobal_EnchantProtector_All then
    return
  end
  self._ui.stc_keyGuide:SetShow(self._isConsole == true)
  self._ui.btn_close:SetShow(self._isConsole == false)
  local guideIconGroup = {
    self._ui.txt_guideIconB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(guideIconGroup, self._ui.stc_keyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._ui.stc_keyGuide:ComputePos()
end
function PaGlobal_EnchantProtector_All:prepareOpen()
  if nil == Panel_Window_EnchantProtector_All then
    return
  end
  PaGlobalFunc_EnchantMaterial_All_Close()
  self._currentIndex = ToClient_GetCurrentProtectorIndex()
  PaGlobal_EnchantProtector_All:open()
  PaGlobal_EnchantProtector_All:update()
end
function PaGlobal_EnchantProtector_All:open()
  if nil == Panel_Window_EnchantProtector_All then
    return
  end
  Panel_Window_EnchantProtector_All:SetShow(true)
end
function PaGlobal_EnchantProtector_All:prepareClose()
  if nil == Panel_Window_EnchantProtector_All then
    return
  end
  PaGlobal_EnchantProtector_All:close()
end
function PaGlobal_EnchantProtector_All:close()
  if nil == Panel_Window_EnchantProtector_All then
    return
  end
  Panel_Window_EnchantProtector_All:SetShow(false)
end
function PaGlobal_EnchantProtector_All:registEventHandler()
  if nil == Panel_Window_EnchantProtector_All then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_EnchantProtector_All_Close()")
  self._ui.btn_apply:addInputEvent("Mouse_LUp", "PaGlobalFunc_EnchantProtector_All_Apply()")
  self._ui.list2_protectorList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_EnchantProtector_CreateContent")
  self._ui.list2_protectorList:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_UpdateProtector", "FromClient_UpdateProtector")
end
function PaGlobal_EnchantProtector_All:validate()
  if nil == Panel_Window_EnchantProtector_All then
    return
  end
end
function PaGlobal_EnchantProtector_All:apply()
  if nil == Panel_Window_EnchantProtector_All then
    return
  end
  local protectorSS = ToClient_GetProtectorForLua(self._currentIndex)
  if protectorSS == nil then
    return
  end
  local itemStatic = protectorSS:get()
  if itemStatic == nil then
    return
  end
  audioPostEvent_SystemItem(itemStatic._itemMaterial)
  ToClient_SetCurrentProtector(self._currentIndex)
end
function PaGlobal_EnchantProtector_All:createContent(content, key)
  if PaGlobal_EnchantProtector_All == nil or content == nil or key == nil then
    return
  end
  local index = Int64toInt32(key)
  local protectorSS = ToClient_GetProtectorForLua(index)
  local protectorCount = ToClient_GetProtectorCount(index)
  local btn_protector = UI.getChildControl(content, "RadioButton_Protector")
  if self._currentIndex == index then
    btn_protector:SetCheck(true)
  else
    btn_protector:SetCheck(false)
  end
  local txt_itemName = UI.getChildControl(btn_protector, "StaticText_Name")
  local protectorName = protectorSS:getName()
  txt_itemName:SetText(protectorName)
  local txt_itemCount = UI.getChildControl(btn_protector, "StaticText_EquipSlotText")
  txt_itemCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENCHANT_RENEWEL_HAVECOUNT", "count", tostring(protectorCount)))
  local stc_slotBackground = UI.getChildControl(btn_protector, "Static_SlotBg")
  slot = {}
  SlotItem.reInclude(slot, "protectorSlot_", index, stc_slotBackground, self._slotConfig)
  slot:clearItem()
  slot:setItemByStaticStatus(protectorSS, protectorCount)
  Panel_Tooltip_Item_SetPosition(index, slot, "Protector")
  btn_protector:addInputEvent("Mouse_LUp", "HandleEventOn_EnchantProtector_SelectIndex(" .. index .. ")")
  txt_itemName:addInputEvent("Mouse_LUp", "HandleEventOn_EnchantProtector_SelectIndex(" .. index .. ")")
  slot.icon:addInputEvent("Mouse_LUp", "HandleEventOn_EnchantProtector_SelectIndex(" .. index .. ")")
  slot.icon:addInputEvent("Mouse_On", "HandleEventOn_EnchantProtector_Slot(" .. index .. ", true)")
  slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantProtector_Slot(" .. index .. ", false)")
end
function PaGlobal_EnchantProtector_All:update()
  if nil == Panel_Window_EnchantProtector_All then
    return
  end
  PaGlobal_EnchantProtector_All:updateList()
  PaGlobal_EnchantProtector_All:updateButton()
end
function PaGlobal_EnchantProtector_All:updateList()
  local listSize = ToClient_GetProtectorListSize()
  local listManager = self._ui.list2_protectorList:getElementManager()
  listManager:clearKey()
  for index = 0, listSize - 1 do
    listManager:pushKey(toInt64(0, index))
  end
end
function PaGlobal_EnchantProtector_All:updateButton()
  self._ui.btn_apply:SetIgnore(self._currentIndex == -1)
  self._ui.btn_apply:SetMonoTone(self._currentIndex == -1)
end
function PaGlobal_EnchantProtector_All:selectIndex(index)
  self._currentIndex = index
end
