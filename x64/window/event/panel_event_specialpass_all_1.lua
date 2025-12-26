function PaGlobal_SpecialPass:initialize()
  if self._initialize == true then
    return
  end
  self._isPadSnapping = ToClient_isUsePadSnapping()
  self._isConsole = ToClient_isConsole()
  self._ui.stc_TitleArea = UI.getChildControl(Panel_Event_SpecialPass_All, "Static_TitleArea")
  self._ui.stc_Title = UI.getChildControl(self._ui.stc_TitleArea, "StaticText_Title")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_TitleArea, "Button_Close")
  if self._isConsole == true then
    self._ui.stc_MainBG = UI.getChildControl(Panel_Event_SpecialPass_All, "Static_MainBG_Console")
  elseif isGameTypeKorea() == true then
    self._ui.stc_MainBG = UI.getChildControl(Panel_Event_SpecialPass_All, "Static_MainBG")
  else
    self._ui.stc_MainBG = UI.getChildControl(Panel_Event_SpecialPass_All, "Static_MainBG_Global")
  end
  self._ui.stc_MainBG:SetShow(true)
  self._ui.stc_ImageFont = UI.getChildControl(self._ui.stc_MainBG, "Static_Title_ImageFont")
  self._ui.stc_DecoLine = UI.getChildControl(self._ui.stc_MainBG, "Static_Deco_Line")
  self._ui.txt_Date = UI.getChildControl(self._ui.stc_MainBG, "MultilineText_Date")
  self._ui.btn_PearlShop = UI.getChildControl(self._ui.stc_MainBG, "Button_GotoShop")
  self._ui.btn_SpiritBox = UI.getChildControl(self._ui.stc_MainBG, "Button_OpenBox")
  self._ui.txt_Day = UI.getChildControl(self._ui.stc_MainBG, "StaticText_Day")
  if self._isConsole == true then
    self._ui.list2 = UI.getChildControl(Panel_Event_SpecialPass_All, "List2_Quest_Console")
  elseif isGameTypeKorea() == true then
    self._ui.list2 = UI.getChildControl(Panel_Event_SpecialPass_All, "List2_Quest")
  else
    self._ui.list2 = UI.getChildControl(Panel_Event_SpecialPass_All, "List2_Quest_Global")
  end
  self._ui.list2:SetShow(true)
  self._ui.list2_Content = UI.getChildControl(self._ui.list2, "List2_1_Content")
  self._ui.stc_ProductBG = UI.getChildControl(self._ui.list2_Content, "Static_Product_BG0")
  self._ui.stc_BottomDesc = UI.getChildControl(Panel_Event_SpecialPass_All, "Static_BottomDesc")
  self._ui.txt_Desc = UI.getChildControl(self._ui.stc_BottomDesc, "StaticText_Desc")
  self._ui.txt_RateView = UI.getChildControl(self._ui.stc_BottomDesc, "StaticText_RateDesc")
  self._ui.stc_KeyGuideConsole = UI.getChildControl(Panel_Event_SpecialPass_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_B_Button = UI.getChildControl(self._ui.stc_KeyGuideConsole, "StaticText_B_ConsoleUI")
  self._ui.stc_A_Button = UI.getChildControl(self._ui.stc_KeyGuideConsole, "StaticText_A_ConsoleUI")
  self._ui.stc_X_Button = UI.getChildControl(self._ui.stc_KeyGuideConsole, "StaticText_X_ConsoleUI")
  self._ui.stc_Y_Button = UI.getChildControl(self._ui.stc_KeyGuideConsole, "StaticText_Y_ConsoleUI")
  self._ui.stc_LTA_Button = UI.getChildControl(self._ui.stc_KeyGuideConsole, "StaticText_LTA_ReceiveAll_ConsoleUI")
  self._ui.stc_ChangeModeBg = UI.getChildControl(Panel_Event_SpecialPass_All, "Static_ChangeModeBg")
  self._ui.btn_ToggleButton = UI.getChildControl(self._ui.stc_ChangeModeBg, "Button_Toggle")
  self._ui.stc_DailySpecial = UI.getChildControl(self._ui.stc_ChangeModeBg, "StaticText_DailySpecial")
  self._ui.stc_DailySpecialIcon = UI.getChildControl(self._ui.stc_ChangeModeBg, "Static_DailySpecial")
  self._ui.stc_SolareSpecial = UI.getChildControl(self._ui.stc_ChangeModeBg, "StaticText_SolareSpecial")
  self._ui.stc_SolareSpecialIcon = UI.getChildControl(self._ui.stc_ChangeModeBg, "Static_SolareSpecial")
  self._ui.stc_SelectRB = UI.getChildControl(self._ui.stc_ChangeModeBg, "Static_SelectLB")
  self._ui.stc_SelectLB = UI.getChildControl(self._ui.stc_ChangeModeBg, "Static_SelectRB")
  self._ui.stc_SolarePassDesc = UI.getChildControl(Panel_Event_SpecialPass_All, "StaticText_SolarePass_Desc")
  self._textureInfo = {
    [__eSpecialPassContentType_Solare] = {
      _mainBg = "Combine/CommonIcon/Ingame_Banner_Event_NewType_07.dds",
      _imageFont = "Combine/CommonIcon/Ingame_Banner_Event_NewType_Title_01.dds",
      _decoLine = "Combine_Etc_Event_New_Type_04_Deco_MainTitle_Line",
      _pearlShopButton = "Combine_Etc_Event_New_Type_04_BTN_MainTitle_02_Normal",
      _pearlShopButton_On = "Combine_Etc_Event_New_Type_04_BTN_MainTitle_02_Over",
      _pearlShopButton_Click = "Combine_Etc_Event_New_Type_04_BTN_MainTitle_02_Click",
      _itemSlotNormal = "Combine_Etc_Event_New_Type_04_Frm_Slot_02",
      _itemSlotEmpty = "Combine_Etc_Event_New_Type_04_Frm_Slot_01",
      _itemSlotNoticeLine = "Combine_Etc_Event_New_Type_04_Frm_Slot_04"
    },
    [__eSpecialPassContentType_Daily] = {
      _mainBg = "combine/commonicon/ingame_banner_event_newtype_18.dds",
      _imageFont = "combine/commonicon/ingame_banner_event_newtype_title_14.dds",
      _decoLine = "Combine_Etc_Event_New_Type_03_Deco_MainTitle_Line",
      _pearlShopButton = "Combine_Etc_Event_New_Type_03_BTN_MainTitle_02_Normal",
      _pearlShopButton_On = "Combine_Etc_Event_New_Type_03_BTN_MainTitle_02_Over",
      _pearlShopButton_Click = "Combine_Etc_Event_New_Type_03_BTN_MainTitle_02_Click",
      _itemSlotNormal = "Combine_Etc_Event_New_Type_03_Frm_Slot_02",
      _itemSlotEmpty = "Combine_Etc_Event_New_Type_03_Frm_Slot_01",
      _itemSlotNoticeLine = "Combine_Etc_Event_New_Type_03_Frm_Slot_04"
    }
  }
  if self._isConsole == true then
    self._textureInfo[__eSpecialPassContentType_Daily]._mainBg = "combine/commonicon/ingame_banner_event_newtype_14.dds"
    self._textureInfo[__eSpecialPassContentType_Daily]._imageFont = "combine/commonicon/ingame_banner_event_newtype_title_03.dds"
    self._ui.btn_Close:SetShow(false)
  end
  self:registerEvent()
  self:validate()
  self:createTemplate()
  self._initialize = true
end
function PaGlobal_SpecialPass:registerEvent()
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_Event_SpecialPass_Close()")
  self._ui.btn_SpiritBox:addInputEvent("Mouse_LUp", "HandleEventLUp_OpenTotalReward()")
  self._ui.txt_RateView:addInputEvent("Mouse_LUp", "HandleEventLUp_SpecialPass_OpenRateViewByLink()")
  self._ui.txt_RateView:addInputEvent("Mouse_On", "HandleEventOnOut_SpecialPass_ChangeRateViewButtonText(true)")
  self._ui.txt_RateView:addInputEvent("Mouse_Out", "HandleEventOnOut_SpecialPass_ChangeRateViewButtonText(false)")
  self._ui.stc_ChangeModeBg:addInputEvent("Mouse_LUp", "HandleEventLUp_ToggleSpeicalPassType()")
  if self._isPadSnapping == true or self._isConsole == true then
    Panel_Event_SpecialPass_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_ShowSpecialPassPearlShop()")
    Panel_Event_SpecialPass_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "HandleEventLUp_OpenTotalReward()")
    self._ui.stc_KeyGuideConsole:SetShow(true)
    Panel_Event_SpecialPass_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "HandleEventLUp_ToggleSpeicalPassType(" .. __eSpecialPassContentType_Daily .. ")")
    Panel_Event_SpecialPass_All:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "HandleEventLUp_ToggleSpeicalPassType(" .. __eSpecialPassContentType_Solare .. ")")
    self._ui.stc_SelectLB:SetShow(true)
    self._ui.stc_SelectRB:SetShow(true)
  end
end
function PaGlobal_SpecialPass:validate()
  self._ui.stc_TitleArea:isValidate()
  self._ui.stc_Title:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.stc_MainBG:isValidate()
  self._ui.stc_DecoLine:isValidate()
  self._ui.stc_ImageFont:isValidate()
  self._ui.txt_Date:isValidate()
  self._ui.btn_PearlShop:isValidate()
  self._ui.btn_SpiritBox:isValidate()
  self._ui.txt_Day:isValidate()
  self._ui.list2:isValidate()
  self._ui.list2_Content:isValidate()
  self._ui.stc_BottomDesc:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui.txt_RateView:isValidate()
  self._ui.stc_ChangeModeBg:isValidate()
  self._ui.btn_ToggleButton:isValidate()
  self._ui.stc_DailySpecial:isValidate()
  self._ui.stc_SolareSpecial:isValidate()
  self._ui.stc_DailySpecialIcon:isValidate()
  self._ui.stc_SolareSpecialIcon:isValidate()
  self._ui.stc_SelectLB:isValidate()
  self._ui.stc_SelectRB:isValidate()
  self._ui.stc_KeyGuideConsole:isValidate()
  self._ui.stc_B_Button:isValidate()
  self._ui.stc_A_Button:isValidate()
  self._ui.stc_X_Button:isValidate()
  self._ui.stc_Y_Button:isValidate()
  self._ui.stc_LTA_Button:isValidate()
end
function PaGlobal_SpecialPass:prepareOpen(passType)
  if Panel_Event_SpecialPass_All == nil then
    return
  end
  if self:updateUI(passType) == false then
    self:prepareClose()
    return
  end
  self:open()
end
function PaGlobal_SpecialPass:open()
  if Panel_Event_SpecialPass_All == nil then
    return
  end
  Panel_Event_SpecialPass_All:SetShow(true)
end
function PaGlobal_SpecialPass:updateUI(passType)
  self._currentPassKey = 0
  self._currentPassType = __eSpecialPassContentType_Count
  local key = ToClient_GetCurrentSpecialPassKey(passType)
  if key == 0 then
    return false
  end
  if ToClient_openSpecialPassInfo(key) == false then
    return false
  end
  self._currentPassKey = key
  self._currentPassType = passType
  HandleEventOnOut_SpecialPass_ChangeRateViewButtonText(false)
  self:updatePass()
  return true
end
function PaGlobal_SpecialPass:prepareClose()
  if Panel_Event_SpecialPass_All == nil then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  if PaGlobal_SpecialPassEffectClose ~= nil then
    PaGlobal_SpecialPassEffectClose()
  end
  local needToShowFunctionEffect = false
  if ToClient_CheckReceiveItemCurrentSpecialPass() == true and PaGlobal_SpecialPassEffectAvailable ~= nil then
    PaGlobal_SpecialPassEffectAvailable()
  end
  self:close()
end
function PaGlobal_SpecialPass:close()
  if Panel_Event_SpecialPass_All == nil then
    return
  end
  Panel_Event_SpecialPass_All:SetShow(false)
end
function PaGlobal_SpecialPass:updatePass()
  if Panel_Event_SpecialPass_All == nil then
    return
  end
  if self._currentPassKey == 0 then
    return
  end
  for idx = 0, __eSPECIALPASS_MAX_COUNT - 1 do
    local productBG = self._itemList[idx]
    if productBG ~= nil then
      local basicItemBG = UI.getChildControl(productBG, "Static_ItemIcon_Basic_BG")
      if basicItemBG ~= nil then
        basicItemBG:EraseAllEffect()
      end
      local passItemBG = UI.getChildControl(productBG, "Static_ItemIcon_Special_BG")
      if passItemBG ~= nil then
        passItemBG:EraseAllEffect()
      end
    end
  end
  self:updateUITexture()
  self:updateToggleButton()
  self:updateItemSlots()
  if self._isPadSnapping == true or self._isConsole == true then
    self._ui.stc_KeyGuideConsole:SetPosXY(self._ui.stc_KeyGuideConsole:GetPosX(), Panel_Event_SpecialPass_All:GetSizeY())
    local keyGuides = {
      self._ui.stc_LTA_Button,
      self._ui.stc_Y_Button,
      self._ui.stc_X_Button,
      self._ui.stc_A_Button,
      self._ui.stc_B_Button
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_KeyGuideConsole, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_SpecialPass:updateItemSlots()
  if Panel_Event_SpecialPass_All == nil then
    return
  end
  local rowCount = self._rowCount
  local startPosition = (self._ui.list2_Content:GetSizeX() - rowCount * self._ui.stc_ProductBG:GetSizeX() - (rowCount - 1) * 5) * 0.5
  local posXStart = startPosition
  local posYStart = 10
  for idx = 0, __eSPECIALPASS_MAX_COUNT - 1 do
    local productBG = self._itemList[idx]
    if productBG ~= nil then
      if idx <= self._itemCount - 1 then
        productBG:SetShow(true)
      else
        productBG:SetShow(false)
      end
      productBG:SetPosXY(posXStart, posYStart)
      posXStart = startPosition + (idx + 1) % rowCount * (self._ui.stc_ProductBG:GetSizeX() + 5)
      posYStart = 10 + math.floor((idx + 1) / rowCount) * (self._ui.stc_ProductBG:GetSizeY() + 5)
    end
  end
  local availableGetReward = false
  for idx = 0, self._itemCount - 1 do
    local productBG = self._itemList[idx]
    if productBG ~= nil then
      local itemRewardPoint = ToClient_GetSpecialPassItemRewardPoint(self._currentPassKey, idx)
      local dayControl = UI.getChildControl(productBG, "StaticText_Day")
      local dayString = ""
      if self._currentPassType == __eSpecialPassContentType_Daily then
        if itemRewardPoint >= 0 and itemRewardPoint <= 9 then
          dayString = "0" .. tostring(itemRewardPoint)
        else
          dayString = tostring(itemRewardPoint)
        end
      elseif self._currentPassType == __eSpecialPassContentType_Solare then
        dayString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_EVENT_SPECIALPASS_SOLARE", "score", makeDotMoney(itemRewardPoint))
      end
      dayControl:SetText(dayString)
      local basicSlot = {}
      local basicItemBG = UI.getChildControl(productBG, "Static_ItemIcon_Basic_BG")
      basicSlot.control = UI.getChildControl(basicItemBG, "Static_IconSlot")
      SlotItem.reInclude(basicSlot, "Static_BasicItemSlot_" .. idx, 0, basicSlot.control, self._slotConfig)
      basicSlot.icon:SetPosXY(1, 1)
      basicSlot.icon:SetSize(basicSlot.control:GetSizeX(), basicSlot.control:GetSizeY())
      basicSlot.border:SetSize(basicSlot.control:GetSizeX(), basicSlot.control:GetSizeY())
      basicSlot.icon:SetShow(true)
      local itemEnchantKey = ToClient_GetSpecialPassItemEnchantKey(self._currentPassKey, false, idx)
      local itemCount = ToClient_GetSpecialPassItemCount(self._currentPassKey, false, idx)
      local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
      if itemSSW ~= nil then
        basicSlot:setItemByStaticStatus(itemSSW, itemCount)
      end
      self._basicItemButtonList[idx] = basicSlot
      if self._isConsole == true or self._isPadSnapping == true then
        basicItemBG:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_RewardItem_ShowSlotToolTip(" .. self._currentPassKey .. ",true, false, " .. idx .. ")")
      else
        basicSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_RewardItem_ShowSlotToolTip(" .. self._currentPassKey .. ", true, false, " .. idx .. ")")
      end
      basicSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_RewardItem_ShowSlotToolTip(" .. self._currentPassKey .. ", false, false, " .. idx .. ")")
      basicSlot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_GetBasicReward(" .. self._currentPassKey .. "," .. idx .. ")")
      if self._isPadSnapping == true then
        local keyGuidePC = UI.getChildControl(basicItemBG, "Static_KeyGuide_PCUI")
        keyGuidePC:ChangeTextureInfoNameAsync("renewal/ui_icon/console_xboxkey_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(keyGuidePC, 1, 1, 45, 45)
        keyGuidePC:getBaseTexture():setUV(x1, y1, x2, y2)
        keyGuidePC:setRenderTexture(keyGuidePC:getBaseTexture())
        keyGuidePC:SetSize(30, 30)
      end
      local passSlot = {}
      local passItemBG = UI.getChildControl(productBG, "Static_ItemIcon_Special_BG")
      passSlot.control = UI.getChildControl(passItemBG, "Static_IconSlot")
      SlotItem.reInclude(passSlot, "Static_PassItemSlot_" .. idx, 0, passSlot.control, self._slotConfig)
      passSlot.icon:SetPosXY(1, 1)
      passSlot.icon:SetSize(passSlot.control:GetSizeX(), passSlot.control:GetSizeY())
      passSlot.border:SetSize(passSlot.control:GetSizeX(), passSlot.control:GetSizeY())
      passSlot.icon:SetShow(true)
      itemEnchantKey = ToClient_GetSpecialPassItemEnchantKey(self._currentPassKey, true, idx)
      itemCount = ToClient_GetSpecialPassItemCount(self._currentPassKey, true, idx)
      itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
      if itemSSW ~= nil then
        passSlot:setItemByStaticStatus(itemSSW, itemCount)
      end
      self._passItemButtonList[idx] = passSlot
      if self._isConsole == true or self._isPadSnapping == true then
        passItemBG:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_RewardItem_ShowSlotToolTip(" .. self._currentPassKey .. ", true, true, " .. idx .. ")")
      else
        passSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_RewardItem_ShowSlotToolTip(" .. self._currentPassKey .. ", true, true, " .. idx .. ")")
      end
      passSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_RewardItem_ShowSlotToolTip(" .. self._currentPassKey .. ", false, true, " .. idx .. ")")
      if self._isPassUser == false and self._isPurchasablePassItem == true then
        passSlot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_ShowSpecialPassPearlShop(" .. self._currentPassType .. ")")
      else
        passSlot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_GetPassReward(" .. self._currentPassKey .. "," .. idx .. ")")
      end
      if self._isPadSnapping == true then
        local keyGuidePC = UI.getChildControl(passItemBG, "Static_KeyGuide_PCUI")
        keyGuidePC:ChangeTextureInfoNameAsync("combine/icon/combine_xbox_key_icon_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(keyGuidePC, 1, 1, 45, 45)
        keyGuidePC:getBaseTexture():setUV(x1, y1, x2, y2)
        keyGuidePC:setRenderTexture(keyGuidePC:getBaseTexture())
        keyGuidePC:SetSize(30, 30)
      end
    end
  end
  for idx = 0, self._itemCount - 1 do
    local productBG = self._itemList[idx]
    local todayBG = UI.getChildControl(productBG, "Static_Today_BG")
    local soldoutBG = UI.getChildControl(productBG, "Static_Soldout_BG")
    local basicItemBG = UI.getChildControl(productBG, "Static_ItemIcon_Basic_BG")
    local basicItemControl = UI.getChildControl(basicItemBG, "Static_IconSlot")
    local basicItemStamp = UI.getChildControl(basicItemBG, "Static_Stamp")
    local basicItemMouse = UI.getChildControl(basicItemBG, "Static_KeyGuide_PCUI")
    local passItemBG = UI.getChildControl(productBG, "Static_ItemIcon_Special_BG")
    local passItemControl = UI.getChildControl(passItemBG, "Static_IconSlot")
    local passItemStamp = UI.getChildControl(passItemBG, "Static_Stamp")
    local passItemMouse = UI.getChildControl(passItemBG, "Static_KeyGuide_PCUI")
    local passLock = UI.getChildControl(passItemBG, "Static_Locked")
    if idx >= self._maxRewardIndex then
      basicItemControl:SetMonoTone(false)
      basicItemStamp:SetShow(false)
      basicItemMouse:SetShow(false)
    elseif idx < self._currentRewardIndex then
      basicItemControl:SetMonoTone(true)
      basicItemStamp:SetShow(true)
      basicItemMouse:SetShow(false)
    elseif idx == self._currentRewardIndex then
      basicItemControl:SetMonoTone(false)
      basicItemStamp:SetShow(false)
      basicItemMouse:SetShow(true)
      availableGetReward = true
      basicItemBG:AddEffect("fUI_ingame_pass_02A", true, 0, 0)
    else
      basicItemControl:SetMonoTone(false)
      basicItemStamp:SetShow(false)
      basicItemMouse:SetShow(false)
    end
    if self._isPassUser == false then
      passItemControl:SetMonoTone(false)
      passItemStamp:SetShow(false)
      passItemMouse:SetShow(false)
      passLock:SetShow(true)
    else
      passLock:SetShow(false)
      if idx >= self._maxRewardIndex then
        passItemControl:SetMonoTone(false)
        passItemStamp:SetShow(false)
        passItemMouse:SetShow(false)
      elseif idx < self._currentPassRewardIndex then
        passItemControl:SetMonoTone(true)
        passItemStamp:SetShow(true)
        passItemMouse:SetShow(false)
      elseif idx == self._currentPassRewardIndex then
        passItemControl:SetMonoTone(false)
        passItemStamp:SetShow(false)
        passItemMouse:SetShow(true)
        availableGetReward = true
        passItemBG:AddEffect("fUI_ingame_pass_02A", true, 0, 0)
      else
        passItemControl:SetMonoTone(false)
        passItemStamp:SetShow(false)
        passItemMouse:SetShow(false)
      end
    end
    if idx < self._currentRewardIndex and idx < self._currentPassRewardIndex then
      soldoutBG:SetShow(true)
    else
      soldoutBG:SetShow(false)
    end
    if idx == self._maxRewardIndex - 1 then
      todayBG:SetShow(true)
    else
      todayBG:SetShow(false)
    end
  end
  if availableGetReward == true and PaGlobal_SpecialPassEffectAvailable ~= nil then
    PaGlobal_SpecialPassEffectAvailable()
  end
  if self._isPassUser == true then
    self._ui.btn_PearlShop:SetMonoTone(true)
    self._ui.btn_PearlShop:SetIgnore(true)
  else
    self._ui.btn_PearlShop:SetMonoTone(false)
    self._ui.btn_PearlShop:SetIgnore(false)
  end
end
function PaGlobal_SpecialPass:updateUITexture()
  if Panel_Event_SpecialPass_All == nil then
    return
  end
  local textureInfo = self._textureInfo[self._currentPassType]
  if textureInfo == nil then
    return
  end
  self._ui.stc_SolarePassDesc:SetShow(false)
  if self._currentPassType == __eSpecialPassContentType_Solare then
    self._ui.txt_Day:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_EVENT_SPECIALPASS_MYSOLARESCORE", "score", makeDotMoney(self._currentRewardPoint)))
    self._ui.stc_SolarePassDesc:SetShow(true)
  elseif self._currentPassType == __eSpecialPassContentType_Daily then
    self._ui.txt_Day:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_SPECIALPASS_DAY", "day", tostring(self._maxRewardIndex)))
  end
  self._ui.btn_PearlShop:addInputEvent("Mouse_LUp", "HandleEventLUp_ShowSpecialPassPearlShop(" .. self._currentPassType .. ")")
  if textureInfo._mainBg ~= nil then
    self._ui.stc_MainBG:ChangeTextureInfoNameAsync(textureInfo._mainBg)
  end
  if textureInfo._decoLine ~= nil then
    self._ui.stc_DecoLine:ChangeTextureInfoTextureIDAsync(textureInfo._decoLine)
  end
  if textureInfo._pearlShopButton ~= nil then
    self._ui.btn_PearlShop:ChangeTextureInfoTextureIDAsync(textureInfo._pearlShopButton)
    self._ui.btn_PearlShop:ChangeTextureInfoTextureIDAsync(textureInfo._pearlShopButton_On, __eUITextureTypeOn)
    self._ui.btn_PearlShop:ChangeTextureInfoTextureIDAsync(textureInfo._pearlShopButton_Click, __eUITextureTypeClick)
  end
  if textureInfo._imageFont ~= nil then
    self._ui.stc_ImageFont:ChangeTextureInfoNameAsync(textureInfo._imageFont)
  end
  for idx = 0, __eSPECIALPASS_MAX_COUNT - 1 do
    local productBG = self._itemList[idx]
    productBG:ChangeTextureInfoTextureIDAsync(textureInfo._itemSlotNormal)
    local todayBG = UI.getChildControl(productBG, "Static_Today_BG")
    todayBG:ChangeTextureInfoTextureIDAsync(textureInfo._itemSlotNoticeLine)
  end
end
function PaGlobal_SpecialPass:updateToggleButton()
  local doDailyPass = ToClient_GetCurrentSpecialPassKey(__eSpecialPassContentType_Daily)
  local doSolarePass = ToClient_GetCurrentSpecialPassKey(__eSpecialPassContentType_Solare)
  if doDailyPass == 0 or doSolarePass == 0 then
    self._ui.stc_ChangeModeBg:SetShow(false)
    return
  end
  local onButton, offButton
  if self._currentPassType == __eSpecialPassContentType_Daily then
    self._ui.btn_ToggleButton:SetHorizonLeft()
    onButton = self._ui.stc_DailySpecialIcon
    offButton = self._ui.stc_SolareSpecialIcon
    onText = self._ui.stc_DailySpecial
    offText = self._ui.stc_SolareSpecial
  elseif self._currentPassType == __eSpecialPassContentType_Solare then
    self._ui.btn_ToggleButton:SetHorizonRight()
    onButton = self._ui.stc_SolareSpecialIcon
    offButton = self._ui.stc_DailySpecialIcon
    onText = self._ui.stc_SolareSpecial
    offText = self._ui.stc_DailySpecial
  else
    self._ui.stc_ChangeModeBg:SetShow(false)
    return
  end
  onText:SetFontColor(4293914607)
  onButton:setRenderTexture(onButton:getOnTexture())
  offText:SetFontColor(4288187779)
  offButton:setRenderTexture(offButton:getBaseTexture())
  self._ui.stc_ChangeModeBg:SetShow(true)
end
function PaGlobal_SpecialPass:toggleSpecialPassType(passType)
  local doDailyPass = ToClient_GetCurrentSpecialPassKey(__eSpecialPassContentType_Daily)
  local doSolarePass = ToClient_GetCurrentSpecialPassKey(__eSpecialPassContentType_Solare)
  if doDailyPass == 0 or doSolarePass == 0 then
    self._ui.stc_ChangeModeBg:SetShow(false)
    return
  end
  if passType == nil then
    if self._currentPassType == __eSpecialPassContentType_Daily then
      self._currentPassType = __eSpecialPassContentType_Solare
    elseif self._currentPassType == __eSpecialPassContentType_Solare then
      self._currentPassType = __eSpecialPassContentType_Daily
    else
      self._ui.stc_ChangeModeBg:SetShow(false)
      return
    end
  else
    if passType == self._currentPassType then
      return
    end
    self._currentPassType = passType
  end
  local prevPosX = Panel_Event_SpecialPass_All:GetPosX()
  local prevPosY = Panel_Event_SpecialPass_All:GetPosY()
  if self:updateUI(self._currentPassType) == false then
    self:prepareClose()
    return
  end
  Panel_Event_SpecialPass_All:SetPosXY(prevPosX, prevPosY)
end
function PaGlobal_SpecialPass:updateRewardItem(nextRewardItemIndex, isPassItem)
  if Panel_Event_SpecialPass_All == nil then
    return
  end
  if nextRewardItemIndex == 0 then
    _PA_ASSERT("false", "\236\138\164\237\142\152\236\133\156 \237\140\168\236\138\164 \236\149\132\236\157\180\237\133\156\236\157\132 \235\176\155\236\149\152\235\138\148\235\141\176 \236\160\136\235\140\128 0\236\157\180 \235\144\160 \236\136\152 \236\151\134\235\139\164!")
    return
  end
  local prevProductBG = self._itemList[nextRewardItemIndex - 1]
  if prevProductBG == nil then
    return
  end
  if nextRewardItemIndex == self._itemCount then
    if isPassItem == true then
      self._currentPassRewardIndex = nextRewardItemIndex
      local prevItemBG = UI.getChildControl(prevProductBG, "Static_ItemIcon_Special_BG")
      local prevItemStamp = UI.getChildControl(prevItemBG, "Static_Stamp")
      local prevItemMouse = UI.getChildControl(prevItemBG, "Static_KeyGuide_PCUI")
      local prevItemControl = UI.getChildControl(prevItemBG, "Static_IconSlot")
      prevItemControl:SetMonoTone(true)
      prevItemStamp:SetShow(true)
      prevItemMouse:SetShow(false)
      prevItemBG:EraseAllEffect()
      prevItemBG:AddEffect("fUI_ingame_pass_03A", false, 0, 0)
      prevItemStamp:ResetVertexAni()
      prevItemStamp:SetVertexAniRun("Ani_Scale_New", true)
      prevItemStamp:SetVertexAniRun("Ani_Move_Pos_New", true)
      audioPostEvent_SystemUi(0, 28)
    else
      self._currentRewardIndex = nextRewardItemIndex
      local prevItemBG = UI.getChildControl(prevProductBG, "Static_ItemIcon_Basic_BG")
      local prevItemStamp = UI.getChildControl(prevItemBG, "Static_Stamp")
      local prevItemMouse = UI.getChildControl(prevItemBG, "Static_KeyGuide_PCUI")
      local prevItemControl = UI.getChildControl(prevItemBG, "Static_IconSlot")
      prevItemControl:SetMonoTone(true)
      prevItemStamp:SetShow(true)
      prevItemMouse:SetShow(false)
      prevItemBG:EraseAllEffect()
      prevItemBG:AddEffect("fUI_ingame_pass_03A", false, 0, 0)
      prevItemStamp:ResetVertexAni()
      prevItemStamp:SetVertexAniRun("Ani_Scale_New", true)
      prevItemStamp:SetVertexAniRun("Ani_Move_Pos_New", true)
      audioPostEvent_SystemUi(0, 28)
    end
  else
    local currentProductBG = self._itemList[nextRewardItemIndex]
    if currentProductBG == nil then
      return
    end
    if isPassItem == true then
      self._currentPassRewardIndex = nextRewardItemIndex
      local prevItemBG = UI.getChildControl(prevProductBG, "Static_ItemIcon_Special_BG")
      local prevItemStamp = UI.getChildControl(prevItemBG, "Static_Stamp")
      local prevItemMouse = UI.getChildControl(prevItemBG, "Static_KeyGuide_PCUI")
      local prevItemControl = UI.getChildControl(prevItemBG, "Static_IconSlot")
      local currentItemBG = UI.getChildControl(currentProductBG, "Static_ItemIcon_Special_BG")
      local currentItemMouse = UI.getChildControl(currentItemBG, "Static_KeyGuide_PCUI")
      prevItemControl:SetMonoTone(true)
      prevItemStamp:SetShow(true)
      prevItemMouse:SetShow(false)
      prevItemBG:EraseAllEffect()
      prevItemControl:AddEffect("fUI_ingame_pass_03A", false, 0, 0)
      prevItemStamp:ResetVertexAni()
      prevItemStamp:SetVertexAniRun("Ani_Scale_New", true)
      prevItemStamp:SetVertexAniRun("Ani_Move_Pos_New", true)
      audioPostEvent_SystemUi(0, 28)
      if nextRewardItemIndex < self._maxRewardIndex then
        currentItemMouse:SetShow(true)
        currentItemBG:AddEffect("fUI_ingame_pass_02A", true, 0, 0)
      end
    else
      self._currentRewardIndex = nextRewardItemIndex
      local prevItemBG = UI.getChildControl(prevProductBG, "Static_ItemIcon_Basic_BG")
      local prevItemStamp = UI.getChildControl(prevItemBG, "Static_Stamp")
      local prevItemMouse = UI.getChildControl(prevItemBG, "Static_KeyGuide_PCUI")
      local prevItemControl = UI.getChildControl(prevItemBG, "Static_IconSlot")
      local currentItemBG = UI.getChildControl(currentProductBG, "Static_ItemIcon_Basic_BG")
      local currentItemMouse = UI.getChildControl(currentItemBG, "Static_KeyGuide_PCUI")
      prevItemControl:SetMonoTone(true)
      prevItemStamp:SetShow(true)
      prevItemMouse:SetShow(false)
      prevItemBG:EraseAllEffect()
      prevItemBG:AddEffect("fUI_ingame_pass_03A", false, 0, 0)
      prevItemStamp:ResetVertexAni()
      prevItemStamp:SetVertexAniRun("Ani_Scale_New", true)
      prevItemStamp:SetVertexAniRun("Ani_Move_Pos_New", true)
      audioPostEvent_SystemUi(0, 28)
      if nextRewardItemIndex < self._maxRewardIndex then
        currentItemMouse:SetShow(true)
        currentItemBG:AddEffect("fUI_ingame_pass_02A", true, 0, 0)
      end
    end
  end
  if nextRewardItemIndex - 1 < self._currentRewardIndex and nextRewardItemIndex - 1 < self._currentPassRewardIndex then
    local soldoutBG = UI.getChildControl(prevProductBG, "Static_Soldout_BG")
    if soldoutBG ~= nil then
      soldoutBG:SetShow(true)
    end
  end
end
function PaGlobal_SpecialPass:useSpecialPass(key)
  if self._currentPassKey ~= key then
    return
  end
  if key == nil or key == 0 then
    return
  end
  self._isPassUser = true
  self:updatePass()
end
function PaGlobal_SpecialPass:createTemplate()
  if #self._itemList ~= 0 then
    return
  end
  for idx = 0, __eSPECIALPASS_MAX_COUNT - 1 do
    local productBG = UI.cloneControl(self._ui.stc_ProductBG, self._ui.list2_Content, "Static_ProductBG_" .. tostring(idx))
    if productBG == nil then
      _PA_ASSERT(false, "\236\138\164\237\142\152\236\133\156 \237\140\168\236\138\164 productBG Clone \236\139\164\237\140\168!")
      return
    end
    self._itemList[idx] = productBG
    local basicSlot = {}
    local basicItemBG = UI.getChildControl(productBG, "Static_ItemIcon_Basic_BG")
    basicSlot.control = UI.getChildControl(basicItemBG, "Static_IconSlot")
    SlotItem.new(basicSlot, "Static_BasicItemSlot_" .. idx, 0, basicSlot.control, self._slotConfig)
    basicSlot:createChild()
    local passSlot = {}
    local passItemBG = UI.getChildControl(productBG, "Static_ItemIcon_Special_BG")
    passSlot.control = UI.getChildControl(passItemBG, "Static_IconSlot")
    SlotItem.new(passSlot, "Static_PassItemSlot_" .. idx, 0, passSlot.control, self._slotConfig)
    passSlot:createChild()
  end
  self._ui.stc_ProductBG:SetShow(false)
end
function FromClient_SetSpecialPassInfo(specialPassKey, currentRewardIndex, currentPassRewardIndex, maxRewardIndex, itemCount, isPassUser, isShowBuyButton, currentRewardPoint)
  local self = PaGlobal_SpecialPass
  if self == nil then
    return
  end
  if Panel_Event_SpecialPass_All == nil then
    return
  end
  if specialPassKey == 0 then
    return
  end
  if self._ui.stc_Title == nil or self._ui.txt_Date == nil or self._ui.txt_Desc == nil then
    return
  end
  if self._ui.btn_PearlShop == nil then
    return
  end
  self._currentRewardIndex = currentRewardIndex
  self._currentPassRewardIndex = currentPassRewardIndex
  self._currentRewardPoint = currentRewardPoint
  self._maxRewardIndex = maxRewardIndex
  self._itemCount = itemCount
  self._isPassUser = isPassUser
  self._isPurchasablePassItem = isShowBuyButton
  self._ui.txt_RateView:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RATEDESC_HERE_CLICK"))
  local extraSizeY = 20
  self._ui.btn_PearlShop:SetShow(isShowBuyButton)
  self._ui.stc_Title:SetText(ToClient_GetSpecialPassTitle(specialPassKey))
  self._ui.txt_Date:SetText(ToClient_GetSpecialPassPeriod(specialPassKey))
  self._ui.txt_Desc:SetText(ToClient_GetSpecialPassDesc(specialPassKey))
  self._ui.txt_Desc:SetSize(self._ui.txt_Desc:GetSizeX(), self._ui.txt_Desc:GetTextSizeY())
  self._ui.txt_RateView:SetSize(self._ui.txt_RateView:GetSizeX(), self._ui.txt_RateView:GetTextSizeY())
  self._ui.txt_RateView:SetSpanSize(self._ui.txt_RateView:GetSpanSize().x, self._ui.txt_Desc:GetSpanSize().y + self._ui.txt_Desc:GetSizeY())
  self._ui.stc_BottomDesc:SetSize(self._ui.stc_BottomDesc:GetSizeX(), self._ui.txt_Desc:GetSizeY() + self._ui.txt_RateView:GetSizeY() + extraSizeY)
  local posY = self._ui.stc_TitleArea:GetSizeY() + self._ui.stc_MainBG:GetSizeY() + self._ui.stc_BottomDesc:GetSizeY() + extraSizeY
  Panel_Event_SpecialPass_All:SetSize(Panel_Event_SpecialPass_All:GetSizeX(), posY)
  Panel_Event_SpecialPass_All:ComputePosAllChild()
end
function FromClient_UpdateSpecialPassItem(nextRewardItemIndex, isPassItem)
  if Panel_Event_SpecialPass_All == nil then
    return
  end
  PaGlobal_SpecialPass:updateRewardItem(nextRewardItemIndex, isPassItem)
end
function FromClient_UseSpecialPass(key)
  if Panel_Event_SpecialPass_All == nil then
    return
  end
  PaGlobal_SpecialPass:useSpecialPass(key)
end
function FromClient_SpecialPassFunctionEffect()
  if Panel_Event_SpecialPass_All == nil then
    return
  end
  if PaGlobal_SpecialPassEffectAvailable ~= nil then
    PaGlobal_SpecialPassEffectAvailable()
  end
end
registerEvent("FromClient_SetSpecialPassInfo", "FromClient_SetSpecialPassInfo")
registerEvent("FromClient_UpdateSpecialPassItem", "FromClient_UpdateSpecialPassItem")
registerEvent("FromClient_UseSpecialPass", "FromClient_UseSpecialPass")
registerEvent("FromClient_SpecialPassFunctionEffect", "FromClient_SpecialPassFunctionEffect")
