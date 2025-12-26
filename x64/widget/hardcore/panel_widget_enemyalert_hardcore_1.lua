function PaGlobal_EnemyAlert_HardCore_All:initialize()
  if PaGlobal_EnemyAlert_HardCore_All._initialize == true then
    return
  end
  self._ui._btn = UI.getChildControl(Panel_Widget_EnemyAlert_HardCore, "Button_Icon")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_EnemyAlert_HardCore_All:registEventHandler()
  PaGlobal_EnemyAlert_HardCore_All:validate()
  PaGlobal_EnemyAlert_HardCore_All._initialize = true
  self:prepareOpen()
end
function PaGlobal_EnemyAlert_HardCore_All:registEventHandler()
  if Panel_Widget_EnemyAlert_HardCore == nil then
    return
  end
  registerEvent("FromClient_HardCoreChangedNearPlayerAlert", "PaGlobal_EnemyAlert_HardCore_All_UpdatAlert()")
  Panel_Widget_EnemyAlert_HardCore:addInputEvent("Mouse_On", "PaGlobal_EnemyAlert_HardCore_All:showToolTip(true)")
  Panel_Widget_EnemyAlert_HardCore:addInputEvent("Mouse_Out", "PaGlobal_EnemyAlert_HardCore_All:showToolTip(false)")
end
function PaGlobal_EnemyAlert_HardCore_All:validate()
  self._ui._btn:isValidate()
end
function PaGlobal_EnemyAlert_HardCore_All:prepareOpen()
  if Panel_Widget_EnemyAlert_HardCore == nil then
    return
  end
  self:update()
end
function PaGlobal_EnemyAlert_HardCore_All:open()
  if Panel_Widget_EnemyAlert_HardCore == nil then
    return
  end
  Panel_Widget_EnemyAlert_HardCore:SetShow(true)
end
function PaGlobal_EnemyAlert_HardCore_All:prepareClose()
  if Panel_Widget_EnemyAlert_HardCore == nil then
    return
  end
  self._ui._btn:EraseAllEffect()
  self:close()
end
function PaGlobal_EnemyAlert_HardCore_All:close()
  if Panel_Widget_EnemyAlert_HardCore == nil then
    return
  end
  Panel_Widget_EnemyAlert_HardCore:SetShow(false)
end
function PaGlobal_EnemyAlert_HardCore_All:update()
  if Panel_Widget_EnemyAlert_HardCore == nil then
    return
  end
  local level = ToClient_GetHardCoreNearPlayerAlertLevel()
  self._ui._btn:EraseAllEffect()
  if self._prevLevel ~= 0 then
    self._ui._btn:EraseAllEffect()
  end
  if level == 0 then
    self:prepareClose()
  else
    self:open()
    if level == 1 then
      self._ui._btn:AddEffect("fUI_HardCore_Icon_01A", true, 0, 0)
    elseif level == 2 then
      self._ui._btn:AddEffect("fUI_HardCore_Icon_01B", true, 0, 0)
    end
  end
  self._prevLevel = level
end
function PaGlobal_EnemyAlert_HardCore_All:showToolTip(isShow)
  if PaGlobal_EnemyAlert_HardCore_All == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_HARDCORE_ENEMY_ALERT_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_HARDCORE_ENEMY_ALERT_DESC")
  local control = Panel_Widget_EnemyAlert_HardCore
  TooltipSimple_Show(control, name, desc)
end
