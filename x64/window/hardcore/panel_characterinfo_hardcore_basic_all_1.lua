function PaGlobal_CharacterInfo_HardCore_Basic:initialize()
  if self._initialize == true then
    return
  end
  self._ui.photoBg = UI.getChildControl(Panel_CharacterInfoBasic_HardCore_All, "Static_CharacterPhoto")
  self._ui.stc_CharPhoto = UI.getChildControl(self._ui.photoBg, "Static_CharPhoto")
  self._ui.btn_FacePhoto = UI.getChildControl(self._ui.photoBg, "Button_FacePhoto_PCUI")
  self._ui.stc_EnchantStackIcon = UI.getChildControl(self._ui.photoBg, "Static_EnchantStackIcon")
  self._ui.txt_EnchantStackIcon_Value = UI.getChildControl(self._ui.stc_EnchantStackIcon, "Static_EnchantStackValue")
  self._ui.txt_PlayerName = UI.getChildControl(self._ui.photoBg, "StaticText_PlayerName_Value")
  self._ui.txt_PlayerLv = UI.getChildControl(self._ui.photoBg, "StaticText_PlayerLevel_Value")
  self._ui.txt_HpTitle = UI.getChildControl(self._ui.photoBg, "StaticText_Health")
  self._ui.txt_HpVal = UI.getChildControl(self._ui.photoBg, "StaticText_Health_Val")
  self._ui.txt_MpTitle = UI.getChildControl(self._ui.photoBg, "StaticText_Mental")
  self._ui.txt_Mp_Val = UI.getChildControl(self._ui.photoBg, "StaticText_Mental_Val")
  self._ui.txt_LTTitle = UI.getChildControl(self._ui.photoBg, "StaticText_Weight")
  self._ui.txt_LTVal = UI.getChildControl(self._ui.photoBg, "StaticText_Weight_Val")
  self._ui.stc_PotenBg = UI.getChildControl(Panel_CharacterInfoBasic_HardCore_All, "Static_PotentialBg")
  self._ui.txt_AtkSpd = UI.getChildControl(self._ui.stc_PotenBg, "StaticText_Atk_Speed")
  self._ui.txt_AtkLv = UI.getChildControl(self._ui.stc_PotenBg, "StaticText_Atk_Speed_Level")
  self._ui.txt_MoveSpd = UI.getChildControl(self._ui.stc_PotenBg, "StaticText_Move_Speed")
  self._ui.txt_MoveLv = UI.getChildControl(self._ui.stc_PotenBg, "StaticText_Move_Speed_Level")
  self._ui.txt_Critical = UI.getChildControl(self._ui.stc_PotenBg, "StaticText_Cri")
  self._ui.txt_CriticalLv = UI.getChildControl(self._ui.stc_PotenBg, "StaticText_Cri_Level")
  self._ui.stc_CombatBg = UI.getChildControl(Panel_CharacterInfoBasic_HardCore_All, "Static_BattleBg")
  self._ui.txt_AtkTitle = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Atk")
  self._ui.txt_AwakenTitle = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Atk_Awaken")
  self._ui.txt_DefTitle = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Def")
  self._ui.txt_StaminaTitle = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Stamina")
  self._ui.txt_AtkTypeTitle = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Atk_Type")
  self._ui.txt_Atk = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Atk_Val")
  self._ui.txt_AwakenAtk = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Atk_Awaken_Val")
  self._ui.txt_Def = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Def_Val")
  self._ui.txt_AtkTypeRegist = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Atk_Type_Val")
  self._ui.txt_Stamina = UI.getChildControl(self._ui.stc_CombatBg, "StaticText_Stamina_Val")
  self._ui.btn_MyStatInfoBtn = UI.getChildControl(self._ui.stc_CombatBg, "Button_MyStat")
  local rightBg = UI.getChildControl(Panel_CharacterInfoBasic_HardCore_All, "Static_RightBG")
  local stc_Title = UI.getChildControl(rightBg, "Static_Title")
  self._ui.stc_TitleBg = UI.getChildControl(stc_Title, "StaticText_TitleBG")
  self._ui.txt_TitleName = UI.getChildControl(stc_Title, "StaticText_TitleName")
  self._ui.txt_TitleDesc = UI.getChildControl(stc_Title, "StaticText_TitleStory")
  self._ui.txt_Desc_ForGlobal = UI.getChildControl(stc_Title, "StaticText_TitleStory_forGlobal")
  self._ui.btn_Apply = UI.getChildControl(stc_Title, "Button_SelectButton")
  self._ui.txt_TitleCondi = UI.getChildControl(stc_Title, "StaticText_SelectedType")
  self._ui.list2_Title = UI.getChildControl(rightBg, "List2_TitleList")
  self._ui.txt_TitleName:SetShow(true)
  self._ui.txt_TitleDesc:SetShow(true)
  self._ui.txt_Desc_ForGlobal:SetShow(false)
  self._ui.btn_Apply:SetShow(false)
  self._ui.txt_TitleCondi:SetHorizonCenter()
  self._ui.txt_TitleCondi:SetSpanSize(0, self._ui.btn_Apply:GetSpanSize().y + 5)
  self._ui.txt_TitleCondi:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_TitleDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_HpTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_HpTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_HP"))
  self._ui.txt_MpTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_MpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_MP"))
  self._ui.txt_LTTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_LTTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_WEIGHT"))
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._selfPlayer = getSelfPlayer()
  self:registEventHandler()
  self:validate()
  self:setUnChangedData()
  self._initialize = true
end
function PaGlobal_CharacterInfo_HardCore_Basic:setUnChangedData()
  if Panel_CharacterInfoBasic_HardCore_All == nil then
    return
  end
  local classType = self._selfPlayer:getClassType()
  self._isAwakenWeaponContentsOpen = PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(classType)
  self._ui.txt_PlayerName:SetText(self._selfPlayer:getOriginalName())
  self._ui.txt_PlayerLv:SetText("( " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_WORKERLEVEL", "level", tostring(self._selfPlayer:get():getLevel())) .. " )")
  PaGlobalFunc_Util_SetClassSymbolIcon(self._ui.txt_PlayerLv, classType)
  self._ui.txt_PlayerLv:SetIgnore(false)
  if self._isConsole == true then
    self._ui.photoBg:addInputEvent("Mouse_On", "PaGlobal_CharInfoBasic_All:classDescriptionTooltip(" .. classType .. ")")
    self._ui.photoBg:addInputEvent("Mouse_Out", "PaGlobal_CharInfoBasic_All:classDescriptionTooltip()")
  end
  self._ui.txt_PlayerLv:addInputEvent("Mouse_On", "PaGlobal_CharInfoBasic_All:classDescriptionTooltip(" .. classType .. ")")
  self._ui.txt_PlayerLv:addInputEvent("Mouse_Out", "PaGlobal_CharInfoBasic_All:classDescriptionTooltip()")
  local POTEN_STRING = {
    [0] = "AttackSpeed_",
    [1] = "MoveSpeed_",
    [2] = "Critcal_"
  }
  local potenSlotBG_Temp = UI.getChildControl(self._ui.stc_PotenBg, "Static_SlotBg")
  local potenSlot_Temp = UI.getChildControl(self._ui.stc_PotenBg, "Static_Slot")
  for potenIdx = 0, #POTEN_STRING do
    local tempData = {
      title = nil,
      val = nil,
      slotBg = {},
      slot = {},
      toolTipDesc = ""
    }
    local battleSpeed = NewClassData.newClass_CategoryType[classType]._battleSpeed
    if self._ENUM_POTEN.ATKSPD == potenIdx then
      tempData.title = self._ui.txt_AtkSpd
      tempData.val = self._ui.txt_AtkLv
      local classString = PaGlobal_CharInfoBasic_All:getClassStringByAtkType(battleSpeed)
      tempData.toolTipDesc = classString
    elseif self._ENUM_POTEN.MOVESPD == potenIdx then
      tempData.title = self._ui.txt_MoveSpd
      tempData.val = self._ui.txt_MoveLv
      tempData.toolTipDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TXT_DESC_2")
    elseif self._ENUM_POTEN.CRITICAL == potenIdx then
      tempData.title = self._ui.txt_Critical
      tempData.val = self._ui.txt_CriticalLv
      tempData.toolTipDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TXT_DESC_3")
    end
    tempData.toolTipDesc = tempData.toolTipDesc .. "\n"
    for idx = 0, self._MAX_POTENCIALSLOT + 1 do
      local percentString = tostring(ToClient_GetTranslateStatPercent(potenIdx, battleSpeed + 1, idx))
      percentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_POTENTIAL_DEPTH_COUNT", "depth", idx, "count", percentString) .. "%\n"
      tempData.toolTipDesc = tempData.toolTipDesc .. percentString
    end
    tempData.title:SetIgnore(false)
    tempData.title:SetSize(tempData.title:GetTextSizeX(), tempData.title:GetSizeY())
    tempData.title:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_HardCore_All_Potential(true, " .. tostring(potenIdx) .. ")")
    tempData.title:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_HardCore_All_Potential(false)")
    local padding = 5
    for slotIdx = 0, self._MAX_POTENCIALSLOT do
      local slotBg = UI.createControl(__ePAUIControl_Static, self._ui.stc_PotenBg, "Static_" .. POTEN_STRING[potenIdx] .. "SlotBG_" .. slotIdx)
      local slot = UI.createControl(__ePAUIControl_Static, self._ui.stc_PotenBg, "Static_" .. POTEN_STRING[potenIdx] .. "Slot_" .. slotIdx)
      slot:SetShow(false)
      CopyBaseProperty(potenSlotBG_Temp, slotBg)
      CopyBaseProperty(potenSlot_Temp, slot)
      local sizeY = tempData.title:GetSizeY() + padding
      slotBg:SetSpanSize(tempData.title:GetSpanSize().x + (slotIdx * (slotBg:GetSizeX() + 7) + slotIdx * 5), tempData.val:GetSpanSize().y + sizeY)
      slot:SetSpanSize(tempData.title:GetSpanSize().x + (slotIdx * (slot:GetSizeX() + 7) + slotIdx * 5), tempData.val:GetSpanSize().y + sizeY)
      tempData.slotBg[slotIdx] = slotBg
      tempData.slot[slotIdx] = slot
    end
    self._potentialData[potenIdx] = tempData
  end
  self:setBattleStatUIPos(true)
  self:setAtkType()
  local index = PaGlobal_CharacterInfo_HardCore_All._HARDCORE_CHARACTERINFO_TABINDEX._basic
  PaGlobal_CharacterInfo_HardCore_initTab(index, Panel_CharacterInfoBasic_HardCore_All, PaGlobal_CharacterInfo_HardCore_Basic_Update)
end
function PaGlobal_CharacterInfo_HardCore_Basic:setBattleStatUIPos(isAwaken)
  if Panel_CharacterInfoBasic_HardCore_All == nil or self._checkAwaken == isAwaken then
    return
  end
  local BattileInfoTitleSpanY = 5
  local gap = 35
  local isShyWomen = __eClassType_ShyWaman == self._selfPlayer:getClassType()
  self._checkAwaken = isAwaken
  self._ui.txt_AwakenTitle:SetShow(isAwaken)
  self._ui.txt_AwakenAtk:SetShow(isAwaken)
  local statUI = {
    [1] = self._ui.txt_AtkTitle,
    [2] = nil,
    [3] = self._ui.txt_DefTitle,
    [4] = self._ui.txt_AtkTypeTitle,
    [5] = self._ui.txt_StaminaTitle
  }
  if true == isAwaken then
    statUI[2] = self._ui.txt_AwakenTitle
    if true == isShyWomen then
      self._ui.txt_AwakenTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SHYSTAT_1"))
    else
      self._ui.txt_AwakenTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_AWAKENATTACK"))
    end
  end
  local uiCount = 1
  for i = 1, 5 do
    if nil ~= statUI[i] then
      statUI[i]:SetSpanSize(statUI[i]:GetSpanSize().x, 0)
      statUI[i]:SetSpanSize(self._statOriginSpanX, BattileInfoTitleSpanY + statUI[i]:GetSpanSize().y + gap * uiCount)
      uiCount = uiCount + 1
    end
  end
  self._ui.txt_Atk:SetSpanSize(self._statOriginSpanX, self._ui.txt_AtkTitle:GetSpanSize().y)
  self._ui.txt_AwakenAtk:SetSpanSize(self._statOriginSpanX, self._ui.txt_AwakenTitle:GetSpanSize().y)
  self._ui.txt_Def:SetSpanSize(self._statOriginSpanX, self._ui.txt_DefTitle:GetSpanSize().y)
  self._ui.txt_AtkTypeRegist:SetSpanSize(self._statOriginSpanX, self._ui.txt_AtkTypeTitle:GetSpanSize().y)
  self._ui.txt_Stamina:SetSpanSize(self._statOriginSpanX, self._ui.txt_StaminaTitle:GetSpanSize().y)
end
function PaGlobal_CharacterInfo_HardCore_Basic:setAtkType()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local classType = selfPlayer:getClassType()
  local attackType = NewClassData.newClass_CategoryType[classType]._attackType
  if attackType == __eAttackTypeMagical then
    self._ui.txt_AtkTypeRegist:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ATKTYPE_MAGIC"))
  elseif attackType == __eAttackTypeRange then
    self._ui.txt_AtkTypeRegist:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RANGER_SUCCESSION_COMBAT_TYPE"))
  else
    self._ui.txt_AtkTypeRegist:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WARRIOR_AWAKEN_COMBAT_TYPE"))
  end
end
function PaGlobal_CharacterInfo_HardCore_Basic:classDescriptionTooltip(classType)
  if nil == classType then
    TooltipSimple_Hide()
    return
  end
  local _className = NewClassData.newClass_String[classType]._classType2String
  local _classDesc = getClassDescription(classType, __ePlayerCreateNormal)
  TooltipSimple_Show(self._ui.txt_PlayerLv, _className, _classDesc)
end
function PaGlobal_CharacterInfo_HardCore_Basic:registEventHandler()
  if Panel_CharacterInfoBasic_HardCore_All == nil then
    return
  end
  registerEvent("FromClient_SelfPlayerExpChanged", "FromClient_CharInfoBasic_HardCore_All_LevelUpdate")
  registerEvent("EventSelfPlayerLevelUp", "FromClient_CharInfoBasic_HardCore_All_LevelUpdate")
  registerEvent("FromClient_SelfPlayerHpChanged", "FromClient_CharInfoBasic_HardCore_All_HpUpdate")
  registerEvent("FromClient_SelfPlayerMpChanged", "FromClient_CharInfoBasic_HardCore_All_MpUpdate")
  registerEvent("FromClient_InventoryUpdate", "FromClient_CharInfoBasic_HardCore_All_WeightUpdate")
  registerEvent("FromClient_WeightChanged", "FromClient_CharInfoBasic_HardCore_All_WeightUpdate")
  registerEvent("FromClient_UpdateSelfPlayerStatPoint", "FromClient_CharInfoBasic_HardCore_All_PotentialUpdate")
  registerEvent("EventEquipmentUpdate", "FromClient_CharInfoBasic_HardCore_All_BattleStatUpdate")
  self._ui.btn_FacePhoto:SetIgnore(false)
  self._ui.btn_FacePhoto:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoBasic_HardCore_All_TakePhoto()")
  self._ui.btn_FacePhoto:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_HardCore_All_FacePhoto(true)")
  self._ui.btn_FacePhoto:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_HardCore_All_FacePhoto(false)")
  self._ui.stc_EnchantStackIcon:SetIgnore(false)
  self._ui.stc_EnchantStackIcon:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_HardCore_EnchantStack( true )")
  self._ui.stc_EnchantStackIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_HardCore_EnchantStack( false )")
  local localFunc_disableIgnore_SetTextSize = function(control)
    if nil ~= control then
      control:SetIgnore(false)
      control:SetSize(control:GetTextSizeX(), control:GetSizeY())
      control:SetEnableArea(0, 0, control:GetTextSizeX(), control:GetSizeY())
      control:ComputePos()
    end
  end
  localFunc_disableIgnore_SetTextSize(self._ui.txt_HpTitle)
  localFunc_disableIgnore_SetTextSize(self._ui.txt_MpTitle)
  localFunc_disableIgnore_SetTextSize(self._ui.txt_LTTitle)
  self._ui.txt_HpTitle:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_HardCore_All_BasicStat(true , 0 )")
  self._ui.txt_MpTitle:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_HardCore_All_BasicStat(true , 1 )")
  self._ui.txt_LTTitle:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoBasic_HardCore_All_BasicStat(true , 2 )")
  self._ui.txt_HpTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_HardCore_All_BasicStat(false)")
  self._ui.txt_MpTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_HardCore_All_BasicStat(false)")
  self._ui.txt_LTTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoBasic_HardCore_All_BasicStat(false)")
  registerEvent("FromClient_TitleInfo_HardCore_UpdateList", "PaGlobal_CharacterInfo_HardCore_Basic_UpdateTitleList")
  self._ui.list2_Title:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_CharInfoTitle_HardCore_List2Update")
  self._ui.list2_Title:registEvent(__ePAUIList2EventType_ScrollAnimationStop, "FromClient_CharInfoTitle_List2AnimationStop")
  self._ui.list2_Title:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list2_Title:setMinScrollBtnSize(float2(5, 50 * self._ui.list2_Title:GetScale().y))
end
function PaGlobal_CharacterInfo_HardCore_Basic:validate()
  self._ui.photoBg:isValidate()
  self._ui.stc_CharPhoto:isValidate()
  self._ui.btn_FacePhoto:isValidate()
  self._ui.stc_EnchantStackIcon:isValidate()
  self._ui.txt_EnchantStackIcon_Value:isValidate()
  self._ui.txt_PlayerName:isValidate()
  self._ui.txt_PlayerLv:isValidate()
  self._ui.txt_HpTitle:isValidate()
  self._ui.txt_HpVal:isValidate()
  self._ui.txt_MpTitle:isValidate()
  self._ui.txt_Mp_Val:isValidate()
  self._ui.txt_LTTitle:isValidate()
  self._ui.txt_LTVal:isValidate()
  self._ui.stc_PotenBg:isValidate()
  self._ui.txt_AtkSpd:isValidate()
  self._ui.txt_AtkLv:isValidate()
  self._ui.txt_MoveSpd:isValidate()
  self._ui.txt_MoveLv:isValidate()
  self._ui.txt_Critical:isValidate()
  self._ui.txt_CriticalLv:isValidate()
  self._ui.stc_CombatBg:isValidate()
  self._ui.txt_AtkTitle:isValidate()
  self._ui.txt_AwakenTitle:isValidate()
  self._ui.txt_DefTitle:isValidate()
  self._ui.txt_StaminaTitle:isValidate()
  self._ui.txt_AtkTypeTitle:isValidate()
  self._ui.txt_Atk:isValidate()
  self._ui.txt_AwakenAtk:isValidate()
  self._ui.txt_Def:isValidate()
  self._ui.txt_AtkTypeRegist:isValidate()
  self._ui.txt_Stamina:isValidate()
  self._ui.btn_MyStatInfoBtn:isValidate()
  self._ui.stc_TitleBg:isValidate()
  self._ui.txt_TitleName:isValidate()
  self._ui.txt_TitleDesc:isValidate()
  self._ui.txt_Desc_ForGlobal:isValidate()
  self._ui.btn_Apply:isValidate()
  self._ui.txt_TitleCondi:isValidate()
  self._ui.list2_Title:isValidate()
end
function PaGlobal_CharacterInfo_HardCore_Basic:prepareOpen()
  if Panel_CharacterInfoBasic_HardCore_All == nil then
    return
  end
  self:open()
end
function PaGlobal_CharacterInfo_HardCore_Basic:open()
  if Panel_CharacterInfoBasic_HardCore_All == nil then
    return
  end
  Panel_CharacterInfoBasic_HardCore_All:SetShow(true)
end
function PaGlobal_CharacterInfo_HardCore_Basic:prepareClose()
  if Panel_CharacterInfoBasic_HardCore_All == nil then
    return
  end
  self:close()
end
function PaGlobal_CharacterInfo_HardCore_Basic:close()
  if Panel_CharacterInfoBasic_HardCore_All == nil then
    return
  end
  Panel_CharacterInfoBasic_HardCore_All:SetShow(false)
end
function PaGlobal_CharacterInfo_HardCore_Basic:update()
  if Panel_CharacterInfoBasic_HardCore_All == nil then
    return
  end
  PaGlobal_CharInfoBasic_All_UpdateCharPhoto(PaGlobal_CharacterInfo_HardCore_Basic)
  FromClient_CharInfoBasic_HardCore_All_LevelUpdate()
  PaGlobalFunc_CharInfoBasic_HardCore_All_HpUpdate()
  PaGlobalFunc_CharInfoBasic_HardCore_All_MpUpdate()
  FromClient_CharInfoBasic_HardCore_All_WeightUpdate()
  FromClient_CharInfoBasic_HardCore_All_PotentialUpdate()
  FromClient_CharInfoBasic_HardCore_All_BattleStatUpdate()
  self:updateTitleList()
  local currentTitleKey = ToClient_GetHardCoreSelfPlayerCurrentTitleKey()
  self:setTitleText(currentTitleKey)
end
function PaGlobal_CharacterInfo_HardCore_Basic:getPlayTimeString(isOnlyHour)
  if Panel_CharacterInfoBasic_HardCore_All == nil then
    return
  end
  local totalSecond = Int64toInt32(ToClient_GetUserPlayTime())
  local daySecond = 86400
  local hourSecond = 3600
  local day = math.floor(totalSecond / daySecond)
  if day <= 0 then
    day = 0
  end
  local remainTime = totalSecond - day * daySecond
  local hour = math.floor(remainTime / hourSecond)
  if hour <= 0 then
    hour = 0
  end
  if isOnlyHour == true then
    hour = hour + day * 24
  end
  local totalstring
  if day > 0 then
    totalstring = tostring(day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY") .. " " .. tostring(hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR")
  else
    totalstring = tostring(hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR")
  end
  return totalstring
end
function PaGlobal_CharacterInfo_HardCore_Basic:updateTitleList()
  if Panel_CharacterInfoBasic_HardCore_All == nil then
    return
  end
  local titleCount = ToClient_getHardCoreTitleCount()
  self._ui.list2_Title:getElementManager():clearKey()
  for index = 0, titleCount - 1 do
    local key = ToClient_getHardCoreTitleKeyByIndex(index)
    if key ~= 0 then
      self._ui.list2_Title:getElementManager():pushKey(toInt64(0, key))
    end
  end
  self._ui.list2_Title:setMinScrollBtnSize(float2(5, 50 * self._ui.list2_Title:GetScale().y))
end
function PaGlobal_CharacterInfo_HardCore_Basic:alignTitleTextForGlobal()
  local serviceType = getGameServiceResType()
  if CppEnums.ServiceResourceType.eServiceResourceType_KR == serviceType or CppEnums.ServiceResourceType.eServiceResourceType_CN == serviceType or CppEnums.ServiceResourceType.eServiceResourceType_Dev == serviceType then
    return
  end
  local titleSizeX = 395 * self._ui.txt_TitleName:GetScale().x
  self._ui.txt_TitleName:SetSize(titleSizeX - 5, self._ui.txt_Desc_ForGlobal:GetSizeY())
  self._ui.txt_TitleName:SetHorizonCenter()
  self._ui.txt_TitleName:SetSpanSize(0, 15)
  self._ui.txt_TitleName:ComputePos()
end
function PaGlobal_CharacterInfo_HardCore_Basic:setTitleText(key)
  if nil == key then
    return
  end
  if key == 0 then
    self._ui.txt_TitleName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_TITLE_NOAPPLIEDTITLEYET"))
    self._ui.txt_TitleDesc:SetShow(false)
    self._ui.txt_TitleCondi:SetShow(false)
    self._ui.txt_TitleName:SetFontColor(Defines.Color.C_FFF5BA3A)
  else
    local desc = ToClient_getHardCoreTitleDescByKey(key)
    local condition = ToClient_getHardCoreTitleConditionByKey(key)
    local conditionText = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TITLE_CONDITION") .. condition
    local name = ToClient_getHardCoreTitleNameByKey(key)
    local fontColor = ToClient_GetHardCoreTitleGradeColor(key)
    self._ui.txt_TitleName:SetText(name)
    self._ui.txt_TitleName:SetFontColor(fontColor)
    self._ui.txt_TitleDesc:SetText(desc)
    self._ui.txt_TitleCondi:SetText(conditionText)
    self._ui.txt_TitleDesc:SetShow(true)
    self._ui.txt_TitleCondi:SetShow(true)
  end
  local scaleY = self._ui.txt_TitleDesc:GetScale().y
  if self._ui.txt_TitleDesc:GetTextSizeY() * scaleY > self._ui.txt_TitleDesc:GetSizeY() then
    UI.setLimitTextAndAddTooltip(self._ui.txt_TitleDesc, "", self._ui.txt_TitleDesc:GetText())
  elseif true == self._ui.txt_TitleDesc:IsLimitText() then
    self._ui.txt_TitleDesc:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_TitleDesc:SetText(self._ui.txt_TitleDesc:GetText())
  end
end
