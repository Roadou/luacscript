function PaGlobal_CouponCode_Input:initialize()
  if true == PaGlobal_CouponCode_Input._initialize then
    return
  end
  self._ui._edit_CouponCode = UI.getChildControl(Panel_Window_CouponCode_Input, "Edit_CouponCode")
  self._ui._stc_keyGuide_bg = UI.getChildControl(Panel_Window_CouponCode_Input, "Static_KeyGuide_ConsoleUI")
  self._ui._txt_BKey = UI.getChildControl(self._ui._stc_keyGuide_bg, "StaticText_B_ConsoleUI")
  self._ui._txt_AKey = UI.getChildControl(self._ui._stc_keyGuide_bg, "StaticText_A_ConsoleUI")
  self._ui._txt_searchIcon = UI.getChildControl(Panel_Window_CouponCode_Input, "StaticText_SearchIcon")
  self._ui._txt_searchIconTitle = UI.getChildControl(self._ui._txt_searchIcon, "StaticText_Title")
  PaGlobal_CouponCode_Input:registEventHandler()
  PaGlobal_CouponCode_Input:validate()
  PaGlobal_CouponCode_Input._initialize = true
end
function PaGlobal_CouponCode_Input:registEventHandler()
  if nil == Panel_Window_CouponCode_Input then
    return
  end
  registerEvent("onScreenResize", "FromClient_ProductNote_Search_Resize")
  registerEvent("FromClient_RequestContentString", "PaGlobalFunc_Couponcode_Input_Open")
  Panel_Window_CouponCode_Input:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_Couponcode_Input_Confirm()")
  Panel_Window_CouponCode_Input:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_Couponcode_Input_SetFocus()")
  self._ui._edit_CouponCode:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_Couponcode_Input_OnVirtualKeyboardEnd")
end
function PaGlobal_CouponCode_Input:prepareOpen(contentLabel)
  if nil == Panel_Window_CouponCode_Input then
    return
  end
  self._contentLabel = contentLabel
  if self._contentLabel == "_password" then
    PaGlobal_CouponCode_Input._ui._edit_CouponCode:SetSafeMode(true)
    self._ui._txt_searchIconTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ACCOUNT_LINKING_PW"))
    self._ui._edit_CouponCode:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ACCOUNT_LINKING_NO_PW"))
  elseif self._contentLabel == "_email" then
    self._ui._txt_searchIconTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ACCOUNT_LINKING_ID"))
    self._ui._edit_CouponCode:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ACCOUNT_LINKING_NO_ID"))
  elseif self._contentLabel == "couponCode" then
    self._ui._txt_searchIconTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COUPON_INPUT_TITLE"))
    self._ui._edit_CouponCode:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COUPON_INPUT_EDIT_DEFAULT"))
  end
  PaGlobal_CouponCode_Input:open()
end
function PaGlobal_CouponCode_Input:open()
  if nil == Panel_Window_CouponCode_Input then
    return
  end
  Panel_Window_CouponCode_Input:SetShow(true)
end
function PaGlobal_CouponCode_Input:prepareClose()
  if nil == Panel_Window_CouponCode_Input then
    return
  end
  self._contentLabel = "-"
  PaGlobal_CouponCode_Input._ui._edit_CouponCode:SetSafeMode(false)
  PaGlobal_CouponCode_Input._ui._edit_CouponCode:SetEditText("")
  PaGlobal_CouponCode_Input:close()
end
function PaGlobal_CouponCode_Input:close()
  if nil == Panel_Window_CouponCode_Input then
    return
  end
  Panel_Window_CouponCode_Input:SetShow(false)
end
function PaGlobal_CouponCode_Input:validate()
  if nil == Panel_Window_CouponCode_Input then
    return
  end
  self._ui._edit_CouponCode:isValidate()
  self._ui._stc_keyGuide_bg:isValidate()
  self._ui._txt_BKey:isValidate()
  self._ui._txt_AKey:isValidate()
end
