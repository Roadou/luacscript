function PaGlobal_Event_TicketShop:initialize()
  if PaGlobal_Event_TicketShop._initialize == true then
    return
  end
  PaGlobal_Event_TicketShop._isConsole = _ContentsGroup_UsePadSnapping
  local titleControl = UI.getChildControl(Panel_Event_TicketShop, "Static_TitleArea")
  PaGlobal_Event_TicketShop._ui._btn_close = UI.getChildControl(titleControl, "Button_Close")
  PaGlobal_Event_TicketShop._ui._btn_refresh = UI.getChildControl(titleControl, "Button_Refresh")
  PaGlobal_Event_TicketShop._ui._stc_keyGuide = UI.getChildControl(Panel_Event_TicketShop, "Static_KeyGuide_ConsoleUI")
  local mainBG = UI.getChildControl(Panel_Event_TicketShop, "Static_MainBG")
  local ticketBG = UI.getChildControl(mainBG, "Static_Ticket_BG")
  PaGlobal_Event_TicketShop._ui._txt_coinCount = UI.getChildControl(ticketBG, "StaticText_MyTicket_Value")
  PaGlobal_Event_TicketShop._ui._txt_loseCoinCount = UI.getChildControl(ticketBG, "StaticText_ExchangeTicket_Value")
  PaGlobal_Event_TicketShop._ui._stc_coinIcon = UI.getChildControl(ticketBG, "Static_Myticket_Icon")
  PaGlobal_Event_TicketShop._ui._stc_loseCoinIcon = UI.getChildControl(ticketBG, "Static_ExchangeTicket_Icon")
  PaGlobal_Event_TicketShop._ui._btn_detailLink = UI.getChildControl(ticketBG, "Button_DetailLink")
  PaGlobal_Event_TicketShop._ui._list2_drawItemList = UI.getChildControl(Panel_Event_TicketShop, "List2_Quest")
  local list2Content = UI.getChildControl(PaGlobal_Event_TicketShop._ui._list2_drawItemList, "List2_1_Content")
  for ii = 0, 2 do
    local drawSlot = UI.getChildControl(list2Content, "Static_Product_BG" .. ii)
    local drawItemSlotBG = UI.getChildControl(drawSlot, "Static_ItemIcon_BG")
    local drawItemSlot = UI.getChildControl(drawItemSlotBG, "Static_IconSlot")
    local slot = {}
    SlotItem.new(slot, "ItemSlot", 0, drawItemSlotBG, PaGlobal_Event_TicketShop._slotConfig)
    slot:createChild()
    slot.empty = true
    slot:clearItem()
    slot.icon:SetPosX(drawItemSlot:GetSizeX() / 2)
    slot.icon:SetPosY(drawItemSlot:GetSizeY() / 2)
    slot.icon:SetSize(drawItemSlot:GetSizeX(), drawItemSlot:GetSizeY())
  end
  PaGlobal_Event_TicketShop._ui._stc_unboxingBG = UI.getChildControl(Panel_Event_TicketShop_Unboxing, "Static_MainBG")
  PaGlobal_Event_TicketShop._ui._stc_unboxingBox = UI.getChildControl(Panel_Event_TicketShop_Unboxing, "Static_EffectShape_BG")
  PaGlobal_Event_TicketShop._ui._stc_unboxingBombEffect = UI.getChildControl(Panel_Event_TicketShop_Unboxing, "Static_Effect")
  PaGlobal_Event_TicketShop._ui._stc_unboxingResult = UI.getChildControl(Panel_Event_TicketShop_Unboxing, "Panel_Event_Unboxing_Confirm")
  Panel_Event_TicketShop_Unboxing:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Event_TicketShop_Unboxing:SetPosXY(0, 0)
  PaGlobal_Event_TicketShop._ui._stc_unboxingBG:ComputePos()
  PaGlobal_Event_TicketShop._ui._stc_unboxingBox:ComputePos()
  PaGlobal_Event_TicketShop._ui._stc_unboxingBombEffect:ComputePos()
  PaGlobal_Event_TicketShop._ui._stc_unboxingResult:ComputePos()
  PaGlobal_Event_TicketShop._ui._stc_unboxingResultItemSlot = UI.getChildControl(PaGlobal_Event_TicketShop._ui._stc_unboxingResult, "Static_ItemSlot")
  PaGlobal_Event_TicketShop._ui._stc_unboxingResultItemName = UI.getChildControl(PaGlobal_Event_TicketShop._ui._stc_unboxingResult, "MultilineText_ItemName")
  PaGlobal_Event_TicketShop._ui._btn_unboxingResultItem = UI.getChildControl(PaGlobal_Event_TicketShop._ui._stc_unboxingResult, "Button_Confirm")
  PaGlobal_Event_TicketShop:registEventHandler()
  PaGlobal_Event_TicketShop:validate()
  local resultItemSlot = {}
  SlotItem.new(resultItemSlot, "ItemSlot", 0, PaGlobal_Event_TicketShop._ui._stc_unboxingResultItemSlot, PaGlobal_Event_TicketShop._slotConfig)
  resultItemSlot:createChild()
  resultItemSlot.empty = true
  resultItemSlot:clearItem()
  resultItemSlot.icon:SetSize(PaGlobal_Event_TicketShop._ui._stc_unboxingResultItemSlot:GetSizeX(), PaGlobal_Event_TicketShop._ui._stc_unboxingResultItemSlot:GetSizeY())
  PaGlobal_Event_TicketShop:initKeyGuide()
  PaGlobal_Event_TicketShop._initialize = true
end
function PaGlobal_Event_TicketShop:initKeyGuide()
  if PaGlobal_Event_TicketShop._isConsole == false then
    return
  end
  PaGlobal_Event_TicketShop._ui._stc_keyGuide:SetShow(PaGlobal_Event_TicketShop._isConsole == true)
  local consoleButton = {}
  consoleButton[1] = UI.getChildControl(PaGlobal_Event_TicketShop._ui._stc_keyGuide, "StaticText_B_ConsoleUI")
  consoleButton[2] = UI.getChildControl(PaGlobal_Event_TicketShop._ui._stc_keyGuide, "StaticText_A_ConsoleUI")
  consoleButton[3] = UI.getChildControl(PaGlobal_Event_TicketShop._ui._stc_keyGuide, "StaticText_X_ConsoleUI")
  consoleButton[4] = UI.getChildControl(PaGlobal_Event_TicketShop._ui._stc_keyGuide, "StaticText_Y_ConsoleUI")
  local guildBGSize = PaGlobal_Event_TicketShop._ui._stc_keyGuide:GetSizeX()
  local padding = 10
  for jj = 1, 4 do
    local length = consoleButton[jj]:GetSizeX() + consoleButton[jj]:GetTextSizeX()
    if jj == 1 then
      consoleButton[jj]:SetPosX(guildBGSize - length - padding)
    else
      consoleButton[jj]:SetPosX(consoleButton[jj - 1]:GetPosX() - length - padding)
    end
  end
end
function PaGlobal_Event_TicketShop:registEventHandler()
  if Panel_Event_TicketShop == nil then
    return
  end
  PaGlobal_Event_TicketShop._ui._list2_drawItemList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_Event_TicketShop_CreateDrawItemList2")
  PaGlobal_Event_TicketShop._ui._list2_drawItemList:createChildContent(__ePAUIList2ElementManagerType_List)
  if PaGlobal_Event_TicketShop._isConsole == true then
    Panel_Event_TicketShop:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Event_TicketShop_Refresh()")
    Panel_Event_TicketShop:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_PaGlobal_Event_TicketShop_ShowItemTooltip()")
    PaGlobal_Event_TicketShop._ui._btn_detailLink:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_Event_TicketShop_OpenDetailLink()")
    PaGlobal_Event_TicketShop._ui._stc_coinIcon:addInputEvent("Mouse_On", "PaGlobal_Event_TicketShop_SetFocusIndex(-1)")
    PaGlobal_Event_TicketShop._ui._stc_loseCoinIcon:addInputEvent("Mouse_On", "PaGlobal_Event_TicketShop_SetFocusIndex(-2)")
  else
    PaGlobal_Event_TicketShop._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Event_TicketShop_Close()")
    PaGlobal_Event_TicketShop._ui._btn_refresh:addInputEvent("Mouse_LUp", "HandleEventLUp_Event_TicketShop_Refresh()")
    PaGlobal_Event_TicketShop._ui._stc_coinIcon:addInputEvent("Mouse_On", "HandleEventOnOut_PaGlobal_Event_TicketShop_EnableCoinTooltip(true, true)")
    PaGlobal_Event_TicketShop._ui._stc_coinIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_PaGlobal_Event_TicketShop_EnableCoinTooltip(0, false)")
    PaGlobal_Event_TicketShop._ui._stc_loseCoinIcon:addInputEvent("Mouse_On", "HandleEventOnOut_PaGlobal_Event_TicketShop_EnableCoinTooltip(false, true)")
    PaGlobal_Event_TicketShop._ui._stc_loseCoinIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_PaGlobal_Event_TicketShop_EnableCoinTooltip(0, false)")
  end
  PaGlobal_Event_TicketShop._ui._stc_unboxingBox:addInputEvent("Mouse_LUp", "PaGlobal_Event_TicketShop_DrawConfirm()")
  Panel_Event_TicketShop_Unboxing:addInputEvent("Mouse_LUp", "PaGlobal_Event_TicketShop_DrawConfirm()")
  PaGlobal_Event_TicketShop._ui._btn_unboxingResultItem:addInputEvent("Mouse_LUp", "PaGlobal_Event_TicketShop_Unboxing_Result_Close()")
  PaGlobal_Event_TicketShop._ui._btn_close:SetShow(PaGlobal_Event_TicketShop._isConsole == false)
  PaGlobal_Event_TicketShop._ui._btn_refresh:SetShow(PaGlobal_Event_TicketShop._isConsole == false)
  PaGlobal_Event_TicketShop._ui._stc_keyGuide:SetShow(PaGlobal_Event_TicketShop._isConsole == true)
  registerEvent("FromClient_OpenDrawEventShop", "PaGlobal_Event_TicketShop_Open")
  registerEvent("FromClient_OpenDrawEventResult", "PaGlobal_Event_TicketShop_Unboxing_Result_Open")
  Panel_Event_TicketShop_Unboxing:RegisterShowEventFunc(true, "PaGlobal_Event_TicketShop_Unboxing_ShowAni()")
  PaGlobal_Event_TicketShop._ui._btn_detailLink:addInputEvent("Mouse_LUp", "PaGlobal_Event_TicketShop_OpenDetailLink()")
end
function PaGlobal_Event_TicketShop:prepareOpen()
  if Panel_Event_TicketShop == nil then
    return
  end
  PaGlobal_Event_TicketShop:createDrawItemList()
  if PaGlobal_Event_TicketShop._isConsole == true then
    PaGlobal_Event_TicketShop._ui._btn_unboxingResultItem:SetText(PAGetString(Defines.StringSheet_RESOURCE, "DIALOG_ITEMTAKE_BTN_YES"))
  end
  PaGlobal_Event_TicketShop._ui._txt_coinCount:SetText(ToClient_GetDrawCoinCount())
  PaGlobal_Event_TicketShop._ui._txt_loseCoinCount:SetText(ToClient_GetDrawLoseCoinCount())
  PaGlobal_Event_TicketShop:open()
end
function PaGlobal_Event_TicketShop:open()
  if _ContentsGroup_drawEvent == false then
    return
  end
  if Panel_Event_TicketShop == nil then
    return
  end
  Panel_Event_TicketShop:SetShow(true)
end
function PaGlobal_Event_TicketShop:prepareClose()
  if Panel_Event_TicketShop == nil then
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_hideTooltip()
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
  PaGlobal_Event_TicketShop:close()
end
function PaGlobal_Event_TicketShop:close()
  if _ContentsGroup_drawEvent == false then
    return
  end
  if Panel_Event_TicketShop == nil then
    return
  end
  Panel_Event_TicketShop:SetShow(false)
end
function PaGlobal_Event_TicketShop:prepareOpenUnboxing()
  if _ContentsGroup_drawEvent == false then
    return
  end
  if Panel_Event_TicketShop_Unboxing == nil then
    return
  end
  PaGlobal_Event_TicketShop._ui._stc_unboxingBG:SetShow(false)
  PaGlobal_Event_TicketShop._ui._stc_unboxingBox:SetShow(false)
  PaGlobal_Event_TicketShop._ui._stc_unboxingBombEffect:SetShow(false)
  PaGlobal_Event_TicketShop._ui._stc_unboxingResult:SetShow(false)
  PaGlobal_Event_TicketShop._isRequest = false
  PaGlobal_Event_TicketShop._isShowEffect = false
  PaGlobal_Event_TicketShop._isShowResultEffect = false
  PaGlobal_Event_TicketShop._animationTimeStamp = 0
  PaGlobal_Event_TicketShop._animationResultTimeStamp = 0
  PaGlobal_Event_TicketShop._ui._stc_unboxingBox:EraseAllEffect()
  Panel_Event_TicketShop_Unboxing:RegisterUpdateFunc("PaGlobal_Event_TicketShop_PerFrame")
  Panel_Event_TicketShop_Unboxing:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Event_TicketShop_Unboxing:SetPosXY(0, 0)
  PaGlobal_Event_TicketShop._ui._stc_unboxingBG:ComputePos()
  PaGlobal_Event_TicketShop._ui._stc_unboxingBox:ComputePos()
  PaGlobal_Event_TicketShop._ui._stc_unboxingBombEffect:ComputePos()
  PaGlobal_Event_TicketShop._ui._stc_unboxingResult:ComputePos()
  PaGlobal_Event_TicketShop:openUnboxing()
  PaGlobal_Event_TicketShop._ui._stc_unboxingBox:SetIgnore(false)
  SetUIMode(Defines.UIMode.eUIMode_DrawEvent)
  PaGlobal_Event_TicketShop_DrawConfirm()
end
function PaGlobal_Event_TicketShop:openUnboxing()
  if _ContentsGroup_drawEvent == false then
    return
  end
  if Panel_Event_TicketShop_Unboxing == nil then
    return
  end
  Panel_Event_TicketShop_Unboxing:SetShow(true, true)
end
function PaGlobal_Event_TicketShop:prepareCloseUnboxing()
  if _ContentsGroup_drawEvent == false then
    return
  end
  if Panel_Event_TicketShop_Unboxing == nil then
    return
  end
  SetUIMode(Defines.UIMode.eUIMode_Default)
  Panel_Event_TicketShop_Unboxing:ClearUpdateLuaFunc()
  PaGlobal_Event_TicketShop:closeUnboxing()
end
function PaGlobal_Event_TicketShop:closeUnboxing()
  if _ContentsGroup_drawEvent == false then
    return
  end
  if Panel_Event_TicketShop_Unboxing == nil then
    return
  end
  Panel_Event_TicketShop_Unboxing:SetShow(false)
  ToClient_padSnapResetPanelControl(Panel_Event_TicketShop)
  PaGlobal_Event_TicketShop:stopOpeningAudio()
end
function PaGlobal_Event_TicketShop:prepareOpenUnboxingResult(drawIndex, isWin)
  if _ContentsGroup_drawEvent == false then
    return
  end
  if Panel_Event_TicketShop_Unboxing == nil then
    return
  end
  local drawStaticStatusWrapper = getDrawItemStaticStatus(drawIndex)
  if drawStaticStatusWrapper == nil then
    return
  end
  local itemSSW
  local itemKey = 0
  local itemCount = 0
  if isWin == true then
    itemSSW = getItemEnchantStaticStatus(drawStaticStatusWrapper:getItemkey())
    itemKey = drawStaticStatusWrapper:getItemkey()
    itemCount = drawStaticStatusWrapper:getItemCount()
  else
    itemSSW = getItemEnchantStaticStatus(drawStaticStatusWrapper:getLoseItemKey())
    itemKey = drawStaticStatusWrapper:getLoseItemKey()
    itemCount = drawStaticStatusWrapper:getLoseCoinCount()
  end
  if itemSSW == nil then
    return
  end
  local itemIconSlot = {}
  SlotItem.reInclude(itemIconSlot, "ItemSlot", 0, PaGlobal_Event_TicketShop._ui._stc_unboxingResultItemSlot, PaGlobal_Event_TicketShop._slotConfig)
  itemIconSlot:clearItem()
  PaGlobal_Event_TicketShop._ui._stc_unboxingResultItemName:SetText(FGlobal_ChangeItemNameColorByGrade(itemKey))
  itemIconSlot:setItemByStaticStatus(itemSSW, itemCount)
  PaGlobal_Event_TicketShop._ui._stc_unboxingBox:SetIgnore(true)
  PaGlobal_Event_TicketShop:openUnboxingResult()
end
function PaGlobal_Event_TicketShop:openUnboxingResult()
  if _ContentsGroup_drawEvent == false then
    return
  end
  if Panel_Event_TicketShop_Unboxing == nil then
    return
  end
  audioPostEvent_SystemUi(5, 95)
  _AudioPostEvent_SystemUiForXBOX(5, 95)
  PaGlobal_Event_TicketShop._ui._stc_unboxingResult:SetShow(true)
end
function PaGlobal_Event_TicketShop:prepareCloseUnboxingResult()
  if _ContentsGroup_drawEvent == false then
    return
  end
  if Panel_Event_TicketShop_Unboxing == nil then
    return
  end
  SetUIMode(Defines.UIMode.eUIMode_Default)
  PaGlobal_Event_TicketShop:closeUnboxingResult()
end
function PaGlobal_Event_TicketShop:closeUnboxingResult()
  if _ContentsGroup_drawEvent == false then
    return
  end
  if Panel_Event_TicketShop_Unboxing == nil then
    return
  end
  PaGlobal_Event_TicketShop_Unboxing_Close()
  PaGlobal_Event_TicketShop._ui._stc_unboxingResult:SetShow(false)
end
function PaGlobal_Event_TicketShop:update()
  if Panel_Event_TicketShop == nil then
    return
  end
end
function PaGlobal_Event_TicketShop:validate()
  if Panel_Event_TicketShop == nil then
    return
  end
  PaGlobal_Event_TicketShop._ui._btn_close:isValidate()
  PaGlobal_Event_TicketShop._ui._btn_refresh:isValidate()
  PaGlobal_Event_TicketShop._ui._stc_keyGuide:isValidate()
  PaGlobal_Event_TicketShop._ui._txt_coinCount:isValidate()
  PaGlobal_Event_TicketShop._ui._txt_loseCoinCount:isValidate()
  PaGlobal_Event_TicketShop._ui._list2_drawItemList:isValidate()
  PaGlobal_Event_TicketShop._ui._stc_unboxingBG:isValidate()
  PaGlobal_Event_TicketShop._ui._stc_unboxingBox:isValidate()
  PaGlobal_Event_TicketShop._ui._stc_unboxingBombEffect:isValidate()
  PaGlobal_Event_TicketShop._ui._stc_unboxingResult:isValidate()
  PaGlobal_Event_TicketShop._ui._stc_unboxingResultItemSlot:isValidate()
  PaGlobal_Event_TicketShop._ui._stc_unboxingResultItemName:isValidate()
  PaGlobal_Event_TicketShop._ui._btn_unboxingResultItem:isValidate()
end
function PaGlobal_Event_TicketShop:getScrollValue()
  local toIndex = PaGlobal_Event_TicketShop._ui._list2_drawItemList:getCurrenttoIndex()
  local scrollValue = 0
  local lastTopIndex = 0
  if toIndex ~= 0 then
    lastTopIndex = toIndex
    scrollValue = PaGlobal_Event_TicketShop._ui._list2_drawItemList:GetVScroll():GetControlPos()
  end
  return lastTopIndex, scrollValue
end
function PaGlobal_Event_TicketShop:setScrollValue(topIndex, scrollValue)
  PaGlobal_Event_TicketShop._ui._list2_drawItemList:setCurrenttoIndex(topIndex)
  PaGlobal_Event_TicketShop._ui._list2_drawItemList:GetVScroll():SetControlPos(scrollValue)
end
function PaGlobal_Event_TicketShop:createDrawItemList()
  if Panel_Event_TicketShop == nil then
    return
  end
  local drawItemCount = ToClient_GetDrawItemCount()
  local lastTopIndex, scrollValue = PaGlobal_Event_TicketShop:getScrollValue()
  PaGlobal_Event_TicketShop._ui._list2_drawItemList:getElementManager():clearKey()
  if drawItemCount > 0 then
    for ii = 0, drawItemCount - 1 do
      if ii % 3 == 0 then
        PaGlobal_Event_TicketShop._ui._list2_drawItemList:getElementManager():pushKey(ii)
      end
    end
  end
  PaGlobal_Event_TicketShop._ui._list2_drawItemList:ComputePos()
  if Panel_Event_TicketShop:GetShow() == true then
    PaGlobal_Event_TicketShop:setScrollValue(lastTopIndex, scrollValue)
  end
end
function PaGlobal_Event_TicketShop:setFocusIndex(drawOrderNo)
  if Panel_Event_TicketShop == nil then
    return
  end
  if PaGlobal_Event_TicketShop == nil then
    return
  end
  PaGlobal_Event_TicketShop._focusDrawOrderNo = drawOrderNo
end
function PaGlobal_Event_TicketShop:stopOpeningAudio()
  if PaGlobal_Event_TicketShop == nil then
    return
  end
  if PaGlobal_Event_TicketShop._ui._audioPlayingID ~= 0 then
    audioPostEvent_StopAudioByPlayingID(PaGlobal_Event_TicketShop._ui._audioPlayingID, 0)
    PaGlobal_Event_TicketShop._ui._audioPlayingID = 0
  end
  if PaGlobal_Event_TicketShop._ui._audioPlayingIDConsole ~= 0 then
    audioPostEvent_StopAudioByPlayingID(PaGlobal_Event_TicketShop._ui._audioPlayingIDConsole, 0)
    PaGlobal_Event_TicketShop._ui._audioPlayingIDConsole = 0
  end
end
function HandleEventLUp_Event_TicketShop_Refresh()
  if Panel_Event_TicketShop == nil then
    return
  end
  local elepsedTime = getTickCount32() - PaGlobal_Event_TicketShop._refreshTime
  if elepsedTime < PaGlobal_Event_TicketShop._refreshCoolTime then
    local remainSecTime = math.floor((PaGlobal_Event_TicketShop._refreshCoolTime - elepsedTime) / 1000)
    local coolTimeString = PAGetStringParam1(Defines.StringSheet_GAME, "GAME_CONSOLE_REFRESH_MAIL_COOLTIME", "cooltime", remainSecTime)
    Proc_ShowMessage_Ack(coolTimeString)
    return
  end
  PaGlobal_Event_TicketShop._refreshTime = getTickCount32()
  ToClient_RequestOpenDrawEventList()
end
function PaGlobal_Event_TicketShop_SetFocusIndex(drawOrderNo)
  if Panel_Event_TicketShop == nil then
    return
  end
  if PaGlobal_Event_TicketShop == nil then
    return
  end
  PaGlobal_Event_TicketShop:setFocusIndex(drawOrderNo)
end
function PaGlobal_Event_TicketShop_DrawConfirm()
  if Panel_Event_TicketShop == nil then
    return
  end
  if PaGlobal_Event_TicketShop == nil then
    return
  end
  local drawStaticStatusWrapper = getDrawItemStaticStatusByOrderIndex(PaGlobal_Event_TicketShop._focusDrawOrderNo)
  if drawStaticStatusWrapper == nil then
    return
  end
  if PaGlobal_Event_TicketShop._isShowEffect == true then
    if PaGlobal_Event_TicketShop._isShowResultEffect == false then
      PaGlobal_Event_TicketShop._isShowResultEffect = true
      PaGlobal_Event_TicketShop._ui._stc_unboxingBox:EraseAllEffect()
      PaGlobal_Event_TicketShop._ui._stc_unboxingBox:AddEffect("fUI_Valentaine_Event_02A", false, 0, 0)
      PaGlobal_Event_TicketShop:stopOpeningAudio()
      audioPostEvent_SystemUi(5, 94)
      _AudioPostEvent_SystemUiForXBOX(5, 94)
    end
    return
  end
  PaGlobal_Event_TicketShop._isShowEffect = false
  PaGlobal_Event_TicketShop._isShowResultEffect = true
  PaGlobal_Event_TicketShop._ui._stc_unboxingBox:EraseAllEffect()
  PaGlobal_Event_TicketShop._ui._stc_unboxingBox:AddEffect("fUI_Valentaine_Event_01A", true, 0, 0)
  PaGlobal_Event_TicketShop._ui._audioPlayingID = audioPostEvent_SystemUi(5, 93)
  PaGlobal_Event_TicketShop._ui._audioPlayingIDConsole = _AudioPostEvent_SystemUiForXBOX(5, 93)
end
function PaGlobal_Event_TicketShop_Unboxing_ShowAni()
  Panel_Event_TicketShop_Unboxing:ResetVertexAni()
  local aniInfo = Panel_Event_TicketShop_Unboxing:addColorAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  aniInfo:SetStartColorBySafe(PAUIColorType(0, 255, 255, 255))
  aniInfo:SetEndColorBySafe(PAUIColorType(Panel_Event_TicketShop_Unboxing:GetAlpha() * 255, 255, 255, 255))
  PaGlobal_Event_TicketShop._ui._stc_unboxingBG:ResetVertexAni()
  local childAniInfo1 = PaGlobal_Event_TicketShop._ui._stc_unboxingBG:addColorAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  childAniInfo1:SetStartColorBySafe(PAUIColorType(0, 255, 255, 255))
  childAniInfo1:SetEndColorBySafe(PAUIColorType(PaGlobal_Event_TicketShop._ui._stc_unboxingBG:GetAlpha() * 255, 255, 255, 255))
  PaGlobal_Event_TicketShop._ui._stc_unboxingBox:ResetVertexAni()
  local childAniInfo = PaGlobal_Event_TicketShop._ui._stc_unboxingBox:addColorAnimation(0, 0.4, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  childAniInfo:SetStartColorBySafe(PAUIColorType(0, 255, 255, 255))
  childAniInfo:SetEndColorBySafe(PAUIColorType(PaGlobal_Event_TicketShop._ui._stc_unboxingBox:GetAlpha() * 255, 255, 255, 255))
end
function PaGlobal_Event_TicketShop_PerFrame(deltaTime)
  if PaGlobal_Event_TicketShop._isShowEffect == true then
    PaGlobal_Event_TicketShop._animationTimeStamp = PaGlobal_Event_TicketShop._animationTimeStamp + deltaTime
    if PaGlobal_Event_TicketShop._effectTimeDraw <= PaGlobal_Event_TicketShop._animationTimeStamp and PaGlobal_Event_TicketShop._isShowResultEffect == false then
      PaGlobal_Event_TicketShop._isShowResultEffect = true
      PaGlobal_Event_TicketShop._ui._stc_unboxingBox:EraseAllEffect()
      PaGlobal_Event_TicketShop._ui._stc_unboxingBox:AddEffect("fUI_Valentaine_Event_02A", false, 0, 0)
      audioPostEvent_SystemUi(5, 94)
      _AudioPostEvent_SystemUiForXBOX(5, 94)
      return
    end
  end
  if PaGlobal_Event_TicketShop._isShowResultEffect == true then
    PaGlobal_Event_TicketShop._animationResultTimeStamp = PaGlobal_Event_TicketShop._animationResultTimeStamp + deltaTime
    if PaGlobal_Event_TicketShop._effectTimeResult <= PaGlobal_Event_TicketShop._animationResultTimeStamp and PaGlobal_Event_TicketShop._isRequest == false then
      local drawStaticStatusWrapper = getDrawItemStaticStatusByOrderIndex(PaGlobal_Event_TicketShop._focusDrawOrderNo)
      if drawStaticStatusWrapper == nil then
        return
      end
      PaGlobal_Event_TicketShop._isRequest = true
      ToClient_RequestDrawItem(drawStaticStatusWrapper:getIndex())
      return
    end
  end
end
function PaGlobal_Event_TicketShop_CreateDrawItemList2(content, index)
  if Panel_Event_TicketShop == nil then
    return
  end
  local index32 = Int64toInt32(index)
  for ii = index32, index32 + 2 do
    local drawStaticStatusWrapper = getDrawItemStaticStatusByOrderIndex(ii)
    local slot = UI.getChildControl(content, "Static_Product_BG" .. ii % 3)
    if drawStaticStatusWrapper == nil then
      slot:SetShow(false)
    else
      slot:SetShow(true)
      local specialBG = UI.getChildControl(slot, "Static_Special_BG")
      local soldOutBG = UI.getChildControl(slot, "Static_Soldout_BG")
      local needCoinCountText = UI.getChildControl(slot, "StaticText_NeedTicket")
      local itemNameText = UI.getChildControl(slot, "MultilineText_ItemName")
      local itemCountText = UI.getChildControl(slot, "StaticText_Desc")
      local exchangeBTN = UI.getChildControl(slot, "Button_Exchange")
      local soldOutBTN = UI.getChildControl(slot, "StaticText_Btn_Soldout")
      local itemIconBG = UI.getChildControl(slot, "Static_ItemIcon_BG")
      local itemSpecialIconBG = UI.getChildControl(slot, "Static_ItemIcon_SpecialBG")
      local itemIconSlot = {}
      SlotItem.reInclude(itemIconSlot, "ItemSlot", 0, itemIconBG, PaGlobal_Event_TicketShop._slotConfig)
      itemIconSlot:clearItem()
      needCoinCountText:SetText(drawStaticStatusWrapper:getCoinCount())
      local itemCount = drawStaticStatusWrapper:getDrawMaxCount() - drawStaticStatusWrapper:getDrawMinCount()
      if itemCount < 0 then
        itemCount = 0
      end
      itemCountText:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "NPCSHOP_REMAIN_COUNT2", "count", itemCount, "maxCount", drawStaticStatusWrapper:getDrawMaxCount()))
      itemCountText:SetShow(true)
      soldOutBG:SetShow(itemCount <= 0)
      soldOutBTN:SetShow(itemCount <= 0)
      exchangeBTN:SetShow(itemCount > 0)
      specialBG:SetShow(drawStaticStatusWrapper:getIsSpecialItem())
      if drawStaticStatusWrapper:getIsSpecialItem() == true then
        itemSpecialIconBG:SetShow(true)
      else
        itemSpecialIconBG:SetShow(false)
      end
      local itemStaticStatusWrapper = getItemEnchantStaticStatus(drawStaticStatusWrapper:getItemkey())
      if itemStaticStatusWrapper ~= nil then
        itemNameText:SetTextMode(__eTextMode_Limit_AutoWrap)
        itemNameText:setLineCountByLimitAutoWrap(2)
        itemNameText:SetText(FGlobal_ChangeItemNameColorByGrade(drawStaticStatusWrapper:getItemkey()))
        itemIconSlot:setItemByStaticStatus(itemStaticStatusWrapper, drawStaticStatusWrapper:getItemCount())
        itemIconSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_PaGlobal_Event_TicketShop_EnableItemTooltip(" .. ii .. ", true)")
        itemIconSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_PaGlobal_Event_TicketShop_EnableItemTooltip(0, false)")
      end
      exchangeBTN:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_Event_TicketShop_Draw(" .. ii .. ")")
      if PaGlobal_Event_TicketShop._isConsole == true then
        exchangeBTN:addInputEvent("Mouse_On", "PaGlobal_Event_TicketShop_SetFocusIndex(" .. ii .. ")")
        if false == _ContentsGroup_RenewUI_Tooltip then
          exchangeBTN:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
        else
          exchangeBTN:addInputEvent("Mouse_Out", "PaGlobalFunc_TooltipInfo_Close()")
        end
      end
    end
  end
end
