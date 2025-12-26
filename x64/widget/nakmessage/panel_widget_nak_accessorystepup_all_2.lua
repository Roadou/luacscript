function PaGloabl_Widget_Nak_AccessoryStepUp_All_Open(nakType, itemName)
  if _ContentsGroup_AccessoryStepUp == false then
    return
  end
  if nakType == nil then
    return
  end
  local self = PaGlobal_Widget_Nak_AccessoryStepUp_All
  if self == nil then
    return
  end
  self:prepareOpen(nakType, itemName)
end
function PaGloabl_Widget_Nak_AccessoryStepUp_All_Close()
  if _ContentsGroup_AccessoryStepUp == false then
    return
  end
  local self = PaGlobal_Widget_Nak_AccessoryStepUp_All
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGloabl_Widget_Nak_AccessoryStepUp_All_ExecuteLuaFunc(funcText)
  if getSelfPlayer() == nil then
    return
  end
  if funcText == "GetStepUpAccessory" then
    PaGloabl_Widget_Nak_AccessoryStepUp_All_Open(0)
  end
end
function PaGloabl_Widget_Nak_AccessoryStepUp_All_ShowAni()
  if Panel_Widget_Nak_AccessoryStepUp_All == nil then
    return
  end
end
function PaGloabl_Widget_Nak_AccessoryStepUp_All_HideAni()
  if Panel_Widget_Nak_AccessoryStepUp_All == nil then
    return
  end
end
