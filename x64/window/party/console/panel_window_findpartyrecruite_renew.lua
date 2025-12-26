local Panel_Window_FindPartyRecruite_info = {
  _ui = {
    static_CenterBg = nil,
    txt_type = nil,
    txt_area = nil,
    static_Level = nil,
    static_OffenceTitle = nil,
    static_DefenceTitle = nil,
    static_Offence = nil,
    static_Defence = nil,
    static_BottomBg = nil,
    staticText_Y_ConsoleUI = nil,
    staticText_A_ConsoleUI = nil,
    staticText_B_ConsoleUI = nil,
    list2_preset = nil
  },
  _value = {
    selectLevel = 1,
    selectOffence = 0,
    selectDefence = 0,
    currentCategory = 0,
    selectType = "",
    selectArea = ""
  },
  _config = {
    maxlevel = 60,
    maxOffence = 370,
    maxDefence = 440
  },
  _enum = {main = 0, sub = 1},
  _string = {
    defaultType = PAGetString(Defines.StringSheet_GAME, "LUA_FINDPARTYRECRUITE_SELECTTYPE"),
    defaultArea = PAGetString(Defines.StringSheet_GAME, "LUA_FINDPARTYRECRUITE_SELECTAREA")
  },
  _currentPresetStrings = {},
  _isGuildParty = false,
  _mainCategoryCount = 5,
  _subCategoryCount = 7
}
function Panel_Window_FindPartyRecruite_info:registEventHandler()
  self._ui.list2_preset:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_FindPartyRecruite_CreatePreset")
  self._ui.list2_preset:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.txt_type:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_FindPartyRecruite_ShowList(0)")
  self._ui.txt_area:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_FindPartyRecruite_ShowList(1)")
  self._ui.static_Level:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_FindPartyRecruite_ValueChange(" .. self._config.maxlevel .. ",0)")
  self._ui.static_Offence:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_FindPartyRecruite_ValueChange(" .. self._config.maxOffence .. ",1)")
  self._ui.static_Defence:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_FindPartyRecruite_ValueChange(" .. self._config.maxDefence .. ",2)")
  Panel_PartyRecruite:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_FindPartyRecruite_Confrim()")
end
function Panel_Window_FindPartyRecruite_info:registerMessageHandler()
  registerEvent("onScreenResize", "FromClient_FindPartyRecruite_Resize")
end
function Panel_Window_FindPartyRecruite_info:initialize()
  self:childControl()
  self:initValue()
  self:keyAlign()
  self:registerMessageHandler()
  self:registEventHandler()
end
function Panel_Window_FindPartyRecruite_info:initValue()
  self._value.selectLevel = 1
  self._value.selectOffence = 0
  self._value.selectDefence = 0
  self._value.selectType = ""
  self._value.selectArea = ""
  self._ui.txt_type:SetText(self._string.defaultType)
  self._ui.txt_area:SetText(self._string.defaultArea)
end
function Panel_Window_FindPartyRecruite_info:keyAlign()
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuide, self._ui.static_BottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function Panel_Window_FindPartyRecruite_info:childControl()
  self._ui.static_CenterBg = UI.getChildControl(Panel_PartyRecruite, "Static_CenterBg")
  self._ui.txt_type = UI.getChildControl(self._ui.static_CenterBg, "StaticText_TypeValue")
  self._ui.txt_area = UI.getChildControl(self._ui.static_CenterBg, "StaticText_AreaValue")
  self._ui.static_Level = UI.getChildControl(self._ui.static_CenterBg, "StaticText_LevelValue")
  self._ui.static_OffenceTitle = UI.getChildControl(self._ui.static_CenterBg, "StaticText_OffenceTitle")
  self._ui.static_DefenceTitle = UI.getChildControl(self._ui.static_CenterBg, "StaticText_DefenceTitle")
  self._ui.static_Offence = UI.getChildControl(self._ui.static_CenterBg, "StaticText_OffenceValue")
  self._ui.static_Defence = UI.getChildControl(self._ui.static_CenterBg, "StaticText_DefenceValue")
  self._ui.static_BottomBg = UI.getChildControl(Panel_PartyRecruite, "Static_BottomBg")
  self._ui.staticText_Y_ConsoleUI = UI.getChildControl(self._ui.static_BottomBg, "StaticText_Y_ConsoleUI")
  self._ui.staticText_A_ConsoleUI = UI.getChildControl(self._ui.static_BottomBg, "StaticText_A_ConsoleUI")
  self._ui.staticText_B_ConsoleUI = UI.getChildControl(self._ui.static_BottomBg, "StaticText_B_ConsoleUI")
  self._keyGuide = {
    self._ui.staticText_Y_ConsoleUI,
    self._ui.staticText_A_ConsoleUI,
    self._ui.staticText_B_ConsoleUI
  }
  self._ui.list2_preset = UI.getChildControl(Panel_PartyRecruite, "List2_Preset")
  self._ui.list2_preset:SetShow(false)
  self._ui.static_OffenceTitle:SetShow(_ContentsGroup_PartyMatching_Limit_OtherServerInvite)
  self._ui.static_DefenceTitle:SetShow(_ContentsGroup_PartyMatching_Limit_OtherServerInvite)
  self._ui.static_Offence:SetShow(_ContentsGroup_PartyMatching_Limit_OtherServerInvite)
  self._ui.static_Defence:SetShow(_ContentsGroup_PartyMatching_Limit_OtherServerInvite)
end
function Panel_Window_FindPartyRecruite_info:setBaseLevel()
  self._ui.static_Level:SetText(tostring(self._value.selectLevel))
end
function Panel_Window_FindPartyRecruite_info:setBaseOffence()
  self._ui.static_Offence:SetText(tostring(self._value.selectOffence))
end
function Panel_Window_FindPartyRecruite_info:setBaseDefence()
  self._ui.static_Defence:SetText(tostring(self._value.selectDefence))
end
function Panel_Window_FindPartyRecruite_info:open(isGuildParty)
  self._isGuildParty = isGuildParty
  Panel_PartyRecruite:SetShow(true)
end
function Panel_Window_FindPartyRecruite_info:close()
  if Panel_PartyRecruite:GetShow() then
    _AudioPostEvent_SystemUiForXBOX(50, 3)
  end
  if true == self._ui.list2_preset:GetShow() then
    self:closeList()
    return
  end
  Panel_PartyRecruite:SetShow(false)
end
function Panel_Window_FindPartyRecruite_info:closeList()
  self._ui.list2_preset:SetShow(false)
end
function PaGlobalFunc_FindPartyRecruite_GetShow()
  return Panel_PartyRecruite:GetShow()
end
function PaGlobalFunc_FindPartyRecruite_Open(isGuildParty)
  local self = Panel_Window_FindPartyRecruite_info
  self:open(isGuildParty)
end
function PaGlobalFunc_FindPartyRecruite_Close()
  local self = Panel_Window_FindPartyRecruite_info
  self:close()
end
function PaGlobalFunc_FindPartyRecruite_Show(isGuildParty)
  local self = Panel_Window_FindPartyRecruite_info
  self:initValue()
  self:setBaseLevel()
  self:setBaseOffence()
  self:setBaseDefence()
  self:keyAlign()
  self:open(isGuildParty)
end
function PaGlobalFunc_FindPartyRecruite_Exit()
  local self = Panel_Window_FindPartyRecruite_info
  self:close()
end
function PaGlobalFunc_FindPartyRecruite_ExitAll()
  local self = Panel_Window_FindPartyRecruite_info
  self:close()
end
function PaGlobalFunc_FindPartyRecruite_Confrim()
  local self = Panel_Window_FindPartyRecruite_info
  if "" == self._value.selectType then
    Proc_ShowMessage_Ack(self._string.defaultType)
    return
  elseif "" == self._value.selectArea then
    Proc_ShowMessage_Ack(self._string.defaultArea)
    return
  end
  local msg = self._value.selectType .. " " .. self._value.selectArea
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoingAlterOfBlood"))
    return
  end
  ToClient_RequestPartyRecruitment(msg, Int64toInt32(self._value.selectLevel), Int64toInt32(self._value.selectOffence), Int64toInt32(self._value.selectDefence), 5, CppEnums.PartyType.ePartyType_Normal, self._isGuildParty)
  self:close()
end
function PaGlobalFunc_FindPartyRecruite_CreatePreset(control, index64)
  local index = Int64toInt32(index64)
  local btn_Contents = UI.getChildControl(control, "Button_Contents")
  local txt_preset = UI.getChildControl(btn_Contents, "StaticText_Preset")
  txt_preset:SetTextMode(__eTextMode_AutoWrap)
  txt_preset:SetText(Panel_Window_FindPartyRecruite_info._currentPresetStrings[index])
  btn_Contents:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_FindPartyRecruite_SetPreset(" .. index .. ")")
end
function PaGlobalFunc_FindPartyRecruite_ShowList(category)
  local self = Panel_Window_FindPartyRecruite_info
  if true == self._ui.list2_preset:GetShow() then
    return
  end
  self._value.currentCategory = category
  ToClient_padSnapSetTargetGroup(self._ui.list2_preset)
  self._ui.list2_preset:getElementManager():clearKey()
  local count = 0
  self._currentPresetStrings = {}
  if self._enum.main == category then
    count = self._mainCategoryCount
    for i = 0, count - 1 do
      self._currentPresetStrings[i] = PAGetString(Defines.StringSheet_GAME, "LUA_CONSOLE_FINDPARTY_MAINCATEGORY_" .. i)
      self._ui.list2_preset:getElementManager():pushKey(toInt64(0, i))
    end
  else
    count = self._subCategoryCount
    for i = 0, count - 1 do
      self._currentPresetStrings[i] = PAGetString(Defines.StringSheet_GAME, "LUA_CONSOLE_FINDPARTY_SUBCATEGORY_" .. i)
      self._ui.list2_preset:getElementManager():pushKey(toInt64(0, i))
    end
  end
  Panel_PartyRecruite:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "PaGlobalFunc_FindPartyRecruite_EmptyFunction()")
  Panel_PartyRecruite:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "PaGlobalFunc_FindPartyRecruite_EmptyFunction()")
  self._ui.list2_preset:SetShow(true)
end
function PaGlobalFunc_FindPartyRecruite_EmptyFunction()
end
function PaGlobalFunc_FindPartyRecruite_SetPreset(index)
  local self = Panel_Window_FindPartyRecruite_info
  local selectString = self._currentPresetStrings[index]
  if self._enum.main == self._value.currentCategory then
    self._value.selectType = selectString
    self._ui.txt_type:SetText(selectString)
  else
    self._value.selectArea = selectString
    self._ui.txt_area:SetText(selectString)
  end
  Panel_PartyRecruite:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "")
  Panel_PartyRecruite:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "")
  self:closeList()
end
function PaGlobalFunc_FindPartyRecruite_ValueChange(maxValue, index)
  local max = toInt64(0, maxValue)
  local function setValue(inputNum)
    if index == 0 then
      Panel_Window_FindPartyRecruite_info._value.selectLevel = inputNum
      Panel_Window_FindPartyRecruite_info:setBaseLevel()
    elseif index == 1 then
      Panel_Window_FindPartyRecruite_info._value.selectOffence = inputNum
      Panel_Window_FindPartyRecruite_info:setBaseOffence()
    elseif index == 2 then
      Panel_Window_FindPartyRecruite_info._value.selectDefence = inputNum
      Panel_Window_FindPartyRecruite_info:setBaseDefence()
    end
  end
  Panel_NumberPad_Show(true, max, 0, setValue)
end
function FromClient_FindPartyRecruite_Init()
  local self = Panel_Window_FindPartyRecruite_info
  self:initialize()
end
function FromClient_FindPartyRecruite_Resize()
  local self = Panel_Window_FindPartyRecruite_info
  self:keyAlign()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_FindPartyRecruite_Init")
