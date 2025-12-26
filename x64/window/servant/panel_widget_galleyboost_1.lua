function PaGlobal_GalleyBoost_All:initialize()
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  if self._initialize == true then
    return
  end
  self._ui._btn_main = UI.getChildControl(Panel_Widget_GalleyBoost, "Button_GameStart")
  self._ui._txt_desc = UI.getChildControl(self._ui._btn_main, "MultilineText_1")
  self._ui._txt_memberCount = UI.getChildControl(self._ui._btn_main, "StaticText_MemCount")
  self._ui._stc_skill = UI.getChildControl(Panel_Widget_GalleyBoost, "Static_SkillIcon")
  self._ui._stc_effect = UI.getChildControl(Panel_Widget_GalleyBoost, "Static_Effect")
  self._ui._btn_showMember = UI.getChildControl(Panel_Widget_GalleyBoost, "Button_MiniView_Show")
  self._ui._stc_coolTime = UI.createCustomControl("StaticCooltime", self._ui._stc_skill, "Static_Cooltime")
  self._ui._stc_coolTime:SetMonoTone(true)
  self._ui._stc_coolTime:SetSize(self._ui._stc_skill:GetSizeX(), self._ui._stc_skill:GetSizeY())
  self._ui._stc_coolTime:SetIgnore(true)
  self._ui._stc_coolTime:SetShow(false)
  self._ui._txt_coolTime = UI.createControl(__ePAUIControl_StaticText, self._ui._stc_coolTime, "StaticText_Cooltime")
  self._ui._txt_coolTime:SetSize(self._ui._stc_skill:GetSizeX(), self._ui._stc_skill:GetSizeY())
  self._ui._txt_coolTime:SetIgnore(true)
  self._ui._txt_coolTime:SetShow(true)
  self._ui._txt_coolTime:SetTextHorizonCenter()
  self._ui._txt_coolTime:SetTextVerticalCenter()
  self:validate()
  self:registEventHandler()
  self:clear()
  Panel_Widget_GalleyBoost:ComputePos()
  self._initialize = true
end
function PaGlobal_GalleyBoost_All:clear()
  for i = 1, 3 do
    if i == self._stateType.None then
      self._stateList[i] = true
    else
      self._stateList[i] = false
    end
  end
  self._currentState = 0
end
function PaGlobal_GalleyBoost_All:validate()
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  self._ui._btn_main:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._txt_memberCount:isValidate()
  self._ui._stc_skill:isValidate()
  self._ui._stc_coolTime:isValidate()
  self._ui._txt_coolTime:isValidate()
  self._ui._stc_effect:isValidate()
  self._ui._btn_showMember:isValidate()
end
function PaGlobal_GalleyBoost_All:registEventHandler()
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  Panel_Widget_GalleyBoost:RegisterUpdateFunc("PaGlobal_GalleyBoost_All_UpdatePerFrame")
  ActionChartEventBindFunction(Defines.ActionChartLua.GalleyShipBoostOn, PaGlobal_GalleyBoost_All_ToActionChartGalleyShipBoostOn)
  ActionChartEventBindFunction(Defines.ActionChartLua.GalleyShipBoostOff, PaGlobal_GalleyBoost_All_ToActionChartGalleyShipBoostOff)
  self._ui._btn_showMember:addInputEvent("Mouse_LUp", "PaGlobal_GalleyBoost_All:uphandlerShowMemberToggleButton()")
  self._ui._stc_skill:addInputEvent("Mouse_On", "PaGlobal_GalleyBoost_All:onhandlerSkillIconUI()")
  self._ui._stc_skill:addInputEvent("Mouse_Out", "PaGlobal_GalleyBoost_All:outhandlerSkillIconUI()")
end
function PaGlobal_GalleyBoost_All_setKeyChange()
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  if Panel_Widget_GalleyBoost:GetShow() == false then
    return
  end
  PaGlobal_GalleyBoost_All._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GALLYPADDLE_GAMESTART"))
end
function PaGlobal_GalleyBoost_All:prepareOpen()
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  self:clear()
  self:open()
end
function PaGlobal_GalleyBoost_All:open()
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  Panel_Widget_GalleyBoost:SetShow(true)
  local selfPlayerWrapper = getSelfPlayer()
  self._isDriver = selfPlayerWrapper:get():isVehicleDriver()
  self:updateIconUI()
  self:updateShowMemberToggleButton()
end
function PaGlobal_GalleyBoost_All:prepareClose()
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  self:close()
end
function PaGlobal_GalleyBoost_All:close()
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  Panel_Widget_GalleyBoost:SetShow(false)
end
function PaGlobal_GalleyBoost_All:UpdatePerFrame(deltaTime)
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  self:updateSkillCoolTime(deltaTime)
end
function PaGlobal_GalleyBoost_All:updateIconUI()
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  if self._initialize == false then
    return
  end
  if Panel_Widget_GalleyBoost:GetShow() == false then
    return
  end
  local currentState = self._stateType.None
  for i = 1, 3 do
    if self._stateList[i] == true then
      currentState = i
    end
  end
  if self._currentState == currentState then
    return
  end
  self._currentState = currentState
  self._ui._stc_effect:EraseAllEffect()
  self._ui._stc_effect:AddEffect("FUI_Mini_Game_Galley_Wait_01A", true, 0, 0)
  if self._isDriver == true and currentState == self._stateType.None then
    self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GALLYPADDLE_GAMESTART"))
  elseif currentState == self._stateType.None then
    self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GALLYPADDLE_VOYAGE"))
  elseif currentState == self._stateType.PaddleMiniGame then
    self._ui._stc_effect:AddEffect("FUI_Mini_Game_Galley_Ping_02A", true, 0, 0)
    self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GALLYPADDLE_GAMEPROGRESS"))
    self:updatePlayMemberCountUI()
  elseif currentState == self._stateType.Boost then
    self._ui._stc_effect:AddEffect("FUI_Mini_Game_Galley_Ping_03A", true, 0, 0)
    self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GALLYPADDLE_SKILLPROGRESS"))
    audioPostEvent_SystemUi(11, 128)
    _AudioPostEvent_SystemUiForXBOX(11, 128)
  end
  if self._isDriver == true then
    self._ui._stc_skill:ChangeTextureInfoNameAsync("icon/new_icon/04_pc_skill/06_riding_skill/riding_skill_0093.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_skill, 0, 0, 44, 44)
    self._ui._stc_skill:getBaseTexture():setUV(x1, y1, x2, y2)
    if currentState == self._stateType.PaddleMiniGame then
      self._ui._stc_skill:SetMonoTone(true)
    else
      self._ui._stc_skill:SetMonoTone(false)
    end
  else
    if currentState == self._stateType.Boost then
      self._ui._stc_skill:ChangeTextureInfoTextureIDAsync("Combine_Etc_MiniGame_16_Widget_Icon_Ship_Rapid")
    else
      self._ui._stc_skill:ChangeTextureInfoTextureIDAsync("Combine_Etc_MiniGame_16_Widget_Icon_Ship")
    end
    self._ui._stc_skill:SetMonoTone(false)
  end
  self._ui._stc_skill:setRenderTexture(self._ui._stc_skill:getBaseTexture())
end
function PaGlobal_GalleyBoost_All:updateSkillCoolTime(deltaTime)
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  if self._isDriver == true then
    local coolTickTime = Int64toInt32(ToClient_GetPaddleMiniGameCoolTickTime())
    local moveTickTime = Int64toInt32(getUtc64() - ToClient_GetLastPaddleMiniGameTime()) * 1000
    local remainCoolTickTime = coolTickTime - moveTickTime
    if remainCoolTickTime > 0 then
      if self._lastCoolTimeInt ~= math.ceil(remainCoolTickTime) then
        self._innerTimeForCoolTime = 0
        self._lastCoolTimeInt = math.ceil(remainCoolTickTime)
      end
      local coolTimeRate = (remainCoolTickTime - self._innerTimeForCoolTime) / coolTickTime
      self._innerTimeForCoolTime = self._innerTimeForCoolTime + deltaTime * 1000
      self._ui._stc_coolTime:SetShow(true)
      self._ui._txt_coolTime:SetText(Util.Time.timeFormatting(math.floor(remainCoolTickTime / 1000)))
      self._ui._stc_coolTime:UpdateCoolTime(coolTimeRate)
    else
      self._ui._stc_coolTime:SetShow(false)
    end
  else
    self._ui._stc_coolTime:SetShow(false)
  end
end
function PaGlobal_GalleyBoost_All:updatePlayMemberCountUI()
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  self._ui._txt_memberCount:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GALLYPADDLE_MEMCOUNT", "currentMemCount", PaGlobal_GalleyMember_All_GetPlayerCount(), "maxMemCount", 10))
end
function PaGlobal_GalleyBoost_All:setLastStartMiniGameTime(utcTime32)
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  self._lastStartMiniGameTime = utcTime32
end
function PaGlobal_GalleyBoost_All:setState(stateType, isActive)
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  self._stateList[stateType] = isActive
  self:updateIconUI()
end
function PaGlobal_GalleyBoost_All:uphandlerShowMemberToggleButton()
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  if PaGlobal_GalleyMember_All_IsShow() == true then
    PaGlobal_GalleyMember_All_SimpleClose()
  else
    PaGlobal_GalleyMember_All_SimpleOpen()
  end
  self:updateShowMemberToggleButton()
end
function PaGlobal_GalleyBoost_All:onhandlerSkillIconUI()
  local skillWrapper = getVehicleSkillStaticStatus(94)
  if skillWrapper == nil then
    return
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    PaGlobal_Tooltip_Skill_Servant_All_Open(skillWrapper, self._ui._stc_skill, false)
  else
    PaGlobal_Tooltip_Servant_Open(skillWrapper, self._ui._stc_skill, false)
  end
end
function PaGlobal_GalleyBoost_All:outhandlerSkillIconUI()
  if true == _ContentsGroup_NewUI_Tooltip_All then
    PaGlobal_Tooltip_Skill_Servant_All_Close()
  else
    PaGlobal_Tooltip_Servant_Close()
  end
end
function PaGlobal_GalleyBoost_All:updateShowMemberToggleButton()
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  if self._initialize == false then
    return
  end
  if PaGlobal_GalleyMember_All_IsShow() == true then
    self._ui._btn_showMember:ChangeTextureInfoTextureIDAsync("Combine_Btn_Checkbox_Down_cliick_2", __eUITextureTypeClick)
    self._ui._btn_showMember:ChangeTextureInfoTextureIDAsync("Combine_Btn_Checkbox_Down_Over_2", __eUITextureTypeOn)
    self._ui._btn_showMember:ChangeTextureInfoTextureIDAsync("Combine_Btn_Checkbox_Down_Nomal_2")
  else
    self._ui._btn_showMember:ChangeTextureInfoTextureIDAsync("Combine_Btn_Checkbox_Up_cliick_2", __eUITextureTypeClick)
    self._ui._btn_showMember:ChangeTextureInfoTextureIDAsync("Combine_Btn_Checkbox_Up_Over_2", __eUITextureTypeOn)
    self._ui._btn_showMember:ChangeTextureInfoTextureIDAsync("Combine_Btn_Checkbox_Up_Nomal_2")
  end
  self._ui._btn_showMember:setRenderTexture(self._ui._btn_showMember:getBaseTexture())
end
