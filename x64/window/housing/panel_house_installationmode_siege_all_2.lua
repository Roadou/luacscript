function PaGlobal_House_InstallationSiege_All_CreateList2(content, index)
  if true == PaGlobal_House_InstallationSiege_All._isRemoteMode then
    if true == PaGlobal_House_InstallationSiege_All._isBuildedTent then
      PaGlobal_House_InstallationSiege_All_CreateSiegeInstallationList2(content, index)
    else
      PaGlobal_House_InstallationSiege_All_CreateRemoteSiegeInstallationList2(content, index)
    end
  else
    PaGlobal_House_InstallationSiege_All_CreateSiegeInstallationList2(content, index)
  end
end
function PaGlobal_House_InstallationSiege_All_CreateSiegeInstallationList2(content, index)
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
  local key = Int64toInt32(index)
  local characterWrapper = ToClient_getSiegeInstallableListByIndex(key)
  if nil == characterWrapper then
    return
  end
  local radioButton = UI.getChildControl(content, "RadioButton_1")
  local stc_itemTemp = UI.getChildControl(radioButton, "Static_Item_Templete")
  local txt_shortCut = UI.getChildControl(stc_itemTemp, "StaticText_ShortCut")
  radioButton:SetText(characterWrapper:getName())
  txt_shortCut:SetText("")
  if _ContentsGroup_SimpleBuildMode == true and PaGlobal_House_InstallationSiege_All._isConsole == false and PaGlobal_House_InstallationSiege_All._isRemoteMode == false then
    if key >= 0 and key < 9 then
      txt_shortCut:SetText(tostring(key + 1))
    elseif key == 9 then
      txt_shortCut:SetText("0")
    elseif key > 9 and key < 20 then
      local num = key - 9
      txt_shortCut:SetText("F" .. tostring(num))
    end
  end
  txt_shortCut:ChangeTextureInfoNameAsync("Icon/" .. ToClient_getSiegeInstallationCharacterIconPath(key))
  if true == PaGlobal_House_InstallationSiege_All._isRemoteMode and true == PaGlobal_House_InstallationSiege_All._isBuildedTent then
    radioButton:addInputEvent("Mouse_LUp", "PaGlobal_House_InstallationSiege_All_RequestRemoteSiegeInstallationStart(false," .. key .. ")")
    txt_shortCut:addInputEvent("Mouse_LUp", "PaGlobal_House_InstallationSiege_All_RequestRemoteSiegeInstallationStart(false," .. key .. ")")
  else
    radioButton:addInputEvent("Mouse_LUp", "PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(" .. key .. ")")
    txt_shortCut:addInputEvent("Mouse_LUp", "PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(" .. key .. ")")
  end
  txt_shortCut:addInputEvent("Mouse_On", "HandleEventOnOut_House_InstallationSiege_All_ShowInstallationTooltip(true," .. tostring(key) .. ")")
  txt_shortCut:addInputEvent("Mouse_Out", "HandleEventOnOut_House_InstallationSiege_All_ShowInstallationTooltip(false)")
  PaGlobal_House_InstallationSiege_All._radioBtnSlot[key] = radioButton
end
function PaGlobal_House_InstallationSiege_All_CreateRemoteSiegeInstallationList2(content, index)
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
  local radioButton = UI.getChildControl(content, "RadioButton_1")
  local stc_itemTemp = UI.getChildControl(radioButton, "Static_Item_Templete")
  local txt_shortCut = UI.getChildControl(stc_itemTemp, "StaticText_ShortCut")
  local key = Int64toInt32(index)
  local slotIdx = PaGlobal_House_InstallationSiege_All._remoteSiegeList[key]
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotIdx)
  if nil == itemWrapper then
    return
  end
  local itemESS = itemWrapper:getStaticStatus()
  if nil == itemESS then
    return
  end
  local itemCSS = itemESS:getCharacterStaticStatus()
  if nil == itemCSS then
    return
  end
  radioButton:SetTextMode(__eTextMode_AutoWrap)
  radioButton:SetText(itemESS:getName())
  txt_shortCut:SetText("")
  txt_shortCut:ChangeTextureInfoNameAsync("Icon/" .. itemESS:getIconPath())
  radioButton:addInputEvent("Mouse_LUp", "PaGlobal_House_InstallationSiege_All_RequestRemoteSiegeInstallationStart(true," .. key .. ")")
  txt_shortCut:addInputEvent("Mouse_LUp", "PaGlobal_House_InstallationSiege_All_RequestRemoteSiegeInstallationStart(true," .. key .. ")")
  txt_shortCut:addInputEvent("Mouse_On", "HandleEventOnOut_House_InstallationSiege_All_RemoteTentInstallationTooltip(true," .. tostring(key) .. ")")
  txt_shortCut:addInputEvent("Mouse_Out", "HandleEventOnOut_House_InstallationSiege_All_RemoteTentInstallationTooltip(false)")
  PaGlobal_House_InstallationSiege_All._radioBtnSlot[key] = radioButton
end
function PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(index)
  if ToClient_IsVillageSiegeBeing() == true then
    local function installationStart()
      PaGlobal_House_InstallationSiege_All:requestSiegeInstallationStart(index)
    end
    local price64 = ToClient_getSiegeInstallationGuildMoney(index)
    local price = Int64toInt32(price64)
    if price <= 0 then
      PaGlobal_House_InstallationSiege_All:requestSiegeInstallationStart(index)
    else
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_INTERACTION_WARBUILDING_MEMO_TITLE"),
        content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_WARBUILDING_MEMO_DESC2", "price", makeDotMoney(price)),
        functionYes = installationStart,
        functionCancel = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    end
  else
    PaGlobal_House_InstallationSiege_All:requestSiegeInstallationStart(index)
  end
end
function PaGlobal_House_InstallationSiege_All_RequestRemoteSiegeInstallationStart(isTent, index)
  PaGlobal_House_InstallationSiege_All:requestRemoteSiegeInstallationStart(isTent, index)
end
function PaGlobal_House_InstallationSiege_All_RequestRemoteSiegeInstallationNoneItemStart()
  PaGlobal_House_InstallationSiege_All:requestRemoteSiegeInstallationNoneItemStart()
end
function PaGlobal_House_InstallationSiege_All_EndBuildTent()
  PaGlobal_House_InstallationSiege_All:endBuildTent()
end
function HandleEventLUp_House_InstallationSiege_All_RemoteConfirm()
  PaGlobal_House_InstallationSiege_All:remoteInstallConfirm()
end
function PaGlobal_House_InstallationSiege_All_CheckKeyBinder()
  if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    PaGlobal_House_InstallationSiege_All_KeyBinderClose()
    return
  end
  if _ContentsGroup_SimpleBuildMode == true and PaGlobal_House_InstallationSiege_All._isConsole == false and PaGlobal_House_InstallationSiege_All._isRemoteMode == false then
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_1) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(0)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_2) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(1)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_3) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(2)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_4) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(3)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_5) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(4)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_6) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(5)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_7) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(6)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_8) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(7)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_9) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(8)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_0) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(9)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_F1) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(10)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_F2) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(11)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_F3) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(12)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_F4) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(13)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_F5) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(14)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_F6) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(15)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_F7) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(16)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_F8) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(17)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_F9) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(18)
      return
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_F10) then
      PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(19)
      return
    end
  end
end
function HandleEventLUp_House_InstallationSiege_All_EditItemNameClear()
  PaGlobal_House_InstallationSiege_All._ui._edit_searchBox:SetEditText("", true)
  SetFocusEdit(PaGlobal_House_InstallationSiege_All._ui._edit_searchBox)
  PaGlobal_House_InstallationSiege_All._ui._txt_searchIcon:SetShow(false)
end
function HandleEventKey_House_InstallationSiege_All_FindItemName()
  local inputKeyword = PaGlobal_House_InstallationSiege_All._ui._edit_searchBox:GetEditText()
  ClearFocusEdit()
  ToClient_clearFilterSiegeInstallationList()
  ToClient_searchFilterSiegeInstallationList(inputKeyword)
  PaGlobal_House_InstallationSiege_All:createSiegeInstallationList()
end
function HandleEventKey_House_InstallationSiege_All_FindItemName_ForConsole(str)
  local inputKeyword = str
  if nil == inputKeyword then
    inputKeyword = ""
  end
  PaGlobal_House_InstallationSiege_All._ui._edit_searchBox:SetEditText(inputKeyword)
  ClearFocusEdit()
  ToClient_clearFilterSiegeInstallationList()
  ToClient_searchFilterSiegeInstallationList(inputKeyword)
  PaGlobal_House_InstallationSiege_All:createSiegeInstallationList()
  PaGlobal_House_InstallationSiege_All:firstItemSnapping()
end
function HandleEventOnOut_House_InstallationSiege_All_ShowInstallationTooltip(isShow, key)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == key then
    return
  end
  local characterWrapper = ToClient_getSiegeInstallableListByIndex(key)
  if nil == characterWrapper then
    return
  end
  local radioButton = PaGlobal_House_InstallationSiege_All._radioBtnSlot[key]
  if nil == radioButton then
    return
  end
  local parentControl = UI.getChildControl(radioButton, "Static_Item_Templete")
  if parentControl == nil then
    return
  end
  local control = UI.getChildControl(parentControl, "StaticText_ShortCut")
  if control == nil then
    return
  end
  local name = characterWrapper:getName()
  local desc = ToClient_getSiegeBuildKitInstallationDesc(key)
  TooltipSimple_Show(control, name, desc)
  local tooltipPosX = 0
  if true == PaGlobal_House_InstallationSiege_All._isRemoteMode then
    tooltipPosX = PaGlobal_House_InstallationSiege_All._ui._stc_backGround:GetPosX() + PaGlobal_House_InstallationSiege_All._ui._stc_backGround:GetSizeX() + 10
  else
    tooltipPosX = PaGlobal_House_InstallationSiege_All._ui._stc_backGround:GetPosX() - Panel_Tooltip_SimpleText:GetSizeX()
  end
  TooltipSimple_Common_Pos(tooltipPosX, Panel_Tooltip_SimpleText:GetPosY())
end
function HandleEventOnOut_House_InstallationSiege_All_RemoteTentInstallationTooltip(isShow, key)
  if nil == isShow or false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if nil == key then
    return
  end
  local slotIdx = PaGlobal_House_InstallationSiege_All._remoteSiegeList[key]
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotIdx)
  if nil == itemWrapper then
    return
  end
  Panel_Tooltip_Item_Show(itemWrapper, PaGlobal_House_InstallationSiege_All._radioBtnSlot[key], false, true, nil)
end
function FromClient_House_InstallationSiege_All_UpdateItemInventory()
  if false == PaGlobal_House_InstallationSiege_All_GetShowPanel() then
    return
  end
  PaGlobal_House_InstallationSiege_All:updateItemSetData(true)
  PaGlobal_House_InstallationSiege_All:updateItemSlot(PaGlobal_House_InstallationSiege_All._startItemSlotIndex)
end
function FromClient_House_InstallationSiege_All_CancelInstallModeMessageBox()
  if false == PaGlobal_House_InstallationSiege_All_GetShowPanel() then
    return
  end
  PaGlobal_House_Installation_All_CancelInstallModeMessageBox()
end
function PaGlobal_House_InstallationSiege_All_ShowAni()
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
end
function PaGlobal_House_InstallationSiege_All_HideAni()
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
end
function PaGlobal_House_InstallationSiege_All_Open()
  PaGlobal_House_InstallationSiege_All:prepareOpen()
end
function PaGlobal_House_InstallationSiege_All_Close()
  if ToClient_isSimpleBuildMode() == true then
    return
  end
  PaGlobal_House_InstallationSiege_All:prepareClose()
end
function PaGlobal_House_InstallationSiege_All_KeyBinderClose()
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
  local remoteBatchCancel = function()
    if false == PaGlobal_House_InstallationSiege_All._isBuildedTent then
      ToClient_EndRemoteInstall()
    else
      ToClient_CancelRemoteInstallObject()
    end
    PaGlobal_WarInfomation_All_Update()
    PaGlobal_House_InstallationMode_ObjectControl_All_Close()
    PaGlobal_House_InstallationSiege_All:remoteSelectClear()
    PaGlobal_House_InstallationSiege_All:initTentKitItemInfo()
    PaGlobal_House_InstallationSiege_All:buttonUpdate()
  end
  local remoteHousingCancel = function()
    ToClient_EndRemoteInstall()
    PaGlobal_WarInfomation_All_Close()
    PaGlobal_House_InstallationMode_ObjectControl_All_Close()
    PaGlobal_House_InstallationSiege_All:remoteSelectClear()
    PaGlobal_House_InstallationSiege_All:initTentKitItemInfo()
    PaGlobal_House_InstallationSiege_All:buttonUpdate()
  end
  if true == PaGlobal_House_InstallationSiege_All._isRemoteMode and true == housing_isBuildMode() then
    if true == ToClient_IsRemoteSelected() then
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "TENT_BUILD_CANCEL_MESSAGEBOX_TITLE"),
        content = PAGetString(Defines.StringSheet_GAME, "TENT_BUILD_CANCEL_MESSAGEBOX_MEMO"),
        functionYes = remoteBatchCancel,
        functionCancel = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_REMOTEINSTALLATION_HOUSINGMODE_CANCEL"),
        functionYes = remoteHousingCancel,
        functionCancel = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    end
  end
  if true == PaGlobal_House_InstallationSiege_All._isRemoteMode then
    return
  end
  PaGlobal_House_InstallationSiege_All_Close()
end
function HandleEventLUp_House_InstallationSiege_All_Close()
  if true == PaGlobal_House_InstallationSiege_All._isRemoteMode then
    if true == housing_isBuildMode() then
      ToClient_CancelRemoteInstallObject()
    end
    PaGlobal_House_InstallationSiege_All_RemoteOff()
  end
  PaGlobal_House_InstallationSiege_All_Close()
end
function PaGlobal_House_InstallationSiege_All_GetShowPanel()
  if nil == Panel_House_InstallationMode_Siege_All then
    return false
  end
  return Panel_House_InstallationMode_Siege_All:GetShow()
end
function PaGlobal_House_InstallationSiege_All_SetSearchFocus()
  ClearFocusEdit()
  PaGlobal_House_InstallationSiege_All._ui._edit_searchBox:SetEditText("", false)
  SetFocusEdit(PaGlobal_House_InstallationSiege_All._ui._edit_searchBox)
  PaGlobal_House_InstallationSiege_All._ui._txt_searchIcon:SetShow(false)
end
function PaGlobal_House_InstallationSiege_All_SetKeyGuide(modeState)
  PaGlobal_House_InstallationSiege_All:setKeyGuide(modeState)
end
function PaGlobal_House_InstallationSiege_All_OnScreenResize()
end
function PaGlobal_House_InstallationSiege_All_FromClient_OpenSiegeInstallationList(itemEnchantKey)
  if nil == itemEnchantKey then
    return
  end
  PaGlobal_House_InstallationSiege_All._itemEnchantKey = itemEnchantKey
  PaGlobal_House_InstallationSiege_All_Open()
end
function PaGlobal_House_InstallationSiege_All_FromClient_InventoryUpdate()
  if false == PaGlobal_House_InstallationSiege_All_GetShowPanel() then
    return
  end
  if true == PaGlobal_House_InstallationSiege_All._isRemoteMode and false == PaGlobal_House_InstallationSiege_All._isBuildedTent then
    return
  end
  PaGlobal_House_InstallationSiege_All:checkRemainTentKitItemCount()
  PaGlobal_House_InstallationSiege_All._currentSelectedIndex = nil
end
function PaGlobal_House_InstallationSiege_All_RemoteControlModeInit()
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
  if false == ToClient_IsRemoteInstallMode() then
    return
  end
  PaGlobal_House_InstallationSiege_All._isRemoteMode = true
  local regionKey = ToClient_GetRemoteRegionKey()
  local regionInfo = getRegionInfoByRegionKey(regionKey)
  local territoryInfo = getTerritoryInfoWrapper(regionInfo:getTerritoryKeyRaw())
  PaGlobal_House_InstallationSiege_All._ui._btn_cancel:SetSize(PaGlobal_House_InstallationSiege_All._ui._btn_confirm:GetSizeX(), PaGlobal_House_InstallationSiege_All._ui._btn_cancel:GetSizeY())
  PaGlobal_House_InstallationSiege_All._ui._btn_cancel:SetShow(true)
  PaGlobal_House_InstallationSiege_All._ui._btn_confirm:SetShow(true)
  PaGlobal_House_InstallationSiege_All._ui._stc_keyguidePCRemote:SetShow(true)
  local isMinorSiege = ToClient_GetRemoteRegionIsMinorSiege()
  if true == isMinorSiege then
    ToClient_toggleVillageSiegeArea(true)
  end
  if false == ToClient_getMyGuildBuildingInfoByRegionKey(regionKey:get()) then
    PaGlobal_House_InstallationSiege_All._isBuildedTent = false
    PaGlobal_House_InstallationSiege_All._ui._stc_itemKitBg:SetShow(false)
    PaGlobal_House_InstallationSiege_All._ui._stc_remoteInfoBg:SetShow(true)
    PaGlobal_House_InstallationSiege_All._ui._stc_remoteIcon:SetText(regionInfo:getAreaName())
    PaGlobal_House_InstallationSiege_All._ui._stc_remoteIcon:ChangeTextureInfoNameAsync(territoryInfo:getTerritoryImage())
    PaGlobal_House_InstallationSiege_All:prepareOpen()
  else
    PaGlobal_House_InstallationSiege_All._isBuildedTent = true
    PaGlobal_House_InstallationSiege_All._ui._stc_itemKitBg:SetShow(true)
    PaGlobal_House_InstallationSiege_All._ui._stc_remoteInfoBg:SetShow(false)
    PaGlobal_House_InstallationSiege_All:createRemoteSiegeInstallationList()
  end
end
function FromClient_House_InstallationSiege_All_AddTentAck()
  if false == ToClient_IsRemoteInstallMode() then
    return
  end
  if true == PaGlobal_House_InstallationSiege_All._isBuildedTent then
    return
  end
  local regionKey = ToClient_GetRemoteRegionKey()
  if false == ToClient_getMyGuildBuildingInfoByRegionKey(regionKey:get()) then
    return
  end
  PaGlobal_House_InstallationSiege_All._isBuildedTent = true
  PaGlobal_House_InstallationSiege_All._ui._stc_itemKitBg:SetShow(true)
  PaGlobal_House_InstallationSiege_All._ui._stc_remoteInfoBg:SetShow(false)
  PaGlobal_House_InstallationSiege_All:createRemoteSiegeInstallationList()
end
function FromClient_House_InstallationSiege_All_RemoveTentAck()
  if false == ToClient_IsRemoteInstallMode() then
    return
  end
  local regionKey = ToClient_GetRemoteRegionKey()
  local regionInfo = getRegionInfoByRegionKey(regionKey)
  local territoryInfo = getTerritoryInfoWrapper(regionInfo:getTerritoryKeyRaw())
  if true == ToClient_getMyGuildBuildingInfoByRegionKey(regionKey:get()) then
    return
  end
  PaGlobal_House_InstallationSiege_All._isBuildedTent = false
  PaGlobal_House_InstallationSiege_All._ui._stc_itemKitBg:SetShow(false)
  PaGlobal_House_InstallationSiege_All._ui._stc_remoteInfoBg:SetShow(true)
  PaGlobal_House_InstallationSiege_All._ui._stc_remoteIcon:SetText(regionInfo:getAreaName())
  PaGlobal_House_InstallationSiege_All._ui._stc_remoteIcon:ChangeTextureInfoNameAsync(territoryInfo:getTerritoryImage())
  ToClient_clearSiegeInstallableList()
  PaGlobal_House_InstallationSiege_All:prepareOpen()
end
function FromClient_House_InstallationSiege_All_InsertRemoteInstallationList()
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
  if false == PaGlobal_House_InstallationSiege_All._isRemoteMode then
    return
  end
  if false == PaGlobal_House_InstallationSiege_All._isBuildedTent then
    return
  end
  PaGlobal_House_InstallationSiege_All._remoteObjectCount = ToClient_GetRemoteInsertedCount()
  PaGlobal_House_InstallationSiege_All:checkRemainTentKitItemCount()
  PaGlobal_House_InstallationSiege_All._currentSelectedIndex = nil
  PaGlobal_House_InstallationSiege_All:createRemoteSiegeInstallationList()
end
function FromClient_House_InstallationSiege_All_ButtonUpdate()
  PaGlobal_House_InstallationSiege_All:buttonUpdate()
end
function PaGlobal_House_InstallationSiege_All_RemoteOff()
  local regionKey = ToClient_GetRemoteRegionKey()
  local isMinorSiege = ToClient_GetRemoteRegionIsMinorSiege()
  ToClient_RemoteInstallModeOnOff(false, regionKey:get(), isMinorSiege)
end
function FromClient_House_InstallationSiege_All_SimpleBuildEnd()
  if Panel_House_InstallationMode_Siege_All == nil or Panel_House_InstallationMode_Siege_All:GetShow() == false then
    return
  end
  PaGlobal_House_InstallationSiege_All:endBuildTent()
end
function FromClient_RemoteControlOpen()
  PaGlobal_House_InstallationSiege_All_RemoteControlModeInit()
end
