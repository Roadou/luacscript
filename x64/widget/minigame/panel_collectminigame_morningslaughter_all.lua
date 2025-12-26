PaGlobal_MiniGame_MorningSlaughter_All = {
  _ui = {
    _txt_resurtBG = nil,
    _stc_success = nil,
    _stc_fail = nil,
    _stc_progressArea = nil,
    _stc_progressGauge = nil,
    _stc_successEffect = nil,
    _stc_failEffect = nil,
    _txt_timer = nil,
    _txt_desc = nil,
    _txt_jump = nil,
    _stc_purpose = nil,
    _txt_purpose = nil
  },
  _curGameTime = 0,
  _maxGameTime = 20,
  _curStageTime = 0,
  _maxStageTime = 3,
  _isSuccessStage = false,
  _clickEffectTime = 0,
  _clickEffectMaxTime = 0.5,
  _curResultTime = 0,
  _maxResultTime = 0.6,
  _stage = 1,
  _stageMax = 3,
  _eGameState = {
    GAME = 0,
    RESULT = 1,
    END = 2
  },
  _eItemType = {
    MEAT = 0,
    LEATHER = 1,
    BLOOD = 2,
    BONE = 3,
    COUNT = 4
  },
  _itemTypeMaxCount = 3,
  _maxItemCount = 12,
  _itemInfo = {
    [1] = {
      control = nil,
      type = 0,
      minDegree = 0,
      maxDegree = 23
    },
    [2] = {
      control = nil,
      type = 0,
      minDegree = 21,
      maxDegree = 46
    },
    [3] = {
      control = nil,
      type = 0,
      minDegree = 44,
      maxDegree = 68
    },
    [4] = {
      control = nil,
      type = 0,
      minDegree = 66,
      maxDegree = 90
    },
    [5] = {
      control = nil,
      type = 0,
      minDegree = 88,
      maxDegree = 113
    },
    [6] = {
      control = nil,
      type = 0,
      minDegree = 111,
      maxDegree = 135
    },
    [7] = {
      control = nil,
      type = 0,
      minDegree = 133,
      maxDegree = 158
    },
    [8] = {
      control = nil,
      type = 0,
      minDegree = 156,
      maxDegree = 180
    },
    [9] = {
      control = nil,
      type = 0,
      minDegree = 178,
      maxDegree = 202
    },
    [10] = {
      control = nil,
      type = 0,
      minDegree = 200,
      maxDegree = 225
    },
    [11] = {
      control = nil,
      type = 0,
      minDegree = 223,
      maxDegree = 247
    },
    [12] = {
      control = nil,
      type = 0,
      minDegree = 245,
      maxDegree = 270
    }
  },
  _maxSuccessArea = 3,
  _successArea = {},
  _state = 0,
  _result = 0,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_MiniGame_MorningSlaughter_All_Init")
function FromClient_MiniGame_MorningSlaughter_All_Init()
  PaGlobal_MiniGame_MorningSlaughter_All:initialize()
end
function PaGlobal_MiniGame_MorningSlaughter_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._txt_resurtBG = UI.getChildControl(Panel_MiniGame_MorningSlaughter_All, "StaticText_Resurt_BG")
  self._ui._stc_success = UI.getChildControl(self._ui._txt_resurtBG, "Static_Success")
  self._ui._stc_fail = UI.getChildControl(self._ui._txt_resurtBG, "Static_Fail")
  self._ui._stc_progressArea = UI.getChildControl(Panel_MiniGame_MorningSlaughter_All, "Static_ProgressArea")
  self._ui._stc_progressGauge = UI.getChildControl(self._ui._stc_progressArea, "CircularProgress_Gauge")
  self._ui._stc_successEffect = UI.getChildControl(self._ui._stc_progressArea, "Static_SuccessEffect")
  self._ui._stc_failEffect = UI.getChildControl(self._ui._stc_progressArea, "Static_FailEffect")
  self._ui._txt_timer = UI.getChildControl(self._ui._stc_progressArea, "StaticText_Timer")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_progressArea, "StaticText_Desc")
  self._ui._txt_jump = UI.getChildControl(self._ui._stc_progressArea, "StaticText_SpaceBar")
  self._ui._stc_purpose = UI.getChildControl(Panel_MiniGame_MorningSlaughter_All, "Static_Purpose")
  self._ui._txt_purpose = UI.getChildControl(self._ui._stc_purpose, "StaticText_Purpose")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_MiniGame_MorningSlaughter_All:validate()
  if Panel_MiniGame_MorningSlaughter_All == nil then
    return
  end
  self._ui._txt_resurtBG:isValidate()
  self._ui._stc_success:isValidate()
  self._ui._stc_fail:isValidate()
  self._ui._stc_progressArea:isValidate()
  self._ui._stc_progressGauge:isValidate()
  self._ui._stc_successEffect:isValidate()
  self._ui._stc_failEffect:isValidate()
  self._ui._txt_timer:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._txt_jump:isValidate()
  self._ui._stc_purpose:isValidate()
  self._ui._txt_purpose:isValidate()
  for ii = 1, self._maxItemCount do
    self._itemInfo[ii].control:isValidate()
  end
  for ii = 1, self._maxSuccessArea do
    self._successArea[ii]:isValidate()
  end
end
function PaGlobal_MiniGame_MorningSlaughter_All:registEventHandler()
  if Panel_MiniGame_MorningSlaughter_All == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_MiniGame_MorningSlaughter_All_ResizePanel")
  Panel_MiniGame_MorningSlaughter_All:RegisterShowEventFunc(false, "PaGlobalFunc_CollectMiniGame_SetHideAnim(" .. __eCollectToolType_ButcheryKnife .. ")")
  for ii = 1, self._maxItemCount do
    self._itemInfo[ii].control = UI.getChildControl(self._ui._stc_progressArea, "Static_Item_" .. tostring(ii))
  end
  for ii = 1, self._maxSuccessArea do
    self._successArea[ii] = UI.getChildControl(self._ui._stc_progressArea, "Static_SuccessArea_" .. tostring(ii))
  end
  self._ui._txt_jump:SetShow(self._isConsole == false)
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  if self._isConsole == true then
    self._ui._txt_desc:SetText(self._ui._txt_desc:GetText())
  end
end
function PaGlobal_MiniGame_MorningSlaughter_All:prepareOpen()
  if Panel_MiniGame_MorningSlaughter_All == nil then
    return
  end
  PaGlobalFunc_CollectMiniGame_Start()
  self:clear()
  self:updateCurStageItem()
  if self._isConsole == false then
    self:setActionKeyText()
  end
  Panel_MiniGame_MorningSlaughter_All:RegisterUpdateFunc("PaGlobal_MiniGame_MorningSlaughter_All_Update")
  self:open()
end
function PaGlobal_MiniGame_MorningSlaughter_All:open()
  if Panel_MiniGame_MorningSlaughter_All == nil then
    return
  end
  Panel_MiniGame_MorningSlaughter_All:SetShow(true)
end
function PaGlobal_MiniGame_MorningSlaughter_All:prepareClose()
  if Panel_MiniGame_MorningSlaughter_All == nil then
    return
  end
  PaGlobalFunc_CollectMiniGame_End()
  self._state = self._eGameState.GAME
  Panel_MiniGame_MorningSlaughter_All:EraseAllEffect()
  Panel_MiniGame_MorningSlaughter_All:ClearUpdateLuaFunc()
  self:close()
end
function PaGlobal_MiniGame_MorningSlaughter_All:close()
  if Panel_MiniGame_MorningSlaughter_All == nil then
    return
  end
  Panel_MiniGame_MorningSlaughter_All:SetShow(false, true)
end
function PaGlobal_MiniGame_MorningSlaughter_All:clear()
  if Panel_MiniGame_MorningSlaughter_All == nil then
    return
  end
  Panel_MiniGame_MorningSlaughter_All:EraseAllEffect()
  Panel_MiniGame_MorningSlaughter_All:ClearUpdateLuaFunc()
  self._state = self._eGameState.GAME
  self._stage = 1
  self._curGameTime = self._maxGameTime
  self._curResultTime = 0
  self._curStageTime = 0
  self._clickEffectTime = 0
  self._isSuccessStage = false
  self._result = __eCollectMiniGameState_Cancle
  self._ui._txt_resurtBG:SetShow(false)
  self._ui._stc_success:SetShow(false)
  self._ui._stc_fail:SetShow(false)
  self._ui._stc_success:EraseAllEffect()
  self._ui._stc_fail:EraseAllEffect()
  self._ui._stc_successEffect:SetShow(false)
  self._ui._stc_successEffect:ResetVertexAni()
  self._ui._stc_failEffect:SetShow(false)
  self._ui._stc_failEffect:ResetVertexAni()
  self:resetProgress()
  self._ui._txt_purpose:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_SLAUGHTER_PURPOSE", "currentCount", tostring(self._stage - 1)))
  self._ui._stc_purpose:SetShow(true)
end
function PaGlobal_MiniGame_MorningSlaughter_All:setActionKeyText()
  local actionKey_jump = keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Jump)
  local descText = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_MINIGAME_SLAUGHTER_DESC_PC", "Space", actionKey_jump)
  self._ui._txt_desc:SetText(descText)
  self._ui._txt_jump:SetText(string.upper(actionKey_jump))
end
function PaGlobal_MiniGame_MorningSlaughter_All:update(deltaTime)
  if Panel_MiniGame_MorningSlaughter_All == nil then
    return
  end
  if self._state == self._eGameState.GAME then
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) == true then
      ToClient_CollectMiniGameEnd(__eCollectMiniGameState_Cancle)
      self:prepareClose()
      return
    end
    if self._clickEffectTime > 0 then
      self._clickEffectTime = self._clickEffectTime - deltaTime
      if self._clickEffectTime <= 0 then
        self._clickEffectTime = 0
        self._ui._stc_successEffect:SetShow(false)
        self._ui._stc_successEffect:ResetVertexAni()
        self._ui._stc_failEffect:SetShow(false)
        self._ui._stc_failEffect:ResetVertexAni()
        if self._isSuccessStage == true then
          self._stage = self._stage + 1
          if self._stage > self._stageMax then
            self._result = __eCollectMiniGameState_Success
            self._state = self._eGameState.RESULT
          else
            self:updateCurStageItem()
            self._curStageTime = 0
            self:resetProgress()
          end
        else
          self:updateCurStageItem()
          self._curStageTime = 0
          self:resetProgress()
        end
        self._ui._txt_purpose:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_SLAUGHTER_PURPOSE", "currentCount", tostring(self._stage - 1)))
        self._isSuccessStage = false
      end
      PaGlobalFunc_CollectMiniGame_UpdateNotInputCheck(false)
    else
      self._curGameTime = self._curGameTime - deltaTime
      if 0 >= self._curGameTime then
        self._curGameTime = 0
        self._result = __eCollectMiniGameState_Fail
        self._state = self._eGameState.RESULT
      else
        self._curStageTime = self._curStageTime + deltaTime
        if self._curStageTime > self._maxStageTime then
          self._curStageTime = 0
        end
        local progressRate = math.sin(self._curStageTime / self._maxStageTime * 3.14) * 0.75
        self._ui._stc_progressGauge:SetProgressRate(progressRate * 100)
        local isKeyDown = self._isConsole == true and isPadDown(__eJoyPadInputType_A) == true or keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Jump) == true
        if isKeyDown == true then
          local curDegree = progressRate * 360
          self._isSuccessStage = false
          for ii = 1, self._maxItemCount do
            if self._itemInfo[ii].type == self._eItemType.MEAT and curDegree >= self._itemInfo[ii].minDegree and curDegree <= self._itemInfo[ii].maxDegree then
              self._isSuccessStage = true
              break
            end
          end
          self._ui._stc_successEffect:SetShow(false)
          self._ui._stc_successEffect:ResetVertexAni()
          self._ui._stc_failEffect:SetShow(false)
          self._ui._stc_failEffect:ResetVertexAni()
          if self._isSuccessStage == true then
            self._ui._stc_successEffect:SetShow(true)
            self._ui._stc_successEffect:SetVertexAniRun("Ani_Color_New", true)
            audioPostEvent_SystemUi(11, 130)
            _AudioPostEvent_SystemUiForXBOX(11, 130)
          else
            self._ui._stc_failEffect:SetShow(true)
            self._ui._stc_failEffect:SetVertexAniRun("Ani_Color_New", true)
            audioPostEvent_SystemUi(11, 131)
            _AudioPostEvent_SystemUiForXBOX(11, 131)
          end
          self._clickEffectTime = self._clickEffectMaxTime
          PaGlobalFunc_CollectMiniGame_SetNotInputCheck(true)
        end
      end
    end
    self._ui._txt_timer:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_POWERCONTROL_REMAINTIME", "gameEndTimer", math.floor(self._curGameTime)))
    if self._state == self._eGameState.RESULT then
      PaGlobalFunc_CollectMiniGame_UpdateResult(self._result, self._ui._stc_success, self._ui._stc_fail, self._ui._txt_resurtBG, self._ui._stc_purpose)
      self:resetProgress()
    end
  elseif self._state == self._eGameState.RESULT then
    PaGlobalFunc_CollectMiniGame_UpdateNotInputCheck(true)
    self._curResultTime = self._curResultTime + deltaTime
    if self._curResultTime < self._maxResultTime then
      return
    end
    self._state = self._eGameState.END
    self:prepareClose()
  end
end
function PaGlobal_MiniGame_MorningSlaughter_All:resetProgress()
  if Panel_MiniGame_MorningSlaughter_All == nil then
    return
  end
  self._ui._stc_progressGauge:SetSmoothMode(false)
  self._ui._stc_progressGauge:SetProgressRate(0)
  self._ui._stc_progressGauge:SetSmoothMode(true)
end
function PaGlobal_MiniGame_MorningSlaughter_All:updateCurStageItem()
  if Panel_MiniGame_MorningSlaughter_All == nil then
    return
  end
  local diffMeatCount = 0
  local meatCount = self._itemTypeMaxCount - diffMeatCount
  local curMeatCount = 0
  local itemTypeList = {
    [self._eItemType.MEAT] = meatCount,
    [self._eItemType.LEATHER] = self._itemTypeMaxCount,
    [self._eItemType.BLOOD] = self._itemTypeMaxCount,
    [self._eItemType.BONE] = self._itemTypeMaxCount
  }
  for ii = 1, diffMeatCount do
    local addType = math.random(self._eItemType.LEATHER, self._eItemType.BONE)
    itemTypeList[addType] = itemTypeList[addType] + 1
  end
  local curSuccessIndex = 0
  for ii = 1, self._maxSuccessArea do
    self._successArea[ii]:SetShow(false)
  end
  local indexList = {}
  for ii = 1, self._maxItemCount do
    local rand = math.random(1, self._maxItemCount)
    if indexList[ii] == nil then
      indexList[ii] = ii
    end
    if indexList[rand] == nil then
      indexList[rand] = rand
    end
    if ii ~= rand then
      local tmp = indexList[ii]
      indexList[ii] = indexList[rand]
      indexList[rand] = tmp
    end
  end
  if indexList[1] ~= indexList[2] + 1 and indexList[1] ~= indexList[2] - 1 then
    local temp = indexList[2]
    if indexList[1] == self._maxItemCount then
      for index = 3, self._maxItemCount do
        if indexList[1] - 1 == indexList[index] then
          indexList[2] = indexList[index]
          indexList[index] = temp
          break
        end
      end
    else
      for index = 3, self._maxItemCount do
        if indexList[1] + 1 == indexList[index] then
          indexList[2] = indexList[index]
          indexList[index] = temp
          break
        end
      end
    end
  end
  for ii = 1, self._maxItemCount do
    local type = self._eItemType.COUNT
    for jj = 0, self._eItemType.COUNT - 1 do
      if itemTypeList[jj] ~= 0 then
        itemTypeList[jj] = itemTypeList[jj] - 1
        type = jj
        break
      end
    end
    local index = indexList[ii]
    self._itemInfo[index].type = type
    local control = self._itemInfo[index].control
    control:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_MiniGame_15.dds")
    local x1, y1, x2, y2 = 0, 0, 0, 0
    if self._itemInfo[index].type == self._eItemType.MEAT then
      x1, y1, x2, y2 = setTextureUV_Func(control, 1, 499, 45, 543)
      curSuccessIndex = curSuccessIndex + 1
      if meatCount >= curSuccessIndex and self._successArea[curSuccessIndex] ~= nil then
        self._successArea[curSuccessIndex]:SetRotate((self._itemInfo[index].maxDegree - 180) / 180 * 3.14)
        self._successArea[curSuccessIndex]:SetShow(true)
      end
    elseif self._itemInfo[index].type == self._eItemType.LEATHER then
      x1, y1, x2, y2 = setTextureUV_Func(control, 46, 499, 90, 543)
    elseif self._itemInfo[index].type == self._eItemType.BLOOD then
      x1, y1, x2, y2 = setTextureUV_Func(control, 91, 499, 135, 543)
    elseif self._itemInfo[index].type == self._eItemType.BONE then
      x1, y1, x2, y2 = setTextureUV_Func(control, 136, 499, 180, 543)
    end
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
  end
end
function PaGlobal_MiniGame_MorningSlaughter_All_Open()
  PaGlobal_MiniGame_MorningSlaughter_All:prepareOpen()
end
function PaGlobal_MiniGame_MorningSlaughter_All_Close()
  if Panel_MiniGame_MorningSlaughter_All ~= nil and Panel_MiniGame_MorningSlaughter_All:GetShow() == true then
    ToClient_CollectMiniGameEnd(__eCollectMiniGameState_Cancle)
  end
  PaGlobal_MiniGame_MorningSlaughter_All:prepareClose()
end
function PaGlobal_MiniGame_MorningSlaughter_All_Update(deltaTime)
  PaGlobal_MiniGame_MorningSlaughter_All:update(deltaTime)
end
function PaGlobal_MiniGame_MorningSlaughter_All_IsOpen()
  if Panel_MiniGame_MorningSlaughter_All == nil then
    return false
  end
  return Panel_MiniGame_MorningSlaughter_All:GetShow()
end
function FromClient_MiniGame_MorningSlaughter_All_ResizePanel()
  if Panel_MiniGame_MorningSlaughter_All == nil then
    return
  end
  Panel_MiniGame_MorningSlaughter_All:ComputePosAllChild()
end
