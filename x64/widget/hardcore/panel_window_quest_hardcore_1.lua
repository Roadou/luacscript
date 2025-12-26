function PaGlobal_HardCoreQuestDetails:initialize()
  if PaGlobal_HardCoreQuestDetails._initialize == true then
    return
  end
  local titleBG = UI.getChildControl(Panel_Window_Quest_HardCore, "Static_TitleBG")
  self._ui._btn_Close = UI.getChildControl(titleBG, "Button_Win_Close")
  self._ui._titleBg = UI.getChildControl(Panel_Window_Quest_HardCore, "Static_TitleBG")
  self._ui._noneQuest = UI.getChildControl(Panel_Window_Quest_HardCore, "MultilineText_Noquest")
  self._originalPanelSizeY = Panel_Window_Quest_HardCore:GetSizeY()
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_HardCoreQuestDetails:registEventHandler()
  PaGlobal_HardCoreQuestDetails:validate()
  PaGlobal_HardCoreQuestDetails._initialize = true
  self:initQuestList()
end
function PaGlobal_HardCoreQuestDetails:registEventHandler()
  if Panel_Window_Quest_HardCore == nil then
    return
  end
  registerEvent("FromClient_UpdateQuestList", "PaGlobal_HardCoreQuestDetails_UpdateQuestInfo")
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_HardCoreQuestDetails_Close()")
end
function PaGlobal_HardCoreQuestDetails:validate()
end
function PaGlobal_HardCoreQuestDetails:prepareOpen()
  if Panel_Window_Quest_HardCore == nil then
    return
  end
  self:update()
  self:open()
end
function PaGlobal_HardCoreQuestDetails:open()
  if Panel_Window_Quest_HardCore == nil then
    return
  end
  Panel_Window_Quest_HardCore:SetShow(true)
end
function PaGlobal_HardCoreQuestDetails:prepareClose()
  if Panel_Window_Quest_HardCore == nil then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  self:close()
end
function PaGlobal_HardCoreQuestDetails:close()
  if Panel_Window_Quest_HardCore == nil then
    return
  end
  Panel_Window_Quest_HardCore:SetShow(false)
end
function PaGlobal_HardCoreQuestDetails:update()
  if Panel_Window_Quest_HardCore == nil then
    return
  end
  self:updateQuest()
end
function PaGlobal_HardCoreQuestDetails:initQuestList()
  if Panel_Window_Quest_HardCore == nil then
    return
  end
  for index = 0, self._questCountMax - 1 do
    local questUI = {
      _bg = nil,
      _descBg = nil,
      _txt_QuestName = nil,
      _txt_QuestCondition = nil,
      _txt_CompleteNpc = nil,
      _txt_QuestDesc = nil,
      _txt_RewardTitle = nil,
      _itemSlotBg = {},
      _itemSlot = {}
    }
    questUI._bg = UI.getChildControl(Panel_Window_Quest_HardCore, "Static_QuestList_" .. tostring(index + 1))
    questUI._txt_QuestName = UI.getChildControl(questUI._bg, "StaticText_ListMain_QuestName")
    questUI._descBg = UI.getChildControl(questUI._bg, "Static_DescBg")
    questUI._txt_QuestCondition = UI.getChildControl(questUI._descBg, "StaticText_Condition")
    questUI._txt_CompleteNpc = UI.getChildControl(questUI._descBg, "StaticText_CompleteNpc")
    questUI._txt_QuestDesc = UI.getChildControl(questUI._descBg, "MultilineText_Desc")
    questUI._txt_RewardTitle = UI.getChildControl(questUI._descBg, "StaticText_RewardTitle")
    local templateSlotBg = UI.getChildControl(questUI._descBg, "Static_SlotBg_Template")
    local itemSlotPosX = templateSlotBg:GetPosX()
    local slotOffsetX = templateSlotBg:GetSizeX() + 5
    for slotIndex = 0, self._itemSlotMaxCount - 1 do
      local itemIndex = index * self._itemSlotMaxCount + slotIndex
      local clonedItemSlotBg = UI.cloneControl(templateSlotBg, questUI._descBg, "Static_SlotBg_" .. tostring(itemIndex))
      clonedItemSlotBg:SetPosX(itemSlotPosX)
      questUI._itemSlotBg[slotIndex] = clonedItemSlotBg
      itemSlotPosX = itemSlotPosX + slotOffsetX
      local slot = {}
      SlotItem.new(slot, "HardCoreBaseReward_" .. itemIndex, itemIndex, clonedItemSlotBg, self._rewardSlotConfig)
      slot:createChild()
      slot.icon:SetPosX(2)
      slot.icon:SetPosY(2)
      slot.icon:SetSize(40, 40)
      slot.border:SetSize(42, 42)
      slot.icon:SetIgnore(false)
      slot.icon:addInputEvent("Mouse_On", "")
      slot.icon:addInputEvent("Mouse_On", "")
      if true == self._isConsole then
        slot.icon:SetIgnore(true)
      end
      questUI._itemSlot[slotIndex] = slot
      Panel_Tooltip_Item_SetPosition(itemIndex, slot, "QuestHardCoreReward_Base")
    end
    templateSlotBg:SetShow(false)
    self._ui._questUI[index] = questUI
  end
end
function PaGlobal_HardCoreQuestDetails:updateQuest()
  if Panel_Window_Quest_HardCore == nil then
    return
  end
  local hardCoreSubQuestWarpper = ToClient_getHardCoreSubQuest()
  local hardCoreRepeatQuestWarpper = ToClient_getHardCoreRepeatQuest()
  for index = 0, self._questCountMax - 1 do
    self._questData[index] = nil
    self._ui._questUI[index]._bg:SetShow(false)
  end
  local insertIndex = 0
  if hardCoreSubQuestWarpper ~= nil then
    self._questData[insertIndex] = hardCoreSubQuestWarpper:getKey()
    insertIndex = insertIndex + 1
  end
  local repeatQuestCount = ToClient_getHardCoreRepeatQuestCountMax()
  for repeatQuestIndex = 0, repeatQuestCount - 1 do
    local hardCoreRepeatQuestWarpper = ToClient_getHardCoreRepeatQuest(repeatQuestIndex)
    if hardCoreRepeatQuestWarpper ~= nil then
      self._questData[insertIndex] = hardCoreRepeatQuestWarpper:getKey()
      insertIndex = insertIndex + 1
    end
  end
  local controlIndex = 0
  local lastQuestListPosY = 0
  local bottomGap = 10
  for index = 0, self._questCountMax - 1 do
    if self._questData[index] ~= nil then
      local progressQuestWarpper = ToClient_getProgressingQuestAtKey(self._questData[index])
      if progressQuestWarpper ~= nil then
        local questWarpper = questList_getQuestInfo(self._questData[index])
        local questGroupNo = questWarpper:getQuestGroupNo()
        local questNo = questWarpper:getQuestGroupQuestNo()
        self._ui._questUI[controlIndex]._bg:SetShow(true)
        if index > 0 then
          self._ui._questUI[controlIndex]._bg:SetPosY(lastQuestListPosY)
        end
        self._ui._questUI[controlIndex]._txt_QuestName:SetText(progressQuestWarpper:getTitle())
        if _ContentsGroup_UsePadSnapping == false then
          UI.setLimitTextAndAddTooltip(self._ui._questUI[controlIndex]._txt_QuestName)
        end
        self._ui._questUI[controlIndex]._bg:addInputEvent("Mouse_RUp", "PaGlobal_HardCoreQuest_QuestNavi(" .. index .. ")")
        self._ui._questUI[controlIndex]._txt_QuestName:addInputEvent("Mouse_RUp", "PaGlobal_HardCoreQuest_QuestNavi(" .. index .. ")")
        self._ui._questUI[controlIndex]._txt_QuestCondition:addInputEvent("Mouse_RUp", "PaGlobal_HardCoreQuest_QuestNavi(" .. index .. ")")
        local completeNpc = questWarpper:getCompleteDisplay()
        local completeNpcControl = self._ui._questUI[controlIndex]._txt_CompleteNpc
        completeNpcControl:SetShow(true)
        completeNpcControl:SetTextMode(__eTextMode_AutoWrap)
        completeNpcControl:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "QUESTLIST_COMPLETETARGET", "getCompleteDisplay", completeNpc))
        local btn_QuestNavi = UI.getChildControl(self._ui._questUI[controlIndex]._bg, "Checkbox_ListMain_QuestNavi")
        local btn_AutoNavi = UI.getChildControl(self._ui._questUI[controlIndex]._bg, "CheckButton_ListMain_AutoNavi")
        local btn_GiveUp = UI.getChildControl(self._ui._questUI[controlIndex]._bg, "Checkbox_ListMain_QuestGiveup")
        local btn_Tag = UI.getChildControl(self._ui._questUI[controlIndex]._bg, "Checkbox_ListMain_QuestTag")
        if _QuestWidget_ReturnQuestState ~= nil then
          local _questGroupId, _questId, _naviInfoAgain, _naviIsAutoRun = _QuestWidget_ReturnQuestState()
          if questGroupNo == _questGroupId and questNo == _questId then
            if true == _naviInfoAgain then
              btn_QuestNavi:SetCheck(false)
            else
              btn_QuestNavi:SetCheck(true)
              if true == _naviIsAutoRun then
                btn_AutoNavi:SetCheck(true)
              end
            end
          else
            btn_AutoNavi:SetCheck(false)
            btn_QuestNavi:SetCheck(false)
          end
        end
        btn_QuestNavi:addInputEvent("Mouse_LUp", "PaGlobal_HardCoreQuestDetails:findQuestNavi(" .. tostring(index) .. ", false)")
        btn_AutoNavi:addInputEvent("Mouse_LUp", "PaGlobal_HardCoreQuestDetails:findQuestNavi(" .. tostring(index) .. ", true)")
        btn_GiveUp:addInputEvent("Mouse_LUp", "PaGlobal_HardCoreQuestDetails_QuestGiveUp(" .. questGroupNo .. "," .. questNo .. ")")
        btn_Tag:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_Tag(" .. questGroupNo .. "," .. questNo .. ")")
        local questInfo = ToClient_GetQuestInfo(questGroupNo, questNo)
        local demandCount = progressQuestWarpper:getDemadCount()
        local demandString = ""
        for demandIndex = 0, demandCount - 1 do
          if questInfo ~= nil then
            local demand = questInfo:getDemandAt(demandIndex)
            if demand._destCount <= demand._currentCount then
              demandString = demandString .. "<PAColor0xFF626262>- " .. demand._desc .. " (" .. PAGetString(Defines.StringSheet_GAME, "DIALOG_BUTTON_QUEST_COMPLETE") .. ")<PAOldColor>\n"
            elseif demand._destCount == 1 then
              demandString = demandString .. "- " .. demand._desc .. "\n"
            else
              demandString = demandString .. "- " .. demand._desc .. " (" .. demand._currentCount .. "/" .. demand._destCount .. ")\n"
            end
          else
            local demand = progressQuestWarpper:getDemandAt(demandIndex)
            if 1 < demand._destCount then
              demandString = demandString .. "- " .. demand._desc .. " (0/" .. demand._destCount .. ")\n"
            else
              demandString = demandString .. "- " .. demand._desc .. "\n"
            end
          end
        end
        local questConditionControl = self._ui._questUI[controlIndex]._txt_QuestCondition
        questConditionControl:SetShow(true)
        questConditionControl:SetTextMode(__eTextMode_AutoWrap)
        questConditionControl:SetAutoResize(true)
        questConditionControl:SetText(tostring(ToClient_getReplaceDialog(demandString)))
        local descControl = self._ui._questUI[controlIndex]._txt_QuestDesc
        descControl:SetPosY(questConditionControl:GetPosY() + questConditionControl:GetSizeY())
        descControl:SetTextMode(__eTextMode_AutoWrap)
        local questDesc = questWarpper:getDesc()
        descControl:SetText(ToClient_getReplaceDialog(questDesc))
        descControl:setLocalizedStaticType(18)
        descControl:setLocalizedKey(questWarpper:getDescLocalizedKey())
        descControl:SetIgnore(true)
        descControl:SetSize(descControl:GetSizeX(), descControl:GetTextSizeY())
        self:rewardUpdate(controlIndex, questGroupNo, questNo)
        local itemSlot = self._ui._questUI[controlIndex]._itemSlotBg[0]
        local descBgSizeY = itemSlot:GetPosY() + itemSlot:GetSizeY() + bottomGap
        self._ui._questUI[controlIndex]._descBg:SetSize(self._ui._questUI[controlIndex]._descBg:GetSizeX(), descBgSizeY)
        lastQuestListPosY = self._ui._questUI[controlIndex]._bg:GetPosY() + self._ui._questUI[controlIndex]._bg:GetSizeY() + descBgSizeY
        controlIndex = controlIndex + 1
      end
    end
  end
  local panelSizeY = lastQuestListPosY + bottomGap
  if panelSizeY < self._originalPanelSizeY then
    panelSizeY = self._originalPanelSizeY
  end
  Panel_Window_Quest_HardCore:SetSize(Panel_Window_Quest_HardCore:GetSizeX(), panelSizeY)
  if controlIndex > 0 then
    self._ui._noneQuest:SetShow(false)
  else
    self._ui._noneQuest:SetShow(true)
  end
end
function PaGlobal_HardCoreQuestDetails:openQuestInfo(index)
  if Panel_Window_Quest_HardCore == nil then
    return
  end
  local questKeyRaw = self._questData[index]
  if questKeyRaw == nil then
    return
  end
  local progressQuestWarpper = ToClient_getProgressingQuestAtKey(questKeyRaw)
  local questWarpper = questList_getQuestInfo(questKeyRaw)
  local questGroupNo = questWarpper:getQuestGroupNo()
  local questNo = questWarpper:getQuestGroupQuestNo()
  local questCondition
  if progressQuestWarpper ~= nil and true == progressQuestWarpper:isSatisfied() then
    questCondition = QuestConditionCheckType.eQuestConditionCheckType_Complete
  else
    questCondition = QuestConditionCheckType.eQuestConditionCheckType_Progress
  end
  PaGlobalFunc_QuestInfo_All_Detail(questGroupNo, questNo, questCondition, "nil", nil, false, false, true, isCleared, nil, index, false)
end
function PaGlobal_HardCoreQuestDetails:findQuestNavi(index, isAuto)
  if Panel_Window_Quest_HardCore == nil then
    return
  end
  local questKeyRaw = self._questData[index]
  if questKeyRaw == nil then
    return
  end
  local progressQuestWarpper = ToClient_getProgressingQuestAtKey(questKeyRaw)
  local questWarpper = questList_getQuestInfo(questKeyRaw)
  local questGroupNo = questWarpper:getQuestGroupNo()
  local questNo = questWarpper:getQuestGroupQuestNo()
  local questCondition
  if progressQuestWarpper ~= nil and true == progressQuestWarpper:isSatisfied() then
    questCondition = QuestConditionCheckType.eQuestConditionCheckType_Complete
  else
    questCondition = QuestConditionCheckType.eQuestConditionCheckType_Progress
  end
  PaGlobalFunc_Quest_All_FindWay(questGroupNo, questNo, questCondition, isAuto)
end
function PaGlobal_HardCoreQuestDetails:rewardUpdate(questIndex, groupID, questID)
  local questStaticInfo = questList_getQuestStatic(groupID, questID)
  if nil == questStaticInfo then
    UI.ASSERT_NAME(false, "PaGlobal_HardCoreQuestDetails:rewardUpdate() questStaticInfo is nil.", "\237\153\169\236\157\184\235\178\148")
    return
  end
  local baseCount = questStaticInfo:getQuestBaseRewardCount()
  local selectCount = questStaticInfo:getQuestSelectRewardCount()
  local questDescBg = self._ui._questUI[questIndex]._txt_QuestDesc
  local title = self._ui._questUI[questIndex]._txt_RewardTitle
  title:SetPosY(questDescBg:GetPosY() + questDescBg:GetSizeY() + 30)
  local rewardIconPosY = title:GetPosY() + title:GetSizeY() + 5
  for baseIdx = 1, baseCount do
    local baseReward = questStaticInfo:getQuestBaseRewardAt(baseIdx - 1)
    self._baseReward[baseIdx] = {
      _type = nil,
      _isMoney = false,
      _key = nil,
      _value = nil
    }
    self._baseReward[baseIdx]._type = baseReward:getType()
    self._baseReward[baseIdx]._isMoney = baseReward:isMoney()
    if self._baseReward[baseIdx]._isMoney == true or self._baseReward[baseIdx]._type == __eRewardLifeExp or self._baseReward[baseIdx]._type == __eRewardIntimacy or self._baseReward[baseIdx]._type == __eRewardKnowledge or self._baseReward[baseIdx]._type == __eRewardSeasonReward or self._baseReward[baseIdx]._type == __eRewardExploreExp or self._baseReward[baseIdx]._type == __eRewardFamilyStat then
      UI.ASSERT_NAME(false, "PaGlobal_HardCoreQuestDetails:rewardUpdate() \237\149\152\235\147\156\236\189\148\236\150\180\236\132\156\235\178\132\236\151\144\236\132\156 \236\132\164\236\160\149\235\144\152\236\150\180 \236\158\136\236\167\128 \236\149\138\236\157\128 \237\128\152\236\138\164\237\138\184 \235\179\180\236\131\129\236\158\133\235\139\136\235\139\164.", "\237\153\169\236\157\184\235\178\148")
      return
    end
    if __eRewardItem == self._baseReward[baseIdx]._type then
      self._baseReward[baseIdx]._key = baseReward:getItemEnchantKey()
      self._baseReward[baseIdx]._value = baseReward:getItemCount()
    end
  end
  for index = 0, self._itemSlotMaxCount - 1 do
    local itemSlot = self._ui._questUI[questIndex]._itemSlot[index]
    local itemSlotBg = self._ui._questUI[questIndex]._itemSlotBg[index]
    itemSlotBg:SetPosY(rewardIconPosY)
    itemSlot.icon:addInputEvent("Mouse_On", "")
    itemSlot.icon:addInputEvent("Mouse_Out", "")
    itemSlotBg:addInputEvent("Mouse_On", "")
    itemSlotBg:addInputEvent("Mouse_Out", "")
    itemSlotBg:registerPadEvent(__eConsoleUIPadEvent_X, "")
    self._ui._questUI[questIndex]._itemSlot[index]:clearItem()
  end
  local baseRewardSlotIndex = 0
  for ii = 1, #self._baseReward do
    if self._baseReward[ii]._isMoney == false then
      self:setReward(self._ui._questUI[questIndex]._itemSlot[ii - 1], self._baseReward[ii], baseRewardSlotIndex, questIndex)
      baseRewardSlotIndex = baseRewardSlotIndex + 1
    end
  end
end
function PaGlobal_HardCoreQuestDetails:setReward(uiSlot, reward, index, questIndex)
  uiSlot._type = reward._type
  if uiSlot.count ~= nil then
    uiSlot.count:SetText("")
  end
  uiSlot.icon:SetAlpha(1)
  uiSlot.icon:ChangeTextureInfoNameAsync("")
  local texturePathList = {
    [__eRewardExp] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds",
    [__eRewardSkillExp] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/SkillExp.dds",
    [__eRewardExpGrade] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/ExpGrade.dds",
    [__eRewardSkillExpGrade] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/SkillExpGrade.dds",
    [__eRewardCharacterStat] = "Icon/New_Icon/03_ETC/03_Quest_Item/familystat_001.dds"
  }
  local typeStr = {
    [__eRewardExp] = "Exp",
    [__eRewardSkillExp] = "SkillExp",
    [__eRewardExpGrade] = "ExpGrade",
    [__eRewardSkillExpGrade] = "SkillExpGrade",
    [__eRewardCharacterStat] = "CharacterStat"
  }
  local questTypeSlotBg = self._ui._questUI[questIndex]._itemSlotBg[index]
  if nil ~= texturePathList[reward._type] then
    if uiSlot.count ~= nil then
      uiSlot.count:SetText("")
    end
    uiSlot.icon:ChangeTextureInfoNameAsync(texturePathList[reward._type])
    if true == self._isConsole then
      questTypeSlotBg:addInputEvent("Mouse_On", "rewardTooltip_ForHardCoreQuestWindow(" .. typeStr[reward._type] .. ", true," .. questIndex .. "," .. index .. ")")
      questTypeSlotBg:addInputEvent("Mouse_Out", "rewardTooltip_ForHardCoreQuestWindow(" .. typeStr[reward._type] .. ", false," .. questIndex .. "," .. index .. ")")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "rewardTooltip_ForHardCoreQuestWindow(" .. typeStr[reward._type] .. ", true," .. questIndex .. "," .. index .. ")")
      uiSlot.icon:addInputEvent("Mouse_Out", "rewardTooltip_ForHardCoreQuestWindow(" .. typeStr[reward._type] .. ", false," .. questIndex .. "," .. index .. ")")
    end
  end
  if __eRewardItem == reward._type then
    local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(reward._key))
    uiSlot:setItemByStaticStatus(itemStatic, reward._value)
    uiSlot._item = reward._key
    local itemIndex = questIndex * self._itemSlotMaxCount + index
    if true == self._isConsole then
      if true == _ContentsGroup_RenewUI_Tooltip then
        questTypeSlotBg:registerPadEvent(__eConsoleUIPadEvent_X, "HandlePadEventX_QuestInfo_All_HardCoreRewardItemTooltip(" .. itemIndex .. ")")
      else
        questTypeSlotBg:registerPadEvent(__eConsoleUIPadEvent_X, "Panel_Tooltip_Item_Show_GeneralStatic(" .. itemIndex .. ",\"QuestHardCoreReward_Base\",true)")
        questTypeSlotBg:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralStatic(" .. itemIndex .. ",\"QuestHardCoreReward_Base\",false)")
      end
    else
      uiSlot.icon:addInputEvent("Mouse_On", "Panel_Tooltip_Item_Show_GeneralStatic(" .. itemIndex .. ",\"QuestHardCoreReward_Base\",true)")
      uiSlot.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralStatic(" .. itemIndex .. ",\"QuestHardCoreReward_Base\",false)")
    end
  end
end
