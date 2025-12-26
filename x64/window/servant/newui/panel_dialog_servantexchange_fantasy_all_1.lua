function PaGlobal_ServantExchange_Fantasy_All:initialize()
  if nil == Panel_Dialog_ServantExchange_Fantasy_All or true == self._initailize then
    return
  end
  self._ui._stc_Title = UI.getChildControl(Panel_Dialog_ServantExchange_Fantasy_All, "Static_Title")
  self._ui._txt_Title = UI.getChildControl(self._ui._stc_Title, "StaticText_Title")
  self._ui._btn_Question_PC = UI.getChildControl(self._ui._stc_Title, "Button_Question")
  self._ui._btn_Close_PC = UI.getChildControl(self._ui._stc_Title, "Button_Close")
  self._ui._btn_Exchange_PC = UI.getChildControl(Panel_Dialog_ServantExchange_Fantasy_All, "Button_Exchange")
  self._ui._stc_Bg = UI.getChildControl(Panel_Dialog_ServantExchange_Fantasy_All, "Static_Bg")
  self._ui._stc_Exchange_Bg = UI.getChildControl(Panel_Dialog_ServantExchange_Fantasy_All, "Static_ExchangeBg")
  self._ui._txt_TopDesc = UI.getChildControl(self._ui._stc_Exchange_Bg, "StaticText_TopDesc")
  self._ui._txt_RateCount = UI.getChildControl(self._ui._stc_Exchange_Bg, "StaticText_RateCount")
  self._ui._txt_StackCount = UI.getChildControl(self._ui._stc_Exchange_Bg, "StaticText_Stack")
  self._ui._txt_ItemCount = UI.getChildControl(self._ui._stc_Exchange_Bg, "StaticText_ItemCount")
  self._ui._stc_ItemSlotBg = UI.getChildControl(self._ui._stc_Exchange_Bg, "Static_ItemSlotBG")
  self._ui._stc_ItemIcon = UI.getChildControl(self._ui._stc_ItemSlotBg, "Static_ItemIcon")
  self._ui._stc_LeftBg = UI.getChildControl(self._ui._stc_Exchange_Bg, "Static_LeftBg")
  self._ui._btn_LeftSelect = UI.getChildControl(self._ui._stc_LeftBg, "Button_Select")
  self._ui._btn_LeftChange = UI.getChildControl(self._ui._stc_LeftBg, "Button_Change")
  self._ui._stc_LeftPlus = UI.getChildControl(self._ui._btn_LeftSelect, "Static_Plus")
  self._ui._stc_LeftMale = UI.getChildControl(self._ui._btn_LeftSelect, "Static_Male")
  self._ui._stc_LeftImage = UI.getChildControl(self._ui._stc_LeftBg, "Static_Image")
  self._ui._txt_LeftName = UI.getChildControl(self._ui._stc_LeftBg, "StaticText_Name")
  self._ui._stc_LeftGenderIcon = UI.getChildControl(self._ui._stc_LeftBg, "Static_GenderIcon")
  self._ui._stc_RightBg = UI.getChildControl(self._ui._stc_Exchange_Bg, "Static_RightBg")
  self._ui._btn_RightSelect = UI.getChildControl(self._ui._stc_RightBg, "Button_Select")
  self._ui._btn_RightChange = UI.getChildControl(self._ui._stc_RightBg, "Button_Change")
  self._ui._stc_RightPlus = UI.getChildControl(self._ui._btn_RightSelect, "Static_Plus")
  self._ui._stc_RightMale = UI.getChildControl(self._ui._btn_RightSelect, "Static_Female")
  self._ui._stc_RightImage = UI.getChildControl(self._ui._stc_RightBg, "Static_Image")
  self._ui._txt_RightName = UI.getChildControl(self._ui._stc_RightBg, "StaticText_Name")
  self._ui._stc_RightGenderIcon = UI.getChildControl(self._ui._stc_RightBg, "Static_GenderIcon")
  self._ui._edit_Naming = UI.getChildControl(self._ui._stc_Exchange_Bg, "Edit_Naming")
  self._ui._stc_Pencil = UI.getChildControl(self._ui._edit_Naming, "Static_Pencil")
  self._ui._stc_DescBG = UI.getChildControl(Panel_Dialog_ServantExchange_Fantasy_All, "Static_DescBG")
  self._ui._txt_Desc = UI.getChildControl(self._ui._stc_DescBG, "StaticText_1")
  self._ui._stc_Bottom_KeyGuide = UI.getChildControl(Panel_Dialog_ServantExchange_Fantasy_All, "Static_BottomBg_ConsoleUI")
  self._ui._stc_KeyGuide_Y = UI.getChildControl(self._ui._stc_Bottom_KeyGuide, "StaticText_Y_ConsoleUI")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_Bottom_KeyGuide, "StaticText_A_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_Bottom_KeyGuide, "StaticText_B_ConsoleUI")
  self._ui._stc_KeyGuide_X = UI.getChildControl(self._ui._stc_Bottom_KeyGuide, "StaticText_X_ConsoleUI")
  if _ContentsGroup_FantasyUpgradeAutoRegist == false then
    self._ui._btn_LeftChange:SetShow(false)
    self._ui._btn_RightChange:SetShow(false)
    self._ui._txt_RateCount:SetSpanSize(self._ui._txt_RateCount:GetSpanSize().x, 160)
    self._ui._txt_ItemCount:SetShow(false)
    fontWrapper = ToClient_getFontWrapper("RealFont_20_Base")
    if fontWrapper ~= nil then
      self._ui._txt_RateCount:SetFont(fontWrapper:get())
    end
    self._ui._stc_ItemSlotBg:SetSpanSize(0, 187)
  end
  self:validate()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:isConsoleUI(self._isConsole)
  self:setControlData()
  self:registerEventHandler(self._isConsole)
  self._initialize = true
end
function PaGlobal_ServantExchange_Fantasy_All:registerEventHandler(isConsole)
  registerEvent("onScreenResize", "FromClient_ServantExchange_Fantasy_All_OnScreenResize")
  registerEvent("FromClient_ServantFantasyMix", "FromClient_ServantExchange_Fantasy_All_ServantExchangeFinish")
  registerEvent("FromClient_ServantFantasyMixCancle", "FromClient_ServantExchange_Fantasy_All_ServantExchangeCancle")
  registerEvent("FromClient_setFantasyMixNakData", "FromClient_ServantExchange_Fantasy_All_SetFantasyMixNakData")
  self._ui._edit_Naming:SetMaxInput(getGameServiceTypeServantNameLength())
  self._ui._btn_Exchange_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantExchange_Fantasy_All_MixConfirm()")
  self._ui._btn_LeftSelect:addInputEvent("Mouse_LUp", "PaGlobalFunc_Servant_FantasySelect_All_Open(true)")
  self._ui._btn_RightSelect:addInputEvent("Mouse_LUp", "PaGlobalFunc_Servant_FantasySelect_All_Open(false)")
  if _ContentsGroup_FantasyUpgradeAutoRegist == true then
    self._ui._btn_LeftChange:addInputEvent("Mouse_LUp", "PaGlobalFunc_Servant_FantasySelect_All_Open(true)")
    self._ui._btn_RightChange:addInputEvent("Mouse_LUp", "PaGlobalFunc_Servant_FantasySelect_All_Open(false)")
  end
  if false == isConsole then
    self._itemSlot.iconBG:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantExchange_Fantasy_All_NeedItemToolTip(false)")
    self._itemSlot.iconBG:addInputEvent("Mouse_RUp", "PaGlobal_ServantExchange_Fantasy_All:clearNeedItemCount()")
    self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantFunction_All_Close()")
    self._ui._btn_LeftSelect:addInputEvent("Mouse_RUp", "HandleEventRUp_ServantExchange_Fantasy_All_ClearSlot(true)")
    self._ui._btn_RightSelect:addInputEvent("Mouse_RUp", "HandleEventRUp_ServantExchange_Fantasy_All_ClearSlot(false)")
    self._ui._edit_Naming:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantExchange_Fantasy_All_EditClick()")
    self._ui._edit_Naming:RegistReturnKeyEvent("HandleEventLUp_ServantExchange_Fantasy_All_MixConfirm()")
    self._itemSlot.iconBG:addInputEvent("Mouse_On", "HandleEventOnOut_ServantExchange_Fantasy_All_NeedItemToolTip(true)")
    if _ContentsGroup_FantasyUpgradeAutoRegist == false then
      self._itemSlot.iconBG:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantExchange_Fantasy_All_ItemSet_NumPadOn()")
    end
  else
    self._ui._btn_LeftSelect:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_ServantExchange_Fantasy_All_ClearSlot(true)")
    self._ui._btn_RightSelect:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_ServantExchange_Fantasy_All_ClearSlot(false)")
    Panel_Dialog_ServantExchange_Fantasy_All:ignorePadSnapMoveToOtherPanel()
    self._ui._edit_Naming:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_ServantExchange_Fantasy_All_CloseVirtualKeyboard()")
    self._ui._edit_Naming:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_ServantExchange_Fantasy_All_OpenVirtualKeyboard()")
    Panel_Dialog_ServantExchange_Fantasy_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_ServantExchange_Fantasy_All_MixConfirm()")
    self._itemSlot.iconBG:addInputEvent("Mouse_On", "PaGlobal_ServantExchange_Fantasy_All:padKeyAlign(true)")
    self._itemSlot.iconBG:addInputEvent("Mouse_Out", "PaGlobal_ServantExchange_Fantasy_All:padKeyAlign(false)")
    self._ui._stc_ItemSlotBg:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventOnOut_ServantExchange_Fantasy_All_NeedItemToolTip(true)")
    if _ContentsGroup_FantasyUpgradeAutoRegist == false then
      self._ui._stc_ItemSlotBg:registerPadEvent(__eConsoleUIPadEvent_A, "HandleEventLUp_ServantExchange_Fantasy_All_ItemSet_NumPadOn()")
    end
  end
end
function PaGlobal_ServantExchange_Fantasy_All:setControlData()
  local createdSlot = {}
  SlotItem.new(createdSlot, "NeedItemIconSlot", 0, self._ui._stc_ItemIcon, self._slotConfig)
  createdSlot:createChild()
  createdSlot.iconBG = self._ui._stc_ItemIcon
  createdSlot.icon:SetIgnore(true)
  self._itemSlot = createdSlot
  self._ui._txt_TopDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_TopDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HORSE_EXCHANGE_FANTASY_DESC"))
  self._ui._txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_Desc:SetText(self._ui._txt_Desc:GetText())
  if self._ui._txt_Desc:GetSizeY() < self._ui._txt_Desc:GetTextSizeY() then
    local sizeY = self._ui._txt_Desc:GetTextSizeY() - self._ui._txt_Desc:GetSizeY() - 20
    self._ui._txt_Desc:SetSize(self._ui._txt_Desc:GetSizeX(), self._ui._txt_Desc:GetTextSizeY())
    Panel_Dialog_ServantExchange_Fantasy_All:SetSize(Panel_Dialog_ServantExchange_Fantasy_All:GetSizeX(), Panel_Dialog_ServantExchange_Fantasy_All:GetSizeY() + sizeY)
    self._ui._stc_DescBG:SetSize(self._ui._stc_DescBG:GetSizeX(), self._ui._stc_DescBG:GetSizeY() + sizeY)
  end
  Panel_Dialog_ServantExchange_Fantasy_All:ComputePosAllChild()
  PaGlobal_ServantExchange_Fantasy_All:padKeyAlign()
  self._ui._txt_LeftName:SetTextMode(__eTextMode_Limit_AutoWrap)
  self._ui._txt_RightName:SetTextMode(__eTextMode_Limit_AutoWrap)
end
function PaGlobal_ServantExchange_Fantasy_All:padKeyAlign(isShowXKey)
  if true == _ContentsGroup_RenewUI then
    if nil ~= Panel_Widget_Tooltip_Renew and true == Panel_Widget_Tooltip_Renew:GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
    end
  elseif true == _ContentsGroup_UsePadSnapping and true == Panel_Tooltup_Item_isShow() then
    Panel_Tooltip_Item_hideTooltip()
  end
  if isShowXKey ~= nil then
    self._ui._stc_KeyGuide_X:SetShow(isShowXKey)
  end
  local keyguide = {
    self._ui._stc_KeyGuide_Y,
    self._ui._stc_KeyGuide_X,
    self._ui._stc_KeyGuide_A,
    self._ui._stc_KeyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui._stc_Bottom_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_ServantExchange_Fantasy_All:isConsoleUI(isConsole)
  if nil == Panel_Dialog_ServantExchange_Fantasy_All then
    return
  end
  Panel_Dialog_ServantExchange_Fantasy_All:SetDragEnable(not isConsole)
  Panel_Dialog_ServantExchange_Fantasy_All:SetDragAll(not isConsole)
  self._ui._btn_Question_PC:SetShow(not isConsole and false == _ContentsOption_CH_WepHelperControl)
  self._ui._btn_Close_PC:SetShow(not isConsole)
  self._ui._btn_Exchange_PC:SetShow(not isConsole)
  self._ui._stc_Bottom_KeyGuide:SetShow(isConsole)
  self._ui._stc_KeyGuide_X:SetShow(false)
  self._ui._stc_KeyGuide_Y:SetShow(isConsole)
  self._ui._stc_KeyGuide_A:SetShow(isConsole)
  self._ui._stc_KeyGuide_B:SetShow(isConsole)
  if true == isConsole then
    local btnSize = self._ui._btn_Exchange_PC:GetSizeY()
    Panel_Dialog_ServantExchange_Fantasy_All:SetSize(Panel_Dialog_ServantExchange_Fantasy_All:GetSizeX(), Panel_Dialog_ServantExchange_Fantasy_All:GetSizeY() - (btnSize + 10))
    self._ui._stc_Bg:SetSize(self._ui._stc_Bg:GetSizeX(), self._ui._stc_Bg:GetSizeY() - (btnSize + 10))
    self._ui._stc_ItemSlotBg:SetSpanSize(self._ui._stc_ItemSlotBg:GetSpanSize().x, self._ui._stc_ItemSlotBg:GetSpanSize().y - 21)
    self._ui._edit_Naming:SetSpanSize(self._ui._edit_Naming:GetSpanSize().x, self._ui._edit_Naming:GetSpanSize().y - 21)
    self._ui._stc_LeftBg:SetSize(self._ui._stc_LeftBg:GetSizeX(), self._ui._stc_LeftBg:GetSizeY() - (btnSize + 5))
    self._ui._stc_RightBg:SetSize(self._ui._stc_RightBg:GetSizeX(), self._ui._stc_RightBg:GetSizeY() - (btnSize + 5))
    self._ui._btn_LeftSelect:SetSize(self._ui._btn_LeftSelect:GetSizeX(), self._ui._btn_LeftSelect:GetSizeY() - (btnSize + 5))
    self._ui._btn_RightSelect:SetSize(self._ui._btn_RightSelect:GetSizeX(), self._ui._btn_RightSelect:GetSizeY() - (btnSize + 5))
    Panel_Dialog_ServantExchange_Fantasy_All:ComputePosAllChild()
    PaGlobal_ServantExchange_Fantasy_All:padKeyAlign()
  end
  if true == _ContentsOption_CH_Help then
    self._ui._btn_Question_PC:SetShow(false)
  end
end
function PaGlobal_ServantExchange_Fantasy_All:clear()
  self._isFantasyMixDoing = false
  self._elapsedTime = 0
  self._effectType = 0
  self._servantNo_Result = nil
  self._resultCharacterKey = nil
  self:clearNeedItemCount()
  self._fantasyMixNakData._setData = false
  self._fantasyMixNakData._notifyType = nil
  self._fantasyMixNakData._playerName = nil
  self._fantasyMixNakData._fromName = nil
  self._fantasyMixNakData._iconPath = nil
  self._fantasyMixNakData._param1 = nil
  if nil ~= Panel_Dialog_ServantExchange_Fantasy_All then
    Panel_Dialog_ServantList_All:ClearUpdateLuaFunc()
  end
  if nil ~= PaGlobalFunc_ServantSwiftResult_All_EffectErase then
    PaGlobalFunc_ServantSwiftResult_All_EffectErase()
  end
  if nil ~= PaGlobalFunc_ServantSwiftResult_All_EffectClose then
    PaGlobalFunc_ServantSwiftResult_All_EffectClose()
  end
  if _ContentsGroup_FantasyUpgradeAutoRegist == false then
    self._servantNo_Left = nil
    self._servantNo_Right = nil
  else
    self:clearEditName()
  end
end
function PaGlobal_ServantExchange_Fantasy_All:prepareOpen()
  if nil == Panel_Dialog_ServantExchange_Fantasy_All or true == Panel_Dialog_ServantExchange_Fantasy_All:GetShow() then
    return
  end
  if false == _ContentsGroup_ServantFantasyMix then
    return
  end
  FromClient_ServantExchange_Fantasy_All_OnScreenResize()
  if nil ~= PaGlobalFunc_ServantFunction_All_TempOnOff then
    PaGlobalFunc_ServantFunction_All_TempOnOff(false)
  end
  self:clear()
  self:open()
  self:update()
end
function PaGlobal_ServantExchange_Fantasy_All:open()
  if nil == Panel_Dialog_ServantExchange_Fantasy_All or true == Panel_Dialog_ServantExchange_Fantasy_All:GetShow() then
    return
  end
  if false == _ContentsGroup_ServantFantasyMix then
    return
  end
  Panel_Dialog_ServantExchange_Fantasy_All:SetShow(true)
end
function PaGlobal_ServantExchange_Fantasy_All:prepareClose()
  if nil == Panel_Dialog_ServantExchange_Fantasy_All then
    return
  end
  if true == self._isConsole then
    ToClient_padSnapSetTargetPanel(Panel_Dialog_ServantList_All)
  end
  if nil ~= PaGlobalFunc_ServantFunction_All_TempOnOff then
    PaGlobalFunc_ServantFunction_All_TempOnOff(true)
  end
  self:clear()
  self:close()
end
function PaGlobal_ServantExchange_Fantasy_All:close()
  if nil == Panel_Dialog_ServantExchange_Fantasy_All or false == Panel_Dialog_ServantExchange_Fantasy_All:GetShow() then
    return
  end
  Panel_Dialog_ServantExchange_Fantasy_All:SetShow(false)
end
function PaGlobal_ServantExchange_Fantasy_All:update()
  self:matingUpdate()
  if _ContentsGroup_FantasyUpgradeAutoRegist == true then
    self:needItemUpdate()
  end
  self:exchangeStateUpdate()
  self:stackCountUpdate()
end
function PaGlobal_ServantExchange_Fantasy_All:clearNeedItemCount()
  if false == _ContentsGroup_ServantFantasyMix then
    return
  end
  if true == self._isFantasyMixDoing then
    return
  end
  local itemWrapper = ToClient_getFantasyMixNeedItem()
  if nil == itemWrapper then
    return
  end
  self._ui._stc_ItemIcon:SetMonoTone(true, true)
  self._ui._btn_Exchange_PC:SetMonoTone(true, true)
  self._ui._btn_Exchange_PC:SetIgnore(true)
  self._needItemInfo._needItemSlotNo = __eTInventorySlotNoUndefined
  self._needItemInfo._needItemCount = 0
  self._itemSlot:setItemByStaticStatus(itemWrapper, toInt64(0, self._needItemInfo._needItemCount))
  self._itemSlot.icon:SetMonoTone(true, true)
  self._itemSlot.iconBG:removeInputEvent("Mouse_RUp")
  self:exchangeStateUpdate()
end
function PaGlobal_ServantExchange_Fantasy_All:matingUpdate()
  if nil == Panel_Dialog_ServantExchange_Fantasy_All or false == Panel_Dialog_ServantExchange_Fantasy_All:GetShow() then
    return
  end
  if true == self._isFantasyMixDoing then
    return
  end
  local servantInfo_Left, servantInfo_Right
  if nil ~= self._servantNo_Left then
    servantInfo_Left = stable_getServantByServantNo(self._servantNo_Left)
  end
  if nil ~= servantInfo_Left then
    self._ui._stc_LeftImage:ReleaseTexture()
    local findImage = true
    local characterKeyRaw = servantInfo_Left:getCharacterKeyRaw()
    local x1, y1, x2, y2 = 0, 0, 0, 0
    if 9989 == characterKeyRaw or 31583 == characterKeyRaw then
      x1, y1, x2, y2 = 1, 484, 185, 939
    elseif 9988 == characterKeyRaw or 31582 == characterKeyRaw then
      x1, y1, x2, y2 = 186, 484, 370, 939
    elseif 9987 == characterKeyRaw or 31581 == characterKeyRaw then
      x1, y1, x2, y2 = 371, 484, 555, 939
    else
      findImage = false
    end
    if true == findImage then
      self._ui._stc_LeftImage:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_9thGenEnhance.dds")
      local uvX1, uvY1, uvX2, uvY2 = setTextureUV_Func(self._ui._stc_LeftImage, x1, y1, x2, y2)
      self._ui._stc_LeftImage:getBaseTexture():setUV(uvX1, uvY1, uvX2, uvY2)
      self._ui._stc_LeftImage:setRenderTexture(self._ui._stc_LeftImage:getBaseTexture())
    end
    self._ui._txt_LeftName:SetShow(true)
    local servantName = servantInfo_Left:getName()
    if nil ~= servantName then
      self._ui._txt_LeftName:SetText(servantName)
    end
    self._ui._stc_LeftGenderIcon:SetShow(false)
    if true == servantInfo_Left:isDisplayGender() then
      self._ui._stc_LeftGenderIcon:SetShow(true)
      self._ui._stc_LeftGenderIcon:ChangeTextureInfoNameAsync("combine/etc/combine_etc_stable.dds")
      local x1, y1, x2, y2 = 0, 0, 0, 0
      if true == servantInfo_Left:isMale() then
        x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_LeftGenderIcon, 1, 209, 31, 239)
      else
        x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_LeftGenderIcon, 1, 178, 31, 208)
      end
      self._ui._stc_LeftGenderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
      self._ui._stc_LeftGenderIcon:setRenderTexture(self._ui._stc_LeftGenderIcon:getBaseTexture())
    end
    self._ui._stc_LeftPlus:SetShow(false)
    if _ContentsGroup_FantasyUpgradeAutoRegist == true then
      self._ui._btn_LeftSelect:SetIgnore(true)
      self._ui._btn_LeftChange:SetIgnore(false)
      self._ui._btn_LeftChange:SetMonoTone(false)
    end
  else
    self._ui._stc_LeftImage:ReleaseTexture()
    self._ui._stc_LeftImage:ChangeTextureInfoNameAsync("")
    self._ui._txt_LeftName:SetText("")
    self._ui._txt_LeftName:SetShow(false)
    self._ui._stc_LeftPlus:SetShow(true)
    if _ContentsGroup_FantasyUpgradeAutoRegist == true then
      self._ui._btn_LeftSelect:SetIgnore(false)
      self._ui._btn_LeftChange:SetIgnore(true)
      self._ui._btn_LeftChange:SetMonoTone(true)
    end
  end
  if nil ~= self._servantNo_Right then
    servantInfo_Right = stable_getServantByServantNo(self._servantNo_Right)
  end
  if nil ~= servantInfo_Right then
    self._ui._stc_RightImage:ReleaseTexture()
    local findImage = true
    local characterKeyRaw = servantInfo_Right:getCharacterKeyRaw()
    local x1, y1, x2, y2 = 0, 0, 0, 0
    if 9889 == characterKeyRaw or 31580 == characterKeyRaw then
      x1, y1, x2, y2 = 185, 484, 1, 939
    elseif 9888 == characterKeyRaw or 31579 == characterKeyRaw then
      x1, y1, x2, y2 = 370, 484, 186, 939
    elseif 9887 == characterKeyRaw or 31578 == characterKeyRaw then
      x1, y1, x2, y2 = 555, 484, 371, 939
    else
      findImage = false
    end
    if true == findImage then
      self._ui._stc_RightImage:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_9thGenEnhance.dds")
      local uvX1, uvY1, uvX2, uvY2 = setTextureUV_Func(self._ui._stc_RightImage, x1, y1, x2, y2)
      self._ui._stc_RightImage:getBaseTexture():setUV(uvX1, uvY1, uvX2, uvY2)
      self._ui._stc_RightImage:setRenderTexture(self._ui._stc_RightImage:getBaseTexture())
    end
    self._ui._txt_RightName:SetShow(true)
    local servantName = servantInfo_Right:getName()
    if nil ~= servantName then
      self._ui._txt_RightName:SetText(servantName)
    end
    self._ui._stc_RightGenderIcon:SetShow(false)
    if true == servantInfo_Right:isDisplayGender() then
      self._ui._stc_RightGenderIcon:SetShow(true)
      self._ui._stc_RightGenderIcon:ChangeTextureInfoNameAsync("combine/etc/combine_etc_stable.dds")
      local x1, y1, x2, y2 = 0, 0, 0, 0
      if true == servantInfo_Right:isMale() then
        x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_RightGenderIcon, 1, 209, 31, 239)
      else
        x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_RightGenderIcon, 1, 178, 31, 208)
      end
      self._ui._stc_RightGenderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
      self._ui._stc_RightGenderIcon:setRenderTexture(self._ui._stc_RightGenderIcon:getBaseTexture())
    end
    self._ui._stc_RightPlus:SetShow(false)
    if _ContentsGroup_FantasyUpgradeAutoRegist == true then
      self._ui._btn_RightSelect:SetIgnore(true)
      self._ui._btn_RightChange:SetIgnore(false)
      self._ui._btn_RightChange:SetMonoTone(false)
    end
  else
    self._ui._stc_RightImage:ReleaseTexture()
    self._ui._stc_RightImage:ChangeTextureInfoNameAsync("")
    self._ui._txt_RightName:SetText("")
    self._ui._txt_RightName:SetShow(false)
    self._ui._stc_RightPlus:SetShow(true)
    if _ContentsGroup_FantasyUpgradeAutoRegist == true then
      self._ui._btn_RightSelect:SetIgnore(false)
      self._ui._btn_RightChange:SetIgnore(true)
      self._ui._btn_RightChange:SetMonoTone(true)
    end
  end
end
function PaGlobal_ServantExchange_Fantasy_All:exchangeStateUpdate()
  if nil == Panel_Dialog_ServantExchange_Fantasy_All or false == Panel_Dialog_ServantExchange_Fantasy_All:GetShow() then
    return
  end
  if nil ~= self._servantNo_Left and nil ~= self._servantNo_Right and __eTInventorySlotNoUndefined ~= self._needItemInfo._needItemSlotNo and 0 < self._needItemInfo._needItemCount then
    self._ui._edit_Naming:SetMonoTone(false)
    self._ui._edit_Naming:SetIgnore(false)
    self._ui._btn_Exchange_PC:SetMonoTone(false)
    self._ui._btn_Exchange_PC:SetIgnore(false)
  else
    self._ui._edit_Naming:SetMonoTone(true, true)
    self._ui._edit_Naming:SetIgnore(true)
    self:clearEditName()
    self._ui._btn_Exchange_PC:SetMonoTone(true, true)
    self._ui._btn_Exchange_PC:SetIgnore(true)
  end
end
function PaGlobal_ServantExchange_Fantasy_All:clearEditName()
  if Panel_Dialog_ServantExchange_Fantasy_All == nil then
    return
  end
  if self._isConsole == false then
    self._ui._edit_Naming:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTREGIST_EDITDESC"), true)
  else
    local randIndex = getRandomValue(1, #PaGlobal_ServantFunction_All._randomName_ForConsole)
    self._ui._edit_Naming:SetEditText(PaGlobal_ServantFunction_All._randomName_ForConsole[randIndex])
  end
  ClearFocusEdit()
end
function PaGlobal_ServantExchange_Fantasy_All:stackCountUpdate()
  if Panel_Dialog_ServantExchange_Fantasy_All == nil or Panel_Dialog_ServantExchange_Fantasy_All:GetShow() == false then
    return
  end
  if _ContentsGroup_ServantFantasyMix == false then
    return
  end
  local defaultRate = ToClient_getFantasyMixMaxRate() / 10000
  local stackCount = ToClient_getFantasyMixStackCount()
  local addRate = ToClient_getFantasyUpgradeFailStackRate() / 10000
  local totalRate = defaultRate + addRate
  totalRate = string.format("%.1f", totalRate)
  totalRate = tostring(totalRate) .. "%"
  if _ContentsGroup_FantasyUpgradeAutoRegist == true then
    self._ui._txt_RateCount:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_DREAMFANTASY_PERCENT", "rate", totalRate))
  else
    self._ui._txt_RateCount:SetText(totalRate)
  end
  self._ui._txt_RateCount:SetShow(true)
  self._ui._txt_StackCount:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_StackCount:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_DREAMFANTASY_PERCENT_INCREASE", "stack", tostring(stackCount)))
  self._ui._txt_StackCount:SetShow(true)
  if _ContentsGroup_GuaranteeHorseFusion == true then
    local fantasyUpgradeMaximumStack = ToClient_getFantasyUpgradeMaximumStack()
    if fantasyUpgradeMaximumStack ~= nil and fantasyUpgradeMaximumStack > 0 then
      if stackCount >= fantasyUpgradeMaximumStack then
        self._ui._txt_RateCount:SetText("100%")
      end
      self._ui._txt_StackCount:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_DREAMFANTASY_PERCENT_INCREASE", "stack", tostring(stackCount) .. " / " .. tostring(fantasyUpgradeMaximumStack)))
    end
  end
end
function PaGlobal_ServantExchange_Fantasy_All:needItemUpdate()
  if Panel_Dialog_ServantExchange_Fantasy_All == nil then
    return
  end
  if self._isFantasyMixDoing == true then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  local fantasyMixNeedItemWrapper = ToClient_getFantasyMixNeedItem()
  if fantasyMixNeedItemWrapper == nil then
    return
  end
  local needItemKey = fantasyMixNeedItemWrapper:get()._key:getItemKey()
  if needItemKey == nil then
    return
  end
  local fromItemWhereType = CppEnums.ItemWhereType.eInventory
  local fromItemSlotNo = __eTInventorySlotNoUndefined
  local useStartSlot = inventorySlotNoUserStart()
  local invenUseSize = selfPlayer:getInventorySlotCount(false)
  local needItemCount = 0
  local needItemWrapper
  for index = useStartSlot, invenUseSize - 1 do
    local itemWrapper = getInventoryItemByType(fromItemWhereType, index)
    if itemWrapper ~= nil then
      local invenItemSSW = itemWrapper:getStaticStatus()
      if invenItemSSW:get()._key:getItemKey() == needItemKey then
        needItemWrapper = invenItemSSW
        needItemCount = itemWrapper:getCount()
        fromItemSlotNo = index
        break
      end
    end
  end
  local curItemCount = Int64toInt32(needItemCount)
  local itemNeedCount = ToClient_getFantasyMixNeedItemMaxCount()
  if curItemCount < itemNeedCount then
    self:clearNeedItemCount()
  else
    self._needItemInfo._needItemSlotNo = fromItemSlotNo
    self._needItemInfo._needItemCount = itemNeedCount
    self._itemSlot:setItemByStaticStatus(needItemWrapper, itemNeedCount)
    self._itemSlot.icon:SetMonoTone(false)
    self:exchangeStateUpdate()
  end
  self._ui._txt_ItemCount:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_DREAMFANTASY_ITEM", "num", tostring(curItemCount)))
end
function PaGlobal_ServantExchange_Fantasy_All:MixConfirm()
  if nil == Panel_Dialog_ServantExchange_Fantasy_All or false == Panel_Dialog_ServantExchange_Fantasy_All:GetShow() then
    return
  end
  if true == self._isFantasyMixDoing then
    return
  end
  ClearFocusEdit()
  local name = self._ui._edit_Naming:GetEditText()
  if nil == self._servantNo_Left or nil == self._servantNo_Right or nil == name then
    return
  end
  if __eTInventorySlotNoUndefined == self._needItemInfo._needItemSlotNo or self._needItemInfo._needItemCount < 1 then
    return
  end
  local function servantFantasyMix()
    self._isFantasyMixDoing = true
    if nil ~= PaGlobalFunc_Servant_FantasySelect_All_Close then
      PaGlobalFunc_Servant_FantasySelect_All_Close()
    end
    local rv = ToClient_fantasyMix(self._servantNo_Left, self._servantNo_Right, CppEnums.ItemWhereType.eInventory, self._needItemInfo._needItemSlotNo, name)
    if 0 ~= rv then
      self._isFantasyMixDoing = false
    end
  end
  messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTEXCHANGE_FANTASY_TEXT_CONFIRM"),
    functionYes = servantFantasyMix,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  local isUsedAddStatItem = false
  local servantInfo = stable_getServantByServantNo(self._servantNo_Left)
  if servantInfo ~= nil and not isUsedAddStatItem then
    isUsedAddStatItem = servantInfo:isUsedAnyAddStatItem()
  end
  servantInfo = stable_getServantByServantNo(self._servantNo_Right)
  if servantInfo ~= nil and not isUsedAddStatItem then
    isUsedAddStatItem = servantInfo:isUsedAnyAddStatItem()
  end
  if isUsedAddStatItem == true then
    messageboxData.content = messageboxData.content .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_BUFF_USE_WARN")
  end
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_ServantExchange_Fantasy_All:validate()
  if nil == Panel_Dialog_ServantExchange_Fantasy_All then
    return
  end
  self._ui._stc_Title:isValidate()
  self._ui._txt_Title:isValidate()
  self._ui._btn_Question_PC:isValidate()
  self._ui._btn_Close_PC:isValidate()
  self._ui._btn_Exchange_PC:isValidate()
  self._ui._stc_Bg:isValidate()
  self._ui._stc_Exchange_Bg:isValidate()
  self._ui._txt_TopDesc:isValidate()
  self._ui._txt_RateCount:isValidate()
  self._ui._txt_StackCount:isValidate()
  self._ui._stc_ItemSlotBg:isValidate()
  self._ui._stc_ItemIcon:isValidate()
  self._ui._stc_LeftBg:isValidate()
  self._ui._btn_LeftSelect:isValidate()
  self._ui._stc_LeftPlus:isValidate()
  self._ui._stc_LeftMale:isValidate()
  self._ui._stc_LeftImage:isValidate()
  self._ui._stc_LeftGenderIcon:isValidate()
  self._ui._txt_LeftName:isValidate()
  self._ui._stc_RightBg:isValidate()
  self._ui._btn_RightSelect:isValidate()
  self._ui._stc_RightPlus:isValidate()
  self._ui._stc_RightMale:isValidate()
  self._ui._stc_RightImage:isValidate()
  self._ui._stc_RightGenderIcon:isValidate()
  self._ui._txt_RightName:isValidate()
  self._ui._edit_Naming:isValidate()
  self._ui._stc_Pencil:isValidate()
  self._ui._stc_DescBG:isValidate()
  self._ui._txt_Desc:isValidate()
  self._ui._stc_Bottom_KeyGuide:isValidate()
  self._ui._stc_KeyGuide_Y:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._ui._stc_KeyGuide_B:isValidate()
  self._ui._stc_KeyGuide_X:isValidate()
end
