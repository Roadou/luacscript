function PaGlobalFunc_PartyRecruite_All_Open(isGuildParty)
  PaGlobal_PartyRecruite_All:prepareOpen(isGuildParty)
end
function PaGlobalFunc_PartyRecruite_All_Close()
  PaGlobal_PartyRecruite_All:prepareClose()
end
function PaGlobalFunc_PartyRecruite_All_GetShow()
  if nil == Panel_PartyRecruite_All then
    return false
  end
  return Panel_PartyRecruite_All:GetShow()
end
function HandleEventLUp_PartyRecruite_All_TextSet()
  if nil == Panel_PartyRecruite_All then
    return
  end
  local msg = PaGlobal_PartyRecruite_All._ui.edit_adDesc:GetEditText()
  local baseText = PAGetString(Defines.StringSheet_GAME, "LUA_PARTYLISTRECRUITE_DEFALUTTEXT")
  if baseText == msg then
    PaGlobal_PartyRecruite_All._ui.edit_adDesc:SetEditText("")
  end
  SetFocusEdit(PaGlobal_PartyRecruite_All._ui.edit_adDesc)
end
function PadEventXUp_PartyRecruite_All_Edit()
  if nil == Panel_PartyRecruite_All then
    return
  end
  if true == PaGlobal_PartyRecruite_All._ui.edit_adDesc:GetFocusEdit() then
    ClearFocusEdit()
  else
    SetFocusEdit(PaGlobal_PartyRecruite_All._ui.edit_adDesc)
    PaGlobal_PartyRecruite_All._ui.edit_adDesc:SetEditText("")
  end
end
function HandleEventLUp_PartyRecruite_All_Request()
  if nil == Panel_PartyRecruite_All then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    Panel_NumberPad_Close()
  end
  if Panel_NumberPad_IsPopUp() == true then
    return
  end
  local msg = PaGlobal_PartyRecruite_All._ui.edit_adDesc:GetEditText()
  local baseText = PAGetString(Defines.StringSheet_GAME, "LUA_PARTYLISTRECRUITE_DEFALUTTEXT")
  if "" == msg or baseText == msg then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PARTYLISTRECRUITE_REGISTALERT"))
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoingAlterOfBlood"))
    return
  end
  if true == _ContentsGroup_PersonalField then
    if ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_PersonalField) == true or ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_PersonalRelayField) == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotPossibleInvitationParty"))
      return
    end
    if false == ToClient_CheckMirrorFieldDelayTime(true) then
      return
    end
  end
  local isLargeParty = PaGlobal_PartyRecruite_All._ui.rdo_PartyLarge:IsCheck()
  local partyType = CppEnums.PartyType.ePartyType_Normal
  local maxMember = 5
  if true == isLargeParty then
    maxMember = 20
    partyType = CppEnums.PartyType.ePartyType_Large
  end
  ToClient_RequestPartyRecruitment(msg, PaGlobal_PartyRecruite_All._selectLevel, PaGlobal_PartyRecruite_All._selectOffence, PaGlobal_PartyRecruite_All._selectDeffence, maxMember, partyType, PaGlobal_PartyRecruite_All._isGuildParty)
  PaGlobalFunc_PartyRecruite_All_Close()
end
function PaGlobalFunc_PartyRecruite_All_LevelChange()
  if nil == Panel_PartyRecruite_All then
    return
  end
  local setLevel = function(inputNum)
    inputNum = Int64toInt32(inputNum)
    PaGlobal_PartyRecruite_All._ui.stc_level:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PARTYLISTRECRUITE_MINLEVEL", "level", tostring(inputNum)))
    if PaGlobal_PartyRecruite_All._maxLevel == inputNum then
      local levelText = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_LEVELFILTER") .. " " .. inputNum
      PaGlobal_PartyRecruite_All._ui.stc_level:SetText(levelText)
    end
    PaGlobal_PartyRecruite_All._selectLevel = inputNum
  end
  Panel_NumberPad_Show(true, PaGlobal_PartyRecruite_All._maxLevel, 0, setLevel)
end
function PaGlobalFunc_PartyRecruite_All_OffenceChange()
  if nil == Panel_PartyRecruite_All then
    return
  end
  local setOffence = function(inputNum)
    inputNum = Int64toInt32(inputNum)
    PaGlobal_PartyRecruite_All._ui.stc_offence:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PARTYLISTRECRUITE_MINOFFENCE", "offence", tostring(inputNum)))
    if PaGlobal_PartyRecruite_All._maxOffence == inputNum then
      local levelText = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_LEVELFILTER") .. " " .. inputNum
      PaGlobal_PartyRecruite_All._ui.stc_offence:SetText(levelText)
    end
    PaGlobal_PartyRecruite_All._selectOffence = inputNum
  end
  Panel_NumberPad_Show(true, PaGlobal_PartyRecruite_All._maxOffence, 0, setOffence)
end
function PaGlobalFunc_PartyRecruite_All_DefenceChange()
  if nil == Panel_PartyRecruite_All then
    return
  end
  local setDefence = function(inputNum)
    inputNum = Int64toInt32(inputNum)
    PaGlobal_PartyRecruite_All._ui.stc_defence:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PARTYLISTRECRUITE_MINDEFENCE", "defence", tostring(inputNum)))
    if PaGlobal_PartyRecruite_All._maxDefence == inputNum then
      local levelText = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_LEVELFILTER") .. " " .. inputNum
      PaGlobal_PartyRecruite_All._ui.stc_defence:SetText(levelText)
    end
    PaGlobal_PartyRecruite_All._selectDeffence = inputNum
  end
  Panel_NumberPad_Show(true, PaGlobal_PartyRecruite_All._maxDefence, 0, setDefence)
end
function PadEventDpad_PartyRecruite_All_SetLevel(value)
  if nil == Panel_PartyRecruite_All then
    return
  end
  ToClient_padSnapResetControl()
  if 0 >= PaGlobal_PartyRecruite_All._selectLevel + value then
    return
  end
  local maxLevel32 = Int64toInt32(PaGlobal_PartyRecruite_All._maxLevel)
  if maxLevel32 < PaGlobal_PartyRecruite_All._selectLevel + value then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(51, 4)
  PaGlobal_PartyRecruite_All._selectLevel = PaGlobal_PartyRecruite_All._selectLevel + value
  PaGlobal_PartyRecruite_All._ui.stc_level:SetText(tostring(PaGlobal_PartyRecruite_All._selectLevel))
end
function PaGlobalFunc_PartyRecruite_All_OnVirtualKeyboardEnd(str)
  if nil == Panel_PartyRecruite_All then
    return
  end
  if PaGlobal_PartyRecruite_All._MAXINPUTSIZE < getWstringLength(str) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrInputTooLong"))
    str = getMaxSliceString(str, PaGlobal_PartyRecruite_All._MAXINPUTSIZE)
  end
  PaGlobal_PartyRecruite_All._ui.edit_adDesc:SetEditText(str)
  ClearFocusEdit()
end
function FromClient_PartyRecruite_All_Resize()
  if nil == Panel_PartyRecruite_All then
    return
  end
  PaGlobal_PartyRecruite_All:resize()
end
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_PSFT = CppEnums.PAUI_SHOW_FADE_TYPE
local UI_color = Defines.Color
function PaGlobalFunc_PartyRecruite_All_ShowAni()
  if nil == Panel_PartyRecruite_All then
    return
  end
  UIAni.fadeInSCR_Down(Panel_PartyRecruite_All)
  local aniInfo1 = Panel_PartyRecruite_All:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_PartyRecruite_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_PartyRecruite_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_PartyRecruite_All:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_PartyRecruite_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_PartyRecruite_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobalFunc_PartyRecruite_All_HideAni()
  if nil == Panel_PartyRecruite_All then
    return
  end
  Panel_PartyRecruite_All:SetShowWithFade(UI_PSFT.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_PartyRecruite_All:addColorAnimation(0, 0.25, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function PaGlobalFunc_PartyRecruite_All_CheckUiEdit(targetUI)
  if nil == Panel_PartyRecruite_All then
    return false
  end
  if nil == targetUI then
    return false
  end
  if false == Panel_PartyRecruite_All:GetShow() then
    return
  end
  return targetUI:GetKey() == PaGlobal_PartyRecruite_All._ui.edit_adDesc:GetKey()
end
function PaGlobalFunc_PartyRecruite_All_OffDefToolTip(type, isShow)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control
  if type == "off" then
    control = PaGlobal_PartyRecruite_All._ui.stc_offence
  elseif type == "def" then
    control = PaGlobal_PartyRecruite_All._ui.stc_defence
  else
    return
  end
  TooltipSimple_Show(control, PAGetString(Defines.StringSheet_GAME, "LUA_PARTYLIST_ATKDEF_TITLE_TOOLTIP"), PAGetString(Defines.StringSheet_GAME, "LUA_PARTYLIST_ATKDEF_TITLE_TOOLTIP_DESC"))
end
