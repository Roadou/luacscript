PaGlobal_Worldmap_NodeLevel = {
  _ui = {
    _stc_title = nil,
    _stc_title_icon = nil,
    _btn_close = nil,
    _list2_button = nil,
    _list2_content = nil,
    _stc_picturePool = {},
    _stc_keyGuideBg = nil,
    _btn_confirm_consoleUI = nil,
    _btn_cancel_consoleUI = nil
  },
  _param0 = nil,
  _param1 = nil,
  _confirmFunction = nil,
  _isConsole = false,
  _initialize = false,
  _listOriginPosX = 0,
  _listOriginPosY = 0,
  _listOriginSizeY = 0,
  _listShowMaxCount = 0,
  _selectedIndex = 0,
  _selfCharacterNo_64 = 0
}
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_WorldMap_NodeLevel_Init")
function FromClient_luaLoadComplete_WorldMap_NodeLevel_Init()
  PaGlobal_Worldmap_NodeLevel:initialize()
end
function PaGlobal_Worldmap_NodeLevel:initialize()
  if true == self._initialize or nil == Panel_Worldmap_NodeLevel then
    return
  end
  self._ui._stc_title = UI.getChildControl(Panel_Worldmap_NodeLevel, "StaticText_Title")
  self._ui._stc_title_icon = UI.getChildControl(self._ui._stc_title, "StaticText_TitleIcon")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_title, "Button_Win_Close")
  self._ui._list2_button = UI.getChildControl(Panel_Worldmap_NodeLevel, "List2_CharacterSelect")
  self._ui._list2_content = UI.getChildControl(self._ui._list2_button, "List2_2_Content")
  self._ui._stc_KeyGuideBg = UI.getChildControl(Panel_Worldmap_NodeLevel, "Static_KeyGuide_Console")
  self._ui._btn_confirm_consoleUI = UI.getChildControl(self._ui._stc_KeyGuideBg, "StaticText_Select_Console")
  self._ui._btn_cancel_consoleUI = UI.getChildControl(self._ui._stc_KeyGuideBg, "StaticText_Close_Console")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._listOriginPosX = self._ui._list2_button:GetPosX()
  self._listOriginPosY = self._ui._list2_button:GetPosY()
  self._listOriginSizeY = self._ui._list2_button:GetSizeY()
  self._listShowMaxCount = math.floor(self._ui._list2_button:GetSizeY() / self._ui._list2_content:GetSizeY())
  PaGlobal_Worldmap_NodeLevel:registEventHandler()
  PaGlobal_Worldmap_NodeLevel:setConsoleUI()
  PaGlobal_Worldmap_NodeLevel:validate()
  self._initialize = true
end
function PaGlobal_Worldmap_NodeLevel:setConsoleUI()
  if nil == Panel_Worldmap_NodeLevel then
    return
  end
  if true == self._isConsole then
    self._ui._stc_KeyGuideBg:SetShow(true)
    self._ui._btn_confirm_consoleUI:SetShow(true)
    self._ui._btn_cancel_consoleUI:SetShow(true)
    self._ui._stc_KeyGuideBg:SetPosY(Panel_Worldmap_NodeLevel:GetSizeY())
    local keyGuideSizeX = self._ui._btn_confirm_consoleUI:GetSizeX() + self._ui._btn_confirm_consoleUI:GetTextSizeX() + self._ui._btn_cancel_consoleUI:GetSizeX() + self._ui._btn_cancel_consoleUI:GetTextSizeX()
    local keyGuides = {
      self._ui._btn_confirm_consoleUI,
      self._ui._btn_cancel_consoleUI
    }
    if keyGuideSizeX < self._ui._stc_KeyGuideBg:GetSizeX() then
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    else
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    end
  else
    self._ui._stc_KeyGuideBg:SetShow(false)
    self._ui._btn_confirm_consoleUI:SetShow(false)
    self._ui._btn_cancel_consoleUI:SetShow(false)
  end
end
function PaGlobal_Worldmap_NodeLevel:validate()
  self._ui._stc_title:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._list2_button:isValidate()
  self._ui._list2_content:isValidate()
  self._ui._stc_KeyGuideBg:isValidate()
  self._ui._btn_confirm_consoleUI:isValidate()
  self._ui._btn_cancel_consoleUI:isValidate()
end
function PaGlobal_Worldmap_NodeLevel:registEventHandler()
  if nil == Panel_Worldmap_NodeLevel then
    return
  end
  Panel_Worldmap_NodeLevel:RegisterShowEventFunc(true, "PaGlobal_WorldMap_NodeLevel_All_ShowAni()")
  Panel_Worldmap_NodeLevel:RegisterShowEventFunc(false, "PaGlobal_WorldMap_NodeLevel_All_HideAni()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldMap_Grand_NodeLevel_Close()")
  self._ui._list2_button:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_CharacterList_All_SelectNodeInvestCharacter")
  self._ui._list2_button:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_WpChangedWithParam", "FromClient_SelfPlayerWpChanged")
  registerEvent("FromClient_WpChangedOtherCharacter", "FromClient_OtherCharacterWpChanged")
end
function PaGlobal_WorldMap_NodeLevel_All_ShowAni()
  UIAni.fadeInSCR_Down(Panel_Worldmap_NodeLevel)
end
function PaGlobal_WorldMap_NodeLevel_All_HideAni()
  if nil == Panel_Worldmap_NodeLevel then
    return
  end
  Panel_Worldmap_NodeLevel:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Worldmap_NodeLevel:addColorAnimation(0, 0.22, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function PaGlobal_Worldmap_NodeLevel:prepareOpen()
  self._ui._list2_button:SetShow(true)
  self._ui._list2_button:getElementManager():clearKey()
  local selfProxy = getSelfPlayer()
  self._selfCharacterNo_64 = toInt64(0, 0)
  if nil ~= selfProxy then
    self._selfCharacterNo_64 = selfProxy:getCharacterNo_64()
  end
  local characterDatacount = getCharacterDataCount(__ePlayerCreateNormal)
  for idx = 0, characterDatacount - 1 do
    self._ui._list2_button:getElementManager():pushKey(idx)
  end
  self._selectedIndex = 0
  PaGlobal_Worldmap_NodeLevel:open()
end
function PaGlobal_Worldmap_NodeLevel:open()
  Panel_Worldmap_NodeLevel:SetShow(true)
end
function PaGlobal_Worldmap_NodeLevel:prepareClose()
  PaGlobal_Worldmap_NodeLevel:close()
end
function PaGlobal_Worldmap_NodeLevel:close()
  Panel_Worldmap_NodeLevel:SetShow(false)
end
function PaGlobal_Worldmap_NodeLevel:openSetting(confirmFunction, param0, param1, param2)
  self._param0 = param0
  self._param1 = param1
  self._param2 = param2
  self._confirmFunction = confirmFunction
  if false == Panel_Worldmap_NodeLevel:GetShow() then
    if self._isConsole then
      local snappedControl = ToClient_getSnappedControl()
      if nil ~= snappedControl then
        Panel_Worldmap_NodeLevel:SetPosX(getMousePosX())
        Panel_Worldmap_NodeLevel:SetPosY(getMousePosY())
      else
        Panel_Worldmap_NodeLevel:SetPosX(getOriginScreenSizeX() / 2 - Panel_Worldmap_NodeLevel:GetSizeX() / 2)
        Panel_Worldmap_NodeLevel:SetPosY(getOriginScreenSizeY() / 2 - Panel_Worldmap_NodeLevel:GetSizeY() / 2)
      end
    else
      Panel_Worldmap_NodeLevel:SetPosX(getMousePosX())
      Panel_Worldmap_NodeLevel:SetPosY(getMousePosY())
    end
  end
  if false == self._isConsole then
    if Panel_Worldmap_NodeLevel:GetPosY() + Panel_Worldmap_NodeLevel:GetSizeY() > getScreenSizeY() or Panel_Worldmap_NodeLevel:GetPosY() < 0 then
      Panel_Worldmap_NodeLevel:SetPosY(getScreenSizeY() - Panel_Worldmap_NodeLevel:GetSizeY() - 30)
    end
  elseif Panel_Worldmap_NodeLevel:GetPosY() + Panel_Worldmap_NodeLevel:GetSizeY() + self._ui._stc_KeyGuideBg:GetSizeY() > getScreenSizeY() then
    Panel_Worldmap_NodeLevel:SetPosY(getScreenSizeY() - Panel_Worldmap_NodeLevel:GetSizeY() - self._ui._stc_KeyGuideBg:GetSizeY() - 30)
  end
  if Panel_Worldmap_NodeLevel:GetPosX() + Panel_Worldmap_NodeLevel:GetSizeX() > getScreenSizeX() or 0 > Panel_Worldmap_NodeLevel:GetPosX() then
    Panel_Worldmap_NodeLevel:SetPosX(getScreenSizeX() - Panel_Worldmap_NodeLevel:GetSizeX())
  end
  self._ui._stc_title_icon:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NODELEVEL_CHARACTERSELECT"))
  PaGlobal_Worldmap_NodeLevel:prepareOpen()
end
function PaGlobalFunc_WorldMap_NodeLevel_Show(confirmFunction, param0, param1, param2)
  PaGlobal_Worldmap_NodeLevel:openSetting(confirmFunction, param0, param1, param2)
end
function PaGlobalFunc_WorldMap_Grand_NodeLevel_Close()
  PaGlobal_Worldmap_NodeLevel:prepareClose()
end
function PaGlobal_CharacterList_All_SelectNodeInvestCharacter(control, key)
  local index = Int64toInt32(key)
  local serverUtc64 = getServerUtc64()
  local characterData = getCharacterDataByIndex(index, __ePlayerCreateNormal)
  if characterData == nil then
    return
  end
  local characterName = getCharacterName(characterData)
  local characterWp = ToClient_getWpInCharacterDataList(index)
  local classType = getCharacterClassType(characterData)
  local characterLv = string.format("%d", characterData._level)
  local btn_character = UI.getChildControl(control, "RadioButton_CharacterName")
  local stc_classIcon = UI.getChildControl(btn_character, "Static_ClassIcon")
  local stc_currentCharacter = UI.getChildControl(btn_character, "Static_CurrentCharacter")
  local stc_classBg = UI.getChildControl(btn_character, "Static_Class_BG")
  local stc_characterLv = UI.getChildControl(btn_character, "StaticText_Lv")
  local btn_CharacterName = UI.getChildControl(btn_character, "StaticText_Name")
  local btn_CharacterWp = UI.getChildControl(btn_character, "StaticText_WP")
  PaGlobalFunc_Util_SetFriendClassTypeIcon(stc_classIcon, classType)
  btn_CharacterName:SetText(characterName)
  stc_characterLv:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. characterLv)
  btn_CharacterWp:SetText(tostring(characterWp))
  if PaGlobal_Worldmap_NodeLevel._selfCharacterNo_64 ~= characterData._characterNo_s64 then
    stc_currentCharacter:SetShow(false)
  else
    stc_currentCharacter:SetShow(true)
  end
  btn_character:SetCheck(false)
  btn_character:setNotImpactScrollEvent(true)
  btn_character:addInputEvent("Mouse_LUp", "SelectNodeInvserCharacter(" .. index .. "," .. characterWp .. ")")
end
function SelectNodeInvserCharacter(characterIdx, characterWp)
  PaGlobal_Worldmap_NodeLevel._confirmFunction(PaGlobal_Worldmap_NodeLevel._param0, characterIdx, characterWp)
  PaGlobal_Worldmap_NodeLevel._selectedIndex = characterIdx
end
function Panel_Worldmap_NodeLevel_IsPopUp()
  return Panel_Worldmap_NodeLevel:IsShow()
end
function PaGlobalFunc_WorldMap_Grand_NodeLevel_GetShow()
  if nil == Panel_Worldmap_NodeLevel then
    return false
  end
  return Panel_Worldmap_NodeLevel:GetShow()
end
function FromClient_SelfPlayerWpChanged(prevWp, wp)
  local self = PaGlobal_Worldmap_NodeLevel
  if self == nil then
    return
  end
  if PaGlobalFunc_WorldMap_Grand_NodeLevel_GetShow() == false then
    return
  end
  local characterData = getCharacterDataByIndex(self._selectedIndex, __ePlayerCreateNormal)
  if characterData == nil then
    return
  end
  local contents = self._ui._list2_button:GetContentByKey(self._selectedIndex)
  if contents == nil then
    return
  end
  local btn_character = UI.getChildControl(contents, "RadioButton_CharacterName")
  if btn_character == nil then
    return
  end
  local stc_currentCharacter = UI.getChildControl(btn_character, "Static_CurrentCharacter")
  if stc_currentCharacter == nil then
    return
  end
  if stc_currentCharacter:GetShow() == false then
    return
  end
  local btn_CharacterWp = UI.getChildControl(btn_character, "StaticText_WP")
  if btn_CharacterWp == nil then
    return
  end
  btn_CharacterWp:SetText(tostring(wp))
end
function FromClient_OtherCharacterWpChanged(characterNo)
  local self = PaGlobal_Worldmap_NodeLevel
  if self == nil then
    return
  end
  if PaGlobalFunc_WorldMap_Grand_NodeLevel_GetShow() == false then
    return
  end
  local characterData = getCharacterDataByIndex(self._selectedIndex, __ePlayerCreateNormal)
  if characterData == nil then
    return
  end
  if characterData._characterNo_s64 ~= characterNo then
    return
  end
  local contents = self._ui._list2_button:GetContentByKey(self._selectedIndex)
  if contents == nil then
    return
  end
  local btn_character = UI.getChildControl(contents, "RadioButton_CharacterName")
  if btn_character == nil then
    return
  end
  local btn_CharacterWp = UI.getChildControl(btn_character, "StaticText_WP")
  if btn_CharacterWp == nil then
    return
  end
  local characterWp = ToClient_getWpInCharacterDataList(self._selectedIndex)
  btn_CharacterWp:SetText(tostring(characterWp))
end
