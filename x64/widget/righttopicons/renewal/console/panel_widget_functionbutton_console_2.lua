function PaGlobalFunc_FuncttionButton_Console_Open()
  if nil == PaGlobal_Widget_FunctionButton_Console then
    return
  end
  PaGlobal_Widget_FunctionButton_Console:prepareOpen()
end
function PaGlobalFunc_FuncttionButton_Console_Close()
  if nil == PaGlobal_Widget_FunctionButton_Console then
    return
  end
  PaGlobal_Widget_FunctionButton_Console:prepareClose()
end
function FromClient_Widget_FunctionButton_Console_Resize()
  if nil == PaGlobal_Widget_FunctionButton_Console then
    return
  end
  PaGlobal_Widget_FunctionButton_Console:resize()
end
function FromCLient_PlayGrowthPassRewardEffect()
  if nil == PaGlobal_Widget_FunctionButton_Console then
    return
  end
  if false == _ContentsGroup_GrowthPass then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  if true == selfPlayerWrapper:get():isSeasonCharacter() then
    return
  end
  if true == ToClient_isPremiumCharacter() then
    return
  end
  local functionType = Widget_Function_Type_Console.GrowthPass
  local self = PaGlobal_Widget_FunctionButton_Console
  if false == self._button[functionType]:GetShow() then
    return
  end
  self._button[functionType]:EraseAllEffect()
  self._button[functionType]:AddEffect("UI_BlackSpirit_Pass_Icon_Cast_01A", false, 0, 0)
  self._growthPassIconValue._growthPassEffectNo = nil
  FromClient_CheckGrowthPassEffect()
end
function FromClient_CheckGrowthPassEffect()
  if nil == PaGlobal_Widget_FunctionButton_Console then
    return
  end
  if false == _ContentsGroup_GrowthPass then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  if true == selfPlayerWrapper:get():isSeasonCharacter() then
    return
  end
  if true == ToClient_isPremiumCharacter() then
    return
  end
  local isGetableAnyRewardItem = ToClient_checkGetableAnyRewardItemForGrowthPass()
  ProcessGrowthPassIconEffect(isGetableAnyRewardItem)
end
function FromClient_ResponseYachtPvPBattle()
  if nil == PaGlobal_Widget_FunctionButton_Console then
    return
  end
  if false == _ContentsGroup_MiniGame_YachtDice then
    return
  end
  ProcessYachtIconEffect()
end
function FromClient_CheckSpecialPassShow()
  if PaGlobal_Widget_FunctionButton_Console == nil then
    return
  end
  local functionType = Widget_Function_Type_Console.SpecialPass
  local self = PaGlobal_Widget_FunctionButton_Console
  self._buttonShow[functionType] = PaGlobal_GetCurrentSpecialPass ~= nil and PaGlobal_GetCurrentSpecialPass() ~= nil
  self._button[functionType]:SetShow(self._buttonShow[functionType])
  self:resize()
end
function ProcessGrowthPassIconEffect(isActiveEffect)
  if nil == PaGlobal_Widget_FunctionButton_Console then
    return
  end
  if false == _ContentsGroup_GrowthPass then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  if true == selfPlayerWrapper:get():isSeasonCharacter() then
    return
  end
  if true == ToClient_isPremiumCharacter() then
    return
  end
  local functionType = Widget_Function_Type_Console.GrowthPass
  local self = PaGlobal_Widget_FunctionButton_Console
  if false == self._button[functionType]:GetShow() then
    return
  end
  if true == isActiveEffect then
    if nil == self._growthPassIconValue._growthPassEffectNo then
      self._growthPassIconValue._growthPassEffectNo = self._button[functionType]:AddEffect("fUI_GrowthPassIcon_01A", true, 0, 0)
    end
  elseif nil ~= self._growthPassIconValue._growthPassEffectNo then
    self._button[functionType]:EraseEffect(self._growthPassIconValue._growthPassEffectNo)
    self._growthPassIconValue._growthPassEffectNo = nil
  end
  PaGlobal_ShowGrowthPassRewardBubleTextIcon(isActiveEffect)
end
function ProcessYachtIconEffect()
  if nil == PaGlobal_Widget_FunctionButton_Console then
    return
  end
  if false == _ContentsGroup_MiniGame_YachtDice then
    return
  end
  local functionType = Widget_Function_Type_Console.YachtPvP
  local self = PaGlobal_Widget_FunctionButton_Console
  if false == self._button[functionType]:GetShow() then
    return
  end
  self._button[functionType]:EraseAllEffect()
  self._button[functionType]:AddEffect("UI_BlackSpirit_Pass_Icon_Cast_01A", false, 0, 0)
  PaGlobal_ShowYachtPvPInviteBubleTextIcon(true)
end
function PaGlobal_CheckAndShowGrowthPassIntroBubbleText()
  if nil == PaGlobal_Widget_FunctionButton_Console then
    return
  end
  if false == _ContentsGroup_GrowthPass then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  if true == selfPlayerWrapper:get():isSeasonCharacter() then
    return
  end
  if true == ToClient_isPremiumCharacter() then
    return
  end
  local functionType = Widget_Function_Type_Console.GrowthPass
  local self = PaGlobal_Widget_FunctionButton_Console
  if false == self._button[functionType]:GetShow() then
    return
  end
  local rewardBubbleTextControl = UI.getChildControl(self._button[functionType], "Static_Bubble_Tail_Console_02")
  if rewardBubbleTextControl == nil then
    return
  end
  local introBubbleTextControl = UI.getChildControl(self._button[functionType], "Static_Bubble_Tail_Console")
  if introBubbleTextControl == nil then
    return
  end
  local isExistCacheData = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eGrowthPassIntroScreen)
  local isShow = not isExistCacheData
  if true == isShow then
    introBubbleTextControl:ResetVertexAni()
    introBubbleTextControl:SetVertexAniRun("Ani_Color_Show", true)
  end
  if isShow == true and rewardBubbleTextControl:GetShow() == true then
    rewardBubbleTextControl:SetShow(false)
    self._growthPassIconValue._accDeltaTime = 0
    self._growthPassIconValue._doUpdate = false
    self._growthPassIconValue._keptGrowthPassIntroBubbleTextControl = false
  end
  introBubbleTextControl:SetShow(isShow)
end
function PaGlobal_ShowGrowthPassRewardBubleTextIcon(isShow)
  if nil == PaGlobal_Widget_FunctionButton_Console then
    return
  end
  if false == _ContentsGroup_GrowthPass then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  if true == selfPlayerWrapper:get():isSeasonCharacter() then
    return
  end
  if true == ToClient_isPremiumCharacter() then
    return
  end
  local functionType = Widget_Function_Type_Console.GrowthPass
  local self = PaGlobal_Widget_FunctionButton_Console
  if false == self._button[functionType]:GetShow() then
    return
  end
  local introBubbleTextControl = UI.getChildControl(self._button[functionType], "Static_Bubble_Tail_Console")
  local rewardBubbleTextControl = UI.getChildControl(self._button[functionType], "Static_Bubble_Tail_Console_02")
  if true == isShow then
    if true == self._yachtIconValue._doUpdate then
      self._yachtIconValue._accDeltaTime = self._yachtIconValue._showTime
    end
    self._growthPassIconValue._accDeltaTime = 0
    self._growthPassIconValue._doUpdate = true
    if true == introBubbleTextControl:GetShow() then
      introBubbleTextControl:SetShow(false)
      self._growthPassIconValue._keptGrowthPassIntroBubbleTextControl = true
    end
    rewardBubbleTextControl:ResetVertexAni()
    rewardBubbleTextControl:SetVertexAniRun("Ani_Color_Show", true)
  elseif true == self._growthPassIconValue._keptGrowthPassIntroBubbleTextControl then
    PaGlobal_CheckAndShowGrowthPassIntroBubbleText()
    self._growthPassIconValue._keptGrowthPassIntroBubbleTextControl = false
  end
  rewardBubbleTextControl:SetShow(isShow)
end
function PaGlobal_ShowYachtPvPInviteBubleTextIcon(isShow)
  if nil == PaGlobal_Widget_FunctionButton_Console then
    return
  end
  if false == _ContentsGroup_MiniGame_YachtDice then
    return
  end
  local functionType = Widget_Function_Type_Console.YachtPvP
  local self = PaGlobal_Widget_FunctionButton_Console
  if false == self._button[functionType]:GetShow() then
    return
  end
  local yachtBubbleTextControl = UI.getChildControl(self._button[functionType], "Static_Bubble_Tail_Console")
  if true == isShow then
    local introBubbleTextControl = UI.getChildControl(self._button[Widget_Function_Type_Console.GrowthPass], "Static_Bubble_Tail_Console")
    local rewardBubbleTextControl = UI.getChildControl(self._button[Widget_Function_Type_Console.GrowthPass], "Static_Bubble_Tail_Console_02")
    if introBubbleTextControl:GetShow() == true or rewardBubbleTextControl:GetShow() == true then
      introBubbleTextControl:SetShow(false)
      rewardBubbleTextControl:SetShow(false)
      self._growthPassIconValue._accDeltaTime = 0
      self._growthPassIconValue._doUpdate = false
      self._growthPassIconValue._keptGrowthPassIntroBubbleTextControl = false
    end
    self._yachtIconValue._accDeltaTime = 0
    self._yachtIconValue._doUpdate = true
    yachtBubbleTextControl:ResetVertexAni()
    yachtBubbleTextControl:SetVertexAniRun("Ani_Color_Show", true)
  else
    PaGlobal_CheckAndShowGrowthPassIntroBubbleText()
  end
  yachtBubbleTextControl:SetShow(isShow)
end
function PaGlobalFunc_FunctionButton_Update(deltaTime)
  if nil == PaGlobal_Widget_FunctionButton_Console then
    return
  end
  PaGlobal_Widget_FunctionButton_Console:update(deltaTime)
end
