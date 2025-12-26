local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_PSFT = CppEnums.PAUI_SHOW_FADE_TYPE
local UI_color = Defines.Color
local UI_BUFFTYPE = CppEnums.UserChargeType
Panel_SelfPlayerExpGage:SetShow(not PaGlobalFunc_IsRemasterUIOption(), false)
Panel_SelfPlayerExpGage:SetIgnore(true)
Panel_SelfPlayerExpGage:ActiveMouseEventEffect(false)
Panel_SelfPlayerExpGage:RegisterShowEventFunc(true, "SelfPlayerExpGageShowAni()")
Panel_SelfPlayerExpGage:RegisterShowEventFunc(false, "SelfPlayerExpGageHideAni()")
local _defaultEventExp = 1000000
local _initCheck = false
local _levelBG = UI.getChildControl(Panel_SelfPlayerExpGage, "Static_LevelBG")
local expGageBG = UI.getChildControl(Panel_SelfPlayerExpGage, "Static_SelfPlayerExpBG")
local expGage = UI.getChildControl(Panel_SelfPlayerExpGage, "Progress2_ExpGage")
local _expHead = UI.getChildControl(expGage, "Progress2_ExpGage_Head")
local staticLevelBg = UI.getChildControl(Panel_SelfPlayerExpGage, "Static_LevelBG")
local _staticLevel = UI.getChildControl(Panel_SelfPlayerExpGage, "StaticText_Level")
local _staticLevelSub = UI.getChildControl(Panel_SelfPlayerExpGage, "StaticText_Level_Sub")
local _staticLvText = UI.getChildControl(Panel_SelfPlayerExpGage, "StaticText_LVTXT")
local expText = UI.getChildControl(Panel_SelfPlayerExpGage, "StaticText_EXPText")
local _skillGaugeBG = UI.getChildControl(Panel_SelfPlayerExpGage, "Static_SkillGauge_BG")
local _staticSkillExp = UI.getChildControl(Panel_SelfPlayerExpGage, "CircularProgress_SkillExp")
local _staticSkillExp_Head = UI.getChildControl(_staticSkillExp, "Progress2_1_Bar_Head")
local _staticSkillPoint = UI.getChildControl(Panel_SelfPlayerExpGage, "StaticText_Sp")
local _txt_DefenceInfo = UI.getChildControl(Panel_SelfPlayerExpGage, "StaticText_DefenceInfo")
local _stc_skillLearnGuideTail = UI.getChildControl(_staticSkillPoint, "Static_Bubble_Tail_Console")
local _stc_skillLearnGuideBG = UI.getChildControl(_stc_skillLearnGuideTail, "Static_blackBubble")
local _txt_skillLearnGuide = UI.getChildControl(_stc_skillLearnGuideBG, "StaticText_Desc_New")
_txt_skillLearnGuide:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLRESET_GUIDE_NOTICE"))
_txt_skillLearnGuide:SetSize(_txt_skillLearnGuide:GetTextSizeX() + 5, _txt_skillLearnGuide:GetTextSizeY())
_stc_skillLearnGuideBG:SetSize(_txt_skillLearnGuide:GetSizeX() + 20, _txt_skillLearnGuide:GetSizeY() + 10)
_stc_skillLearnGuideTail:SetShow(false)
local _wpGaugeBG = UI.getChildControl(Panel_SelfPlayerExpGage, "Static_WP_BG")
local _Wp = UI.getChildControl(Panel_SelfPlayerExpGage, "StaticText_WP")
local _Wp_Main = UI.getChildControl(Panel_SelfPlayerExpGage, "StaticText_WP_Main")
local _wpGauge = UI.getChildControl(Panel_SelfPlayerExpGage, "Progress2_WP")
local _wpGauge_Head = UI.getChildControl(_wpGauge, "Progress2_1_Bar_Head")
local _WpHelpMSG = UI.getChildControl(Panel_SelfPlayerExpGage, "StaticText_WPHelp")
local _contribute_BG = UI.getChildControl(Panel_SelfPlayerExpGage, "Static_Contribute_BG")
local _contribute_progress = UI.getChildControl(Panel_SelfPlayerExpGage, "Progress_Contribute")
local _contribute_progress_Head = UI.getChildControl(_contribute_progress, "Progress2_1_Bar_Head")
local _contribute_txt = UI.getChildControl(Panel_SelfPlayerExpGage, "StaticText_ContributeP")
local _contribute_Main = UI.getChildControl(Panel_SelfPlayerExpGage, "StaticText_Contribute_Main")
local _contribute_helpMsg = UI.getChildControl(Panel_SelfPlayerExpGage, "StaticText_ContributeHelpMsg")
local _contribute_Icon = UI.getChildControl(Panel_SelfPlayerExpGage, "StaticText_ContributeP")
local _close_ExpGauge = UI.getChildControl(Panel_SelfPlayerExpGage, "Button_Win_Close")
local _txt_BubbleAlert = UI.getChildControl(Panel_SelfPlayerExpGage, "StaticText_BubbleAlert")
local _stc_HardCorePoint = UI.getChildControl(Panel_SelfPlayerExpGage, "StaticText_HardcorePoint")
local localNodeName
local localNodeInvestment = false
local pcRoomRate = 0
local pcRoomNeedTime = ToClient_GetPcRoomUserHomeBuffLimitTime()
local needTime = 0
local useTime = 0
local _defaultSkillPoint = 56
local _oldCharacter = false
local _levelUpQuestClear = false
local defaultSkillPointMainSpanX = 240
local initPosX = Panel_SelfPlayerExpGage:GetPosX()
local initPosY = Panel_SelfPlayerExpGage:GetPosY()
_close_ExpGauge:SetShow(false)
_txt_BubbleAlert:SetShow(false)
_Wp:SetIgnore(false)
_WpHelpMSG:SetAlpha(0)
_WpHelpMSG:SetFontAlpha(0)
function panel_ExpGauge_unRenderInInstacne()
  if nil == Panel_SelfPlayerExpGage then
    _PA_ASSERT_NAME(false, "Panel_SelfPlayerExpGage\236\157\180 nil \236\158\133\235\139\136\235\139\164.", "\234\176\156\235\176\156\236\158\144")
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local bHide = false
  local hideCondition = {
    ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing),
    ToClient_IsRemoteInstallMode()
  }
  for k, v in ipairs(hideCondition) do
    if true == v then
      bHide = true
    end
  end
  if true == bHide then
    Panel_SelfPlayerExpGage:SetRenderAndEventHide(true)
  else
    Panel_SelfPlayerExpGage:SetRenderAndEventHide(false)
  end
end
function SelfPlayerExpGageShowAni()
  UIAni.AlphaAnimation(1, Panel_SelfPlayerExpGage, 0, 0.2)
end
function SelfPlayerExpGageHideAni()
  local aniInfo = UIAni.AlphaAnimation(0, Panel_SelfPlayerExpGage, 0, 0.2)
  aniInfo:SetHideAtEnd(true)
end
function Panel_SelfPlayerExpGage_onScreenResize()
  local sizeX = getScreenSizeX()
  expGageBG:SetSize(sizeX, 4)
  expGage:SetSize(sizeX, 4)
  expGage:SetProgressRate(0)
  FGlobal_PackageIconUpdate()
  ExpGauge_CharacterInfoUpdate_Reload()
end
local _selfExpSimpleUI_MouseOver = false
function SelfExp_MouseOver(isOver)
  if not getEnableSimpleUI() then
    return
  end
  SelfExp_MouseOver_Force(isOver)
end
function SelfExp_MouseOver_Force(isOver)
  _selfExpSimpleUI_MouseOver = isOver
end
function SelfExp_MouseOver_Force_Over()
  SelfExp_MouseOver_Force(false)
end
function SelfExp_MouseOver_Force_Out()
  _levelBG:SetShow(true)
  _skillGaugeBG:SetShow(false)
  _skillGaugeBG:SetAlpha(1)
  _staticSkillExp:SetShow(false)
  _staticSkillExp:SetAlpha(1)
  _staticSkillExp_Head:SetShow(false)
  _staticSkillExp_Head:SetAlpha(1)
  _staticSkillPoint:SetShow(true)
  _staticSkillPoint:SetFontAlpha(1)
  _txt_DefenceInfo:SetShow(true)
  _txt_DefenceInfo:SetFontAlpha(1)
  _wpGaugeBG:SetShow(true)
  _wpGaugeBG:SetAlpha(1)
  _wpGauge:SetShow(true)
  _wpGauge:SetAlpha(1)
  _wpGauge_Head:SetShow(true)
  _wpGauge_Head:SetAlpha(1)
  _Wp:SetShow(true)
  _Wp:SetFontAlpha(1)
  _Wp_Main:SetShow(true)
  _Wp_Main:SetFontAlpha(1)
  _contribute_BG:SetShow(true)
  _contribute_BG:SetAlpha(1)
  _contribute_progress:SetShow(true)
  _contribute_progress:SetAlpha(1)
  _contribute_progress_Head:SetShow(true)
  _contribute_progress_Head:SetAlpha(1)
  _contribute_txt:SetShow(true)
  _contribute_txt:SetFontAlpha(1)
  _contribute_Main:SetShow(true)
  _contribute_Main:SetFontAlpha(1)
end
if getEnableSimpleUI() then
  SelfExp_MouseOver_Force(false)
end
_levelBG:addInputEvent("Mouse_On", "SelfExp_MouseOver( true )")
_levelBG:addInputEvent("Mouse_Out", "SelfExp_MouseOver( false )")
registerEvent("EventSimpleUIEnable", "SelfExp_MouseOver_Force_Over")
registerEvent("EventSimpleUIDisable", "SelfExp_MouseOver_Force_Out")
function SelfExp_SimpleUIUpdatePerFrame(deltaTime)
  local tmpRaderAlphaValue = 0.65
  local tmpRaderLessAlphaValue = 0.85
  local tmpRaderMoreAlphaValue = 0.55
  if _selfExpSimpleUI_MouseOver then
    tmpRaderAlphaValue = 1
    tmpRaderLessAlphaValue = 1
    tmpRaderMoreAlphaValue = 1
  end
  UIAni.perFrameAlphaAnimation(tmpRaderAlphaValue, _levelBG, 2.8 * deltaTime)
  UIAni.perFrameAlphaAnimation(tmpRaderMoreAlphaValue, _skillGaugeBG, 3.8 * deltaTime)
  UIAni.perFrameAlphaAnimation(tmpRaderMoreAlphaValue, _staticSkillExp, 3.8 * deltaTime)
  UIAni.perFrameAlphaAnimation(tmpRaderMoreAlphaValue, _staticSkillExp_Head, 3.8 * deltaTime)
  UIAni.perFrameFontAlphaAnimation(tmpRaderLessAlphaValue, _staticSkillPoint, 3.8 * deltaTime)
  UIAni.perFrameFontAlphaAnimation(tmpRaderLessAlphaValue, _txt_DefenceInfo, 3.8 * deltaTime)
  UIAni.perFrameAlphaAnimation(tmpRaderMoreAlphaValue, _wpGaugeBG, 3.8 * deltaTime)
  UIAni.perFrameAlphaAnimation(tmpRaderMoreAlphaValue, _wpGauge, 3.8 * deltaTime)
  UIAni.perFrameAlphaAnimation(tmpRaderMoreAlphaValue, _wpGauge_Head, 3.8 * deltaTime)
  UIAni.perFrameFontAlphaAnimation(tmpRaderLessAlphaValue, _Wp, 3.8 * deltaTime)
  UIAni.perFrameFontAlphaAnimation(tmpRaderLessAlphaValue, _Wp_Main, 3.8 * deltaTime)
  UIAni.perFrameAlphaAnimation(tmpRaderMoreAlphaValue, _contribute_BG, 3.8 * deltaTime)
  UIAni.perFrameAlphaAnimation(tmpRaderMoreAlphaValue, _contribute_progress, 3.8 * deltaTime)
  UIAni.perFrameAlphaAnimation(tmpRaderMoreAlphaValue, _contribute_progress_Head, 3.8 * deltaTime)
  UIAni.perFrameFontAlphaAnimation(tmpRaderLessAlphaValue, _contribute_txt, 3.8 * deltaTime)
  UIAni.perFrameFontAlphaAnimation(tmpRaderLessAlphaValue, _contribute_Main, 3.8 * deltaTime)
end
registerEvent("SimpleUI_UpdatePerFrame", "SelfExp_SimpleUIUpdatePerFrame")
local function registEventHandler()
  if _ContentsGroup_ShowOtherClassSkill == true then
    _stc_skillLearnGuideBG:addInputEvent("Mouse_LUp", "PaGlobalFunc_SkillGroup_All_HotKeyToggle()")
  else
    _stc_skillLearnGuideBG:addInputEvent("Mouse_LUp", "PaGlobalFunc_SkillGroup_HotKeyToggle()")
  end
  _staticSkillPoint:addInputEvent("Mouse_LUp", "GlobalKeyBinder_MouseKeyMap( __eUiInputType_Inventory )")
  _txt_DefenceInfo:addInputEvent("Mouse_LUp", "GlobalKeyBinder_MouseKeyMap( __eUiInputType_Inventory )")
  _Wp:addInputEvent("Mouse_On", "SelfPlayer_ExpTooltip(true, " .. 1 .. ")")
  _Wp:addInputEvent("Mouse_Out", "SelfPlayer_ExpTooltip(false, " .. 1 .. ")")
  _Wp_Main:addInputEvent("Mouse_On", "SelfPlayer_ExpTooltip(true, " .. 1 .. ")")
  _Wp_Main:addInputEvent("Mouse_Out", "SelfPlayer_ExpTooltip(false, " .. 1 .. ")")
  _Wp:setTooltipEventRegistFunc("SelfPlayer_ExpTooltip(true, " .. 1 .. ")")
  _Wp_Main:setTooltipEventRegistFunc("SelfPlayer_ExpTooltip(true, " .. 1 .. ")")
  _contribute_txt:addInputEvent("Mouse_On", "SelfPlayer_ExpTooltip( true, " .. 2 .. " )")
  _contribute_txt:addInputEvent("Mouse_Out", "SelfPlayer_ExpTooltip( false, " .. 2 .. " )")
  _contribute_Main:addInputEvent("Mouse_On", "SelfPlayer_ExpTooltip( true, " .. 2 .. " )")
  _contribute_Main:addInputEvent("Mouse_Out", "SelfPlayer_ExpTooltip( false, " .. 2 .. " )")
  _contribute_Main:addInputEvent("Mouse_LUp", "PaGlobalFunc_ExplorePoint_UsingInfo_Open()")
  _contribute_txt:addInputEvent("Mouse_LUp", "PaGlobalFunc_ExplorePoint_UsingInfo_Open()")
  _contribute_txt:setTooltipEventRegistFunc("SelfPlayer_ExpTooltip(true, " .. 2 .. ")")
  _contribute_Main:setTooltipEventRegistFunc("SelfPlayer_ExpTooltip(true, " .. 2 .. ")")
  _close_ExpGauge:addInputEvent("Mouse_LUp", "SelfPlayerExpGauge_ShowToggle()")
  _txt_BubbleAlert:addInputEvent("Mouse_LUp", "GlobalKeyBinder_MouseKeyMap(__eUiInputType_BlackSpirit)")
  Panel_SelfPlayerExpGage:addInputEvent("Mouse_On", "ExpGauge_ChangeTexture_On()")
  Panel_SelfPlayerExpGage:addInputEvent("Mouse_Out", "ExpGauge_ChangeTexture_Off()")
  Panel_SelfPlayerExpGage:addInputEvent("Mouse_LUp", "ResetPos_WidgetButton()")
  if _ContentsGroup_ContributePointList == true then
    _contribute_txt:addInputEvent("Mouse_LUp", "PaGlobalFunc_ExplorePoint_UsingInfo_Open()")
  end
end
local registMessageHandler = function()
  registerEvent("onScreenResize", "Panel_SelfPlayerExpGage_onScreenResize")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "Panel_SelfPlayerExpGage_onScreenResize")
  registerEvent("EventCharacterInfoUpdate", "ExpGauge_CharacterInfoUpdate_Reload")
  registerEvent("FromClient_SelfPlayerCombatSkillPointChanged", "UserSkillPoint_Update")
  registerEvent("FromClient_SelfPlayerExpChanged", "Panel_SelfPlayerExpGage_CharacterInfoWindowUpdate")
  registerEvent("EventSelfPlayerLevelUp", "UserLevel_Update")
  registerEvent("FromClient_WpChanged", "wpPoint_UpdateFunc")
  registerEvent("FromClient_UpdateExplorePoint", "contributePoint_UpdateFunc")
  registerEvent("FromClient_luaLoadComplete", "PaGlobal_SelfPlayerExpGage_InitCheck")
  registerEvent("FromClient_HardCoreCharacterInfoChangedSelf", "PaGlobal_SelfPlayerExpGage_HardCoreSurvivalPoint")
end
local _lastSkillPoint = -1
local _lastWP = -1
local _lastEXP = -1
local _lastSkillExp = 0
local saved_maxWp = 0
local expHead_EffectKey = 0
local prevLevel = 0
function Panel_SelfPlayerExpGage_CharacterInfoWindowUpdate()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  local s64_needExp = player:getNeedExp_s64()
  local s64_exp = player:getExp_s64()
  local _const = Defines.u64_const
  local rate = 0
  local rateDisplay = 0
  local stringS64Exp = tostring64(s64_exp)
  local stringS64NeedExp = tostring64(s64_needExp)
  rate = tonumber(stringS64Exp) * 1000 * 100 / tonumber(stringS64NeedExp)
  if _lastEXP < tonumber(stringS64Exp) and -1 ~= _lastEXP then
    if 0 ~= expHead_EffectKey then
      _expHead:EraseEffect(expHead_EffectKey)
    end
    expHead_EffectKey = _expHead:AddEffect("fUI_Gauge_Experience", false, 0, 0)
  end
  local real_rate = rate / 1000
  if 100 == real_rate then
    rateDisplay = "100.000%"
  elseif 0 == real_rate then
    rateDisplay = "0.000%"
  elseif real_rate == real_rate - real_rate % 1 then
    rateDisplay = real_rate .. ".000%"
  elseif real_rate == real_rate - real_rate % 0.1 then
    rateDisplay = real_rate .. "00%"
  elseif real_rate == real_rate - real_rate % 0.01 then
    rateDisplay = real_rate .. "0%"
  else
    rateDisplay = real_rate .. "%"
  end
  PaGlobalFunc_SelfPlayerExpGage_BubbleText_49Level_Update()
  expGage:SetProgressRate(real_rate)
  _lastEXP = tonumber(stringS64Exp)
  _staticLevelSub:ComputePos()
  _staticLevelSub:SetText(string.format("%.3f", real_rate) .. "%")
  _staticLevelSub:useGlowFont(true, "BaseFont_Glow", 4284572001)
  _staticLvText:useGlowFont(true, "BaseFont_8_Glow", 4284572001)
end
function UserSkillPoint_Update()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  PaGlobal_SelfPlayerExpGage_AttackInfoUpdate()
  _staticSkillPoint:useGlowFont(true, "BaseFont_Glow", 4284572001)
  _txt_DefenceInfo:useGlowFont(true, "BaseFont_Glow", 4284572001)
end
function PaGlobal_SelfPlayerExpGage_AttackInfoUpdate()
  if getSelfPlayer() == nil then
    return
  end
  local offenceStatus = 0
  local AwakenStatus = 0
  local DefenceStatus = 0
  local doUpdateColor = false
  if _ContentsGroup_RenewCharacterStatusViewMode == true and PaGlobalFunc_NotationAbility_IsLateInitialized ~= nil and PaGlobalFunc_NotationAbility_IsLateInitialized() == true then
    offenceStatus = PaGlobalFunc_NotationAbility_GetMyAtk()
    AwakenStatus = PaGlobalFunc_NotationAbility_GetMyAwakenAtk()
    DefenceStatus = PaGlobalFunc_NotationAbility_GetMyDef()
    doUpdateColor = true
  else
    if _initCheck == true then
      ToClient_updateAttackStat()
    end
    offenceStatus = ToClient_getOffence()
    AwakenStatus = ToClient_getAwakenOffence()
    DefenceStatus = ToClient_getDefence()
  end
  if doUpdateColor == true then
    local fontColor = PaGlobalFunc_NotationAbility_GetFontColor()
    local glowFontColor = PaGlobalFunc_NotationAbility_GetGlowFontColor()
    local iconColor = PaGlobalFunc_NotationAbility_GetIconColor()
    _staticSkillPoint:SetColor(iconColor)
    _txt_DefenceInfo:SetColor(iconColor)
    _staticSkillPoint:SetFontColor(fontColor)
    _staticSkillPoint:useGlowFont(true, "RealFont_14_Shadhow", glowFontColor)
    _txt_DefenceInfo:SetFontColor(fontColor)
    _txt_DefenceInfo:useGlowFont(true, "RealFont_14_Shadhow", glowFontColor)
  end
  local mySkillType = ToClient_GetCurrentPlayerSkillType()
  local isSetAwakenWeapon = ToClient_getEquipmentItem(__eEquipSlotNoAwakenWeapon)
  local isShyWomen = __eClassType_ShyWaman == getSelfPlayer():getClassType()
  local myAttakStatus = offenceStatus
  if mySkillType == __eSkillTypeParam_Inherit or mySkillType == __eSkillTypeParam_Normal then
    myAttakStatus = offenceStatus
  elseif mySkillType == __eSkillTypeParam_Awaken then
    myAttakStatus = AwakenStatus
  else
    myAttakStatus = offenceStatus
  end
  if nil ~= isSetAwakenWeapon then
    if true == isShyWomen then
      myAttakStatus = AwakenStatus
    end
  elseif true == isShyWomen then
    myAttakStatus = offenceStatus
  end
  PaGlobal_SelfPlayerExpGage_StatusIconChange(mySkillType, isSetAwakenWeapon, isShyWomen)
  _staticSkillPoint:SetText(tostring(myAttakStatus))
  _txt_DefenceInfo:SetText(tostring(DefenceStatus))
  _staticSkillPoint:addInputEvent("Mouse_On", "PaGlobal_SelfPlayerExpGage_StatusIconTooltip(true, " .. tostring(mySkillType) .. ", " .. tostring(isShyWomen) .. ")")
  _staticSkillPoint:addInputEvent("Mouse_Out", "PaGlobal_SelfPlayerExpGage_StatusIconTooltip()")
  _txt_DefenceInfo:addInputEvent("Mouse_On", "PaGlobal_SelfPlayerExpGage_StatusIconTooltip(true, 99)")
  _txt_DefenceInfo:addInputEvent("Mouse_Out", "PaGlobal_SelfPlayerExpGage_StatusIconTooltip()")
end
function PaGlobal_SelfPlayerExpGage_StatusIconChange(attackType, isSetAwakenWeapon, isShyWomen)
  if attackType == nil then
    return
  end
  local self = MainStatus
  local textureIdKey = "Combine_Equip_Icon_Attack_Classic"
  if attackType == __eSkillTypeParam_Inherit then
    textureIdKey = "Combine_Equip_Icon_Attack_Classic"
  elseif attackType == __eSkillTypeParam_Awaken then
    textureIdKey = "Combine_Equip_Icon_Attack_Awaken"
  else
    textureIdKey = "Combine_Equip_Icon_Attack_Classic"
  end
  if nil ~= isSetAwakenWeapon then
    if true == isShyWomen then
      textureIdKey = "Combine_Equip_Icon_Shai"
    end
  elseif true == isShyWomen then
    textureIdKey = "Combine_Equip_Icon_Attack_Classic"
  end
  _staticSkillPoint:ChangeTextureInfoTextureIDAsync(textureIdKey)
  _staticSkillPoint:setRenderTexture(_staticSkillPoint:getBaseTexture())
end
function PaGlobal_SelfPlayerExpGage_StatusIconTooltip(isShow, tipType, isShyWomen)
  if isShow == nil then
    TooltipSimple_Hide()
    return
  end
  local name = ""
  local desc = ""
  local control
  local isSetAwakenWeapon = ToClient_getEquipmentItem(__eEquipSlotNoAwakenWeapon)
  local _classType = getSelfPlayer():getClassType()
  if tipType == __eSkillTypeParam_Inherit or tipType == __eSkillTypeParam_Normal then
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_ATTACK")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_ATTACK_TEXT_TOOLTIP_DESC") .. [[

<PAColor0xffe7d583>- ]] .. PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TEXT_HIT") .. " : " .. tostring(ToClient_getHit()) .. "<PAOldColor>"
    if _classType == __eClassType_Scholar or _classType == __eClassType_RangerMan then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_ATTACK_TEXT_TOOLTIP_DESC2") .. [[

<PAColor0xffe7d583>- ]] .. PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TEXT_HIT") .. " : " .. tostring(ToClient_getHit()) .. "<PAOldColor>"
    end
    control = _staticSkillPoint
  elseif tipType == 99 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_DEFENCE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_DEFENCE_TEXT_TOOLTIP_DESC") .. [[

<PAColor0xffe7d583>]] .. PAGetString(Defines.StringSheet_RESOURCE, "TOOLTIP_ITEM_TXT_DV") .. " " .. tostring(ToClient_getDv()) .. [[
<PAOldColor>
<PAColor0xffe7d583>]] .. PAGetString(Defines.StringSheet_RESOURCE, "TOOLTIP_ITEM_TXT_PV") .. " " .. tostring(ToClient_getPv()) .. "<PAOldColor>"
    control = _txt_DefenceInfo
  elseif tipType == __eSkillTypeParam_Awaken and isShyWomen == false then
    name = PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TOOLTIP_AWAKEN_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AWAKEN_TEXT_TOOLTIP_DESC") .. [[

<PAColor0xffe7d583>- ]] .. PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TEXT_HIT") .. " : " .. tostring(ToClient_getHit()) .. "<PAOldColor>"
    control = _staticSkillPoint
  elseif isShyWomen == true then
    if isSetAwakenWeapon ~= nil then
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SHYSTAT_1")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SHYSTAT1_DESC") .. [[

<PAColor0xffe7d583>- ]] .. PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TEXT_HIT") .. " : " .. tostring(ToClient_getHit()) .. "<PAOldColor>"
      control = _staticSkillPoint
    else
      name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_ATTACK")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_ATTACK_TEXT_TOOLTIP_DESC2") .. [[

<PAColor0xffe7d583>- ]] .. PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TEXT_HIT") .. " : " .. tostring(ToClient_getHit()) .. "<PAOldColor>"
      control = _staticSkillPoint
    end
  else
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name, desc)
end
local tooltipExpPanel = UI.createPanel("tooltipExp", Defines.UIGroup.PAGameUIGroup_Windows)
tooltipExpPanel:SetShow(false, false)
local tooltipExpPanel_Static = UI.createControl(__ePAUIControl_StaticText, tooltipExpPanel, "tooltipExpStatic")
tooltipExpPanel_Static:SetPosX(10)
tooltipExpPanel_Static:SetPosY(10)
tooltipExpPanel_Static:SetSize(290, 90)
tooltipExpPanel_Static:SetShow(true)
function Panel_SelfPlayerExpGage_OnMouse()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  tooltipExpPanel:SetSize(300, 100)
  tooltipExpPanel:SetPosX(getMousePosX())
  positionY = getMousePosY()
  positionY = positionY - 100
  tooltipExpPanel:SetPosY(positionY)
  tooltipExpPanel:SetShow(true, false)
  tooltipExpPanel_Static:SetText(PAGetString(Defines.StringSheet_GAME, "MAINSTATUS_EXP") .. tostring(player:getExp_s64()) .. "/" .. tostring(player:getNeedExp_s64()))
end
function Panel_SelfPlayerExpGage_OutMouse()
  tooltipExpPanel:SetShow(false, false)
end
local _lastLevel = 0
function UserLevel_Update()
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  staticLevelBg:SetShow(true)
  staticLevelBg:SetAlpha(0.8)
  _staticLevel:SetText(tostring(player:get():getLevel()))
  _staticLevel:useGlowFont(true, "RealFont_35_Glow", 4284572001)
  if _lastLevel < player:get():getLevel() and 0 ~= _lastLevel then
    _staticLevel:EraseAllEffect()
    _staticLevel:AddEffect("fUI_NewSkill01", false, 0, 0)
    _staticLevel:AddEffect("UI_NewSkill01", false, 0, 0)
    _staticLevel:AddEffect("UI_LevelUP_Main", false, -33, -43)
    _staticLevel:AddEffect("fUI_Gauge_LevelUp01", false, 80, -40)
  end
  CharacterLevelCheckForWeather()
  _lastLevel = player:get():getLevel()
end
local isSixteen = false
function CharacterLevelCheckForWeather()
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  local inMyLevel = player:get():getLevel()
  if 16 == inMyLevel and not isSixteen then
    isSixteen = true
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "PANEL_SELFPLAYEREXPGAGE_LEVEL_WEATHERCHECK"))
  end
end
CharacterLevelCheckForWeather()
function wpPoint_UpdateFunc()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local Wp = selfPlayer:getWp()
  local maxWp = selfPlayer:getMaxWp()
  local wpSetProgress = Wp / maxWp * 100
  if Wp > _lastWP and -1 ~= _lastWP then
    audioPostEvent_SystemUi(3, 13)
    _AudioPostEvent_SystemUiForXBOX(3, 13)
    _Wp_Main:EraseAllEffect()
    _Wp:AddEffect("UI_LevelUP_Skill", false, 0, 1)
    _Wp:AddEffect("fUI_LevelUP_Skill02", false, 0, 1)
    _wpGauge:EraseAllEffect()
    _wpGauge_Head:EraseAllEffect()
    _wpGauge:AddEffect("UI_Gauge_Experience02", false, 0, 0)
    _wpGauge_Head:AddEffect("fUI_Repair01", false, 0, 0)
  end
  _Wp_Main:SetText(tostring(Wp) .. " / " .. maxWp)
  _wpGauge:SetProgressRate(wpSetProgress)
  _Wp_Main:SetEnableArea(0, 0, _Wp_Main:GetTextSizeX(), _Wp_Main:GetSizeY())
  _Wp_Main:useGlowFont(true, "BaseFont_Glow", 4284572001)
  _lastWP = Wp
end
function wpPoint_UpdateEffect()
  if nil == Panel_SelfPlayerExpGage or false == Panel_SelfPlayerExpGage:GetShow() then
    return
  end
  _Wp:EraseAllEffect()
  _Wp:AddEffect("UI_LevelUP_Skill", false, 0, 1)
  _Wp:AddEffect("fUI_LevelUP_Skill02", false, 0, 1)
end
local lastContRate = 0
local lastRemainExplorePoint = 0
local lastExplorePoint = 0
local isFirstExplore = false
Panel_Expgauge_MyContributeValue = 0
function contributePoint_UpdateFunc()
  local explorePoint = ToClient_getExplorePoint()
  if nil == explorePoint then
    _contribute_Main:SetText("")
    _contribute_progress:SetProgressRate(0)
    return
  end
  local s64_exploreRequireExp = ToClient_getRequireExperienceToExplorePoint_s64()
  local cont_expRate = Int64toInt32(explorePoint:getExperience_s64()) / Int64toInt32(getRequireExplorationExperience_s64())
  local nowRemainExpPoint = tostring(explorePoint:getRemainedPoint())
  local nowExpPoint = tostring(explorePoint:getAquiredPoint())
  _contribute_Main:SetText(tostring(explorePoint:getRemainedPoint()) .. " / " .. tostring(explorePoint:getAquiredPoint()))
  if isGameServiceTypeDev() then
    _contribute_Main:SetText(tostring(explorePoint:getRemainedPoint()) .. " / " .. tostring(explorePoint:getAquiredPoint()) .. " (" .. Int64toInt32(explorePoint:getExperience_s64()) .. " / " .. Int64toInt32(getRequireExplorationExperience_s64()) .. ")")
  end
  _contribute_progress:SetProgressRate(cont_expRate * 100)
  _contribute_Main:SetEnableArea(0, 0, _contribute_Main:GetTextSizeX(), _contribute_Main:GetSizeY())
  Panel_Expgauge_MyContributeValue = tostring(explorePoint:getRemainedPoint())
  if isFirstExplore == false then
    lastRemainExplorePoint = 0
    lastExplorePoint = 0
    nowRemainExpPoint = 0
    nowExpPoint = 0
    isFirstExplore = true
  end
  if lastContRate ~= cont_expRate then
    _contribute_progress:SetNotAbleMasking(true)
    _contribute_progress_Head:SetNotAbleMasking(true)
    _contribute_progress:EraseAllEffect()
    _contribute_progress_Head:EraseAllEffect()
    _contribute_progress:AddEffect("UI_Gauge_Experience02", false, 0, 0)
    _contribute_progress_Head:AddEffect("fUI_Repair01", false, 0, 0)
  end
  if lastRemainExplorePoint ~= nowRemainExpPoint and isFirstExplore == true then
    audioPostEvent_SystemUi(3, 7)
    _AudioPostEvent_SystemUiForXBOX(3, 7)
    _contribute_Main:EraseAllEffect()
    _contribute_Main:AddEffect("UI_LevelUP_Skill", false, 0, 1)
  end
  if lastExplorePoint ~= nowExpPoint and isFirstExplore == true then
    audioPostEvent_SystemUi(3, 7)
    _AudioPostEvent_SystemUiForXBOX(3, 7)
    _contribute_Main:EraseAllEffect()
    _contribute_Icon:AddEffect("UI_LevelUP_Skill", false, 0, 0)
  end
  _contribute_Main:useGlowFont(true, "BaseFont_Glow", 4284572001)
  lastContRate = cont_expRate
  lastRemainExplorePoint = tostring(explorePoint:getRemainedPoint())
  lastExplorePoint = tostring(explorePoint:getAquiredPoint())
end
local _contributeUsePoint = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_1"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_2"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_3")
}
function ExpGauge_ChangeTexture_On()
  _close_ExpGauge:SetShow(true)
  Panel_SelfPlayerExpGage:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/window_sample_drag.dds")
  expText:SetText(PAGetString(Defines.StringSheet_GAME, "MAINSTATUS_DRAG_SKILLEXP"))
end
function ExpGauge_ChangeTexture_Off()
  _close_ExpGauge:SetShow(false)
  Panel_SelfPlayerExpGage:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/window_sample_isWidget.dds")
  expText:SetText(PAGetString(Defines.StringSheet_GAME, "MAINSTATUS_SKILLEXP"))
end
function SelfPlayerExpGauge_ShowToggle()
  if true == PaGlobalFunc_IsRemasterUIOption() then
    return
  end
  local isShow = Panel_SelfPlayerExpGage:IsShow()
  if isShow == true then
    Panel_SelfPlayerExpGage:SetShow(false, false)
  else
    Panel_SelfPlayerExpGage:SetPosX(initPosX)
    Panel_SelfPlayerExpGage:SetPosY(initPosY)
    Panel_SelfPlayerExpGage:SetShow(true, true)
  end
  PaGlobalFunc_SelfPlayerExpGage_QuestCheck()
end
function PaGlobalFunc_SelfPlayerExpGage_QuestCheck()
  _oldCharacter = questList_isClearQuest(650, 1)
  if true == _oldCharacter then
    _levelUpQuestClear = questList_isClearQuest(677, 1)
  else
    _levelUpQuestClear = questList_isClearQuest(21100, 7)
  end
end
function PaGlobalFunc_SelfPlayerExpGage_BubbleText_49Level_Update()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  local nowLevel = player:getLevel()
  local levelText
  local temporaryWrapper = getTemporaryInformationWrapper()
  local family50LevelCheck = ToClient_UserHasOverLevelCharacter(50)
  local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
  local newbieUser = 2 == userType
  local returnUser = 1 == userType
  if false == _levelUpQuestClear and nowLevel >= 49 and nowLevel < 60 then
    if true == _oldCharacter then
      levelText = PAGetString(Defines.StringSheet_GAME, "LUA_MAXLEVELUP_YESLIMIT_NOBOSS")
    else
      levelText = PAGetString(Defines.StringSheet_GAME, "LUA_MAXLEVELUP_NOLIMIT_YESBOSS")
    end
  end
  if false == family50LevelCheck and 49 == nowLevel and (newbieUser or returnUser) and levelText ~= nil then
    _txt_BubbleAlert:SetShow(true)
    _txt_BubbleAlert:SetText(levelText)
    _txt_BubbleAlert:SetSize(_txt_BubbleAlert:GetTextSizeX() + 18, _txt_BubbleAlert:GetTextSizeY() + 35)
  else
    _txt_BubbleAlert:SetShow(false)
  end
end
local _staticSkillExp_p = UI.getChildControl(Panel_SelfPlayerExpGage, "CircularProgress_SkillExp_p")
local _staticSkillPoint_p = UI.getChildControl(Panel_SelfPlayerExpGage, "StaticText_SkillPoint_p")
function Panel_User_ProductSkillPoint_Update()
  local skillPointInfo = ToClient_getSkillPointInfo(2)
  _staticSkillPoint_p:SetText(tostring(skillPointInfo._remainPoint))
  local skillExpRate_p = skillPointInfo._currentExp / skillPointInfo._nextLevelExp
  _staticSkillExp_p:SetProgressRate(skillExpRate_p * 100)
end
function ExpGauge_CharacterInfoUpdate_Reload()
  Panel_SelfPlayerExpGage_CharacterInfoWindowUpdate()
  UserSkillPoint_Update()
  UserLevel_Update()
  wpPoint_UpdateFunc()
  contributePoint_UpdateFunc()
  PaGlobalFunc_SelfPlayerExpGage_BubbleText_49Level_Update()
  PaGlobal_SelfPlayerExpGage_HardCoreSurvivalPoint()
end
function SelfExp_BuffIcon_PosX()
  return _buffIconPosX
end
function renderModeChange_FGlobal_PackageIconUpdate(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  FGlobal_PackageIconUpdate()
end
registerEvent("FromClient_RenderModeChangeState", "renderModeChange_FGlobal_PackageIconUpdate")
function SelfPlayer_ExpTooltip(isShow, iconType)
  local uiControl, name, desc
  if 1 == iconType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_MENTAL")
    desc = PAGetString(Defines.StringSheet_GAME, "MAINSTATUS_DESC_WP")
    uiControl = _Wp_Main
  elseif 2 == iconType then
    local _contributeBubbleText = ""
    if PaGlobal_ExplorePoint_UsingInfo == nil then
      return
    end
    PaGlobal_ExplorePoint_UsingInfo:searchHouseList()
    local houseTotal_uint32 = ToClient_getHouseTotalExplorePoint()
    PaGlobal_ExplorePoint_UsingInfo:searchNodeList()
    local nodeTotal_uint32 = ToClient_getNodeTotalExplorePoint()
    if ToClient_GetPalaceManageContentUsed() == true then
      nodeTotal_uint32 = nodeTotal_uint32 + ToClient_GetPalaceManageExplorationPoint()
    end
    PaGlobal_ExplorePoint_UsingInfo:searchItemList()
    local itemTotal_uint32 = ToClient_getItemTotalExplorePoint()
    local contributeUsePointInt = {
      houseTotal_uint32,
      nodeTotal_uint32,
      itemTotal_uint32
    }
    for i = 0, 2 do
      if contributeUsePointInt[i + 1] > 0 then
        if "" == _contributeBubbleText then
          _contributeBubbleText = _contributeUsePoint[i] .. " " .. contributeUsePointInt[i + 1]
        else
          _contributeBubbleText = _contributeBubbleText .. " | " .. _contributeUsePoint[i] .. " " .. contributeUsePointInt[i + 1]
        end
      end
    end
    if "" == _contributeBubbleText then
      _contributeBubbleText = PAGetString(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_4")
    elseif _ContentsGroup_UsePadSnapping == false then
      _contributeBubbleText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_5", "_contributeBubbleText", _contributeBubbleText)
    else
      _contributeBubbleText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_6", "_contributeBubbleText", _contributeBubbleText)
    end
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_GUIDE_CONTRIBUTIVENESS")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CONTRIBUTE_POINT_DESC") .. "\n" .. _contributeBubbleText
    uiControl = _contribute_Main
  end
  if isShow then
    audioPostEvent_SystemUi(0, 13)
    _AudioPostEvent_SystemUiForXBOX(0, 13)
    registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(uiControl, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_SelfPlayerExpGage_HardCoreSurvivalPoint()
  local isHardCoreCharacter = _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreCharacter()
  if isHardCoreCharacter == false then
    _stc_HardCorePoint:SetShow(false)
    return
  end
  _wpGaugeBG:SetShow(false)
  _wpGauge:SetShow(false)
  _wpGauge_Head:SetShow(false)
  _Wp:SetShow(false)
  _Wp_Main:SetShow(false)
  _contribute_BG:SetShow(false)
  _contribute_progress:SetShow(false)
  _contribute_progress_Head:SetShow(false)
  _contribute_txt:SetShow(false)
  _contribute_Main:SetShow(false)
  _stc_HardCorePoint:SetText(ToClient_getHardCoreRankPoint())
  _stc_HardCorePoint:SetShow(true)
end
function PaGlobalFunc_SelfPlayerExpGage_SetShow(isShow, isAni, isForce)
  if true == PaGlobalFunc_IsRemasterUIOption() then
    isShow = false
  end
  if true == isForce then
    if Panel_SelfPlayerExpGage:GetShow() == isShow then
      return
    end
    Panel_SelfPlayerExpGage:SetShow(isShow, isAni)
    return
  end
  if true == isShow and -1 < ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_SelfPlayer_ExpGage, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow) then
    isShow = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_SelfPlayer_ExpGage, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow)
  end
  Panel_SelfPlayerExpGage:SetShow(isShow, isAni)
end
function PaGlobal_SelfPlayerExpGage_InitCheck()
  _initCheck = true
end
contributePoint_UpdateFunc()
Panel_SelfPlayerExpGage_CharacterInfoWindowUpdate()
UserSkillPoint_Update()
registEventHandler()
registMessageHandler()
PaGlobal_SelfPlayerExpGage_HardCoreSurvivalPoint()
changePositionBySever(Panel_SelfPlayerExpGage, CppEnums.PAGameUIType.PAGameUIPanel_SelfPlayer_ExpGage, true, false, false)
PaGlobalFunc_SelfPlayerExpGage_SetShow(true, false)
panel_ExpGauge_unRenderInInstacne()
