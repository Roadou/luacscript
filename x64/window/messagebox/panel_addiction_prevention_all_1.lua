function PaGlobal_AddictionPrevent:initialize()
  if Panel_Addiction_Prevention_All == nil then
    return
  end
  if self._initialize == true then
    return
  end
  self._ui.stc_titleArea = UI.getChildControl(Panel_Addiction_Prevention_All, "Static_TitleArea")
  self._ui.stc_blackBG = UI.getChildControl(Panel_Addiction_Prevention_All, "Static_BlackBG")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_titleArea, "StaticText_TItle")
  self._ui.txt_desc = UI.getChildControl(Panel_Addiction_Prevention_All, "MultilineText_Desc")
  self._ui.btn_exit = UI.getChildControl(Panel_Addiction_Prevention_All, "Button_Exit")
  local screenX = getResolutionSizeX()
  local screenY = getResolutionSizeY()
  self._ui.stc_blackBG:SetSize(screenX, screenY)
  self:registerEventHandler()
  self:validate()
  self._isPadSnapping = _ContentsGroup_UsePadSnapping
  self._initialize = true
  ToClient_CheckAntiAddictionActions()
end
function PaGlobal_AddictionPrevent:registerEventHandler()
  registerEvent("FromClient_OpenAntiAddictionActions", "FromClient_OpenAntiAddictionActions")
  registerEvent("FromClient_OpenAntiAddictionActionsByCustom", "FromClient_OpenAntiAddictionActionsByCustom")
  registerEvent("FromClient_AntiAddictionBuyCashShop", "FromClient_AntiAddictionBuyCashShop")
end
function PaGlobal_AddictionPrevent:prepareOpen()
  if Panel_Addiction_Prevention_All == nil then
    return
  end
  self:update()
  self:open()
end
function PaGlobal_AddictionPrevent:open()
  if Panel_Addiction_Prevention_All == nil then
    return
  end
  Panel_Addiction_Prevention_All:SetShow(true)
end
function PaGlobal_AddictionPrevent:prepareClose()
  if Panel_Addiction_Prevention_All == nil then
    return
  end
  if ToClient_GetAntiAddictionType() == 2 then
    Panel_Addiction_Prevention_All:SetShow(false)
    exitGameClient(true)
    return
  end
  self:close()
end
function PaGlobal_AddictionPrevent:close()
  if Panel_Addiction_Prevention_All == nil then
    return
  end
  Panel_Addiction_Prevention_All:SetShow(false)
end
function PaGlobal_AddictionPrevent:update()
  if Panel_Addiction_Prevention_All == nil then
    return
  end
  local title = ToClient_GetAntiAddictionTitle()
  local content = ToClient_GetAntiAddictionContent()
  local typeID = ToClient_GetAntiAddictionType()
  self._ui.txt_title:SetText(title)
  self._ui.txt_desc:SetText(content)
  local screenX = getResolutionSizeX()
  local screenY = getResolutionSizeY()
  self._ui.stc_blackBG:SetSize(screenX, screenY)
  if typeID == 1 then
    self._ui.btn_exit:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CONFIRM"))
  elseif typeID == 2 then
    self._ui.btn_exit:SetText(PAGetString(Defines.StringSheet_RESOURCE, "GAMEEXIT_PRE_TEXT_TITLE"))
  end
  self:computePos()
  self._ui.btn_exit:addInputEvent("Mouse_LUp", "PaGlobal_AddictionPrevent:prepareClose()")
end
function PaGlobal_AddictionPrevent:computePos()
  if Panel_Addiction_Prevention_All == nil then
    return
  end
  local screenX = getResolutionSizeX()
  local screenY = getResolutionSizeY()
  self._ui.stc_blackBG:SetSize(screenX, screenY)
  Panel_Addiction_Prevention_All:ComputePosAllChild()
  self._ui.txt_desc:SetSize(self._ui.txt_desc:GetSizeX(), self._ui.txt_desc:GetTextSizeY())
  Panel_Addiction_Prevention_All:SetSize(Panel_Addiction_Prevention_All:GetSizeX(), self._ui.txt_title:GetSizeY() + self._ui.txt_desc:GetSizeY() + 70)
  self._ui.btn_exit:SetPosY(self._ui.txt_desc:GetPosY() + self._ui.txt_desc:GetSizeY() + 8)
end
function FromClient_OpenAntiAddictionActions(isShow)
  if isShow == true then
    PaGlobal_AddictionPrevent:prepareOpen()
  else
    PaGlobal_AddictionPrevent:prepareClose()
  end
end
function FromClient_AntiAddictionBuyCashShop(type, title, msg)
  if Panel_Addiction_Prevention_All == nil then
    return
  end
  if type == -1 then
    return
  end
  if type == 0 then
    _InGameShopBuy_Confirm_EnoughMoney(-1)
    return
  end
  local self = PaGlobal_AddictionPrevent
  local title = title
  local content = msg
  self._ui.txt_title:SetText(title)
  self._ui.txt_desc:SetText(content)
  self._ui.btn_exit:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CONFIRM"))
  if type == 1 then
    self._ui.btn_exit:addInputEvent("Mouse_LUp", "_InGameShopBuy_Confirm_EnoughMoney(-1)")
  elseif type == 7 then
    self._ui.btn_exit:addInputEvent("Mouse_LUp", "PaGlobal_AddictionPrevent:prepareClose()")
  end
  self:computePos()
  self:open()
end
function PaGlobal_AddictionPrevent:validate()
  if Panel_Addiction_Prevention_All == nil then
    return
  end
  self._ui.stc_titleArea:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui.btn_exit:isValidate()
end
function FromClient_OpenAntiAddictionActionsByCustom(argument)
  PaGlobal_AddictionPrevent._customArgument = argument
  luaTimer_AddEvent(FromClient_OpenAntiAddictionActionsByCustom_XXX, 3000, false, 0)
end
function FromClient_OpenAntiAddictionActionsByCustom_XXX()
  if Panel_Addiction_Prevention_All == nil then
    return
  end
  local descTable = {
    [1] = "\228\186\178\231\136\177\231\154\132\231\148\168\230\136\183\239\188\140\230\160\185\230\141\174\232\133\190\232\174\175\230\156\170\230\136\144\229\185\180\228\186\186\229\129\165\229\186\183\228\184\138\231\189\145\228\191\157\230\138\164\232\174\161\229\136\146\239\188\140\231\148\177\228\186\142\230\156\170\230\187\16112\229\178\129\239\188\140\230\130\168\230\154\130\230\151\182\230\151\160\230\179\149\228\189\191\231\148\168\229\133\133\229\128\188\229\138\159\232\131\189",
    [2] = "\228\186\178\231\136\177\231\154\132\231\148\168\230\136\183\239\188\140\230\160\185\230\141\174\232\133\190\232\174\175\230\156\170\230\136\144\229\185\180\228\186\186\229\129\165\229\186\183\228\184\138\231\189\145\228\191\157\230\138\164\232\174\161\229\136\146\239\188\140\231\148\177\228\186\142\230\156\170\230\187\16116\229\178\129\239\188\140\230\130\168\231\154\132\229\141\149\230\172\161\229\133\133\229\128\188\228\184\141\229\190\151\232\182\133\232\191\13550\229\133\131\239\188\140\232\175\183\233\128\137\230\139\169\229\133\182\228\187\150\229\133\133\229\128\188\230\161\163\228\189\141",
    [3] = "\228\186\178\231\136\177\231\154\132\231\148\168\230\136\183\239\188\140\230\160\185\230\141\174\232\133\190\232\174\175\230\156\170\230\136\144\229\185\180\228\186\186\229\129\165\229\186\183\228\184\138\231\189\145\228\191\157\230\138\164\232\174\161\229\136\146\239\188\140\231\148\177\228\186\142\230\156\170\230\187\16116\229\178\129\239\188\140\230\130\168\230\156\172\230\156\136\229\133\133\229\128\188\228\184\141\232\131\189\232\182\133\232\191\135200\229\133\131",
    [4] = "\228\186\178\231\136\177\231\154\132\231\148\168\230\136\183\239\188\140\230\160\185\230\141\174\232\133\190\232\174\175\230\156\170\230\136\144\229\185\180\228\186\186\229\129\165\229\186\183\228\184\138\231\189\145\228\191\157\230\138\164\232\174\161\229\136\146\239\188\140\231\148\177\228\186\142\230\156\170\230\187\16118\229\178\129\239\188\140\230\130\168\231\154\132\229\141\149\230\172\161\229\133\133\229\128\188\228\184\141\229\190\151\232\182\133\232\191\135100\229\133\131\239\188\140\232\175\183\233\128\137\230\139\169\229\133\182\228\187\150\229\133\133\229\128\188\230\161\163\228\189\141",
    [5] = "\228\186\178\231\136\177\231\154\132\231\148\168\230\136\183\239\188\140\230\160\185\230\141\174\232\133\190\232\174\175\230\156\170\230\136\144\229\185\180\228\186\186\229\129\165\229\186\183\228\184\138\231\189\145\228\191\157\230\138\164\232\174\161\229\136\146\239\188\140\231\148\177\228\186\142\230\156\170\230\187\16118\229\178\129\239\188\140\230\130\168\230\156\172\230\156\136\229\133\133\229\128\188\228\184\141\232\131\189\232\182\133\232\191\135400\229\133\131"
  }
  local self = PaGlobal_AddictionPrevent
  local title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_FUNCTION_ALERT_VIEW")
  local content = descTable[PaGlobal_AddictionPrevent._customArgument]
  local typeID = 1
  self._ui.txt_title:SetText(title)
  self._ui.txt_desc:SetText(content)
  if typeID == 1 then
    self._ui.btn_exit:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CONFIRM"))
  elseif typeID == 2 then
    self._ui.btn_exit:SetText(PAGetString(Defines.StringSheet_RESOURCE, "GAMEEXIT_PRE_TEXT_TITLE"))
  end
  self:computePos()
  self._ui.btn_exit:addInputEvent("Mouse_LUp", "PaGlobal_AddictionPrevent:prepareClose()")
  self:open()
end
