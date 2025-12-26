function PaGlobalFunc_Couponcode_Input_Confirm()
  if nil == Panel_Window_CouponCode_Input then
    return
  end
  if PaGlobal_CouponCode_Input._contentLabel == "couponCode" then
    PaGlobalFunc_CouponCode_Confirm(PaGlobal_CouponCode_Input._ui._edit_CouponCode:GetEditText(), PaGlobal_CouponCode_Input._contentLabel)
  elseif Panel_Window_CouponCode:GetShow() == true then
    PaGlobalFunc_CouponCode_Confirm(PaGlobal_CouponCode_Input._ui._edit_CouponCode:GetEditText(), PaGlobal_CouponCode_Input._contentLabel)
  else
    PaGlobalFunc_AccountLinking_Web_Confirm(PaGlobal_CouponCode_Input._ui._edit_CouponCode:GetEditText(), PaGlobal_CouponCode_Input._contentLabel)
  end
  PaGlobalFunc_Couponcode_Input_Close()
end
function PaGlobalFunc_Couponcode_Input_SetFocus()
  if nil == Panel_Window_CouponCode_Input then
    return
  end
  SetFocusEdit(PaGlobal_CouponCode_Input._ui._edit_CouponCode)
end
function PaGlobalFunc_Couponcode_Input_OnVirtualKeyboardEnd(input)
  if nil == Panel_Window_CouponCode_Input then
    return
  end
  PaGlobal_CouponCode_Input._ui._edit_CouponCode:SetEditText(input)
  ClearFocusEdit()
end
function PaGlobalFunc_Couponcode_Input_Open(contentLabel)
  if nil == Panel_Window_CouponCode_Input then
    return
  end
  PaGlobal_CouponCode_Input:prepareOpen(contentLabel)
end
function PaGlobalFunc_Couponcode_Input_Close()
  if nil == Panel_Window_CouponCode_Input then
    return
  end
  PaGlobal_CouponCode_Input:prepareClose()
end
