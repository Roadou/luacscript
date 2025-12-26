function PaGlobal_Season_Character_Create:initialize()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleBG, "Button_Close_PCUI")
  self._ui._btn_close:SetShow(false == self._isConsole)
  self._ui._keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_A_ConsoleUI")
  self._ui._keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_B_ConsoleUI")
  local keyGuide = {
    self._ui._keyGuide_A,
    self._ui._keyGuide_B
  }
  self._ui._keyGuide_A:SetShow(true == self._isConsole)
  self._ui._keyGuide_B:SetShow(true == self._isConsole)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._ui._stc_keyGuideBG:SetShow(true == self._isConsole)
  self:validate()
  self:registerEvent()
  self._seasonButtonOriginSpanSize = self._ui._btn_season:GetSpanSize()
  self._initialize = true
end
function PaGlobal_Season_Character_Create:clear()
  self._playerCreateType = nil
  self._isSeasonCharacter = nil
end
function PaGlobal_Season_Character_Create:prepareOpen(playerCreateType)
  return self:open(playerCreateType)
end
function PaGlobal_Season_Character_Create:isOpen()
  if false == PaGlobalFunc_CharacterSelect_All_CanMakeSeason() then
    return false
  end
  if true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason then
    return true
  end
  local curChannelData = getCurrentChannelServerData()
  if curChannelData ~= nil and curChannelData:isMultiNationServer() == true then
    return false
  end
  return false
end
function PaGlobal_Season_Character_Create:open(playerCreateType)
  if false == self._initialize then
    return false
  end
  if playerCreateType ~= __ePlayerCreateNormal then
    return false
  end
  if false == self:isOpen() then
    return false
  end
  self:clear()
  self._playerCreateType = playerCreateType
  if PaGlobalFunc_Customization_ForceFirstChracterSeason ~= nil and PaGlobalFunc_Customization_ForceFirstChracterSeason() == true then
    self._ui._btn_normal:SetShow(false)
    self._ui._btn_season:SetSpanSize(0, self._seasonButtonOriginSpanSize.y)
  else
    self._ui._btn_normal:SetShow(true)
    self._ui._btn_season:SetSpanSize(self._seasonButtonOriginSpanSize.x, self._seasonButtonOriginSpanSize.y)
  end
  Panel_Window_Season_Character_Create:SetShow(true)
  return true
end
function PaGlobal_Season_Character_Create:prepareClose()
  self:close()
end
function PaGlobal_Season_Character_Create:close()
  Panel_Window_Season_Character_Create:SetShow(false)
end
function PaGlobal_Season_Character_Create:validate()
  self._ui._stc_titleBG:isValidate()
  self._ui._btn_season:isValidate()
  self._ui._btn_normal:isValidate()
  self._ui._btn_close:isValidate()
end
function PaGlobal_Season_Character_Create:registerEvent()
  self._ui._btn_season:addInputEvent("Mouse_LUp", "PaGlobal_Season_Character_Create:createCharacter(true)")
  self._ui._btn_normal:addInputEvent("Mouse_LUp", "PaGlobal_Season_Character_Create:createCharacter(false)")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Season_Character_Create:prepareClose()")
end
function PaGlobal_Season_Character_Create:createCharacter(isSeason)
  if nil == self._playerCreateType then
    return
  end
  self._isSeasonCharacter = isSeason
  self:prepareClose()
  changeCreateCharacterMode_SelectClass(self._playerCreateType)
  FGlobal_SetPlayerCreateType(self._playerCreateType)
  if _ContentsOption_CH_GPM == true then
    ToClient_reportChinaGPM(__eReportSceneCreateSeasonCharacter, true)
  end
end
