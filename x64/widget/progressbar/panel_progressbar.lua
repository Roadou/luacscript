local _collect_100per = UI.getChildControl(Panel_Collect_Bar, "Static_100per")
local _product_100per = UI.getChildControl(Panel_Product_Bar, "Static_100per")
local _enchant_100per = UI.getChildControl(Panel_Enchant_Bar, "Static_100per")
local _casting_100per = UI.getChildControl(Panel_Casting_Bar, "Static_Effect_BG")
local _preCoolTime_cancel = UI.getChildControl(Panel_Widget_EscapeBar_All, "StaticText_CancelEscape")
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_AV = CppEnums.PA_UI_ALIGNVERTICAL
local UI_TT = CppEnums.PAUI_TEXTURE_TYPE
local UI_PSFT = CppEnums.PAUI_SHOW_FADE_TYPE
local UI_color = Defines.Color
local _collectText = UI.getChildControl(Panel_Collect_Bar, "StaticText_CollectingNow")
local checkBtn_DrawWater = UI.getChildControl(Panel_Collect_Bar, "CheckButton_DrawWater")
checkBtn_DrawWater:addInputEvent("Mouse_LUp", "DrawWater_Check()")
checkBtn_DrawWater:SetEnableArea(0, 0, checkBtn_DrawWater:GetSizeX() + checkBtn_DrawWater:GetTextSizeX() + 10, checkBtn_DrawWater:GetSizeY())
registerEvent("FromClient_SetRepeatCollectValue", "FromClient_SetRepeatCollectValue")
function FromClient_SetRepeatCollectValue(isRepeatCollect)
  if isRepeatCollect == nil then
    return
  end
  DrawWater_Check(isRepeatCollect)
end
function DrawWater_Check(setCheckValue)
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return
  end
  if setCheckValue ~= nil then
    checkBtn_DrawWater:SetCheck(setCheckValue)
  end
  local isCheck = checkBtn_DrawWater:IsCheck()
  temporaryWrapper:setRepeatCollect(isCheck)
  Global_UpdateDrawWaterRepeat()
end
function Global_SetShowDrawWaterRepeat(isShow)
  if true == _ContentsGroup_UsePadSnapping then
    isShow = false
  end
  checkBtn_DrawWater:SetShow(isShow)
end
function Global_UpdateDrawWaterRepeat()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local isCheck = temporaryWrapper:getRepeatCollect()
  checkBtn_DrawWater:SetCheck(isCheck)
end
Panel_Collect_Bar:SetShow(false, false)
Panel_Product_Bar:SetShow(false, false)
Panel_Enchant_Bar:SetShow(false, false)
Panel_Casting_Bar:SetShow(false, false)
Panel_Widget_EscapeBar_All:SetShow(false, false)
Panel_Collect_Bar:RegisterShowEventFunc(true, "CollectBarShowAni()")
Panel_Collect_Bar:RegisterShowEventFunc(false, "CollectBarHideAni()")
function CollectBarShowAni()
  Panel_Collect_Bar:SetShowWithFade(UI_PSFT.PAUI_ANI_TYPE_FADE_IN)
  local CollectBar_Alpha = Panel_Collect_Bar:addColorAnimation(0, 0.05, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  CollectBar_Alpha:SetStartColor(UI_color.C_00FFFFFF)
  CollectBar_Alpha:SetEndColor(UI_color.C_FFFFFFFF)
  CollectBar_Alpha.IsChangeChild = true
end
function CollectBarHideAni()
  Panel_Collect_Bar:SetShow(false, false)
end
Panel_Product_Bar:RegisterShowEventFunc(true, "ProductBarShowAni()")
Panel_Product_Bar:RegisterShowEventFunc(false, "ProductBarHideAni()")
function ProductBarShowAni()
  Panel_Product_Bar:SetShowWithFade(UI_PSFT.PAUI_ANI_TYPE_FADE_IN)
  local CollectBar_Alpha = Panel_Product_Bar:addColorAnimation(0, 0.05, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  CollectBar_Alpha:SetStartColor(UI_color.C_00FFFFFF)
  CollectBar_Alpha:SetEndColor(UI_color.C_FFFFFFFF)
  CollectBar_Alpha.IsChangeChild = true
end
function ProductBarHideAni()
  Panel_Product_Bar:SetShow(false, false)
end
Panel_Enchant_Bar:RegisterShowEventFunc(true, "EnchantBarShowAni()")
Panel_Enchant_Bar:RegisterShowEventFunc(false, "EnchantBarHideAni()")
function EnchantBarShowAni()
  Panel_Enchant_Bar:SetShowWithFade(UI_PSFT.PAUI_ANI_TYPE_FADE_IN)
  local CollectBar_Alpha = Panel_Enchant_Bar:addColorAnimation(0, 0.05, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  CollectBar_Alpha:SetStartColor(UI_color.C_00FFFFFF)
  CollectBar_Alpha:SetEndColor(UI_color.C_FFFFFFFF)
  CollectBar_Alpha.IsChangeChild = true
end
function EnchantBarHideAni()
  Panel_Enchant_Bar:SetShow(false, false)
end
Panel_Casting_Bar:RegisterShowEventFunc(true, "CastingBarShowAni()")
Panel_Casting_Bar:RegisterShowEventFunc(false, "CastingBarHideAni()")
function CastingBarShowAni()
  Panel_Casting_Bar:SetShowWithFade(UI_PSFT.PAUI_ANI_TYPE_FADE_IN)
  local casting_Alpha = Panel_Casting_Bar:addColorAnimation(0, 0.05, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  casting_Alpha:SetStartColor(UI_color.C_00FFFFFF)
  casting_Alpha:SetEndColor(UI_color.C_FFFFFFFF)
  casting_Alpha.IsChangeChild = true
end
function CastingBarHideAni()
  Panel_Casting_Bar:SetShow(false, false)
end
Panel_Widget_EscapeBar_All:RegisterShowEventFunc(true, "PreCoolTimeBarShowAni()")
Panel_Widget_EscapeBar_All:RegisterShowEventFunc(false, "PreCoolTimeBarHideAni()")
function PreCoolTimeBarShowAni()
  Panel_Widget_EscapeBar_All:SetShowWithFade(UI_PSFT.PAUI_ANI_TYPE_FADE_IN)
  local preCoolTime_Alpha = Panel_Widget_EscapeBar_All:addColorAnimation(0, 0.05, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  preCoolTime_Alpha:SetStartColor(UI_color.C_00FFFFFF)
  preCoolTime_Alpha:SetEndColor(UI_color.C_FFFFFFFF)
  preCoolTime_Alpha.IsChangeChild = true
end
function PreCoolTimeBarHideAni()
  Panel_Widget_EscapeBar_All:SetShow(false, false)
end
local collectBar = {
  _progressText,
  _progressControl,
  _progressTime = 0,
  _currentTime = 0,
  _endEventFunction = nil,
  _checkActionFunction = nil,
  _useType = 0
}
local productBar = {
  _progressText,
  _progressControl,
  _progressTime,
  _currentTime,
  _endEventFunction = nil
}
local enchantBar = {
  _progressText,
  _progressControl,
  _progressTime = 0,
  _currentTime = 0,
  _endEventFunction = nil
}
local castingBar = {
  _progressControl = nil,
  _progressTime = 0,
  _currentTime = 0,
  _isReverse = false,
  _endEventFunction = nil
}
local preCoolTimeBar = {
  _progressControl = nil,
  _progressTime = 0,
  _currentTime = 0,
  _endEventFunction = nil,
  _coolTimeType = 0
}
function collectBar:Init()
  collectBar._titleText = UI.getChildControl(Panel_Collect_Bar, "StaticText_CollectingNow")
  collectBar._progressText = UI.getChildControl(Panel_Collect_Bar, "StaticText_Bar")
  collectBar._progressControl = UI.getChildControl(Panel_Collect_Bar, "Progress2_1")
end
local currentTime_Collect
function collectBar:Show(isShow, progressTime, endFunction, checkFunction)
  if true == isShow then
    Panel_Collect_Bar:SetShow(true, true)
    currentTime_Collect = FGlobal_getFrameCount() + 1
    collectBar._progressControl:SetShow(true)
    collectBar._progressTime = progressTime
    collectBar._currentTime = 0
    local strTemp = string.format("%.1f", progressTime)
    collectBar._progressText:SetText(strTemp)
    collectBar._progressControl:SetProgressRate(0)
    collectBar._endEventFunction = endFunction
    collectBar._checkActionFunction = checkFunction
  else
    collectBar:Stop(true)
  end
end
function collectBar:Update(fDeltaTime)
  if 0 == collectBar._progressTime then
    return
  end
  if nil ~= collectBar._checkActionFunction and false == collectBar._checkActionFunction() then
    collectBar:Stop(true)
  end
  local nextTime = collectBar._currentTime + fDeltaTime
  collectBar._currentTime = nextTime
  local percent = nextTime / collectBar._progressTime * 100
  if percent > 100 then
    if nil ~= collectBar._endEventFunction then
      collectBar._endEventFunction()
    end
    collectBar:Stop(false)
  else
    local remainTime = collectBar._progressTime - collectBar._currentTime
    local strTemp = string.format("%.1f", remainTime)
    collectBar._progressText:SetText(strTemp)
    collectBar._progressControl:SetProgressRate(percent)
    if collectBar._useType == 1 then
      local curEndurance = repair_getSelfRepairItemEndurance()
      local strEndurance = string.format("%d", curEndurance)
      collectBar._titleText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_PROGRESSBAR_REPAIRING_P1", "endurance", strEndurance))
      if ToClient_isConsole() == false then
        PaGlobal_Manufacture_All_UpdateRepairTime()
      end
    end
  end
end
function collectBar:Stop(isClear)
  collectBar._progressTime = 0
  collectBar._endEventFunction = nil
  collectBar._checkActionFunction = nil
  collectBar._progressControl:SetShow(false)
  if nil ~= isClear and true == isClear then
    Manufacture_ClearValues()
  end
  if true == Panel_Collect_Bar:IsShow() then
    _collect_100per:SetVertexAniRun("Ani_Color_100per_0", true)
    Panel_Collect_Bar:SetShow(false, true)
    currentTime_Collect = nil
  end
end
function productBar:Init()
  productBar._titleText = UI.getChildControl(Panel_Product_Bar, "StaticText_ProductNow")
  productBar._progressText = UI.getChildControl(Panel_Product_Bar, "StaticText_Bar")
  productBar._progressControl = UI.getChildControl(Panel_Product_Bar, "Progress2_1")
end
function productBar:Show(isShow, progressTime, endFunction)
  if true == isShow then
    Panel_Product_Bar:SetShow(true, true)
    productBar._progressControl:SetShow(true)
    productBar._progressTime = progressTime
    productBar._currentTime = 0
    local strTemp = string.format("%.1f", progressTime)
    productBar._progressText:SetText(strTemp)
    productBar._progressControl:SetProgressRate(0)
    productBar._endEventFunction = endFunction
  else
    productBar:Stop()
  end
end
function productBar:Update(fDeltaTime)
  if 0 == productBar._progressTime then
    return
  end
  local nextTime = productBar._currentTime + fDeltaTime
  productBar._currentTime = nextTime
  local percent = nextTime / productBar._progressTime * 100
  if percent > 100 then
    if nil ~= productBar._endEventFunction then
      productBar._endEventFunction()
    end
    _product_100per:SetVertexAniRun("Ani_Color_100per_0", true)
    Panel_Product_Bar:SetShow(false, true)
    productBar:Stop()
  else
    local remainTime = productBar._progressTime - productBar._currentTime
    local strTemp = string.format("%.1f", remainTime)
    productBar._progressText:SetText(strTemp)
    productBar._progressControl:SetProgressRate(percent)
  end
end
function productBar:Stop()
  productBar._progressTime = 0
  productBar._endEventFunction = nil
  productBar._progressControl:SetShow(false)
  if true == Panel_Product_Bar:IsShow() then
    _product_100per:SetVertexAniRun("Ani_Color_100per_0", true)
    Panel_Product_Bar:SetShow(false, true)
  end
end
function enchantBar:Init()
  enchantBar._titleText = UI.getChildControl(Panel_Enchant_Bar, "StaticText_ProductNow")
  enchantBar._progressText = UI.getChildControl(Panel_Enchant_Bar, "StaticText_Bar")
  enchantBar._progressControl = UI.getChildControl(Panel_Enchant_Bar, "Progress2_1")
  progress_Enchant = UI.getChildControl(Panel_Enchant_Bar, "Progress2_1")
  progress_Enchant_Head = UI.getChildControl(progress_Enchant, "Progress2_1_Bar_Head")
end
function enchantBar:Show(isShow, progressTime, endFunction, enchantType)
  progress_Enchant:EraseAllEffect()
  progress_Enchant_Head:EraseAllEffect()
  if true == isShow then
    if enchantType == 0 then
      progress_Enchant:SetVertexAniRun("Ani_Color_Weapon", true)
    elseif enchantType == 1 then
      progress_Enchant:SetVertexAniRun("Ani_Color_Armor", true)
    end
    Panel_Enchant_Bar:SetShow(true, true)
    enchantBar._progressControl:SetShow(true)
    enchantBar._progressTime = progressTime
    enchantBar._currentTime = 0
    local strTemp = string.format("%.1f", progressTime)
    enchantBar._progressText:SetText(strTemp)
    enchantBar._progressControl:SetProgressRate(0)
    enchantBar._endEventFunction = endFunction
    progress_Enchant:SetNotAbleMasking(true)
    progress_Enchant_Head:SetNotAbleMasking(true)
    progress_Enchant:AddEffect("UI_ButtonLineRight_Blue", true, 0, 0)
  else
    progress_Enchant:EraseAllEffect()
    progress_Enchant_Head:EraseAllEffect()
    enchantBar:Stop()
  end
end
function enchantBar:Update(fDeltaTime)
  if 0 == enchantBar._progressTime then
    return
  end
  if false == isEnchantingAction() then
    enchantBar:Stop()
    Enchant_CloseButton()
  end
  local nextTime = enchantBar._currentTime + fDeltaTime
  enchantBar._currentTime = nextTime
  progress_Enchant_Head:AddEffect("fUI_Repair01B", true, 0, 0)
  local percent = nextTime / enchantBar._progressTime * 100
  if percent > 100 then
    if nil ~= enchantBar._endEventFunction then
      enchantBar._endEventFunction()
    end
    _enchant_100per:SetVertexAniRun("Ani_Color_100per_0", true)
    enchantBar:Stop()
  else
    local remainTime = enchantBar._progressTime - enchantBar._currentTime
    local strTemp = string.format("%.1f", remainTime)
    enchantBar._progressText:SetText(strTemp)
    enchantBar._progressControl:SetProgressRate(percent)
  end
end
function enchantBar:Stop()
  enchantBar._progressTime = 0
  enchantBar._endEventFunction = nil
  enchantBar._progressControl:SetShow(false)
  if true == Panel_Enchant_Bar:IsShow() then
    _enchant_100per:SetVertexAniRun("Ani_Color_100per_0", true)
    Panel_Enchant_Bar:SetShow(false, true)
  end
end
function castingBar:Init()
  castingBar._progressControl = UI.getChildControl(Panel_Casting_Bar, "Progress2_SP")
end
function castingBar:Show(isShow, progressTime, endFunction, isReverse, startTime)
  if isShow then
    Panel_Casting_Bar:SetShow(true, true)
    castingBar._progressControl:SetShow(true)
    castingBar._progressTime = progressTime
    castingBar._currentTime = startTime
    castingBar._isReverse = isReverse
    castingBar._progressControl:SetProgressRate(0)
    castingBar._endEventFunction = endFunction
  else
    castingBar:Stop()
  end
end
function castingBar:Update(fDeltaTime)
  if 0 == castingBar._progressTime then
    return
  end
  local nextTime = castingBar._currentTime + fDeltaTime
  castingBar._currentTime = nextTime
  local percent = nextTime / castingBar._progressTime * 100
  if percent > 100 then
    if nil ~= castingBar._endEventFunction then
      castingBar._endEventFunction()
    end
    _casting_100per:SetVertexAniRun("Ani_Color_Start_1", true)
    Panel_Casting_Bar:SetShow(false, true)
    castingBar:Stop()
  else
    if castingBar._isReverse == true then
      percent = 100 - percent
    end
    castingBar._progressControl:SetProgressRate(percent)
  end
end
function castingBar:Stop()
  castingBar._progressTime = 0
  castingBar._currentTime = 0
  castingBar._isReverse = false
  castingBar._endEventFunction = nil
  castingBar._progressControl:SetShow(false)
  if true == Panel_Casting_Bar:IsShow() then
    _enchant_100per:SetVertexAniRun("Ani_Color_Start_1", true)
    Panel_Casting_Bar:SetShow(false, true)
  end
end
function preCoolTimeBar:Init()
  preCoolTimeBar._progressControl = UI.getChildControl(Panel_Widget_EscapeBar_All, "Progress2_Escape")
  _preCoolTime_cancel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CENCLE_FUNC_CASTING"))
end
function preCoolTimeBar:Show(isShow, progressTime, endFunction, coolTimeType)
  if isShow then
    Panel_Widget_EscapeBar_All:SetShow(true, true)
    preCoolTimeBar._progressControl:SetShow(true)
    preCoolTimeBar._progressTime = progressTime
    preCoolTimeBar._currentTime = 0
    preCoolTimeBar._progressControl:SetProgressRate(0)
    preCoolTimeBar._endEventFunction = endFunction
    preCoolTimeBar._coolTimeType = coolTimeType
    if coolTimeType == __ePreCoolTimeType_Escape or coolTimeType == __ePreCoolTimeType_MorningLandBossTeleport or coolTimeType == __ePreCoolTimeType_GuildMansionTeleport or coolTimeType == __ePreCoolTimeType_ImmortalHellTeleport or coolTimeType == __ePreCoolTimeType_EdanaCastleTeleport then
      _preCoolTime_cancel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CENCLE_FUNC_CASTING"))
    elseif coolTimeType == __ePreCoolTimeType_JewelChange or coolTimeType == __ePreCoolTimeType_JewelPresetChange then
      _preCoolTime_cancel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PRESETCENCLE_FUNC_CASTING"))
      PaGlobalFunc_JewelPreset_SetBlockBg(true)
      PaGlobalFunc_JewelPreset_SetProgressBarActive(true)
    elseif coolTimeType == __ePreCoolTimeType_SillPresetChange or coolTimeType == __ePreCoolTimeType_TotalPresetApply or coolTimeType == __ePreCoolTimeType_ReforgeStonePresetSave or coolTimeType == __ePreCoolTimeType_ReforgeStonePresetApply then
      _preCoolTime_cancel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PRESETCENCLE_FUNC_CASTING"))
    end
  else
    preCoolTimeBar:Stop()
    if coolTimeType ~= nil then
      if coolTimeType == __ePreCoolTimeType_JewelChange or coolTimeType == __ePreCoolTimeType_JewelPresetChange then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_JEWELPRESET_PROGRESS_CANCEL"))
      elseif coolTimeType == __ePreCoolTimeType_MorningLandBossTeleport then
        ToClient_removeMorningLandBossTeleportNpc()
      elseif coolTimeType == __ePreCoolTimeType_GuildMansionTeleport then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMANSION_TELEPORT_PROGRESS_CANCEL"))
      elseif coolTimeType == __ePreCoolTimeType_SillPresetChange then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_PROGRESS_CANCEL"))
      elseif coolTimeType == __ePreCoolTimeType_TotalPresetApply or coolTimeType == __ePreCoolTimeType_ReforgeStonePresetSave or coolTimeType == __ePreCoolTimeType_ReforgeStonePresetApply then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TOTAL_PRESET_PROGRESS_CANCEL"))
      end
    end
  end
end
function preCoolTimeBar:Update(fDeltaTime)
  if 0 == preCoolTimeBar._progressTime then
    return
  end
  local nextTime = preCoolTimeBar._currentTime + fDeltaTime
  preCoolTimeBar._currentTime = nextTime
  local percent = nextTime / preCoolTimeBar._progressTime * 100
  if percent > 100 then
    if nil ~= preCoolTimeBar._endEventFunction then
      preCoolTimeBar._endEventFunction()
    end
    if preCoolTimeBar._coolTimeType ~= __ePreCoolTimeType_MorningLandBossTeleport then
      Panel_Widget_EscapeBar_All:SetShow(false, true)
      preCoolTimeBar:Stop()
    end
  else
    preCoolTimeBar._progressControl:SetProgressRate(percent)
    if (preCoolTimeBar._coolTimeType == __ePreCoolTimeType_JewelChange or preCoolTimeBar._coolTimeType == __ePreCoolTimeType_JewelPresetChange or preCoolTimeBar._coolTimeType == __ePreCoolTimeType_GuildMansionTeleport or preCoolTimeBar._coolTimeType == __ePreCoolTimeType_MorningLandBossTeleport or preCoolTimeBar._coolTimeType == __ePreCoolTimeType_SillPresetChange or preCoolTimeBar._coolTimeType == __ePreCoolTimeType_ImmortalHellTeleport or preCoolTimeBar._coolTimeType == __ePreCoolTimeType_EdanaCastleTeleport or preCoolTimeBar._coolTimeType == __ePreCoolTimeType_TotalPresetApply or preCoolTimeBar._coolTimeType == __ePreCoolTimeType_ReforgeStonePresetSave or preCoolTimeBar._coolTimeType == __ePreCoolTimeType_ReforgeStonePresetApply) and IsSelfPlayerWaitAction() == false then
      ToClient_StopPreCoolTime()
    end
  end
end
function preCoolTimeBar:Stop()
  preCoolTimeBar._progressTime = 0
  preCoolTimeBar._endEventFunction = nil
  preCoolTimeBar._progressControl:SetShow(false)
  if true == Panel_Widget_EscapeBar_All:IsShow() then
    Panel_Widget_EscapeBar_All:SetShow(false, true)
  end
  if preCoolTimeBar._coolTimeType == __ePreCoolTimeType_JewelChange or preCoolTimeBar._coolTimeType == __ePreCoolTimeType_JewelPresetChange then
    PaGlobalFunc_JewelPreset_SetBlockBg(false)
    PaGlobalFunc_JewelPreset_SetProgressBarActive(false)
  end
end
function ProgressBar_Collect_Show(isShow, progressTime, endfuction)
  collectBar:Show(isShow, progressTime, endfuction, nil)
end
function ProgressBar_Product_Show(isShow, progressTime, endfuction)
  productBar:Show(isShow, progressTime, endfuction)
end
function ProgressBar_Enchant_Show(isShow, progressTime, endfuction, enchantType)
  enchantBar:Show(isShow, progressTime, endfuction, enchantType)
end
function ProgressBar_PreCoolTime_Show(isShow, progressTime, endFunction, preCooltimeType)
  preCoolTimeBar:Show(isShow, progressTime, endFunction, preCooltimeType)
end
function OnlyPerFrame_ProgressBar_Collect_Update(fDeltaTime)
  if nil == currentTime_Collect or FGlobal_getFrameCount() <= currentTime_Collect then
    return
  end
  collectBar:Update(fDeltaTime)
end
function ProgressBar_Product_Update(fDeltaTime)
  productBar:Update(fDeltaTime)
end
function ProgressBar_Enchant_Update(fDeltaTime)
  enchantBar:Update(fDeltaTime)
end
function ProgressBar_Casting_Update(fDeltaTime)
  castingBar:Update(fDeltaTime)
end
function ProgressBar_PreCoolTime_Update(fDeltaTime)
  preCoolTimeBar:Update(fDeltaTime)
end
function checkCollectAction()
  return isCollectingAction()
end
function checkBuildTentAction()
  return isDoingAction("BUILD_TENT")
end
function checkTakeDownTentAction()
  return isDoingAction("TAKEDOWN_TENT")
end
function checkTakeDownCannonAction()
  return isDoingAction("TAKEDOWN_CANNON")
end
function checkRepairKingOrLordTentAction()
  return isDoingAction("COMMAND_REPAIR")
end
function checkBuidingUpgradeAction()
  return isDoingAction("BUILDING_UPGRADE")
end
function checkRepairAction()
  return repair_IsRepairingAction()
end
function checkCampfireAction()
  return isDoingAction("CAMPFIRE")
end
function checkCookAction()
  return isDoingAction("ALCHEMYSYSTEM_COOK")
end
function checkReadBookAction()
  return isDoingAction("READ_BOOK")
end
function checkManufactureAction()
  return isManufactureAction()
end
function checkAlchemyAction()
  local isDoing = isDoingAction("ALCHEMYSYSTEM_COOK") or isDoingAction("ALCHEMYSYSTEM_ALCHEMY")
  return isDoing
end
function checkBuildTentKitAction()
  return isDoingAction("BUILD_TENT_KIT")
end
function checkEnterToHadumFieldAction()
  return isDoingAction("ENTER_TO_HADUMFIELD") == true or isDoingAction("ENTER_TO_HADUMFIELD_ING") == true
end
function EventProgressBarShow(isShow, progressTime, isReverse, progressStartTime, barType, param)
  local endFunction, checkActionFunction
  if isShow then
    Global_SetShowDrawWaterRepeat(false)
    if 0 == barType then
      castingBar:Show(isShow, progressTime, nil, isReverse, progressStartTime)
    elseif 1 == barType then
      ProgressBar_Product_Show(isShow, progressTime, nil)
    elseif 2 == barType then
      if 0 == param then
        collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_PROGRESSBAR_COLLECTING") .. "..")
      elseif 1 == param then
        collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PROGRESSBAR_HARVEST"))
      elseif 2 == param then
        collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PROGRESSBAR_SEEDS"))
      elseif 3 == param then
        collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PROGRESSBAR_PRUNING"))
      elseif 4 == param then
        collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PROGRESSBAR_WORM"))
      elseif 5 == param then
        collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_PROGRESSBAR_COLLECTING"))
        Global_SetShowDrawWaterRepeat(true)
        local temporaryWrapper = getTemporaryInformationWrapper()
        temporaryWrapper:setRepeatCollect(checkBtn_DrawWater:IsCheck())
        Global_UpdateDrawWaterRepeat()
      else
        collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_PROGRESSBAR_COLLECTING") .. "..")
      end
      collectBar._useType = 0
      endFunction = nil
      checkActionFunction = checkCollectAction
      collectBar:Show(isShow, progressTime, endFunction, checkActionFunction)
    elseif 3 == barType then
      collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_PROGRESSBAR_INSTALL_TENT") .. "..")
      collectBar._useType = 0
      endFunction = nil
      checkActionFunction = checkBuildTentAction
      collectBar:Show(isShow, progressTime, endFunction, checkActionFunction)
    elseif 4 == barType then
      collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_PROGRESSBAR_REMOVE_TENT") .. "..")
      collectBar._useType = 0
      endFunction = nil
      checkActionFunction = checkTakeDownTentAction
      collectBar:Show(isShow, progressTime, endFunction, checkActionFunction)
    elseif 5 == barType then
      collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_PROGRESSBAR_INSTALL_TENT") .. "..")
      collectBar._useType = 0
      endFunction = nil
      checkActionFunction = checkCampfireAction
      collectBar:Show(isShow, progressTime, endFunction, checkActionFunction)
    elseif 6 == barType then
      collectBar._useType = 1
      endFunction = nil
      checkActionFunction = checkRepairAction
      collectBar:Show(isShow, progressTime, endFunction, checkActionFunction)
    elseif 7 == barType then
      collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "GAME_MANUFACTURE_COOK") .. "..")
      collectBar._useType = 0
      endFunction = PaGlobal_Alchemy_All_DoAlchemy
      checkActionFunction = checkCookAction
      collectBar:Show(isShow, progressTime, endFunction, checkActionFunction)
    elseif 8 == barType then
      collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_PROGRESSBAR_READING") .. "..")
      collectBar._useType = 0
      endFunction = nil
      checkActionFunction = checkReadBookAction
      collectBar:Show(isShow, progressTime, endFunction, checkActionFunction)
    elseif 9 == barType then
      collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PROGRESSBAR_COLLECTBAR_TITLE"))
      collectBar._useType = 0
      endFunction = PaGlobal_Alchemy_All_DoAlchemy
      checkActionFunction = checkAlchemyAction
      collectBar:Show(isShow, progressTime, endFunction, checkActionFunction)
    elseif 10 == barType then
      collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_PROGRESSBAR_REMOVE_CANNON") .. "..")
      collectBar._useType = 0
      endFunction = nil
      checkActionFunction = checkTakeDownCannonAction
      collectBar:Show(isShow, progressTime, endFunction, checkActionFunction)
    elseif 11 == barType then
      collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PROGRESSBAR_REPAIR"))
      collectBar._useType = 0
      endFunction = nil
      checkActionFunction = checkRepairKingOrLordTentAction
      collectBar:Show(isShow, progressTime, endFunction, checkActionFunction)
    elseif 12 == barType then
      collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PROGRESSBAR_UPGRADING"))
      collectBar._useType = 0
      endFunction = nil
      checkActionFunction = checkBuidingUpgradeAction
      collectBar:Show(isShow, progressTime, endFunction, checkActionFunction)
    elseif 13 == barType then
      collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PROGRESSBAR_REPAIRSHIP"))
      Global_SetShowDrawWaterRepeat(true)
      Global_UpdateDrawWaterRepeat()
      collectBar._useType = 0
      endFunction = nil
      checkActionFunction = checkRepairKingOrLordTentAction
      collectBar:Show(isShow, progressTime, endFunction, checkActionFunction)
    elseif 14 == barType then
      collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_PROGRESSBAR_INSTALL_TENT") .. "..")
      collectBar._useType = 0
      endFunction = nil
      checkActionFunction = checkBuildTentKitAction
      collectBar:Show(isShow, progressTime, endFunction, checkActionFunction)
    elseif barType == 15 then
      collectBar._titleText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_ING") .. "..")
      collectBar._useType = 0
      endFunction = nil
      checkActionFunction = checkEnterToHadumFieldAction
      collectBar:Show(isShow, progressTime, endFunction, checkActionFunction)
    elseif barType == 16 then
      ProgressBar_PreCoolTime_Show(isShow, progressTime, ToClient_EndPreCoolTime, param)
    end
  elseif 0 == barType then
    castingBar:Show(false, 0, nil, false, 0)
  elseif 1 == barType then
    ProgressBar_Product_Show(false, 0, nil)
  elseif barType == 16 then
    ProgressBar_PreCoolTime_Show(false, 0, nil, param)
  else
    collectBar:Show(false, 0, nil, nil)
  end
end
registerEvent("EventProgressBarShow", "EventProgressBarShow")
Panel_Product_Bar:RegisterUpdateFunc("ProgressBar_Product_Update")
Panel_Enchant_Bar:RegisterUpdateFunc("ProgressBar_Enchant_Update")
Panel_Casting_Bar:RegisterUpdateFunc("ProgressBar_Casting_Update")
Panel_Widget_EscapeBar_All:RegisterUpdateFunc("ProgressBar_PreCoolTime_Update")
collectBar:Init()
productBar:Init()
enchantBar:Init()
castingBar:Init()
preCoolTimeBar:Init()
