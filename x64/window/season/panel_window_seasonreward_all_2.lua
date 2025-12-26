function PaGlobal_SeasonReward_All_Open()
  if nil == Panel_Window_SeasonReward_All then
    return
  end
  PaGlobal_SeasonReward_All:prepareOpen()
end
function PaGlobal_SeasonReward_All_Close()
  if nil == Panel_Window_SeasonReward_All then
    return
  end
  PaGlobal_SeasonReward_All:prepareClose()
end
function PaGlobal_SeasonReward_All_CreateSeasonList(content, key)
  local key32 = Int64toInt32(key)
  local button = UI.getChildControl(content, "Button_LeftContentBg")
  local buttonText = UI.getChildControl(button, "StaticText_ButtonText")
  local completeIcon = UI.getChildControl(button, "Static_StatusIcon_Complete")
  local activateIcon = UI.getChildControl(button, "Static_StatusIcon_Activate")
  local lockIcon = UI.getChildControl(button, "Static_StatusIcon_Lock")
  buttonText:SetTextMode(__eTextMode_LimitText)
  local seasonRewardStaticStatus = getSeasonRewardStaticStatus(key32)
  if nil ~= seasonRewardStaticStatus then
    local seasonNameKey = seasonRewardStaticStatus:getSeasonName()
    local seasonName = PAGetString(Defines.StringSheet_GAME, seasonNameKey)
    buttonText:SetText(seasonName)
  else
    buttonText:SetText("")
  end
  completeIcon:SetShow(false)
  activateIcon:SetShow(false)
  lockIcon:SetShow(false)
  local isReceivedReward = ToClient_isSelectedRewardSeasonNo(key32)
  if true == isReceivedReward then
    completeIcon:SetShow(true)
  else
    activateIcon:SetShow(true)
  end
  button:addInputEvent("Mouse_LUp", "PaGlobal_SeasonReward_All_SelectSeason(" .. tostring(key32) .. ")")
  if true == PaGlobal_SeasonReward_All._isConsole then
    button:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_SelectSeasonBtnTooltip(" .. tostring(key32) .. ", true)")
    button:addInputEvent("Mouse_Out", "HandleEventLUp_SelectSeasonBtnTooltip(false)")
  end
end
function PaGlobal_SeasonReward_All_SelectSeason(seasonNo)
  PaGlobal_SeasonReward_All._selectedSeasonNo = seasonNo
  PaGlobal_SeasonReward_All._selectedItemIndex = 1
  PaGlobal_SeasonReward_All:contentUpdate()
end
function PaGlobal_SeasonReward_All_SelectRewardIndex(index)
  PaGlobal_SeasonReward_All._selectedItemIndex = index
  PaGlobal_SeasonReward_All:contentUpdate()
end
function PaGlobal_SeasonReward_All_ReceiveReward()
  local isReceivedReward = ToClient_isSelectedRewardSeasonNo(PaGlobal_SeasonReward_All._selectedSeasonNo)
  if isReceivedReward == true and PaGlobal_SeasonReward_All._selectedSeasonNo ~= PaGlobal_SeasonReward_All._seasonNoRewardRepeatable then
    return
  end
  ToClient_selectSeasonReward(PaGlobal_SeasonReward_All._selectedSeasonNo, PaGlobal_SeasonReward_All._selectedItemIndex - 1)
end
function HandleEventOnOut_SeasonReward_All_ShowRewardItemTooltip_Console(isShow)
  if nil == Panel_Window_SeasonReward_All then
    return
  end
  local closeFunc = Panel_Tooltip_Item_hideTooltip
  if true == _ContentsGroup_RenewUI then
    closeFunc = PaGlobalFunc_TooltipInfo_Close
  end
  if false == isShow and nil ~= closeFunc then
    closeFunc()
    return
  end
  local rewardItemEnchantKey = ToClient_getRewardByIndex(PaGlobal_SeasonReward_All._selectedSeasonNo, PaGlobal_SeasonReward_All._selectedItemIndex - 1)
  if nil == rewardItemEnchantKey then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(rewardItemEnchantKey)
  if nil == itemSSW then
    return
  end
  local control = PaGlobal_SeasonReward_All._ui.rewardItemSlot.icon
  if false == _ContentsGroup_RenewUI then
    Panel_Tooltip_Item_Show(itemSSW, control, true)
  else
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventOnOut_SeasonReward_All_ShowRewardItemTooltip(isShow, itemKey, enchantLevel)
  if nil == Panel_Window_SeasonReward_All then
    return
  end
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey, enchantLevel))
  if nil == itemSSW then
    return
  end
  local control = PaGlobal_SeasonReward_All._ui.rewardItemSlot.icon
  Panel_Tooltip_Item_Show(itemSSW, control, true)
end
function HandleEventOnOut_SeasonReward_All_ShowListItemTooltip(isShow, index, itemKey, enchantLevel)
  if nil == Panel_Window_SeasonReward_All then
    return
  end
  local closeFunc = Panel_Tooltip_Item_hideTooltip
  if true == _ContentsGroup_RenewUI then
    closeFunc = PaGlobalFunc_TooltipInfo_Close
  end
  if false == isShow and nil ~= closeFunc then
    closeFunc()
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey, enchantLevel))
  if nil == itemSSW then
    return
  end
  local control = PaGlobal_SeasonReward_All._ui.rewardSlotList[index].icon
  if false == _ContentsGroup_RenewUI then
    Panel_Tooltip_Item_Show(itemSSW, control, true)
  else
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function FromClient_SeasonReward_All_OnScreenResize()
  if nil == Panel_Window_SeasonReward_All then
    return
  end
  Panel_Window_SeasonReward_All:ComputePosAllChild()
end
function FromClient_SeasonReward_All_ResponseSelectSeasonReward()
  if nil == Panel_Window_SeasonReward_All or false == Panel_Window_SeasonReward_All:GetShow() then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHANGEWEAPON_SUCCESS_CHANGEITEM"))
  PaGlobal_SeasonReward_All._ui.stc_exchangeEffect:EraseAllEffect()
  PaGlobal_SeasonReward_All._ui.stc_exchangeEffect:AddEffect("fUI_Season_Gift_01A", false, 0, 0)
  audioPostEvent_SystemUi(28, 2)
  _AudioPostEvent_SystemUiForXBOX(28, 2)
  PaGlobal_SeasonReward_All:listUpdate()
  PaGlobal_SeasonReward_All:contentUpdate()
end
function HandleEventLUp_SelectSeasonBtnTooltip(key32, isShow)
  if true == Panel_Tooltip_SimpleText:GetShow() then
    TooltipSimple_Hide()
    return
  end
  if nil == key32 or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local content = PaGlobal_SeasonReward_All._ui.list2_season:GetContentByKey(key32)
  if nil == content then
    return
  end
  local button = UI.getChildControl(content, "Button_LeftContentBg")
  local buttonText = UI.getChildControl(button, "StaticText_ButtonText")
  local name = buttonText:GetText()
  local desc = ""
  TooltipSimple_Show(control, name, desc)
end
