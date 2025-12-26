function PaGlobal_SetupRepair_All:initialize()
  if true == PaGlobal_SetupRepair_All._initialize then
    return
  end
  if PaGlobal_RepairFunc_All == nil or Panel_Dialog_Repair_Function_All == nil then
    return
  end
  if 32 <= PaGlobal_RepairFunc_All._REPAIRTYPE.COUNT then
    return
  end
  self._ui.stc_mainArea = UI.getChildControl(Panel_Window_SetupRepair_All, "Static_MainArea")
  self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.EQUIPMENT] = UI.getChildControl(self._ui.stc_mainArea, "CheckButton_FunctionButton_Equip")
  self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.INVENTORY] = UI.getChildControl(self._ui.stc_mainArea, "CheckButton_FunctionButton_Inventory")
  self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.HORSE] = UI.getChildControl(self._ui.stc_mainArea, "CheckButton_FunctionButton_Horse")
  self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.SHIP] = UI.getChildControl(self._ui.stc_mainArea, "CheckButton_FunctionButton_Ship")
  self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.GUILD] = UI.getChildControl(self._ui.stc_mainArea, "CheckButton_FunctionButton_Guild")
  self._ui.stc_keyGuideBG = UI.getChildControl(Panel_Window_SetupRepair_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_keyGuideY = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_Y_ConsoleUI")
  self._ui.stc_keyGuideB = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_B_ConsoleUI")
  self._ui.stc_keyGuideA = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_A_ConsoleUI")
  self._ui.btn_save = UI.getChildControl(Panel_Window_SetupRepair_All, "Button_Save")
  self._ui.btn_close = UI.getChildControl(Panel_Window_SetupRepair_All, "Button_Close")
  PaGlobal_SetupRepair_All:registEventHandler()
  PaGlobal_SetupRepair_All:validate()
  self._originPanelSize = Panel_Window_SetupRepair_All:GetSizeY()
  self._mainAreaSize = self._ui.stc_mainArea:GetSizeY()
  self._saveButtonSize = self._ui.btn_save:GetSizeY() + 10
  PaGlobal_SetupRepair_All._initialize = true
end
function PaGlobal_SetupRepair_All:registEventHandler()
  if nil == Panel_Window_SetupRepair_All then
    return
  end
  self._ui.btn_save:addInputEvent("Mouse_LUp", "HandleEventLUp_SetupRepair_Save()")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGloabl_SetupRepair_All_Close()")
  if _ContentsGroup_UsePadSnapping == true then
    Panel_Dialog_Repair_Function_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_SetupRepair_Save()")
    Panel_Dialog_Repair_Function_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGloabl_SetupRepair_All_Close()")
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.EQUIPMENT]:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_SetupRepair_Save()")
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.INVENTORY]:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_SetupRepair_Save()")
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.HORSE]:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_SetupRepair_Save()")
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.SHIP]:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_SetupRepair_Save()")
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.GUILD]:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_SetupRepair_Save()")
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.EQUIPMENT]:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGloabl_SetupRepair_All_Close()")
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.INVENTORY]:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGloabl_SetupRepair_All_Close()")
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.HORSE]:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGloabl_SetupRepair_All_Close()")
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.SHIP]:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGloabl_SetupRepair_All_Close()")
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.GUILD]:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGloabl_SetupRepair_All_Close()")
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.EQUIPMENT]:addInputEvent("Mouse_Out", "HandleEventMOut_SetupRepair_CheckButton()")
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.INVENTORY]:addInputEvent("Mouse_Out", "HandleEventMOut_SetupRepair_CheckButton()")
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.HORSE]:addInputEvent("Mouse_Out", "HandleEventMOut_SetupRepair_CheckButton()")
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.SHIP]:addInputEvent("Mouse_Out", "HandleEventMOut_SetupRepair_CheckButton()")
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.GUILD]:addInputEvent("Mouse_Out", "HandleEventMOut_SetupRepair_CheckButton()")
  end
end
function PaGlobal_SetupRepair_All:setCheckButtons()
  if nil == Panel_Window_SetupRepair_All then
    return
  end
  for index = 1, PaGlobal_RepairFunc_All._REPAIRTYPE.COUNT - 1 do
    if nil ~= self._ui.chk_button[index] then
      self._ui.chk_button[index]:SetCheck(self._ui.chk_button[index]:IsCheck())
    end
  end
end
function PaGlobal_SetupRepair_All:prepareOpen()
  if nil == Panel_Window_SetupRepair_All then
    return
  end
  if _ContentsGroup_UsePadSnapping == true then
    self._ui.stc_keyGuideBG:SetShow(true)
    self._ui.btn_save:SetShow(false)
    self._ui.btn_close:SetShow(false)
    Panel_Window_SetupRepair_All:SetSize(Panel_Window_SetupRepair_All:GetSizeX(), self._originPanelSize - self._saveButtonSize)
    self._ui.stc_mainArea:SetSize(self._ui.stc_mainArea:GetSizeX(), self._mainAreaSize - self._saveButtonSize)
    local keyGuide = {
      self._ui.stc_keyGuideA,
      self._ui.stc_keyGuideY,
      self._ui.stc_keyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
    self._ui.stc_keyGuideBG:SetShow(false)
    self._ui.btn_save:SetShow(true)
    self._ui.btn_close:SetShow(true)
    Panel_Window_SetupRepair_All:SetSize(Panel_Window_SetupRepair_All:GetSizeX(), self._originPanelSize)
    self._ui.stc_mainArea:SetSize(self._ui.stc_mainArea:GetSizeX(), self._mainAreaSize)
  end
  PaGlobal_SetupRepair_All:update()
  PaGlobal_SetupRepair_All:open()
end
function PaGlobal_SetupRepair_All:open()
  if nil == Panel_Window_SetupRepair_All then
    return
  end
  Panel_Window_SetupRepair_All:SetShow(true)
end
function PaGlobal_SetupRepair_All:prepareClose()
  if nil == Panel_Window_SetupRepair_All then
    return
  end
  PaGlobal_SetupRepair_All:close()
end
function PaGlobal_SetupRepair_All:close()
  if nil == Panel_Window_SetupRepair_All then
    return
  end
  Panel_Window_SetupRepair_All:SetShow(false)
end
function PaGlobal_SetupRepair_All:update()
  if nil == Panel_Window_SetupRepair_All then
    return
  end
  if self._isCamping == true then
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.HORSE]:SetShow(_ContentsGroup_CampHorseEquipRepair)
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.SHIP]:SetShow(false)
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.GUILD]:SetShow(false)
  else
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.HORSE]:SetShow(true)
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.SHIP]:SetShow(true)
    self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.GUILD]:SetShow(true)
  end
  for index = 1, PaGlobal_RepairFunc_All._REPAIRTYPE.COUNT - 1 do
    if self._ui.chk_button[index] ~= nil then
      self._ui.chk_button[index]:SetCheck(false)
    end
  end
  local BitFlagCheckRepairType = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eRepairAllCheckTypeBitFlag)
  for index = 1, PaGlobal_RepairFunc_All._REPAIRTYPE.COUNT - 1 do
    if false == ToClient_isCheckRepairTypeBitFlag(BitFlagCheckRepairType, index - 1) and nil ~= self._ui.chk_button[index] then
      self._ui.chk_button[index]:SetCheck(true)
    end
  end
end
function PaGlobal_SetupRepair_All:saveRepairTypeLuaCache()
  if nil == Panel_Window_SetupRepair_All then
    return
  end
  local RepairTypeLuaCache = 0
  for index = 1, PaGlobal_RepairFunc_All._REPAIRTYPE.COUNT - 1 do
    if nil ~= self._ui.chk_button[index] then
      RepairTypeLuaCache = ToClient_SetRepairTypeBitFlag(RepairTypeLuaCache, index - 1, not self._ui.chk_button[index]:IsCheck())
    end
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eRepairAllCheckTypeBitFlag, RepairTypeLuaCache, CppEnums.VariableStorageType.eVariableStorageType_User)
  local BitFlagCheckRepairType = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eRepairAllCheckTypeBitFlag)
  for index = 1, PaGlobal_RepairFunc_All._REPAIRTYPE.COUNT - 1 do
    if false == ToClient_isCheckRepairTypeBitFlag(BitFlagCheckRepairType, index - 1) then
      self._ui.chk_button[index]:SetCheck(true)
    end
  end
  local saveCompleteStr = PAGetString(Defines.StringSheet_GAME, "LUA_BOSSALERT_SET_CONFIRM")
  Proc_ShowMessage_Ack(saveCompleteStr)
end
function PaGlobal_SetupRepair_All:validate()
  if nil == Panel_Window_SetupRepair_All then
    return
  end
  self._ui.stc_mainArea:isValidate()
  self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.EQUIPMENT]:isValidate()
  self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.INVENTORY]:isValidate()
  self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.HORSE]:isValidate()
  self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.SHIP]:isValidate()
  self._ui.chk_button[PaGlobal_RepairFunc_All._REPAIRTYPE.GUILD]:isValidate()
  self._ui.btn_save:isValidate()
  self._ui.btn_close:isValidate()
end
