function PaGlobal_EnchantMaterial_All:initialize()
  if Panel_Window_Enchant_Material_All == nil or PaGlobal_EnchantMaterial_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlInit()
  self:setConsoleUI()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_EnchantMaterial_All:controlInit()
  if nil == Panel_Window_Enchant_Material_All then
    return
  end
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_Enchant_Material_All, "Static_MainBG_Material")
  self._ui.list_itemList = UI.getChildControl(self._ui.stc_mainBg, "List2_ItemList")
  self._ui.list_content = UI.getChildControl(self._ui.list_itemList, "List2_1_Content")
  self._ui.rdo_radioButton1 = UI.getChildControl(self._ui.list_content, "RadioButton_1")
  self._ui.stc_equipSlotBG = UI.getChildControl(self._ui.rdo_radioButton1, "Static_EquipListSlotBg")
  self._ui.stc_equipSlot = UI.getChildControl(self._ui.stc_equipSlotBG, "Static_EquipListSlot")
  local slot = {}
  SlotItem.new(slot, "EnchantMaterialSlot", 0, self._ui.stc_equipSlot, self._slotConfig)
  slot:createChild()
  slot.empty = true
  slot:clearItem()
  slot.border:SetSize(44, 44)
  slot.border:SetPosX(0)
  slot.border:SetPosY(0)
  self._ui.stc_titleBar = UI.getChildControl(Panel_Window_Enchant_Material_All, "Static_TitleBar")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBar, "Static_CloseIcon")
  self._ui.btn_close:SetShow(self._isConsole == false)
  self._ui.btn_apply = UI.getChildControl(Panel_Window_Enchant_Material_All, "Button_Apply")
  self._ui.stc_keyGuide = UI.getChildControl(Panel_Window_Enchant_Material_All, "Static_ConsoleKeyGuide")
  self._ui.txt_guideIconB = UI.getChildControl(self._ui.stc_keyGuide, "StaticText_CancelButton_C")
end
function PaGlobal_EnchantMaterial_All:setConsoleUI()
  if nil == Panel_Window_Enchant_Material_All then
    return
  end
  self._ui.stc_keyGuide:SetShow(self._isConsole == true)
  local guideIconGroup = {
    self._ui.txt_guideIconB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(guideIconGroup, self._ui.stc_keyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._ui.stc_keyGuide:ComputePos()
end
function PaGlobal_EnchantMaterial_All:prepareOpen()
  if nil == Panel_Window_Enchant_Material_All then
    return
  end
  self._currentIndex = ToClient_GetCurrentEnchantMaterialIndex()
  PaGlobalFunc_EnchantProtector_All_Close()
  PaGlobal_EnchantMaterial_All:update()
  PaGlobal_EnchantMaterial_All:open()
end
function PaGlobal_EnchantMaterial_All:open()
  if nil == Panel_Window_Enchant_Material_All then
    return
  end
  Panel_Window_Enchant_Material_All:SetShow(true)
end
function PaGlobal_EnchantMaterial_All:prepareClose()
  if nil == Panel_Window_Enchant_Material_All then
    return
  end
  PaGlobal_EnchantMaterial_All:close()
end
function PaGlobal_EnchantMaterial_All:close()
  if nil == Panel_Window_Enchant_Material_All then
    return
  end
  Panel_Window_Enchant_Material_All:SetShow(false)
end
function PaGlobal_EnchantMaterial_All:registEventHandler()
  if nil == Panel_Window_Enchant_Material_All then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_EnchantMaterial_All_Close()")
  self._ui.btn_apply:addInputEvent("Mouse_LUp", "PaGlobalFunc_EnchantMaterial_All_Apply()")
  self._ui.list_itemList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_EnchantMaterial_All_CreateListControl")
  self._ui.list_itemList:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_UpdateEnchantMaterial", "FromClient_UpdateEnchantMaterial")
end
function PaGlobal_EnchantMaterial_All:validate()
  if nil == Panel_Window_Enchant_Material_All then
    return
  end
end
function PaGlobal_EnchantMaterial_All:createListControl(content, key)
  local index = Int64toInt32(key)
  local radioButton = UI.getChildControl(content, "RadioButton_1")
  local slotBG = UI.getChildControl(radioButton, "Static_EquipListSlotBg")
  local itemIcon = UI.getChildControl(slotBG, "Static_EquipListSlot")
  local txt_materialName = UI.getChildControl(radioButton, "StaticText_EquipName")
  local txt_mateiralCount = UI.getChildControl(radioButton, "StaticText_EquipSlotText")
  local itemWrapper = ToClient_GetEnchantMaterialByIndex(index)
  if itemWrapper == nil then
    radioButton:SetShow(false)
    return
  end
  radioButton:SetCheck(self._currentIndex == index)
  local slot = {}
  SlotItem.reInclude(slot, "EnchantMaterialSlot", 0, itemIcon, self._slotConfig)
  slot:clearItem()
  slot:setItemByStaticStatus(itemWrapper:getStaticStatus())
  Panel_Tooltip_Item_SetPosition(index, slot, "EnchantMaterial")
  radioButton:addInputEvent("Mouse_LUp", "HandleEventOn_EnchantMaterial_SelectIndex(" .. index .. ")")
  slot.icon:addInputEvent("Mouse_LUp", "HandleEventOn_EnchantMaterial_SelectIndex(" .. index .. ")")
  slot.icon:addInputEvent("Mouse_On", "HandleEventOn_EnchantMaterial_Slot(" .. index .. ", true)")
  slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantMaterial_Slot(" .. index .. ", false)")
  radioButton:SetShow(true)
  local materialName = itemWrapper:getStaticStatus():getName()
  txt_materialName:setLineCountByLimitAutoWrap(2)
  txt_materialName:SetText(materialName)
  if txt_materialName:IsLimitText() == true then
    txt_materialName:addInputEvent("Mouse_LUp", "HandleEventOn_EnchantMaterial_SelectIndex(" .. index .. ")")
  end
  txt_mateiralCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENCHANT_RENEWEL_HAVECOUNT", "count", tostring(itemWrapper:getCount())))
end
function PaGlobal_EnchantMaterial_All:update()
  if Panel_Window_Enchant_Material_All == nil then
    return
  end
  local listSize = ToClient_GetEnchantMaterialListSize()
  self._ui.list_itemList:getElementManager():clearKey()
  for index = 0, listSize - 1 do
    self._ui.list_itemList:getElementManager():pushKey(toInt64(0, index))
  end
end
function PaGlobal_EnchantMaterial_All:apply()
  if nil == Panel_Window_Enchant_Material_All then
    return
  end
  local itemWrapper = ToClient_GetEnchantMaterialByIndex(self._currentIndex)
  if itemWrapper == nil then
    return
  end
  local itemStatic = itemWrapper:getStaticStatus():get()
  if itemStatic == nil then
    return
  end
  audioPostEvent_SystemItem(itemStatic._itemMaterial)
  ToClient_SetCurrentEnchantMaterial(self._currentIndex)
  PaGlobal_EnchantMaterial_All:prepareClose()
end
function PaGlobal_EnchantMaterial_All:selectIndex(index)
  if nil == Panel_Window_Enchant_Material_All then
    return
  end
  self._currentIndex = index
end
