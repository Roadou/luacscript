function PaGlobal_GrowthPass_Info:initialize()
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  Panel_Window_GrowthPass_Info:ignorePadSnapMoveToOtherPanel()
  self._isConsole = true == ToClient_isConsole()
  self._isPadMode = true == self._isConsole or true == _ContentsGroup_UsePadSnapping
  PaGlobal_GrowthPass_Info:initializeControl()
  PaGlobal_GrowthPass_Info:registEventHandler()
  PaGlobal_GrowthPass_Info:validate()
  PaGlobal_GrowthPass_Info._initialize = true
end
function PaGlobal_GrowthPass_Info:registEventHandler()
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  if true == self._isConsole then
    self._ui._btn_close:SetShow(false)
  else
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GrowPath_Info_Close()")
  end
  if true == self._isPadMode then
    Panel_Window_GrowthPass_Info:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_GrowthPass_Info_OnClickedKeyguideA()")
    Panel_Window_GrowthPass_Info:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_GrowthPass_Info_OnClickedKeyguideX()")
  end
end
function PaGlobal_GrowthPass_Info:initializeControl()
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  local questIconBg = UI.getChildControl(self._ui._stc_mainBg, "Static_QuestIconBG")
  self._ui._stc_questDescBg = UI.getChildControl(self._ui._stc_mainBg, "StaticText_QuestDesc_BG")
  self._ui._stc_rewardGroup = UI.getChildControl(self._ui._stc_mainBg, "Static_RewardGroup")
  self._ui._stc_rewardBg = UI.getChildControl(self._ui._stc_rewardGroup, "Static_BaseRewardBG")
  self._ui._stc_questTitle = UI.getChildControl(self._ui._stc_mainBg, "StaticText_QuestTitle")
  self._ui._stc_questIconTexture = UI.getChildControl(questIconBg, "Static_QuestIcon")
  self._ui._stc_questConditionText = UI.getChildControl(self._ui._stc_mainBg, "StaticText_QuestCondition")
  self._ui._stc_questDescText = UI.getChildControl(self._ui._stc_questDescBg, "StaticText_DescBox")
  self._ui._questItemSlot = UI.getChildControl(self._ui._stc_rewardBg, "Static_Reward_Slot_0")
  self._ui._questItemNameText = UI.getChildControl(self._ui._stc_rewardBg, "StaticText_Name")
  self._ui._btn_reward = UI.getChildControl(self._ui._stc_mainBg, "Button_Reward")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_mainBg, "Button_Close")
  self._ui._consoleArea = UI.getChildControl(self._ui._stc_mainBg, "Static_KeyGuide_ConsoleUI_Import")
  self._ui._consoleKeyguide_A = UI.getChildControl(self._ui._consoleArea, "StaticText_A_ConsoleUI")
  self._ui._consoleKeyguide_X = UI.getChildControl(self._ui._consoleArea, "StaticText_X_ConsoleUI")
  self._ui._consoleKeyguide_B = UI.getChildControl(self._ui._consoleArea, "StaticText_B_ConsoleUI")
  if true == self._isPadMode then
    self._ui._consoleArea:SetShow(true)
    self._ui._consoleKeyguide_A:SetShow(false)
    self._ui._consoleKeyguide_X:SetShow(true)
    self._ui._consoleKeyguide_B:SetShow(true)
    self._ui._btn_reward:SetShow(false)
  else
    self._ui._consoleArea:SetShow(false)
    self._ui._consoleKeyguide_A:SetShow(false)
    self._ui._consoleKeyguide_X:SetShow(false)
    self._ui._consoleKeyguide_B:SetShow(false)
    self._ui._btn_reward:SetShow(true)
  end
  self._ui._questItemSlot:SetShow(false)
  local tempSlot = {}
  SlotItem.new(tempSlot, "GrowthPass_RewardItem_", 1, self._ui._stc_rewardBg, self._slotConfig)
  tempSlot:createChild()
  tempSlot.icon:SetSize(42, 42)
  tempSlot.icon:SetPosX(self._ui._questItemSlot:GetPosX())
  tempSlot.icon:SetPosY(self._ui._questItemSlot:GetPosY())
  tempSlot.icon:ComputePos()
  self._ui._itemSlot = tempSlot
  local rewardTitle = UI.getChildControl(self._ui._stc_rewardGroup, "Static_Menu_Reward")
  self._ui._rewardTitle_spanY = rewardTitle:GetSpanSize().y
end
function PaGlobal_GrowthPass_Info:updateKeyguide(isShowKeyguideA)
  if nil == Panel_Window_GrowthPass_Info or false == self._isPadMode then
    return
  end
  self._ui._consoleKeyguide_A:SetShow(isShowKeyguideA)
  local keyGuides = {}
  if true == isShowKeyguideA then
    keyGuides[1] = self._ui._consoleKeyguide_A
    keyGuides[2] = self._ui._consoleKeyguide_X
  else
    keyGuides[1] = self._ui._consoleKeyguide_X
    keyGuides[2] = self._ui._consoleKeyguide_B
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._consoleArea, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  if true == isShowKeyguideA then
    local exitKeyGuide = {
      [1] = self._ui._consoleKeyguide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(exitKeyGuide, self._ui._consoleArea, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    self._ui._consoleKeyguide_B:SetPosY(self._ui._consoleKeyguide_X:GetPosY() + self._ui._consoleKeyguide_X:GetSizeY())
  else
    self._ui._consoleKeyguide_B:SetPosY(self._ui._consoleKeyguide_X:GetPosY())
  end
end
function PaGlobal_GrowthPass_Info:prepareOpen(questInfoWrapper, questInfoControl, isForceShow)
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  if nil == questInfoWrapper or nil == questInfoControl then
    return
  end
  if false == isForceShow and self._cachedTargetControl == questInfoControl then
    PaGlobalFunc_GrowPath_Info_Close()
    return
  else
    self._cachedTargetControl = questInfoControl
  end
  local questNo = questInfoWrapper:getQuestNo()
  local questWrapper = ToClient_getQuestWrapper(questNo)
  if nil == questWrapper then
    return
  end
  local demandCount = questWrapper:getDemadCount()
  local demandString = ""
  for demandIndex = 0, demandCount - 1 do
    local demand = questWrapper:getDemandAt(demandIndex)
    demandString = demandString .. "- " .. demand._desc .. "\n"
  end
  local questBaseReward = questInfoWrapper:getQuestBaseRewardAt(0)
  if nil == questBaseReward then
    return
  end
  local rewardItemKey = ItemEnchantKey(questBaseReward:getItemEnchantKey())
  local rewardItemSSW = getItemEnchantStaticStatus(rewardItemKey)
  if nil == rewardItemSSW then
    return
  end
  self._cachedQuestGroupRaw = questNo._group
  self._cachedQuestIdRaw = questNo._quest
  self._cachedRewardItemKeyRaw = rewardItemKey:get()
  local nextSpanY = self._ui._stc_questTitle:GetSpanSize().y
  local gabY = 5
  local panel = Panel_Window_GrowthPass_Info
  self._ui._stc_questTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_questTitle:SetText(ToClient_getReplaceDialog(questWrapper:getTitle()))
  self._ui._stc_questIconTexture:ChangeTextureInfoNameAsync(questWrapper:getGrowthPassIconPath())
  self._ui._stc_questIconTexture:setRenderTexture(self._ui._stc_questIconTexture:getBaseTexture())
  self._ui._stc_questConditionText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_questConditionText:SetText(ToClient_getReplaceDialog(demandString))
  self._ui._stc_questDescText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_questDescText:SetText(ToClient_getReplaceDialog(questWrapper:getDesc()))
  self._ui._itemSlot:clearItem()
  self._ui._itemSlot:setItemByStaticStatus(rewardItemSSW, questBaseReward:getItemCount())
  self._ui._itemSlot.icon:removeInputEvent("Mouse_LUp")
  self._ui._itemSlot.icon:removeInputEvent("Mouse_On")
  self._ui._itemSlot.icon:removeInputEvent("Mouse_Out")
  self._ui._itemSlot.icon:addInputEvent("Mouse_On", "PaGlobal_GrowthPass_Info_ShowItemTooptip(" .. tostring(rewardItemKey:get()) .. ", true)")
  self._ui._itemSlot.icon:addInputEvent("Mouse_Out", "PaGlobal_GrowthPass_Info_ShowItemTooptip(" .. tostring(rewardItemKey:get()) .. ", false)")
  self._ui._questItemNameText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._questItemNameText:SetText(rewardItemSSW:getName() .. " x" .. tostring(questBaseReward:getItemCount()))
  local questState = ToClient_getGrowthPassQuestState(questNo._group, questNo._quest)
  local isCompleteQuest = __eGrowthPass_QuestState_Complete == questState
  if true == self._isPadMode then
    self:updateKeyguide(isCompleteQuest)
  else
    self._ui._btn_reward:SetShow(isCompleteQuest)
    self._ui._btn_reward:addInputEvent("Mouse_LUp", "PaGlobalFunc_GrowthPass_Info_OnClickedQuestionRewardIcon(" .. tostring(questNo._group) .. "," .. tostring(questNo._quest) .. ")")
  end
  nextSpanY = nextSpanY + self._ui._stc_questTitle:GetTextSizeY() + gabY
  self._ui._stc_questConditionText:SetSpanSize(self._ui._stc_questConditionText:GetSpanSize().x, nextSpanY)
  nextSpanY = nextSpanY + self._ui._stc_questConditionText:GetTextSizeY()
  self._ui._stc_questDescBg:SetSize(self._ui._stc_questDescBg:GetSizeX(), self._ui._stc_questDescText:GetTextSizeY() + 20)
  self._ui._stc_questDescBg:SetSpanSize(self._ui._stc_questDescBg:GetSpanSize().x, nextSpanY)
  nextSpanY = nextSpanY + self._ui._stc_questDescBg:GetSizeY() + self._ui._rewardTitle_spanY + self._ui._stc_rewardGroup:GetSizeY()
  self._ui._stc_rewardGroup:SetSpanSize(self._ui._stc_rewardGroup:GetSpanSize().x, nextSpanY)
  local addBtnSizeY = 0
  local panelSizeGapY = 0
  nextSpanY = nextSpanY + self._ui._stc_rewardGroup:GetSizeY() + gabY
  if true == self._isPadMode then
    panelSizeGapY = 5
    addBtnSizeY = self._ui._consoleArea:GetSizeY()
    self._ui._consoleArea:SetSpanSize(self._ui._consoleArea:GetSpanSize().x, nextSpanY)
  else
    panelSizeGapY = 10
    if true == self._ui._btn_reward:GetShow() then
      addBtnSizeY = self._ui._btn_reward:GetSizeY()
      self._ui._btn_reward:SetSpanSize(self._ui._btn_reward:GetSpanSize().x, nextSpanY)
      self._ui._btn_reward:SetMonoTone(false)
    end
  end
  local exitKeyguidSizeY = 0
  if true == self._isPadMode and true == isCompleteQuest then
    exitKeyguidSizeY = self._ui._consoleKeyguide_B:GetSizeY()
  end
  local changePanelSizeY = nextSpanY + addBtnSizeY + panelSizeGapY + exitKeyguidSizeY
  panel:SetSize(panel:GetSizeX(), changePanelSizeY)
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local panelSizeX = panel:GetSizeX()
  local panelSizeY = panel:GetSizeY()
  local frameContent = self._cachedTargetControl:getParent()
  local frameContentSizeY = frameContent:GetSizeY()
  local frame = frameContent:getParent()
  local frameSizeY = frame:GetSizeY()
  local posX = self._cachedTargetControl:GetParentPosX()
  local posY = self._cachedTargetControl:GetParentPosY()
  local isRight = posX > screenSizeX / 2
  local isBottom = posY > screenSizeY / 2
  if true == isRight then
    posX = posX - panelSizeX - self._panelPos_gapX
  else
    posX = posX + self._cachedTargetControl:GetSizeX() + self._panelPos_gapX
  end
  if true == isBottom then
    posY = posY - (panelSizeY - self._cachedTargetControl:GetSizeY())
  else
  end
  if screenSizeX < posX + panelSizeX then
    posX = screenSizeX - panelSizeX
  end
  if screenSizeY < posY + panelSizeY then
    posY = screenSizeY - panelSizeY
  end
  panel:SetPosX(posX)
  panel:SetPosY(posY)
  PaGlobal_GrowthPass_Info:open()
end
function PaGlobal_GrowthPass_Info:open()
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  Panel_Window_GrowthPass_Info:SetShow(true)
end
function PaGlobal_GrowthPass_Info:prepareClose()
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  self._cachedRewardItemKeyRaw = nil
  self._cachedQuestGroupRaw = nil
  self._cachedQuestIdRaw = nil
  self._cachedTargetControl = nil
  PaGlobal_GrowthPass_Info:close()
end
function PaGlobal_GrowthPass_Info:close()
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  Panel_Window_GrowthPass_Info:SetShow(false)
end
function PaGlobal_GrowthPass_Info:validate()
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  self._ui._stc_mainBg:isValidate()
  self._ui._stc_questTitle:isValidate()
  self._ui._stc_questIconTexture:isValidate()
  self._ui._stc_questConditionText:isValidate()
  self._ui._stc_questDescText:isValidate()
  self._ui._questItemSlot:isValidate()
  self._ui._questItemNameText:isValidate()
end
