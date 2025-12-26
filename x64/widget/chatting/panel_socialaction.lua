PaGlobal_SocialMenu = {
  _ui = {
    _stc_titlebg = nil,
    _btn_winClose = nil,
    _stc_mainBg = nil,
    _stc_listBg = nil,
    _stc_radioBg = nil,
    _rdo_character = nil,
    _rdo_maidActor = nil,
    _rdo_together = nil,
    _frameSocialAction = nil,
    _edit_command = nil,
    _edit_keyword_1 = nil,
    _edit_keyword_2 = nil,
    _edit_keyword_3 = nil,
    _commandTitle = nil,
    _selectedTitle = nil,
    _descArea = nil,
    _btnApply = nil,
    _btnReset = nil,
    _btnCancel = nil,
    _groupApplyCeremony = nil,
    _keyTitle = nil,
    _groupSocial = nil,
    _iconBG = nil,
    _descBG = nil,
    _name = nil,
    _icon = nil,
    _keyGuideBG = nil,
    _keyGuideY = nil,
    _keyGuideA = nil,
    _keyGuideX = nil,
    _keyGuideB = nil
  },
  _classSlot = {},
  _socialIconSlot = {},
  _socialIconSlotBG = {},
  _selectedSlotBG = nil,
  _panelSizeY = 0,
  _mainBgSizeY = 0,
  _groupSocialSizeY = 0,
  _selectedAreaSizeY = 0,
  _frameSpanSizeY = 0,
  _listBgPosY = 0,
  _keyTitlePosY = 0,
  _keywordPosY = 0,
  _descPosY = 0,
  _commandTitlePosY = 0,
  _selectedIconPosY = 0,
  _selectedNamePosY = 0,
  _originalTextSize = 0,
  _maxColumnCount = 6,
  _selectIndex = -1,
  _SOCIALACTION_MAINTAB_COUNT = 13,
  _SOCIALACTION_SUBTAB_COUNT = 4,
  _command = "",
  _keywordValue = "",
  _socialActionKey = nil,
  _initialize = false,
  _isSelectingCeremony = false
}
registerEvent("FromClient_luaLoadComplete", "SocialAction_Icon_Initialize")
registerEvent("FromClient_CheckChinaProhibitedWord_SetSocialActionKeyword", "FromClient_CheckChinaProhibitedWord_SetSocialActionKeyword")
function SocialAction_Icon_Initialize()
  PaGlobal_SocialMenu:Initialize()
end
function PaGlobal_SocialMenu:Initialize()
  if true == self._initialize then
    return
  end
  self._ui._stc_titlebg = UI.getChildControl(Panel_Chat_SocialMenu, "Static_TitleBg")
  self._ui._btn_winClose = UI.getChildControl(self._ui._stc_titlebg, "Button_WinClose")
  self._ui._stc_mainBg = UI.getChildControl(Panel_Chat_SocialMenu, "Static_MainBg")
  self._ui._stc_radioBg = UI.getChildControl(Panel_Chat_SocialMenu, "Static_ButtonBg")
  self._ui._rdo_character = UI.getChildControl(self._ui._stc_radioBg, "RadioButton_Character")
  self._ui._rdo_maidActor = UI.getChildControl(self._ui._stc_radioBg, "RadioButton_Maid")
  self._ui._rdo_together = UI.getChildControl(self._ui._stc_radioBg, "RadioButton_Together")
  self._ui._rdo_character:SetShow(true)
  self._ui._rdo_maidActor:SetShow(_ContentsGroup_MaidActorSystem == true)
  self._ui._rdo_together:SetShow(_ContentsGroup_MaidActorSystem == true)
  self._ui._stc_listBg = UI.getChildControl(Panel_Chat_SocialMenu, "Static_ListBg")
  self._ui._frameSocialAction = UI.getChildControl(Panel_Chat_SocialMenu, "Frame_SocialAction")
  self._ui._groupSocial = UI.getChildControl(Panel_Chat_SocialMenu, "Static_Group_Social")
  self._ui._edit_command = UI.getChildControl(self._ui._groupSocial, "Edit_Command")
  self._ui._edit_keyword_1 = UI.getChildControl(self._ui._groupSocial, "Edit_Keyword_1")
  self._ui._edit_keyword_2 = UI.getChildControl(self._ui._groupSocial, "Edit_Keyword_2")
  self._ui._edit_keyword_3 = UI.getChildControl(self._ui._groupSocial, "Edit_Keyword_3")
  self._ui._descArea = UI.getChildControl(self._ui._groupSocial, "Static_DescArea")
  self._ui._groupApplyCeremony = UI.getChildControl(Panel_Chat_SocialMenu, "Static_Group_Solare")
  self._ui._btnApplyCeremony = UI.getChildControl(self._ui._groupApplyCeremony, "Button_Apply")
  self._ui._btnApply = UI.getChildControl(self._ui._groupSocial, "Button_Apply")
  self._ui._btnReset = UI.getChildControl(self._ui._groupSocial, "Button_Reset")
  self._ui._btnCancel = UI.getChildControl(self._ui._groupSocial, "Button_Cancel")
  self._ui._keyTitle = UI.getChildControl(self._ui._groupSocial, "StaticText_Key_Title")
  self._ui._name = UI.getChildControl(Panel_Chat_SocialMenu, "StaticText_SocialName")
  self._ui._icon = UI.getChildControl(Panel_Chat_SocialMenu, "Static_SelectedIcon")
  self._ui._iconBG = UI.getChildControl(Panel_Chat_SocialMenu, "Static_IconBG")
  self._ui._descBG = UI.getChildControl(Panel_Chat_SocialMenu, "Static_DescBG")
  self._ui._conditionText = UI.getChildControl(Panel_Chat_SocialMenu, "StaticText_ConditionMessage")
  self._ui._commandTitle = UI.getChildControl(Panel_Chat_SocialMenu, "StaticText_Command_Title")
  self._ui._selectedTitle = UI.getChildControl(Panel_Chat_SocialMenu, "StaticText_SelectedCeremony")
  self._ui._keyGuideBG = UI.getChildControl(Panel_Chat_SocialMenu, "Static_KeyGuide_ConsoleUI")
  self._ui._keyGuideY = UI.getChildControl(self._ui._keyGuideBG, "StaticText_Y_ConsoleUI")
  self._ui._keyGuideA = UI.getChildControl(self._ui._keyGuideBG, "StaticText_A_ConsoleUI")
  self._ui._keyGuideX = UI.getChildControl(self._ui._keyGuideBG, "StaticText_X_ConsoleUI")
  self._ui._keyGuideB = UI.getChildControl(self._ui._keyGuideBG, "StaticText_B_ConsoleUI")
  self:validate()
  self:registEventHandler()
  Panel_Chat_SocialMenu:setGlassBackground(true)
  Panel_Chat_SocialMenu:SetDragEnable(true)
  Panel_Chat_SocialMenu:SetDragAll(true)
  Panel_Chat_SocialMenu:SetPosX(getScreenSizeX() / 2 + Panel_Chat_SocialMenu:GetSizeX() / 2)
  Panel_Chat_SocialMenu:SetPosY(getScreenSizeY() / 2 - Panel_Chat_SocialMenu:GetSizeY() / 2)
  Panel_Chat_SocialMenu:SetChildIndex(self._ui._icon, 9999)
  self._ui._conditionText:SetTextMode(__eTextMode_AutoWrap)
  local descText = UI.getChildControl(self._ui._descArea, "StaticText_Desc")
  local originalTextSize = descText:GetSizeY()
  descText:SetTextMode(__eTextMode_AutoWrap)
  descText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_DESC"))
  descText:SetSize(descText:GetSizeX(), descText:GetTextSizeY())
  local changedTextSize = descText:GetSizeY()
  self._ui._descArea:SetSize(self._ui._descArea:GetSizeX(), self._ui._descArea:GetSizeY() + (changedTextSize - originalTextSize))
  self._ui._groupSocial:SetSize(self._ui._groupSocial:GetSizeX(), self._ui._groupSocial:GetSizeY() + (changedTextSize - originalTextSize))
  self._ui._stc_mainBg:SetSize(self._ui._stc_mainBg:GetSizeX(), self._ui._stc_mainBg:GetSizeY() + (changedTextSize - originalTextSize))
  Panel_Chat_SocialMenu:SetSize(Panel_Chat_SocialMenu:GetSizeX(), Panel_Chat_SocialMenu:GetSizeY() + (changedTextSize - originalTextSize))
  descText:ComputePos()
  if true == _ContentsGroup_UsePadSnapping then
    self._ui._btn_winClose:SetShow(false)
    self._ui._btnApply:SetShow(false)
    self._ui._btnReset:SetShow(false)
    self._ui._btnCancel:SetShow(false)
    Panel_Chat_SocialMenu:SetSize(Panel_Chat_SocialMenu:GetSizeX(), Panel_Chat_SocialMenu:GetSizeY() - self._ui._btnApply:GetSizeY())
    local keyGuide = {
      self._ui._keyGuideY,
      self._ui._keyGuideA,
      self._ui._keyGuideX,
      self._ui._keyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
  end
  self._panelSizeY = Panel_Chat_SocialMenu:GetSizeY()
  self._mainBgSizeY = self._ui._stc_mainBg:GetSizeY()
  self._groupSocialSizeY = self._ui._groupSocial:GetSizeY()
  self._selectedAreaSizeY = self._ui._iconBG:GetSizeY() + self._ui._selectedTitle:GetSizeY() + 30
  self._frameSpanSizeY = self._ui._frameSocialAction:GetSpanSize().y
  self._listBgPosY = self._ui._stc_listBg:GetPosY()
  self._keyTitlePosY = self._ui._keyTitle:GetPosY()
  self._keywordPosY = self._ui._edit_keyword_1:GetPosY()
  self._descPosY = self._ui._descArea:GetPosY()
  self._commandTitlePosY = self._ui._commandTitle:GetPosY()
  self._selectedIconPosY = self._ui._icon:GetPosY()
  self._selectedNamePosY = self._ui._name:GetPosY()
  self:makeClassSlotIndex()
  self._initialize = true
end
function PaGlobal_SocialMenu:registEventHandler()
  if Panel_Chat_SocialMenu == nil then
    return
  end
  if _ContentsGroup_MaidActorSystem == true then
    self._ui._rdo_character:addInputEvent("Mouse_LUp", "HandleEventLUp_SocialMenu_ClickRadio(" .. __eMaidActorSocialActionType_SelfPlayer .. ")")
    self._ui._rdo_maidActor:addInputEvent("Mouse_LUp", "HandleEventLUp_SocialMenu_ClickRadio(" .. __eMaidActorSocialActionType_MaidActor .. ")")
    self._ui._rdo_together:addInputEvent("Mouse_LUp", "HandleEventLUp_SocialMenu_ClickRadio(" .. __eMaidActorSocialActionType_Together .. ")")
  end
  if _ContentsGroup_UsePadSnapping == false then
    self._ui._btn_winClose:addInputEvent("Mouse_LUp", "HandleClicked_Button(1,0)")
    self._ui._edit_command:addInputEvent("Mouse_LUp", "HandleClicked_EditBox(" .. 0 .. ")")
    self._ui._edit_keyword_1:addInputEvent("Mouse_LUp", "HandleClicked_EditBox(" .. 1 .. ")")
    self._ui._edit_keyword_2:addInputEvent("Mouse_LUp", "HandleClicked_EditBox(" .. 2 .. ")")
    self._ui._edit_keyword_3:addInputEvent("Mouse_LUp", "HandleClicked_EditBox(" .. 3 .. ")")
    self._ui._btnApply:addInputEvent("Mouse_LUp", "HandleClicked_Apply()")
    self._ui._btnReset:addInputEvent("Mouse_LUp", "HandleClicked_Button(" .. 0 .. ")")
    self._ui._btnCancel:addInputEvent("Mouse_LUp", "HandleClicked_Button(" .. 1 .. ")")
    if _ContentsGroup_SolareCeremony == true then
      self._ui._groupApplyCeremony:addInputEvent("Mouse_LUp", "HandleClicked_Apply()")
      self._ui._btnApplyCeremony:addInputEvent("Mouse_LUp", "HandleClicked_ApplyCeremony()")
    end
  else
    self._ui._edit_command:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleClicked_EditBox(" .. 0 .. ")")
    self._ui._edit_keyword_1:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleClicked_EditBox(" .. 1 .. ")")
    self._ui._edit_keyword_2:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleClicked_EditBox(" .. 2 .. ")")
    self._ui._edit_keyword_3:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleClicked_EditBox(" .. 3 .. ")")
    Panel_Chat_SocialMenu:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleClicked_ApplyCeremony()")
    Panel_Chat_SocialMenu:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  end
  if _ContentsGroup_RenewUI == true then
    self._ui._edit_command:setXboxVirtualKeyBoardEndEvent("PaGlobal_SocialMenu_EndInputEvent_Command")
    self._ui._edit_keyword_1:setXboxVirtualKeyBoardEndEvent("PaGlobal_SocialMenu_EndInputEvent_Keyword_1")
    self._ui._edit_keyword_2:setXboxVirtualKeyBoardEndEvent("PaGlobal_SocialMenu_EndInputEvent_Keyword_2")
    self._ui._edit_keyword_3:setXboxVirtualKeyBoardEndEvent("PaGlobal_SocialMenu_EndInputEvent_Keyword_3")
  else
    self._ui._edit_command:RegistReturnKeyEvent("PaGlobal_SocialMenu_EndInputEvent_Command()")
    self._ui._edit_keyword_1:RegistReturnKeyEvent("PaGlobal_SocialMenu_EndInputEvent_Keyword_1()")
    self._ui._edit_keyword_2:RegistReturnKeyEvent("PaGlobal_SocialMenu_EndInputEvent_Keyword_2()")
    self._ui._edit_keyword_3:RegistReturnKeyEvent("PaGlobal_SocialMenu_EndInputEvent_Keyword_3()")
  end
end
function PaGlobal_SocialMenu:validate()
  if Panel_Chat_SocialMenu == nil then
    return
  end
  self._ui._stc_titlebg:isValidate()
  self._ui._btn_winClose:isValidate()
  self._ui._stc_mainBg:isValidate()
  self._ui._frameSocialAction:isValidate()
  self._ui._edit_command:isValidate()
  self._ui._edit_keyword_1:isValidate()
  self._ui._edit_keyword_2:isValidate()
  self._ui._edit_keyword_3:isValidate()
  self._ui._descArea:isValidate()
  self._ui._btnApply:isValidate()
  self._ui._btnReset:isValidate()
  self._ui._btnCancel:isValidate()
  self._ui._keyTitle:isValidate()
  self._ui._descBG:isValidate()
  self._ui._name:isValidate()
  self._ui._conditionText:isValidate()
  self._ui._icon:isValidate()
  self._ui._keyGuideBG:isValidate()
  self._ui._keyGuideY:isValidate()
  self._ui._keyGuideA:isValidate()
  self._ui._keyGuideX:isValidate()
  self._ui._keyGuideB:isValidate()
end
function PaGlobal_SocialMenu:prepareOpen()
  if Panel_Chat_SocialMenu == nil then
    return
  end
  if Panel_Chat_SocialMenu:GetShow() == true then
    return
  end
  if _ContentsGroup_MaidActorSystem == true then
    local saveCacheNumber = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMaidActorSocialActionType)
    if saveCacheNumber == __eMaidActorSocialActionType_SelfPlayer then
      self._ui._rdo_character:SetCheck(true)
      self._ui._rdo_maidActor:SetCheck(false)
      self._ui._rdo_together:SetCheck(false)
    elseif saveCacheNumber == __eMaidActorSocialActionType_MaidActor then
      self._ui._rdo_character:SetCheck(false)
      self._ui._rdo_maidActor:SetCheck(true)
      self._ui._rdo_together:SetCheck(false)
    elseif saveCacheNumber == __eMaidActorSocialActionType_Together then
      self._ui._rdo_character:SetCheck(false)
      self._ui._rdo_maidActor:SetCheck(false)
      self._ui._rdo_together:SetCheck(true)
    else
      self._ui._rdo_character:SetCheck(true)
      self._ui._rdo_maidActor:SetCheck(false)
      self._ui._rdo_together:SetCheck(false)
    end
  else
    self._ui._rdo_character:SetCheck(true)
  end
  if self._isSelectingCeremony == true then
    self._ui._frameSocialAction:SetSpanSize(self._ui._frameSocialAction:GetSpanSize().x, self._frameSpanSizeY - (self._ui._stc_radioBg:GetSizeY() - 5))
  else
    self._ui._frameSocialAction:SetSpanSize(self._ui._frameSocialAction:GetSpanSize().x, self._frameSpanSizeY)
  end
  if _ContentsGroup_UsePadSnapping == true then
    self._ui._frameSocialAction:GetFrameContent():SetPosY(0)
    UI.getChildControl(self._ui._frameSocialAction, "VerticalScroll"):SetControlPos(0)
  end
  self._selectIndex = -1
  self:updateButtonState()
  local keyGuide
  if self._isSelectingCeremony == true then
    self._ui._groupSocial:SetShow(false)
    self._ui._groupApplyCeremony:SetShow(true)
    self._ui._stc_radioBg:SetShow(false)
    self._ui._commandTitle:SetShow(false)
    self._ui._selectedTitle:SetShow(true)
    self._ui._conditionText:SetShow(false)
    local radioBgSizeY = self._ui._stc_radioBg:GetSizeY()
    self._ui._groupSocial:SetSize(self._ui._groupSocial:GetSizeX(), self._groupSocialSizeY - radioBgSizeY + self._selectedAreaSizeY + 10)
    self._ui._stc_mainBg:SetSize(self._ui._stc_mainBg:GetSizeX(), self._mainBgSizeY - radioBgSizeY + self._selectedAreaSizeY - self._groupSocialSizeY + self._ui._groupApplyCeremony:GetSizeY() + 15)
    local groupSocialGapY = self._panelSizeY - self._ui._groupSocial:GetPosY()
    Panel_Chat_SocialMenu:SetSize(Panel_Chat_SocialMenu:GetSizeX(), self._panelSizeY - radioBgSizeY + self._selectedAreaSizeY - (groupSocialGapY - self._ui._groupApplyCeremony:GetSizeY()) + 10)
    local ceremonyKey = ToClient_GetInstanceContentsSocialActionKey(__eInstanceContentsType_Solare, true)
    local socialIconCount = ToClient_getSocialActionInfoList()
    for ii = 0, socialIconCount do
      local socialActionInfo = ToClient_getSocialActionInfoByIndex(ii)
      if socialActionInfo ~= nil then
        local socialKey = socialActionInfo:getSocialActionKeyRaw()
        if socialKey == ceremonyKey and ToClient_isUsableSocialAction(socialKey, self._isSelectingCeremony) == true then
          ShowModificationWarning(ii, true)
          break
        end
      end
    end
    self._ui._stc_listBg:SetPosY(self._listBgPosY - radioBgSizeY + 5)
    self._ui._name:SetPosY(self._selectedNamePosY - radioBgSizeY + 10)
    self._ui._icon:SetPosY(self._selectedIconPosY - radioBgSizeY + 10)
    self._ui._iconBG:SetPosY(self._selectedIconPosY - radioBgSizeY + 10)
    self._ui._groupApplyCeremony:ComputePos()
    Panel_Chat_SocialMenu:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleClicked_ApplyCeremony()")
    Panel_Chat_SocialMenu:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    keyGuide = {
      self._ui._keyGuideY,
      self._ui._keyGuideA,
      self._ui._keyGuideB
    }
    self._ui._keyGuideX:SetShow(false)
  else
    self._ui._groupSocial:SetShow(true)
    self._ui._groupApplyCeremony:SetShow(false)
    self._ui._stc_radioBg:SetShow(true)
    self._ui._commandTitle:SetShow(true)
    self._ui._selectedTitle:SetShow(false)
    self._ui._rdo_maidActor:SetShow(_ContentsGroup_MaidActorSystem == true)
    self._ui._rdo_together:SetShow(_ContentsGroup_MaidActorSystem == true)
    local descText = UI.getChildControl(self._ui._descArea, "StaticText_Desc")
    self._ui._descArea:SetSize(self._ui._descArea:GetSizeX(), self._ui._descArea:GetSizeY())
    self._ui._stc_mainBg:SetSize(self._ui._stc_mainBg:GetSizeX(), self._mainBgSizeY)
    self._ui._groupSocial:SetSize(self._ui._stc_mainBg:GetSizeX(), Panel_Chat_SocialMenu:GetSizeY() - self._ui._groupSocial:GetSpanSize().y)
    Panel_Chat_SocialMenu:SetSize(Panel_Chat_SocialMenu:GetSizeX(), self._panelSizeY)
    self._ui._stc_listBg:SetPosY(self._listBgPosY)
    self._ui._commandTitle:SetPosY(self._commandTitlePosY)
    self._ui._name:SetPosY(self._selectedNamePosY)
    self._ui._icon:SetPosY(self._selectedIconPosY)
    self._ui._iconBG:SetPosY(self._selectedIconPosY)
    descText:ComputePos()
    self._ui._btnApply:ComputePos()
    self._ui._btnReset:ComputePos()
    self._ui._btnCancel:ComputePos()
    Panel_Chat_SocialMenu:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleClicked_Apply()")
    Panel_Chat_SocialMenu:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleClicked_Button(" .. 0 .. ")")
    keyGuide = {
      self._ui._keyGuideY,
      self._ui._keyGuideA,
      self._ui._keyGuideX,
      self._ui._keyGuideB
    }
    self._ui._keyGuideX:SetShow(true)
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._ui._keyGuideBG:SetPosY(Panel_Chat_SocialMenu:GetSizeY())
  self:Open()
end
function PaGlobal_SocialMenu:Open()
  if Panel_Chat_SocialMenu == nil then
    return
  end
  Panel_Chat_SocialMenu:SetShow(true)
end
function PaGlobal_SocialMenu:prepareClose()
  if Panel_Chat_SocialMenu == nil then
    return
  end
  if Panel_Chat_SocialMenu:GetShow() == false then
    return
  end
  if _ContentsOption_CH_CheckProhibitedWord == true then
    if _ContentsGroup_UsePadSnapping == true then
      Panel_Chat_SocialMenu:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleClicked_Apply()")
    else
      self._ui._btnApply:SetIgnore(false)
    end
    self._ui._edit_command:RegistReturnKeyEvent("PaGlobal_SocialMenu_EndInputEvent_Command()")
    self._ui._edit_keyword_1:RegistReturnKeyEvent("PaGlobal_SocialMenu_EndInputEvent_Keyword_1()")
    self._ui._edit_keyword_2:RegistReturnKeyEvent("PaGlobal_SocialMenu_EndInputEvent_Keyword_2()")
    self._ui._edit_keyword_3:RegistReturnKeyEvent("PaGlobal_SocialMenu_EndInputEvent_Keyword_3()")
  end
  ToClient_cancelSocialActionInfo()
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  if _ContentsGroup_RenewUI == false then
    FGlobal_SocialAction_SetCHK(false)
  end
  TooltipSimple_Hide()
  self._isSelectingCeremony = false
  self:Close()
end
function PaGlobal_SocialMenu:Close()
  if Panel_Chat_SocialMenu == nil then
    return
  end
  Panel_Chat_SocialMenu:SetShow(false)
end
function PaGlobal_SocialMenu:setSocialAction()
  if Panel_Chat_SocialMenu == nil then
    return
  end
  local selectedSlotBG = UI.getChildControl(Panel_Chat_SocialMenu, "Static_C_IconSelect")
  local socialIconCount = ToClient_getSocialActionInfoList()
  local iconGap = 55
  local columnCount = 0
  local rowCount = 0
  local posIndex = 0
  local startIndex = 0
  local frameContent = self._ui._frameSocialAction:GetFrameContent()
  frameContent:DestroyAllChild()
  local isClassType = getSelfPlayer():getClassType()
  local isMakeSuccess = false
  if #self._classSlot ~= 0 then
    startIndex = self._classSlot[1]
  end
  for index = 1, #self._classSlot do
    isMakeSuccess, columnCount, rowCount = self:makeSlot(self._classSlot[index], posIndex, columnCount, rowCount)
    if isMakeSuccess == true then
      posIndex = posIndex + 1
    end
  end
  if posIndex == 0 then
    startIndex = 0
  end
  for index = 0, socialIconCount do
    if ToClient_checkClassTypeSocialAction(index) == true and self:checkPrevSlot(index) == false then
      isMakeSuccess, columnCount, rowCount = self:makeSlot(index, posIndex, columnCount, rowCount)
      if isMakeSuccess == true then
        posIndex = posIndex + 1
      end
    end
  end
  self._selectedSlotBG = createControl(__ePAUIControl_Static, frameContent, "Static_SelectedSlot")
  CopyBaseProperty(selectedSlotBG, self._selectedSlotBG)
  self._ui._frameSocialAction:UpdateContentScroll()
  return startIndex
end
function PaGlobal_SocialMenu:makeSlot(index, posIndex, columnCount, rowCount)
  if Panel_Chat_SocialMenu == nil then
    return
  end
  local socialIconSlotBG = UI.getChildControl(Panel_Chat_SocialMenu, "Static_C_IconBG")
  local socialIconSlot = UI.getChildControl(Panel_Chat_SocialMenu, "Static_C_SocialIcon")
  local frameContent = self._ui._frameSocialAction:GetFrameContent()
  local socialIconCount = ToClient_getSocialActionInfoList()
  local iconGap = 55
  self._socialIconSlotBG[index] = {}
  self._socialIconSlot[index] = {}
  self._socialIconSlotBG[index] = createControl(__ePAUIControl_Static, frameContent, "Static_SocialIconSlotBG_" .. index)
  self._socialIconSlot[index] = UI.createControl(__ePAUIControl_Static, frameContent, "Static_SocialIconSlot_" .. index)
  local slotBG = self._socialIconSlotBG[index]
  local slot = self._socialIconSlot[index]
  local prevColumnCount = columnCount
  local prevRowCount = rowCount
  CopyBaseProperty(socialIconSlotBG, slotBG)
  CopyBaseProperty(socialIconSlot, slot)
  frameContent:SetChildIndex(slot, 3000)
  if posIndex % self._maxColumnCount == 0 then
    columnCount = 0
    rowCount = rowCount + 1
  else
    columnCount = columnCount + 1
  end
  slotBG:SetPosX(socialIconSlotBG:GetPosX() + iconGap * columnCount)
  slotBG:SetPosY(socialIconSlotBG:GetPosY() + iconGap * (rowCount - 1))
  slot:SetPosX(socialIconSlot:GetPosX() + iconGap * columnCount)
  slot:SetPosY(socialIconSlot:GetPosY() + iconGap * (rowCount - 1))
  slotBG:SetShow(true)
  slot:SetShow(true)
  if socialIconCount ~= index then
    local socialActionInfo = ToClient_getSocialActionInfoByIndex(index)
    if socialActionInfo == nil then
      return false, prevColumnCount, prevRowCount
    end
    local sASS = socialActionInfo:getStaticStatus()
    local socialKey = socialActionInfo:getSocialActionKeyRaw()
    local isBlockedCeremony = false
    if self._isSelectingCeremony == true then
      isBlockedCeremony = sASS:isBlockCeremony()
    end
    if ToClient_isUsableSocialAction(socialKey, self._isSelectingCeremony) == true and isBlockedCeremony == false then
      slot:ActiveMouseEventEffect(true)
      slot:SetMonoTone(false)
      slot:addInputEvent("Mouse_LUp", "ShowModificationWarning(" .. index .. ", true )")
      slot:addInputEvent("Mouse_RUp", "HandleClicked_DoAction(" .. index .. ")")
      slot:addInputEvent("Mouse_PressMove", "HandleEventPressMove_SocialIcon_StartDrag(" .. index .. ")")
      slot:addInputEvent("Mouse_On", "Show_Condition_SocialIcon(" .. index .. ", true )")
      slot:addInputEvent("Mouse_Out", "Show_Condition_SocialIcon()")
      slot:SetEnableDragAndDrop(true)
    else
      slot:ActiveMouseEventEffect(false)
      slot:SetMonoTone(true)
      slot:addInputEvent("Mouse_On", "Show_Condition_SocialIcon(" .. index .. ")")
      slot:addInputEvent("Mouse_Out", "Show_Condition_SocialIcon()")
    end
    slot:ChangeTextureInfoNameAsync("Icon/" .. sASS:getIconPath())
    slot:SetAlpha(1)
  else
    slot:ChangeTextureInfoNameAsync("Icon/New_Icon/03_ETC/item_unknown.dds")
    slot:SetAlpha(1)
    slot:SetIgnore(true)
    slotBG:SetIgnore(true)
    if _ContentsOption_CH_Help == true then
      slot:SetShow(false)
      slotBG:SetShow(false)
    end
  end
  return true, columnCount, rowCount
end
function PaGlobal_SocialMenu:checkPrevSlot(index)
  if Panel_Chat_SocialMenu == nil then
    return false
  end
  for ii = 1, #self._classSlot do
    if self._classSlot[ii] == index then
      return true
    end
  end
  return false
end
function PaGlobal_SocialMenu:Description_Setting(index)
  if Panel_Chat_SocialMenu == nil then
    return
  end
  ToClient_getSocialActionInfoList()
  local socialActionInfo = ToClient_getSocialActionInfoByIndex(index)
  if socialActionInfo == nil then
    return
  end
  local sASS = socialActionInfo:getStaticStatus()
  local socialKey = socialActionInfo:getSocialActionKeyRaw()
  local allKeyword = socialActionInfo:getKeywordBuffer()
  local conditionGap = 0
  self._ui._name:SetText(sASS:getName())
  UI.setLimitTextAndAddTooltip(self._name)
  self._ui._icon:ChangeTextureInfoNameAsync("Icon/" .. sASS:getIconPath())
  self._ui._icon:addInputEvent("Mouse_LUp", "ToClient_requestStartSocialAction(" .. socialKey .. ")")
  if self._isSelectingCeremony == true then
    return
  end
  self._ui._conditionText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_CONDITIONTEXT") .. sASS:getConditionMessage())
  if socialActionInfo:getCommand() ~= nil then
    self._ui._edit_command:SetEditText(socialActionInfo:getCommand())
  end
  if "" ~= sASS:getConditionMessage() then
    if self._ui._conditionText:GetSizeY() < self._ui._conditionText:GetTextSizeY() then
      conditionGap = self._ui._conditionText:GetTextSizeY() + 10
    else
      conditionGap = 30
    end
  end
  self._ui._conditionText:SetShow(0 ~= conditionGap)
  if self._isSelectingCeremony == true then
    conditionGap = conditionGap + self._selectedAreaSizeY
  end
  Panel_Chat_SocialMenu:SetSize(Panel_Chat_SocialMenu:GetSizeX(), self._panelSizeY + conditionGap)
  self._ui._stc_mainBg:SetSize(self._ui._stc_mainBg:GetSizeX(), self._mainBgSizeY + conditionGap)
  self._ui._groupSocial:SetSize(self._ui._stc_mainBg:GetSizeX(), Panel_Chat_SocialMenu:GetSizeY() - self._ui._groupSocial:GetSpanSize().y)
  self._ui._groupSocial:ComputePos()
  self._ui._keyGuideBG:ComputePos()
  self._ui._keyTitle:SetPosY(self._keyTitlePosY + conditionGap)
  self._ui._edit_keyword_1:SetPosY(self._keywordPosY + conditionGap)
  self._ui._edit_keyword_2:SetPosY(self._keywordPosY + conditionGap)
  self._ui._edit_keyword_3:SetPosY(self._keywordPosY + conditionGap)
  self._ui._descArea:SetPosY(self._descPosY + conditionGap)
  self._ui._keyGuideBG:SetPosY(Panel_Chat_SocialMenu:GetSizeY())
  self._ui._btnApply:ComputePos()
  self._ui._btnReset:ComputePos()
  self._ui._btnCancel:ComputePos()
  local semicolonCount = 0
  local locationSemicolon = 0
  local stringStartIndex = 1
  local keyWord = {}
  while true do
    locationSemicolon = string.find(allKeyword, ";", locationSemicolon + 1)
    if locationSemicolon == nil then
      break
    end
    local string = string.sub(allKeyword, stringStartIndex, locationSemicolon - 1)
    if nil == string then
      string = ""
    end
    keyWord[semicolonCount] = string
    stringStartIndex = locationSemicolon + 1
    semicolonCount = semicolonCount + 1
  end
  if semicolonCount < 3 then
    local string = string.sub(allKeyword, stringStartIndex, string.len(allKeyword))
    if nil == string then
      string = ""
    end
    keyWord[semicolonCount] = string
  end
  if keyWord[0] == nil or keyWord[0] == "" then
    keyWord[0] = PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_KEYWORD_1")
  end
  if keyWord[1] == nil or keyWord[1] == "" then
    keyWord[1] = PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_KEYWORD_2")
  end
  if keyWord[2] == nil or keyWord[2] == "" then
    keyWord[2] = PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_KEYWORD_3")
  end
  self._ui._edit_keyword_1:SetEditText(keyWord[0])
  self._ui._edit_keyword_2:SetEditText(keyWord[1])
  self._ui._edit_keyword_3:SetEditText(keyWord[2])
  UI.setLimitTextAndAddTooltip(self._ui._name)
end
function PaGlobal_SocialMenu:getSlotByIndex(index)
  if Panel_Chat_SocialMenu == nil then
    return
  end
  if index <= #self._socialIconSlot then
    return self._socialIconSlot[index]
  end
  _PA_ASSERT_NAME(false, "\234\184\176\235\179\184 \236\134\140\236\133\156\236\149\161\236\133\152 \236\149\132\236\157\180\236\189\152\236\157\152 \235\178\148\236\156\132\235\165\188 \236\180\136\234\179\188\237\150\136\236\138\181\235\139\136\235\139\164.", "\236\160\149\236\152\129\236\164\128")
end
function PaGlobal_SocialMenu:makeClassSlotIndex()
  local slotCount = 1
  local socialIconCount = ToClient_getSocialActionInfoList()
  for index = 0, socialIconCount - 1 do
    if ToClient_checkClassTypeSocialAction(index) == true then
      self._classSlot[slotCount] = index
      slotCount = slotCount + 1
    end
  end
end
function PaGlobal_SocialMenu:updateButtonState()
  if Panel_Chat_SocialMenu == nil then
    return
  end
  local startIndex = self:setSocialAction()
  HandleClicked_SocialIcon(startIndex)
  self:Description_Setting(self._selectIndex)
end
function PaGlobal_SocialMenu_EndInputEvent_Command()
  PaGlobal_SocialMenu_EndInputEvent(0)
end
function PaGlobal_SocialMenu_EndInputEvent_Keyword_1()
  PaGlobal_SocialMenu_EndInputEvent(1)
end
function PaGlobal_SocialMenu_EndInputEvent_Keyword_2()
  PaGlobal_SocialMenu_EndInputEvent(2)
end
function PaGlobal_SocialMenu_EndInputEvent_Keyword_3()
  PaGlobal_SocialMenu_EndInputEvent(3)
end
function PaGlobal_SocialMenu_EndInputEvent(controlNo)
  local self = PaGlobal_SocialMenu
  if self == nil then
    return
  end
  local control
  if controlNo == 0 then
    control = self._ui._edit_command
  elseif controlNo == 1 then
    control = self._ui._edit_keyword_1
  elseif controlNo == 2 then
    control = self._ui._edit_keyword_2
  elseif controlNo == 3 then
    control = self._ui._edit_keyword_3
  else
    return
  end
  if control == nil then
    return
  end
  local isSafeWord = ToClient_checkToHaveProhibitedWord(control:GetEditText(), 0)
  if isSafeWord == false then
    if _ContentsOption_CH_GameType == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoInvalidWordForChina"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoInappropriateWord"))
    end
    self:Description_Setting(self._selectIndex)
  else
    HandleClicked_Apply()
  end
  ClearFocusEdit()
end
function HandleEventLUp_SocialMenu_ClickRadio(radioType)
  local self = PaGlobal_SocialMenu
  if self == nil then
    return
  end
  if radioType == nil then
    return
  end
  local saveCacheNumber
  if radioType == __eMaidActorSocialActionType_SelfPlayer then
    if self._isSelectingCeremony == true then
      return
    end
    saveCacheNumber = __eMaidActorSocialActionType_SelfPlayer
    self._ui._rdo_character:SetCheck(true)
  elseif radioType == __eMaidActorSocialActionType_MaidActor then
    saveCacheNumber = __eMaidActorSocialActionType_MaidActor
    self._ui._rdo_maidActor:SetCheck(true)
  elseif radioType == __eMaidActorSocialActionType_Together then
    saveCacheNumber = __eMaidActorSocialActionType_Together
    self._ui._rdo_together:SetCheck(true)
  else
    UI.ASSERT_NAME(false, "inputType\236\157\180 \235\185\132\236\160\149\236\131\129\236\157\180\235\139\164!", "\236\157\180\236\163\188")
  end
  if saveCacheNumber ~= nil then
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eMaidActorSocialActionType, saveCacheNumber, CppEnums.VariableStorageType.eVariableStorageType_User)
    local currSelectedIdx
    if self._selectIndex ~= nil and self._selectIndex > -1 then
      currSelectedIdx = self._selectIndex
    end
    if currSelectedIdx ~= nil then
      HandleClicked_SocialIcon(currSelectedIdx)
      self:Description_Setting(currSelectedIdx)
    end
  end
end
function HandleClicked_Button(number)
  local self = PaGlobal_SocialMenu
  if self == nil then
    return
  end
  if 0 == number then
    local socialActionInfo = ToClient_getSocialActionInfoByIndex(self._selectIndex)
    if socialActionInfo == nil then
      return
    end
    ToClient_resetSocialActionInfo(socialActionInfo:getStaticStatus())
  elseif 1 == number then
    if self._isSelectingCeremony == true then
      self:prepareClose()
      return
    end
    ShowModificationWarning(self._selectIndex, false)
    return
  end
  self:Description_Setting(self._selectIndex)
end
function HandleClicked_CloseSocialActionPanel()
  ToClient_cancelSocialActionInfo()
  FGlobal_SocialAction_ShowToggle()
  if false == CheckChattingInput() then
    ClearFocusEdit()
  end
end
function HandleClicked_Apply()
  local self = PaGlobal_SocialMenu
  if self == nil then
    return
  end
  local keyword_1 = self._ui._edit_keyword_1:GetEditText()
  local keyword_2 = self._ui._edit_keyword_2:GetEditText()
  local keyword_3 = self._ui._edit_keyword_3:GetEditText()
  local keyword1 = PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_KEYWORD_1")
  local keyword2 = PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_KEYWORD_2")
  local keyword3 = PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_KEYWORD_3")
  self._command = self._ui._edit_command:GetEditText()
  self._keywordValue = ""
  if keyword_1 ~= nil and keyword_1 ~= keyword1 then
    self._keywordValue = keyword_1
  end
  self._keywordValue = self._keywordValue .. ";"
  if keyword_2 ~= nil and keyword_2 ~= keyword2 then
    self._keywordValue = self._keywordValue .. keyword_2
  end
  self._keywordValue = self._keywordValue .. ";"
  if keyword_3 ~= nil and keyword_3 ~= keyword3 then
    self._keywordValue = self._keywordValue .. keyword_3
  end
  if _ContentsOption_CH_CheckProhibitedWord == true then
    self._keywordValue = self._keywordValue .. ";" .. self._command
    local result = ToClient_CheckChinaProhibitedWord(self._keywordValue, __eSceneIdSetSocialActionKeyword)
    if result == true then
      if _ContentsGroup_UsePadSnapping == true then
        Panel_Chat_SocialMenu:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      else
        self._ui._btnApply:SetIgnore(true)
      end
      self._ui._edit_command:RegistReturnKeyEvent("")
      self._ui._edit_keyword_1:RegistReturnKeyEvent("")
      self._ui._edit_keyword_2:RegistReturnKeyEvent("")
      self._ui._edit_keyword_3:RegistReturnKeyEvent("")
    end
    return
  end
  local socialActionInfo = ToClient_getSocialActionInfoByIndex(self._selectIndex)
  if nil == socialActionInfo then
    return
  end
  local sASS = socialActionInfo:getStaticStatus()
  if nil == sASS then
    return
  end
  self._socialActionKey = socialActionInfo:getSocialActionKeyRaw()
  applySocialActionInfoChanges()
end
function HandleClicked_ApplyCeremony()
  local self = PaGlobal_SocialMenu
  if self == nil then
    return
  end
  local socialActionInfo = ToClient_getSocialActionInfoByIndex(self._selectIndex)
  if socialActionInfo == nil then
    return
  end
  local sASS = socialActionInfo:getStaticStatus()
  if sASS == nil then
    return
  end
  self._socialActionKey = socialActionInfo:getSocialActionKeyRaw()
  if self._socialActionKey == nil then
    return
  end
  ToClient_SetInstanceContentsSocialActionKey(__eInstanceContentsType_Solare, true, self._socialActionKey)
end
function applySocialActionInfoChanges()
  local self = PaGlobal_SocialMenu
  if self == nil then
    return
  end
  if self._socialActionKey == nil then
    return
  end
  ToClient_setSocialActionCommand(self._socialActionKey, self._command)
  local isSuccess = ToClient_setSocialActionKeyword(self._socialActionKey, self._keywordValue)
  if isSuccess ~= nil and isSuccess == true then
    ToClient_applySocialActionInfo()
  end
  self:Description_Setting(self._selectIndex)
end
function HandleClicked_EditBox(editControlNo)
  local self = PaGlobal_SocialMenu
  if self == nil then
    return
  end
  if 0 == editControlNo then
    SetFocusEdit(self._ui._edit_command)
  elseif 1 == editControlNo then
    SetFocusEdit(self._ui._edit_keyword_1)
  elseif 2 == editControlNo then
    SetFocusEdit(self._ui._edit_keyword_2)
  elseif 3 == editControlNo then
    SetFocusEdit(self._ui._edit_keyword_3)
  end
end
function HandleClicked_SocialIcon(iconIndex)
  local self = PaGlobal_SocialMenu
  if self == nil then
    return
  end
  audioPostEvent_SystemUi(0, 0)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  if 0 <= self._selectIndex then
    self._socialIconSlot[self._selectIndex]:ResetVertexAni()
    self._socialIconSlot[self._selectIndex]:SetVertexAniRun("Ani_Color_Reset", true)
  end
  self._socialIconSlot[iconIndex]:ResetVertexAni()
  self._socialIconSlot[iconIndex]:SetVertexAniRun("Ani_Color", true)
  self._selectedSlotBG:SetPosX(self._socialIconSlotBG[iconIndex]:GetPosX())
  self._selectedSlotBG:SetPosY(self._socialIconSlotBG[iconIndex]:GetPosY())
  self._selectedSlotBG:SetShow(true)
  self:Description_Setting(iconIndex)
  HandleClicked_DoAction(iconIndex)
  self._selectIndex = iconIndex
end
function HandleClicked_DoAction(iconIndex)
  local socialActionInfo = ToClient_getSocialActionInfoByIndex(iconIndex)
  if socialActionInfo == nil then
    return
  end
  local sASS = socialActionInfo:getStaticStatus()
  if sASS == nil then
    return
  end
  local socialKey = socialActionInfo:getSocialActionKeyRaw()
  if self._isSelectingCeremony == false or ToClient_isUsableSocialAction(socialKey, false) == true then
    ToClient_requestStartSocialAction(socialKey)
  end
end
function HandleEventPressMove_SocialIcon_StartDrag(iconIndex)
  if MessageBoxGetShow() then
    return
  end
  local currentUIMode = GetUIMode()
  if currentUIMode == Defines.UIMode.eUIMode_Sequence or currentUIMode == Defines.UIMode.eUIMode_SequencePlayerControl then
    return
  end
  local socialActionInfo = ToClient_getSocialActionInfoByIndex(iconIndex)
  if socialActionInfo == nil then
    _PA_ASSERT_NAME(false, "socialActionInfo\235\165\188 \234\176\128\236\160\184\236\152\164\235\138\148\235\141\176 \236\139\164\237\140\168\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164.", "\236\160\149\236\152\129\236\164\128")
    return
  end
  local sASS = socialActionInfo:getStaticStatus()
  if sASS == nil then
    _PA_ASSERT_NAME(false, "socialActionInfo\236\157\152 StaticStatus\235\165\188 \234\176\128\236\160\184\236\152\164\235\138\148\235\141\176 \236\139\164\237\140\168\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164.", "\236\160\149\236\152\129\236\164\128")
    return
  end
  local socialActionKey = sASS:getKey()
  local socialIconPath = sASS:getIconPath()
  DragManager:setDragInfo(Panel_Chat_SocialMenu, nil, socialActionKey, "Icon/" .. socialIconPath, SocialAction_GroundClick, getSelfPlayer():getActorKey())
  QuickSlot_ShowBackGround()
end
function SocialAction_GroundClick(whereType, socialActionKey)
  DragManager:clearInfo()
end
function Show_Condition_SocialIcon(iconIndex, conditionCheck, slotType, slotNo, socialActionKey)
  local self = PaGlobal_SocialMenu
  if self == nil then
    return
  end
  if nil == iconIndex and nil == socialActionKey then
    TooltipSimple_Hide()
    return
  end
  local sASS
  if nil == socialActionKey then
    local socialActionInfo = ToClient_getSocialActionInfoByIndex(iconIndex)
    if nil == socialActionInfo then
      _PA_ASSERT_NAME(false, "socialActionInfo\235\165\188 \234\176\128\236\160\184\236\152\164\235\138\148\235\141\176 \236\139\164\237\140\168\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164.", "\236\160\149\236\152\129\236\164\128")
      return
    end
    sASS = socialActionInfo:getStaticStatus()
    if nil == sASS then
      _PA_ASSERT_NAME(false, "socialActionInfo\236\157\152 StaticStatus\235\165\188 \234\176\128\236\160\184\236\152\164\235\138\148\235\141\176 \236\139\164\237\140\168\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164.", "\236\160\149\236\152\129\236\164\128")
      return
    end
  else
    sASS = ToClient_getSocialActionStaticStatusByKey(socialActionKey)
    if nil == sASS then
      _PA_ASSERT_NAME(false, "socialActionKey\235\165\188 \236\130\172\236\154\169\237\149\152\236\151\172 StaticStatus\235\165\188 \234\176\128\236\160\184\236\152\164\235\138\148\235\141\176 \236\139\164\237\140\168\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164.", "\236\160\149\236\152\129\236\164\128")
      return
    end
  end
  if true == conditionCheck then
    local name = sASS:getName()
    if slotType == "QuickSlot" then
      local socialActionQuickSlot = PaGlobal_QuickSlot:getSlotByIndex(slotNo + 1)
      if socialActionQuickSlot.slotType ~= __eQuickSlotDataType_SocialAction then
        return
      end
      TooltipSimple_Show(socialActionQuickSlot.socialAction, name)
    elseif slotType == "SkillGroupQuickSlot" then
      local socialActionSkillGroupQuickSlot = PaGlobal_SkillGroup_QuickSlot._slots[slotNo]
      if socialActionSkillGroupQuickSlot.slotType ~= __eQuickSlotDataType_SocialAction then
        return
      end
      TooltipSimple_Show(socialActionSkillGroupQuickSlot.socialAction, name)
    elseif slotType == "NewQuickSlot" then
      local socialActionNewQuickSlot = PaGlobal_NewQuickSlot:getSlotByIndex(slotNo).socialAction
      if nil == socialActionNewQuickSlot then
        return
      end
      TooltipSimple_Show(socialActionNewQuickSlot, name)
    else
      TooltipSimple_Show(self._socialIconSlot[iconIndex], name)
    end
  else
    local conditionText = sASS:getConditionMessage()
    if "" == conditionText then
      return
    end
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_CONDITIONTEXT")
    TooltipSimple_Show(self._socialIconSlot[iconIndex], name, conditionText)
  end
end
function FGlobal_SocialAction_GetShow()
  if Panel_Chat_SocialMenu == nil then
    return false
  end
  return Panel_Chat_SocialMenu:GetShow()
end
function FGlobal_SocialAction_Ceremony_ShowToggle()
  local self = PaGlobal_SocialMenu
  if self == nil then
    return
  end
  self._isSelectingCeremony = _ContentsGroup_SolareCeremony == true and true
  FGlobal_SocialAction_ShowToggle()
end
function FGlobal_SocialAction_ShowToggle()
  local self = PaGlobal_SocialMenu
  if self == nil then
    return
  end
  PaGlobal_SocialMenu._ui._groupApplyCeremony:SetShow(false)
  if Panel_Chat_SocialMenu:GetShow() then
    self:prepareClose()
    return false
  elseif Panel_Chatting_Macro:IsShow() then
    Panel_Chatting_Macro:SetShow(false, false)
    self:prepareOpen()
    return true
  else
    audioPostEvent_SystemUi(1, 0)
    _AudioPostEvent_SystemUiForXBOX(1, 0)
    self:prepareOpen()
    return true
  end
  return false
end
function PaGlobal_Solare_CeremonyAction_Open()
  if FGlobal_SocialAction_Ceremony_ShowToggle == nil then
    return
  end
  FGlobal_SocialAction_Ceremony_ShowToggle()
end
function FromClient_CheckChinaProhibitedWord_SetSocialActionKeyword(isPass, filteredText)
  if _ContentsOption_CH_CheckProhibitedWord == false then
    return
  end
  local self = PaGlobal_SocialMenu
  if self == nil then
    return
  end
  if _ContentsGroup_UsePadSnapping == true then
    Panel_Chat_SocialMenu:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleClicked_Apply()")
  else
    self._ui._btnApply:SetIgnore(false)
  end
  self._ui._edit_command:RegistReturnKeyEvent("PaGlobal_SocialMenu_EndInputEvent_Command()")
  self._ui._edit_keyword_1:RegistReturnKeyEvent("PaGlobal_SocialMenu_EndInputEvent_Keyword_1()")
  self._ui._edit_keyword_2:RegistReturnKeyEvent("PaGlobal_SocialMenu_EndInputEvent_Keyword_2()")
  self._ui._edit_keyword_3:RegistReturnKeyEvent("PaGlobal_SocialMenu_EndInputEvent_Keyword_3()")
  if isPass == true then
    local filteredTextArray = string.split(filteredText, ";")
    local keyWordValue = ""
    local command = ""
    if filteredTextArray[1] ~= nil then
      keyWordValue = filteredTextArray[1]
      for i = 2, 3 do
        if filteredTextArray[i] ~= nil and filteredTextArray[i] ~= "" then
          keyWordValue = keyWordValue .. ";" .. filteredTextArray[i]
        end
      end
    end
    if filteredTextArray[#filteredTextArray] ~= nil then
      command = filteredTextArray[#filteredTextArray]
    end
    local socialActionInfo = ToClient_getSocialActionInfoByIndex(self._selectIndex)
    if nil == socialActionInfo then
      return
    end
    local sASS = socialActionInfo:getStaticStatus()
    if nil == sASS then
      return
    end
    ToClient_setSocialActionCommand(sASS:getKey(), command)
    local isSuccess = ToClient_setSocialActionKeyword(sASS:getKey(), keyWordValue)
    if isSuccess ~= nil and isSuccess == true then
      ToClient_applySocialActionInfo()
    end
    self:Description_Setting(self._selectIndex)
  end
end
local iconIndexToChange = -1
function ShowModificationWarning(iconIndex, isClickedIcon)
  DragManager:clearInfo()
  local self = PaGlobal_SocialMenu
  if self == nil then
    return
  end
  if isClickedIcon == true and iconIndex == self._selectIndex then
    return
  end
  local socialIconCount = ToClient_getSocialActionInfoList()
  if socialIconCount == 0 or iconIndex >= socialIconCount then
    return
  end
  local socialActionInfo = ToClient_getSocialActionInfoByIndex(self._selectIndex)
  if socialActionInfo == nil then
    return
  end
  local sASS = socialActionInfo:getStaticStatus()
  if sASS == nil then
    return
  end
  if isClickedIcon == true then
    iconIndexToChange = iconIndex
  else
    iconIndexToChange = -1
  end
  if self._isSelectingCeremony == true then
    if iconIndexToChange == -1 then
      iconIndexToChange = 0
    end
    HandleClicked_SocialIcon(iconIndexToChange)
    return
  end
  self._command = self._ui._edit_command:GetEditText()
  self._keywordValue = ""
  self._socialActionKey = socialActionInfo:getSocialActionKeyRaw()
  local keyword_1 = self._ui._edit_keyword_1:GetEditText()
  local keyword_2 = self._ui._edit_keyword_2:GetEditText()
  local keyword_3 = self._ui._edit_keyword_3:GetEditText()
  local keyWordValue = ""
  local keyword1 = PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_KEYWORD_1")
  local keyword2 = PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_KEYWORD_2")
  local keyword3 = PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_KEYWORD_3")
  if keyword_1 ~= nil and keyword_1 ~= keyword1 then
    self._keywordValue = keyword_1
  end
  self._keywordValue = self._keywordValue .. ";"
  if keyword_2 ~= nil and keyword_2 ~= keyword2 then
    self._keywordValue = self._keywordValue .. keyword_2
  end
  self._keywordValue = self._keywordValue .. ";"
  if keyword_3 ~= nil and keyword_3 ~= keyword3 then
    self._keywordValue = self._keywordValue .. keyword_3
  end
  if ToClient_getIsSocialActionDataModified(self._socialActionKey, self._command, self._keywordValue) == false then
    if isClickedIcon == true then
      HandleClicked_MessageBoxNo()
      return
    end
    HandleClicked_CloseSocialActionPanel()
    return
  end
  ClearFocusEdit()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_SAVE_CONFIRM"),
    functionYes = HandleClicked_MessageBoxYes,
    functionNo = HandleClicked_MessageBoxNo,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleClicked_MessageBoxYes()
  applySocialActionInfoChanges()
  if iconIndexToChange < 0 then
    HandleClicked_CloseSocialActionPanel()
    return
  end
  HandleClicked_SocialIcon(iconIndexToChange)
end
function HandleClicked_MessageBoxNo()
  ToClient_cancelSocialActionInfo()
  if iconIndexToChange < 0 then
    HandleClicked_CloseSocialActionPanel()
    return
  end
  HandleClicked_SocialIcon(iconIndexToChange)
end
