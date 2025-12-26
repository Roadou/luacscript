function PaGlobal_Picture:initialize()
  if true == PaGlobal_Picture._initialize then
    return
  end
  self._ui.stc_pic1 = UI.getChildControl(Panel_Window_Picture, "Static_Picture1")
  self._ui.stc_pic2 = UI.getChildControl(Panel_Window_Picture, "Static_Picture2")
  self._ui.stc_pic3 = UI.getChildControl(Panel_Window_Picture, "Static_Picture3")
  self._ui.btn_Close = UI.getChildControl(Panel_Window_Picture, "Button_Close")
  self._ui.stc_KeyguideB = UI.getChildControl(Panel_Window_Picture, "StaticText_BButton")
  PaGlobal_Picture:registEventHandler()
  PaGlobal_Picture:validate()
  PaGlobal_Picture._initialize = true
end
function PaGlobal_Picture:registEventHandler()
  if nil == Panel_Window_Picture then
    return
  end
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_Picture_Close()")
  Panel_Window_Picture:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_Picture_Close()")
end
function PaGlobal_Picture:prepareOpen(eType)
  if nil == Panel_Window_Picture then
    return
  end
  self:initTexture(eType)
  self:switchPadUI(_ContentsGroup_UsePadSnapping)
  PaGlobal_Picture:open()
end
function PaGlobal_Picture:switchPadUI(isPadUse)
  self._ui.stc_KeyguideB:SetShow(isPadUse)
  self._ui.btn_Close:SetShow(not isPadUse)
  self._ui.stc_KeyguideB:ComputePos()
  if true == _ContentsGroup_UsePadSnapping then
    Panel_Window_Picture:ignorePadSnapMoveToOtherPanel()
  end
end
function PaGlobal_Picture:open()
  if nil == Panel_Window_Picture then
    return
  end
  Panel_Window_Picture:SetShow(true)
end
function PaGlobal_Picture:prepareClose()
  if nil == Panel_Window_Picture then
    return
  end
  PaGlobal_Picture:close()
end
function PaGlobal_Picture:close()
  if nil == Panel_Window_Picture then
    return
  end
  Panel_Window_Picture:SetShow(false)
end
function PaGlobal_Picture:validate()
  if nil == Panel_Window_Picture then
    return
  end
  self._ui.stc_pic1:isValidate()
  self._ui.stc_pic2:isValidate()
  self._ui.stc_pic3:isValidate()
  self._ui.btn_Close:isValidate()
end
function PaGlobal_Picture:initTexture(eType)
  self._ui.stc_pic1:SetShow(false)
  self._ui.stc_pic2:SetShow(false)
  self._ui.stc_pic3:SetShow(false)
  if self._eType.termianMapHint1 == eType then
    self._ui.stc_pic1:SetShow(true)
  elseif self._eType.termianMapHint2 == eType then
    self._ui.stc_pic2:SetShow(true)
  elseif self._eType.termianMapHint3 == eType then
    self._ui.stc_pic3:SetShow(true)
  end
end
