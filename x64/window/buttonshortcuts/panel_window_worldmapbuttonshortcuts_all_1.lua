function PaGlobal_WorldmapButtonShortcuts_All:initialize()
  if PaGlobal_WorldmapButtonShortcuts_All._initialize == true then
    return
  end
  PaGlobal_WorldmapButtonShortcuts_All:controlAll_Init()
  PaGlobal_WorldmapButtonShortcuts_All:initializeDefaultShortcuts()
  PaGlobal_WorldmapButtonShortcuts_All:registEventHandler()
  PaGlobal_WorldmapButtonShortcuts_All:validate()
  PaGlobal_WorldmapButtonShortcuts_All._initialize = true
end
function PaGlobal_WorldmapButtonShortcuts_All:controlAll_Init()
  if Panel_Window_WorldmapButtonShortcuts_All == nil then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_WorldmapButtonShortcuts_All, "Static_Title_BG")
  self._ui.stc_curSetBg = UI.getChildControl(Panel_Window_WorldmapButtonShortcuts_All, "Static_Current_KeySetting")
  self._ui.txt_curSetTitle = UI.getChildControl(self._ui.stc_curSetBg, "StaticText_Current_Key_Title")
  self._ui.txt_curSetName = UI.getChildControl(self._ui.stc_curSetBg, "StaticText_Current_Key_Name")
  self._ui.radio_curSetKey = UI.getChildControl(self._ui.stc_curSetBg, "Radiobutton_Current_Key")
  self._ui.stc_allListBg = UI.getChildControl(Panel_Window_WorldmapButtonShortcuts_All, "Static_KeySetting_AllList")
  self._ui.edit_search = UI.getChildControl(self._ui.stc_allListBg, "Edit_SearchButtonShortcut")
  self._ui.btn_search = UI.getChildControl(self._ui.edit_search, "Button_SearchIcon")
  self._ui.chk_all = UI.getChildControl(self._ui.stc_allListBg, "CheckButton_AllView")
  self._ui.chk_all:SetTextMode(__eTextMode_Limit_AutoWrap)
  self._ui.chk_all:SetText(self._ui.chk_all:GetText())
  self._ui.list2_keySet = UI.getChildControl(self._ui.stc_allListBg, "List2_KeySetting_BG")
  self._ui.stc_bottomDescBg = UI.getChildControl(Panel_Window_WorldmapButtonShortcuts_All, "Static_BottomDescBG")
  self._ui.txt_bottomDesc = UI.getChildControl(self._ui.stc_bottomDescBg, "StaticText_BottomDesc")
  self._ui.txt_bottomDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_bottomDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_BUTTONSHORTCUT_BOTTOM_DESC"))
  self._ui.btn_close = UI.getChildControl(Panel_Window_WorldmapButtonShortcuts_All, "Button_Close")
  self._ui.btn_reset = UI.getChildControl(Panel_Window_WorldmapButtonShortcuts_All, "Button_Reset")
  self._ui.btn_allView = UI.getChildControl(Panel_Window_WorldmapButtonShortcuts_All, "Button_ButtonShortcuts_AllView")
  self._ui.btn_confirm = UI.getChildControl(Panel_Window_WorldmapButtonShortcuts_All, "Button_Confirm")
  self._bottomBgOriginSizeY = self._ui.stc_bottomDescBg:GetSizeY()
  self._UIMODE.Current.size = Panel_Window_WorldmapButtonShortcuts_All:GetSizeY() - self._ui.stc_allListBg:GetSizeY() - 10
  self._UIMODE.List.size = Panel_Window_WorldmapButtonShortcuts_All:GetSizeY() - self._ui.stc_allListBg:GetSizeY() - 10 + self._ui.stc_allListBg:GetSizeY() + 10
  self._UIMODE.ListOnly.size = Panel_Window_WorldmapButtonShortcuts_All:GetSizeY() - self._ui.stc_curSetBg:GetSizeY() - 10
  self._UIMODE.ListOnly.offset = self._ui.stc_curSetBg:GetSizeY() + 10
  self._listOriginPos = self._ui.stc_allListBg:GetPosY()
  self._buttonPos[self._UIMODE.Current.index] = self._ui.btn_reset:GetPosY() - self._ui.stc_allListBg:GetSizeY() - 10
  self._buttonPos[self._UIMODE.List.index] = self._ui.btn_reset:GetPosY()
  self._buttonPos[self._UIMODE.ListOnly.index] = self._ui.btn_reset:GetPosY() - (self._ui.stc_curSetBg:GetSizeY() + 10)
end
function PaGlobal_WorldmapButtonShortcuts_All:prepareOpen(index)
  if Panel_Window_WorldmapButtonShortcuts_All == nil then
    return
  end
  if ToClient_WorldMapIsShow() == false then
    return
  end
  WorldMapPopupManager:increaseLayer(true)
  WorldMapPopupManager:push(Panel_Window_WorldmapButtonShortcuts_All, true)
  audioPostEvent_SystemUi(1, 0)
  _AudioPostEvent_SystemUiForXBOX(1, 0)
  self._ui.chk_all:SetCheck(true)
  self._ui.edit_search:SetEditText(self._defaultEditTxt)
  local isCurrentMode = nil ~= index
  if isCurrentMode == true then
    self._curId = index
    self._openButtonsShortcuts = ToClient_GetWorldmapButtonShortcut(index)
    self._ui.txt_curSetName:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_curSetName:SetText(self._openButtonsShortcuts:getButtonString())
    self._ui.radio_curSetKey:SetText(self:getKeyCodeText(self._openButtonsShortcuts:getKeyCode()))
    self._currentSetId = index
    self._ui.chk_all:SetCheck(false)
    self._ePanelType = self._eOpenType.currentSet
  else
    self._ePanelType = self._eOpenType.allSet
  end
  PaGlobal_WorldmapButtonShortcuts_All:resize()
  PaGlobal_WorldmapButtonShortcuts_All:open()
  PaGlobal_WorldmapButtonShortcuts_All:uiRefresh(index)
end
function PaGlobal_WorldmapButtonShortcuts_All:initializeDefaultShortcuts()
  if Panel_Window_WorldmapButtonShortcuts_All == nil then
    return
  end
  local modifierKey = 0
  modifierKey = self:setModifierKey(modifierKey, __eWorldmapShortcutModifierKeyType_Ctrl)
  ToClient_SetDefaultWorldmapButtonShortcut("HandleEventLUp_CheckBtn_CameraSaveSlot()", Defines.StringSheet_GAME, "LUA_WORLDMAP_CAMERASAVE_TITLE", modifierKey, CppEnums.VirtualKeyCode.KeyCode_1)
  ToClient_SetDefaultWorldmapButtonShortcut("BtnEvent_NodeNaviCalculation()", Defines.StringSheet_RESOURCE, "PANEL_WINDOW_NODECAL_TITLE", modifierKey, CppEnums.VirtualKeyCode.KeyCode_2)
  ToClient_SetDefaultWorldmapButtonShortcut("BtnEvent_WaypointOption()", Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_WAYPOINTOPTION_TITLE", modifierKey, CppEnums.VirtualKeyCode.KeyCode_3)
  ToClient_SetDefaultWorldmapButtonShortcut("BtnEvent_WaypointPreset()", Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_MENUBUTTONTOOLTIP_WAYPOINTPRESET", modifierKey, CppEnums.VirtualKeyCode.KeyCode_4)
  ToClient_SetDefaultWorldmapButtonShortcut("BtnEvent_Quest()", Defines.StringSheet_GAME, "DIALOG_BUTTON_QUEST", modifierKey, CppEnums.VirtualKeyCode.KeyCode_5)
  ToClient_SetDefaultWorldmapButtonShortcut("BtnEvent_BarterFind()", Defines.StringSheet_RESOURCE, "PANEL_SEA_BARTER_SERACH", modifierKey, CppEnums.VirtualKeyCode.KeyCode_6)
  ToClient_SetDefaultWorldmapButtonShortcut("BtnEvent_NpcNavi()", Defines.StringSheet_GAME, "NPCNAVIGATION_NOTDRAGABLE", modifierKey, CppEnums.VirtualKeyCode.KeyCode_7)
  ToClient_SetDefaultWorldmapButtonShortcut("BtnEvent_StableMarket()", Defines.StringSheet_RESOURCE, "STABLE_FUNCTION_BTN_MARKET", modifierKey, CppEnums.VirtualKeyCode.KeyCode_8)
  ToClient_SetDefaultWorldmapButtonShortcut("BtnEvent_TotalStable()", Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_MENUBUTTONTOOLTIP_STABLE", modifierKey, CppEnums.VirtualKeyCode.KeyCode_9)
  ToClient_SetDefaultWorldmapButtonShortcut("BtnEvent_Transport()", Defines.StringSheet_GAME, "DIALOG_BUTTON_DELIVERY", modifierKey, CppEnums.VirtualKeyCode.KeyCode_0)
  ToClient_SetDefaultWorldmapButtonShortcut("BtnEvent_MarketPlace()", Defines.StringSheet_RESOURCE, "PANEL_MARKETPLACE_TITLE", modifierKey, CppEnums.VirtualKeyCode.KeyCode_OEM_EQUAL)
  ToClient_SetDefaultWorldmapButtonShortcut("BtnEvent_WorkerList()", Defines.StringSheet_GAME, "LUA_MENU_WORKERTITLE", modifierKey, CppEnums.VirtualKeyCode.KeyCode_OEM_MINUS)
end
function PaGlobal_WorldmapButtonShortcuts_All:open(index)
  if Panel_Window_WorldmapButtonShortcuts_All == nil then
    return
  end
  Panel_Window_WorldmapButtonShortcuts_All:SetShow(true)
end
function PaGlobal_WorldmapButtonShortcuts_All:prepareClose()
  if Panel_Window_WorldmapButtonShortcuts_All == nil then
    return
  end
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  self._openButtonsShortcuts = nil
  self._curId = -1
  self._currentSetId = -1
  self._searchText = ""
  setKeyCustomizing(false)
  PaGlobal_WorldmapButtonShortcuts_All:uiRefresh()
  PaGlobal_WorldmapButtonShortcuts_All:close()
end
function PaGlobal_WorldmapButtonShortcuts_All:close()
  if Panel_Window_WorldmapButtonShortcuts_All == nil then
    return
  end
  WorldMapPopupManager:pop()
end
function PaGlobal_WorldmapButtonShortcuts_All:registEventHandler()
  if Panel_Window_WorldmapButtonShortcuts_All == nil then
    return
  end
  registerEvent("FromClient_OpenWorldmapButtonShortcuts", "FromClient_WorldmapButtonShortcuts_All_OpenButtonShortcuts")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldmapButtonShorcuts_All_Close()")
  self._ui.btn_confirm:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldmapButtonShorcuts_All_Close()")
  self._ui.btn_reset:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldmapButtonShortcuts_All_SetDefault()")
  self._ui.btn_allView:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldmapButtonShortcuts_All_ChangeAllViewMode()")
  self._ui.chk_all:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldmapButtonShortcuts_All_ToggleAllView()")
  self._ui.btn_allView:addInputEvent("Mouse_On", "HandleEventOnOut_WorldmapButtonShortcuts_All_SimpleTooltips(true, 0)")
  self._ui.btn_allView:addInputEvent("Mouse_Out", "HandleEventOnOut_WorldmapButtonShortcuts_All_SimpleTooltips(false)")
  self._ui.btn_reset:addInputEvent("Mouse_On", "HandleEventOnOut_WorldmapButtonShortcuts_All_SimpleTooltips(true, 1)")
  self._ui.btn_reset:addInputEvent("Mouse_Out", "HandleEventOnOut_WorldmapButtonShortcuts_All_SimpleTooltips(false)")
  self._ui.chk_all:addInputEvent("Mouse_On", "HandleEventOnOut_WorldmapButtonShortcuts_All_SimpleTooltips(true, 2)")
  self._ui.chk_all:addInputEvent("Mouse_Out", "HandleEventOnOut_WorldmapButtonShortcuts_All_SimpleTooltips(false)")
  self._ui.radio_curSetKey:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldmapButtonShortcuts_All_ClickedChangeShortcuts()")
  self._ui.btn_search:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldmapButtonShortcuts_All_ApplySearch()")
  self._ui.edit_search:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldmapButtonShortcuts_All_EditSearch()")
  self._ui.list2_keySet:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_WorldmapButtonShorcuts_All_ListControlCreate")
  self._ui.list2_keySet:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_WorldmapButtonShortcuts_All:validate()
  if Panel_Window_WorldmapButtonShortcuts_All == nil then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui.stc_curSetBg:isValidate()
  self._ui.txt_curSetTitle:isValidate()
  self._ui.txt_curSetName:isValidate()
  self._ui.radio_curSetKey:isValidate()
  self._ui.stc_allListBg:isValidate()
  self._ui.edit_search:isValidate()
  self._ui.btn_search:isValidate()
  self._ui.chk_all:isValidate()
  self._ui.list2_keySet:isValidate()
  self._ui.stc_bottomDescBg:isValidate()
  self._ui.txt_bottomDesc:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.btn_reset:isValidate()
  self._ui.btn_allView:isValidate()
  self._ui.btn_confirm:isValidate()
end
function PaGlobal_WorldmapButtonShortcuts_All:resize()
  local descSizeY = self._ui.txt_bottomDesc:GetTextSizeY() + 10
  if self._ui.stc_bottomDescBg:GetSizeY() < descSizeY + 10 then
    local addSizeY = descSizeY - self._bottomBgOriginSizeY
    self._ui.stc_bottomDescBg:SetSize(self._ui.stc_bottomDescBg:GetSizeX(), self._bottomBgOriginSizeY + addSizeY)
    local panel = Panel_Window_WorldmapButtonShortcuts_All
    panel:SetSize(panel:GetSizeX(), panel:GetSizeY() + addSizeY)
    self._ui.stc_bottomDescBg:ComputePos()
    self._ui.txt_bottomDesc:ComputePos()
    self._ui.btn_confirm:ComputePos()
    self._ui.btn_reset:ComputePos()
    self._ui.btn_allView:ComputePos()
  end
end
function PaGlobal_WorldmapButtonShortcuts_All:register(virtualKeyCode)
  if self:isExhibitKey(virtualKeyCode) == true then
    PaGlobal_WorldmapButtonShortcuts_All:uiRefresh(self._curId)
    self._curButtonsShortcuts = nil
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BUTTONSHORTCUTS_DISAVAILABLE_REGISTER"))
    return
  end
  if self._curButtonsShortcuts == nil then
    PaGlobal_WorldmapButtonShortcuts_All:uiRefresh()
    return
  end
  local modifierKey = self._curButtonsShortcuts:getModifierKey()
  if modifierKey == 0 then
    return
  end
  if ToClient_HasKeyWorldmapButtonShortcut(modifierKey, VirtualKeyCode) == true then
    self._registerKey = VirtualKeyCode
    local messageBoxMemo = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BUTTONSHORTCUTS_ALEADY_KEYCODE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = PaGlobalFunc_WorldmapButtonShorcuts_All_RegisterOk,
      functionNo = PaGlobal_WorldmapButtonShortcuts_All_CurrentRefresh,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  ToClient_SetWorldmapButtonShortcutKey(self._curButtonsShortcuts, VirtualKeyCode)
  PaGlobal_WorldmapButtonShortcuts_All:uiRefresh(self._curId)
  self._curButtonsShortcuts = nil
  FGlobal_NewShortCut_Close()
end
function PaGlobal_WorldmapButtonShortcuts_All:remove()
  ToClient_RemoveAtWorldmapButtonShortcutEvent(self._curButtonsShortcuts)
  PaGlobal_WorldmapButtonShortcuts_All:uiRefresh(self._curId)
end
function PaGlobal_WorldmapButtonShortcuts_All:changeUI(mode)
  TooltipSimple_Hide()
  if nil == mode then
    return
  end
  self._curMode = mode
  self._ui.stc_allListBg:SetPosY(self._listOriginPos)
  self._ui.btn_reset:SetPosY(self._buttonPos[mode])
  self._ui.btn_confirm:SetPosY(self._buttonPos[mode])
  self._ui.btn_allView:SetPosY(self._buttonPos[mode])
  if mode == self._UIMODE.Current.index then
    self._ui.stc_allListBg:SetShow(false)
    self._ui.stc_curSetBg:SetShow(true)
    self._ui.stc_bottomDescBg:SetPosY(135)
    self._ui.btn_allView:SetShow(true)
    Panel_Window_WorldmapButtonShortcuts_All:SetSize(Panel_Window_WorldmapButtonShortcuts_All:GetSizeX(), self._UIMODE.Current.size)
  elseif mode == self._UIMODE.List.index then
    self._ui.stc_allListBg:SetShow(true)
    self._ui.stc_curSetBg:SetShow(true)
    self._ui.stc_bottomDescBg:SetPosY(486)
    self._ui.btn_allView:SetShow(false)
    Panel_Window_WorldmapButtonShortcuts_All:SetSize(Panel_Window_WorldmapButtonShortcuts_All:GetSizeX(), self._UIMODE.List.size)
    PaGlobal_WorldmapButtonShortcuts_All:uiRefresh()
  elseif mode == self._UIMODE.ListOnly.index then
    self._ui.stc_allListBg:SetShow(true)
    self._ui.stc_curSetBg:SetShow(false)
    self._ui.btn_allView:SetShow(false)
    self._ui.stc_bottomDescBg:SetPosY(396)
    self._ui.stc_allListBg:SetPosY(self._ui.stc_allListBg:GetPosY() - self._UIMODE.ListOnly.offset)
    Panel_Window_WorldmapButtonShortcuts_All:SetSize(Panel_Window_WorldmapButtonShortcuts_All:GetSizeX(), self._UIMODE.ListOnly.size)
  end
end
function PaGlobal_WorldmapButtonShortcuts_All:uiRefresh(index)
  if self._openButtonsShortcuts ~= nil then
    self._ui.txt_curSetName:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_curSetName:SetText(self._openButtonsShortcuts:getButtonString())
    self._ui.radio_curSetKey:SetText(PaGlobal_WorldmapButtonShortcuts_All:getKeyCodeText(self._openButtonsShortcuts:getKeyCode()))
  end
  self._ui.radio_curSetKey:SetCheck(false)
  self._curId = -1
  if index ~= nil then
    self._ui.list2_keySet:requestUpdateByKey(toInt64(0, index))
  else
    PaGlobal_WorldmapButtonShortcuts_All:listRefresh()
  end
  ClearFocusEdit()
end
function PaGlobal_WorldmapButtonShortcuts_All:listRefresh()
  self._ui.list2_keySet:getElementManager():clearKey()
  local count = ToClient_GetWorldmapButtonShortcutsCount()
  for idx = 0, count - 1 do
    local isShow = true
    local data = ToClient_GetWorldmapButtonShortcut(idx)
    if self._searchText ~= "" and string.find(data:getButtonString(), self._searchText) == nil then
      isShow = false
    end
    if self._ui.chk_all:IsCheck() == false and data:getKeyCode() == 0 then
      isShow = false
    end
    if isShow == true then
      self._ui.list2_keySet:getElementManager():pushKey(toInt64(0, idx))
    end
  end
end
function PaGlobal_WorldmapButtonShortcuts_All:listControlCreate(content, key)
  local key32 = Int64toInt32(key)
  local buttonShortcut = ToClient_GetWorldmapButtonShortcut(key32)
  local buttonName = UI.getChildControl(content, "StaticText_ListKeySetting_Name")
  local shortcuts = UI.getChildControl(content, "Radiobutton_ListKeySetting")
  local isShow = true
  buttonName:SetShow(true)
  shortcuts:SetShow(true)
  buttonName:setNotImpactScrollEvent(true)
  shortcuts:setNotImpactScrollEvent(true)
  buttonName:SetTextMode(__eTextMode_AutoWrap)
  buttonName:SetText(buttonShortcut:getButtonString())
  shortcuts:SetTextMode(__eTextMode_AutoWrap)
  shortcuts:SetText(self:getKeyCodeText(buttonShortcut))
  if self._curId ~= nil and self._curId == key32 then
    shortcuts:SetText("")
  end
  shortcuts:SetCheck(self._curId == key32)
  shortcuts:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldmapButtonShortcuts_All_ChangeShortcuts(" .. key32 .. ")")
  shortcuts:addInputEvent("Mouse_RUp", "HandleEventLUp_WorldmapButtonShortcuts_All_DeleteShortcuts(" .. key32 .. ")")
end
function PaGlobal_WorldmapButtonShortcuts_All:isSetModifierKey(modifierKey, modifierKeyType)
  if modifierKey == nil or modifierKeyType == nil then
    return
  end
  return math.floor(modifierKey / 2 ^ modifierKeyType) % 2 == 1
end
function PaGlobal_WorldmapButtonShortcuts_All:checkAndAddModifierString(modifierKey, modifierKeyType, modifierString, keyCode)
  if modifierKey == nil or modifierKeyType == nil or modifierString == nil or keyCode == nil then
    return
  end
  if self:isSetModifierKey(modifierKey, modifierKeyType) == true then
    modifierString = modifierString .. self._keyString[keyCode] .. " + "
  end
  return modifierString
end
function PaGlobal_WorldmapButtonShortcuts_All:setModifierKey(modifierKey, modifierKeyType)
  if modifierKey == nil or modifierKeyType == nil then
    return
  end
  if self:isSetModifierKey(modifierKey, modifierKeyType) == true then
    return
  end
  return modifierKey + 2 ^ modifierKeyType
end
function PaGlobal_WorldmapButtonShortcuts_All:getKeyCodeText(buttonShortcut)
  if buttonShortcut == nil then
    return self._nothingTxt
  end
  local modifierKey = buttonShortcut:getModifierKey()
  local keycode = buttonShortcut:getKeyCode()
  if modifierKey ~= 0 and keycode ~= 0 then
    if self._keyString[keycode] == nil then
      return self._nothingTxt
    end
    local modifierString = ""
    modifierString = self:checkAndAddModifierString(modifierKey, __eWorldmapShortcutModifierKeyType_Alt, modifierString, CppEnums.VirtualKeyCode.KeyCode_MENU)
    modifierString = self:checkAndAddModifierString(modifierKey, __eWorldmapShortcutModifierKeyType_Ctrl, modifierString, CppEnums.VirtualKeyCode.KeyCode_CONTROL)
    modifierString = self:checkAndAddModifierString(modifierKey, __eWorldmapShortcutModifierKeyType_Shift, modifierString, CppEnums.VirtualKeyCode.KeyCode_SHIFT)
    local keystring = "<PAColor0xffd8ad70>" .. modifierString .. self._keyString[keycode] .. "<PAOldColor>"
    return keystring
  end
  return self._nothingTxt
end
function PaGlobal_WorldmapButtonShortcuts_All:isExhibitKey(keyCode)
  local exhibitKeys = {
    CppEnums.VirtualKeyCode.KeyCode_SHIFT,
    CppEnums.VirtualKeyCode.KeyCode_TAB,
    CppEnums.VirtualKeyCode.KeyCode_BACK,
    CppEnums.VirtualKeyCode.KeyCode_CAPITAL,
    CppEnums.VirtualKeyCode.KeyCode_CONTROL,
    CppEnums.VirtualKeyCode.KeyCode_SPACE,
    CppEnums.VirtualKeyCode.KeyCode_OEM_7,
    CppEnums.VirtualKeyCode.KeyCode_OEM_2,
    CppEnums.VirtualKeyCode.KeyCode_OEM_3
  }
  for idx = 0, #exhibitKeys do
    if keyCode == exhibitKeys[idx] then
      return true
    end
  end
  if self._nothingTxt == PaGlobal_WorldmapButtonShortcuts_All:getKeyCodeText(keyCode) then
    return true
  end
  return false
end
function PaGlobal_WorldmapButtonShortcuts_All:setDefault()
  TooltipSimple_Hide()
  local messageBoxMemo = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BUTTONSHORTCUTS_ALLRESETMESSAGE")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = PaGlobalFunc_WorldmapButtonShorcuts_All_SetDefault,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_WorldmapButtonShortcuts_All:clickedChangeShortcuts()
  self._curButtonsShortcuts = self._openButtonsShortcuts
  ClearFocusEdit()
end
