function PaGlobal_CharacterInfo_HardCore_ShowAni()
  if PaGlobal_CharacterInfo_HardCore_All == nil then
    return
  end
end
function PaGlobal_CharacterInfo_HardCore_HideAni()
  if PaGlobal_CharacterInfo_HardCore_All == nil then
    return
  end
end
function PaGlobal_CharacterInfo_HardCore_Open()
  if PaGlobal_CharacterInfo_HardCore_All == nil then
    return
  end
  PaGlobal_CharacterInfo_HardCore_All:prepareOpen()
end
function PaGlobal_CharacterInfo_HardCore_Close()
  if PaGlobal_CharacterInfo_HardCore_All == nil then
    return
  end
  if false == Panel_CharacterInfo_HardCore_All:GetShow() then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  TooltipSimple_Hide()
  PaGlobal_CharacterInfo_HardCore_All:prepareClose()
end
function PaGlobal_CharacterInfo_HardCore_Toggle()
  local self = PaGlobal_CharacterInfo_HardCore_All
  if self == nil then
    return
  end
  local isShow = Panel_Menu_HardCore:GetShow()
  if isShow == true then
    PaGlobal_CharacterInfo_HardCore_All:prepareClose()
  else
    PaGlobal_CharacterInfo_HardCore_All:prepareOpen()
  end
end
function PaGlobal_CharacterInfo_HardCore_ClickOtherTab(idx)
  local self = PaGlobal_CharacterInfo_HardCore_All
  if self == nil then
    return
  end
  UI.ASSERT_NAME(nil ~= PaGlobal_CharacterInfo_HardCore_All._tabData[idx], "Panel_CharacterInfo_HardCore_All.lua / self._tabData[idx] is nil ", "-")
  if nil == idx then
    return
  end
  self:otherTabOpen(idx)
end
function PaGlobal_CharacterInfo_HardCore_TabBtn_Tooltip(idx)
  local self = PaGlobal_CharacterInfo_HardCore_All
  if self == nil or idx == nil or self._isConsole == true then
    TooltipSimple_Hide()
    return
  end
  if self._tabData[idx].btn == nil then
    return
  end
  local control, name, desc
  control = self._tabData[idx].btn
  name = PAGetString(Defines.StringSheet_RESOURCE, self._TABSTRING[idx])
  TooltipSimple_Show(control, name, dsec)
end
function PaGlobal_CharacterInfo_HardCore_initTab(index, panel, updateFunc)
  local self = PaGlobal_CharacterInfo_HardCore_All
  if self == nil or panel == nil then
    return
  end
  self:setTabData(index, panel, updateFunc)
end
function PaGlobalFunc_ChracterInfo_HardCore_GetBgShow(idx)
  local self = PaGlobal_CharacterInfo_HardCore_All
  if false == Panel_CharacterInfo_HardCore_All:GetShow() or nil == self._tabData[idx] then
    return false
  end
  if nil ~= self._tabData[idx].bg then
    return self._tabData[idx].bg:GetShow()
  else
    UI.ASSERT_NAME(nil ~= self._tabData[idx].bg, "Panel_CharacterInfo_HardCore_All.lua / PaGlobal_CharacterInfo_HardCore_All._tabData[idx].bg[" .. idx .. "] is nil ", "-")
  end
end
function HandleEventLUp_ChracterInfo_HardCore_All_PopUpUI()
  if false == Panel_CharacterInfo_HardCore_All:IsUISubApp() then
    Panel_CharacterInfo_HardCore_All:OpenUISubApp()
  else
    Panel_CharacterInfo_HardCore_All:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function HandleEventOnOut_ChracterInfo_HardCore_All_PopUpUI_Tooltip(isShow)
  if false == isShow or nil == type then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
  if false == Panel_CharacterInfo_HardCore_All:IsUISubApp() then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
  else
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
  end
  control = PaGlobal_CharacterInfo_HardCore_All._ui._btn_StickerUI
  TooltipSimple_Show(control, name, desc)
end
