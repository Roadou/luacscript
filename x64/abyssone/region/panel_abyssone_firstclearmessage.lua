PaGlobal_AbyssOne_FirstClearMessage = {
  _accDeltaTime = 0,
  _isOnceShowed = false,
  _showTime = 5,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_AbyssOne_FirstClearMessage_Init")
function FromClient_AbyssOne_FirstClearMessage_Init()
  PaGlobal_AbyssOne_FirstClearMessage:initialize()
end
function PaGlobal_AbyssOne_FirstClearMessage:initialize()
  if self._initialize == true then
    return
  end
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_AbyssOne_FirstClearMessage:registEventHandler()
  if Panel_AbyssOne_FirstClearMessage == nil then
    return
  end
  Panel_AbyssOne_FirstClearMessage:RegisterShowEventFunc(true, "Panel_AbyssOne_FirstClearMessage_ShowAni()")
  Panel_AbyssOne_FirstClearMessage:RegisterShowEventFunc(false, "Panel_AbyssOne_FirstClearMessage_HideAni()")
end
function PaGlobal_AbyssOne_FirstClearMessage:prepareOpen()
  if Panel_AbyssOne_FirstClearMessage == nil then
    return
  end
  if self._isOnceShowed == true then
    return
  else
    self._isOnceShowed = true
  end
  local stc_bg = UI.getChildControl(Panel_AbyssOne_FirstClearMessage, "Static_Desc_BG")
  local txt_desc = UI.getChildControl(stc_bg, "MultilineText_Desc")
  txt_desc:AddEffect("UI_QustPerform01", false, 80, 0)
  self:open()
end
function PaGlobal_AbyssOne_FirstClearMessage:open()
  if Panel_AbyssOne_FirstClearMessage == nil then
    return
  end
  Panel_AbyssOne_FirstClearMessage:ComputePos()
  Panel_AbyssOne_FirstClearMessage:RegisterUpdateFunc("PaGlobalFunc_AbyssOne_FirstClearMessage_Update")
  Panel_AbyssOne_FirstClearMessage:SetShow(true, true)
end
function PaGlobal_AbyssOne_FirstClearMessage:prepareClose()
  if Panel_AbyssOne_FirstClearMessage == nil then
    return
  end
  self._accDeltaTime = 0
  self:close()
end
function PaGlobal_AbyssOne_FirstClearMessage:close()
  if Panel_AbyssOne_FirstClearMessage == nil then
    return
  end
  Panel_AbyssOne_FirstClearMessage:ClearUpdateLuaFunc()
  Panel_AbyssOne_FirstClearMessage:SetShow(false, true)
end
function PaGlobalFunc_AbyssOne_FirstClearMessage_Open()
  local self = PaGlobal_AbyssOne_FirstClearMessage
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_AbyssOne_FirstClearMessage_Close()
  local self = PaGlobal_AbyssOne_FirstClearMessage
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_AbyssOne_FirstClearMessage_Update(deltaTime)
  local self = PaGlobal_AbyssOne_FirstClearMessage
  if self == nil then
    return
  end
  self._accDeltaTime = self._accDeltaTime + deltaTime
  if self._showTime <= self._accDeltaTime then
    PaGlobalFunc_AbyssOne_FirstClearMessage_Close()
  end
end
function Panel_AbyssOne_FirstClearMessage_ShowAni()
  Panel_AbyssOne_FirstClearMessage:SetAlpha(0)
  local aniInfo = UIAni.AlphaAnimation(1, Panel_AbyssOne_FirstClearMessage, 0, 0.5)
end
function Panel_AbyssOne_FirstClearMessage_HideAni()
  Panel_AbyssOne_FirstClearMessage:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_AbyssOne_FirstClearMessage, 0, 0.5)
  aniInfo:SetHideAtEnd(true)
end
