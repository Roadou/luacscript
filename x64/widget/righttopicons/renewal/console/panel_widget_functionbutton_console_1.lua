function PaGlobal_Widget_FunctionButton_Console:initialize()
  if true == self._initialize then
    return
  end
  self:initializeChildControl()
  self:initializeChildControlShowState()
  self:initGrowthPassBubbleTextControl()
  self:initYachtPvPBubbleTextControl()
  self:registEventHandler()
  self:validate()
  self:checkAndShow()
  self:resize()
  self._initialize = true
  self:afterInitProcess()
end
function PaGlobal_Widget_FunctionButton_Console:initializeChildControl()
  if nil == Panel_Widget_FunctionButton_Console then
    return
  end
  self._button[Widget_Function_Type_Console.GrowthPass] = UI.getChildControl(Panel_Widget_FunctionButton_Console, "Button_GrowthPass")
  self._button[Widget_Function_Type_Console.YachtPvP] = UI.getChildControl(Panel_Widget_FunctionButton_Console, "Button_Yatch")
  self._button[Widget_Function_Type_Console.EnterToHadumField] = UI.getChildControl(Panel_Widget_FunctionButton_Console, "Button_Elvia_Enter")
  self._button[Widget_Function_Type_Console.SpecialPass] = UI.getChildControl(Panel_Widget_FunctionButton_Console, "Button_SpecialPass")
end
function PaGlobal_Widget_FunctionButton_Console:initializeChildControlShowState()
  if nil == Panel_Widget_FunctionButton_Console then
    return
  end
  for index = 0, Widget_Function_Type_Console.Count - 1 do
    self:checkButton(index)
  end
end
function PaGlobal_Widget_FunctionButton_Console:checkButton(functionType)
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. selfPlayerWrapper\234\176\128 nullptr\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local isSeasonCharacter = selfPlayerWrapper:get():isSeasonCharacter()
  local isPremiumCharacter = ToClient_isPremiumCharacter()
  if functionType == Widget_Function_Type_Console.GrowthPass then
    self._buttonShow[functionType] = true == _ContentsGroup_GrowthPass and false == isSeasonCharacter and false == isPremiumCharacter
  elseif functionType == Widget_Function_Type_Console.YachtPvP then
    self._buttonShow[functionType] = true == _ContentsGroup_MiniGame_YachtDice
  elseif functionType == Widget_Function_Type_Console.EnterToHadumField then
    self._buttonShow[functionType] = PaGlobal_Widget_HadumField_Enter_All_IsShowEnterButton ~= nil and PaGlobal_Widget_HadumField_Enter_All_IsShowEnterButton() == true
  elseif functionType == Widget_Function_Type_Console.SpecialPass then
    self._buttonShow[functionType] = PaGlobal_GetCurrentSpecialPass ~= nil and PaGlobal_GetCurrentSpecialPass() ~= nil
  else
    UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
  end
end
function PaGlobal_Widget_FunctionButton_Console:initGrowthPassBubbleTextControl()
  if nil == Panel_Widget_FunctionButton_Console then
    return
  end
  local functionType = Widget_Function_Type_Console.GrowthPass
  if nil == self._button[functionType] then
    return
  end
  local introBubbleParent = UI.getChildControl(self._button[functionType], "Static_Bubble_Tail_Console")
  local introBubbleBg = UI.getChildControl(introBubbleParent, "Static_blackBubble")
  local introBubbleText = UI.getChildControl(introBubbleBg, "StaticText_Desc_New")
  local introString = PAGetString(Defines.StringSheet_GAME, "LUA_GROWTHPASS_WIDGET_ICON_NOTICE_NEW_DESC")
  introBubbleText:SetText(ToClient_getReplaceDialog(introString))
  introBubbleText:SetSize(introBubbleText:GetTextSizeX() + 5, introBubbleText:GetTextSizeY())
  introBubbleBg:SetSize(introBubbleText:GetSizeX() + 20, introBubbleText:GetSizeY() + 10)
  local rewardBubbleParent = UI.getChildControl(self._button[functionType], "Static_Bubble_Tail_Console_02")
  local rewardBubbleBg = UI.getChildControl(rewardBubbleParent, "Static_blackBubble")
  local rewardBubbleText = UI.getChildControl(rewardBubbleBg, "StaticText_Desc_Reward")
  local rewardString = PAGetString(Defines.StringSheet_GAME, "LUA_GROWTHPASS_WIDGET_ICON_NOTICE_REWARD_DESC")
  rewardBubbleText:SetText(rewardString)
  rewardBubbleText:SetSize(rewardBubbleText:GetTextSizeX() + 5, rewardBubbleText:GetTextSizeY())
  rewardBubbleBg:SetSize(rewardBubbleText:GetSizeX() + 20, rewardBubbleText:GetSizeY() + 10)
end
function PaGlobal_Widget_FunctionButton_Console:initYachtPvPBubbleTextControl()
  if nil == Panel_Widget_FunctionButton_Console then
    return
  end
  local functionType = Widget_Function_Type_Console.YachtPvP
  if nil == self._button[functionType] then
    return
  end
  local yachtBubbleParent = UI.getChildControl(self._button[functionType], "Static_Bubble_Tail_Console")
  local yachtBubbleBg = UI.getChildControl(yachtBubbleParent, "Static_blackBubble")
  local yachtBubbleText = UI.getChildControl(yachtBubbleBg, "StaticText_Desc_New")
  local yachtString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_YATCH_DESC_CONSOLE")
  yachtBubbleText:SetText(yachtString)
  yachtBubbleText:SetSize(yachtBubbleText:GetTextSizeX() + 5, yachtBubbleText:GetTextSizeY())
  yachtBubbleBg:SetSize(yachtBubbleText:GetSizeX() + 20, yachtBubbleText:GetSizeY() + 10)
end
function PaGlobal_Widget_FunctionButton_Console:registEventHandler()
  if nil == Panel_Widget_FunctionButton_Console then
    return
  end
  registerEvent("onScreenResize", "FromClient_Widget_FunctionButton_Console_Resize")
  registerEvent("FromClient_notifyUpdateGrowthPassQuest", "FromCLient_PlayGrowthPassRewardEffect")
  registerEvent("FromClient_ClearGrowthPassQuest", "FromClient_CheckGrowthPassEffect")
  registerEvent("FromClient_GetGrowthPassCategoryTotalRewardItem", "FromClient_CheckGrowthPassEffect")
  registerEvent("FromClient_responseYachtDiceBattle", "FromClient_ResponseYachtPvPBattle")
  registerEvent("FromClient_SpecialPassKeyReceived", "FromClient_CheckSpecialPassShow")
end
function PaGlobal_Widget_FunctionButton_Console:validate()
  if nil == Panel_Widget_FunctionButton_Console then
    return
  end
  for index = 0, Widget_Function_Type_Console.Count - 1 do
    if nil ~= self._button[index] then
      self._button[index]:isValidate()
    end
  end
end
function PaGlobal_Widget_FunctionButton_Console:checkAndShow()
  if nil == Panel_Widget_FunctionButton_Console then
    return
  end
  local spanPosX = 0
  for index = 0, Widget_Function_Type_Console.Count - 1 do
    if nil ~= self._buttonShow[index] then
      self._button[index]:SetShow(self._buttonShow[index])
      if true == self._buttonShow[index] then
        self._button[index]:SetSpanSize(spanPosX, 0)
        spanPosX = spanPosX + 40
      end
    end
  end
  PaGlobalFunc_FuncttionButton_Console_Open()
end
function PaGlobal_Widget_FunctionButton_Console:resize()
  if nil == Panel_Widget_FunctionButton_Console then
    return
  end
  local radorPosX = FGlobal_Panel_Radar_GetPosX()
  local sizeX = Panel_Widget_FunctionButton_Console:GetSizeX()
  Panel_Widget_FunctionButton_Console:SetPosXY(radorPosX - sizeX, 5)
  local gap_x = 50
  local mul = 0
  for index = 0, Widget_Function_Type_Console.Count - 1 do
    if nil ~= self._button[index] and true == self._buttonShow[index] then
      self._button[index]:SetSpanSize(mul * gap_x, 0)
      mul = mul + 1
    end
  end
end
function PaGlobal_Widget_FunctionButton_Console:recalcGrowthPassBubbleControlPos()
  if nil == Panel_Widget_FunctionButton_Console then
    return
  end
  local functionType = Widget_Function_Type_Console.GrowthPass
  if nil == self._button[functionType] then
    return
  end
  local introBubbleParent = UI.getChildControl(self._button[functionType], "Static_Bubble_Tail_Console")
  local introBubbleBg = UI.getChildControl(introBubbleParent, "Static_blackBubble")
  local rewardBubbleParent = UI.getChildControl(self._button[functionType], "Static_Bubble_Tail_Console_02")
  local rewardBubbleBg = UI.getChildControl(rewardBubbleParent, "Static_blackBubble")
  local introParentPosX = introBubbleParent:GetPosX()
  local introParentSizeX = introBubbleParent:GetSizeX()
  local introBubbleSizeX = introBubbleBg:GetSizeX()
  local introBubblePosX = introParentPosX - introBubbleSizeX + introParentSizeX
  introBubbleBg:SetPosX(introBubblePosX - 10)
  local rewardParentPosX = rewardBubbleParent:GetPosX()
  local rewardParentSizeX = rewardBubbleParent:GetSizeX()
  local rewardBubbleSizeX = rewardBubbleBg:GetSizeX()
  local rewardBubblePosX = rewardParentPosX - rewardBubbleSizeX + rewardParentSizeX
  rewardBubbleBg:SetPosX(rewardBubblePosX - 10)
end
function PaGlobal_Widget_FunctionButton_Console:recalcYachtBubbleControlPos()
  if nil == Panel_Widget_FunctionButton_Console then
    return
  end
  local functionType = Widget_Function_Type_Console.YachtPvP
  if nil == self._button[functionType] then
    return
  end
  local yachtBubbleParent = UI.getChildControl(self._button[functionType], "Static_Bubble_Tail_Console")
  local yachtBubbleBg = UI.getChildControl(yachtBubbleParent, "Static_blackBubble")
  local yachtParentPosX = yachtBubbleParent:GetPosX()
  local yachtParentSizeX = yachtBubbleParent:GetSizeX()
  local yachtBubbleSizeX = yachtBubbleBg:GetSizeX()
  local yachtBubblePosX = yachtParentPosX - yachtBubbleSizeX + yachtParentSizeX
  yachtBubbleBg:SetPosX(yachtBubblePosX - 10)
end
function PaGlobal_Widget_FunctionButton_Console:afterInitProcess()
  if nil == Panel_Widget_FunctionButton_Console then
    return
  end
  if true == self._buttonShow[Widget_Function_Type_Console.GrowthPass] then
    self:recalcGrowthPassBubbleControlPos()
    PaGlobal_CheckAndShowGrowthPassIntroBubbleText()
    FromClient_CheckGrowthPassEffect()
  end
  if true == self._buttonShow[Widget_Function_Type_Console.YachtPvP] then
    self:recalcYachtBubbleControlPos()
  end
end
function PaGlobal_Widget_FunctionButton_Console:prepareOpen()
  if nil == Panel_Widget_FunctionButton_Console then
    return
  end
  for index = 0, Widget_Function_Type_Console.Count - 1 do
    if self._buttonShow[index] == true then
      Panel_Widget_FunctionButton_Console:RegisterUpdateFunc("PaGlobalFunc_FunctionButton_Update")
      break
    end
  end
  self:open()
end
function PaGlobal_Widget_FunctionButton_Console:open()
  if nil == Panel_Widget_FunctionButton_Console then
    return
  end
  Panel_Widget_FunctionButton_Console:SetShow(true)
end
function PaGlobal_Widget_FunctionButton_Console:prepareClose()
  if nil == Panel_Widget_FunctionButton_Console then
    return
  end
  Panel_Widget_FunctionButton_Console:ClearUpdateLuaFunc()
  self:close()
end
function PaGlobal_Widget_FunctionButton_Console:close()
  if nil == Panel_Widget_FunctionButton_Console then
    return
  end
  Panel_Widget_FunctionButton_Console:SetShow(false)
end
function PaGlobal_Widget_FunctionButton_Console:update(deltaTime)
  if nil == Panel_Widget_FunctionButton_Console then
    return
  end
  if true == self._buttonShow[Widget_Function_Type_Console.GrowthPass] then
    self:updateGrowthPassIcon(deltaTime)
  end
  if true == self._buttonShow[Widget_Function_Type_Console.YachtPvP] then
    self:updateYachtPvPIcon(deltaTime)
  end
  if self._buttonShow[Widget_Function_Type_Console.EnterToHadumField] == true then
    self:updateEnterToHadumFieldIcon(deltaTime)
  end
end
function PaGlobal_Widget_FunctionButton_Console:updateGrowthPassIcon(deltaTime)
  if false == self._buttonShow[Widget_Function_Type_Console.GrowthPass] then
    return
  end
  if false == self._growthPassIconValue._doUpdate then
    return
  end
  self._growthPassIconValue._accDeltaTime = self._growthPassIconValue._accDeltaTime + deltaTime
  if self._growthPassIconValue._showTime < self._growthPassIconValue._accDeltaTime then
    self._growthPassIconValue._doUpdate = false
    self._growthPassIconValue._accDeltaTime = 0
    PaGlobal_ShowGrowthPassRewardBubleTextIcon(false)
  end
end
function PaGlobal_Widget_FunctionButton_Console:updateYachtPvPIcon(deltaTime)
  if false == self._buttonShow[Widget_Function_Type_Console.YachtPvP] then
    return
  end
  if false == self._yachtIconValue._doUpdate then
    return
  end
  self._yachtIconValue._accDeltaTime = self._yachtIconValue._accDeltaTime + deltaTime
  if self._yachtIconValue._showTime < self._yachtIconValue._accDeltaTime then
    self._yachtIconValue._doUpdate = false
    self._yachtIconValue._accDeltaTime = 0
    PaGlobal_ShowYachtPvPInviteBubleTextIcon(false)
  end
end
function PaGlobal_Widget_FunctionButton_Console:updateEnterToHadumFieldIcon(deltaTime)
  if self._buttonShow[Widget_Function_Type_Console.EnterToHadumField] == false then
    return
  end
  self._enterToHadumFieldIconValue._curUpdateTime = self._enterToHadumFieldIconValue._curUpdateTime + deltaTime
  if self._enterToHadumFieldIconValue._curUpdateTime < self._enterToHadumFieldIconValue._maxUpdateTime then
    return
  end
  self._enterToHadumFieldIconValue._curUpdateTime = 0
  if ToClient_IsEnterHadumField() == true then
    if self._enterToHadumFieldIconValue._enterToHadumFieldEffectNo == nil then
      self._enterToHadumFieldIconValue._enterToHadumFieldEffectNo = self._button[Widget_Function_Type_Console.EnterToHadumField]:AddEffect("fUI_ingame_Icon_01A", true, 0, 0)
    end
  elseif self._enterToHadumFieldIconValue._enterToHadumFieldEffectNo ~= nil then
    self._button[Widget_Function_Type_Console.EnterToHadumField]:EraseAllEffect()
    self._enterToHadumFieldIconValue._enterToHadumFieldEffectNo = nil
  end
end
