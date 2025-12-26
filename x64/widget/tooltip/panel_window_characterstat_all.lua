PaGlobal_Window_CharacterStat_All = {
  _ui = {
    _stc_TitleArea = nil,
    _btn_Close = nil,
    _combo_Stat = nil,
    _btn_Reload = nil,
    _btn_ShowDiff = nil,
    _stc_ServerBG = nil,
    _txt_Server = nil,
    _stc_ClientBG = nil,
    _txt_Client = nil
  },
  _STAT_TYPE = {
    _OFFENCE = 0,
    _PV = 1,
    _DV = 2,
    _HIT = 3,
    _SPECIALATTACK = 4,
    _RESISTANCE = 5,
    _SPEED = 6,
    _ACQUIRE = 7,
    _COUNT = 7
  },
  _STAT_STRING = {
    [0] = "\234\179\181\234\178\169\235\160\165",
    [1] = "\237\148\188\237\149\180 \234\176\144\236\134\140",
    [2] = "\237\154\140\237\148\188",
    [3] = "\236\160\129\236\164\145",
    [4] = "\237\138\185\236\182\148\237\148\188",
    [5] = "\236\160\128\237\149\173",
    [6] = "\234\179\181\236\134\141 \236\157\180\236\134\141 \236\139\156\236\134\141",
    [7] = "\237\154\141\235\147\157"
  },
  _ATT_BUFF_SOURCETYPE = {
    [0] = "\236\157\188\235\176\152",
    [1] = "\236\158\165\235\185\132 \236\138\164\237\130\172 [\236\158\165\235\185\132\236\138\164\237\130\172, \236\158\165\235\185\132 \236\132\184\237\138\184\236\152\181\236\133\152, \236\158\172\235\160\168, \234\181\176\236\153\149 \236\158\172\235\160\168 \235\147\177]",
    [2] = "\236\136\152\236\160\149, \234\180\145\235\170\133\236\132\157 [\236\136\152\236\160\149, \236\136\152\236\160\149\236\132\184\237\138\184, \234\180\145\235\170\133\236\132\157, \234\180\145\235\170\133\236\132\157 \236\132\184\237\138\184 \235\147\177]",
    [3] = "\234\176\128\235\172\184\235\139\168\236\156\132 \236\160\129\236\154\169\236\138\164\237\130\172[\234\177\176\236\160\144\236\138\164\237\130\172, \236\130\176\236\130\188 \235\147\177] ",
    [4] = "\236\186\144\235\166\173\237\132\176 \235\178\132\237\148\132 [\237\140\168\236\139\156\235\184\140, \236\149\161\237\139\176\235\184\140, \235\148\148\235\178\132\237\148\132 \235\147\177]"
  },
  _currentStatType = 0,
  _showDiff = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_CharacterStatInit")
function FromClient_CharacterStatInit()
  PaGlobal_Window_CharacterStat_All:initialize()
end
function PaGlobal_Window_CharacterStat_All:initialize()
  if self._isInitialize == true then
    return
  end
  self._ui._stc_TitleArea = UI.getChildControl(Panel_Window_CharacterStat_All, "Static_TitleArea")
  self._ui._btn_Close = UI.getChildControl(self._ui._stc_TitleArea, "Button_Close")
  self._ui._combo_Stat = UI.getChildControl(Panel_Window_CharacterStat_All, "Combobox_Stat")
  self._ui._btn_Reload = UI.getChildControl(Panel_Window_CharacterStat_All, "Button_Reload")
  self._ui._btn_ShowDiff = UI.getChildControl(Panel_Window_CharacterStat_All, "Button_ShowDiff")
  self._ui._stc_ServerBG = UI.getChildControl(Panel_Window_CharacterStat_All, "Static_ServerBg")
  self._ui._txt_Server = UI.getChildControl(self._ui._stc_ServerBG, "StaticText_Desc")
  self._ui._stc_ClientBG = UI.getChildControl(Panel_Window_CharacterStat_All, "Static_ClientBg")
  self._ui._txt_Client = UI.getChildControl(self._ui._stc_ClientBG, "StaticText_Desc")
  self:registerEventHandler()
  self:validate()
  for index = 0, #self._STAT_STRING do
    self._ui._combo_Stat:AddItem(self._STAT_STRING[index])
  end
  self._ui._combo_Stat:SetSelectItemIndex(0)
  self._ui._combo_Stat:GetListControl():AddSelectEvent("HandleEventLUp_ChracterStat_Select()")
  self._isInitialize = true
end
function PaGlobal_Window_CharacterStat_All:registerEventHandler()
  if Panel_Window_CharacterStat_All == nil then
    return
  end
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_Window_CharacterStat_All_Close()")
  self._ui._combo_Stat:addInputEvent("Mouse_LUp", "PaGlobal_Window_CharacterStat_All_ToggleList()")
  self._ui._btn_Reload:addInputEvent("Mouse_LUp", "HandleEventLUp_ReloadDebugStatInfo()")
  self._ui._btn_ShowDiff:addInputEvent("Mouse_LUp", "HandleEventLUp_ShowDiff()")
  registerEvent("FromClient_ResponseShowPlayerStat", "FromClient_ResponseShowPlayerStat")
end
function PaGlobal_Window_CharacterStat_All:prepareOpen()
  if Panel_Window_CharacterStat_All == nil then
    return
  end
  if self:update(self._currentStatType) == false then
    return
  end
  self:open()
end
function PaGlobal_Window_CharacterStat_All:open()
  if Panel_Window_CharacterStat_All == nil then
    return
  end
  Panel_Window_CharacterStat_All:SetShow(true)
end
function PaGlobal_Window_CharacterStat_All:prepareClose()
  if Panel_Window_CharacterStat_All == nil then
    return
  end
  self:close()
end
function PaGlobal_Window_CharacterStat_All:close()
  if Panel_Window_CharacterStat_All == nil then
    return
  end
  Panel_Window_CharacterStat_All:SetShow(false)
end
function PaGlobal_Window_CharacterStat_All:update(statType)
  if Panel_Window_CharacterStat_All == nil then
    return false
  end
  local stat = ToClient_getDebugStatInfo()
  if stat == nil then
    return false
  end
  local oldStat = ToClient_getOldDebugStatInfo()
  if oldStat == nil then
    return false
  end
  local serverString = ""
  local clientString = ""
  if statType == self._STAT_TYPE._OFFENCE then
    serverString = self:updateReboot(statType)
  elseif statType == self._STAT_TYPE._PV then
    serverString = self:updateReboot(statType)
  elseif statType == self._STAT_TYPE._DV then
    serverString = self:updateReboot(statType)
  elseif statType == self._STAT_TYPE._HIT then
    serverString = self:updateReboot(statType)
  elseif statType == self._STAT_TYPE._SPECIALATTACK then
    serverString = self:updateReboot(statType)
  elseif statType == self._STAT_TYPE._RESISTANCE then
    serverString = self:updateReboot(statType)
  elseif statType == self._STAT_TYPE._SPEED then
    serverString = serverString .. "<PAColor0xffa78e6a> - \235\130\180 \236\160\149\235\179\180 \236\158\160\236\158\172\235\160\165\236\151\144 \236\158\136\235\138\148 \236\166\157\234\176\128\236\156\168 - <PAOldColor> \n\t"
    serverString = serverString .. "\236\157\180\235\143\153 \236\134\141\235\143\132 \236\166\157\234\176\128\236\156\168(" .. makePercentString(stat:getPointSpeedRate(0), oldStat:getPointSpeedRate(0)) .. [[
) 
	]]
    serverString = serverString .. "\234\179\181\234\178\169 \236\134\141\235\143\132 \236\166\157\234\176\128\236\156\168(" .. makePercentString(stat:getPointSpeedRate(1), oldStat:getPointSpeedRate(1)) .. [[
) 
	]]
    serverString = serverString .. "\236\186\144\236\138\164\237\140\133 \236\134\141\235\143\132 \236\166\157\234\176\128\236\156\168(" .. makePercentString(stat:getPointSpeedRate(2), oldStat:getPointSpeedRate(2)) .. [[
) 

	]]
    serverString = serverString .. "<PAColor0xffa78e6a> - \235\130\180 \236\160\149\235\179\180 \236\158\160\236\158\172\235\160\165\236\151\144 \236\158\136\235\138\148 \236\166\157\234\176\128\236\156\168\236\157\152 \237\149\156\234\179\132\236\185\152 - <PAOldColor> \n\t"
    serverString = serverString .. "\236\157\180\235\143\153 \236\134\141\235\143\132 \236\166\157\234\176\128\236\156\168 \237\149\156\234\179\132\236\185\152(" .. makePercentString(stat:getPointSpeedRateLimit(0), oldStat:getPointSpeedRateLimit(0)) .. [[
) 
	]]
    serverString = serverString .. "\234\179\181\234\178\169 \236\134\141\235\143\132 \236\166\157\234\176\128\236\156\168 \237\149\156\234\179\132\236\185\152(" .. makePercentString(stat:getPointSpeedRateLimit(1), oldStat:getPointSpeedRateLimit(1)) .. [[
) 
	]]
    serverString = serverString .. "\236\186\144\236\138\164\237\140\133 \236\134\141\235\143\132 \236\166\157\234\176\128\236\156\168 \237\149\156\234\179\132\236\185\152(" .. makePercentString(stat:getPointSpeedRateLimit(2), oldStat:getPointSpeedRateLimit(2)) .. [[
) 

	]]
    serverString = serverString .. "<PAColor0xffa78e6a> - \236\181\156\236\162\133 \236\166\157\234\176\128\236\156\168 - <PAOldColor> \n\t"
    serverString = serverString .. "\236\157\180\235\143\153 \236\134\141\235\143\132 \236\181\156\236\162\133 \236\166\157\234\176\128\236\156\168(" .. makePercentString(stat:getSpeedRateResult(0), oldStat:getSpeedRateResult(0)) .. [[
) 
	]]
    serverString = serverString .. "\234\179\181\234\178\169 \236\134\141\235\143\132 \236\181\156\236\162\133 \236\166\157\234\176\128\236\156\168(" .. makePercentString(stat:getSpeedRateResult(1), oldStat:getSpeedRateResult(1)) .. [[
) 
	]]
    serverString = serverString .. "\236\186\144\236\138\164\237\140\133 \236\134\141\235\143\132 \236\181\156\236\162\133 \236\166\157\234\176\128\236\156\168(" .. makePercentString(stat:getSpeedRateResult(2), oldStat:getSpeedRateResult(2)) .. [[
) 

	]]
  elseif statType == self._STAT_TYPE._ACQUIRE then
    serverString = serverString .. "<PAColor0xffa78e6a> - \235\130\180 \236\160\149\235\179\180 \236\158\160\236\158\172\235\160\165\236\151\144 \236\158\136\235\138\148 \236\166\157\234\176\128\236\156\168 - <PAOldColor> \n\t"
    serverString = serverString .. "\236\160\132\237\136\172 \234\178\189\237\151\152\236\185\152 \236\166\157\234\176\128\236\156\168 = \236\186\144\235\166\173\237\132\176(" .. makePercentStringNotDivide(stat._addExperienceRate, oldStat._addExperienceRate) .. ") + \237\142\171( " .. makePercentStringNotDivide(stat._addExperienceRateByPet, oldStat._addExperienceRateByPet) .. [[
) 
	]]
    serverString = serverString .. "\234\184\176\236\136\160 \234\178\189\237\151\152\236\185\152 \236\166\157\234\176\128\236\156\168 = \236\186\144\235\166\173\237\132\176(" .. makePercentStringNotDivide(stat._addBattleExperienceRate, oldStat._addBattleExperienceRate) .. ") + \237\142\171( " .. makePercentStringNotDivide(stat._addBattleExperienceRateByPet, oldStat._addBattleExperienceRateByPet) .. [[
) 
	]]
    serverString = serverString .. "\236\132\177\237\150\165 \236\166\157\234\176\128\236\156\168 = \236\186\144\235\166\173\237\132\176(" .. makePercentStringNotDivide(stat._addTendencyExperienceRate, oldStat._addTendencyExperienceRate) .. ") + \237\142\171( " .. makePercentStringNotDivide(stat._addTendencyExperienceRateByPet, oldStat._addTendencyExperienceRateByPet) .. [[
) 
	]]
    serverString = serverString .. "\237\140\140\237\139\176 \234\178\189\237\151\152\236\185\152 \236\166\157\234\176\128\236\156\168(" .. makePercentStringNotDivide(stat._addPartyExperienceRate, oldStat._addPartyExperienceRate) .. [[
) 
	]]
    serverString = serverString .. "\236\177\132\236\167\145 \234\178\189\237\151\152\236\185\152 \236\166\157\234\176\128\236\156\168 = \236\186\144\235\166\173\237\132\176(" .. makePercentStringNotDivide(stat:getAddLifeExperienceRate(0), oldStat:getAddLifeExperienceRate(0)) .. ") + \237\142\171( " .. makePercentStringNotDivide(stat:getAddLifeExperienceRateByPet(0), oldStat:getAddLifeExperienceRateByPet(0)) .. [[
) 
	]]
    serverString = serverString .. "\235\130\154\236\139\156 \234\178\189\237\151\152\236\185\152 \236\166\157\234\176\128\236\156\168 = \236\186\144\235\166\173\237\132\176(" .. makePercentStringNotDivide(stat:getAddLifeExperienceRate(1), oldStat:getAddLifeExperienceRate(1)) .. ") + \237\142\171( " .. makePercentStringNotDivide(stat:getAddLifeExperienceRateByPet(1), oldStat:getAddLifeExperienceRateByPet(1)) .. [[
) 
	]]
    serverString = serverString .. "\236\136\152\235\160\181 \234\178\189\237\151\152\236\185\152 \236\166\157\234\176\128\236\156\168 = \236\186\144\235\166\173\237\132\176(" .. makePercentStringNotDivide(stat:getAddLifeExperienceRate(2), oldStat:getAddLifeExperienceRate(2)) .. ") + \237\142\171( " .. makePercentStringNotDivide(stat:getAddLifeExperienceRateByPet(2), oldStat:getAddLifeExperienceRateByPet(2)) .. [[
) 
	]]
    serverString = serverString .. "\236\154\148\235\166\172 \234\178\189\237\151\152\236\185\152 \236\166\157\234\176\128\236\156\168 = \236\186\144\235\166\173\237\132\176(" .. makePercentStringNotDivide(stat:getAddLifeExperienceRate(3), oldStat:getAddLifeExperienceRate(3)) .. ") + \237\142\171( " .. makePercentStringNotDivide(stat:getAddLifeExperienceRateByPet(3), oldStat:getAddLifeExperienceRateByPet(3)) .. [[
) 
	]]
    serverString = serverString .. "\236\151\176\234\184\136 \234\178\189\237\151\152\236\185\152 \236\166\157\234\176\128\236\156\168 = \236\186\144\235\166\173\237\132\176(" .. makePercentStringNotDivide(stat:getAddLifeExperienceRate(4), oldStat:getAddLifeExperienceRate(4)) .. ") + \237\142\171( " .. makePercentStringNotDivide(stat:getAddLifeExperienceRateByPet(4), oldStat:getAddLifeExperienceRateByPet(4)) .. [[
) 
	]]
    serverString = serverString .. "\234\176\128\234\179\181 \234\178\189\237\151\152\236\185\152 \236\166\157\234\176\128\236\156\168 = \236\186\144\235\166\173\237\132\176(" .. makePercentStringNotDivide(stat:getAddLifeExperienceRate(5), oldStat:getAddLifeExperienceRate(5)) .. ") + \237\142\171( " .. makePercentStringNotDivide(stat:getAddLifeExperienceRateByPet(5), oldStat:getAddLifeExperienceRateByPet(5)) .. [[
) 
	]]
    serverString = serverString .. "\236\161\176\235\160\168 \234\178\189\237\151\152\236\185\152 \236\166\157\234\176\128\236\156\168 = \236\186\144\235\166\173\237\132\176(" .. makePercentStringNotDivide(stat:getAddLifeExperienceRate(6), oldStat:getAddLifeExperienceRate(6)) .. ") + \237\142\171( " .. makePercentStringNotDivide(stat:getAddLifeExperienceRateByPet(6), oldStat:getAddLifeExperienceRateByPet(6)) .. [[
) 
	]]
    serverString = serverString .. "\235\172\180\236\151\173 \234\178\189\237\151\152\236\185\152 \236\166\157\234\176\128\236\156\168 = \236\186\144\235\166\173\237\132\176(" .. makePercentStringNotDivide(stat:getAddLifeExperienceRate(7), oldStat:getAddLifeExperienceRate(7)) .. ") + \237\142\171( " .. makePercentStringNotDivide(stat:getAddLifeExperienceRateByPet(7), oldStat:getAddLifeExperienceRateByPet(7)) .. [[
) 
	]]
    serverString = serverString .. "\236\158\172\235\176\176 \234\178\189\237\151\152\236\185\152 \236\166\157\234\176\128\236\156\168 = \236\186\144\235\166\173\237\132\176(" .. makePercentStringNotDivide(stat:getAddLifeExperienceRate(8), oldStat:getAddLifeExperienceRate(8)) .. ") + \237\142\171( " .. makePercentStringNotDivide(stat:getAddLifeExperienceRateByPet(8), oldStat:getAddLifeExperienceRateByPet(8)) .. [[
) 
	]]
    serverString = serverString .. "\237\149\173\237\149\180 \234\178\189\237\151\152\236\185\152 \236\166\157\234\176\128\236\156\168 = \236\186\144\235\166\173\237\132\176(" .. makePercentStringNotDivide(stat:getAddLifeExperienceRate(9), oldStat:getAddLifeExperienceRate(9)) .. ") + \237\142\171( " .. makePercentStringNotDivide(stat:getAddLifeExperienceRateByPet(9), oldStat:getAddLifeExperienceRateByPet(9)) .. [[
) 
	]]
    serverString = serverString .. "\237\128\152\236\138\164\237\138\184\235\182\129 \234\178\189\237\151\152\236\185\152 \236\166\157\234\176\128\236\156\168 = \236\186\144\235\166\173\237\132\176(" .. makePercentStringNotDivide(stat:getAddLifeExperienceRate(10), oldStat:getAddLifeExperienceRate(10)) .. ") + \237\142\171( " .. makePercentStringNotDivide(stat:getAddLifeExperienceRateByPet(10), oldStat:getAddLifeExperienceRateByPet(10)) .. [[
) 
	]]
    serverString = serverString .. "\235\172\188\234\181\144 \234\178\189\237\151\152\236\185\152 \236\166\157\234\176\128\236\156\168 = \236\186\144\235\166\173\237\132\176(" .. makePercentStringNotDivide(stat:getAddLifeExperienceRate(11), oldStat:getAddLifeExperienceRate(11)) .. ") + \237\142\171( " .. makePercentStringNotDivide(stat:getAddLifeExperienceRateByPet(11), oldStat:getAddLifeExperienceRateByPet(11)) .. [[
) 

	]]
    serverString = serverString .. "<PAColor0xffa78e6a> - \236\149\132\236\157\180\237\133\156 \237\153\149\235\165\160 \236\166\157\234\176\128 - <PAOldColor> \n\t"
    serverString = serverString .. "\234\184\176\235\179\184 \236\149\132\236\157\180\237\133\156 \237\153\149\235\165\160(Normal) = (" .. makePercentString(stat:getAddItemDropRate(0), oldStat:getAddItemDropRate(0)) .. [[
) 
	]]
    serverString = serverString .. "\234\184\176\235\179\184 \236\149\132\236\157\180\237\133\156 \237\153\149\235\165\160(Special) = (" .. makePercentString(stat:getAddItemDropRate(1), oldStat:getAddItemDropRate(1)) .. [[
) 
	]]
    serverString = serverString .. "\236\149\132\236\157\180\237\133\156 \237\154\141\235\147\157 \236\166\157\234\176\128 \236\163\188\235\172\184\236\132\156 \237\153\149\235\165\160 = (" .. makePercentString(stat._itemDropRate, oldStat._itemDropRate) .. [[
) 
	]]
    serverString = serverString .. "\236\149\132\236\157\180\237\133\156 \237\154\141\235\147\157 \236\166\157\234\176\128 \236\163\188\235\172\184\236\132\156 \236\158\161\237\133\156 \236\166\157\234\176\128\235\159\137 = (" .. makePercentString(stat._itemCountRate, oldStat._itemCountRate) .. [[
) 
	]]
  end
  self._ui._txt_Server:SetText(serverString)
  self._ui._txt_Client:SetText(clientString)
  return true
end
function HandleEventLUp_ReloadDebugStatInfo()
  ToClient_ReloadDebugStatInfo()
end
function HandleEventLUp_ShowDiff()
  PaGlobal_Window_CharacterStat_All._showDiff = not PaGlobal_Window_CharacterStat_All._showDiff
  PaGlobal_Window_CharacterStat_All:prepareOpen()
end
function PaGlobal_Window_CharacterStat_All_Open()
  if Panel_Window_CharacterStat_All == nil then
    return
  end
  PaGlobal_Window_CharacterStat_All:prepareOpen()
end
function PaGlobal_Window_CharacterStat_All_Close()
  if Panel_Window_CharacterStat_All == nil then
    return
  end
  PaGlobal_Window_CharacterStat_All:prepareClose()
end
function PaGlobal_Window_CharacterStat_All_ToggleList()
  PaGlobal_Window_CharacterStat_All._ui._combo_Stat:ToggleListbox()
end
function FromClient_ResponseShowPlayerStat()
  if PaGlobal_Window_CharacterStat_All == nil then
    return
  end
  PaGlobal_Window_CharacterStat_All:prepareOpen()
end
function HandleEventLUp_ChracterStat_Select()
  local index = PaGlobal_Window_CharacterStat_All._ui._combo_Stat:GetSelectIndex()
  PaGlobal_Window_CharacterStat_All._currentStatType = index
  PaGlobal_Window_CharacterStat_All:update(index)
end
function makeStatString(stat, oldStat)
  if stat == oldStat then
    return tostring(stat)
  elseif PaGlobal_Window_CharacterStat_All._showDiff == true then
    if oldStat < stat then
      return "<PAColor0xFF39A07D>" .. tostring(stat) .. "<PAOldColor>" .. "(" .. tostring(oldStat) .. "->" .. tostring(stat) .. ")"
    else
      return "<PAColor0xFFB82929>" .. tostring(stat) .. "<PAOldColor>" .. "(" .. tostring(oldStat) .. "->" .. tostring(stat) .. ")"
    end
  elseif oldStat < stat then
    return "<PAColor0xFF39A07D>" .. tostring(stat) .. "<PAOldColor>"
  else
    return "<PAColor0xFFB82929>" .. tostring(stat) .. "<PAOldColor>"
  end
end
function makePercentString(percent, oldPercent)
  if percent == oldPercent then
    return tostring(percent / 10000) .. "%"
  elseif PaGlobal_Window_CharacterStat_All._showDiff == true then
    if oldPercent < percent then
      return "<PAColor0xFF39A07D>" .. tostring(percent / 10000) .. "% <PAOldColor>" .. "(" .. tostring(oldPercent / 10000) .. "% ->" .. tostring(percent / 10000) .. "%)"
    else
      return "<PAColor0xFFB82929>" .. tostring(percent / 10000) .. "% <PAOldColor>" .. "(" .. tostring(oldPercent / 10000) .. "% ->" .. tostring(percent / 10000) .. "%)"
    end
  elseif oldPercent < percent then
    return "<PAColor0xFF39A07D> " .. tostring(percent / 10000) .. "% <PAOldColor>"
  else
    return "<PAColor0xFFB82929> " .. tostring(percent / 10000) .. "% <PAOldColor>"
  end
end
function makePercentStringNotDivide(percent, oldPercent)
  if percent == oldPercent then
    return tostring(percent) .. "%"
  elseif PaGlobal_Window_CharacterStat_All._showDiff == true then
    if oldPercent < percent then
      return "<PAColor0xFF39A07D>" .. tostring(percent) .. "% <PAOldColor>" .. "(" .. tostring(oldPercent) .. "% ->" .. tostring(percent) .. "%)"
    else
      return "<PAColor0xFFB82929>" .. tostring(percent) .. "% <PAOldColor>" .. "(" .. tostring(oldPercent) .. "% ->" .. tostring(percent) .. "%)"
    end
  elseif oldPercent < percent then
    return "<PAColor0xFF39A07D> " .. tostring(percent) .. "% <PAOldColor>"
  else
    return "<PAColor0xFFB82929> " .. tostring(percent) .. "% <PAOldColor>"
  end
end
function PaGlobal_Window_CharacterStat_All:validate()
  if Panel_Window_CharacterStat_All == nil then
    return
  end
  self._ui._stc_TitleArea:isValidate()
  self._ui._btn_Close:isValidate()
  self._ui._combo_Stat:isValidate()
  self._ui._btn_Reload:isValidate()
  self._ui._stc_ServerBG:isValidate()
  self._ui._txt_Server:isValidate()
  self._ui._stc_ClientBG:isValidate()
  self._ui._txt_Client:isValidate()
end
function PaGlobal_Window_CharacterStat_All:updateReboot(statType)
  if Panel_Window_CharacterStat_All == nil then
    return
  end
  local offenceStat = ToClient_getCharacterAttackOffenceStat()
  local defenceStat = ToClient_getCharacterAttackDefenceStat()
  if offenceStat == nil or defenceStat == nil then
    return
  end
  local mainAttackType = ToClient_getMainAttackType()
  local serverString = ""
  local clientString = ""
  if statType == self._STAT_TYPE._OFFENCE then
    serverString = serverString .. "<PAColor0xffa78e6a> - \234\179\181\234\178\169\235\160\165 - <PAOldColor> \n\t"
    serverString = serverString .. "\236\186\144\235\166\173\237\132\176 \234\179\181\234\178\169\235\160\165 Min(<PAColor0xFF39A07D>" .. offenceStat:getCharacterDDMin() .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\186\144\235\166\173\237\132\176 \234\179\181\234\178\169\235\160\165 Max(<PAColor0xFF39A07D>" .. offenceStat:getCharacterDDMax() .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\186\144\235\166\173\237\132\176 \234\179\181\234\178\169\235\160\165 Added(<PAColor0xFF39A07D>" .. offenceStat:getCharacterAddedDD() .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "Player \234\176\128\235\172\184 \234\179\181\234\178\169\235\160\165(<PAColor0xFF39A07D>" .. offenceStat:getPlayerUserAddedOffenceAll() .. "<PAOldColor>) [\234\176\128\235\172\184 \236\157\188\236\167\128, OTP, \237\150\137\235\179\181\237\149\156 \237\157\145\236\160\149])\n\t"
    serverString = serverString .. "Player \236\186\144\235\166\173\237\132\176 \234\179\181\234\178\169\235\160\165(<PAColor0xFF39A07D>" .. offenceStat:getPlayerCharacterAddedOffenceAll() .. "<PAOldColor>) [\235\160\136\235\178\168,\235\179\184 \236\136\152\236\160\149])\n\t"
    local weaponDD = "<PAColor0xFF39A07D>" .. offenceStat:getEquipAverageDD(mainAttackType, __eAttackOffenceEquipType_Normal) .. "<PAOldColor>"
    local weaponDD2 = "<PAColor0xFF39A07D>" .. offenceStat:getEquipAverageDD(mainAttackType, __eAttackOffenceEquipType_Awaken) .. "<PAOldColor>"
    local weaponDD3 = "<PAColor0xFF39A07D>" .. offenceStat:getEquipAverageDD(mainAttackType, __eAttackOffenceEquipType_Sub) .. "<PAOldColor>"
    serverString = serverString .. "\236\158\165\235\185\132 \235\172\180\234\184\176 \234\179\181\234\178\169\235\160\165 \236\163\188\235\172\180\234\184\176(" .. weaponDD .. ") \234\176\129\236\132\177\235\172\180\234\184\176(" .. weaponDD2 .. ") \235\179\180\236\161\176\235\172\180\234\184\176(" .. weaponDD3 .. [[
)
	]]
    serverString = serverString .. "\236\158\165\235\185\132 \234\184\176\237\131\128 \234\179\181\234\178\169\235\160\165(<PAColor0xFF39A07D>" .. offenceStat:getEquipAverageDD(mainAttackType, __eAttackOffenceEquipType_Other) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\158\165\235\185\132 \236\185\180\237\148\132\235\157\188\236\138\164 \234\179\181\234\178\169\235\160\165(<PAColor0xFF39A07D>" .. offenceStat:getEquipCaphrasDD(mainAttackType) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\162\133\236\161\177 \236\182\148\234\176\128 \234\179\181\234\178\169\235\160\165<\236\157\184\234\176\132>(<PAColor0xFF39A07D>" .. offenceStat:getTribeDD(__eNewTribeType_NonHuman) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\162\133\236\161\177 \236\182\148\234\176\128 \234\179\181\234\178\169\235\160\165<\236\149\132\236\157\184>(<PAColor0xFF39A07D>" .. offenceStat:getTribeDD(__eNewTribeType_NonHuman) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\162\133\236\161\177 \236\182\148\234\176\128 \234\179\181\234\178\169\235\160\165<\234\184\176\237\131\128>(<PAColor0xFF39A07D>" .. offenceStat:getTribeDD(__eNewTribeType_Others) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\162\133\236\161\177 \236\182\148\234\176\128 \234\179\181\234\178\169\235\160\165<\236\185\180\235\167\136>(<PAColor0xFF39A07D>" .. offenceStat:getTribeDD(__eNewTribeType_Kamasilvia) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\162\133\236\161\177 \236\182\148\234\176\128 \234\179\181\234\178\169\235\160\165<\235\167\136\236\161\177>(<PAColor0xFF39A07D>" .. offenceStat:getTribeDD(__eNewTribeType_Edania) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\162\133\236\161\177 \236\182\148\234\176\128 \234\179\181\234\178\169\235\160\165<\236\136\152\235\160\181>(<PAColor0xFF39A07D>" .. offenceStat:getTribeDD(__eNewTribeType_HuntCreature) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\162\133\236\161\177 \236\182\148\234\176\128 \234\179\181\234\178\169\235\160\165<\234\179\181\236\132\177>(<PAColor0xFF39A07D>" .. offenceStat:getTribeDD(__eNewTribeType_SiegeObject) .. [[
<PAOldColor>)
	]]
    local currentSkillType = ToClient_GetCurrentPlayerSkillType()
    local dpOffence = ToClient_getAttackDisplayOffence(currentSkillType, true)
    serverString = serverString .. "\235\130\180 \236\138\164\237\130\172\237\131\128\236\158\133\236\151\144 \235\148\176\235\165\184 \237\145\156\234\184\176\234\179\181(<PAColor0xFF39A07D>" .. dpOffence .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\160\129\236\154\169\235\144\152\235\138\148 \235\179\180\235\132\136\236\138\164 \234\179\181\234\178\169\235\160\165(<PAColor0xFF39A07D>" .. ToClient_getRebootBonusDDFromStat(dpOffence) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\160\129\236\154\169\235\144\152\235\138\148 \235\179\180\235\132\136\236\138\164 \235\170\172\236\138\164\237\132\176 \234\179\181\234\178\169\235\160\165(<PAColor0xFF39A07D>" .. ToClient_getRebootBonusMonDDFromStat(dpOffence) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\235\170\172\236\138\164\237\132\176 \236\182\148\234\176\128 \234\179\181\234\178\169\235\160\165(\235\179\180\235\132\136\236\138\164\235\175\184\237\143\172\237\149\168)(<PAColor0xFF39A07D>" .. offenceStat:getAddedMonsterDD() .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\235\170\168\237\151\152\234\176\128 \236\182\148\234\176\128 \234\179\181\234\178\169\235\160\165(<PAColor0xFF39A07D>" .. offenceStat:getAddedPlayerDD() .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "<PAColor0xffa78e6a>--- \235\178\132\237\148\132 \236\182\148\234\176\128 \234\179\181\234\178\169\235\160\165 --- <PAOldColor> \n\t"
    for index = 0, __eAttackBuffSourceType_Count - 1 do
      serverString = serverString .. "\235\178\132\237\148\132 \236\182\148\234\176\128 \234\179\181\234\178\169\235\160\165 \235\178\132\237\148\132\236\134\140\236\138\164\237\131\128\236\158\133:(" .. index .. self._ATT_BUFF_SOURCETYPE[index] .. ") : (<PAColor0xFF39A07D>" .. offenceStat:getBuffDD(mainAttackType, index) .. [[
<PAOldColor>)
	]]
    end
  elseif statType == self._STAT_TYPE._HIT then
    serverString = serverString .. "<PAColor0xffa78e6a> - \236\160\129\236\164\145\235\160\165 - <PAOldColor> \n\t"
    serverString = serverString .. "\236\186\144\235\166\173\237\132\176 \234\184\176\235\179\184 \236\160\129\236\164\145\235\160\165 (<PAColor0xFF39A07D>" .. offenceStat:getCharacteHit(mainAttackType) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "Player \234\176\128\235\172\184 \236\160\129\236\164\145\235\160\165(<PAColor0xFF39A07D>" .. offenceStat:getPlayerUserAddedHitAll() .. "<PAOldColor>) [\234\176\128\235\172\184 \236\157\188\236\167\128, OTP, \237\150\137\235\179\181\237\149\156 \237\157\145\236\160\149]\n\t"
    serverString = serverString .. "Player \236\186\144\235\166\173\237\132\176 \236\160\129\236\164\145\235\160\165(<PAColor0xFF39A07D>" .. offenceStat:getPlayerCharacterAddedHitAll() .. "<PAOldColor>)  [\235\160\136\235\178\168,\235\179\184 \236\136\152\236\160\149]\n\t"
    serverString = serverString .. "\236\158\165\235\185\132 \236\160\129\236\164\145\235\160\165(<PAColor0xFF39A07D>" .. offenceStat:getEquipHit(mainAttackType) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "<PAColor0xffa78e6a>--- \235\178\132\237\148\132 \236\182\148\234\176\128 \236\160\129\236\164\145\235\160\165 --- <PAOldColor> \n\t"
    for index = 0, __eAttackBuffSourceType_Count - 1 do
      serverString = serverString .. "\235\178\132\237\148\132 \236\182\148\234\176\128 \236\160\129\236\164\145\235\160\165 \235\178\132\237\148\132\236\134\140\236\138\164\237\131\128\236\158\133:(" .. index .. self._ATT_BUFF_SOURCETYPE[index] .. ") :(<PAColor0xFF39A07D>" .. offenceStat:getBuffHit(mainAttackType, index) .. [[
<PAOldColor>)
	]]
    end
  elseif statType == self._STAT_TYPE._PV then
    local dpDefence = ToClient_getAttackDisplayDefence(currentSkillType, true)
    serverString = serverString .. "<PAColor0xffa78e6a> - \237\148\188\237\149\180\234\176\144\236\134\140 - <PAOldColor> \n\t"
    serverString = serverString .. "\236\186\144\235\166\173\237\132\176 \234\184\176\235\179\184 PV (<PAColor0xFF39A07D>" .. defenceStat:getCharacterPV(mainAttackType) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\186\144\235\166\173\237\132\176 \234\184\176\235\179\184 HPV(<PAColor0xFF39A07D>" .. defenceStat:getCharacterHPV(mainAttackType) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "Player \234\176\128\235\172\184 \237\148\188\237\149\180\234\176\144\236\134\140(<PAColor0xFF39A07D>" .. defenceStat:getPlayerUserAddedPVAll() .. "<PAOldColor>) [\234\176\128\235\172\184 \236\157\188\236\167\128, OTP, \237\150\137\235\179\181\237\149\156 \237\157\145\236\160\149]\n\t"
    serverString = serverString .. "Player \236\186\144\235\166\173\237\132\176 \237\148\188\237\149\180\234\176\144\236\134\140(<PAColor0xFF39A07D>" .. defenceStat:getPlayerCharacterAddedPVAll() .. "<PAOldColor>) [\235\160\136\235\178\168,\235\179\184 \236\136\152\236\160\149]\n\t"
    serverString = serverString .. "\236\158\165\235\185\132 PV(<PAColor0xFF39A07D>" .. defenceStat:getEquipPV(mainAttackType) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\158\165\235\185\132 HPV(<PAColor0xFF39A07D>" .. defenceStat:getEquipHPV(mainAttackType) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\235\140\128 \235\170\172\236\138\164\237\132\176 \236\182\148\234\176\128 \237\148\188\237\149\180\234\176\144\236\134\140(<PAColor0xFF39A07D>" .. defenceStat:getMonsterPv() .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\235\140\128 \235\170\168\237\151\152\234\176\128 \236\182\148\234\176\128 \237\148\188\237\149\180\234\176\144\236\134\140(<PAColor0xFF39A07D>" .. defenceStat:getPlayerPv() .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\235\179\180\235\132\136\236\138\164 \237\148\188\237\149\180\234\176\144\236\134\140(<PAColor0xFF39A07D>" .. ToClient_getRebootBonusPVFromStat(dpDefence) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\235\179\180\235\132\136\236\138\164 \235\140\128 \235\170\172\236\138\164\237\132\176 \237\148\188\237\149\180\234\176\144\236\134\140(<PAColor0xFF39A07D>" .. ToClient_getRebootBonusMonPVFromStat(dpDefence) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "--- \235\178\132\237\148\132 \236\182\148\234\176\128 \237\148\188\237\149\180\234\176\144\236\134\140 --- \n\t"
    for index = 0, __eAttackBuffSourceType_Count - 1 do
      serverString = serverString .. "\235\178\132\237\148\132 \236\182\148\234\176\128 \237\148\188\237\149\180\234\176\144\236\134\140 \235\178\132\237\148\132\236\134\140\236\138\164\237\131\128\236\158\133:(" .. index .. self._ATT_BUFF_SOURCETYPE[index] .. ") : (<PAColor0xFF39A07D>" .. defenceStat:getBuffPV(mainAttackType, index) .. [[
<PAOldColor>)
	]]
    end
    serverString = serverString .. "\237\148\188\237\149\180\234\176\144\236\134\140 \236\138\164\236\188\128\236\157\188\234\176\146(<PAColor0xFF39A07D>" .. tostring(defenceStat:getPVScale() / CppDefine.e1Percent) .. "%" .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\n\t<PAColor0xffa78e6a> - \237\148\188\237\149\180\234\176\144\236\134\140\236\156\168- <PAOldColor> \n\t"
    serverString = serverString .. "\235\178\132\237\148\132 \236\182\148\234\176\128 \237\148\188\237\149\180\234\176\144\236\134\140\236\156\168 (<PAColor0xFF39A07D>" .. tostring(defenceStat:getDamageResistanceAll() / CppDefine.e1Percent) .. "%" .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\235\178\132\237\148\132 \236\182\148\234\176\128 PC\235\167\140 \236\160\129\236\154\169\235\144\152\235\138\148 \237\148\188\237\149\180\234\176\144\236\134\140\236\156\168 (<PAColor0xFF39A07D>" .. tostring(defenceStat:getDamageResistanceOnlyPCAll() / CppDefine.e1Percent) .. "%" .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\235\140\128 \235\170\172\236\138\164\237\132\176 \237\148\188\237\149\180\234\176\144\236\134\140\236\156\168 (<PAColor0xFF39A07D>" .. tostring(defenceStat:getDamageResistanceFromMonsterAll() / CppDefine.e1Percent) .. "%" .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\235\179\180\235\132\136\236\138\164 \237\148\188\237\149\180\234\176\144\236\134\140\236\156\168 (<PAColor0xFF39A07D>" .. tostring(ToClient_getRebootBonusDamageResistance(dpDefence) / CppDefine.e1Percent) .. "%" .. [[
<PAOldColor>)
	]]
  elseif statType == self._STAT_TYPE._DV then
    serverString = serverString .. "<PAColor0xffa78e6a> - \237\154\140\237\148\188\235\160\165 - <PAOldColor> \n\t"
    serverString = serverString .. "\236\186\144\235\166\173\237\132\176 \234\184\176\235\179\184 DV (<PAColor0xFF39A07D>" .. defenceStat:getCharacterDV(mainAttackType) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\186\144\235\166\173\237\132\176 \234\184\176\235\179\184 HDV(<PAColor0xFF39A07D>" .. defenceStat:getCharacterHDV(mainAttackType) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "Player \234\176\128\235\172\184 \237\154\140\237\148\188\235\160\165(<PAColor0xFF39A07D>" .. defenceStat:getPlayerUserAddedDVAll() .. "<PAOldColor>)  [\234\176\128\235\172\184 \236\157\188\236\167\128, OTP, \237\150\137\235\179\181\237\149\156 \237\157\145\236\160\149]\n\t"
    serverString = serverString .. "Player \236\186\144\235\166\173\237\132\176 \237\154\140\237\148\188\235\160\165(<PAColor0xFF39A07D>" .. defenceStat:getPlayerCharacterAddedDVAll() .. "<PAOldColor>)  [\235\160\136\235\178\168,\235\179\184 \236\136\152\236\160\149]\n\t"
    serverString = serverString .. "\236\158\165\235\185\132 DV(<PAColor0xFF39A07D>" .. defenceStat:getEquipDV(mainAttackType) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\158\165\235\185\132 HDV(<PAColor0xFF39A07D>" .. defenceStat:getEquipHDV(mainAttackType) .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "<PAColor0xffa78e6a>--- \235\178\132\237\148\132 \236\182\148\234\176\128 \237\154\140\237\148\188\235\160\165 --- <PAOldColor> \n\t"
    for index = 0, __eAttackBuffSourceType_Count - 1 do
      serverString = serverString .. "\235\178\132\237\148\132 \236\182\148\234\176\128 \237\154\140\237\148\188\235\160\165 \235\178\132\237\148\132\236\134\140\236\138\164\237\131\128\236\158\133:(" .. index .. self._ATT_BUFF_SOURCETYPE[index] .. ") : (<PAColor0xFF39A07D>" .. defenceStat:getBuffDV(mainAttackType, index) .. [[
<PAOldColor>)
	]]
    end
  elseif statType == self._STAT_TYPE._SPECIALATTACK then
    serverString = serverString .. "<PAColor0xffa78e6a> - \237\129\172\235\166\172, \237\138\185\236\136\152\237\148\188\237\149\180 - <PAOldColor> \n\t"
    serverString = serverString .. "\237\129\172\235\166\172\237\139\176\236\187\172 \237\153\149\235\165\160(<PAColor0xFF39A07D>" .. tostring(offenceStat:getCriticalAddPercentRate() / CppDefine.e1Percent) .. "%" .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\237\129\172\235\166\172\237\139\176\236\187\172 \236\182\148\234\176\128\235\142\128 \236\166\157\234\176\128\236\156\168(<PAColor0xFF39A07D>" .. tostring(offenceStat:getCriticalAddDamageRate() / CppDefine.e1Percent) .. "%" .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\235\176\177\236\150\180\237\131\157 \236\182\148\234\176\128\235\142\128 \236\166\157\234\176\128\236\156\168(<PAColor0xFF39A07D>" .. tostring(offenceStat:getAdditionalDamageRate(__eAdditionalDamageType_Back) / CppDefine.e1Percent) .. "%" .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\235\139\164\236\154\180\236\150\180\237\131\157 \236\182\148\234\176\128\235\142\128 \236\166\157\234\176\128\236\156\168(<PAColor0xFF39A07D>" .. tostring(offenceStat:getAdditionalDamageRate(__eAdditionalDamageType_Down) / CppDefine.e1Percent) .. "%" .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\151\144\236\150\180\236\150\180\237\131\157 \236\182\148\234\176\128\235\142\128 \236\166\157\234\176\128\236\156\168(<PAColor0xFF39A07D>" .. tostring(offenceStat:getAdditionalDamageRate(__eAdditionalDamageType_Air) / CppDefine.e1Percent) .. "%" .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\138\164\237\148\188\235\147\156\236\150\180\237\131\157 \236\182\148\234\176\128\235\142\128 \236\166\157\234\176\128\236\156\168(<PAColor0xFF39A07D>" .. tostring(offenceStat:getAdditionalDamageRate(__eAdditionalDamageType_Speed) / CppDefine.e1Percent) .. "%" .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\185\180\236\154\180\237\132\176\236\150\180\237\131\157 \236\182\148\234\176\128\235\142\128\236\166\157\234\176\128\236\156\168(<PAColor0xFF39A07D>" .. tostring(offenceStat:getAdditionalDamageRate(__eAdditionalDamageType_Counter) / CppDefine.e1Percent) .. "%" .. [[
<PAOldColor>)
	]]
  elseif statType == self._STAT_TYPE._RESISTANCE then
    serverString = serverString .. "\234\184\176\236\160\136/\234\178\189\236\167\129/\235\185\153\234\178\176 \236\160\128\237\149\173\235\165\160(<PAColor0xFF39A07D>" .. tostring(defenceStat:getActionRestrictResistance(__eActionRestrictStatType_Stun) / CppDefine.e1Percent) .. "%" .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\236\158\161\234\184\176 \236\160\128\237\149\173\235\165\160(<PAColor0xFF39A07D>" .. tostring(defenceStat:getActionRestrictResistance(__eActionRestrictStatType_Catch) / CppDefine.e1Percent) .. "%" .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\235\132\137\235\139\164\236\154\180/\235\176\148\236\154\180\235\147\156 \236\160\128\237\149\173\235\165\160(<PAColor0xFF39A07D>" .. tostring(defenceStat:getActionRestrictResistance(__eActionRestrictStatType_Knockdown) / CppDefine.e1Percent) .. "%" .. [[
<PAOldColor>)
	]]
    serverString = serverString .. "\235\132\137\235\176\177/\235\157\132\236\154\176\234\184\176 \236\160\128\237\149\173\235\165\160(<PAColor0xFF39A07D>" .. tostring(defenceStat:getActionRestrictResistance(__eActionRestrictStatType_Knockback) / CppDefine.e1Percent) .. "%" .. [[
<PAOldColor>)
	]]
  end
  return serverString
end
