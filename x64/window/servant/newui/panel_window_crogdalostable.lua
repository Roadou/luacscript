PaGlobal_Window_CrogdaloStable = {
  _ui = {
    _horseBg = {},
    _btn_Common = nil,
    _stc_Selected = nil,
    _stc_UnSealed = nil,
    _stc_doom_pad = nil,
    _txt_doomName_pad = nil,
    _txt_doomState_pad = nil,
    _stc_dine_pad = nil,
    _txt_dineName_pad = nil,
    _txt_dineState_pad = nil,
    _stc_adu_pad = nil,
    _txt_aduName_pad = nil,
    _txt_aduState_pad = nil,
    _stc_keyguide = nil,
    _stc_keyguide_A = nil,
    _stc_keyguide_B = nil
  },
  _initialize = false,
  _maxSize = 3,
  _reservedNo = nil,
  _currentSelectIdx = -1,
  _UNSELAEDTYPE_COUNT = 0,
  _UNSELAEDTYPE_CROGDALO = 1,
  _UNSELAEDTYPE_OTHER = 2
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Window_CrogdaloStable")
function FromClient_Window_CrogdaloStable()
  PaGlobal_Window_CrogdaloStable:initialize()
end
function PaGlobal_Window_CrogdaloStable:initialize()
  if Panel_Window_CrogdaloStable == nil then
    return
  end
  if _ContentsGroup_UsePadSnapping == false then
    self._maxSize = ToClient_getServantMaxCountByType(CppEnums.ServantWhereType.ServantWhereTypeCrogdaloStable)
    local templateBg = UI.getChildControl(Panel_Window_CrogdaloStable, "Static_HorseBG")
    local posX = templateBg:GetPosX()
    local gapX = 60
    for idx = 0, self._maxSize - 1 do
      local tempTable = {bg = nil, icon = nil}
      tempTable.bg = UI.cloneControl(templateBg, Panel_Window_CrogdaloStable, "Static_HorseBG_" .. idx)
      tempTable.icon = UI.getChildControl(tempTable.bg, "Static_HorseIcon")
      self._ui._horseBg[idx] = tempTable
      tempTable.bg:SetShow(true)
      tempTable.bg:SetPosX(posX)
      posX = posX + gapX
    end
    self._ui._btn_Common = UI.getChildControl(Panel_Window_CrogdaloStable, "Button_Horse")
    self._ui._stc_Selected = UI.getChildControl(Panel_Window_CrogdaloStable, "Static_Selected")
    self._ui._stc_UnSealed = UI.getChildControl(Panel_Window_CrogdaloStable, "Static_CurrentCheck")
    self._ui._stc_Selected:SetShow(false)
    self._ui._stc_UnSealed:SetShow(false)
  else
    self._ui._stc_doom_pad = UI.getChildControl(Panel_Window_CrogdaloStable, "Button_Doom")
    self._ui._txt_doomName_pad = UI.getChildControl(self._ui._stc_doom_pad, "StaticText_Name")
    self._ui._txt_doomState_pad = UI.getChildControl(self._ui._stc_doom_pad, "StaticText_State")
    self._ui._stc_dine_pad = UI.getChildControl(Panel_Window_CrogdaloStable, "Button_Dine")
    self._ui._txt_dineName_pad = UI.getChildControl(self._ui._stc_dine_pad, "StaticText_Name")
    self._ui._txt_dineState_pad = UI.getChildControl(self._ui._stc_dine_pad, "StaticText_State")
    self._ui._stc_adu_pad = UI.getChildControl(Panel_Window_CrogdaloStable, "Button_Adu")
    self._ui._txt_aduName_pad = UI.getChildControl(self._ui._stc_adu_pad, "StaticText_Name")
    self._ui._txt_aduState_pad = UI.getChildControl(self._ui._stc_adu_pad, "StaticText_State")
    self._stc_keyguide = UI.getChildControl(Panel_Window_CrogdaloStable, "Static_QuestBranchBottomGroup")
    self._stc_keyguide_A = UI.getChildControl(self._stc_keyguide, "StaticText_A")
    self._stc_keyguide_B = UI.getChildControl(self._stc_keyguide, "StaticText_B")
    PaGlobalFunc_ConsoleKeyGuide_SetAlign({
      self._stc_keyguide_A,
      self._stc_keyguide_B
    }, self._stc_keyguide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_CENTER)
    UI.getChildControl(Panel_Window_CrogdaloStable, "StaticText_Title"):SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTICON_TREASURETOOLTIP"))
  end
  PaGlobal_Window_CrogdaloStable:registEventHandler()
end
function PaGlobal_Window_CrogdaloStable:registEventHandler()
  registerEvent("FromClient_ServantSeal", "FromClient_CrogdaloStable_SealFinish")
  registerEvent("FromClient_ServantUnseal", "FromClient_CrogdaloStable_UnSealFinish")
  registerEvent("FromClient_ServantRecovery", "FromClient_CrogdaloStable_RecoveryFinish")
  registerEvent("FromClient_InventoryUpdate", "FromClient_CrogdaloStable_CheckAvailable")
  registerEvent("onScreenResize", "FromClient_CrogdaloStable_Resize")
  registerEvent("EventSelfServantUpdate", "FromClient_CrogdaloStable_Update")
  registerEvent("FromClient_CrogdaloStableListUpdate", "FromClient_CrogdaloStable_Update")
  registerEvent("FromClient_ServantUpdate", "FromClient_CrogdaloStable_Update")
end
function PaGlobal_Window_CrogdaloStable:prepareOpen()
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  if selfPlayer:isInstancePlayer() == true then
    return
  end
  if ToClient_isPlayingSequence() == true then
    return
  end
  if _ContentsGroup_UsePadSnapping == false then
    self._currentSelectIdx = -1
    self._ui._btn_Common:SetShow(false)
    self._ui._stc_Selected:SetShow(false)
    self._ui._stc_UnSealed:SetShow(false)
  end
  PaGlobal_Window_CrogdaloStable:update()
  if PaGlobal_PetControl_All ~= nil then
    PaGlobal_PetControl_All:prepareClose()
  end
  if _ContentsGroup_UsePadSnapping == true and Interaction_Close ~= nil then
    Interaction_Close()
  end
  PaGlobal_Window_CrogdaloStable:open()
  FromClient_CrogdaloStable_Resize()
end
function PaGlobal_Window_CrogdaloStable:resizePanel()
  Panel_Window_CrogdaloStable:ComputePos()
end
function PaGlobal_Window_CrogdaloStable:open()
  Panel_Window_CrogdaloStable:SetShow(true)
end
function PaGlobal_Window_CrogdaloStable:prepareClose()
  TooltipSimple_Hide()
  PaGlobal_Window_CrogdaloStable:close()
end
function PaGlobal_Window_CrogdaloStable:close()
  Panel_Window_CrogdaloStable:SetShow(false)
end
function PaGlobal_Window_CrogdaloStable:updatePc(unSealedType)
  for idx = 0, self._maxSize - 1 do
    local crogWrapper = ToClient_getServantCrogdaloByIndex(idx)
    self._ui._horseBg[idx].icon:SetShow(crogWrapper ~= nil)
    if crogWrapper ~= nil then
      local name = crogWrapper:getName()
      local getState = crogWrapper:getStateType()
      if CppEnums.ServantStateType.Type_Field == getState then
        self._ui._stc_UnSealed:SetShow(true)
        self._ui._stc_UnSealed:SetPosXY(self._ui._horseBg[idx].bg:GetPosX(), self._ui._stc_UnSealed:GetPosY())
      end
      self._ui._horseBg[idx].icon:ChangeTextureInfoNameAsync(crogWrapper:getIconPath1())
      local isComa = CppEnums.ServantStateType.Type_Coma == getState
      self._ui._horseBg[idx].icon:SetMonoTone(isComa, isComa)
      self._ui._horseBg[idx].bg:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrogdaloStable_UpdateBtnAndShow(" .. idx .. "," .. getState .. "," .. unSealedType .. ")")
      if self._currentSelectIdx == idx then
        PaGlobalFunc_CrogdaloStable_UpdateBtnAndShow(idx, getState, unSealedType)
      end
    else
      self._ui._horseBg[idx].bg:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrogdaloStable_UpdateBtnAndShow(" .. idx .. "," .. CppEnums.ServantStateType.Type_Count .. "," .. unSealedType .. ")")
      if self._currentSelectIdx == idx then
        PaGlobalFunc_CrogdaloStable_UpdateBtnAndShow(idx, CppEnums.ServantStateType.Type_Count, unSealedType)
      end
    end
    self._ui._horseBg[idx].icon:setRenderTexture(self._ui._horseBg[idx].icon:getBaseTexture())
  end
end
function PaGlobal_Window_CrogdaloStable:updatePad(unSealedType)
  self._ui._stc_adu_pad:SetMonoTone(true, true)
  self._ui._stc_adu_pad:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  self._ui._txt_aduName_pad:SetText("")
  self._ui._txt_aduState_pad:SetText("")
  self._ui._stc_dine_pad:SetMonoTone(true, true)
  self._ui._stc_dine_pad:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  self._ui._txt_dineName_pad:SetText("")
  self._ui._txt_dineState_pad:SetText("")
  self._ui._stc_doom_pad:SetMonoTone(true, true)
  self._ui._stc_doom_pad:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  self._ui._txt_doomName_pad:SetText("")
  self._ui._txt_doomState_pad:SetText("")
  self._ui._stc_adu_pad:addInputEvent("Mouse_On", "PaGlobalFunc_CrogdaloStable_UpdatePadKeyAndShow(0,0," .. CppEnums.ServantStateType.Type_Count .. "," .. unSealedType .. ")")
  self._ui._stc_dine_pad:addInputEvent("Mouse_On", "PaGlobalFunc_CrogdaloStable_UpdatePadKeyAndShow(1,1," .. CppEnums.ServantStateType.Type_Count .. "," .. unSealedType .. ")")
  self._ui._stc_doom_pad:addInputEvent("Mouse_On", "PaGlobalFunc_CrogdaloStable_UpdatePadKeyAndShow(2,2," .. CppEnums.ServantStateType.Type_Count .. "," .. unSealedType .. ")")
  if self._currentSelectIdx == idx then
    PaGlobalFunc_CrogdaloStable_UpdatePadKeyAndShow(0, 0, CppEnums.ServantStateType.Type_Count, unSealedType)
  end
  local stcControl
  for idx = 0, self._maxSize - 1 do
    local crogWrapper = ToClient_getServantCrogdaloByIndex(idx)
    if crogWrapper ~= nil then
      local name = crogWrapper:getName()
      local getState = crogWrapper:getStateType()
      local level = crogWrapper:getLevel()
      local textControl, stateControl
      local btnIdx = -1
      if crogWrapper:isDreamAdooanat() == true then
        textControl = self._ui._txt_aduName_pad
        stcControl = self._ui._stc_adu_pad
        stateControl = self._ui._txt_aduState_pad
        btnIdx = 0
      elseif crogWrapper:isDreamDine() == true then
        textControl = self._ui._txt_dineName_pad
        stcControl = self._ui._stc_dine_pad
        stateControl = self._ui._txt_dineState_pad
        btnIdx = 1
      elseif crogWrapper:isDreamDoom() == true then
        textControl = self._ui._txt_doomName_pad
        stcControl = self._ui._stc_doom_pad
        stateControl = self._ui._txt_doomState_pad
        btnIdx = 2
      else
        return
      end
      textControl:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_EXPEDITION_LEVEL_CHARACTERNAME", "level", level, "name", name))
      local isComa = CppEnums.ServantStateType.Type_Coma == getState
      local isUnSealed = CppEnums.ServantStateType.Type_Field == getState
      stateControl:SetText("")
      if isComa == true then
        stateControl:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_TXT_HURT"))
      elseif isUnSealed == true then
        stateControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_NOW_VEHICLE"))
      end
      stcControl:SetMonoTone(not isUnSealed, not isUnSealed)
      stcControl:addInputEvent("Mouse_On", "PaGlobalFunc_CrogdaloStable_UpdatePadKeyAndShow(" .. btnIdx .. "," .. idx .. "," .. getState .. "," .. unSealedType .. ")")
      if self._currentSelectIdx == idx then
        PaGlobalFunc_CrogdaloStable_UpdatePadKeyAndShow(btnIdx, idx, getState, unSealedType)
      end
    end
  end
end
function PaGlobal_Window_CrogdaloStable:update()
  local servantCount = ToClient_getStableCountCrogdalo()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local unsealedServantInfo = temporaryWrapper:getUnsealVehicle(__eServantTypeVehicle)
  local unsealedServantNo = 0
  local unSealedType = self._UNSELAEDTYPE_COUNT
  if unsealedServantInfo ~= nil then
    unsealedServantNo = unsealedServantInfo:getServantNo()
    local isOtherServant = true
    for idx = 0, servantCount do
      local servantWrapper = ToClient_getServantCrogdaloByIndex(idx)
      if servantWrapper ~= nil and CppEnums.ServantStateType.Type_Field == servantWrapper:getStateType() then
        unSealedType = self._UNSELAEDTYPE_CROGDALO
        isOtherServant = false
        if self._currentSelectIdx == -1 then
          self._currentSelectIdx = idx
        end
        break
      end
    end
    if isOtherServant == true then
      unSealedType = self._UNSELAEDTYPE_OTHER
    end
  end
  if _ContentsGroup_UsePadSnapping == false then
    PaGlobal_Window_CrogdaloStable:updatePc(unSealedType)
  else
    PaGlobal_Window_CrogdaloStable:updatePad(unSealedType)
  end
end
function PaGlobalFunc_CrogdaloStable_UpdateBtnAndShow(idx, stateType, unSealedType)
  local self = PaGlobal_Window_CrogdaloStable
  if idx < 0 or idx >= self._maxSize then
    return
  end
  local btnText = ""
  self._ui._btn_Common:SetShow(false)
  self._ui._stc_Selected:SetShow(true)
  self._currentSelectIdx = idx
  self._ui._stc_Selected:SetPosXY(self._ui._horseBg[idx].bg:GetPosX() - 2, self._ui._horseBg[idx].bg:GetPosY() - 2)
  self._ui._btn_Common:SetPosXY(self._ui._horseBg[idx].bg:GetPosX(), self._ui._btn_Common:GetPosY())
  if CppEnums.ServantStateType.Type_Stable == stateType then
    if unSealedType == self._UNSELAEDTYPE_CROGDALO then
      self._ui._btn_Common:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrogdaloStable_Swap(" .. idx .. ")")
      btnText = PAGetString(Defines.StringSheet_RESOURCE, "GAMEEXIT_CHANGE")
    elseif unSealedType == self._UNSELAEDTYPE_OTHER then
    elseif unSealedType == self._UNSELAEDTYPE_COUNT then
      self._ui._btn_Common:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrogdaloStable_UnSeal(" .. idx .. ")")
      btnText = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_FUNCTION_BTN_UNSEAL")
    end
  elseif CppEnums.ServantStateType.Type_Field == stateType then
    self._ui._btn_Common:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrogdaloStable_Seal()")
    btnText = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_FUNCTION_BTN_SEAL")
  elseif CppEnums.ServantStateType.Type_Count == stateType and unSealedType == self._UNSELAEDTYPE_OTHER then
    self._ui._btn_Common:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrogdaloStable_Seal()")
    btnText = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_FUNCTION_BTN_SEAL")
  end
  self._ui._btn_Common:addInputEvent("Mouse_On", "PaGlobalFunc_CrogdaloStableTooltip(true)")
  self._ui._btn_Common:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  self._ui._btn_Common:addInputEvent("Mouse_RUp", "PaGlobalFunc_CrogdaloStable_ShowToggle()")
  if btnText ~= "" then
    self._ui._btn_Common:SetShow(true)
    self._ui._btn_Common:SetText(btnText)
  end
end
function PaGlobalFunc_CrogdaloStable_UpdatePadKeyAndShow(btnIdx, idx, stateType, unSealedType)
  local self = PaGlobal_Window_CrogdaloStable
  if idx < 0 or idx >= self._maxSize then
    return
  end
  self._stc_keyguide_A:SetShow(false)
  local stc_btn
  local btnText = ""
  if btnIdx == 0 then
    stc_btn = self._ui._stc_adu_pad
  elseif btnIdx == 1 then
    stc_btn = self._ui._stc_dine_pad
  elseif btnIdx == 2 then
    stc_btn = self._ui._stc_doom_pad
  end
  if stc_btn == nil then
    return
  end
  self._currentSelectIdx = idx
  stc_btn:removeInputEvent("Mouse_LUp")
  if CppEnums.ServantStateType.Type_Stable == stateType then
    if unSealedType == self._UNSELAEDTYPE_CROGDALO then
      stc_btn:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrogdaloStable_Swap(" .. idx .. ")")
      btnText = PAGetString(Defines.StringSheet_RESOURCE, "GAMEEXIT_CHANGE")
    elseif unSealedType == self._UNSELAEDTYPE_OTHER then
    elseif unSealedType == self._UNSELAEDTYPE_COUNT then
      stc_btn:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrogdaloStable_UnSeal(" .. idx .. ")")
      btnText = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_FUNCTION_BTN_UNSEAL")
    end
  elseif CppEnums.ServantStateType.Type_Field == stateType then
    stc_btn:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrogdaloStable_Seal()")
    btnText = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_FUNCTION_BTN_SEAL")
  elseif CppEnums.ServantStateType.Type_Count == stateType and unSealedType == self._UNSELAEDTYPE_OTHER then
    stc_btn:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrogdaloStable_Seal()")
    btnText = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_FUNCTION_BTN_SEAL")
  end
  if btnText ~= "" then
    self._stc_keyguide_A:SetShow(true)
    self._stc_keyguide_A:SetText(btnText)
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign({
    self._stc_keyguide_A,
    self._stc_keyguide_B
  }, self._stc_keyguide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_CENTER)
end
function PaGlobalFunc_CrogdaloStable_UnSeal(idx)
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  if selfPlayer:isInstancePlayer() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMiniGameYachtDiceNotExitGame"))
    return
  end
  if doHaveContentsItem(__eContentsType_Crogdalo) == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NO_ITEMSCROLL"))
    return
  end
  if false == IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_NOTCURRENTACTION_ACK"))
    return
  end
  if ToClient_isPlayingSequence() == true then
    return
  end
  local servantWrapper = ToClient_getServantCrogdaloByIndex(idx)
  if servantWrapper == nil then
    return
  end
  ToClient_requestUnSealServantCrogdalo(servantWrapper:getServantNo())
  if ServantInventory_Close ~= nil then
    ServantInventory_Close(true)
  end
  PaGlobal_VehicleInfo_All_Close()
end
function PaGlobalFunc_CrogdaloStable_Seal()
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  if selfPlayer:isInstancePlayer() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMiniGameYachtDiceNotExitGame"))
    return
  end
  if false == IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_NOTCURRENTACTION_ACK"))
    return
  end
  if doHaveContentsItem(__eContentsType_Crogdalo) == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NO_ITEMSCROLL"))
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  local unsealedServantInfo = temporaryWrapper:getUnsealVehicle(__eServantTypeVehicle)
  if unsealedServantInfo == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLELIST_NOT_UNSEAL_SERVANT"))
    return
  end
  ToClient_requestSealServantCrogdalo(false)
  if ServantInventory_Close ~= nil then
    ServantInventory_Close(true)
  end
  PaGlobal_VehicleInfo_All_Close()
end
function PaGlobalFunc_CrogdaloStable_Swap(index)
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  if selfPlayer:isInstancePlayer() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMiniGameYachtDiceNotExitGame"))
    return
  end
  if doHaveContentsItem(__eContentsType_Crogdalo) == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NO_ITEMSCROLL"))
    return
  end
  if false == IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_NOTCURRENTACTION_ACK"))
    return
  end
  if ToClient_isPlayingSequence() == true then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  local unsealedServantInfo = temporaryWrapper:getUnsealVehicle(__eServantTypeVehicle)
  if unsealedServantInfo == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLELIST_NOT_UNSEAL_SERVANT"))
    return
  end
  local rv = ToClient_requestSealServantCrogdalo(false)
  if rv == 0 then
    local servantWrapper = ToClient_getServantCrogdaloByIndex(index)
    if servantWrapper == nil then
      return
    end
    PaGlobal_Window_CrogdaloStable._reservedNo = servantWrapper:getServantNo()
    if ServantInventory_Close ~= nil then
      ServantInventory_Close(true)
    end
    PaGlobal_VehicleInfo_All_Close()
  end
end
function PaGlobalFunc_CrogdaloStableTooltip(isShow)
  if isShow == nil then
    TooltipSimple_Hide()
    return
  end
  local name = ""
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_CROGDALO_CALL_CLOSE_BTN")
  local control = PaGlobal_Window_CrogdaloStable._ui._btn_Common
  TooltipSimple_Show(control, name, desc)
end
function FromClient_CrogdaloStable_SealFinish(servantNo, regionKey, servantWhereType)
  if Panel_Window_CrogdaloStable == nil then
    return
  end
  if Defines.UIMode.eUIMode_Default ~= GetUIMode() then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_GIVE_SERVANT_ACK"))
  FGlobal_Window_Servant_Update()
  if Panel_Window_CrogdaloStable:GetShow() == true then
    if PaGlobal_Window_CrogdaloStable._reservedNo == nil or PaGlobal_Window_CrogdaloStable._reservedNo == 0 then
      return
    elseif PaGlobal_Window_CrogdaloStable._reservedNo ~= servantNo then
      ToClient_requestUnSealServantCrogdalo(PaGlobal_Window_CrogdaloStable._reservedNo)
      PaGlobal_Window_CrogdaloStable._reservedNo = nil
    end
  end
  PaGlobal_Window_CrogdaloStable:update()
end
function FromClient_CrogdaloStable_UnSealFinish(servantNo, servantWhereType)
  if Panel_Window_CrogdaloStable == nil then
    return
  end
  if Defines.UIMode.eUIMode_Default ~= GetUIMode() then
    return
  end
  if Panel_Window_CrogdaloStable:GetShow() == true then
    PaGlobal_Window_CrogdaloStable:update()
  end
  if Panel_Dialog_ServantList_All:GetShow() == true then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_GET_SERVANT_ACK"))
  FGlobal_Window_Servant_Update()
end
function FromClient_CrogdaloStable_RecoveryFinish()
  if Panel_Window_CrogdaloStable == nil then
    return
  end
  if Defines.UIMode.eUIMode_Default ~= GetUIMode() then
    return
  end
  if Panel_Window_CrogdaloStable:GetShow() == true then
    PaGlobal_Window_CrogdaloStable:update()
  end
  if Panel_Dialog_ServantList_All:GetShow() == true then
    return
  end
end
function PaGlobalFunc_CrogdaloStable_Close()
  PaGlobal_Window_CrogdaloStable:prepareClose()
end
function PaGlobalFunc_CrogdaloStable_ShowToggle()
  if _ContentsGroup_Crogdalo == false then
    return
  end
  if Panel_Window_CrogdaloStable == nil then
    return
  end
  if Panel_Window_CrogdaloStable:GetShow() == true then
    PaGlobal_Window_CrogdaloStable:prepareClose()
  else
    PaGlobal_Window_CrogdaloStable:prepareOpen()
  end
end
function FromClient_CrogdaloStable_Resize()
  if Panel_Window_CrogdaloStable == nil then
    return
  end
  if Panel_Window_CrogdaloStable:GetShow() == false then
    return
  end
  if _ContentsGroup_UsePadSnapping == false then
    local posX = PaGlobalFunc_ServantIcon_GetIconPosX(0)
    local posY = PaGlobalFunc_ServantIcon_GetIconPosY(0)
    local size = PaGlobalFunc_ServantIcon_GetIconSizeX(0)
    Panel_Window_CrogdaloStable:SetPosX(posX)
    Panel_Window_CrogdaloStable:SetPosY(PaGlobalFunc_ServantIcon_GetPanelPosY() + size)
    local crogdaloHalfPosCheck = getScreenSizeY() <= posY + size + Panel_Window_CrogdaloStable:GetSizeY() + 70
    if crogdaloHalfPosCheck == true then
      Panel_Window_CrogdaloStable:SetPosY(PaGlobalFunc_ServantIcon_GetPanelPosY() - Panel_Window_CrogdaloStable:GetSizeY() - 10)
      PaGlobal_Window_CrogdaloStable._ui._btn_Common:SetSpanSize(0, -45)
    else
      PaGlobal_Window_CrogdaloStable._ui._btn_Common:SetSpanSize(0, 60)
    end
  else
    Panel_Window_CrogdaloStable:ComputePosAllChild()
  end
end
function FromClient_CrogdaloStable_CheckAvailable()
  if Panel_Window_CrogdaloStable == nil then
    return
  end
  if _ContentsGroup_Crogdalo == false then
    return
  end
  if Panel_Window_CrogdaloStable:GetShow() == false then
    return
  end
  if doHaveContentsItem(__eContentsType_Crogdalo) == false then
    PaGlobal_Window_CrogdaloStable:prepareClose()
  end
end
function FromClient_CrogdaloStable_Update()
  if Panel_Window_CrogdaloStable == nil then
    return
  end
  if _ContentsGroup_Crogdalo == false then
    return
  end
  if Panel_Window_CrogdaloStable:GetShow() == false then
    return
  end
  PaGlobal_Window_CrogdaloStable:update()
end
