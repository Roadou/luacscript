function PaGlobal_Window_MailDetail_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  if true == self._isConsole then
    self._mainControl = Panel_Window_MailDetail_All
  else
    self._mainControl = UI.getChildControl(Panel_Window_Mail_All, "Static_MailDetail")
  end
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  if false == self._isConsole then
    self.panel_SizeY = self._mainControl:GetSizeY()
  else
    self.panel_SizeY = self._mainControl:GetSizeY() - (self._ui_pc.btn_close:GetSizeY() + 10)
  end
  self:SetUiSetting()
  self:registEventHandler()
  self:validate()
  if true == self.isConsole then
    self._mainControl:setGlassBackground(true)
  end
  SlotItem.new(self._ui.stc_itemSlot, "ItemIconSlot_", 0, self._ui.stc_itemSlotBG, self._slotConfig)
  self._ui.stc_itemSlot:createChild()
  if false == self._isConsole then
    self._ui.stc_itemSlot.icon:addInputEvent("Mouse_On", "PaGlobal_Window_MailDetail_All_ShowItemToolTip()")
    self._ui.stc_itemSlot.icon:addInputEvent("Mouse_Out", "PaGlobal_Window_MailDetail_All_HideItemToolTip()")
    self._ui.stc_itemSlot.icon:addInputEvent("Mouse_RUp", "HandleEventLUp_MailDetail_All_GetItem()")
  end
  self._ui.stc_itemSlotBG:SetShow(false)
  self._ui.stc_MailBottomBG:SetShow(true)
  self._ui.btn_checkAutoDelete:SetEnableArea(0, 0, self._ui.btn_checkAutoDelete:GetTextSizeX() + 30, self._ui.btn_checkAutoDelete:GetSizeY())
  self.mailTextSizeY = self._ui.frame_mailText:GetSizeY()
  self._initialize = true
end
function PaGlobal_Window_MailDetail_All:controlAll_Init()
  if nil == self._mainControl then
    return
  end
  if true == self._isConsole then
    self._ui.stc_centerBG = UI.getChildControl(self._mainControl, "Static_CenterBg")
  else
    self._ui.stc_centerBG = UI.getChildControl(self._mainControl, "Static_CenterBg_1")
  end
  self._ui.stc_mailContentBG = UI.getChildControl(self._ui.stc_centerBG, "Static_MailContentBg")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_centerBG, "StaticText_Title")
  self._ui.txt_sender = UI.getChildControl(self._ui.stc_centerBG, "StaticText_Sender")
  self._ui.frame_mailText = UI.getChildControl(self._ui.stc_centerBG, "Frame_MailText")
  self._ui.frame_mailContent = UI.getChildControl(self._ui.frame_mailText, "Frame_MailText_Content")
  self._ui.txt_mailContent = UI.getChildControl(self._ui.frame_mailContent, "StaticText_MailContent")
  self._ui.stc_mailExpirateDate = UI.getChildControl(self._ui.stc_centerBG, "Static_ExpirateDate")
  self._ui.txt_mailExpirateDate = UI.getChildControl(self._ui.stc_mailExpirateDate, "StaticText_Date")
  self._ui.frame_vScroll = UI.getChildControl(self._ui.frame_mailText, "Frame_MailText_VerticalScroll")
  self._ui.btn_vScrollUp = UI.getChildControl(self._ui.frame_vScroll, "Frame_MailText_VerticalScroll_UpButton")
  self._ui.btn_vScrollDown = UI.getChildControl(self._ui.frame_vScroll, "Frame_MailText_VerticalScroll_DownButton")
  self._ui.btn_vScrollCtrl = UI.getChildControl(self._ui.frame_vScroll, "Frame_MailText_VerticalScroll_CtrlButton")
  self._ui.frame_hScroll = UI.getChildControl(self._ui.frame_mailText, "Frame_MailText_HorizontalScroll")
  self._ui.btn_hScrollUp = UI.getChildControl(self._ui.frame_hScroll, "Frame_MailText_HorizontalScroll_UpButton")
  self._ui.btn_hScrollDown = UI.getChildControl(self._ui.frame_hScroll, "Frame_MailText_HorizontalScroll_DownButton")
  self._ui.btn_hScrollCtrl = UI.getChildControl(self._ui.frame_hScroll, "Frame_MailText_HorizontalScroll_CtrlButton")
  self._ui.stc_MailBottomBG = UI.getChildControl(self._ui.stc_centerBG, "Static_MailBtmBg")
  self._ui.stc_itemSlotBG = UI.getChildControl(self._ui.stc_centerBG, "Static_ItemSlotBg")
  self._ui.txt_itemEnClosed = UI.getChildControl(self._ui.stc_centerBG, "StaticText_ItemEnclosed")
  self._ui.txt_itemName = UI.getChildControl(self._ui.stc_centerBG, "StaticText_ItemName")
  self._ui.txt_itemCount = UI.getChildControl(self._ui.stc_centerBG, "StaticText_ItemCount")
  self._ui.btn_checkAutoDelete = UI.getChildControl(self._mainControl, "CheckButton_NullMailDelete")
  self.autoDeleteBaseSpanY = self._ui.btn_checkAutoDelete:GetSpanSize().y
end
function PaGlobal_Window_MailDetail_All:controlPc_Init()
  if nil == self._mainControl then
    return
  end
  local topBG
  if true == self._isConsole then
    topBG = UI.getChildControl(self._mainControl, "Static_TopBg")
  else
    topBG = UI.getChildControl(self._mainControl, "Static_TopBg_1")
  end
  self._ui_pc.btn_close = UI.getChildControl(topBG, "Button_Close_PCUI")
  self._ui_pc.btn_receive = UI.getChildControl(self._mainControl, "Button_Receive_PCUI")
  self._ui_pc.btn_delete = UI.getChildControl(self._mainControl, "Button_Delete_PCUI")
  self._ui_pc.btn_apply = UI.getChildControl(self._mainControl, "Button_Apply_PCUI")
end
function PaGlobal_Window_MailDetail_All:controlConsole_Init()
  if nil == self._mainControl then
    return
  end
  if true == self._isConsole then
    self._ui_console.stc_consoleBottomBG = UI.getChildControl(self._mainControl, "Static_BottomBg_ConsoleUI")
  else
    self._ui_console.stc_consoleBottomBG = UI.getChildControl(self._mainControl, "Static_BottomBg_1_ConsoleUI")
  end
  self._ui_console.txt_receiveItem = UI.getChildControl(self._ui_console.stc_consoleBottomBG, "StaticText_ReceiveItem")
  self._ui_console.txt_close = UI.getChildControl(self._ui_console.stc_consoleBottomBG, "StaticText_Close")
  self._ui_console.txt_mailDelete = UI.getChildControl(self._ui_console.stc_consoleBottomBG, "StaticText_MailDelete")
  if true == self._isConsole then
    self._ui_console.txt_scroll = UI.getChildControl(self._ui_console.stc_consoleBottomBG, "StaticText_Scroll")
    self._ui_console.txt_autoDelete = UI.getChildControl(self._ui_console.stc_consoleBottomBG, "StaticText_AutoDelete")
  end
end
function PaGlobal_Window_MailDetail_All:SetUiSetting()
  if nil == self._mainControl then
    return
  end
  self._ui_console.stc_consoleBottomBG:SetShow(self._isConsole)
  self._ui_pc.btn_close:SetShow(false == self._isConsole)
  self._ui_pc.btn_receive:SetShow(false == self._isConsole)
  self._ui_pc.btn_delete:SetShow(false == self._isConsole)
  if true == self._isConsole then
    local padding = 10
    local panelSizeY = self.panel_SizeY - (self._ui_pc.btn_close:GetSizeY() + padding)
    self._mainControl:SetSize(self._mainControl:GetSizeX(), panelSizeY)
    self._mainControl:ComputePosAllChild()
    self._ui_console.keyGuides = {
      self._ui_console.txt_receiveItem,
      self._ui_console.txt_close,
      self._ui_console.txt_mailDelete,
      self._ui_console.txt_scroll,
      self._ui_console.txt_autoDelete
    }
  end
  FromClient_Window_MailDetail_All_ReSizePanel()
end
function PaGlobal_Window_MailDetail_All:registEventHandler()
  if nil == self._mainControl then
    return
  end
  registerEvent("onScreenResize", "FromClient_Window_MailDetail_All_ReSizePanel()")
  registerEvent("ResponseMail_showDetail", "PaGlobal_Window_MailDetail_All_Open")
  registerEvent("FromClient_ShowMassMailDetail", "FromClient_MailDetail_All_ShowMassMailDetail")
  registerEvent("FromClient_ResponseMailGetItem", "FromClient_MailDetail_All_ResponseMailGetItem")
  if false == self._isConsole then
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Window_MailDetail_All_Close()")
    self._ui_pc.btn_delete:addInputEvent("Mouse_LUp", "HandleEventLUp_MailDetail_All_Delete()")
    self._ui_pc.btn_receive:addInputEvent("Mouse_LUp", "HandleEventLUp_MailDetail_All_GetItem()")
    self._ui.btn_checkAutoDelete:addInputEvent("Mouse_LUp", "HandleEventLUp_MailDetail_All_CheckAutoDeleteMail()")
  else
    self._mainControl:RegisterShowEventFunc(true, "PaGlobal_Window_MailDetail_All_ShowAni()")
    self._mainControl:RegisterShowEventFunc(false, "PaGlobal_Window_MailDetail_All_HideAni()")
    self._mainControl:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_MailDetail_All_Delete()")
    self._mainControl:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_MailDetail_All_GetItemConsole(false)")
    self._mainControl:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "PaGlobal_Window_MailDetail_All_MoveScroll(true)")
    self._mainControl:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "PaGlobal_Window_MailDetail_All_MoveScroll(false)")
    self._mainControl:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_MailDetail_All_ToggleAutoDelete()")
  end
end
function PaGlobal_Window_MailDetail_All:prepareOpen(mailNo)
  if nil == self._mainControl then
    return
  end
  self._ui.btn_checkAutoDelete:SetCheck(ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseDeleteMailAfterGetItem))
  self._ui.txt_mailContent:SetSize(self._ui.txt_mailContent:GetSizeX(), self._ui.txt_mailContent:GetTextSizeY())
  UIScroll.SetButtonSize(self._ui.frame_vScroll, self._ui.txt_mailContent:GetSizeY(), self._ui.txt_mailContent:GetTextSizeY())
  self._ui.frame_vScroll:SetControlPos(0)
  if true == self._isConsole and nil ~= Panel_Window_TotalReward_All and true == Panel_Window_TotalReward_All:GetShow() then
    PaGlobal_TotalReward_All_OpenWhenOtherPanel(3)
  end
  PaGlobal_Window_MailDetail_All:open()
end
function PaGlobal_Window_MailDetail_All:open()
  if nil == self._mainControl then
    return
  end
  self._mainControl:SetShow(true)
end
function PaGlobal_Window_MailDetail_All:prepareClose()
  if nil == self._mainControl then
    return
  end
  if true == self._isConsole and nil ~= Panel_Window_TotalReward_All and true == Panel_Window_TotalReward_All:GetShow() then
    PaGlobal_TotalReward_All_OpenWhenOtherPanel(1)
  end
  PaGlobal_Window_MailDetail_All:close()
end
function PaGlobal_Window_MailDetail_All:close()
  if nil == self._mainControl then
    return
  end
  self._mainControl:SetShow(false)
end
function PaGlobal_Window_MailDetail_All:getUtcTimeStr()
  local utcStr = ""
  if true == self._isConsole then
    utcStr = "(UTC)"
  elseif true == isGameTypeID() then
    utcStr = "(GMT+8)"
  elseif true == isGameTypeTR() then
    utcStr = "(GMT+3)"
  elseif true == isGameTypeNA() then
    utcStr = "(UTC)"
  elseif true == isGameTypeSA() then
    utcStr = "(BRT)"
  elseif true == isGameTypeRussia() then
    utcStr = "(MCK)"
  end
  return utcStr
end
function PaGlobal_Window_MailDetail_All:setMailInfo(mailNo)
  if nil == self._mainControl then
    return
  end
  FGlobal_CashShop_GoodsTooltipInfo_Close()
  Panel_Tooltip_Item_hideTooltip()
  self.openMailNo = mailNo
  self.isMassMail = false
  self._ui.txt_sender:SetText(RequestMail_getMailSenderName())
  self._ui.txt_title:SetText(RequestMail_getMailTitle())
  UI.setLimitTextAndAddTooltip(self._ui.txt_title, "", self._ui.txt_title:GetText())
  self._ui.txt_mailContent:SetAutoResize(true)
  self._ui.txt_mailContent:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_mailContent:SetText(RequestMail_getMailContents())
  self._ui.txt_itemName:SetTextMode(__eTextMode_LimitText)
  local deleteDate = RequestMail_getMailDeleteDate()
  if nil ~= deleteDate then
    local deleteDateTitle = PAGetString(Defines.StringSheet_GAME, "LUA_MAILDETAIL_DELETEDATE_TITLE")
    local monthStr = PAGetString(Defines.StringSheet_GAME, "LUA_DATEINFO_MONTH_" .. deleteDate:GetMonth())
    local dayStr = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GOODSDETAILINFO_SELLTIME", "GetYear", deleteDate:GetYear(), "GetMonth", monthStr, "GetDay", deleteDate:GetDay())
    local minuteStr = deleteDate:GetMinute()
    if minuteStr < 10 then
      minuteStr = "0" .. tostring(minuteStr)
    end
    local utcTimeStr = PaGlobal_Window_MailDetail_All:getUtcTimeStr()
    local timeStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BOSSALERT_ALARM_TIME", "hour", deleteDate:GetHour(), "minute", minuteStr) .. " " .. utcTimeStr
    local deleteDateStr = deleteDateTitle .. " " .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MAILDETAIL_DELETEDATE_VALUE", "day", dayStr, "time", timeStr)
    deleteDateStr = "<PAColor0xFFF26A6A>" .. deleteDateStr .. "<PAOldColor>"
    self._ui.txt_mailExpirateDate:SetText(deleteDateStr)
    self._ui.stc_mailExpirateDate:SetShow(true)
  else
    self._ui.stc_mailExpirateDate:SetShow(false)
  end
  if true == self._ui.stc_mailExpirateDate:GetShow() then
    self._ui.frame_mailText:SetSize(self._ui.frame_mailText:GetSizeX(), self.mailTextSizeY - self._ui.stc_mailExpirateDate:GetSizeY())
  else
    self._ui.frame_mailText:SetSize(self._ui.frame_mailText:GetSizeX(), self.mailTextSizeY)
  end
  local textSizeY = self._ui.txt_mailContent:GetSizeY()
  local frameSizeY = self._ui.frame_mailText:GetSizeY()
  self._ui.frame_mailContent:SetSize(self._ui.frame_mailContent:GetSizeX(), textSizeY)
  UIScroll.SetButtonSize(self._ui.frame_vScroll, frameSizeY, textSizeY)
  self._ui.frame_vScroll:SetControlPos(0)
  self._ui.txt_itemCount:SetShow(false)
  self._ui.txt_itemEnClosed:SetShow(false)
  self._ui.stc_MailBottomBG:SetShow(true)
  local isExistItem = false
  if 1 == RequestMail_getMailType() then
    local mailCashProductNoRaw = RequestMail_getMailCashProductNoRaw()
    local cPSSW
    if 0 ~= mailCashProductNoRaw then
      cPSSW = ToClient_GetCashProductStaticStatusWrapperByKeyRaw(mailCashProductNoRaw)
    end
    local itemCount_s64 = RequestMail_getMailItemCount()
    local itemCount = Int64toInt32(itemCount_s64)
    self._ui.txt_itemEnClosed:SetShow(itemCount >= 1)
    self._ui.txt_itemCount:SetShow(itemCount >= 1)
    local itemCountString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MAIL_DETAIL_ITEM_COUNT_TITLE", "count", makeDotMoney(itemCount))
    self._ui.txt_itemCount:SetText(itemCountString)
    isExistItem = itemCount >= 1
    if nil ~= cPSSW then
      self._ui.txt_itemName:SetShow(itemCount >= 1)
      self._ui.txt_itemName:SetText(cPSSW:getName())
      self._ui.stc_itemSlot:clearItem()
      self._ui.stc_itemSlot:setItemByCashProductStaticStatus(cPSSW, RequestMail_getMailItemCount())
      self._ui.stc_itemSlotBG:SetShow(true)
      self._ui.stc_itemSlot.icon:SetShow(true)
      if false == self._isConsole then
        self._ui_pc.btn_receive:SetShow(true)
      else
        self._ui_console.txt_receiveItem:SetShow(true)
      end
      self._ui.stc_MailBottomBG:SetShow(true)
    else
      self._ui.stc_itemSlot:clearItem()
      self._ui.stc_itemSlotBG:SetShow(false)
      self._ui.stc_itemSlot.icon:SetShow(false)
      self._ui.txt_itemName:SetShow(false)
      self._ui.txt_itemEnClosed:SetShow(false)
      if false == self._isConsole then
        self._ui_pc.btn_receive:SetShow(false)
      else
        self._ui_console.txt_receiveItem:SetShow(true)
      end
      self._ui.stc_MailBottomBG:SetShow(false)
    end
  else
    local mailItem = mail_getMailItemStatic()
    if nil ~= mailItem then
      self._ui.stc_itemSlot:clearItem()
      self._ui.stc_itemSlot:setItemByStaticStatus(mailItem, RequestMail_getMailItemCount())
      self._ui.stc_itemSlotBG:SetShow(true)
      self._ui.stc_itemSlot.icon:SetShow(true)
      self._ui.txt_itemName:SetShow(true)
      self._ui.txt_itemEnClosed:SetShow(true)
      if false == self._isConsole then
        self._ui_pc.btn_receive:SetShow(true)
      else
        self._ui_console.txt_receiveItem:SetShow(true)
      end
      local itemKey = mailItem:get()._key:getItemKey()
      local itemCount_s64 = RequestMail_getMailItemCount()
      local itemCount = itemCount_s64
      local silverString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MAIL_DETAIL_SILVER_COUNT_TITLE", "value", makeDotMoney(itemCount_s64))
      local itemCountString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MAIL_DETAIL_ITEM_COUNT_TITLE", "count", makeDotMoney(itemCount_s64))
      isExistItem = itemCount_s64 >= toInt64(0, 1)
      self._ui.txt_itemCount:SetShow(itemCount > toInt64(0, 1))
      if 1 == itemKey then
        self._ui.txt_itemCount:SetText(silverString)
      else
        self._ui.txt_itemCount:SetText(itemCountString)
      end
      self._ui.txt_itemName:SetShow(true)
      self._ui.txt_itemName:SetText(mailItem:getName())
      self._ui.txt_itemEnClosed:SetShow(true)
      self._ui.stc_MailBottomBG:SetShow(true)
    else
      self._ui.stc_MailBottomBG:SetShow(false)
      self._ui.stc_itemSlot:clearItem()
      self._ui.stc_itemSlotBG:SetShow(false)
      self._ui.stc_itemSlot.icon:SetShow(false)
      self._ui.txt_itemName:SetShow(false)
      self._ui.txt_itemEnClosed:SetShow(false)
      if false == self._isConsole then
        self._ui_pc.btn_receive:SetShow(false)
      else
        self._ui_console.txt_receiveItem:SetShow(false)
      end
      self._ui.txt_itemCount:SetShow(false)
    end
  end
  self._ui.btn_checkAutoDelete:SetShow(isExistItem)
  if self._isConsole == true then
    self._ui_console.txt_autoDelete:SetShow(isExistItem)
  end
  PaGlobal_Window_MailDetail_All:SetDynamicPanelSize()
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._ui_console.keyGuides, self._ui_console.stc_consoleBottomBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Window_MailDetail_All:CheckItemGetAfterDelete(mailNo)
  if self._mainControl == nil then
    return
  end
  if self.openMailNo == nil or self.openMailNo ~= mailNo then
    return false
  end
  if self._ui.btn_checkAutoDelete:GetShow() == false then
    return false
  end
  if self._ui.btn_checkAutoDelete:IsCheck() == false then
    return false
  end
  local isDeleteMail = false
  local itemCount_s64 = toInt64(0, 0)
  if self.isMassMail == true then
    itemCount_s64 = ToClient_GetSelectedMassMailItemCount()
  else
    itemCount_s64 = RequestMail_getMailItemCount()
  end
  if itemCount_s64 < toInt64(0, 1) then
    isDeleteMail = true
    if self.isMassMail == true then
      ToClient_RemoveMassMail(mailNo)
    else
      RequestMail_removeMail(mailNo, true)
    end
    self.openMailNo = nil
    PaGlobal_Window_MailDetail_All_Close()
  end
  return isDeleteMail
end
function PaGlobal_Window_MailDetail_All:SetDynamicPanelSize()
  if true == self._isConsole then
    local topBG = UI.getChildControl(self._mainControl, "Static_TopBg")
    self._ui.stc_centerBG = UI.getChildControl(self._mainControl, "Static_CenterBg")
    self.panel_SizeY = topBG:GetSizeY() + self._ui.stc_centerBG:GetSizeY() + 10
    if self._ui.btn_checkAutoDelete:GetShow() == true then
      self.panel_SizeY = self.panel_SizeY + self._ui.btn_checkAutoDelete:GetSizeY() + 20
      self._ui.btn_checkAutoDelete:SetSpanSize(self._ui.btn_checkAutoDelete:GetSpanSize().x, self.autoDeleteBaseSpanY)
    end
    self._mainControl:SetSize(self._mainControl:GetSizeX(), self.panel_SizeY)
  else
    local panelSetSizeY = self.panel_SizeY
    if false == self._ui.stc_MailBottomBG:GetShow() then
      panelSetSizeY = panelSetSizeY - self._ui.stc_MailBottomBG:GetSizeY() - 10
    end
    if self._ui.btn_checkAutoDelete:GetShow() == false then
      panelSetSizeY = panelSetSizeY - self._ui.btn_checkAutoDelete:GetSizeY() - 20
    else
      self._ui.btn_checkAutoDelete:SetSpanSize(self._ui.btn_checkAutoDelete:GetSpanSize().x, self.autoDeleteBaseSpanY)
    end
    self._mainControl:SetSize(self._mainControl:GetSizeX(), panelSetSizeY)
  end
  self._mainControl:ComputePosAllChild()
  self:reposition()
end
function PaGlobal_Window_MailDetail_All:setScrollSize()
  self._ui.txt_mailContent:SetSize(self._ui.txt_mailContent:GetSizeX(), self._ui.txt_mailContent:GetTextSizeY())
  UIScroll.SetButtonSize(self._ui.frame_vScroll, self._ui.frame_mailContent:GetSizeY(), self._ui.txt_mailContent:GetTextSizeY())
  self._ui.frame_vScroll:SetControlPos(0)
end
function PaGlobal_Window_MailDetail_All:validate()
  if nil == self._mainControl then
    return
  end
  self:allValidate()
  self:pcValidate()
  self:consoleValidate()
end
function PaGlobal_Window_MailDetail_All:allValidate()
  if nil == self._mainControl then
    return
  end
  self._ui.stc_centerBG:isValidate()
  self._ui.stc_mailContentBG:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.txt_sender:isValidate()
  self._ui.frame_mailText:isValidate()
  self._ui.frame_mailContent:isValidate()
  self._ui.txt_mailContent:isValidate()
  self._ui.frame_vScroll:isValidate()
  self._ui.btn_vScrollUp:isValidate()
  self._ui.btn_vScrollDown:isValidate()
  self._ui.btn_vScrollCtrl:isValidate()
  self._ui.frame_hScroll:isValidate()
  self._ui.btn_hScrollUp:isValidate()
  self._ui.btn_hScrollDown:isValidate()
  self._ui.btn_hScrollCtrl:isValidate()
  self._ui.stc_MailBottomBG:isValidate()
  self._ui.stc_itemSlotBG:isValidate()
  self._ui.txt_itemEnClosed:isValidate()
  self._ui.txt_itemName:isValidate()
  self._ui.txt_itemCount:isValidate()
end
function PaGlobal_Window_MailDetail_All:pcValidate()
  if nil == self._mainControl then
    return
  end
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_receive:isValidate()
  self._ui_pc.btn_delete:isValidate()
  self._ui_pc.btn_apply:isValidate()
end
function PaGlobal_Window_MailDetail_All:consoleValidate()
  if nil == self._mainControl then
    return
  end
  self._ui_console.stc_consoleBottomBG:isValidate()
  self._ui_console.txt_receiveItem:isValidate()
  self._ui_console.txt_close:isValidate()
  self._ui_console.txt_mailDelete:isValidate()
end
function PaGlobal_Window_MailDetail_All:reposition()
  if nil == Panel_Window_Mail_All or nil == self._mainControl then
    return
  end
  if true == self._isConsole then
    local posX = Panel_Window_Mail_All:GetPosX()
    local posY = Panel_Window_Mail_All:GetPosY()
    local screenSizeX = getScreenSizeX()
    local screenSizeY = getScreenSizeY()
    local sizeX = Panel_Window_Mail_All:GetSizeX()
    local detailSizeX = self._mainControl:GetSizeX()
    if screenSizeX > posX + sizeX + detailSizeX then
      self._mainControl:SetPosX(posX + sizeX)
    else
      self._mainControl:SetPosX(posX - detailSizeX)
    end
    self._mainControl:SetPosY(Panel_Window_Mail_All:GetPosY())
  else
    self._mainControl:ComputePos()
  end
end
