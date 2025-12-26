local UI_PSFT = CppEnums.PAUI_SHOW_FADE_TYPE
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
_PA_ASSERT_NAME(NewClassData.NewClassType == __eClassType_PDKL, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \236\150\180\235\185\132\236\138\164\236\155\144 \235\182\132\235\166\172\237\152\149 \236\132\156\235\184\140 \236\158\144\236\155\144 UI", "\236\161\176\234\180\145\235\175\188")
PaGlobal_ClassResource_All = {
  _ui = {
    _txt_resourceText = nil,
    _txt_resourceValue = nil,
    _stc_sorcererBG = nil,
    _txt_sorcerer_PopMSG = nil,
    _txt_sorcerer_Help = nil,
    _stc_fighterBG = nil,
    _stc_fighter_Point1 = nil,
    _stc_fighter_Point2 = nil,
    _stc_fighter_Point3 = nil,
    _stc_shyBG = nil,
    _stc_shy_Point1 = nil,
    _stc_shy_Point2 = nil,
    _stc_shy_Point3 = nil,
    _stc_maehwaBG = nil,
    _stc_maehwa_Point1 = nil,
    _stc_maehwa_Point2 = nil,
    _stc_maehwa_Point3 = nil,
    _stc_maehwa_Point4 = nil,
    _stc_novaBG = nil,
    _txt_nova_Percent = nil,
    _stc_nova_Progress = nil,
    _stc_corsairBG = nil,
    _stc_corsair_Bomb = nil,
    _stc_corsair_Bazooka = nil,
    _stc_corsair_Cannon = nil,
    _stc_kunoBG = nil,
    _stc_kuno_State0 = nil,
    _stc_kuno_State1 = nil,
    _stc_kuno_State2 = nil,
    _stc_kuno_State3 = nil,
    _stc_kuno_State4 = nil,
    _stc_kuno_State5 = nil,
    _stc_kuno_State6 = nil,
    _stc_kuno_State7 = nil,
    _stc_drakaniaBG = nil,
    _stc_drakania_Progress = nil,
    _stc_drakania_Effect = nil,
    _stc_drakania_Effect2 = nil,
    _stc_drakaniaBG_Awaken = nil,
    _stc_drakania_FormIconBig = nil,
    _stc_drakania_FormIconSmall = nil,
    _stc_maeguBG = nil,
    _stc_DeadEyeBG = nil,
    _stc_pjkdBG = nil,
    _stc_pjkd_GuageBG = nil,
    _stc_pjkd_ProgressBG = nil,
    _stc_pjkd_Progress = nil,
    _stc_pjkd_Effect = nil
  },
  _curClassType = __eClassType_Count,
  _beforeCount = -1,
  _sorcerer_effect_1stChk = false,
  _sorcerer_effect_2ndChk = false,
  _sorcerer_effect_3rdChk = false,
  _maehwa_isShowEffect = false,
  _nova_effectTime = 0,
  _nova_maxNovaEffectTime = 0.01,
  _nova_isProgressUp = false,
  _nova_curProgress = 0,
  _nova_maxProgress = 0,
  _nova_isEffectUpdate = false,
  _nova_isProgressFull = false,
  ENUM_CORSAIR_RESOURCE_ICON_TYPE = {
    _TYPE_BOMB = 0,
    _TYPE_BAZZOKA = 1,
    _TYPE_CANNON = 2
  },
  _corsair_currentResourceType = 0,
  _drakania_isShowLoopEffect = false,
  _drakaniaAwaken_isDragonForm = nil,
  _drakaniaAwaken_formChangeStep = 0,
  _drakaniaAwaken_effectTime = 0,
  _drakaniaAwaken_effectMaxTime = 0.01,
  _drakaniaAwaken_effectStepTime = 0,
  _drakaniaAwaken_step1Time = 0.1,
  _drakaniaAwaken_step2Time = 0.2,
  _drakaniaAwaken_bigIconBasePos = {x = 0, y = 0},
  _drakaniaAwaken_smallIconBasePos = {x = 0, y = 0},
  _deadEye_IsMarniBullet = false,
  _pjkd_curProgress = 0,
  _pjkd_isFormChange = false,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_ClassResource_All_Init")
registerEvent("FromClient_StartSequencePlayerControlable", "FromClient_StartSequencePlayerControlable_ClassResource")
function FromClient_StartSequencePlayerControlable_ClassResource()
  Panel_ClassResource:SetAlpha(0)
  local aniInfo = UIAni.AlphaAnimation(1, Panel_ClassResource, 0, 0.8)
  aniInfo:SetDisableWhileAni(true)
end
function FromClient_ClassResource_All_Init()
  PaGlobal_ClassResource_All:initialize()
end
function PaGlobal_ClassResource_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._txt_resourceText = UI.getChildControl(Panel_ClassResource, "StaticText_ResourceText")
  self._ui._txt_resourceValue = UI.getChildControl(Panel_ClassResource, "StaticText_Count")
  self._ui._stc_sorcererBG = UI.getChildControl(Panel_ClassResource, "Static_SorcererBG")
  self._ui._txt_sorcerer_PopMSG = UI.getChildControl(self._ui._stc_sorcererBG, "StaticText_PhantomPopHelp")
  self._ui._txt_sorcerer_Help = UI.getChildControl(self._ui._stc_sorcererBG, "StaticText_PhantomHelp")
  self._ui._stc_fighterBG = UI.getChildControl(Panel_ClassResource, "Static_FighterBG")
  self._ui._stc_fighter_Point1 = UI.getChildControl(self._ui._stc_fighterBG, "Static_Point1")
  self._ui._stc_fighter_Point2 = UI.getChildControl(self._ui._stc_fighterBG, "Static_Point2")
  self._ui._stc_fighter_Point3 = UI.getChildControl(self._ui._stc_fighterBG, "Static_Point3")
  self._ui._stc_shyBG = UI.getChildControl(Panel_ClassResource, "Static_ShyBG")
  self._ui._stc_shy_Point1 = UI.getChildControl(self._ui._stc_shyBG, "Static_Point1")
  self._ui._stc_shy_Point2 = UI.getChildControl(self._ui._stc_shyBG, "Static_Point2")
  self._ui._stc_shy_Point3 = UI.getChildControl(self._ui._stc_shyBG, "Static_Point3")
  self._ui._stc_maehwaBG = UI.getChildControl(Panel_ClassResource, "Static_MaehwaBG")
  self._ui._stc_maehwa_Point1 = UI.getChildControl(self._ui._stc_maehwaBG, "Static_Left")
  self._ui._stc_maehwa_Point2 = UI.getChildControl(self._ui._stc_maehwaBG, "Static_Middle")
  self._ui._stc_maehwa_Point3 = UI.getChildControl(self._ui._stc_maehwaBG, "Static_Right")
  self._ui._stc_maehwa_Point4 = UI.getChildControl(self._ui._stc_maehwaBG, "Static_Main")
  self._ui._stc_novaBG = UI.getChildControl(Panel_ClassResource, "Static_NovaBG")
  self._ui._txt_nova_Percent = UI.getChildControl(self._ui._stc_novaBG, "StaticText_Percent")
  self._ui._stc_nova_Progress = UI.getChildControl(self._ui._stc_novaBG, "CircularProgress_Nova")
  self._ui._stc_corsairBG = UI.getChildControl(Panel_ClassResource, "Static_CorsairBG")
  self._ui._stc_corsair_Bomb = UI.getChildControl(self._ui._stc_corsairBG, "Static_Bomb1")
  self._ui._stc_corsair_Bazooka = UI.getChildControl(self._ui._stc_corsairBG, "Static_Bomb2")
  self._ui._stc_corsair_Cannon = UI.getChildControl(self._ui._stc_corsairBG, "Static_Bomb3")
  self._ui._stc_kunoBG = UI.getChildControl(Panel_ClassResource, "Static_Kuno_RebootBG")
  self._ui._stc_kuno_State0 = UI.getChildControl(self._ui._stc_kunoBG, "Static_State_0")
  self._ui._stc_kuno_State1 = UI.getChildControl(self._ui._stc_kunoBG, "Static_State_1")
  self._ui._stc_kuno_State2 = UI.getChildControl(self._ui._stc_kunoBG, "Static_State_2")
  self._ui._stc_kuno_State3 = UI.getChildControl(self._ui._stc_kunoBG, "Static_State_3")
  self._ui._stc_kuno_State4 = UI.getChildControl(self._ui._stc_kunoBG, "Static_State_4")
  self._ui._stc_kuno_State5 = UI.getChildControl(self._ui._stc_kunoBG, "Static_State_5")
  self._ui._stc_kuno_State6 = UI.getChildControl(self._ui._stc_kunoBG, "Static_State_6")
  self._ui._stc_kuno_State7 = UI.getChildControl(self._ui._stc_kunoBG, "Static_State_7")
  self._ui._stc_drakaniaBG = UI.getChildControl(Panel_ClassResource, "Static_Drakania_SuccessionBG")
  self._ui._stc_drakania_Progress = UI.getChildControl(self._ui._stc_drakaniaBG, "Progress2_1")
  self._ui._stc_drakania_Effect = UI.getChildControl(self._ui._stc_drakaniaBG, "Static_Effect")
  self._ui._stc_drakania_Effect2 = UI.getChildControl(self._ui._stc_drakaniaBG, "Static_Effect2")
  self._ui._stc_drakaniaBG_Awaken = UI.getChildControl(Panel_ClassResource, "Static_Drakania_AwakenBG")
  self._ui._stc_drakania_FormIconBig = UI.getChildControl(self._ui._stc_drakaniaBG_Awaken, "Static_Normal")
  self._ui._stc_drakania_FormIconSmall = UI.getChildControl(self._ui._stc_drakaniaBG_Awaken, "Static_Dragon")
  self._ui._stc_maeguBG = UI.getChildControl(Panel_ClassResource, "Static_MaeguBG")
  self._ui._stc_DeadEyeBG = UI.getChildControl(Panel_ClassResource, "Static_DeadEyeBG")
  self._ui._stc_pjkdBG = UI.getChildControl(Panel_ClassResource, "Static_PJKD_BG")
  self._ui._stc_pjkd_GuageBG = UI.getChildControl(self._ui._stc_pjkdBG, "Static_PJKD_BG2")
  self._ui._stc_pjkd_ProgressBG = UI.getChildControl(self._ui._stc_pjkdBG, "Static_PJKD_BG1")
  self._ui._stc_pjkd_Progress = UI.getChildControl(self._ui._stc_pjkdBG, "Progress2_1")
  self._ui._stc_pjkd_Effect = UI.getChildControl(self._ui._stc_pjkdBG, "Static_PJKD_Effect")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ClassResource_All:validate()
  if Panel_ClassResource == nil then
    return
  end
  self._ui._txt_resourceText:isValidate()
  self._ui._txt_resourceValue:isValidate()
  self._ui._stc_sorcererBG:isValidate()
  self._ui._txt_sorcerer_PopMSG:isValidate()
  self._ui._txt_sorcerer_Help:isValidate()
  self._ui._stc_fighterBG:isValidate()
  self._ui._stc_fighter_Point1:isValidate()
  self._ui._stc_fighter_Point2:isValidate()
  self._ui._stc_fighter_Point3:isValidate()
  self._ui._stc_shyBG:isValidate()
  self._ui._stc_shy_Point1:isValidate()
  self._ui._stc_shy_Point2:isValidate()
  self._ui._stc_shy_Point3:isValidate()
  self._ui._stc_maehwaBG:isValidate()
  self._ui._stc_maehwa_Point1:isValidate()
  self._ui._stc_maehwa_Point2:isValidate()
  self._ui._stc_maehwa_Point3:isValidate()
  self._ui._stc_maehwa_Point4:isValidate()
  self._ui._stc_novaBG:isValidate()
  self._ui._txt_nova_Percent:isValidate()
  self._ui._stc_nova_Progress:isValidate()
  self._ui._stc_corsairBG:isValidate()
  self._ui._stc_corsair_Bomb:isValidate()
  self._ui._stc_corsair_Bazooka:isValidate()
  self._ui._stc_corsair_Cannon:isValidate()
  self._ui._stc_kunoBG:isValidate()
  self._ui._stc_kuno_State0:isValidate()
  self._ui._stc_kuno_State1:isValidate()
  self._ui._stc_kuno_State2:isValidate()
  self._ui._stc_kuno_State3:isValidate()
  self._ui._stc_kuno_State4:isValidate()
  self._ui._stc_kuno_State5:isValidate()
  self._ui._stc_kuno_State6:isValidate()
  self._ui._stc_kuno_State7:isValidate()
  self._ui._stc_DeadEyeBG:isValidate()
  self._ui._stc_pjkdBG:isValidate()
  self._ui._stc_pjkd_GuageBG:isValidate()
  self._ui._stc_pjkd_ProgressBG:isValidate()
  self._ui._stc_pjkd_Progress:isValidate()
  self._ui._stc_pjkd_Effect:isValidate()
end
function PaGlobal_ClassResource_All:registEventHandler()
  if Panel_ClassResource == nil then
    return
  end
  self:initData()
  Phantom_Locate()
  registerEvent("SimpleUI_UpdatePerFrame", "Panel_ClassResource_UpdateSimpleUI")
  registerEvent("EventSimpleUIEnable", "Panel_ClassResource_EnableSimpleUI")
  registerEvent("EventSimpleUIDisable", "Panel_ClassResource_DisableSimpleUI")
  registerEvent("FromClient_SelfPlayerMpChanged", "FromClient_ClassResource_Update")
  registerEvent("FromClient_RenderModeChangeState", "renderModeChange_Phantom_Locate")
  registerEvent("subResourceChanged", "ClassResource_Update")
  registerEvent("ResponseBuff_changeBuffList", "buffList_update")
  registerEvent("EventPlayerPvPAbleChanged", "Phantom_Locate")
  registerEvent("onScreenResize", "Phantom_Resize")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "Phantom_Resize")
  registerEvent("FromClient_SummonedSelfPlayerClone", "FromClient_SummonedSelfPlayerClone")
  registerEvent("FromClient_UnsummonedSelfPlayerClone", "FromClient_UnsummonedSelfPlayerClone")
  registerEvent("FromClient_MoveToSelfPlayerClone", "FromClient_MoveToSelfPlayerClone")
  registerEvent("FromClient_FailedMoveToSelfPlayerClone", "FromClient_FailedMoveToSelfPlayerClone")
  Panel_ClassResource:addInputEvent("Mouse_LUp", "ResetPos_WidgetButton()")
  Panel_ClassResource:RegisterShowEventFunc(true, "ClassResource_ShowAni()")
  Panel_ClassResource:RegisterShowEventFunc(false, "ClassResource_HideAni()")
  Panel_ClassResource:addInputEvent("Mouse_On", "ClassResource_ChangeTexture_On()")
  Panel_ClassResource:addInputEvent("Mouse_Out", "ClassResource_ChangeTexture_Off()")
  self._ui._stc_sorcererBG:addInputEvent("Mouse_On", "PhantomCount_HelpComment( true )")
  self._ui._stc_sorcererBG:addInputEvent("Mouse_Out", "PhantomCount_HelpComment( false )")
  self._ui._stc_fighterBG:addInputEvent("Mouse_On", "ClassResource_IconHelpComment( true )")
  self._ui._stc_fighterBG:addInputEvent("Mouse_Out", "ClassResource_IconHelpComment( false )")
  self._ui._stc_shyBG:addInputEvent("Mouse_On", "ClassResource_IconHelpComment( true )")
  self._ui._stc_shyBG:addInputEvent("Mouse_Out", "ClassResource_IconHelpComment( false )")
  self._ui._stc_maehwaBG:addInputEvent("Mouse_On", "ClassResource_IconHelpComment( true )")
  self._ui._stc_maehwaBG:addInputEvent("Mouse_Out", "ClassResource_IconHelpComment( false )")
  self._ui._stc_nova_Progress:addInputEvent("Mouse_On", "ClassResource_IconHelpComment( true )")
  self._ui._stc_nova_Progress:addInputEvent("Mouse_Out", "ClassResource_IconHelpComment( false )")
  self._ui._stc_corsairBG:addInputEvent("Mouse_On", "ClassResource_IconHelpComment( true )")
  self._ui._stc_corsairBG:addInputEvent("Mouse_Out", "ClassResource_IconHelpComment( false )")
  self._ui._stc_kunoBG:addInputEvent("Mouse_On", "ClassResource_IconHelpComment( true )")
  self._ui._stc_kunoBG:addInputEvent("Mouse_Out", "ClassResource_IconHelpComment( false )")
  self._ui._stc_drakaniaBG:addInputEvent("Mouse_On", "ClassResource_IconHelpComment( true )")
  self._ui._stc_drakaniaBG:addInputEvent("Mouse_Out", "ClassResource_IconHelpComment( false )")
  self._ui._stc_drakaniaBG_Awaken:addInputEvent("Mouse_On", "ClassResource_IconHelpComment( true )")
  self._ui._stc_drakaniaBG_Awaken:addInputEvent("Mouse_Out", "ClassResource_IconHelpComment( false )")
  self._ui._stc_DeadEyeBG:addInputEvent("Mouse_On", "ClassResource_IconHelpComment( true )")
  self._ui._stc_DeadEyeBG:addInputEvent("Mouse_Out", "ClassResource_IconHelpComment( false )")
  self._ui._stc_pjkdBG:addInputEvent("Mouse_On", "ClassResource_IconHelpComment( true )")
  self._ui._stc_pjkdBG:addInputEvent("Mouse_Out", "ClassResource_IconHelpComment( false )")
end
function PaGlobal_ClassResource_All:initData()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    Panel_ClassResource_SetShow(false)
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    Panel_ClassResource_SetShow(false)
    return
  end
  self._ui._txt_resourceValue:SetShow(false)
  self._ui._stc_sorcererBG:SetShow(false)
  self._ui._stc_fighterBG:SetShow(false)
  self._ui._stc_shyBG:SetShow(false)
  self._ui._stc_maehwaBG:SetShow(false)
  self._ui._stc_novaBG:SetShow(false)
  self._ui._stc_nova_Progress:SetShow(false)
  self._ui._stc_corsairBG:SetShow(false)
  self._ui._stc_kunoBG:SetShow(false)
  self._ui._stc_drakaniaBG:SetShow(false)
  self._ui._stc_drakaniaBG_Awaken:SetShow(false)
  self._ui._stc_maeguBG:SetShow(false)
  self._ui._stc_DeadEyeBG:SetShow(false)
  self._ui._stc_pjkdBG:SetShow(false)
  self._curClassType = selfPlayerWrapper:getClassType()
  if __eClassType_Sorcerer == self._curClassType then
    local phantomCount = selfPlayer:getSubResourcePoint()
    Panel_ClassResource_SetShow(true)
    self._ui._txt_resourceValue:SetText("X " .. phantomCount)
    self._ui._txt_resourceValue:SetShow(true)
    self._ui._stc_sorcererBG:SetShow(true)
  elseif __eClassType_Combattant == self._curClassType or __eClassType_Mystic == self._curClassType then
    Panel_ClassResource_SetShow(true)
    self._ui._stc_fighterBG:SetShow(true)
  elseif __eClassType_ShyWaman == self._curClassType then
    Panel_ClassResource_SetShow(true)
    local count = selfPlayer:getSubResourcePoint()
    self._ui._txt_resourceValue:SetText("X " .. count)
    self._ui._txt_resourceValue:SetShow(true)
    local movespanX = self._ui._stc_shyBG:GetSizeX() - self._ui._stc_sorcererBG:GetSizeX()
    local resoueceValueOriginalSpan = self._ui._txt_resourceValue:GetSpanSize()
    self._ui._txt_resourceValue:SetSpanSize(resoueceValueOriginalSpan.x + movespanX, resoueceValueOriginalSpan.y)
    self._ui._txt_resourceValue:ComputePos()
    self._ui._stc_shyBG:SetShow(true)
  elseif __eClassType_BladeMasterWoman == self._curClassType then
    if PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_BladeMasterWoman) == true then
      Panel_ClassResource_SetShow(true)
      self._ui._stc_maehwaBG:SetShow(true)
    end
  elseif __eClassType_Nova == self._curClassType then
    if PaGlobal_ClassResource_CanAwakenIconEnable(__eClassType_Nova) == true then
      Panel_ClassResource_SetShow(true)
      self._ui._stc_novaBG:SetShow(true)
      self._ui._stc_nova_Progress:SetShow(true)
      self._ui._stc_novaBG:EraseAllEffect()
      self._nova_isEffectUpdate = false
      self._nova_isProgressFull = false
      local showCount = 0
      local maxResourceCount = selfPlayer:getMaxSubResourcePoint(0)
      if maxResourceCount > 0 then
        local resourceCount = math.floor(selfPlayer:getSubResourcePoint(0))
        showCount = resourceCount / maxResourceCount * 100
        if showCount >= 100 then
          showCount = 100
        end
      end
      self._nova_maxProgress = showCount
      self._nova_curProgress = showCount
      self._ui._stc_nova_Progress:SetProgressRate(self._nova_curProgress)
      local showCountString = string.format("%.1f", self._nova_curProgress)
      self._ui._txt_nova_Percent:SetText(showCountString .. "%")
      self._ui._txt_nova_Percent:SetShow(true)
    end
  elseif __eClassType_Corsair == self._curClassType then
    if PaGlobal_ClassResource_CanAwakenIconEnable(__eClassType_Corsair) == true then
      Panel_ClassResource_SetShow(true)
      self._ui._stc_corsairBG:SetShow(true)
    end
  elseif __eClassType_Kunoichi == self._curClassType then
    if PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_Kunoichi) == true then
      Panel_ClassResource_SetShow(true)
      self._ui._stc_kunoBG:SetShow(true)
      self._ui._stc_kuno_State0:SetShow(true)
    end
  elseif __eClassType_Drakania == self._curClassType then
    if PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_Drakania) == true then
      Panel_ClassResource_SetShow(true)
      self._ui._stc_drakaniaBG:SetShow(true)
    elseif PaGlobal_ClassResource_CanAwakenIconEnable(__eClassType_Drakania) == true then
      Panel_ClassResource_SetShow(true)
      self._ui._stc_drakaniaBG_Awaken:SetShow(false)
    end
    self._drakaniaAwaken_bigIconBasePos = {
      x = self._ui._stc_drakania_FormIconBig:GetPosX(),
      y = self._ui._stc_drakania_FormIconBig:GetPosY()
    }
    self._drakaniaAwaken_smallIconBasePos = {
      x = self._ui._stc_drakania_FormIconSmall:GetPosX(),
      y = self._ui._stc_drakania_FormIconSmall:GetPosY()
    }
    self._ui._stc_drakania_FormIconSmall:SetMonoTone(true)
  elseif __eClassType_Giant_Reserved0 == self._curClassType then
    if PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_Giant_Reserved0) == true then
      Panel_ClassResource_SetShow(true)
      self._ui._stc_kunoBG:SetShow(true)
      self._ui._stc_kuno_State0:SetShow(true)
    end
  elseif __eClassType_Giant_Reserved2 == self._curClassType then
    Panel_ClassResource_SetShow(true)
  elseif __eClassType_KunoichiOld == self._curClassType then
    if PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_KunoichiOld) == true then
      Panel_ClassResource_SetShow(true)
      self._ui._stc_kunoBG:SetShow(true)
      self._ui._stc_kuno_State0:SetShow(true)
    end
  elseif __eClassType_PWGE == self._curClassType then
    self._ui._stc_DeadEyeBG:SetShow(PaGlobal_ClassResourceEnable_ByClassType(__eClassType_PWGE))
    self._deadEye_IsMarniBullet = false
    self:updateClassResource_DeadEye()
  elseif self._curClassType == __eClassType_PJKD then
    self._ui._stc_pjkdBG:SetShow(PaGlobal_ClassResourceEnable_ByClassType(__eClassType_PJKD))
    self:updateClassResource_PJKD()
  else
    Panel_ClassResource_SetShow(false)
  end
end
function PaGlobal_ClassResource_All:resizeInitData()
  local isReplayMode = ToClient_IsPlayingReplay()
  if true == isReplayMode then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    Panel_ClassResource_SetShow(false)
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    Panel_ClassResource_SetShow(false)
    return
  end
  self._ui._txt_resourceValue:SetShow(false)
  self._ui._stc_sorcererBG:SetShow(false)
  self._ui._stc_fighterBG:SetShow(false)
  self._ui._stc_shyBG:SetShow(false)
  self._ui._stc_novaBG:SetShow(false)
  self._ui._stc_nova_Progress:SetShow(false)
  self._ui._stc_drakaniaBG:SetShow(false)
  self._ui._stc_drakaniaBG_Awaken:SetShow(false)
  self._ui._stc_maeguBG:SetShow(false)
  self._ui._stc_DeadEyeBG:SetShow(false)
  self._ui._stc_pjkdBG:SetShow(false)
  Panel_ClassResource_SetShow(true)
  self._curClassType = selfPlayerWrapper:getClassType()
  if self._curClassType == __eClassType_Sorcerer then
    local phantomCount = selfPlayer:getSubResourcePoint()
    self._ui._txt_resourceValue:SetText("X " .. phantomCount)
    self._ui._txt_resourceValue:SetShow(true)
    self._ui._stc_sorcererBG:SetShow(true)
  elseif self._curClassType == __eClassType_Combattant or self._curClassType == __eClassType_Mystic then
    self._ui._stc_fighterBG:SetShow(true)
  elseif self._curClassType == __eClassType_ShyWaman then
    local shyCount = selfPlayer:getSubResourcePoint()
    self._ui._txt_resourceValue:SetText("X " .. shyCount)
    self._ui._txt_resourceValue:SetShow(true)
    self._ui._stc_shyBG:SetShow(true)
  elseif self._curClassType == __eClassType_BladeMasterWoman then
    self._ui._stc_maehwaBG:SetShow(PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_BladeMasterWoman))
  elseif self._curClassType == __eClassType_Nova then
    if PaGlobal_ClassResource_CanAwakenIconEnable(__eClassType_Nova) == true then
      self._ui._stc_nova_Progress:SetShow(true)
      self._ui._stc_novaBG:SetShow(true)
      self._ui._stc_novaBG:EraseAllEffect()
      self._nova_isEffectUpdate = false
      self._nova_isProgressFull = false
      local showCount = 0
      local maxResourceCount = selfPlayer:getMaxSubResourcePoint(0)
      if maxResourceCount > 0 then
        local resourceCount = math.floor(selfPlayer:getSubResourcePoint(0))
        showCount = resourceCount / maxResourceCount * 100
        if showCount >= 100 then
          showCount = 100
        end
      end
      self._nova_maxProgress = showCount
      self._nova_curProgress = showCount
      self._ui._stc_nova_Progress:SetProgressRate(self._nova_curProgress)
      local showCountString = string.format("%.1f", self._nova_curProgress)
      self._ui._txt_nova_Percent:SetText(showCountString .. "%")
      self._ui._txt_nova_Percent:SetShow(true)
    end
  elseif self._curClassType == __eClassType_Corsair then
    self._ui._stc_corsairBG:SetShow(PaGlobal_ClassResource_CanAwakenIconEnable(__eClassType_Corsair))
  elseif self._curClassType == __eClassType_Kunoichi then
    self._ui._stc_kunoBG:SetShow(PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_Kunoichi))
  elseif self._curClassType == __eClassType_Drakania then
    if PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_Drakania) == true then
      self._ui._stc_drakaniaBG:SetShow(true)
    elseif PaGlobal_ClassResource_CanAwakenIconEnable(__eClassType_Drakania) == true then
      self._ui._stc_drakaniaBG_Awaken:SetShow(true)
    end
  elseif self._curClassType == __eClassType_Giant_Reserved0 then
    self._ui._stc_kunoBG:SetShow(PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_Giant_Reserved0))
  elseif self._curClassType == __eClassType_Giant_Reserved2 then
  elseif self._curClassType == __eClassType_KunoichiOld then
    self._ui._stc_kunoBG:SetShow(PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_KunoichiOld))
  elseif self._curClassType == __eClassType_PWGE then
    self._ui._stc_DeadEyeBG:SetShow(PaGlobal_ClassResourceEnable_ByClassType(__eClassType_PWGE))
    self:updateClassResource_DeadEye()
  elseif self._curClassType == __eClassType_PJKD then
    self._ui._stc_pjkdBG:SetShow(PaGlobal_ClassResourceEnable_ByClassType(__eClassType_PJKD))
    self:updateClassResource_PJKD()
  else
    Panel_ClassResource_SetShow(false)
  end
end
function PaGlobalFunc_ClassResource_SetShowControl(isShow, isAni, isForce)
  local self = PaGlobal_ClassResource_All
  local isReplayMode = ToClient_IsPlayingReplay()
  if true == isShow and false == isReplayMode then
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    local classType = selfPlayer:getClassType()
    if __eClassType_Sorcerer == classType then
      self._ui._txt_resourceValue:SetShow(true)
      self._ui._stc_sorcererBG:SetShow(true)
    elseif __eClassType_Combattant == classType or __eClassType_Mystic == classType then
      self._ui._stc_fighterBG:SetShow(true)
    elseif __eClassType_ShyWaman == classType then
      self._ui._txt_resourceValue:SetShow(true)
      self._ui._stc_shyBG:SetShow(true)
    elseif __eClassType_BladeMasterWoman == classType then
      self._ui._stc_maehwaBG:SetShow(PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_BladeMasterWoman))
    elseif __eClassType_Nova == classType then
      local canShow = PaGlobal_ClassResource_CanAwakenIconEnable(__eClassType_Nova)
      self._ui._stc_nova_Progress:SetShow(canShow)
      self._ui._stc_novaBG:SetShow(canShow)
    elseif __eClassType_Corsair == classType then
      self._ui._stc_corsairBG:SetShow(PaGlobal_ClassResource_CanAwakenIconEnable(__eClassType_Corsair))
    elseif __eClassType_Kunoichi == classType then
      self._ui._stc_kunoBG:SetShow(PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_Kunoichi))
    elseif __eClassType_Drakania == classType then
      if PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_Drakania) == true then
        self._ui._stc_drakaniaBG:SetShow(true)
        self._ui._stc_drakaniaBG_Awaken:SetShow(false)
      elseif PaGlobal_ClassResource_CanAwakenIconEnable(__eClassType_Drakania) == true then
        self._ui._stc_drakaniaBG:SetShow(false)
        self._ui._stc_drakaniaBG_Awaken:SetShow(true)
      end
    elseif __eClassType_Giant_Reserved0 == classType then
      self._ui._stc_kunoBG:SetShow(PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_Giant_Reserved0))
    elseif __eClassType_KunoichiOld == classType then
      self._ui._stc_kunoBG:SetShow(PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_KunoichiOld))
    elseif self._curClassType == __eClassType_PWGE then
      self._ui._stc_DeadEyeBG:SetShow(PaGlobal_ClassResourceEnable_ByClassType(__eClassType_PWGE))
    else
      if self._curClassType == __eClassType_PJKD then
        self._ui._stc_pjkdBG:SetShow(PaGlobal_ClassResourceEnable_ByClassType(__eClassType_PJKD))
      else
      end
    end
  elseif false == isShow then
    self._ui._txt_resourceValue:SetShow(false)
    self._ui._stc_sorcererBG:SetShow(false)
    self._ui._stc_fighterBG:SetShow(false)
    self._ui._stc_shyBG:SetShow(false)
    self._ui._stc_maehwaBG:SetShow(false)
    self._ui._stc_novaBG:SetShow(false)
    self._ui._stc_nova_Progress:SetShow(false)
    self._ui._stc_corsairBG:SetShow(false)
    self._ui._stc_kunoBG:SetShow(false)
    self._ui._stc_drakaniaBG:SetShow(false)
    self._ui._stc_drakaniaBG_Awaken:SetShow(false)
    self._ui._stc_maeguBG:SetShow(false)
    self._ui._stc_DeadEyeBG:SetShow(false)
    self._ui._stc_pjkdBG:SetShow(false)
  end
end
function PhantomCount_HelpComment(_isShowPhantomHelp)
  local self = PaGlobal_ClassResource_All
  if _isShowPhantomHelp == true then
    local _phantomCount_Message = ""
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    local classType = selfPlayer:getClassType()
    if __eClassType_Sorcerer == classType then
      _phantomCount_Message = PAGetString(Defines.StringSheet_GAME, "LUA_PHANTOMCOUNT_MESSAGE")
    elseif __eClassType_Combattant == classType or __eClassType_Mystic == classType then
      _phantomCount_Message = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_FIGHTER")
    end
    Panel_ClassResource:SetChildIndex(self._ui._txt_sorcerer_Help, 9999)
    self._ui._txt_sorcerer_Help:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_sorcerer_Help:SetAutoResize(true)
    self._ui._txt_sorcerer_Help:SetText(_phantomCount_Message)
    self._ui._txt_sorcerer_Help:SetPosX(getMousePosX() - Panel_ClassResource:GetPosX() - 70)
    self._ui._txt_sorcerer_Help:SetPosY(getMousePosY() - Panel_ClassResource:GetPosY() - 90)
    self._ui._txt_sorcerer_Help:ComputePos()
    self._ui._txt_sorcerer_Help:SetSize(self._ui._txt_sorcerer_Help:GetSizeX(), self._ui._txt_sorcerer_Help:GetSizeY())
    self._ui._txt_sorcerer_Help:SetAlpha(0)
    self._ui._txt_sorcerer_Help:SetFontAlpha(0)
    UIAni.AlphaAnimation(1, self._ui._txt_sorcerer_Help, 0, 0.2)
    self._ui._txt_sorcerer_Help:SetShow(true)
  else
    local aniInfo = UIAni.AlphaAnimation(0, self._ui._txt_sorcerer_Help, 0, 0.2)
    aniInfo:SetHideAtEnd(true)
  end
end
function ClassResource_IconHelpComment(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  local self = PaGlobal_ClassResource_All
  local classType = selfPlayerWrapper:getClassType()
  if __eClassType_Combattant == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_FIGHTERTITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_FIGHTER")
    control = self._ui._stc_fighterBG
  elseif __eClassType_Mystic == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_FIGHTERTITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_MYSTIC")
    control = self._ui._stc_fighterBG
  elseif __eClassType_ShyWaman == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_SHY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_SHY_DESC")
    control = self._ui._stc_shyBG
  elseif __eClassType_BladeMasterWoman == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_MAEHAW_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_MAEHAW")
    control = self._ui._stc_maehwaBG
  elseif __eClassType_Nova == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_NOVA_NAME")
    local showCount = 0
    local maxResourceCount = selfPlayer:getMaxSubResourcePoint(0)
    if maxResourceCount > 0 then
      local resourceCount = math.floor(selfPlayer:getSubResourcePoint(0))
      showCount = resourceCount / maxResourceCount * 100
      if showCount > 100 then
        showCount = 100
      end
    end
    showCount = string.format("%.1f", showCount)
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_NOVA", "count", showCount)
    control = self._ui._stc_novaBG
  elseif __eClassType_Corsair == classType then
    local corsairResource = selfPlayer:getSubResourcePoint()
    if self.ENUM_CORSAIR_RESOURCE_ICON_TYPE._TYPE_BOMB == corsairResource then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_NAME_1")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_DESC_1")
    elseif self.ENUM_CORSAIR_RESOURCE_ICON_TYPE._TYPE_BAZZOKA == corsairResource then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_NAME_2")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_DESC_2")
    elseif self.ENUM_CORSAIR_RESOURCE_ICON_TYPE._TYPE_CANNON == corsairResource then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_NAME_3")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_DESC_3")
    end
    control = self._ui._stc_corsairBG
  elseif __eClassType_Kunoichi == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_KUNOICHI_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_KUNOICHI_DESC")
    control = self._ui._stc_kunoBG
  elseif __eClassType_Drakania == classType then
    if self._ui._stc_drakaniaBG:GetShow() == true then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_PQW_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_PQW_DESC")
      control = self._ui._stc_drakaniaBG
    elseif self._ui._stc_drakaniaBG_Awaken:GetShow() == true then
      if self._drakaniaAwaken_isDragonForm == true then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_PQW_DRANGON_NAME")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_PQW_DRANGON_DESC")
      else
        name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_PQW_HUMAN_NAME")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_PQW_HUMAN_DESC")
      end
      control = self._ui._stc_drakaniaBG_Awaken
    end
  elseif __eClassType_PWGE == classType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_DEADEYE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_DEADEYE_DESC")
    control = self._ui._stc_kunoBG
  elseif classType == __eClassType_PJKD then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_PJKD_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_PJKD_DESC")
    control = self._ui._stc_pjkdBG
  end
  if control == nil then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function ClassResource_ChangeTexture_On()
  local self = PaGlobal_ClassResource_All
  audioPostEvent_SystemUi(0, 10)
  Panel_ClassResource:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/window_sample_drag.dds")
  self._ui._txt_resourceText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PVPMODE_UI_MOVE"))
end
function ClassResource_ChangeTexture_Off()
  local self = PaGlobal_ClassResource_All
  if Panel_UIControl:IsShow() then
    Panel_ClassResource:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/window_sample_isWidget.dds")
    self._ui._txt_resourceText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PVPMODE_UI"))
  else
    Panel_ClassResource:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/window_sample_empty.dds")
  end
end
function ClassResource_ShowAni()
  Panel_ClassResource:SetShowWithFade(UI_PSFT.PAUI_ANI_TYPE_FADE_IN)
  local ClassResourceOpen_Alpha = Panel_ClassResource:addColorAnimation(0, 0.6, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ClassResourceOpen_Alpha:SetStartColor(UI_color.C_00FFFFFF)
  ClassResourceOpen_Alpha:SetEndColor(UI_color.C_FFFFFFFF)
  ClassResourceOpen_Alpha.IsChangeChild = true
end
function ClassResource_HideAni()
  Panel_ClassResource:SetShowWithFade(UI_PSFT.PAUI_ANI_TYPE_FADE_OUT)
  local ClassResourceClose_Alpha = Panel_ClassResource:addColorAnimation(0, 0.6, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ClassResourceClose_Alpha:SetStartColor(UI_color.C_FFFFFFFF)
  ClassResourceClose_Alpha:SetEndColor(UI_color.C_00FFFFFF)
  ClassResourceClose_Alpha.IsChangeChild = true
  ClassResourceClose_Alpha:SetHideAtEnd(true)
  ClassResourceClose_Alpha:SetDisableWhileAni(true)
end
function FromClient_ClassResource_Update(mp, maxMp, percent)
  if ToClient_IsPlayingReplay() == true then
    return
  end
  if __eClassType_Sorcerer ~= PaGlobal_ClassResource_All._curClassType then
    return
  end
  local self = PaGlobal_ClassResource_All
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  local phantomCount = selfPlayer:getSubResourcePoint()
  self._ui._txt_resourceValue:SetText("X " .. phantomCount)
  if phantomCount >= 10 and phantomCount <= 19 and self._sorcerer_effect_1stChk == false then
    self._ui._stc_sorcererBG:EraseAllEffect()
    self._ui._stc_sorcererBG:AddEffect("UI_Button_Hide", false, 0, 0)
    self._sorcerer_effect_1stChk = true
    self._sorcerer_effect_2ndChk = false
    self._sorcerer_effect_3rdChk = false
  elseif phantomCount >= 20 and phantomCount <= 29 and self._sorcerer_effect_2ndChk == false then
    self._ui._stc_sorcererBG:EraseAllEffect()
    self._ui._stc_sorcererBG:AddEffect("UI_Button_Hide", false, 0, 0)
    self._sorcerer_effect_1stChk = false
    self._sorcerer_effect_2ndChk = true
    self._sorcerer_effect_3rdChk = false
  elseif phantomCount == 30 and self._sorcerer_effect_3rdChk == false then
    self._ui._stc_sorcererBG:EraseAllEffect()
    self._ui._stc_sorcererBG:AddEffect("UI_Button_Hide", false, 0, 0)
    self._sorcerer_effect_1stChk = false
    self._sorcerer_effect_2ndChk = false
    self._sorcerer_effect_3rdChk = true
  elseif phantomCount == 0 then
    self._ui._stc_sorcererBG:EraseAllEffect()
    self._sorcerer_effect_1stChk = false
    self._sorcerer_effect_2ndChk = false
    self._sorcerer_effect_3rdChk = false
  end
  if phantomCount >= 10 and percent < 20 then
    self._ui._txt_sorcerer_PopMSG:SetShow(true)
    self._ui._txt_sorcerer_PopMSG:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_PHANTOMPOPMSG"))
  else
    self._ui._txt_sorcerer_PopMSG:SetShow(false)
  end
end
function ClassResource_Update()
  local self = PaGlobal_ClassResource_All
  local isReplayMode = ToClient_IsPlayingReplay()
  if isReplayMode == true then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  if __eClassType_Sorcerer == self._curClassType then
    local playerMp = selfPlayer:getMp()
    local playerMaxMp = selfPlayer:getMaxMp()
    local playerMpRate = playerMp / playerMaxMp * 100
    local phantomCount = selfPlayer:getSubResourcePoint()
    self._ui._txt_resourceValue:SetText("X " .. phantomCount)
    if phantomCount >= 10 and phantomCount <= 19 and self._sorcerer_effect_1stChk == false then
      self._ui._stc_sorcererBG:EraseAllEffect()
      self._ui._stc_sorcererBG:AddEffect("UI_Button_Hide", false, 0, 0)
      self._sorcerer_effect_1stChk = true
      self._sorcerer_effect_2ndChk = false
      self._sorcerer_effect_3rdChk = false
    elseif phantomCount >= 20 and phantomCount <= 29 and self._sorcerer_effect_2ndChk == false then
      self._ui._stc_sorcererBG:EraseAllEffect()
      self._ui._stc_sorcererBG:AddEffect("UI_Button_Hide", false, 0, 0)
      self._sorcerer_effect_1stChk = false
      self._sorcerer_effect_2ndChk = true
      self._sorcerer_effect_3rdChk = false
    elseif phantomCount == 30 and self._sorcerer_effect_3rdChk == false then
      self._ui._stc_sorcererBG:EraseAllEffect()
      self._ui._stc_sorcererBG:AddEffect("UI_Button_Hide", false, 0, 0)
      self._sorcerer_effect_1stChk = false
      self._sorcerer_effect_2ndChk = false
      self._sorcerer_effect_3rdChk = true
    elseif phantomCount == 0 then
      self._ui._stc_sorcererBG:EraseAllEffect()
      self._sorcerer_effect_1stChk = false
      self._sorcerer_effect_2ndChk = false
      self._sorcerer_effect_3rdChk = false
    end
    if phantomCount >= 10 and playerMpRate < 20 then
      self._ui._txt_sorcerer_PopMSG:SetShow(true)
      self._ui._txt_sorcerer_PopMSG:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_PHANTOMPOPMSG"))
    else
      self._ui._txt_sorcerer_PopMSG:SetShow(false)
    end
  elseif __eClassType_Combattant == self._curClassType or __eClassType_Mystic == self._curClassType then
    local fighterCount = selfPlayer:getSubResourcePoint()
    self._ui._stc_fighter_Point1:SetShow(fighterCount >= 10)
    self._ui._stc_fighter_Point2:SetShow(fighterCount >= 20)
    self._ui._stc_fighter_Point3:SetShow(fighterCount >= 30)
    if 10 > self._beforeCount then
      self._ui._stc_fighter_Point3:EraseAllEffect()
      if self._ui._stc_fighter_Point1:GetShow() then
        self._ui._stc_fighter_Point1:AddEffect("fUI_PCM_Energy_01A", false, 0, 0)
      end
    elseif 20 > self._beforeCount then
      self._ui._stc_fighter_Point2:EraseAllEffect()
      if self._ui._stc_fighter_Point2:GetShow() then
        self._ui._stc_fighter_Point2:AddEffect("fUI_PCM_Energy_01A", false, 0, 0)
      end
    elseif 30 > self._beforeCount then
      self._ui._stc_fighter_Point1:EraseAllEffect()
      if self._ui._stc_fighter_Point3:GetShow() then
        self._ui._stc_fighter_Point3:AddEffect("fUI_PCM_Energy_01A", false, 0, 0)
        self._ui._stc_fighter_Point3:AddEffect("fUI_PCM_Energy_02A", false, -15, -8)
        self._ui._stc_fighter_Point3:AddEffect("fUI_PCM_Energy_02B", true, -15, -8)
      end
    end
    if 30 > self._beforeCount and 30 == fighterCount then
      self._ui._stc_fighter_Point1:AddEffect("fUI_PCM_Energy_01A", false, 0, 0)
      self._ui._stc_fighter_Point2:AddEffect("fUI_PCM_Energy_01A", false, 0, 0)
      self._ui._stc_fighter_Point3:AddEffect("fUI_PCM_Energy_01A", false, 0, 0)
      self._ui._stc_fighter_Point3:AddEffect("fUI_PCM_Energy_02A", false, -15, -8)
      self._ui._stc_fighter_Point3:AddEffect("fUI_PCM_Energy_02B", true, -15, -8)
    end
    if 30 == self._beforeCount and 0 == fighterCount then
      self._ui._stc_fighterBG:AddEffect("CO_Empty", false, 0, 0)
    end
    self._beforeCount = fighterCount
  elseif __eClassType_ShyWaman == self._curClassType then
    local shyCount = selfPlayer:getSubResourcePoint(0)
    self._ui._txt_resourceValue:SetText("X " .. shyCount)
    self._ui._stc_shy_Point1:SetShow(shyCount >= 10)
    self._ui._stc_shy_Point2:SetShow(shyCount >= 20)
    self._ui._stc_shy_Point3:SetShow(shyCount >= 30)
    if 10 > self._beforeCount then
      self._ui._stc_shy_Point1:EraseAllEffect()
      if self._ui._stc_shy_Point1:GetShow() then
        self._ui._stc_shy_Point1:AddEffect("fUI_PLW_Energy_01A", true, 0, 0)
      end
    end
    if 20 > self._beforeCount then
      self._ui._stc_shy_Point2:EraseAllEffect()
      if self._ui._stc_shy_Point2:GetShow() then
        self._ui._stc_shy_Point2:AddEffect("fUI_PLW_Energy_01B", true, 0, 0)
      end
    end
    if 30 > self._beforeCount then
      self._ui._stc_shy_Point3:EraseAllEffect()
      if self._ui._stc_shy_Point3:GetShow() then
        self._ui._stc_shy_Point1:EraseAllEffect()
        self._ui._stc_shy_Point2:EraseAllEffect()
        self._ui._stc_shy_Point3:AddEffect("fUI_PLW_Energy_01C", true, 0, 0)
      end
    end
    if 30 == self._beforeCount and 0 == shyCount then
      self._ui._stc_shyBG:AddEffect("fUI_PLW_Energy_01D", false, 0, 0)
    end
    self._beforeCount = shyCount
  elseif __eClassType_BladeMasterWoman == self._curClassType then
    local maehwaCount = selfPlayer:getSubResourcePoint()
    local isIconShow = PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_BladeMasterWoman)
    self._ui._stc_maehwaBG:SetShow(isIconShow)
    if false == isIconShow then
      return
    end
    self._ui._stc_maehwa_Point1:SetShow(maehwaCount >= 1)
    self._ui._stc_maehwa_Point2:SetShow(maehwaCount >= 2)
    self._ui._stc_maehwa_Point3:SetShow(maehwaCount >= 3)
    if self._beforeCount < 1 then
      self._ui._stc_maehwa_Point1:EraseAllEffect()
      if self._ui._stc_maehwa_Point1:GetShow() then
        self._ui._stc_maehwa_Point1:AddEffect("fUI_PKW_UP_Icon_01A", true, -22, 10)
        audioPostEvent_SystemUi(2, 5)
      end
    end
    if self._beforeCount < 2 then
      self._ui._stc_maehwa_Point2:EraseAllEffect()
      if self._ui._stc_maehwa_Point2:GetShow() then
        self._ui._stc_maehwa_Point2:AddEffect("fUI_PKW_UP_Icon_01A", true, -9, -17)
        audioPostEvent_SystemUi(2, 5)
      end
    end
    if self._beforeCount < 3 then
      self._ui._stc_maehwa_Point3:EraseAllEffect()
      if self._ui._stc_maehwa_Point3:GetShow() then
        self._ui._stc_maehwa_Point3:AddEffect("fUI_PKW_UP_Icon_01A", true, 17, -17)
        audioPostEvent_SystemUi(2, 5)
      end
    end
    if self._beforeCount >= 2 and 0 == maehwaCount then
      local remainTime = PaGlobalAppliedBuffList:GetMaehwaBuff_RemainTime()
      if remainTime > -1 and false == self._ui._stc_maehwa_Point4:GetShow() then
        self._ui._stc_maehwaBG:AddEffect("fUI_PKW_UP_Icon_02A", true, 3, -3)
        audioPostEvent_SystemUi(2, 6)
        self._ui._stc_maehwa_Point4:SetShow(true)
        self._maehwa_isShowEffect = true
      end
    end
    self._beforeCount = maehwaCount
  elseif __eClassType_Nova == self._curClassType then
    if PaGlobal_ClassResource_CanAwakenIconEnable(__eClassType_Nova) == true then
      self._ui._stc_novaBG:SetShow(true)
      self._ui._stc_nova_Progress:SetShow(true)
      self._ui._txt_nova_Percent:SetShow(true)
      local maxResourceCount = selfPlayer:getMaxSubResourcePoint(0)
      if maxResourceCount > 0 then
        local resourceCount = math.floor(selfPlayer:getSubResourcePoint(0))
        local showCount = resourceCount / maxResourceCount * 100
        if showCount >= 100 then
          showCount = 100
          if false == self._nova_isProgressFull then
            self._nova_isProgressFull = true
            self._ui._stc_novaBG:EraseAllEffect()
            self._ui._stc_novaBG:AddEffect("fUI_PPW_ARO_Icon_01A", true, 0, 0)
          end
        else
          self._nova_isProgressFull = false
        end
        self._nova_effectTime = self._nova_maxNovaEffectTime
        self._nova_isProgressUp = showCount >= self._nova_maxProgress
        self._nova_maxProgress = showCount
        if true == self._nova_isProgressUp then
          if nil ~= Panel_ClassResource then
            Panel_ClassResource:RegisterUpdateFunc("Panel_ClassResource_UpdateNovaProgress")
          end
        else
          if nil ~= Panel_ClassResource then
            Panel_ClassResource:ClearUpdateLuaFunc()
          end
          if 1 > self._nova_maxProgress then
            self._nova_isEffectUpdate = false
            self._ui._stc_novaBG:EraseAllEffect()
            self._nova_curProgress = 0
            self._nova_maxProgress = 0
          else
            self._nova_curProgress = self._nova_maxProgress
            if false == self._nova_isEffectUpdate then
              self._nova_isEffectUpdate = true
              self._ui._stc_novaBG:EraseAllEffect()
              self._ui._stc_novaBG:AddEffect("fUI_test_Circle", true, 0, 0)
            end
          end
          self._ui._stc_nova_Progress:SetProgressRate(self._nova_curProgress)
          local showCountString = string.format("%.1f", self._nova_curProgress)
          self._ui._txt_nova_Percent:SetText(showCountString .. "%")
        end
      end
    else
      self._ui._stc_novaBG:EraseAllEffect()
      self._ui._stc_novaBG:SetShow(false)
      self._ui._stc_nova_Progress:SetShow(false)
      self._ui._txt_nova_Percent:SetShow(false)
      Panel_ClassResource:ClearUpdateLuaFunc()
    end
  elseif __eClassType_Corsair == self._curClassType then
    local corsairResource = selfPlayer:getSubResourcePoint()
    local isIconShow = PaGlobal_ClassResource_CanAwakenIconEnable(__eClassType_Corsair)
    self._ui._stc_corsairBG:SetShow(isIconShow)
    if false == isIconShow then
      return
    end
    if self.ENUM_CORSAIR_RESOURCE_ICON_TYPE._TYPE_BOMB == corsairResource then
      self._ui._stc_corsair_Bomb:SetShow(true)
      self._ui._stc_corsair_Bazooka:SetShow(false)
      self._ui._stc_corsair_Cannon:SetShow(false)
    elseif self.ENUM_CORSAIR_RESOURCE_ICON_TYPE._TYPE_BAZZOKA == corsairResource then
      self._ui._stc_corsair_Bomb:SetShow(false)
      self._ui._stc_corsair_Bazooka:SetShow(true)
      self._ui._stc_corsair_Cannon:SetShow(false)
    elseif self.ENUM_CORSAIR_RESOURCE_ICON_TYPE._TYPE_CANNON == corsairResource then
      self._ui._stc_corsair_Bomb:SetShow(false)
      self._ui._stc_corsair_Bazooka:SetShow(false)
      self._ui._stc_corsair_Cannon:SetShow(true)
    end
    if corsairResource ~= self._corsair_currentResourceType then
      if self.ENUM_CORSAIR_RESOURCE_ICON_TYPE._TYPE_BOMB == corsairResource then
        self._ui._stc_corsair_Bazooka:EraseAllEffect()
        self._ui._stc_corsair_Cannon:EraseAllEffect()
        if self._ui._stc_corsair_Bomb:GetShow() then
          self._ui._stc_corsair_Bomb:AddEffect("fUI_PFW_ARO_Icon_01A", true, 0, 0)
        end
      elseif self.ENUM_CORSAIR_RESOURCE_ICON_TYPE._TYPE_BAZZOKA == corsairResource then
        self._ui._stc_corsair_Bomb:EraseAllEffect()
        self._ui._stc_corsair_Cannon:EraseAllEffect()
        if self._ui._stc_corsair_Bazooka:GetShow() then
          self._ui._stc_corsair_Bazooka:AddEffect("fUI_PFW_ARO_Icon_02A", true, 0, 0)
        end
      elseif self.ENUM_CORSAIR_RESOURCE_ICON_TYPE._TYPE_CANNON == corsairResource then
        self._ui._stc_corsair_Bomb:EraseAllEffect()
        self._ui._stc_corsair_Bazooka:EraseAllEffect()
        if self._ui._stc_corsair_Cannon:GetShow() then
          self._ui._stc_corsair_Cannon:AddEffect("fUI_PFW_ARO_Icon_03A", true, 0, 0)
        end
      end
    end
    self._corsair_currentResourceType = corsairResource
  elseif __eClassType_Drakania == self._curClassType then
    self._ui._stc_drakaniaBG:SetShow(false)
    self._ui._stc_drakania_Progress:SetShow(false)
    self._ui._stc_drakaniaBG_Awaken:SetShow(false)
    if PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_Drakania) == true then
      self._ui._stc_drakaniaBG:SetShow(true)
      self._ui._stc_drakania_Progress:SetShow(true)
      local drakaniaResource = selfPlayer:getSubResourcePoint()
      if drakaniaResource == self._beforeCount then
        return
      end
      local maxResourceCount = 18
      local rate = math.floor(drakaniaResource / maxResourceCount * 100)
      if drakaniaResource > maxResourceCount then
        rate = 100
      end
      if drakaniaResource < self._beforeCount then
        self._ui._stc_drakania_Progress:SetSmoothMode(false)
      else
        self._ui._stc_drakania_Progress:SetSmoothMode(true)
        self._ui._stc_drakania_Progress:SetAniSpeed(10)
      end
      if rate == 0 then
        self._ui._stc_drakania_Progress:EraseAllEffect()
      end
      self._ui._stc_drakania_Progress:SetProgressRate(rate)
      if maxResourceCount == drakaniaResource then
        self._ui._stc_drakania_Progress:EraseAllEffect()
        self._ui._stc_drakania_Progress:AddEffect("fUI_PQW_Resource_Circle_01A", true, 0, 0)
      else
        if drakaniaResource >= 3 and drakaniaResource % 3 == 0 then
          self._ui._stc_drakania_Progress:EraseAllEffect()
          if drakaniaResource == 3 then
            self._ui._stc_drakania_Progress:AddEffect("fUI_PQW_Resource_Circle_01A", true, 0, 0)
          elseif drakaniaResource == 6 then
            self._ui._stc_drakania_Progress:AddEffect("fUI_PQW_Resource_Circle_01A", true, 0, 0)
          elseif drakaniaResource == 9 then
            self._ui._stc_drakania_Progress:AddEffect("fUI_PQW_Resource_Circle_01A", true, 0, 0)
          elseif drakaniaResource == 12 then
            self._ui._stc_drakania_Progress:AddEffect("fUI_PQW_Resource_Circle_01A", true, 0, 0)
          elseif drakaniaResource == 15 then
            self._ui._stc_drakania_Progress:AddEffect("fUI_PQW_Resource_Circle_01A", true, 0, 0)
          end
        end
        if drakaniaResource >= 3 and self._drakania_isShowLoopEffect == false then
          self._ui._stc_drakania_Effect2:EraseAllEffect()
          self._ui._stc_drakania_Effect2:AddEffect("fUI_PQW_Resource_Circle_01C", true, 0, 0)
          self._drakania_isShowLoopEffect = true
        end
        if self._drakania_isShowLoopEffect == true and drakaniaResource < 3 then
          self._ui._stc_drakania_Effect2:EraseAllEffect()
          self._drakania_isShowLoopEffect = false
        end
        if drakaniaResource < self._beforeCount and (self._beforeCount - drakaniaResource) % 3 == 0 then
          self._ui._stc_drakania_Effect:EraseAllEffect()
          self._ui._stc_drakania_Effect:AddEffect("fUI_PQW_Resource_Circle_01B", false, 0, 0)
        end
      end
      self._beforeCount = drakaniaResource
    elseif PaGlobal_ClassResource_CanAwakenIconEnable(__eClassType_Drakania) == true then
      self._ui._stc_drakaniaBG_Awaken:SetShow(true)
      local isChangeFormType = false
      local isDragonForm = ToClient_isDrakaniaDragonForm()
      if self._drakaniaAwaken_isDragonForm == nil then
        self._drakaniaAwaken_isDragonForm = isDragonForm
        Panel_ClassResource_DrakaniaFormChangeRightNow()
      elseif self._drakaniaAwaken_isDragonForm ~= isDragonForm then
        Panel_ClassResource_DrakaniaFormChangeRightNow()
        self._drakaniaAwaken_isDragonForm = isDragonForm
        isChangeFormType = true
      end
      if isChangeFormType == true then
        self._drakaniaAwaken_formChangeStep = 0
        self._drakaniaAwaken_effectStepTime = 0
        self._drakaniaAwaken_effectTime = self._drakaniaAwaken_effectMaxTime
        Panel_ClassResource:RegisterUpdateFunc("Panel_ClassResource_UpdateDrakaniaFormChange")
        if FromClient_SkillCommandDataSet ~= nil then
          FromClient_SkillCommandDataSet()
        end
      end
    end
  elseif self._curClassType == __eClassType_PJKD then
    self._ui._stc_pjkdBG:SetShow(false)
    if PaGlobal_ClassResourceEnable_ByClassType(__eClassType_PJKD) == true then
      self._ui._stc_pjkdBG:SetShow(true)
      local pjkdResource = selfPlayer:getSubResourcePoint()
      if pjkdResource == self._beforeCount then
        return
      end
      local pjkdMaxResource = selfPlayer:getMaxSubResourcePoint()
      self._pjkd_curProgress = math.floor(pjkdResource / pjkdMaxResource * 100)
      if pjkdResource > pjkdMaxResource then
        self._pjkd_curProgress = 100
      end
      if 100 <= self._pjkd_curProgress then
        self._ui._stc_pjkd_GuageBG:ChangeTextureInfoTextureIDAsync("Combine_Etc_PJKD_SkillBubble_On_BG")
        self._ui._stc_pjkd_GuageBG:setRenderTexture(self._ui._stc_pjkd_GuageBG:getBaseTexture())
      end
      if pjkdResource < self._beforeCount then
        self._ui._stc_pjkd_Progress:SetSmoothMode(false)
      else
        self._ui._stc_pjkd_Progress:SetSmoothMode(true)
        self._ui._stc_pjkd_Progress:SetAniSpeed(10)
      end
      self._ui._stc_pjkd_Progress:SetProgressRate(self._pjkd_curProgress)
      self._beforeCount = pjkdResource
    end
  end
end
function Panel_ClassResource_DrakaniaFormChangeRightNow()
  local self = PaGlobal_ClassResource_All
  if self._drakaniaAwaken_isDragonForm == nil then
    return
  end
  self._ui._stc_drakania_FormIconBig:ResetVertexAni()
  self._ui._stc_drakania_FormIconSmall:ResetVertexAni()
  self._ui._stc_drakania_FormIconBig:ComputePos()
  self._ui._stc_drakania_FormIconSmall:ComputePos()
  self._ui._stc_drakania_FormIconBig:EraseAllEffect()
  self._ui._stc_drakania_FormIconSmall:EraseAllEffect()
  local bX1, bY1, bX2, bY2, sX1, sY1, sX2, sY2
  if self._drakaniaAwaken_isDragonForm == true then
    bX1, bY1, bX2, bY2 = setTextureUV_Func(self._ui._stc_drakania_FormIconBig, 287, 1, 362, 76)
    sX1, sY1, sX2, sY2 = setTextureUV_Func(self._ui._stc_drakania_FormIconSmall, 363, 1, 438, 76)
    self._ui._stc_drakania_FormIconBig:AddEffect("fUI_PQW_Resource_Dragon_01A", true, 0, 0)
  else
    bX1, bY1, bX2, bY2 = setTextureUV_Func(self._ui._stc_drakania_FormIconBig, 363, 1, 438, 76)
    sX1, sY1, sX2, sY2 = setTextureUV_Func(self._ui._stc_drakania_FormIconSmall, 287, 1, 362, 76)
    self._ui._stc_drakania_FormIconBig:AddEffect("fUI_PQW_Resource_Dragon_02A", true, 0, 0)
  end
  self._ui._stc_drakania_FormIconBig:getBaseTexture():setUV(bX1, bY1, bX2, bY2)
  self._ui._stc_drakania_FormIconBig:setRenderTexture(self._ui._stc_drakania_FormIconBig:getBaseTexture())
  self._ui._stc_drakania_FormIconSmall:getBaseTexture():setUV(sX1, sY1, sX2, sY2)
  self._ui._stc_drakania_FormIconSmall:setRenderTexture(self._ui._stc_drakania_FormIconSmall:getBaseTexture())
  self._ui._stc_drakania_FormIconSmall:SetMonoTone(true)
end
function Panel_ClassResource_UpdateDrakaniaFormChange(deltaTime)
  if nil == Panel_ClassResource then
    return
  end
  local self = PaGlobal_ClassResource_All
  self._drakaniaAwaken_effectStepTime = self._drakaniaAwaken_effectStepTime + deltaTime
  self._drakaniaAwaken_effectTime = self._drakaniaAwaken_effectTime + deltaTime
  if self._drakaniaAwaken_effectTime < self._drakaniaAwaken_effectMaxTime then
    return
  end
  self._drakaniaAwaken_effectTime = 0
  local movePos = 10
  if self._drakaniaAwaken_formChangeStep == 0 then
    self._drakaniaAwaken_formChangeStep = 1
    local bigIconMoveAni = self._ui._stc_drakania_FormIconBig:addMoveAnimation(0, self._drakaniaAwaken_step1Time, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    bigIconMoveAni:SetStartPosition(self._drakaniaAwaken_bigIconBasePos.x, self._drakaniaAwaken_bigIconBasePos.y)
    bigIconMoveAni:SetEndPosition(self._drakaniaAwaken_bigIconBasePos.x + movePos, self._drakaniaAwaken_bigIconBasePos.y - movePos)
    local smallIconMoveAni = self._ui._stc_drakania_FormIconSmall:addMoveAnimation(0, self._drakaniaAwaken_step1Time, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    smallIconMoveAni:SetStartPosition(self._drakaniaAwaken_smallIconBasePos.x, self._drakaniaAwaken_smallIconBasePos.y)
    smallIconMoveAni:SetEndPosition(self._drakaniaAwaken_smallIconBasePos.x - movePos, self._drakaniaAwaken_smallIconBasePos.y + movePos)
    self._ui._stc_drakania_FormIconBig:EraseAllEffect()
    if self._drakaniaAwaken_isDragonForm == true then
      self._ui._stc_drakania_FormIconBig:AddEffect("fUI_PQW_Resource_Dragon_01A", true, 0, 0)
    else
      self._ui._stc_drakania_FormIconBig:AddEffect("fUI_PQW_Resource_Dragon_02A", true, 0, 0)
    end
    self._ui._stc_drakania_FormIconSmall:SetMonoTone(false)
  elseif self._drakaniaAwaken_formChangeStep == 1 then
    if self._drakaniaAwaken_effectStepTime > self._drakaniaAwaken_step1Time then
      self._drakaniaAwaken_formChangeStep = 2
      if self._drakaniaAwaken_isDragonForm == true then
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_drakania_FormIconBig, 287, 1, 362, 76)
        self._ui._stc_drakania_FormIconBig:getBaseTexture():setUV(x1, y1, x2, y2)
        self._ui._stc_drakania_FormIconBig:setRenderTexture(self._ui._stc_drakania_FormIconBig:getBaseTexture())
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_drakania_FormIconSmall, 363, 1, 438, 76)
        self._ui._stc_drakania_FormIconSmall:getBaseTexture():setUV(x1, y1, x2, y2)
        self._ui._stc_drakania_FormIconSmall:setRenderTexture(self._ui._stc_drakania_FormIconSmall:getBaseTexture())
      else
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_drakania_FormIconBig, 363, 1, 438, 76)
        self._ui._stc_drakania_FormIconBig:getBaseTexture():setUV(x1, y1, x2, y2)
        self._ui._stc_drakania_FormIconBig:setRenderTexture(self._ui._stc_drakania_FormIconBig:getBaseTexture())
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_drakania_FormIconSmall, 287, 1, 362, 76)
        self._ui._stc_drakania_FormIconSmall:getBaseTexture():setUV(x1, y1, x2, y2)
        self._ui._stc_drakania_FormIconSmall:setRenderTexture(self._ui._stc_drakania_FormIconSmall:getBaseTexture())
      end
      local bigIconMoveAni = self._ui._stc_drakania_FormIconBig:addMoveAnimation(0, self._drakaniaAwaken_step2Time, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
      bigIconMoveAni:SetStartPosition(self._drakaniaAwaken_smallIconBasePos.x + movePos, self._drakaniaAwaken_smallIconBasePos.y - movePos)
      bigIconMoveAni:SetEndPosition(self._drakaniaAwaken_bigIconBasePos.x, self._drakaniaAwaken_bigIconBasePos.y)
      local smallIconMoveAni = self._ui._stc_drakania_FormIconSmall:addMoveAnimation(0, self._drakaniaAwaken_step2Time, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
      smallIconMoveAni:SetStartPosition(self._drakaniaAwaken_bigIconBasePos.x - movePos, self._drakaniaAwaken_bigIconBasePos.y + movePos)
      smallIconMoveAni:SetEndPosition(self._drakaniaAwaken_smallIconBasePos.x, self._drakaniaAwaken_smallIconBasePos.y)
      self._ui._stc_drakania_FormIconSmall:SetMonoTone(true)
    end
  elseif self._drakaniaAwaken_formChangeStep == 2 and self._drakaniaAwaken_effectStepTime > self._drakaniaAwaken_step2Time then
    self._drakaniaAwaken_formChangeStep = 3
    Panel_ClassResource:ClearUpdateLuaFunc()
  end
end
function Panel_ClassResource_UpdateNovaProgress(deltaTime)
  if Panel_ClassResource == nil then
    return
  end
  local self = PaGlobal_ClassResource_All
  self._nova_effectTime = self._nova_effectTime + deltaTime
  if self._nova_maxNovaEffectTime < self._nova_effectTime then
    self._nova_effectTime = 0
    if true == self._nova_isProgressUp then
      self._nova_curProgress = self._nova_curProgress + 1
      if self._nova_maxProgress <= self._nova_curProgress then
        self._nova_curProgress = self._nova_maxProgress
        Panel_ClassResource:ClearUpdateLuaFunc()
      end
      self._ui._stc_nova_Progress:SetProgressRate(self._nova_curProgress)
      local showCountString = string.format("%.1f", self._nova_curProgress)
      self._ui._txt_nova_Percent:SetText(showCountString .. "%")
    else
      Panel_ClassResource:ClearUpdateLuaFunc()
    end
  end
end
function Panel_ClassResource_HideMaehwaSymbol()
  local self = PaGlobal_ClassResource_All
  audioPostEvent_SystemUi(2, 7)
  self._ui._stc_maehwa_Point4:SetShow(false)
end
function Panel_ClasssResource_GetIconSize(idx)
  local self = PaGlobal_ClassResource_All
  local x, y = 50, 50
  if idx == __eClassType_BladeMasterWoman then
    x, y = self._ui._stc_maehwaBG:GetSizeX(), self._ui._stc_maehwaBG:GetSizeY()
  elseif idx == __eClassType_ShyWaman then
    x, y = self._ui._stc_shyBG:GetSizeX(), self._ui._stc_shyBG:GetSizeY()
  elseif idx == __eClassType_Combattant or idx == __eClassType_Mystic then
    x, y = self._ui._stc_fighterBG:GetSizeX(), self._ui._stc_fighterBG:GetSizeY()
  elseif idx == __eClassType_Nova then
    x, y = self._ui._stc_novaBG:GetSizeX(), self._ui._stc_novaBG:GetSizeY()
  end
  return x, y
end
function Panel_ClassResource_EnableSimpleUI()
  Panel_ClassResource_SetAlphaAllChild(Panel_MainStatus_User_Bar:GetAlpha())
end
function Panel_ClassResource_DisableSimpleUI()
  Panel_ClassResource_SetAlphaAllChild(1)
end
function Panel_ClassResource_UpdateSimpleUI(fDeltaTime)
  Panel_ClassResource_SetAlphaAllChild(Panel_MainStatus_User_Bar:GetAlpha())
end
function Panel_ClassResource_SetAlphaAllChild(alphaValue)
  local self = PaGlobal_ClassResource_All
  self._ui._txt_resourceText:SetFontAlpha(alphaValue)
  self._ui._txt_resourceValue:SetFontAlpha(alphaValue)
  self._ui._stc_sorcererBG:SetAlpha(alphaValue)
  self._ui._txt_sorcerer_Help:SetAlpha(alphaValue)
end
function Phantom_Locate()
  local self = PaGlobal_ClassResource_All
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local currentScreenSize = {
    x = getOriginScreenSizeX(),
    y = getOriginScreenSizeY()
  }
  local spanPosY = 30
  if Panel_ClassResource:GetRelativePosX() == -1 and Panel_ClassResource:GetRelativePosY() == -1 then
    local initPosX = Panel_MainStatus_User_Bar:GetPosX() + self._ui._stc_sorcererBG:GetSizeX() - 5
    local initPosY = Panel_MainStatus_User_Bar:GetPosY() - self._ui._stc_sorcererBG:GetSizeY() + 5 - spanPosY
    Panel_ClassResource:SetPosX(initPosX)
    Panel_ClassResource:SetPosY(initPosY)
    changePositionBySever(Panel_ClassResource, CppEnums.PAGameUIType.PAGameUIPanel_ClassResource, true, true, false)
    FGlobal_InitPanelRelativePos(Panel_ClassResource, initPosX, initPosY)
  elseif Panel_ClassResource:GetRelativePosX() == 0 and Panel_ClassResource:GetRelativePosY() == 0 then
    Panel_ClassResource:SetPosX(currentScreenSize.x / 2 - Panel_MainStatus_User_Bar:GetSizeX() / 2 + self._ui._stc_sorcererBG:GetSizeX() - 5)
    Panel_ClassResource:SetPosY(currentScreenSize.y - Panel_QuickSlot:GetSizeY() - Panel_MainStatus_User_Bar:GetSizeY() - self._ui._stc_sorcererBG:GetSizeY() + 5 - spanPosY)
  else
    Panel_ClassResource:SetPosX(currentScreenSize.x * Panel_ClassResource:GetRelativePosX() - Panel_ClassResource:GetSizeX() / 2)
    Panel_ClassResource:SetPosY(currentScreenSize.y * Panel_ClassResource:GetRelativePosY() - Panel_ClassResource:GetSizeY() / 2)
  end
  if 0 < ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ClassResource, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved) then
    Panel_ClassResource_SetShow(ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ClassResource, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow))
  end
  FGlobal_PanelRepostionbyScreenOut(Panel_ClassResource)
  PaGlobal_ClassResource_All:resizeInitData()
end
function Phantom_Resize()
  local self = PaGlobal_ClassResource_All
  local relativePosX = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ClassResource, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
  local relativePosY = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ClassResource, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
  local currentScreenSize = {
    x = getOriginScreenSizeX(),
    y = getOriginScreenSizeY()
  }
  local spanPosY = 30
  if relativePosX == -1 and relativePosY == -1 then
    local initPosX = Panel_MainStatus_User_Bar:GetPosX() + self._ui._stc_sorcererBG:GetSizeX() - 5
    local initPosY = Panel_MainStatus_User_Bar:GetPosY() - self._ui._stc_sorcererBG:GetSizeY() + 5 - spanPosY
    Panel_ClassResource:SetPosX(initPosX)
    Panel_ClassResource:SetPosY(initPosY)
    changePositionBySever(Panel_ClassResource, CppEnums.PAGameUIType.PAGameUIPanel_ClassResource, true, true, false)
    FGlobal_InitPanelRelativePos(Panel_ClassResource, initPosX, initPosY)
  elseif relativePosX == 0 and relativePosY == 0 then
    Panel_ClassResource:SetPosX(currentScreenSize.x / 2 - Panel_MainStatus_User_Bar:GetSizeX() / 2 + self._ui._stc_sorcererBG:GetSizeX() - 5)
    Panel_ClassResource:SetPosY(currentScreenSize.y - Panel_QuickSlot:GetSizeY() - Panel_MainStatus_User_Bar:GetSizeY() - self._ui._stc_sorcererBG:GetSizeY() + 5 - spanPosY)
  else
    Panel_ClassResource:SetRelativePosX(relativePosX)
    Panel_ClassResource:SetRelativePosY(relativePosY)
    Panel_ClassResource:SetPosX(currentScreenSize.x * relativePosX - Panel_ClassResource:GetSizeX() / 2)
    Panel_ClassResource:SetPosY(currentScreenSize.y * relativePosY - Panel_ClassResource:GetSizeY() / 2)
  end
  FGlobal_PanelRepostionbyScreenOut(Panel_ClassResource)
  if 0 < ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ClassResource, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved) then
    Panel_ClassResource_SetShow(ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ClassResource, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow))
  end
  PaGlobal_ClassResource_All:resizeInitData()
end
function Panel_ClassResource_ShowToggle()
  if Panel_ClassResource:IsShow() then
    Panel_ClassResource_SetShow(false)
  else
    Panel_ClassResource_SetShow(true)
  end
end
function renderModeChange_Phantom_Locate(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  Phantom_Locate()
end
function PaGlobal_ClassResource_CanUseResourceIcon(classType)
  if classType == nil then
    return false
  end
  if classType == __eClassType_Sorcerer or classType == __eClassType_Combattant or classType == __eClassType_Mystic or classType == __eClassType_ShyWaman or classType == __eClassType_Giant_Reserved2 then
    return true
  end
  if PaGlobal_ClassResource_CanSuccessionIconEnable(classType) == true or PaGlobal_ClassResource_CanAwakenIconEnable(classType) == true then
    return true
  end
  if PaGlobal_ClassResourceEnable_ByClassType(classType) == true then
    return true
  end
  return false
end
function PaGlobal_ClassResource_CanSuccessionIconEnable(classType)
  if PaGlobalFunc_Util_IsSuccessionContentsOpen(classType) == false then
    return false
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return false
  end
  local checkClassType = selfPlayer:getClassType()
  if checkClassType ~= classType then
    return false
  end
  if checkClassType ~= __eClassType_BladeMasterWoman and checkClassType ~= __eClassType_Kunoichi and checkClassType ~= __eClassType_Drakania then
    return false
  end
  local isSuccession = __eSkillTypeParam_Inherit == ToClient_GetSelfPlayerSkillType()
  if isSuccession == true then
    if checkClassType == __eClassType_Kunoichi then
      local successionRoot = ToClient_getSuccessionRootSkillGroupNo(classType)
      local skillKey = ToClient_getSkillKeyBySkillGroupNo(successionRoot, 1)
      isSuccession = ToClient_isLearnedSkill(skillKey:getSkillNo())
    elseif checkClassType == __eClassType_Drakania then
      isSuccession = ToClient_isLearnedSkill(6933)
    end
  end
  if Panel_MainStatus_Remaster ~= nil and Panel_MainStatus_Remaster:GetShow() == true and Panel_MainStatus_Remaster_SetSuccessionResourceShow ~= nil then
    Panel_MainStatus_Remaster_SetSuccessionResourceShow(checkClassType, isSuccession)
  end
  return isSuccession
end
function PaGlobal_ClassResource_CanAwakenIconEnable(classType)
  if PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(classType) == false then
    return false
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return false
  end
  local checkClassType = selfPlayer:getClassType()
  if checkClassType ~= classType then
    return false
  end
  if checkClassType ~= __eClassType_Nova and checkClassType ~= __eClassType_Corsair and checkClassType ~= __eClassType_Drakania then
    return false
  end
  local isAwaken = __eSkillTypeParam_Awaken == ToClient_GetSelfPlayerSkillType()
  if Panel_MainStatus_Remaster ~= nil and Panel_MainStatus_Remaster:GetShow() == true and Panel_MainStatus_Remaster_SetAwakenResourceShow ~= nil then
    Panel_MainStatus_Remaster_SetAwakenResourceShow(checkClassType, isAwaken)
  end
  return isAwaken
end
function PaGlobal_ClassResourceEnable_ByClassType(classType)
  if nil == Panel_ClassResource then
    return
  end
  if classType == __eClassType_PWGE then
    return ToClient_isLearnedSkill(8990)
  elseif classType == __eClassType_PJKD then
    return ToClient_isLearnedSkill(9605)
  end
  return false
end
function PaGlobal_ClassResource_All:updateClassResource_DeadEye()
  if nil == Panel_ClassResource then
    return
  end
  local buffKey = 12801
  local isMarni = getSelfPlayer():isBuffActivated(buffKey)
  if self._deadEye_IsMarniBullet ~= isMarni then
    self._deadEye_IsMarniBullet = isMarni
    self._ui._stc_DeadEyeBG:getBaseTexture():setReverseTextureAni(isMarni)
    self._ui._stc_DeadEyeBG:setUpdateTextureAni(true)
  else
    self._ui._stc_DeadEyeBG:getBaseTexture():setReverseTextureAni(not isMarni)
    self._ui._stc_DeadEyeBG:setUpdateTextureAni(false)
  end
end
function PaGlobal_ClassResource_All:updateClassResource_PJKD()
  if nil == Panel_ClassResource then
    return
  end
  local buffKey = 12889
  local isFromChange = getSelfPlayer():isBuffActivated(buffKey)
  if self._pjkd_isFormChange ~= isFromChange then
    self._pjkd_isFormChange = isFromChange
    if self._pjkd_isFormChange == true then
      self._ui._stc_pjkd_GuageBG:ChangeTextureInfoTextureIDAsync("Combine_Etc_PJKD_SkillBubble_On_BG")
      self._ui._stc_pjkd_Effect:SetShow(true)
      self._ui._stc_pjkd_Effect:AddEffect("fUI_PJKD_Icon_01A", true, 0, 0)
    elseif self._pjkd_isFormChange == false and self._pjkd_curProgress >= 100 then
      self._ui._stc_pjkd_GuageBG:ChangeTextureInfoTextureIDAsync("Combine_Etc_PJKD_SkillBubble_On_BG")
      self._ui._stc_pjkd_Effect:SetShow(false)
      self._ui._stc_pjkd_Effect:EraseAllEffect()
    else
      self._ui._stc_pjkd_GuageBG:ChangeTextureInfoTextureIDAsync("Combine_Etc_PJKD_SkillBubble_Off_BG")
      self._ui._stc_pjkd_Effect:SetShow(false)
      self._ui._stc_pjkd_Effect:EraseAllEffect()
    end
    self._ui._stc_pjkd_GuageBG:setRenderTexture(self._ui._stc_pjkd_GuageBG:getBaseTexture())
  end
end
function buffList_update()
  if nil == Panel_ClassResource then
    return
  end
  local self = PaGlobal_ClassResource_All
  if true == self._ui._stc_maehwa_Point4:GetShow() then
    local BuffKey = 18634
    local appliedBuff = getSelfPlayer():getAppliedBuffBegin(false)
    while nil ~= appliedBuff do
      if appliedBuff:getBuffKey() == BuffKey then
        return
      end
      appliedBuff = getSelfPlayer():getAppliedBuffNext(false)
    end
    if false == self._maehwa_isShowEffect then
      return
    end
    self._ui._stc_maehwaBG:EraseAllEffect()
    self._ui._stc_maehwaBG:AddEffect("fUI_PKW_UP_Icon_02B", false, 3, -3)
    Panel_ClassResource_HideMaehwaSymbol()
    self._maehwa_isShowEffect = true
  end
  if true == self._ui._stc_kunoBG:GetShow() then
    self._ui._stc_kuno_State1:SetShow(false)
    self._ui._stc_kuno_State2:SetShow(false)
    self._ui._stc_kuno_State3:SetShow(false)
    self._ui._stc_kuno_State4:SetShow(false)
    self._ui._stc_kuno_State5:SetShow(false)
    self._ui._stc_kuno_State6:SetShow(false)
    self._ui._stc_kuno_State7:SetShow(false)
    local effectN = false
    local effectZ = false
    local effectE = false
    local appliedBuff = getSelfPlayer():getAppliedBuffBegin(false)
    while nil ~= appliedBuff do
      if 18679 == appliedBuff:getBuffKey() then
        effectZ = true
      elseif 18680 == appliedBuff:getBuffKey() then
        self._ui._stc_kuno_State2:SetShow(true)
        effectE = true
      elseif 18681 == appliedBuff:getBuffKey() then
        effectN = true
      end
      appliedBuff = getSelfPlayer():getAppliedBuffNext(false)
    end
    if true == effectZ and false == effectE and false == effectN then
      self._ui._stc_kuno_State1:SetShow(true)
    elseif false == effectZ and true == effectE and false == effectN then
      self._ui._stc_kuno_State2:SetShow(true)
    elseif false == effectZ and false == effectE and true == effectN then
      self._ui._stc_kuno_State3:SetShow(true)
    elseif true == effectZ and false == effectE and true == effectN then
      self._ui._stc_kuno_State5:SetShow(true)
    elseif false == effectZ and true == effectE and true == effectN then
      self._ui._stc_kuno_State6:SetShow(true)
    elseif true == effectZ and true == effectE and false == effectN then
      self._ui._stc_kuno_State4:SetShow(true)
    elseif true == effectZ and true == effectE and true == effectN then
      self._ui._stc_kuno_State7:SetShow(true)
    end
  end
  if self._ui._stc_DeadEyeBG:GetShow() == true then
    self:updateClassResource_DeadEye()
  end
  if self._ui._stc_pjkdBG:GetShow() == true then
    self:updateClassResource_PJKD()
  end
end
function FromClient_SummonedSelfPlayerClone(classType)
  if classType == __eClassType_Giant_Reserved2 then
    if Panel_ClassResource:GetShow() == false then
      Panel_ClassResource:SetShow(true)
    end
    PaGlobal_ClassResource_All._ui._stc_maeguBG:SetShow(true)
  end
end
function FromClient_UnsummonedSelfPlayerClone(classType)
  if classType == __eClassType_Giant_Reserved2 then
    PaGlobal_ClassResource_All._ui._stc_maeguBG:SetShow(false)
  end
end
function FromClient_MoveToSelfPlayerClone(classType)
  if classType == __eClassType_Giant_Reserved2 then
    PaGlobal_ClassResource_All._ui._stc_maeguBG:SetShow(false)
  end
end
function FromClient_FailedMoveToSelfPlayerClone(classType)
  if classType == __eClassType_Giant_Reserved2 then
    if PaGlobal_ClassResource_All._ui._stc_maeguBG:GetShow() == false then
      return
    end
    PaGlobal_ClassResource_All._ui._stc_maeguBG:AddEffect("fUI_PKOW_Fail_01A", false, -3, -3)
  end
end
function Panel_ClassResource_SetShow(isShow, isAni, isForce)
  if Panel_ClassResource == nil then
    return
  end
  buffList_update()
  Panel_ClassResource:SetShow(isShow)
  if isShow == true then
    PaGlobalFunc_ClassResource_SetShowControl(true)
  end
end
