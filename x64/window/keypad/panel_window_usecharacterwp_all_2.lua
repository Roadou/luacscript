function PaGlobalFunc_UseCharacterWp_All_Open(type, param0)
  local self = PaGlobal_UseCharacterWp_All
  if self == nil then
    return
  end
  self:prepareOpen(type, param0)
end
function PaGlobalFunc_UseCharacterWp_All_Close()
  local self = PaGlobal_UseCharacterWp_All
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_UseCharacterWp_All_IsShow()
  if Panel_Window_UseCharacterWp_All == nil then
    return
  end
  return Panel_Window_UseCharacterWp_All:GetShow()
end
function PaGlobalFunc_UseCharacterWp_All_ShowAni()
  if Panel_Window_UseCharacterWp_All == nil then
    return
  end
  UIAni.fadeInSCR_Down(Panel_Window_UseCharacterWp_All)
end
function PaGlobalFunc_UseCharacterWp_All_HideAni()
  if Panel_Window_UseCharacterWp_All == nil then
    return
  end
  Panel_Window_UseCharacterWp_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_UseCharacterWp_All:addColorAnimation(0, 0.22, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function PaGlobalFunc_UseCharacterWp_All_MakeCharacterWpList(control, key)
  local self = PaGlobal_UseCharacterWp_All
  if self == nil then
    return
  end
  local index = Int64toInt32(key)
  local characterData = ToClient_getSortNormalCharacterDataByIndex(index)
  if characterData == nil then
    return
  end
  local characterName = getCharacterName(characterData)
  local characterWp = ToClient_getWpInSortNormalCharacterDataList(index)
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
  if self._selectedIndex ~= index then
    btn_character:SetCheck(false)
  else
    btn_character:SetCheck(true)
  end
  if self._selfCharacterNo_64 ~= characterData._characterNo_s64 then
    stc_currentCharacter:SetShow(false)
  else
    stc_currentCharacter:SetShow(true)
  end
  btn_character:setNotImpactScrollEvent(true)
  btn_character:addInputEvent("Mouse_LUp", "PaGlobalFunc_UseCharacterWp_All_SelectCharacterList(" .. index .. ")")
end
function PaGlobalFunc_UseCharacterWp_All_SelectCharacterList(characterIdx)
  local self = PaGlobal_UseCharacterWp_All
  if self == nil then
    return
  end
  self:selectCharacterList(characterIdx)
end
function FromClient_UseCharacterWp_All_SelfPlayerWpChanged(prevWp, wp)
  local self = PaGlobal_UseCharacterWp_All
  if self == nil then
    return
  end
  if Panel_Window_UseCharacterWp_All:GetShow() == false then
    return
  end
  if _ContentsGroup_UseCharacterWp == false then
    return
  end
  local characterData = ToClient_getSortNormalCharacterDataByIndex(self._selectedIndex)
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
function FromClient_UseCharacterWp_All_OtherCharacterWpChanged(characterNo)
  local self = PaGlobal_UseCharacterWp_All
  if self == nil then
    return
  end
  if _ContentsGroup_UseCharacterWp == false then
    return
  end
  if Panel_Window_UseCharacterWp_All:GetShow() == false then
    return
  end
  local characterData = ToClient_getSortNormalCharacterDataByIndex(self._selectedIndex)
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
  local characterWp = ToClient_getWpInSortNormalCharacterDataList(self._selectedIndex)
  btn_CharacterWp:SetText(tostring(characterWp))
  if self._currentOpenType == self._openType._secretRandomShop then
    PaGlobalFunc_RandomShop_All_CheckWp()
  end
end
function PaGlobalFunc_UseCharacterWp_All_InvestNode(inputNumber)
  local self = PaGlobal_UseCharacterWp_All
  if self == nil then
    return
  end
  if self._currentOpenType ~= self._openType._investNode then
    return
  end
  local wpCount = Int64toInt32(inputNumber) * 10
  local nodeName = ToClient_GetNodeNameByWaypointKey(self._param0)
  local function InvestNodeLevelFunc()
    ToClient_RequestIncreaseExperienceNodeByCharacterIndex(self._param0, self._selectedIndex, wpCount)
  end
  local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NODELEVEL_CONFIRM", "regionName", nodeName, "energy", wpCount)
  local messageBoxData = {
    title = "",
    content = messageBoxMemo,
    functionYes = InvestNodeLevelFunc,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
  local self = PaGlobal_UseCharacterWp_All
  if self == nil then
    return
  end
  if self._selectedIndex == -1 then
    local selfPlayerActorWrapper = getSelfPlayer()
    if selfPlayerActorWrapper == nil then
      return
    end
    self._selfCharacterNo_64 = selfPlayerActorWrapper:getCharacterNo_64()
    for index = 0, getCharacterDataCount(__ePlayerCreateNormal) - 1 do
      local characterData = ToClient_getSortNormalCharacterDataByIndex(index)
      if self._selfCharacterNo_64 == characterData._characterNo_s64 then
        self._selectedIndex = index
      end
    end
  end
  return ToClient_getWpInSortNormalCharacterDataList(self._selectedIndex)
end
function PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterName()
  local self = PaGlobal_UseCharacterWp_All
  if self == nil then
    return
  end
  if self._selectedIndex == -1 then
    local selfPlayerActorWrapper = getSelfPlayer()
    if selfPlayerActorWrapper == nil then
      return
    end
    self._selfCharacterNo_64 = selfPlayerActorWrapper:getCharacterNo_64()
    for index = 0, getCharacterDataCount(__ePlayerCreateNormal) - 1 do
      local characterData = ToClient_getSortNormalCharacterDataByIndex(index)
      if self._selfCharacterNo_64 == characterData._characterNo_s64 then
        self._selectedIndex = index
      end
    end
  end
  local characterData = ToClient_getSortNormalCharacterDataByIndex(self._selectedIndex)
  if characterData == nil then
    return
  end
  return getCharacterName(characterData)
end
function PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterIndex()
  local self = PaGlobal_UseCharacterWp_All
  if self == nil then
    return
  end
  return self._selectedIndex
end
function PaGlobalFunc_UseCharacterWp_All_UpdateWpList()
  local self = PaGlobal_UseCharacterWp_All
  if self == nil then
    return
  end
  for idx = 0, getCharacterDataCount(__ePlayerCreateNormal) - 1 do
    local content = self._ui._list2_button:GetContentByKey(idx)
    if content ~= nil then
      local btn_character = UI.getChildControl(content, "RadioButton_CharacterName")
      local btn_CharacterWp = UI.getChildControl(btn_character, "StaticText_WP")
      local characterWp = ToClient_getWpInSortNormalCharacterDataList(idx)
      btn_CharacterWp:SetText(tostring(characterWp))
    end
  end
end
function PaGlobalFunc_UseCharacterWp_All_CanCloseByEsc()
  local self = PaGlobal_UseCharacterWp_All
  if self == nil then
    return false
  end
  if Panel_Window_UseCharacterWp_All == nil then
    return false
  end
  if Panel_Window_UseCharacterWp_All:GetShow() == false then
    return false
  end
  if self._currentOpenType == self._openType._investNode then
    return true
  end
  return false
end
function PaGlobalFunc_UseCharacterWp_All_SetIgnoreControl()
  local self = PaGlobal_UseCharacterWp_All
  if self == nil then
    return false
  end
  for idx = 0, getCharacterDataCount(__ePlayerCreateNormal) - 1 do
    local content = self._ui._list2_button:GetContentByKey(idx)
    if content ~= nil then
      local btn_character = UI.getChildControl(content, "RadioButton_CharacterName")
      local stc_classIcon = UI.getChildControl(btn_character, "Static_ClassIcon")
      local stc_classBg = UI.getChildControl(btn_character, "Static_Class_BG")
      local stc_characterLv = UI.getChildControl(btn_character, "StaticText_Lv")
      local btn_CharacterName = UI.getChildControl(btn_character, "StaticText_Name")
      local btn_CharacterWp = UI.getChildControl(btn_character, "StaticText_WP")
      stc_classIcon:SetIgnore(true)
      stc_classBg:SetIgnore(true)
      btn_CharacterName:SetIgnore(true)
      stc_characterLv:SetIgnore(true)
      btn_CharacterWp:SetIgnore(true)
    end
  end
end
