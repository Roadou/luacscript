function PaGlobal_ArtifactsExchange:initialize()
  if self._initialize == true then
    return
  end
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ArtifactsExchange:controlAll_Init()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  self._ui.stc_TitleBarArea = UI.getChildControl(Panel_Window_Artifacts_Exchange_All, "Static_TitlebarArea")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_TitleBarArea, "Button_Close")
  self._ui.stc_RadioButtonBG = UI.getChildControl(Panel_Window_Artifacts_Exchange_All, "Static_RadioBtn_BG")
  self._ui.rdo_Exchange = UI.getChildControl(self._ui.stc_RadioButtonBG, "RadioButton_Exchange")
  self._ui.rdo_Purify = UI.getChildControl(self._ui.stc_RadioButtonBG, "RadioButton_Purify")
  self._ui.stc_SelectBar = UI.getChildControl(self._ui.stc_RadioButtonBG, "Static_SelectBar")
  self._ui.stc_ExchangeBG = UI.getChildControl(Panel_Window_Artifacts_Exchange_All, "Static_Exchange_BG")
  self._ui.stc_ExchangeEffect = UI.getChildControl(self._ui.stc_ExchangeBG, "Static_Effect")
  self._ui.stc_ExchangeRewardSlot = UI.getChildControl(self._ui.stc_ExchangeBG, "Static_Slot")
  self._ui.txt_ExchangeDesc = UI.getChildControl(self._ui.stc_ExchangeBG, "StaticText_Desc")
  self._ui.txt_ExchangeMultiline = UI.getChildControl(self._ui.txt_ExchangeDesc, "MultilineText_1")
  self._ui.txt_ExchangeFinish = UI.getChildControl(self._ui.txt_ExchangeDesc, "MultilineText_2")
  self._ui.frame = UI.getChildControl(self._ui.stc_ExchangeBG, "Frame_1")
  self._ui.frame_Content = UI.getChildControl(self._ui.frame, "Frame_1_Content")
  self._ui.frame_VerticalScroll = UI.getChildControl(self._ui.frame, "Frame_1_VerticalScroll")
  self._ui.stc_ExchangeSlot = UI.getChildControl(self._ui.frame_Content, "Static_Slot_Temp")
  self._ui.btn_PutInAll = UI.getChildControl(self._ui.stc_ExchangeBG, "Button_PutInAll")
  self._ui.chk_ExchangeSkipAni = UI.getChildControl(self._ui.stc_ExchangeBG, "CheckButton_SkipAni")
  self._ui.btn_Exchange = UI.getChildControl(self._ui.stc_ExchangeBG, "Button_Exchange")
  self._ui.btn_link = UI.getChildControl(self._ui.stc_ExchangeBG, "Button_Percent")
  self._ui.stc_PurifyBG = UI.getChildControl(Panel_Window_Artifacts_Exchange_All, "Static_Purify_BG")
  self._ui.stc_PurifyEffect = UI.getChildControl(self._ui.stc_PurifyBG, "Static_Effect")
  self._ui.stc_PurifyBaseBG = UI.getChildControl(self._ui.stc_PurifyBG, "Static_Purify_Base")
  self._ui.stc_PurifyFireBG = UI.getChildControl(self._ui.stc_PurifyBG, "Static_Purify_Fire")
  self._ui.stc_PurifyEarthBG = UI.getChildControl(self._ui.stc_PurifyBG, "Static_Purify_Earth")
  self._ui.stc_PurifyWindBG = UI.getChildControl(self._ui.stc_PurifyBG, "Static_Purify_Wind")
  self._ui.stc_PurifyGrassBG = UI.getChildControl(self._ui.stc_PurifyBG, "Static_Purify_Grass")
  self._ui.stc_PurifyRewardSlot = UI.getChildControl(self._ui.stc_PurifyBG, "Static_Slot")
  self._ui.txt_PurifyDesc = UI.getChildControl(self._ui.stc_PurifyBG, "StaticText_Desc")
  self._ui.txt_PurifyMultiline = UI.getChildControl(self._ui.txt_PurifyDesc, "MultilineText_1")
  self._ui.txt_PurifyFinish = UI.getChildControl(self._ui.txt_PurifyDesc, "MultilineText_2")
  self._ui.stc_Material = UI.getChildControl(self._ui.stc_PurifyBG, "Static_Meterial")
  self._ui.stc_PurifySlotBG = UI.getChildControl(self._ui.stc_Material, "Static_SlotBG_Temp")
  self._ui.stc_PurifySlot = UI.getChildControl(self._ui.stc_Material, "Static_Slot_Temp")
  self._ui.stc_SilverBG = UI.getChildControl(self._ui.stc_PurifyBG, "Static_Silver_BG")
  self._ui.stc_SilverValue = UI.getChildControl(self._ui.stc_SilverBG, "StaticText_Value")
  self._ui.stc_MoneyArea = UI.getChildControl(self._ui.stc_PurifyBG, "Static_MyMoneyArea")
  self._ui.txt_MoneyValue = UI.getChildControl(self._ui.stc_MoneyArea, "StaticText_MoneyValue")
  self._ui.chk_PurifySkipAni = UI.getChildControl(self._ui.stc_PurifyBG, "CheckButton_SkipAni")
  self._ui.btn_Purify = UI.getChildControl(self._ui.stc_PurifyBG, "Button_Purify")
  self._ui.stc_ExchangeSlot:SetShow(false)
  self._ui.btn_link:SetText(self._ui.btn_link:GetText())
  self._ui.btn_link:SetSize(self._ui.btn_link:GetTextSizeX() + 20, self._ui.btn_link:GetSizeY())
  self._panelSizeY = Panel_Window_Artifacts_Exchange_All:GetSizeY()
  self:createSlots()
end
function PaGlobal_ArtifactsExchange:controlPc_Init()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
end
function PaGlobal_ArtifactsExchange:controlConsole_Init()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  self._ui.LBUI = UI.getChildControl(self._ui.stc_RadioButtonBG, "Static_LB_ConsoleUI")
  self._ui.RBUI = UI.getChildControl(self._ui.stc_RadioButtonBG, "Static_RB_ConsoleUI")
  self._ui.stc_BottomConsole = UI.getChildControl(Panel_Window_Artifacts_Exchange_All, "Static_BottomConsoleButtons")
  self._ui.btn_KeyGuideDetail = UI.getChildControl(self._ui.stc_BottomConsole, "Button_Detail")
  self._ui.btn_KeyGuideSelect = UI.getChildControl(self._ui.stc_BottomConsole, "Button_Select")
  self._ui.btn_KeyGuideCancel = UI.getChildControl(self._ui.stc_BottomConsole, "Button_Cancel")
  self._ui.btn_KeyGuidePurify = UI.getChildControl(self._ui.stc_BottomConsole, "Button_Purify")
  self._ui.btn_KeyGuideExchange = UI.getChildControl(self._ui.stc_BottomConsole, "Button_Exchange")
  self._ui.btn_KeyGuidePushAll = UI.getChildControl(self._ui.stc_BottomConsole, "StaticText_Y_ConsoleUI")
  self._ui.btn_KeyGuideRateView = UI.getChildControl(self._ui.stc_BottomConsole, "StaticText_LBX_ConsoleUI")
  self._ui.stc_BottomConsole:SetShow(true)
  self._ui.btn_PutInAll:SetShow(false)
  self._ui.btn_Exchange:SetShow(false)
  self._ui.btn_Purify:SetShow(false)
  Panel_Window_Artifacts_Exchange_All:SetSize(Panel_Window_Artifacts_Exchange_All:GetSizeX(), Panel_Window_Artifacts_Exchange_All:GetSizeY() - self._ui.btn_Exchange:GetSizeY())
  self._ui.stc_ExchangeBG:SetSize(self._ui.stc_ExchangeBG:GetSizeX(), self._ui.stc_ExchangeBG:GetSizeY() - self._ui.btn_Exchange:GetSizeY())
  self._ui.stc_PurifyBG:SetSize(self._ui.stc_PurifyBG:GetSizeX(), self._ui.stc_PurifyBG:GetSizeY() - self._ui.btn_Purify:GetSizeY())
  self._ui.stc_BottomConsole:SetPosY(Panel_Window_Artifacts_Exchange_All:GetSizeY())
end
function PaGlobal_ArtifactsExchange:registEventHandler()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_ArtifactExchange_Close()")
  self._ui.rdo_Exchange:addInputEvent("Mouse_LUp", "HandleEventLUp_SelectTab(true)")
  self._ui.rdo_Purify:addInputEvent("Mouse_LUp", "HandleEventLUp_SelectTab(false)")
  self._ui.btn_PutInAll:addInputEvent("Mouse_LUp", "HandleEventLUp_PushAllLightStone()")
  self._ui.btn_Exchange:addInputEvent("Mouse_LUp", "HandleEventLUp_Exchange()")
  self._ui.btn_link:SetShow(true)
  self._ui.btn_Purify:addInputEvent("Mouse_LUp", "HandleEventLUp_Purify()")
  UIScroll.InputEvent(self._ui.frame_VerticalScroll, "ExchangeSlot_Scroll")
  self._ui.frame:addInputEvent("Mouse_UpScroll", "ExchangeSlot_Scroll( true )")
  self._ui.frame:addInputEvent("Mouse_DownScroll", "ExchangeSlot_Scroll( false )")
  self._ui.frame_VerticalScroll:SetInterval(1)
  self._ui.btn_link:addInputEvent("Mouse_LUp", "PaGlobalFunc_ClickedEvent_RateLink()")
  Panel_Window_Artifacts_Exchange_All:RegisterUpdateFunc("PaGlobal_LightStone_UpdateAni")
  if self._isConsole == true then
    self._ui.btn_link:SetShow(false)
    Panel_Window_Artifacts_Exchange_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "HandleEventLUp_SelectTab(true)")
    Panel_Window_Artifacts_Exchange_All:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "HandleEventLUp_SelectTab(false)")
    Panel_Window_Artifacts_Exchange_All:registerPadEvent(__eConsoleUIPadEvent_LBPress_X, "PaGlobalFunc_Util_OpenRateView(PaGlobalFunc_DialogMain_All_Close)")
  end
end
function PaGlobal_ArtifactsExchange:prepareOpen()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  if _ContentsGroup_NewUI_Inventory_All == true then
    PaGlobalFunc_Inventory_All_SetInventoryDragNoUse(Panel_Window_Artifacts_Exchange_All)
  else
    FGlobal_SetInventoryDragNoUse(Panel_Window_Artifacts_Exchange_All)
  end
  HandleEventLUp_SelectTab(true)
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  Panel_Window_Artifacts_Exchange_All:ComputePos()
  self:open()
end
function PaGlobal_ArtifactsExchange:open()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  Panel_Window_Artifacts_Exchange_All:SetShow(true)
  if self._isConsole == true then
    if PaGlobalFunc_InventoryInfo_Open ~= nil then
      PaGlobalFunc_InventoryInfo_Open()
    end
  elseif PaGlobalFunc_Inventory_All_SetShow ~= nil then
    PaGlobalFunc_Inventory_All_SetShow(true)
  end
end
function PaGlobal_ArtifactsExchange:prepareClose()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  self:clearExchangeSlots()
  self:changeExchangeRewardSlot()
  self._ui.txt_ExchangeFinish:SetShow(false)
  self._ui.txt_PurifyFinish:SetShow(false)
  self:close()
end
function PaGlobal_ArtifactsExchange:close()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  Panel_Window_Artifacts_Exchange_All:SetShow(false)
  if self._isConsole == true then
    if PaGlobalFunc_InventoryInfo_Close ~= nil then
      PaGlobalFunc_InventoryInfo_Close()
    end
  elseif PaGlobalFunc_Inventory_All_SetShow ~= nil then
    PaGlobalFunc_Inventory_All_SetShow(false)
  end
end
function PaGlobal_ArtifactsExchange:validate()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  self._ui.stc_TitleBarArea:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.stc_RadioButtonBG:isValidate()
  self._ui.rdo_Exchange:isValidate()
  self._ui.rdo_Purify:isValidate()
  self._ui.stc_SelectBar:isValidate()
  self._ui.stc_ExchangeBG:isValidate()
  self._ui.stc_ExchangeEffect:isValidate()
  self._ui.stc_ExchangeRewardSlot:isValidate()
  self._ui.txt_ExchangeDesc:isValidate()
  self._ui.txt_ExchangeMultiline:isValidate()
  self._ui.txt_ExchangeFinish:isValidate()
  self._ui.frame:isValidate()
  self._ui.frame_Content:isValidate()
  self._ui.frame_VerticalScroll:isValidate()
  self._ui.stc_ExchangeSlot:isValidate()
  self._ui.btn_PutInAll:isValidate()
  self._ui.chk_ExchangeSkipAni:isValidate()
  self._ui.btn_Exchange:isValidate()
  self._ui.stc_PurifyBG:isValidate()
  self._ui.stc_PurifyEffect:isValidate()
  self._ui.stc_PurifyBaseBG:isValidate()
  self._ui.stc_PurifyFireBG:isValidate()
  self._ui.stc_PurifyEarthBG:isValidate()
  self._ui.stc_PurifyWindBG:isValidate()
  self._ui.stc_PurifyGrassBG:isValidate()
  self._ui.stc_PurifyRewardSlot:isValidate()
  self._ui.txt_PurifyDesc:isValidate()
  self._ui.txt_PurifyMultiline:isValidate()
  self._ui.txt_PurifyFinish:isValidate()
  self._ui.stc_Material:isValidate()
  self._ui.stc_PurifySlotBG:isValidate()
  self._ui.stc_PurifySlot:isValidate()
  self._ui.stc_SilverBG:isValidate()
  self._ui.stc_SilverValue:isValidate()
  self._ui.chk_PurifySkipAni:isValidate()
  self._ui.btn_Purify:isValidate()
end
function PaGlobal_ArtifactsExchange:resize()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
end
function PaGlobal_ArtifactsExchange:selectTab(isExchange)
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  local posX = 0
  if isExchange == true then
    posX = PaGlobal_ArtifactsExchange._ui.rdo_Exchange:GetPosX() + PaGlobal_ArtifactsExchange._ui.rdo_Exchange:GetSizeX() * 0.5 - PaGlobal_ArtifactsExchange._ui.stc_SelectBar:GetSizeX() * 0.5
    PaGlobal_ArtifactsExchange._ui.stc_SelectBar:SetPosXY(posX, PaGlobal_ArtifactsExchange._ui.stc_SelectBar:GetPosY())
    Inventory_SetFunctor(PaGlobalFunc_ArtifactExchange_Filter, PaGlobalFunc_ArtifactExchange_RClickFunction, nil, nil)
    self:changeExchangeDesc()
    self:changeExchangeRewardSlot()
    self:clearPurifySlot()
    self:clearPurifyRewardSlot()
    self:setShowSuccessDesc(false, false)
    self._ui.frame_VerticalScroll:SetControlTop()
    self.scrollIndex = 0
    self:updateExchangeSlot(true, true)
    if self._isConsole == true then
      ToClient_padSnapChangeToTarget(self._ui.stc_ExchangeBG)
      Panel_Window_Artifacts_Exchange_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Exchange()")
      Panel_Window_Artifacts_Exchange_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_PushAllLightStone()")
      self._ui.btn_KeyGuideDetail:SetShow(false)
      self._ui.btn_KeyGuideSelect:SetShow(false)
      self._ui.btn_KeyGuideCancel:SetShow(false)
      self._ui.btn_KeyGuidePurify:SetShow(false)
      self._ui.btn_KeyGuideExchange:SetShow(false)
      self._ui.btn_KeyGuidePushAll:SetShow(false)
      self._ui.btn_KeyGuideRateView:SetShow(false)
      local keyGuideList = {
        self._ui.btn_KeyGuideDetail,
        self._ui.btn_KeyGuideSelect,
        self._ui.btn_KeyGuideCancel,
        self._ui.btn_KeyGuideExchange,
        self._ui.btn_KeyGuidePushAll,
        self._ui.btn_KeyGuideRateView
      }
      for idx, keyGuide in pairs(keyGuideList) do
        keyGuide:SetShow(true)
      end
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui.stc_BottomConsole, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    end
    if self._isConsole == true then
      Panel_Window_Artifacts_Exchange_All:SetSize(Panel_Window_Artifacts_Exchange_All:GetSizeX(), self._panelSizeY + 50 - self._ui.btn_Exchange:GetSizeY())
      self._ui.stc_BottomConsole:SetPosY(Panel_Window_Artifacts_Exchange_All:GetSizeY())
    else
      Panel_Window_Artifacts_Exchange_All:SetSize(Panel_Window_Artifacts_Exchange_All:GetSizeX(), self._panelSizeY + 50)
    end
  else
    posX = PaGlobal_ArtifactsExchange._ui.rdo_Purify:GetPosX() + PaGlobal_ArtifactsExchange._ui.rdo_Exchange:GetSizeX() * 0.5 - PaGlobal_ArtifactsExchange._ui.stc_SelectBar:GetSizeX() * 0.5
    PaGlobal_ArtifactsExchange._ui.stc_SelectBar:SetPosXY(posX, PaGlobal_ArtifactsExchange._ui.stc_SelectBar:GetPosY())
    Panel_Window_Artifacts_Exchange_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Purify()")
    self:changePurifyDesc()
    self:clearExchangeSlots()
    self:changeExchangeRewardSlot()
    self:setShowSuccessDesc(true, false)
    Inventory_SetFunctor(PaGlobalFunc_ArtifactPurify_Filter, PaGlobalFunc_ArtifactPurify_RClickFunction, nil, nil)
    if self._isConsole == true then
      ToClient_padSnapChangeToTarget(self._ui.stc_PurifyBG)
      self._ui.btn_KeyGuideDetail:SetShow(false)
      self._ui.btn_KeyGuideSelect:SetShow(false)
      self._ui.btn_KeyGuideCancel:SetShow(false)
      self._ui.btn_KeyGuidePurify:SetShow(false)
      self._ui.btn_KeyGuideExchange:SetShow(false)
      self._ui.btn_KeyGuidePushAll:SetShow(false)
      self._ui.btn_KeyGuideRateView:SetShow(false)
      local keyGuideList = {
        self._ui.btn_KeyGuideDetail,
        self._ui.btn_KeyGuideSelect,
        self._ui.btn_KeyGuideCancel,
        self._ui.btn_KeyGuidePurify,
        self._ui.btn_KeyGuideRateView
      }
      for idx, keyGuide in pairs(keyGuideList) do
        keyGuide:SetShow(true)
      end
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui.stc_BottomConsole, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    end
    if self._isConsole == true then
      Panel_Window_Artifacts_Exchange_All:SetSize(Panel_Window_Artifacts_Exchange_All:GetSizeX(), self._panelSizeY - self._ui.btn_Exchange:GetSizeY())
      self._ui.stc_BottomConsole:SetPosY(Panel_Window_Artifacts_Exchange_All:GetSizeY())
    else
      Panel_Window_Artifacts_Exchange_All:SetSize(Panel_Window_Artifacts_Exchange_All:GetSizeX(), self._panelSizeY)
    end
  end
  self:updateMoney()
  self._ui.stc_ExchangeBG:SetShow(isExchange)
  self._ui.stc_PurifyBG:SetShow(not isExchange)
  self._ui.rdo_Exchange:SetCheck(isExchange)
  self._ui.rdo_Purify:SetCheck(not isExchange)
end
function PaGlobal_ArtifactsExchange:createSlots()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  local slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true
  }
  self._exchangeSlotMaxCount = ToClient_GetExchangeSlotCount()
  self._purifyPrice = ToClient_GetLightStonePurifyPrice()
  local temp = (self._ui.frame_Content:GetSizeX() - 20) / (self._ui.stc_ExchangeSlot:GetSizeX() + 10)
  local slotCountPerRow = math.floor(temp)
  local rowCount = math.ceil(self._exchangeSlotMaxCount / slotCountPerRow)
  local startPosition = (self._ui.frame:GetSizeX() - self._ui.frame_VerticalScroll:GetSizeX() - slotCountPerRow * self._ui.stc_ExchangeSlot:GetSizeX() - (slotCountPerRow - 1) * 10) * 0.5
  local posXStart = startPosition
  local posYStart = 10
  for idx = 0, self._exchangeSlotMaxCount - 1 do
    local slot = {}
    slot.control = UI.cloneControl(self._ui.stc_ExchangeSlot, self._ui.frame_Content, "Static_ExchangeSlot_" .. idx)
    SlotItem.new(slot, "Static_ExchangeSlot_" .. idx, 0, slot.control, slotConfig)
    slot:createChild()
    slot.icon:SetPosXY(1, 1)
    slot.icon:SetShow(true)
    slot.icon:SetSize(44, 44)
    slot.border:SetSize(44, 44)
    slot.control:SetPosXY(posXStart, posYStart)
    posXStart = startPosition + (idx + 1) % slotCountPerRow * (self._ui.stc_ExchangeSlot:GetSizeX() + 10)
    posYStart = 10 + math.floor((idx + 1) / slotCountPerRow) * (self._ui.stc_ExchangeSlot:GetSizeY() + 10)
    slot.isEmpty = true
    slot.inventoryType = nil
    slot.control:SetShow(true)
    slot.control:addInputEvent("Mouse_UpScroll", "ExchangeSlot_Scroll( true )")
    slot.control:addInputEvent("Mouse_DownScroll", "ExchangeSlot_Scroll( false )")
    if self._isConsole == true then
      slot.control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_deleteFromExchangeSlot(" .. idx .. ")")
      slot.control:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ArtifactsExchange:toggleItemTooltip(" .. idx .. ")")
      if idx >= slotCountPerRow * 2 and idx < slotCountPerRow * (rowCount - 1) then
        slot.control:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "ExchangeSlot_Scroll( false )")
      end
      if idx >= slotCountPerRow and idx < slotCountPerRow * (rowCount - 2) then
        slot.control:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "ExchangeSlot_Scroll( true )")
      end
    else
      slot.control:addInputEvent("Mouse_On", "HandleEventOnOut_ArtifactExchange_ShowSlotToolTip(" .. idx .. ",true)")
      slot.control:addInputEvent("Mouse_Out", "HandleEventOnOut_ArtifactExchange_ShowSlotToolTip(" .. idx .. ",false)")
      slot.control:addInputEvent("Mouse_RUp", "HandleEventRUp_deleteFromExchangeSlot(" .. idx .. ")")
    end
    self._exchangeSlots[idx] = slot
  end
  local slot = {}
  slot.control = self._ui.stc_ExchangeRewardSlot
  SlotItem.new(slot, "Static_ExchangeRewardSlot", 0, slot.control, slotConfig)
  slot:createChild()
  slot.icon:SetShow(true)
  slot.icon:SetSize(self._ui.stc_ExchangeRewardSlot:GetSizeX(), self._ui.stc_ExchangeRewardSlot:GetSizeY())
  slot.border:SetSize(self._ui.stc_ExchangeRewardSlot:GetSizeX(), self._ui.stc_ExchangeRewardSlot:GetSizeY())
  local exchangeRewardSSW = getArtifactItemStaticStatusWrapper(true, 0, 0)
  if exchangeRewardSSW ~= nil then
    slot:setItemByStaticStatus(exchangeRewardSSW)
  end
  self._exchangeRewardSlot = slot
  if self._isConsole == true then
    slot.control:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ArtifactsExchange:toggleRewardItemTooltip()")
  else
    slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_ArtifactExchangeReward_ShowSlotToolTip(true)")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_ArtifactExchangeReward_ShowSlotToolTip(false)")
  end
  local slot = {}
  slot.controlBG = self._ui.stc_PurifySlotBG
  slot.control = self._ui.stc_PurifySlot
  SlotItem.new(slot, "Static_PurifySlot", 0, slot.controlBG, slotConfig)
  slot:createChild()
  slot.icon:SetPosXY(1, 1)
  slot.icon:SetShow(true)
  slot.icon:SetSize(self._ui.stc_PurifySlotBG:GetSizeX(), self._ui.stc_PurifySlotBG:GetSizeY())
  slot.border:SetSize(self._ui.stc_PurifySlotBG:GetSizeX(), self._ui.stc_PurifySlotBG:GetSizeY())
  slot.isEmpty = true
  slot.inventoryType = nil
  slot.validCount = 0
  slot.lightStoneType = nil
  if self._isConsole == true then
    slot.control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_deleteFromPurifySlot()")
    slot.control:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ArtifactsExchange:togglePurifyItemTooltip()")
  else
    slot.control:addInputEvent("Mouse_On", "HandleEventOnOut_ArtifactPurify_ShowSlotToolTip(true)")
    slot.control:addInputEvent("Mouse_Out", "HandleEventOnOut_ArtifactPurify_ShowSlotToolTip(false)")
    slot.control:addInputEvent("Mouse_RUp", "HandleEventRUp_deleteFromPurifySlot()")
  end
  self._purifySlot = slot
  for idx = 0, 3 do
    self._purifyItemKeyList[idx] = getArtifactItemStaticStatusWrapper(false, idx, 0):get()._key:getItemKey()
  end
  local slot = {}
  slot.control = self._ui.stc_PurifyRewardSlot
  SlotItem.new(slot, "Static_PurifyRewardSlot", 0, slot.control, slotConfig)
  slot:createChild()
  slot.icon:SetShow(true)
  slot.icon:SetSize(self._ui.stc_PurifyRewardSlot:GetSizeX(), self._ui.stc_PurifyRewardSlot:GetSizeY())
  slot.border:SetSize(self._ui.stc_PurifyRewardSlot:GetSizeX(), self._ui.stc_PurifyRewardSlot:GetSizeY())
  self._purifyRewardSlot = slot
end
function PaGlobal_ArtifactsExchange:insertExchangeItem(itemSSW, slotNo, inventoryType)
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  for idx = 0, self._exchangeSlotMaxCount - 1 do
    local slot = self._exchangeSlots[idx]
    if slot.isEmpty == true then
      slot:setItemByStaticStatus(itemSSW)
      slot.isEmpty = false
      slot.slotNo = slotNo
      slot.inventoryType = inventoryType
      table.insert(self._exchangeAddedSlotNo, slotNo)
      Inventory_SetFunctor(PaGlobalFunc_ArtifactExchange_Filter, PaGlobalFunc_ArtifactExchange_RClickFunction, nil, nil)
      self:changeExchangeDesc()
      self:changeExchangeRewardSlot()
      self:setShowSuccessDesc(true, false)
      return
    end
  end
end
function PaGlobal_ArtifactsExchange:clearExchangeSlots()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  for idx = 0, self._exchangeSlotMaxCount - 1 do
    local slot = self._exchangeSlots[idx]
    slot:clearItem()
    slot.isEmpty = true
    slot.slotNo = 0
    slot.inventoryType = nil
  end
  self._exchangeAddedSlotNo = {}
  Inventory_SetFunctor(PaGlobalFunc_ArtifactExchange_Filter, PaGlobalFunc_ArtifactExchange_RClickFunction, nil, nil)
end
function PaGlobal_ArtifactsExchange:popExchangeSlot(index)
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  local slot = self._exchangeSlots[index]
  if slot == nil then
    return
  end
  local deleteIndex
  for idx, value in pairs(self._exchangeAddedSlotNo) do
    if value == slot.slotNo then
      deleteIndex = idx
      break
    end
  end
  if deleteIndex == nil then
    return
  end
  table.remove(self._exchangeAddedSlotNo, deleteIndex)
  slot:clearItem()
  slot.isEmpty = true
  slot.slotNo = 0
  slot.inventoryType = nil
  Inventory_SetFunctor(PaGlobalFunc_ArtifactExchange_Filter, PaGlobalFunc_ArtifactExchange_RClickFunction, nil, nil)
  self:changeExchangeDesc()
  self:changeExchangeRewardSlot()
end
function PaGlobal_ArtifactsExchange:changeExchangeDesc()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  local lightStoneCount = #self._exchangeAddedSlotNo
  if lightStoneCount == 0 then
    self._ui.txt_ExchangeMultiline:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_ARTIFACTS_DESC_BASIC"))
  else
    local resultCount = math.floor(lightStoneCount / 3)
    self._ui.txt_ExchangeMultiline:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_ARTIFACTS_DESC_RESULT", "count", tostring(resultCount)))
  end
  self._ui.stc_ExchangeEffect:EraseAllEffect()
end
function PaGlobal_ArtifactsExchange:exchangeLightStones()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  local sendCount = #self._exchangeAddedSlotNo - #self._exchangeAddedSlotNo % 3
  for idx = 0, self._exchangeSlotMaxCount - 1 do
    local slot = self._exchangeSlots[idx]
    if slot.isEmpty == false and slot.slotNo ~= 0 then
      ToClient_SaveLightStoneInfoForExchange(idx, slot.slotNo)
      sendCount = sendCount - 1
    end
    if sendCount == 0 then
      break
    end
  end
  ToClient_SendLightStoneExchangeInfo()
end
function PaGlobal_ArtifactsExchange:popPurifySlot()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  local slot = self._purifySlot
  if slot == nil then
    return
  end
  slot:clearItem()
  slot.isEmpty = true
  slot.slotNo = 0
  slot.inventoryType = nil
  slot.validCount = 0
  slot.lightStoneType = nil
  Inventory_SetFunctor(PaGlobalFunc_ArtifactPurify_Filter, PaGlobalFunc_ArtifactPurify_RClickFunction, nil, nil)
  self:changePurifyDesc()
  self:changePurifyBG(nil)
  self:changePurifyPrice(0)
  self._purifyRewardSlot:clearItem()
  self._purifyRewardSlot.icon:removeInputEvent("Mouse_On")
  self._purifyRewardSlot.icon:removeInputEvent("Mouse_Out")
end
function PaGlobal_ArtifactsExchange:changePurifyDesc(lightStoneType, count)
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  if lightStoneType == nil then
    self._ui.txt_PurifyMultiline:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_ARTIFACTS_DESC_PURIFY"))
  elseif count ~= nil then
    if lightStoneType == 0 then
      self._ui.txt_PurifyMultiline:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_ARTIFACTS_PURIFY_DESC_RESULT_FIRE", "count", tostring(count)))
    elseif lightStoneType == 1 then
      self._ui.txt_PurifyMultiline:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_ARTIFACTS_PURIFY_DESC_RESULT_EARTH", "count", tostring(count)))
    elseif lightStoneType == 2 then
      self._ui.txt_PurifyMultiline:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_ARTIFACTS_PURIFY_DESC_RESULT_WIND", "count", tostring(count)))
    elseif lightStoneType == 3 then
      self._ui.txt_PurifyMultiline:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_ARTIFACTS_PURIFY_DESC_RESULT_GRASS", "count", tostring(count)))
    end
  end
  self._ui.stc_PurifyEffect:EraseAllEffect()
end
function PaGlobal_ArtifactsExchange:insertPurifyItem(itemSSW, slotNo, inventoryType, lightStoneType, count)
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  local slot = self._purifySlot
  slot:setItemByStaticStatus(itemSSW, count)
  slot.isEmpty = false
  slot.slotNo = slotNo
  slot.inventoryType = inventoryType
  slot.validCount = count
  slot.lightStoneType = lightStoneType
  Inventory_SetFunctor(PaGlobalFunc_ArtifactPurify_Filter, PaGlobalFunc_ArtifactPurify_RClickFunction, nil, nil)
  self:changePurifyDesc(lightStoneType, count)
  self:changePurifyBG(lightStoneType)
  self:changePurifyPrice(count)
  self:setShowSuccessDesc(false, false)
  self:changePurifyRewardSlot(lightStoneType, count)
end
function PaGlobal_ArtifactsExchange:changeExchangeRewardSlot()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  local lightStoneCount = #self._exchangeAddedSlotNo
  local resultCount = math.floor(lightStoneCount / 3)
  if resultCount == 0 then
    self._exchangeRewardSlot.icon:SetMonoTone(true)
  else
    self._exchangeRewardSlot.icon:SetMonoTone(false)
  end
  self._exchangeRewardSlot.count:SetText(tostring(resultCount))
end
function PaGlobal_ArtifactsExchange:GetLightStoneType(itemSSW)
  for idx = 0, #self._purifyItemKeyList do
    if itemSSW:get()._key:getItemKey() == self._purifyItemKeyList[idx] then
      return idx
    end
  end
end
function PaGlobal_ArtifactsExchange:changePurifyBG(lightStoneType)
  self._ui.stc_PurifyBaseBG:SetShow(lightStoneType == nil)
  self._ui.stc_PurifyFireBG:SetShow(lightStoneType == 0)
  self._ui.stc_PurifyEarthBG:SetShow(lightStoneType == 1)
  self._ui.stc_PurifyWindBG:SetShow(lightStoneType == 2)
  self._ui.stc_PurifyGrassBG:SetShow(lightStoneType == 3)
end
function PaGlobal_ArtifactsExchange:selectPurifyCount(slotNo, itemWrapper, inventoryType)
  if itemWrapper == nil then
    return
  end
  local itemCount = itemWrapper:get():getCount_s64()
  if itemCount == 1 then
    PaGlobalFunc_Artifact_Purify_PushItem(itemCount, slotNo, inventoryType)
  else
    Panel_NumberPad_Show(true, itemCount, slotNo, PaGlobalFunc_Artifact_Purify_PushItem, false, inventoryType)
  end
end
function PaGlobal_ArtifactsExchange:changePurifyRewardSlot(lightStoneType, count)
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  if lightStoneType < 0 or lightStoneType > 3 then
    return
  end
  local purifyRewardSSW = getArtifactItemStaticStatusWrapper(false, lightStoneType, 1)
  if purifyRewardSSW == nil then
    return
  end
  self._purifyRewardSlot:setItemByStaticStatus(purifyRewardSSW, count)
  self._purifyRewardSlot.icon:removeInputEvent("Mouse_On")
  self._purifyRewardSlot.icon:removeInputEvent("Mouse_Out")
  if self._isConsole == true then
    self._purifyRewardSlot.control:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ArtifactsExchange:togglePurifyRewardItemTooltip(" .. lightStoneType .. ")")
  else
    self._purifyRewardSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_ArtifactPurifyReward_ShowSlotToolTip(true, " .. lightStoneType .. ")")
    self._purifyRewardSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_ArtifactPurifyReward_ShowSlotToolTip(false, " .. lightStoneType .. ")")
  end
end
function PaGlobal_ArtifactsExchange:clearPurifySlot()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  local slot = self._purifySlot
  if slot == nil then
    return
  end
  slot:clearItem()
  slot.isEmpty = true
  slot.slotNo = 0
  slot.inventoryType = nil
  slot.validCount = 0
  slot.lightStoneType = nil
end
function PaGlobal_ArtifactsExchange:clearPurifyRewardSlot()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  self:changePurifyDesc()
  self:changePurifyBG(nil)
  self:changePurifyPrice(0)
  self:setShowSuccessDesc(false, false)
  self._purifyRewardSlot:clearItem()
  self._purifyRewardSlot.icon:removeInputEvent("Mouse_On")
  self._purifyRewardSlot.icon:removeInputEvent("Mouse_Out")
end
function PaGlobal_ArtifactsExchange:purifyLightStones()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  local slot = self._purifySlot
  if slot == nil then
    return
  end
  if slot.slotNo == 0 then
    return
  end
  if slot.inventoryType == nil then
    return
  end
  if slot.validCount == 0 then
    return
  end
  if slot.lightStoneType == nil then
    return
  end
  ToClient_SendLightStonePurifyInfo(slot.slotNo, slot.inventoryType, slot.validCount, slot.lightStoneType)
end
function PaGlobal_ArtifactsExchange:changePurifyPrice(count)
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  local moneyText = tostring(count) .. " X " .. makeDotMoney(self._purifyPrice) .. " = " .. makeDotMoney(Int64toInt32(count) * Int64toInt32(self._purifyPrice))
  self._ui.stc_SilverValue:SetText(moneyText .. PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_MONEY"))
  self._needPurifyPrice = count * self._purifyPrice
end
function PaGlobal_ArtifactsExchange:updateMoney()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  self._ui.txt_MoneyValue:SetText(makeDotMoney(getSelfPlayer():get():getMoneyInventory():getMoney_s64()))
end
function PaGlobal_ArtifactsExchange:updateExchangeSlot(isUp, isInit)
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  local temp = (self._ui.frame_Content:GetSizeX() - 20) / (self._ui.stc_ExchangeSlot:GetSizeX() + 10)
  local rowCount = math.floor(temp)
  local totalRow = math.ceil(self._exchangeSlotMaxCount / rowCount)
  local viewRow = 3
  local scrollCount = totalRow - viewRow
  if isUp == true then
    self._scrollIndex = self._scrollIndex - 1
    if self._scrollIndex < 0 then
      self._scrollIndex = 0
      if isInit == false then
        return
      end
    end
  else
    self._scrollIndex = self._scrollIndex + 1
    if scrollCount < self._scrollIndex then
      self._scrollIndex = scrollCount
      if isInit == false then
        return
      end
    end
  end
  local startPosition = (self._ui.frame:GetSizeX() - self._ui.frame_VerticalScroll:GetSizeX() - rowCount * self._ui.stc_ExchangeSlot:GetSizeX() - (rowCount - 1) * 10) * 0.5
  local posXStart = startPosition
  local posYStart = 10
  local index = 0
  for idx = 0, #self._exchangeSlots do
    local slot = self._exchangeSlots[idx]
    local needToShow = false
    if idx >= self._scrollIndex * rowCount and idx <= (self._scrollIndex + viewRow - 1) * rowCount + (rowCount - 1) then
      needToShow = true
    end
    slot.control:SetShow(needToShow)
    if needToShow == true then
      slot.control:SetPosXY(posXStart, posYStart)
      posXStart = startPosition + (index + 1) % rowCount * (self._ui.stc_ExchangeSlot:GetSizeX() + 10)
      posYStart = 10 + math.floor((index + 1) / rowCount) * (self._ui.stc_ExchangeSlot:GetSizeY() + 10)
      index = index + 1
    end
  end
end
function PaGlobal_ArtifactsExchange:setShowSuccessDesc(isExchange, isShow)
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  if isExchange == true then
    self._ui.txt_ExchangeFinish:SetShow(isShow)
  else
    self._ui.txt_PurifyFinish:SetShow(isShow)
  end
end
function PaGlobal_ArtifactsExchange:toggleItemTooltip(index)
  local slot = PaGlobal_ArtifactsExchange._exchangeSlots[index]
  if slot == nil then
    return
  end
  if slot.slotNo == 0 then
    return
  end
  if slot.inventoryType == nil then
    return
  end
  local itemWrapper = getInventoryItemByType(slot.inventoryType, slot.slotNo)
  if itemWrapper == nil then
    return
  end
  local isShow = true
  if self._isConsole == true and ToClient_isConsole() == true then
    if PaGlobalFunc_TooltipInfo_GetShow() == true then
      isShow = false
    end
  elseif Panel_Tooltup_Item_isShow() == true then
    isShow = false
  end
  if self._isConsole == true and ToClient_isConsole() == true then
    if isShow == true then
      PaGlobalFunc_FloatingTooltip_Close()
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  elseif isShow == true then
    Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_Artifacts_Exchange_All, false, true, nil, nil, nil, nil, nil, nil)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobal_ArtifactsExchange:togglePurifyRewardItemTooltip(lightStoneType)
  local slot = self._purifySlot
  if slot.lightStoneType == nil then
    return
  end
  local purifyRewardSSW = getArtifactItemStaticStatusWrapper(false, lightStoneType, 1)
  if purifyRewardSSW == nil then
    return
  end
  local isShow = true
  if self._isConsole == true and ToClient_isConsole() == true then
    if PaGlobalFunc_TooltipInfo_GetShow() == true then
      isShow = false
    end
  elseif Panel_Tooltup_Item_isShow() == true then
    isShow = false
  end
  if self._isConsole == true and ToClient_isConsole() == true then
    if isShow == true then
      PaGlobalFunc_FloatingTooltip_Close()
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, purifyRewardSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  elseif isShow == true then
    Panel_Tooltip_Item_Show(purifyRewardSSW, Panel_Window_Artifacts_Exchange_All, true, false, nil, nil, nil, nil, nil, nil)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobal_ArtifactsExchange:togglePurifyItemTooltip()
  local slot = PaGlobal_ArtifactsExchange._purifySlot
  if slot == nil then
    return
  end
  if slot.slotNo == 0 then
    return
  end
  if slot.inventoryType == nil then
    return
  end
  local itemWrapper = getInventoryItemByType(slot.inventoryType, slot.slotNo)
  if itemWrapper == nil then
    return
  end
  local isShow = true
  if self._isConsole == true and ToClient_isConsole() == true then
    if PaGlobalFunc_TooltipInfo_GetShow() == true then
      isShow = false
    end
  elseif Panel_Tooltup_Item_isShow() == true then
    isShow = false
  end
  if self._isConsole == true and ToClient_isConsole() == true then
    if isShow == true then
      PaGlobalFunc_FloatingTooltip_Close()
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  elseif isShow == true then
    Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_Artifacts_Exchange_All, false, true, nil, nil, nil, nil, nil, nil)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobal_ArtifactsExchange:toggleRewardItemTooltip()
  local exchangeRewardSSW = getArtifactItemStaticStatusWrapper(true, 0, 0)
  if exchangeRewardSSW == nil then
    return
  end
  local isShow = true
  if self._isConsole == true and ToClient_isConsole() == true then
    if PaGlobalFunc_TooltipInfo_GetShow() == true then
      isShow = false
    end
  elseif Panel_Tooltup_Item_isShow() == true then
    isShow = false
  end
  if self._isConsole == true and ToClient_isConsole() == true then
    if isShow == true then
      PaGlobalFunc_FloatingTooltip_Close()
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, exchangeRewardSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  elseif isShow == true then
    Panel_Tooltip_Item_Show(exchangeRewardSSW, Panel_Window_Artifacts_Exchange_All, true, false, nil, nil, nil, nil, nil, nil)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function FromClient_ClearArtifactExchangeSlot()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  PaGlobal_ArtifactsExchange:clearExchangeSlots()
  PaGlobal_ArtifactsExchange:setShowSuccessDesc(true, true)
  PaGlobal_ArtifactsExchange:updateMoney()
  PaGlobal_ArtifactsExchange._ui.stc_ExchangeEffect:AddEffect("fUI_Exchange_Stone_01A", true, 0, -42)
  audioPostEvent_SystemUi(10, 5)
end
function FromClient_ClearArtifactPurifySlot(lightStoneType)
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  if lightStoneType == nil then
    return
  end
  PaGlobal_ArtifactsExchange:clearPurifySlot()
  PaGlobal_ArtifactsExchange:setShowSuccessDesc(false, true)
  PaGlobal_ArtifactsExchange:updateMoney()
  if lightStoneType == 0 then
    PaGlobal_ArtifactsExchange._ui.stc_PurifyEffect:AddEffect("fUI_Exchange_Stone_02A", true, -2, -57)
  elseif lightStoneType == 1 then
    PaGlobal_ArtifactsExchange._ui.stc_PurifyEffect:AddEffect("fUI_Exchange_Stone_02B", true, -2, -57)
  elseif lightStoneType == 2 then
    PaGlobal_ArtifactsExchange._ui.stc_PurifyEffect:AddEffect("fUI_Exchange_Stone_02C", true, -2, -57)
  elseif lightStoneType == 3 then
    PaGlobal_ArtifactsExchange._ui.stc_PurifyEffect:AddEffect("fUI_Exchange_Stone_02D", true, -2, -57)
  end
  audioPostEvent_SystemUi(10, 5)
end
function PaGlobal_LightStone_UpdateAni(deltaTime)
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  if PaGlobal_ArtifactsExchange._aniStart == false then
    return
  end
  if PaGlobal_ArtifactsExchange._isExchange == true then
    if PaGlobal_ArtifactsExchange._ui.chk_ExchangeSkipAni:IsCheck() == false then
      PaGlobal_ArtifactsExchange._delta_Exchange_AniTime = PaGlobal_ArtifactsExchange._delta_Exchange_AniTime + deltaTime
      if PaGlobal_ArtifactsExchange._delta_Exchange_AniTime <= PaGlobal_ArtifactsExchange._const_Exchange_AniTime then
        return
      end
    end
    PaGlobal_ArtifactsExchange:exchangeLightStones()
    PaGlobal_ArtifactsExchange._aniStart = false
    PaGlobal_ArtifactsExchange._delta_Exchange_AniTime = 0
    PaGlobal_ArtifactsExchange._ui.chk_ExchangeSkipAni:SetIgnore(false)
    PaGlobal_ArtifactsExchange._ui.btn_PutInAll:SetIgnore(false)
    PaGlobal_ArtifactsExchange._ui.btn_Exchange:SetIgnore(false)
  else
    if PaGlobal_ArtifactsExchange._ui.chk_PurifySkipAni:IsCheck() == false then
      PaGlobal_ArtifactsExchange._delta_Purify_AniTime = PaGlobal_ArtifactsExchange._delta_Purify_AniTime + deltaTime
      if PaGlobal_ArtifactsExchange._delta_Purify_AniTime <= PaGlobal_ArtifactsExchange._const_Purify_AniTime then
        return
      end
    end
    PaGlobal_ArtifactsExchange:purifyLightStones()
    PaGlobal_ArtifactsExchange._aniStart = false
    PaGlobal_ArtifactsExchange._delta_Purify_AniTime = 0
    PaGlobal_ArtifactsExchange._ui.chk_PurifySkipAni:SetIgnore(false)
    PaGlobal_ArtifactsExchange._ui.btn_Purify:SetIgnore(false)
  end
end
registerEvent("FromClient_ClearArtifactExchangeSlot", "FromClient_ClearArtifactExchangeSlot")
registerEvent("FromClient_ClearArtifactPurifySlot", "FromClient_ClearArtifactPurifySlot")
