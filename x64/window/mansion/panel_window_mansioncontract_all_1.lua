function PaGlobal_MansionContract:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_name = UI.getChildControl(Panel_Window_Mansion_Contract_All, "StaticText_To")
  self._ui._btn_date = UI.getChildControl(Panel_Window_Mansion_Contract_All, "Button_Date")
  self._ui._stc_price = UI.getChildControl(Panel_Window_Mansion_Contract_All, "StaticText_Price")
  self._ui._stc_priceValue = UI.getChildControl(Panel_Window_Mansion_Contract_All, "StaticText_Price_Value")
  self._ui._stc_discount = UI.getChildControl(Panel_Window_Mansion_Contract_All, "StaticText_Price_Sale")
  self._ui._chk_inventory = UI.getChildControl(Panel_Window_Mansion_Contract_All, "CheckButton_Silver_Inven")
  self._ui._stc_inventoryMoney = UI.getChildControl(Panel_Window_Mansion_Contract_All, "StaticText_Silver_Inven_Value")
  self._ui._chk_warehouse = UI.getChildControl(Panel_Window_Mansion_Contract_All, "CheckButton_Silver_Warehouse")
  self._ui._stc_warehouseMoney = UI.getChildControl(Panel_Window_Mansion_Contract_All, "StaticText_Silver_Warehouse_Value")
  self._ui._btn_contract = UI.getChildControl(Panel_Window_Mansion_Contract_All, "Button_Contract")
  self._ui._btn_cancle = UI.getChildControl(Panel_Window_Mansion_Contract_All, "Button_Cancle")
  self._ui._frm_mansion = UI.getChildControl(Panel_Window_Mansion_Contract_All, "Frame_Mansion")
  self._ui._frm_content = UI.getChildControl(self._ui._frm_mansion, "Frame_1_Content")
  self._ui._stc_content = UI.getChildControl(self._ui._frm_content, "StaticText_Contents")
  self._ui._chk_warehouse:SetShow(false)
  self._ui._stc_warehouseMoney:SetShow(false)
  self._ui._stc_keyGuideBG = UI.getChildControl(Panel_Window_Mansion_Contract_All, "Static_KeyGuide_ConsoleUI")
  self._ui._stc_keyGuideBG:SetShow(self._isConsole)
  self._ui._stc_MorningMark = UI.getChildControl(Panel_Window_Mansion_Contract_All, "Static_1")
  self._ui._stc_MorningBG = UI.getChildControl(Panel_Window_Mansion_Contract_All, "Static_2")
  self._ui._stc_MorningMark:SetShow(false)
  self._ui._txt_Owner = UI.getChildControl(Panel_Window_Mansion_Contract_All, "StaticText_From")
  self._ui._stc_MorningBG:SetShow(false)
  self:registEventHandler()
  self:validate()
  self._ui._stc_content:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_content:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MANSION_CONTRACTION_DESC"))
  self._confirmMsg = PAGetString(Defines.StringSheet_GAME, "LUA_SYSMSG_CONFIRM")
  local gapY = 20
  local textSizeY = self._ui._stc_content:GetTextSizeY() + gapY
  self._ui._frm_content:SetSize(self._ui._frm_content:GetSizeX(), textSizeY)
  self._ui._stc_content:SetSize(self._ui._stc_content:GetSizeX(), textSizeY)
  self._ui._frm_mansion:UpdateContentScroll()
  self._ui._frm_mansion:UpdateContentPos()
  self._initialize = true
  self._mansionKey = self._eMansionKey._hidelOut
end
function PaGlobal_MansionContract:registEventHandler()
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
  PaGlobal_MansionContract._ui._stc_price:addInputEvent("Mouse_On", "HandleEventOnOut_MansionContract_ShowPriceTooltip(true)")
  PaGlobal_MansionContract._ui._stc_price:addInputEvent("Mouse_Out", "HandleEventOnOut_MansionContract_ShowPriceTooltip(false)")
  PaGlobal_MansionContract._ui._btn_contract:addInputEvent("Mouse_LUp", "HandleEventLUp_MansionContract_ClickContract()")
  PaGlobal_MansionContract._ui._chk_inventory:addInputEvent("Mouse_LUp", "HandleEventLup_MansionContract_ClickMoneyWhereType('Inventory')")
  PaGlobal_MansionContract._ui._chk_warehouse:addInputEvent("Mouse_LUp", "HandleEventLup_MansionContract_ClickMoneyWhereType('WareHouse')")
  PaGlobal_MansionContract._ui._btn_date:addInputEvent("Mouse_LUp", "HandleEventLup_MansionContract_ButtonDate()")
  PaGlobal_MansionContract._ui._btn_cancle:addInputEvent("Mouse_LUp", "PaGlobal_MansionContract_Close()")
  registerEvent("FromClient_ContractMansion", "FromClient_ContractMansion")
  registerEvent("FromClient_ContractMansionSuccess", "FromClient_ContractMansionSuccess")
  registerEvent("onScreenResize", "FromClient_ContractMansion_Resize")
end
function PaGlobal_MansionContract:prepareOpen(houseHoldNo)
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
  local actor = interaction_getInteractable()
  if nil == actor or nil == actor:get() then
    return
  end
  if false == actor:get():isHouseHold() then
    return
  end
  local houseHoldActor = getHouseHoldActor(actor:getActorKey())
  if nil == houseHoldActor then
    return
  end
  local houseHoldActorSSW = houseHoldActor:getStaticStatusWrapper()
  if nil == houseHoldActorSSW then
    return
  end
  local houseObjectSSW = houseHoldActorSSW:getObjectStaticStatus()
  if nil == houseObjectSSW then
    return
  end
  local chracterKey = houseHoldActorSSW:getCharacterKey()
  if -1 == ToClient_getNeenPointMansion(chracterKey) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantFindHouseInfo"))
    return
  end
  PaGlobal_MansionContract:changeTexture(chracterKey)
  self._householdNo = houseHoldNo
  self._mansionKey = chracterKey
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  warehouse_requestInfoByCurrentRegionMainTown()
  self._ui._stc_name:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MANSION_CONTRACTION_TO", "name", selfPlayer:getUserNickname()))
  self._ui._chk_inventory:SetCheck(true)
  self._ui._chk_warehouse:SetCheck(false)
  self._inventoryMoney = getSelfPlayer():get():getMoneyInventory():getMoney_s64()
  self._wareHouseMoney = warehouse_moneyByCurrentRegionMainTown_s64()
  self._ui._stc_warehouseMoney:SetText(makeDotMoney(self._wareHouseMoney))
  self._ui._stc_inventoryMoney:SetText(makeDotMoney(self._inventoryMoney))
  self:setContractPeriod(30)
  PaGlobal_MansionContract:open()
end
function PaGlobal_MansionContract:changeTexture(chracterKey)
  if chracterKey == nil then
    return
  end
  local panelTexture, okBtnTextrue_N, okBtnTextrue_O, okBtnTextrue_C, cancelBtnTextrue_N, cancelBtnTextrue_O, cancelBtnTextrue_C
  if chracterKey == self._eMansionKey._hidelOut and self._mansionKey ~= self._eMansionKey._hidelOut then
    panelTexture = "Combine_Etc_Mansion_Letter_BG"
    okBtnTextrue_N = "Combine_Etc_Mansion_Letter_Btn_Red_Normal"
    okBtnTextrue_O = "Combine_Etc_Mansion_Letter_Btn_Red_Over"
    okBtnTextrue_C = "Combine_Etc_Mansion_Letter_Btn_Red_Click"
    cancelBtnTextrue_N = "Combine_Etc_Mansion_Letter_Btn_Brown_Normal"
    cancelBtnTextrue_O = "Combine_Etc_Mansion_Letter_Btn_Brown_Over"
    cancelBtnTextrue_C = "Combine_Etc_Mansion_Letter_Btn_Brown_Click"
    self._ui._txt_Owner:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MANSION_CONTRACTION_FROM"))
    self._ui._stc_content:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MANSION_CONTRACTION_DESC"))
    self._ui._stc_content:SetTextSpan(0, 0)
    self._ui._stc_MorningBG:SetShow(false)
    self._ui._stc_MorningMark:SetShow(false)
    self._ui._txt_Owner:SetShow(true)
    self._confirmMsg = PAGetString(Defines.StringSheet_GAME, "LUA_SYSMSG_CONFIRM")
  elseif chracterKey == self._eMansionKey._simHayngOut and self._mansionKey ~= self._eMansionKey._simHayngOut then
    self._ui._stc_MorningBG:SetShow(true)
    okBtnTextrue_N = "Combine_Etc_MorningLand_Mansion_Letter_01_Btn_1_Normal"
    okBtnTextrue_O = "Combine_Etc_MorningLand_Mansion_Letter_01_Btn_1_Over"
    okBtnTextrue_C = "Combine_Etc_MorningLand_Mansion_Letter_01_Btn_1_Click"
    cancelBtnTextrue_N = "Combine_Etc_MorningLand_Mansion_Letter_01_Btn_2_Normal"
    cancelBtnTextrue_O = "Combine_Etc_MorningLand_Mansion_Letter_01_Btn_2_Over"
    cancelBtnTextrue_C = "Combine_Etc_MorningLand_Mansion_Letter_01_Btn_2_Click"
    self._ui._stc_MorningMark:SetShow(true)
    self._ui._txt_Owner:SetShow(false)
    self._ui._stc_content:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MANSION_CONTRACTION_DESC_1"))
    self._ui._stc_content:SetTextSpan(0, 10)
    self._ui._stc_MorningBG:SetShow(true)
    self._confirmMsg = PAGetString(Defines.StringSheet_GAME, "LUA_SYSMSG_CONFIRM_1")
  elseif chracterKey == self._eMansionKey._neoWhaOut and self._mansionKey ~= self._eMansionKey._neoWhaOut then
    panelTexture = "Combine_Etc_MorningLand_Mansion_Letter_02_BG"
    okBtnTextrue_N = "Combine_Etc_MorningLand_Mansion_Letter_02_Btn_1_Normal"
    okBtnTextrue_O = "Combine_Etc_MorningLand_Mansion_Letter_02_Btn_1_Over"
    okBtnTextrue_C = "Combine_Etc_MorningLand_Mansion_Letter_02_Btn_1_Click"
    cancelBtnTextrue_N = "Combine_Etc_MorningLand_Mansion_Letter_02_Btn_2_Normal"
    cancelBtnTextrue_O = "Combine_Etc_MorningLand_Mansion_Letter_02_Btn_2_Over"
    cancelBtnTextrue_C = "Combine_Etc_MorningLand_Mansion_Letter_02_Btn_2_Click"
    self._ui._stc_MorningMark:SetShow(true)
    self._ui._txt_Owner:SetShow(false)
    self._ui._stc_content:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MANSION_CONTRACTION_DESC_2"))
    self._ui._stc_content:SetTextSpan(0, 10)
    self._ui._stc_MorningBG:SetShow(false)
    self._confirmMsg = PAGetString(Defines.StringSheet_GAME, "LUA_SYSMSG_CONFIRM_2")
  elseif chracterKey == self._eMansionKey._hyunRokOut and self._mansionKey ~= self._eMansionKey._hyunRokOut then
    self._ui._stc_MorningBG:SetShow(true)
    okBtnTextrue_N = "Combine_Etc_MorningLand_Mansion_Letter_01_Btn_1_Normal"
    okBtnTextrue_O = "Combine_Etc_MorningLand_Mansion_Letter_01_Btn_1_Over"
    okBtnTextrue_C = "Combine_Etc_MorningLand_Mansion_Letter_01_Btn_1_Click"
    cancelBtnTextrue_N = "Combine_Etc_MorningLand_Mansion_Letter_01_Btn_2_Normal"
    cancelBtnTextrue_O = "Combine_Etc_MorningLand_Mansion_Letter_01_Btn_2_Over"
    cancelBtnTextrue_C = "Combine_Etc_MorningLand_Mansion_Letter_01_Btn_2_Click"
    self._ui._stc_MorningMark:SetShow(true)
    self._ui._txt_Owner:SetShow(false)
    self._ui._stc_content:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MANSION_CONTRACTION_DESC_3"))
    self._ui._stc_content:SetTextSpan(0, 10)
    self._ui._stc_MorningBG:SetShow(true)
    self._confirmMsg = PAGetString(Defines.StringSheet_GAME, "LUA_SYSMSG_CONFIRM_3")
  end
  if panelTexture ~= nil then
    Panel_Window_Mansion_Contract_All:ChangeTextureInfoAndSizeByTextureIDKey(panelTexture, 0)
    Panel_Window_Mansion_Contract_All:setRenderTexture(Panel_Window_Mansion_Contract_All:getBaseTexture())
    Panel_Window_Mansion_Contract_All:ComputePosAllChild()
  end
  if okBtnTextrue_N ~= nil then
    self._ui._btn_contract:ChangeTextureInfoAndSizeByTextureIDKey(okBtnTextrue_N, 0)
    self._ui._btn_contract:setRenderTexture(self._ui._btn_contract:getBaseTexture())
  end
  if okBtnTextrue_O ~= nil then
    self._ui._btn_contract:ChangeTextureInfoAndSizeByTextureIDKey(okBtnTextrue_O, 1)
    self._ui._btn_contract:setRenderTexture(self._ui._btn_contract:getOnTexture())
  end
  if okBtnTextrue_C ~= nil then
    self._ui._btn_contract:ChangeTextureInfoAndSizeByTextureIDKey(okBtnTextrue_C, 2)
    self._ui._btn_contract:setRenderTexture(self._ui._btn_contract:getClickTexture())
  end
  if cancelBtnTextrue_N ~= nil then
    self._ui._btn_cancle:ChangeTextureInfoAndSizeByTextureIDKey(cancelBtnTextrue_N, 0)
    self._ui._btn_cancle:setRenderTexture(self._ui._btn_cancle:getBaseTexture())
  end
  if cancelBtnTextrue_O ~= nil then
    self._ui._btn_cancle:ChangeTextureInfoAndSizeByTextureIDKey(cancelBtnTextrue_O, 1)
    self._ui._btn_cancle:setRenderTexture(self._ui._btn_cancle:getOnTexture())
  end
  if cancelBtnTextrue_C ~= nil then
    self._ui._btn_cancle:ChangeTextureInfoAndSizeByTextureIDKey(cancelBtnTextrue_C, 2)
    self._ui._btn_cancle:setRenderTexture(self._ui._btn_cancle:getClickTexture())
  end
  local gapY = 20
  local textSizeY = self._ui._stc_content:GetTextSizeY() + gapY
  self._ui._frm_content:SetSize(self._ui._frm_content:GetSizeX(), textSizeY)
  self._ui._stc_content:SetSize(self._ui._stc_content:GetSizeX(), textSizeY)
  self._ui._frm_mansion:UpdateContentScroll()
  self._ui._frm_mansion:UpdateContentPos()
end
function PaGlobal_MansionContract:open()
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
  Panel_Window_Mansion_Contract_All:SetShow(true)
end
function PaGlobal_MansionContract:prepareClose()
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
  self._householdNo = nil
  self._contract_Period = 0
  self._inventoryMoney = 0
  self._wareHouseMoney = 0
  self._payValue = 0
  self._discountPayValue = 0
  TooltipSimple_Hide()
  PaGlobal_MansionContract:close()
end
function PaGlobal_MansionContract:close()
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
  Panel_Window_Mansion_Contract_All:SetShow(false)
end
function PaGlobal_MansionContract:update()
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
end
function PaGlobal_MansionContract:setContractPeriod(value)
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
  if value <= 0 or value > 365 then
    return
  end
  self._payValue = toInt64(0, value) * ToClient_GetMansionPricePerDay()
  self._discountPayValue = ToClient_GetMansionContractDiscountPrice(value, self._payValue)
  self._contract_Period = value
  self._ui._stc_price:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MANSION_CONTRACTION_PRICE"))
  local priceSpanGapX = self._ui._stc_price:GetSpanSize().x + self._ui._stc_price:GetSizeX() + self._ui._stc_price:GetTextSizeX() + 13
  self._ui._stc_priceValue:SetText(makeDotMoney(self._payValue))
  self._ui._stc_priceValue:SetSpanSize(priceSpanGapX, self._ui._stc_price:GetSpanSize().y)
  self._ui._btn_date:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MANSION_CONTRACTION_DATE", "date", value))
  if self._payValue == self._discountPayValue then
    self._ui._stc_priceValue:SetLineRender(false)
    self._ui._stc_discount:SetShow(false)
  else
    self._ui._stc_priceValue:SetLineRender(true)
    self._ui._stc_discount:SetText(makeDotMoney(self._discountPayValue))
    self._ui._stc_discount:SetShow(true)
    self._ui._stc_discount:SetSpanSize(priceSpanGapX + self._ui._stc_priceValue:GetTextSizeX() + 15, self._ui._stc_price:GetSpanSize().y)
  end
end
function FromClient_ContractMansion_Resize()
  if Panel_Window_Mansion_Contract_All == nil then
    return
  end
  Panel_Window_Mansion_Contract_All:ComputePosAllChild()
end
function PaGlobal_MansionContract:validate()
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
  PaGlobal_MansionContract._ui._stc_name:isValidate()
  PaGlobal_MansionContract._ui._btn_date:isValidate()
  PaGlobal_MansionContract._ui._stc_price:isValidate()
  PaGlobal_MansionContract._ui._stc_priceValue:isValidate()
  PaGlobal_MansionContract._ui._stc_discount:isValidate()
  PaGlobal_MansionContract._ui._chk_inventory:isValidate()
  PaGlobal_MansionContract._ui._stc_inventoryMoney:isValidate()
  PaGlobal_MansionContract._ui._chk_warehouse:isValidate()
  PaGlobal_MansionContract._ui._stc_warehouseMoney:isValidate()
  PaGlobal_MansionContract._ui._btn_contract:isValidate()
  PaGlobal_MansionContract._ui._btn_cancle:isValidate()
  PaGlobal_MansionContract._ui._frm_mansion:isValidate()
  PaGlobal_MansionContract._ui._frm_content:isValidate()
  PaGlobal_MansionContract._ui._stc_content:isValidate()
end
