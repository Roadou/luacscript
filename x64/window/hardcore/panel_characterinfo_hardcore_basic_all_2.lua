function PaGlobal_CharacterInfo_HardCore_Basic_ShowAni()
  if PaGlobal_CharacterInfo_HardCore_Basic == nil then
    return
  end
end
function PaGlobal_CharacterInfo_HardCore_Basic_HideAni()
  if PaGlobal_CharacterInfo_HardCore_Basic == nil then
    return
  end
end
function PaGlobal_CharacterInfo_HardCore_Basic_Open()
  if PaGlobal_CharacterInfo_HardCore_Basic == nil then
    return
  end
  PaGlobal_CharacterInfo_HardCore_Basic:prepareOpen()
end
function PaGlobal_CharacterInfo_HardCore_Basic_Close()
  if PaGlobal_CharacterInfo_HardCore_Basic == nil then
    return
  end
  PaGlobal_CharacterInfo_HardCore_Basic:prepareClose()
end
function PaGlobal_CharacterInfo_HardCore_Basic_Update()
  if PaGlobal_CharacterInfo_HardCore_Basic == nil then
    return
  end
  local self = PaGlobal_CharacterInfo_HardCore_Basic
  self:update()
end
function HandleEventOnOut_CharInfoBasic_HardCore_EnchantStack(isShow)
  local self = PaGlobal_CharacterInfo_HardCore_Basic
  local index = PaGlobal_CharacterInfo_HardCore_All._HARDCORE_CHARACTERINFO_TABINDEX._basic
  if self == nil or PaGlobalFunc_ChracterInfo_HardCore_GetBgShow(index) == false or isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc, isValksItemCheck
  control = self._ui.stc_EnchantStackIcon
  ToClient_RequestCharacterEnchantFailCount()
  local defaultCount = self._selfPlayer:get():getEnchantFailCount()
  local valksCount = self._selfPlayer:get():getEnchantValuePackCount()
  local familyCount = getEnchantInformation():ToClient_getBonusStackCount()
  local isValksItem = ToClient_IsContentsGroupOpen("47")
  if isValksItem == false then
    isValksItemCheck = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ENCHANTCOUNT_TOOLTIP_ADDCOUNT_NONE", "defaultCount", tostring(defaultCount))
  else
    isValksItemCheck = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ENCHANTCOUNT_TOOLTIP", "defaultCount", tostring(defaultCount), "valksCount", tostring(valksCount), "familyCount", tostring(familyCount))
  end
  name = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NORMALSTACK_TOOLTIP_NAME")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NORMALSTACK_TOOLTIP_DESC") .. isValksItemCheck
  if control == nil then
    UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_EnchantStack() /  control is nil", "-")
    return
  end
  TooltipSimple_Show(control, name, desc, self._ui.stc_EnchantStackIcon)
end
function HandleEventLUp_CharInfoBasic_HardCore_All_TakePhoto()
  local index = PaGlobal_CharacterInfo_HardCore_All._HARDCORE_CHARACTERINFO_TABINDEX._basic
  if false == PaGlobalFunc_ChracterInfo_HardCore_GetBgShow(index) then
    return
  end
  HandleEventOnOut_CharInfoBasic_HardCore_EnchantStack(false)
  FGlobal_InGameCustomize_SetCharacterInfo(true)
  IngameCustomize_Show()
end
function HandleEventOnOut_CharInfoBasic_HardCore_All_FacePhoto(isShow)
  local index = PaGlobal_CharacterInfo_HardCore_All._HARDCORE_CHARACTERINFO_TABINDEX._basic
  if false == PaGlobalFunc_ChracterInfo_HardCore_GetBgShow(index) or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc, icon
  name = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_FACEPHOTO_TOOLTIP_NAME")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_FACEPHOTO_TOOLTIP_DESC")
  control = PaGlobal_CharacterInfo_HardCore_Basic._ui.btn_FacePhoto
  icon = UI.getChildControl(PaGlobal_CharacterInfo_HardCore_Basic._ui.btn_FacePhoto, "Static_CameraIcon")
  if nil == control then
    UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_FacePhoto() /  control is nil", "-")
    return
  end
  TooltipSimple_Show(control, name, desc, icon)
end
function HandleEventOnOut_CharInfoBasic_HardCore_All_BasicStat(isShow, tipType)
  local index = PaGlobal_CharacterInfo_HardCore_All._HARDCORE_CHARACTERINFO_TABINDEX._basic
  if PaGlobalFunc_ChracterInfo_HardCore_GetBgShow(index) == false or isShow == false or tipType == nil then
    TooltipSimple_Hide()
    return
  end
  local control, name
  if 0 == tipType then
    control = PaGlobal_CharacterInfo_HardCore_Basic._ui.txt_HpTitle
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_HPREGEN") .. " : " .. tostring(PaGlobal_CharInfoBasic_All._selfPlayer:get():getRegenHp())
  elseif 1 == tipType then
    control = PaGlobal_CharacterInfo_HardCore_Basic._ui.txt_MpTitle
    name = PaGlobal_CharInfo_All:setMpTooltipByClass()
  else
    control = PaGlobal_CharacterInfo_HardCore_Basic._ui.txt_LTTitle
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_WEIGHT_TOOLTIP")
  end
  if nil == control then
    UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfoBasic_All_2.lua / HandleEventOnOut_CharInfoBasic_All_Regist() /  control is nil", "-")
    return
  end
  TooltipSimple_Show(control, name, "")
end
function HandleEventOnOut_CharInfoBasic_HardCore_All_Potential(isShow, tipType)
  local index = PaGlobal_CharacterInfo_HardCore_All._HARDCORE_CHARACTERINFO_TABINDEX._basic
  if PaGlobalFunc_ChracterInfo_HardCore_GetBgShow(index) == false or isShow == false or tipType == nil then
    TooltipSimple_Hide()
    return
  end
  if PaGlobal_CharacterInfo_HardCore_Basic._potentialData[tipType].title == nil then
    UI.ASSERT_NAME(nil ~= PaGlobal_CharacterInfo_HardCore_Basic._potentialData[tipType], " Panel_CharacterInfo_HardCore_Basic_All_2.lua / HandleEventOnOut_CharInfoBasic_HardCore_All_Potential() /  PaGlobal_CharacterInfo_HardCore_All._potentialData[" .. tostring(tipType) .. "potenIdx'] is nil", "-")
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  control = PaGlobal_CharacterInfo_HardCore_Basic._potentialData[tipType].title
  name = PaGlobal_CharacterInfo_HardCore_Basic._potentialData[tipType].title:GetText()
  desc = PaGlobal_CharacterInfo_HardCore_Basic._potentialData[tipType].toolTipDesc
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_CharInfoBasic_HardCore_All_ShowAtkTypeTooltip(isShow)
  local index = PaGlobal_CharacterInfo_HardCore_All._HARDCORE_CHARACTERINFO_TABINDEX._basic
  if PaGlobalFunc_ChracterInfo_HardCore_GetBgShow(index) == false or isShow == false then
    TooltipSimple_Hide()
    return
  end
  local string = {
    "LUA_CHARACTERINFO_TXT_REGIST_ATKTYPE_TOOLTIP_NAME",
    "LUA_CHARACTERINFO_TXT_REGIST_ATKTYPE_TOOLTIP_DESC"
  }
  if true == _ContentsOption_CH_GameType then
    string = {
      "LUA_CHARACTERINFO_TXT_REGIST_ATKTYPE_TOOLTIP_NAME",
      "LUA_ATKTYPE_TOOLTIP_DESC_CH"
    }
  end
  local name = PAGetString(Defines.StringSheet_GAME, string[1])
  local desc = PAGetString(Defines.StringSheet_GAME, string[2])
  local control = PaGlobal_CharacterInfo_HardCore_Basic._ui.txt_AtkTypeTitle
  if nil == control then
    UI.ASSERT_NAME(nil ~= control, " Panel_CharacterInfo_HardCore_Basic_All_2.lua / HandleEventOnOut_CharInfoBasic_HardCore_All_ShowAtkTypeTooltip() /  control is nil", "-")
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function FromClient_CharInfoTitle_HardCore_List2Update(content, key)
  local key32 = Int64toInt32(key)
  local name = ToClient_getHardCoreTitleNameByKey(key32)
  local rdo_name = UI.getChildControl(content, "RadioButton_TilteName")
  local chkBox = UI.getChildControl(rdo_name, "CheckButton_1")
  rdo_name:setNotImpactScrollEvent(true)
  rdo_name:SetText(name)
  rdo_name:SetCheck(false)
  chkBox:SetShow(false)
  local isAcquired = ToClient_isAcquiredHardCoreTitle(key32)
  local fontColor = ToClient_GetHardCoreTitleGradeColor(key32)
  content:EraseAllEffect()
  content:setNotImpactScrollEvent(true)
  ToClient_insertNewTitleUI(key32, content)
  if rdo_name:GetTextSizeX() + 25 > content:GetSizeX() - 25 then
    rdo_name:SetIgnore(false)
    UI.setLimitTextAndAddTooltip(rdo_name)
  end
  if isAcquired == true then
    rdo_name:SetFontColor(fontColor)
  end
  rdo_name:SetMonoTone(not isAcquired, not isAcquired)
  rdo_name:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoTitle_HardCore_SelectTitle(" .. key32 .. ")")
end
function HandleEventLUp_CharInfoTitle_HardCore_SelectTitle(key32)
  if nil == key32 then
    return
  end
  PaGlobal_CharacterInfo_HardCore_Basic:setTitleText(key32)
end
function PaGlobal_CharacterInfo_HardCore_Basic_UpdateTitleList()
  if PaGlobal_CharacterInfo_HardCore_Basic == nil then
    return
  end
  local self = PaGlobal_CharacterInfo_HardCore_Basic
  self:updateTitleList()
end
