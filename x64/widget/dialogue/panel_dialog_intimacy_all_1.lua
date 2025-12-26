function PaGlobal_DialogIntimacy_All:initialize()
  if true == PaGlobal_DialogIntimacy_All._initialize then
    return
  end
  self:controlAll_Init()
  self:controlSetShow()
  for index = 0, self._maxIntimacyRewardCount - 1 do
    local rewardSlot = {}
    rewardSlot.icon = UI.createAndCopyBasePropertyControl(Panel_Npc_Intimacy_All, "Static_RewardIconTemplete", Panel_Npc_Intimacy_All, "Reward_Icon_" .. index)
    rewardSlot.reward = UI.createAndCopyBasePropertyControl(Panel_Npc_Intimacy_All, "StaticText_RewardTemplete", Panel_Npc_Intimacy_All, "Reward_" .. index)
    self._rewardList[index] = rewardSlot
    self._rewardList[index].icon:SetShow(false)
    self._rewardList[index].reward:SetShow(false)
  end
  self._rewardTextPos.x = self._ui.stc_progressBg:GetPosX()
  self._rewardTextPos.y = self._ui.stc_progressBg:GetPosY() + self._space.progressToReward
  PaGlobal_DialogIntimacy_All:registEventHandler()
  PaGlobal_DialogIntimacy_All:validate()
  PaGlobal_DialogIntimacy_All._initialize = true
end
function PaGlobal_DialogIntimacy_All:controlAll_Init()
  if nil == Panel_Npc_Intimacy_All then
    return
  end
  self._ui.stc_title = UI.getChildControl(Panel_Npc_Intimacy_All, "StaticText_Title")
  self._ui.stc_progressBg = UI.getChildControl(Panel_Npc_Intimacy_All, "Static_IntimacyProgressBg")
  self._ui.stc_progress = UI.getChildControl(Panel_Npc_Intimacy_All, "Progress2_IntimacyProgress")
  self._ui.stc_rewardIcon = UI.getChildControl(Panel_Npc_Intimacy_All, "Static_RewardIconTemplete")
  self._ui.stc_rewardTemplete = UI.getChildControl(Panel_Npc_Intimacy_All, "StaticText_RewardTemplete")
  self._ui.stc_npcIcon = UI.getChildControl(Panel_Npc_Intimacy_All, "Static_NPCTag")
  self._ui.stc_tagIcon = UI.getChildControl(self._ui.stc_npcIcon, "Static_TagIcon")
  self._ui.txt_npcName = UI.getChildControl(Panel_Npc_Intimacy_All, "StaticText_NPCName")
  self._ui.txt_npcTitle = UI.getChildControl(Panel_Npc_Intimacy_All, "StaticText_NPCTitle")
end
function PaGlobal_DialogIntimacy_All:controlSetShow()
  if nil == Panel_Npc_Intimacy_All then
    return
  end
  self._ui.stc_rewardIcon:SetShow(false)
  self._ui.stc_rewardTemplete:SetShow(false)
end
function PaGlobal_DialogIntimacy_All:resize()
  if nil == Panel_Npc_Intimacy_All then
    return
  end
end
function PaGlobal_DialogIntimacy_All:prepareOpen()
  if nil == Panel_Npc_Intimacy_All then
    return
  end
  local talker = dialog_getTalker()
  if nil == talker then
  end
  PaGlobalFunc_DialogIntimacy_All_IntimacyShow()
  PaGlobal_DialogIntimacy_All:resize()
  PaGlobal_DialogIntimacy_All:open()
  PaGlobal_DialogIntimacy_All:intimacyValueUpdate()
end
function PaGlobal_DialogIntimacy_All:open()
  if nil == Panel_Npc_Intimacy_All then
    return
  end
  Panel_Npc_Intimacy_All:SetShow(true)
end
function PaGlobal_DialogIntimacy_All:prepareClose()
  if nil == Panel_Npc_Intimacy_All then
    return
  end
  if _ContentsGroup_QuestBackEndLoading == true then
    self:clearQuestLoadingTable()
  end
  PaGlobal_DialogIntimacy_All:close()
end
function PaGlobal_DialogIntimacy_All:close()
  if nil == Panel_Npc_Intimacy_All then
    return
  end
  Panel_Npc_Intimacy_All:SetShow(false)
end
function PaGlobal_DialogIntimacy_All:update()
  if nil == Panel_Npc_Intimacy_All then
    return
  end
end
function PaGlobal_DialogIntimacy_All:validate()
  if nil == Panel_Npc_Intimacy_All then
    return
  end
end
function PaGlobal_DialogIntimacy_All:registEventHandler()
  if nil == Panel_Npc_Intimacy_All then
    return
  end
  self._ui.stc_progress:addInputEvent("Mouse_On", "HandleEventOnOut_DialogIntimacy_All_CircleTooltip(true)")
  self._ui.stc_progress:addInputEvent("Mouse_Out", "HandleEventOnOut_DialogIntimacy_All_CircleTooltip(false)")
  if _ContentsGroup_QuestBackEndLoading == true then
    registerEvent("FromClient_QuestBackEndLoadComplete", "FromClient_DialogIntimacy_QuestBackEndLoadComplete")
  end
end
function PaGlobal_DialogIntimacy_All:intimacyValueUpdate()
  if nil == Panel_Npc_Intimacy_All then
    return
  end
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    ToClient_PopDialogueFlush()
    return
  end
  local npcTitle = dialogData:getContactNpcTitle()
  local npcName = dialogData:getContactNpcName()
  self._ui.txt_npcName:SetText(npcName)
  self._ui.txt_npcTitle:SetText(npcTitle)
  local talker = dialog_getTalker()
  local index = 0
  self._intimacyValueBuffer = {}
  if nil == npcTitle or "" == npcTitle then
    self._ui.txt_npcName:SetSpanSize(self._ui.txt_npcName:GetSpanSize().x, 20)
  else
    self._ui.txt_npcName:SetSpanSize(self._ui.txt_npcName:GetSpanSize().x, 30)
  end
  self._ui.txt_npcName:ComputePos()
  if nil ~= talker then
    local characterKey = talker:getCharacterKey()
    local dialogIndex = talker:get():getDialogIndex()
    local npcData = getNpcInfoByCharacterKeyRaw(characterKey, dialogIndex)
    if nil ~= npcData then
      self:npcTagIconSet(npcData:getSpawnType())
      if true == npcData:hasSpawnType(CppEnums.SpawnType.eSpawnType_intimacy) then
        local intimacy = getIntimacyByCharacterKey(characterKey)
        self._ui.stc_title:SetShow(true)
        self._ui.stc_title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DIALOG_INTIMACY_ALL_VALUE", "intimacy", intimacy))
        local valuePercent = intimacy / 1000 * 100
        if valuePercent > 100 then
          valuePercent = 100
        end
        self._ui.stc_progressBg:SetShow(true)
        self._ui.stc_progress:SetShow(true)
        self._ui.stc_progress:SetProgressRate(valuePercent)
        self:updateIntimacyReward(characterKey, intimacy, dialogIndex)
        return
      end
    end
  else
    self:npcTagIconSet(CppEnums.SpawnType.eSpawnType_Count)
    self._ui.txt_npcName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_INTIMACY_ALL_BLACKSPIRIT"))
  end
  PaGlobalFunc_DialogIntimacy_All_IntimacyHide()
end
function PaGlobal_DialogIntimacy_All:npcTagIconSet(spawnType)
  if nil == self._npcTypeIcon[spawnType] then
    return
  end
  self._ui.stc_tagIcon:ChangeTextureInfoNameAsync(self._npcTypeIconTexturePath)
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_tagIcon, self._npcTypeIcon[spawnType][1], self._npcTypeIcon[spawnType][2], self._npcTypeIcon[spawnType][3], self._npcTypeIcon[spawnType][4])
  self._ui.stc_tagIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.stc_tagIcon:setRenderTexture(self._ui.stc_tagIcon:getBaseTexture())
end
function PaGlobal_DialogIntimacy_All:updateIntimacyReward(characterKey, intimacy, dialogIndex)
  if nil == Panel_Npc_Intimacy_All then
    return
  end
  local count = getIntimacyInformationCount(characterKey)
  local QuestCount = 1
  local listIndex = 0
  for index = 0, self._maxIntimacyRewardCount - 1 do
    if index < count then
      local intimacyInformationData = getIntimacyInformation(characterKey, index)
      if intimacyInformationData ~= nil then
        local imageType = intimacyInformationData:getTypeIndex()
        local invalidInfo = false
        if imageType == CppEnums.IntimacyInformationTypeInfo.eIntimacyInformationTypeInfo_Knowledge and intimacyInformationData:getDialogIndex() ~= dialogIndex then
          invalidInfo = true
        end
        if invalidInfo == false then
          listIndex = listIndex + 1
          local percent = intimacyInformationData:getIntimacy() / 1000
          local giftName = intimacyInformationData:getTypeName()
          local giftDesc = intimacyInformationData:getTypeDescription()
          local RewardIcon = self._rewardList[index].icon
          local Rewardtext = self._rewardList[index].reward
          if intimacyInformationData:isQuestType() == true and intimacyInformationData:isLoadedQuestBackEnd() == false then
            local questNo = intimacyInformationData:getQuestNo()
            local questSSW = questList_getQuestStatic(questNo._group, questNo._quest)
            if questSSW ~= nil then
              self:pushQuestLoadingData(questSSW, characterKey, intimacy, dialogIndex)
            else
              UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. questSSW\234\176\128 nil\236\157\180\235\169\180 \236\149\136\235\144\169\235\139\136\235\139\164. \237\153\149\236\157\184\236\157\180 \234\188\173 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164. \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
            end
          end
          local giftMentalCardWrapper = ToClinet_getMentalCardStaticStatus(intimacyInformationData:getMentalCardKeyRaw())
          if nil ~= giftMentalCardWrapper then
            if giftMentalCardWrapper:isHasCard() then
              giftDesc = giftDesc .. " <PAColor0xFFF5BA3A>" .. self._text.hasMentalCardText .. "<PAOldColor>"
              Rewardtext:SetColor(Defines.Color.C_FFFFEDD4)
              RewardIcon:SetColor(Defines.Color.C_FFFFEDD4)
              Rewardtext:SetFontColor(Defines.Color.C_FFFFEDD4)
              RewardIcon:SetAlpha(1)
              Rewardtext:SetAlpha(1)
            else
              giftDesc = giftDesc .. " " .. self._text.hasntMentalCardText
              Rewardtext:SetColor(Defines.Color.C_FFC0A989)
              RewardIcon:SetColor(Defines.Color.C_FFC0A989)
              Rewardtext:SetFontColor(Defines.Color.C_FFC0A989)
              RewardIcon:SetAlpha(0.8)
              Rewardtext:SetAlpha(0.8)
            end
          else
            Rewardtext:SetColor(Defines.Color.C_FFC0A989)
            RewardIcon:SetColor(Defines.Color.C_FFC0A989)
            Rewardtext:SetFontColor(Defines.Color.C_FFC0A989)
            RewardIcon:SetAlpha(0.8)
            Rewardtext:SetAlpha(0.8)
          end
          local IconType
          if 0 == imageType then
            IconType = self._intimacyIcon[imageType][QuestCount]
            QuestCount = QuestCount + 1
            if QuestCount > 3 then
              QuestCount = 3
            end
          else
            IconType = self._intimacyIcon[imageType]
          end
          Rewardtext:ChangeTextureInfoNameAsync(IconType.texture)
          local x1, y1, x2, y2 = setTextureUV_Func(Rewardtext, IconType.x1, IconType.y1, IconType.x2, IconType.y2)
          Rewardtext:getBaseTexture():setUV(x1, y1, x2, y2)
          Rewardtext:setRenderTexture(Rewardtext:getBaseTexture())
          Rewardtext:SetShow(true)
          if not (percent >= 0) or not (percent <= 1) or ToClient_checkIntimacyInformationFixedState(intimacyInformationData) then
          end
          local giftValue = ""
          local giftOperator = intimacyInformationData:getOperatorType()
          giftValue = "(" .. self._operatorString[giftOperator] .. " " .. percent * 1000 .. ")"
          local PosY = self._rewardTextPos.y + listIndex * self._space.rewardTextHBorder
          Rewardtext:SetPosY(PosY)
          Rewardtext:SetText(giftName .. " : " .. giftDesc .. " " .. giftValue)
        else
          self._rewardList[index].icon:SetShow(false)
          self._rewardList[index].reward:SetShow(false)
        end
      else
        self._rewardList[index].icon:SetShow(false)
        self._rewardList[index].reward:SetShow(false)
      end
    else
      self._rewardList[index].icon:SetShow(false)
      self._rewardList[index].reward:SetShow(false)
    end
  end
end
function PaGlobal_DialogIntimacy_All:clearQuestLoadingTable()
  if Panel_Npc_Intimacy_All == nil or _ContentsGroup_QuestBackEndLoading == false then
    return
  end
  self._questLoadingDataList = Array.new()
end
function PaGlobal_DialogIntimacy_All:pushQuestLoadingData(questSSW, characterKey, intimacy, dialogIndex)
  if Panel_Npc_Intimacy_All == nil or _ContentsGroup_QuestBackEndLoading == false or questSSW == nil then
    return
  end
  if self._questLoadingDataList == nil then
    self:clearQuestLoadingTable()
  end
  local newLoadingData = {
    _questNoRaw = questSSW:getQuestNo()._raw,
    _param_0 = characterKey,
    _param_1 = intimacy,
    _param_2 = dialogIndex
  }
  if self:isExistLoadingDataAnyOne() == true then
    for index = #self._questLoadingDataList, 1, -1 do
      local value = self._questLoadingDataList[index]
      if value ~= nil and value._questNoRaw == newLoadingData._questNoRaw then
        table.remove(self._questLoadingDataList, index)
      end
    end
  end
  self._questLoadingDataList:push_back(newLoadingData)
  questSSW:requestLoadBackEndData()
end
function PaGlobal_DialogIntimacy_All:isExistLoadingDataAnyOne()
  if Panel_Npc_Intimacy_All == nil or _ContentsGroup_QuestBackEndLoading == false then
    return false
  end
  if self._questLoadingDataList == nil then
    return false
  end
  local isExistAnyOne = self._questLoadingDataList:length() ~= 0
  return isExistAnyOne
end
