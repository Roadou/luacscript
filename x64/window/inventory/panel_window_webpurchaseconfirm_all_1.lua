function PaGlobal_WebPurchaseConfirm_All:initialize()
  if PaGlobal_WebPurchaseConfirm_All._initialize == true then
    return
  end
  local stc_titleBg = UI.getChildControl(Panel_Window_WebPurchaseConfirm_All, "Static_TitleBG")
  self._ui._btn_close = UI.getChildControl(stc_titleBg, "Button_Close")
  self._ui._btn_yes = UI.getChildControl(Panel_Window_WebPurchaseConfirm_All, "Button_Yes")
  self._ui._btn_no = UI.getChildControl(Panel_Window_WebPurchaseConfirm_All, "Button_No")
  self._ui._stc_mainBG = UI.getChildControl(Panel_Window_WebPurchaseConfirm_All, "Static_MainBG")
  self._ui._purchaseItemList = UI.getChildControl(self._ui._stc_mainBG, "List2_1")
  self._ui._desc_edge = UI.getChildControl(Panel_Window_WebPurchaseConfirm_All, "Static_DescEdge_Import")
  self._ui._stc_text_desc = UI.getChildControl(self._ui._desc_edge, "StaticText_Desc")
  self._ui._stc_consolebg = UI.getChildControl(Panel_Window_WebPurchaseConfirm_All, "Static_ConsoleButtonsBG")
  self._txt_btn_yes = self._ui._btn_yes:GetText()
  Panel_Window_WebPurchaseConfirm_All:SetSize(Panel_Window_WebPurchaseConfirm_All:GetSizeX(), stc_titleBg:GetSizeY() + self._ui._stc_mainBG:GetSizeY() + self._ui._btn_yes:GetSizeY() + self._ui._desc_edge:GetSizeY() + 50)
  self._ui._desc_edge:SetPosY(self._ui._btn_yes:GetPosY() + self._ui._btn_yes:GetSizeY() + 10)
  local policyDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BUYCASHBOX_PURCHARSE_BOTTOM_DESC")
  self._ui._stc_text_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_text_desc:SetText(policyDesc)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_WebPurchaseConfirm_All:registEventHandler()
  if Panel_Window_WebPurchaseConfirm_All == nil then
    return
  end
  registerEvent("FromClient_NotifyWebCashRestoreCount", "PaGlobalFunc_NotifyWebCashRestoreCount")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_WebPurchaseConfirm_All_Close()")
  self._ui._btn_yes:addInputEvent("Mouse_LUp", "HandleEventLUp_WebPurchaseConfirm_All_RequestReceive()")
  self._ui._btn_no:addInputEvent("Mouse_LUp", "PaGlobalFunc_WebPurchaseConfirm_All_Close()")
  self._ui._purchaseItemList:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_WebPurchaseConfirm_All_UpdateItemList")
  self._ui._purchaseItemList:createChildContent(__ePAUIList2ElementManagerType_List)
  if _ContentsGroup_UsePadSnapping == true then
    Panel_Window_WebPurchaseConfirm_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "PaGlobalFunc_WebPurchaseConfirm_All_MoveScroll(true)")
    Panel_Window_WebPurchaseConfirm_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "PaGlobalFunc_WebPurchaseConfirm_All_MoveScroll(false)")
    Panel_Window_WebPurchaseConfirm_All:ignorePadSnapMoveToOtherPanel()
  end
end
function PaGlobal_WebPurchaseConfirm_All:prepareOpen()
  if Panel_Window_WebPurchaseConfirm_All == nil then
    return
  end
  FGlobal_Window_PearlBox_Purchase_All_ForceClose()
  local stc_titleBg = UI.getChildControl(Panel_Window_WebPurchaseConfirm_All, "Static_TitleBG")
  local stc_title = UI.getChildControl(stc_titleBg, "Static_Text_Title")
  local stc_mainBG = UI.getChildControl(Panel_Window_WebPurchaseConfirm_All, "Static_MainBG")
  local stc_desc = UI.getChildControl(stc_mainBG, "MultilineText_Desc")
  local stc_desc2 = UI.getChildControl(stc_mainBG, "MultilineText_Desc2")
  local stc_desc_noCount = UI.getChildControl(stc_mainBG, "MultilineText_Desc_NoCount")
  self._ui._itemList = Array.new()
  self._ui._purchaseItemList:SetShow(true)
  local count = 0
  local checkCount = 0
  count = ToClient_getWebCashRestoreCount()
  PaGlobalFunc_WebPurchaseConfirm_All_ClearItemList()
  for index = 0, count - 1 do
    local checkIndex = Int64toInt32(index)
    local productNo = ToClient_getWebCashRestoreCashProductNoByIndex(checkIndex)
    local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productNo)
    if nil ~= cashProduct then
      self._ui._purchaseItemList:getElementManager():pushKey(index)
      checkCount = checkCount + 1
    end
  end
  local cashItemCount = ToClient_getWebCashRestoreCashItemCount()
  local elseItemCount = ToClient_getWebCashRestoreElseItemCount()
  local totalMoveCount = math.floor(ToClient_getWebCashRestoreTotalMoveCount() / 20) + 1
  local desc2_txt = ""
  desc2_txt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BUYCASHBOX_PURCHARSE_TOP_DESC", "count", tostring(ToClient_getWebCashRestoreTotalMoveCount())) .. "\n"
  desc2_txt = desc2_txt .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BUYCASHBOX_PURCHARSE_TOP_DESC2", "count2", tostring(ToClient_getWebCashRestoreTotalItemSSCount())) .. "\n"
  if cashItemCount > 0 and elseItemCount > 0 then
    desc2_txt = desc2_txt .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BUYCASHBOX_DESC_SLOT_BOTHINVEN", "count", tostring(elseItemCount), "count2", tostring(cashItemCount))
  elseif elseItemCount > 0 then
    desc2_txt = desc2_txt .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BUYCASHBOX_DESC_SLOT_INVEN", "count", tostring(elseItemCount))
  elseif cashItemCount > 0 then
    desc2_txt = desc2_txt .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BUYCASHBOX_DESC_SLOT_CASHINVEN", "count", tostring(cashItemCount))
  end
  if desc2_txt == "" then
    stc_desc2:SetShow(false)
  else
    stc_desc2:SetShow(true)
    stc_desc2:SetText(desc2_txt)
  end
  if checkCount == 0 then
    stc_desc:SetShow(false)
    stc_desc_noCount:SetShow(true)
    self._ui._purchaseItemList:SetShow(false)
  else
    stc_desc:SetShow(true)
    stc_desc_noCount:SetShow(false)
    self._ui._purchaseItemList:SetShow(true)
  end
  if totalMoveCount > 0 then
    self._ui._btn_yes:SetText(self._txt_btn_yes .. "( " .. tostring(totalMoveCount) .. " )")
    self._ui._btn_yes:addInputEvent("Mouse_On", "PaGlobalFunc_WebPurchaseConfirmButtonSimpleTooltip(true)")
    self._ui._btn_yes:addInputEvent("Mouse_Out", "PaGlobalFunc_WebPurchaseConfirmButtonSimpleTooltip(false)")
  else
    self._ui._btn_yes:SetText(self._txt_btn_yes)
    self._ui._btn_yes:addInputEvent("Mouse_On", "")
    self._ui._btn_yes:addInputEvent("Mouse_Out", "")
  end
  self._ui._stc_mainBG:SetSize(self._ui._stc_mainBG:GetSizeX(), Panel_Window_WebPurchaseConfirm_All:GetSizeY() - stc_titleBg:GetSizeY())
  self._ui._stc_consolebg:SetPosY(Panel_Window_WebPurchaseConfirm_All:GetSizeY())
  Panel_Window_WebPurchaseConfirm_All:ignorePadSnapMoveToOtherPanel()
  PaGlobal_WebPurchaseConfirm_All:open()
end
function PaGlobal_WebPurchaseConfirm_All:open()
  if Panel_Window_WebPurchaseConfirm_All == nil then
    return
  end
  Panel_Window_WebPurchaseConfirm_All:SetShow(true)
end
function PaGlobal_WebPurchaseConfirm_All:prepareClose()
  if Panel_Window_WebPurchaseConfirm_All == nil then
    return
  end
  PaGlobal_WebPurchaseConfirm_All:close()
end
function PaGlobal_WebPurchaseConfirm_All:close()
  if Panel_Window_WebPurchaseConfirm_All == nil then
    return
  end
  Panel_Window_WebPurchaseConfirm_All:SetShow(false)
end
function PaGlobal_WebPurchaseConfirm_All:update()
  if Panel_Window_WebPurchaseConfirm_All == nil then
    return
  end
end
function PaGlobal_WebPurchaseConfirm_All:validate()
  if Panel_Window_WebPurchaseConfirm_All == nil then
    return
  end
  self._ui._btn_close:isValidate()
  self._ui._btn_yes:isValidate()
  self._ui._btn_no:isValidate()
  self._ui._purchaseItemList:isValidate()
end
