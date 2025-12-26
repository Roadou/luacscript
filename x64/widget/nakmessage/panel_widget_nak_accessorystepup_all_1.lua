function PaGlobal_Widget_Nak_AccessoryStepUp_All:initialize()
  if self._initialize == true then
    return
  end
  self._ui._txt_msg = UI.getChildControl(Panel_Widget_Nak_AccessoryStepUp_All, "StaticText_ExchangeMsg")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Widget_Nak_AccessoryStepUp_All:registEventHandler()
  if Panel_Widget_Nak_AccessoryStepUp_All == nil then
    return
  end
  registerEvent("executeLuaFunc", "PaGloabl_Widget_Nak_AccessoryStepUp_All_ExecuteLuaFunc")
end
function PaGlobal_Widget_Nak_AccessoryStepUp_All:prepareOpen(nakType, itemName)
  if Panel_Widget_Nak_AccessoryStepUp_All == nil then
    return
  end
  local messageString = ""
  if nakType == self._eNakType._CLEAR_QUEST then
    messageString = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_QUESTCLEAR")
  elseif nakType == self._eNakType._GET_ACCESSORY then
    messageString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_ACHIEVEMSG", "itemName", itemName)
  elseif nakType == self._eNakType._EXCHANGE_ACCESSORY then
    messageString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_EXCHANGEMSG", "itemName", itemName)
  else
    return
  end
  self._ui._txt_msg:SetText(messageString)
  self._ui._txt_msg:SetShow(true)
  local ImageAni = Panel_Widget_Nak_AccessoryStepUp_All:addColorAnimation(0, 0.25, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  ImageAni:SetStartColor(Defines.Color.C_00FFFFFF)
  ImageAni:SetEndColor(Defines.Color.C_FFFFFFFF)
  ImageAni.IsChangeChild = true
  local ImageAni = Panel_Widget_Nak_AccessoryStepUp_All:addColorAnimation(0.25, 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  ImageAni:SetStartColor(Defines.Color.C_FFFFFFFF)
  ImageAni:SetEndColor(Defines.Color.C_FFFFFFFF)
  ImageAni.IsChangeChild = true
  local ImageAni = Panel_Widget_Nak_AccessoryStepUp_All:addColorAnimation(3, 4.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  ImageAni:SetStartColor(Defines.Color.C_FFFFFFFF)
  ImageAni:SetEndColor(Defines.Color.C_00FFFFFF)
  ImageAni.IsChangeChild = true
  local showNakEffect = function()
    Panel_Widget_Nak_AccessoryStepUp_All:AddEffect("fUI_Jewelry_Change_Nak_01A")
    audioPostEvent_SystemUi(5, 95)
    _AudioPostEvent_SystemUiForXBOX(5, 95)
  end
  luaTimer_AddEvent(showNakEffect, 150, false, 0)
  luaTimer_AddEvent(PaGloabl_Widget_Nak_AccessoryStepUp_All_Close, 4500, false, 0)
  self:open()
end
function PaGlobal_Widget_Nak_AccessoryStepUp_All:open()
  if Panel_Widget_Nak_AccessoryStepUp_All == nil then
    return
  end
  Panel_Widget_Nak_AccessoryStepUp_All:SetShow(true)
end
function PaGlobal_Widget_Nak_AccessoryStepUp_All:prepareClose()
  if Panel_Widget_Nak_AccessoryStepUp_All == nil then
    return
  end
  self:close()
end
function PaGlobal_Widget_Nak_AccessoryStepUp_All:close()
  if Panel_Widget_Nak_AccessoryStepUp_All == nil then
    return
  end
  Panel_Widget_Nak_AccessoryStepUp_All:SetShow(false)
end
function PaGlobal_Widget_Nak_AccessoryStepUp_All:update()
  if Panel_Widget_Nak_AccessoryStepUp_All == nil then
    return
  end
end
function PaGlobal_Widget_Nak_AccessoryStepUp_All:validate()
  if Panel_Widget_Nak_AccessoryStepUp_All == nil then
    return
  end
  self._ui._txt_msg:isValidate()
end
