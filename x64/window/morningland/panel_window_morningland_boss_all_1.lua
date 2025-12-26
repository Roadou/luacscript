function PaGlobal_MorningLand_Boss_All:initialize()
  if self._isInitialize == true then
    return
  end
  if _ContentsGroup_MorningLand == false then
    return
  end
  if Panel_Window_MorningLand_Boss_All == nil then
    return
  end
  self._ui.stc_titleArea = UI.getChildControl(Panel_Window_MorningLand_Boss_All, "Static_TitleArea")
  self._ui.btn_closePC = UI.getChildControl(self._ui.stc_titleArea, "Button_Close_PCUI")
  self._ui.stc_tabArea = UI.getChildControl(Panel_Window_MorningLand_Boss_All, "Static_TabArea")
  self._ui.rdo_MorningLandPart1 = UI.getChildControl(self._ui.stc_tabArea, "Radiobutton_Morning1")
  self._ui.rdo_MorningLandPart2 = UI.getChildControl(self._ui.stc_tabArea, "Radiobutton_Morning2")
  self._ui.stc_selectBar = UI.getChildControl(self._ui.stc_tabArea, "Static_SelectBar")
  self._ui.stc_mainArea = UI.getChildControl(Panel_Window_MorningLand_Boss_All, "Static_MainArea")
  self._ui.stc_mainContentsLock = UI.getChildControl(self._ui.stc_mainArea, "Static_MainContents_Lock")
  self._ui.stc_mainContents = UI.getChildControl(self._ui.stc_mainArea, "Static_MainContents")
  self._ui.txt_conqeustCountTitle = UI.getChildControl(self._ui.stc_mainContents, "StaticText_Weekly_ConqeustTitle")
  self._ui.txt_conqeustCount = UI.getChildControl(self._ui.stc_mainContents, "StaticText_Weekly_ConqeustCount")
  self._ui.btn_conquestHistory = UI.getChildControl(self._ui.stc_mainContents, "Button_ConquestHistory_View")
  self._ui.btn_attributeManage = UI.getChildControl(self._ui.stc_mainContents, "Button_Attribute_Manage")
  self._ui.btn_attributeDisable = UI.getChildControl(self._ui.stc_mainContents, "Button_Attribute_Disable")
  self._ui.btn_rankingView = UI.getChildControl(self._ui.stc_mainContents, "Button_Ranking_View")
  self._ui.btn_MyReward = UI.getChildControl(self._ui.stc_mainContents, "Button_MyReward_View")
  self._ui.stc_getAble = UI.getChildControl(self._ui.btn_MyReward, "Static_MyReward_Gettable")
  self._ui.stc_limitAttackPoint = UI.getChildControl(self._ui.stc_mainContents, "StaticText_LimitAttackPoint")
  self._ui.stc_liimtAPValue = UI.getChildControl(self._ui.stc_limitAttackPoint, "StaticText_LimitAPValue")
  self._ui.stc_myAPValue = UI.getChildControl(self._ui.stc_limitAttackPoint, "StaticText_MyAPValue")
  self._ui.txt_bossWeeknessTitle = UI.getChildControl(self._ui.stc_mainContents, "StaticText_BossWeaknessTitle")
  self._ui.stc_bossWeeknessBg = UI.getChildControl(self._ui.stc_mainContents, "Static_BossWeaknessBG")
  self._ui.txt_bossWeekness = UI.getChildControl(self._ui.stc_bossWeeknessBg, "StaticText_BossWeakness")
  self._ui.txt_impossibleIcon = UI.getChildControl(self._ui.stc_bossWeeknessBg, "Static_ImpossibleIcon")
  self._ui.stc_rewardBox = UI.getChildControl(self._ui.stc_mainContents, "Static_RewardBox")
  self._ui.txt_bossName = UI.getChildControl(self._ui.stc_mainContents, "StaticText_BossName")
  self._ui.txt_bossDesc = UI.getChildControl(self._ui.stc_mainContents, "StaticText_BossDesc")
  self._ui.stc_clearChar = UI.getChildControl(self._ui.stc_mainContents, "Static_FirstClearBox")
  self._ui.txt_clearChar = UI.getChildControl(self._ui.stc_clearChar, "StaticText_FirstClear_CharName")
  self._ui.stc_clearTimeRecord = UI.getChildControl(self._ui.stc_mainContents, "Static_ClearTimeRecord")
  self._ui.txt_clearTimeRecord = UI.getChildControl(self._ui.stc_clearTimeRecord, "StaticText_ClearTime")
  self._ui.stc_clearTime = UI.getChildControl(self._ui.stc_mainContents, "Static_ClearTimeBox")
  self._ui.txt_clearTime = UI.getChildControl(self._ui.stc_clearTime, "StaticText_ClearTime")
  self._ui.btn_conquestStart = UI.getChildControl(self._ui.stc_mainContents, "Button_ConquestStart")
  self._ui.btn_moveToWayPoint = UI.getChildControl(self._ui.stc_mainContents, "Button_MoveToWayPoint")
  self._ui.btn_conquestEnter = UI.getChildControl(self._ui.stc_mainContents, "Button_ConquestEnter")
  self._ui.txt_enter = UI.getChildControl(self._ui.btn_conquestEnter, "StaticText_Enter")
  self._ui.btn_conquestEnterParty = UI.getChildControl(self._ui.stc_mainContents, "Button_ConquestEnter_Party")
  self._ui.txt_enterParty = UI.getChildControl(self._ui.btn_conquestEnterParty, "StaticText_EnterParty")
  self._ui.stc_difficulty = UI.getChildControl(self._ui.stc_mainContents, "Static_Difficulty_RadioBox")
  self._ui.txt_difficulty = UI.getChildControl(self._ui.stc_difficulty, "StaticText_DifficultyText")
  self._ui.stc_txtBubble = UI.getChildControl(self._ui.stc_mainArea, "Static_TextBubble")
  self._ui.stc_princessImage = UI.getChildControl(self._ui.stc_mainArea, "Static_PrincessImage")
  self._ui.txt_bubble = UI.getChildControl(self._ui.stc_mainArea, "StaticText_Bubble")
  self._ui.stc_statManageArea = UI.getChildControl(Panel_Window_MorningLand_Boss_All, "Static_StatManageArea")
  self._ui.stc_statView = UI.getChildControl(self._ui.stc_statManageArea, "Static_StatManageView")
  self._ui.stc_attributeViewPointBox = UI.getChildControl(self._ui.stc_statView, "Static_AttributePointBox")
  self._ui.txt_attributeViewPoint = UI.getChildControl(self._ui.stc_attributeViewPointBox, "StaticText_AttributePoint")
  self._ui.btn_attributeViewReset = UI.getChildControl(self._ui.stc_statView, "Button_Attribute_Reset")
  self._ui.stc_statContents = UI.getChildControl(self._ui.stc_statManageArea, "Static_StatManageContents")
  self._ui.btn_attribute0 = UI.getChildControl(self._ui.stc_statContents, "Radiobutton_Attribute_Tap0")
  self._ui.btn_attribute1 = UI.getChildControl(self._ui.stc_statContents, "Radiobutton_Attribute_Tap1")
  self._ui.btn_attribute2 = UI.getChildControl(self._ui.stc_statContents, "Radiobutton_Attribute_Tap2")
  self._ui.txt_effectDesc = UI.getChildControl(self._ui.stc_statContents, "StaticText_Effect_Desc")
  self._ui.stc_attributePointBox = UI.getChildControl(self._ui.stc_statContents, "Static_AttributePointBox")
  self._ui.txt_attributePoint = UI.getChildControl(self._ui.stc_attributePointBox, "StaticText_AttributePoint")
  self._ui.stc_attributeEnergyBox = UI.getChildControl(self._ui.stc_statContents, "Static_AttributeEnergyBox")
  self._ui.btn_attributeReset = UI.getChildControl(self._ui.stc_statContents, "Button_Attribute_Reset")
  self._ui.txt_myStatTitle = UI.getChildControl(self._ui.stc_statContents, "StaticText_MyStat_Title")
  self._ui.stc_myStatPointBox = UI.getChildControl(self._ui.stc_statContents, "Static_MyStatPointBox")
  self._ui.txt_myStatPoint = UI.getChildControl(self._ui.stc_myStatPointBox, "StaticText_MyStatPoint")
  self._ui.btn_myStatReset = UI.getChildControl(self._ui.stc_statContents, "Button_MyStat_Reset")
  self._ui.stc_statAttackBox = UI.getChildControl(self._ui.stc_statContents, "Static_Stat_AttackBox")
  self._ui.txt_statAttackTitle = UI.getChildControl(self._ui.stc_statAttackBox, "StaticText_Stat_Attack_Title")
  self._ui.txt_statAttack = UI.getChildControl(self._ui.stc_statAttackBox, "StaticText_Stat_Attack")
  self._ui.btn_attackUp = UI.getChildControl(self._ui.stc_statContents, "Button_Attack_Up")
  self._ui.stc_statDeffenceBox = UI.getChildControl(self._ui.stc_statContents, "Static_Stat_DefenceBox")
  self._ui.txt_statDefTitle = UI.getChildControl(self._ui.stc_statDeffenceBox, "StaticText_Stat_Defence_Title")
  self._ui.txt_statDeffence = UI.getChildControl(self._ui.stc_statDeffenceBox, "StaticText_Stat_Defence")
  self._ui.btn_deffenceUp = UI.getChildControl(self._ui.stc_statContents, "Button_Defence_Up")
  self._ui.btn_statApply = UI.getChildControl(self._ui.stc_statContents, "Button_StatApply")
  self._ui.stc_difficultyMorning2 = UI.getChildControl(self._ui.stc_mainContents, "Static_Difficulty_RadioBox2")
  self._ui.btn_rankingViewMorning2 = UI.getChildControl(self._ui.stc_mainContents, "Button_Ranking_View2")
  self._ui.stc_difficultyMorning2 = UI.getChildControl(self._ui.stc_mainContents, "Static_Difficulty_RadioBox2")
  self._ui.rdo_difficultyMorning2_Easy = UI.getChildControl(self._ui.stc_difficultyMorning2, "RadioButton_Easy")
  self._ui.rdo_difficultyMorning2_Hard = UI.getChildControl(self._ui.stc_difficultyMorning2, "RadioButton_Hard")
  self._ui.btn_attributeClose = UI.getChildControl(self._ui.stc_statManageArea, "Button_Attribute_Close")
  self._ui.btn_attributeSet = UI.getChildControl(self._ui.stc_statManageArea, "Button_Attribute_Set")
  self._ui.list2_bossList = UI.getChildControl(Panel_Window_MorningLand_Boss_All, "List2_BossList")
  self._ui.list2_bossListMorning2 = UI.getChildControl(Panel_Window_MorningLand_Boss_All, "List2_BossList2")
  self._ui.stc_noticeArea = UI.getChildControl(Panel_Window_MorningLand_Boss_All, "Static_NoticeArea")
  self._ui.stc_noticeAreaText = UI.getChildControl(self._ui.stc_noticeArea, "StaticText_Notice")
  self._ui.stc_keyGuide = UI.getChildControl(Panel_Window_MorningLand_Boss_All, "Static_KeyGuide_ConsoleUI_Import")
  self._ui.stc_key_LT_Y = UI.getChildControl(self._ui.stc_keyGuide, "StaticText_LT_Y")
  self._ui.stc_key_LT_X = UI.getChildControl(self._ui.stc_keyGuide, "StaticText_LT_X")
  self._ui.stc_key_LT_A = UI.getChildControl(self._ui.stc_keyGuide, "StaticText_LT_A")
  self._ui.stc_key_Y = UI.getChildControl(self._ui.stc_keyGuide, "StaticText_Y")
  self._ui.stc_key_X = UI.getChildControl(self._ui.stc_keyGuide, "StaticText_X")
  self._ui.stc_key_A = UI.getChildControl(self._ui.stc_keyGuide, "StaticText_A_ConsoleUI")
  self._ui.stc_key_B = UI.getChildControl(self._ui.stc_keyGuide, "StaticText_B_ConsoleUI")
  self._ui.stc_key_LB = UI.getChildControl(self._ui.stc_keyGuide, "StaticText_LB_ConcoleUI")
  self._ui.stc_key_RB = UI.getChildControl(self._ui.stc_keyGuide, "StaticText_RB_ConcoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  local noticeAreaSize = self._ui.stc_noticeArea:GetSizeY()
  if ToClient_isXBox() == true or ToClient_isPS() == true then
    self._ui.stc_noticeAreaText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING_ATTRBOSS_NOTICE_CS"))
  end
  if _ContentsGroup_MorningLandTierParty == false then
    self._ui.stc_tabArea:SetShow(false)
    local tabSizeY = self._ui.stc_tabArea:GetSizeY()
    local tabSpanY = self._ui.stc_tabArea:GetSpanSize().y
    Panel_Window_MorningLand_Boss_All:SetSize(Panel_Window_MorningLand_Boss_All:GetSizeX(), Panel_Window_MorningLand_Boss_All:GetSizeY() - tabSizeY)
    self._ui.stc_mainArea:SetSpanSize(self._ui.stc_mainArea:GetSpanSize().x, tabSpanY)
    self._ui.stc_statManageArea:SetSpanSize(self._ui.stc_statManageArea:GetSpanSize().x, tabSpanY)
    self._ui.list2_bossList:SetSpanSize(self._ui.list2_bossList:GetSpanSize().x, tabSpanY)
    self._ui.stc_noticeArea:ComputePos()
  end
  self._ui.stc_noticeAreaText:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_noticeAreaText:SetText(self._ui.stc_noticeAreaText:GetText())
  self._ui.stc_noticeArea:SetSize(self._ui.stc_noticeArea:GetSizeX(), self._ui.stc_noticeAreaText:GetTextSizeY() + 10)
  self._ui.stc_noticeAreaText:ComputePos()
  noticeAreaSize = self._ui.stc_noticeArea:GetSizeY() - noticeAreaSize
  Panel_Window_MorningLand_Boss_All:SetSize(Panel_Window_MorningLand_Boss_All:GetSizeX(), Panel_Window_MorningLand_Boss_All:GetSizeY() + noticeAreaSize)
  self._ui.stc_keyGuide:SetPosY(Panel_Window_MorningLand_Boss_All:GetSizeY())
  self._ui.btn_attributeManage:SetTextMode(__eTextMode_Limit_AutoWrap)
  self._ui.btn_attributeManage:setLineCountByLimitAutoWrap(2)
  UI.setLimitAutoWrapTextAndAddTooltip(self._ui.btn_attributeManage, 2, "", self._ui.btn_attributeManage:GetText())
  self._ui.btn_attributeManage:ComputePos()
  self._ui.btn_rankingView:SetTextMode(__eTextMode_Limit_AutoWrap)
  self._ui.btn_rankingView:setLineCountByLimitAutoWrap(2)
  UI.setLimitAutoWrapTextAndAddTooltip(self._ui.btn_rankingView, 2, "", self._ui.btn_rankingView:GetText())
  self._ui.btn_rankingView:ComputePos()
  self._ui.btn_MyReward:SetTextMode(__eTextMode_Limit_AutoWrap)
  self._ui.btn_MyReward:setLineCountByLimitAutoWrap(2)
  UI.setLimitAutoWrapTextAndAddTooltip(self._ui.btn_MyReward, 2, "", self._ui.btn_MyReward:GetText())
  self._ui.btn_MyReward:ComputePos()
  self._clearTimePosY = self._ui.stc_clearTime:GetPosY()
  self._targetControlList = Array.new()
  self._rewardBtnList = Array.new()
  local rewardTemplate = UI.getChildControl(self._ui.stc_rewardBox, "Static_Reward_ItemSlot_Template")
  rewardTemplate:SetShow(false)
  for index = 0, 5 do
    local button = UI.cloneControl(rewardTemplate, self._ui.stc_rewardBox, "Button_Reward_" .. tostring(index))
    if index < 3 then
      button:SetSpanSize(index * (self._ui.stc_rewardBox:GetSizeX() / 3), 0)
    end
    if index > 2 then
      button:SetSpanSize((index - 3) * (self._ui.stc_rewardBox:GetSizeX() / 3), button:GetSizeY() + 5)
    end
    button:SetShow(false)
    self._rewardBtnList:push_back(button)
  end
  self._listShowRewardSlots = Array.new()
  for index = 0, 5 do
    local backBaseReward = UI.getChildControl(self._ui.stc_rewardBox, "Button_Reward_" .. index)
    backBaseReward:SetIgnore(true)
    local _bossRewardSlotConfig = {
      createIcon = true,
      createBorder = true,
      createEnchant = true,
      createCount = true,
      createClassEquipBG = true,
      createCash = true
    }
    local slot = {}
    SlotItem.new(slot, "BossReward_" .. index, index, backBaseReward, _bossRewardSlotConfig)
    slot:createChild()
    slot.icon:SetPosX(1)
    slot.icon:SetPosY(1)
    slot.icon:SetSize(40, 40)
    slot.border:SetSize(42, 42)
    slot.icon:SetIgnore(false)
    slot.icon:SetShow(false)
    self._listShowRewardSlots:push_back(slot)
  end
  self._difficultyList = Array.new()
  local difficultyTemplate = UI.getChildControl(self._ui.stc_difficulty, "RadioButton_Difficulty_Template")
  difficultyTemplate:SetShow(false)
  for index = 0, 9 do
    local difficultyData = {
      _button = nil,
      _select = nil,
      _talisman = nil,
      _isClear = nil
    }
    difficultyData._button = UI.cloneControl(difficultyTemplate, self._ui.stc_difficulty, "Button_Difficulty_" .. tostring(index))
    difficultyData._select = UI.getChildControl(difficultyData._button, "Static_Difficulty_Select")
    difficultyData._talisman = UI.getChildControl(difficultyData._button, "Static_Difficulty_Talisman")
    difficultyData._isClear = UI.getChildControl(difficultyData._button, "Static_IsClear")
    difficultyData._isClear:SetShow(false)
    PaGlobal_MorningLand_Boss_All:changeTextureLevel(difficultyData._talisman, index + 1, self._levelUV.levelNormal)
    difficultyData._button:SetSpanSize(index * (self._ui.stc_difficulty:GetSizeX() / 10), 0)
    difficultyData._select:SetShow(false)
    self._difficultyList:push_back(difficultyData)
  end
  self._attributeEnergyList = Array.new()
  local attributeEnergyTemplate = UI.getChildControl(self._ui.stc_attributeEnergyBox, "Button_AttributeEnergy_Template")
  for index = 0, 9 do
    local attributeEnergyData = {_button = nil}
    attributeEnergyData._button = UI.cloneControl(attributeEnergyTemplate, self._ui.stc_attributeEnergyBox, "Button_AttributeEnergy_" .. tostring(index))
    attributeEnergyData._button:SetSpanSize(index * (self._ui.stc_attributeEnergyBox:GetSizeX() / 10), 0)
    self._attributeEnergyList:push_back(attributeEnergyData)
    self._targetControlList:push_back(attributeEnergyData._button)
  end
  self._bossList = Array.new()
  self._bossListMorning2 = Array.new()
  for index = 0, PaGlobal_MorningLand_Boss_All._MORNINGLAND_PART1_BOSSCOUNT - 1 do
    local morningBossSSW = ToClient_getElementalMonsterInfo(index, 0)
    if nil ~= morningBossSSW then
      local morningBossData = {
        _group = morningBossSSW:getGroup(),
        _monsterKey = morningBossSSW:getCharacterKeyRaw(),
        _name = "",
        _stat = morningBossSSW:getElementalStatType(),
        _mentalCardKey = morningBossSSW:getUnlockConditionMentalCardKeyRaw()
      }
      local _monsterKeyRaw = morningBossSSW:getCharacterKeyRaw()
      local _monsterGroup = morningBossSSW:getGroup()
      local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(_monsterKeyRaw)
      morningBossData._name = characterStaticStatusWarpper:getName()
      self._bossList:push_back(morningBossData)
    end
  end
  for index = PaGlobal_MorningLand_Boss_All._MORNINGLAND_PART1_BOSSCOUNT, PaGlobal_MorningLand_Boss_All._MORNINGLAND_PART2_BOSSCOUNT - 1 do
    local morningBossSSW = ToClient_getElementalMonsterInfo(index, 0)
    if nil ~= morningBossSSW then
      local morningBossData = {
        _group = morningBossSSW:getGroup(),
        _monsterKey = morningBossSSW:getCharacterKeyRaw(),
        _name = "",
        _stat = morningBossSSW:getElementalStatType(),
        _mentalCardKey = morningBossSSW:getUnlockConditionMentalCardKeyRaw()
      }
      local _monsterKeyRaw = morningBossSSW:getCharacterKeyRaw()
      local _monsterGroup = morningBossSSW:getGroup()
      local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(_monsterKeyRaw)
      morningBossData._name = characterStaticStatusWarpper:getName()
      self._bossListMorning2:push_back(morningBossData)
    end
  end
  self._statViewList = Array.new()
  for index = 0, 2 do
    local statViewControl = UI.getChildControl(self._ui.stc_statView, "Static_Attribute_View_" .. tostring(index))
    local attributeTitle = UI.getChildControl(statViewControl, "StaticText_Attribute_Title")
    local attributeSetting = UI.getChildControl(statViewControl, "Button_StatManage")
    local attributeBox = UI.getChildControl(statViewControl, "Static_AttributeEnergyBox")
    attributeTitle:SetText(PAGetString(Defines.StringSheet_GAME, self._attributeDesc[index]))
    attributeSetting:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:openAttributeManager(" .. index .. ")")
    if index == __eElementalStat_Sun then
      attributeSetting:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.sun .. ", true)")
      attributeSetting:addInputEvent("Mouse_Out", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.sun .. ", false)")
    elseif index == __eElementalStat_Moon then
      attributeSetting:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.moon .. ", true)")
      attributeSetting:addInputEvent("Mouse_Out", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.moon .. ", false)")
    elseif index == __eElementalStat_Land then
      attributeSetting:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.land .. ", true)")
      attributeSetting:addInputEvent("Mouse_Out", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.land .. ", false)")
    end
    local attributeEnergyTemplate = UI.getChildControl(attributeBox, "Button_AttributeEnergy_Template")
    self._attributeEnergyViewList[index] = Array.new()
    for ii = 0, 9 do
      local attributeEnergyData = UI.cloneControl(attributeEnergyTemplate, attributeBox, "Button_AttributeEnergyView_" .. tostring(ii))
      if ii < 5 then
        attributeEnergyData:SetSpanSize(ii * (attributeBox:GetSizeX() / 5), 0)
      else
        local width = ii - 5
        attributeEnergyData:SetSpanSize(width * (attributeBox:GetSizeX() / 5), attributeBox:GetSizeY() / 2)
      end
      self._attributeEnergyViewList[index]:push_back(attributeEnergyData)
    end
    self._statViewList:push_back(statViewControl)
  end
  self._attributeList = Array.new()
  self._attributeList:push_back(self._ui.btn_attribute0)
  self._attributeList:push_back(self._ui.btn_attribute1)
  self._attributeList:push_back(self._ui.btn_attribute2)
  self:registEventHandler()
  if self._isConsole == true then
    self._ui.btn_closePC:SetShow(false)
    self._targetControlList:push_back(self._ui.btn_attributeClose)
    self._targetControlList:push_back(self._ui.btn_attributeReset)
    self._targetControlList:push_back(self._ui.btn_myStatReset)
    self._targetControlList:push_back(self._ui.btn_attackUp)
    self._targetControlList:push_back(self._ui.btn_deffenceUp)
    self._targetControlList:push_back(self._ui.btn_statApply)
    for ii = 1, #self._targetControlList do
      local targetControl = self._targetControlList[ii]
      if self._isConsole == true then
        targetControl:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:addInputEventForConsole( true )")
      end
    end
  end
  self._ui.btn_conquestStart:SetShow(_ContentsGroup_MorningLandTierGo == false)
  self._ui.btn_moveToWayPoint:SetShow(_ContentsGroup_MorningLandTierGo == false)
  self._ui.btn_conquestEnter:SetShow(_ContentsGroup_MorningLandTierGo == true)
  self._ui.btn_conquestEnterParty:SetShow(_ContentsGroup_MorningLandTierParty == true)
  self._sideBtnList[1] = self._ui.btn_attributeManage
  self._sideBtnList[2] = self._ui.btn_rankingView
  self._sideBtnList[3] = self._ui.btn_MyReward
  self._sideBtnList[4] = self._ui.btn_rankingViewMorning2
  self._sideBtnShowList = {
    [1] = 1,
    [2] = 2,
    [3] = 3
  }
  self._sideBtnShowListMorning2 = {
    [1] = 4,
    [2] = 3
  }
  PaGlobal_MorningLand_Boss_All:openBossListMorning1()
  self._ui.stc_clearChar:SetShow(false)
  self._initialize = true
end
function PaGlobal_MorningLand_Boss_All:registEventHandler()
  if nil == Panel_Window_MorningLand_Boss_All then
    return
  end
  if true == self._isConsole then
    Panel_Window_MorningLand_Boss_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "PaGlobal_MorningLand_Boss_All:toggleAttributeManager()")
    Panel_Window_MorningLand_Boss_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobalFunc_MorningMyReward_Open()")
    Panel_Window_MorningLand_Boss_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_MorningMyReward_MajorRewardTooltip()")
    Panel_Window_MorningLand_Boss_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobalFunc_MorningBossRank_Open()")
    Panel_Window_MorningLand_Boss_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_MorningLand_ConquestHistory_All_Open()")
    if _ContentsGroup_MorningLandTierParty == true then
      Panel_Window_MorningLand_Boss_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "PaGlobal_MorningLand_Boss_All:openBossListMorning1()")
      Panel_Window_MorningLand_Boss_All:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "PaGlobal_MorningLand_Boss_All:openBossListMorning2()")
    end
  end
  self._ui.btn_closePC:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All_Close()")
  self._ui.btn_attributeManage:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:toggleAttributeManager()")
  self._ui.btn_attributeViewReset:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:clearElementPoint(true)")
  self._ui.btn_attributeClose:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:toggleAttributeManager()")
  self._ui.btn_conquestHistory:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_ConquestHistory_All_Open()")
  self._ui.btn_conquestHistory:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.history .. ", true)")
  self._ui.btn_conquestHistory:addInputEvent("Mouse_Out", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.history .. ", false)")
  self._ui.txt_bossWeeknessTitle:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.week .. ", true)")
  self._ui.txt_bossWeeknessTitle:addInputEvent("Mouse_Out", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.week .. ", false)")
  self._ui.btn_attributeManage:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.statManage .. ", true)")
  self._ui.btn_attributeManage:addInputEvent("Mouse_Out", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.statManage .. ", false)")
  self._ui.btn_rankingView:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.rank .. ", true)")
  self._ui.btn_rankingView:addInputEvent("Mouse_Out", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.rank .. ", false)")
  self._ui.btn_MyReward:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.reward .. ", true)")
  self._ui.btn_MyReward:addInputEvent("Mouse_Out", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.reward .. ", false)")
  self._ui.btn_attribute0:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.sunDetail .. ", true)")
  self._ui.btn_attribute0:addInputEvent("Mouse_Out", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.sunDetail .. ", false)")
  self._ui.btn_attribute1:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.moonDetail .. ", true)")
  self._ui.btn_attribute1:addInputEvent("Mouse_Out", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.moonDetail .. ", false)")
  self._ui.btn_attribute2:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.landDetail .. ", true)")
  self._ui.btn_attribute2:addInputEvent("Mouse_Out", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.landDetail .. ", false)")
  self._ui.stc_attributePointBox:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.lightDetail .. ", true)")
  self._ui.stc_attributePointBox:addInputEvent("Mouse_Out", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.lightDetail .. ", false)")
  self._ui.stc_attributeViewPointBox:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.light .. ", true)")
  self._ui.stc_attributeViewPointBox:addInputEvent("Mouse_Out", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.light .. ", false)")
  self._ui.stc_myStatPointBox:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.addPoint .. ", true)")
  self._ui.stc_myStatPointBox:addInputEvent("Mouse_Out", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.addPoint .. ", false)")
  self._ui.btn_conquestHistory:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_ConquestHistory_All_Open()")
  self._ui.btn_attribute0:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:initSelectedElementalType(" .. __eElementalStat_Sun .. ")")
  self._ui.btn_attribute1:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:initSelectedElementalType(" .. __eElementalStat_Moon .. ")")
  self._ui.btn_attribute2:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:initSelectedElementalType(" .. __eElementalStat_Land .. ")")
  self._ui.btn_attackUp:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:useElementsPointToStat(" .. self._statType.Offence .. ")")
  self._ui.btn_deffenceUp:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:useElementsPointToStat(" .. self._statType.Deffence .. ")")
  self._ui.btn_attributeReset:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:clearElementPoint(true)")
  self._ui.btn_rankingViewMorning2:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.guildRank .. ", true)")
  self._ui.btn_rankingViewMorning2:addInputEvent("Mouse_Out", "PaGlobal_MorningLand_Boss_All:showTooltip(" .. self._descType.guildRank .. ", false)")
  if true == self._isConsole then
  end
  self._ui.btn_myStatReset:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:clearElementPoint(false)")
  self._ui.btn_conquestStart:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:conquestStart()")
  self._ui.btn_moveToWayPoint:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:setWayPoint()")
  self._ui.btn_conquestEnter:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:conquestStart()")
  self._ui.btn_conquestEnterParty:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:conquestPartyStart()")
  self._ui.btn_statApply:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:applyAllStat()")
  self._ui.btn_rankingView:addInputEvent("Mouse_LUp", "PaGlobalFunc_MorningBossRank_Open()")
  self._ui.btn_MyReward:addInputEvent("Mouse_LUp", "PaGlobalFunc_MorningMyReward_Open()")
  self._ui.btn_rankingViewMorning2:addInputEvent("Mouse_LUp", "PaGlobalFunc_MorningBossGuildRank_Open()")
  self._ui.rdo_MorningLandPart1:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:openBossListMorning1()")
  self._ui.rdo_MorningLandPart2:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:openBossListMorning2()")
  self._ui.list2_bossList:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_MorningLand_Boss_All_List2Update")
  self._ui.list2_bossList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list2_bossListMorning2:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_MorningLand_Boss_Part2_All_List2Update")
  self._ui.list2_bossListMorning2:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_loadElementalStatPoint", "FromClient_loadElementalStatPoint")
  registerEvent("FromClient_setElementalMonsterKey", "FromClient_setElementalMonsterKey")
  registerEvent("FromClient_setElementalMonsterRewardInfo", "FromClient_setElementalMonsterRewardInfo")
  registerEvent("FromClient_ElementalMonsterPersonalInfoLoaded", "FromClient_ElementalMonsterPersonalInfoLoaded")
  registerEvent("FromClient_Worldmap_MorningLandBossIcon_LClick", "FromClient_Worldmap_MorningLandBossIcon_LClick")
  registerEvent("FromClient_Worldmap_MorningLandBossIcon_MouseOn", "FromClient_Worldmap_MorningLandBossIcon_MouseOn")
  registerEvent("FromClient_Worldmap_MorningLandBossIcon_MouseOut", "FromClient_Worldmap_MorningLandBossIcon_MouseOut")
  registerEvent("FromClient_FinishMorningLandBossTeleportProgressBar", "FromClient_FinishMorningLandBossTeleportProgressBar")
  registerEvent("FromClient_BlackTempleFieldExplosionReady", "FromClient_BlackTempleFieldExplosionReady")
end
function PaGlobal_MorningLand_Boss_All:prepareOpen()
  if nil == Panel_Window_MorningLand_Boss_All then
    return
  end
  self:closeWorldMap()
  if _ContentsGroup_UsePadSnapping == true then
    self._tooltipInfo_Pad._index = nil
    self._tooltipInfo_Pad._monsterKeyRaw = nil
  end
  self._selectedBossGroup = 0
  self._selectedLevel = 0
  self._selectedMaxClearLevel = 0
  ToClient_ElementalBossRewardInfoReq()
  ToClient_requestElementalMonsterPersonalInfo()
end
function PaGlobal_MorningLand_Boss_All:open()
  if nil == Panel_Window_MorningLand_Boss_All then
    return
  end
  if self._isConsole == true then
    Panel_Window_MorningLand_Boss_All:ComputePos()
  end
  local monsterGroup, selectedDifficulty, ingMonsterKey
  if self._selectedBoss ~= nil and self._selectedBoss > 0 then
    local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(self._selectedBoss)
    if nil ~= morningBossSSW then
      self._selectedBossGroupIndex = morningBossSSW:getGroup()
      selectedDifficulty = morningBossSSW:getLevel()
    end
  else
    self._selectedBossGroupIndex = 0
    selectedDifficulty = 0
  end
  self._clearStatType = self._statConfirmType.Elemental
  self._ui.btn_statApply:SetMonoTone(true)
  self._ui.btn_attributeManage:EraseAllEffect()
  if 0 < ToClient_GetRemainElementPoint() then
    self._ui.btn_attributeManage:AddEffect("fUI_Ingame_Button_01A", true, 0, 0)
  end
  if self._isConsole == false then
    self._ui.btn_statApply:SetIgnore(true)
  end
  self._ui.stc_mainContentsLock:SetShow(false)
  local conquestCount = ""
  if self._ui.rdo_MorningLandPart1:IsCheck() == true then
    conquestCount = tostring(__eElementalMonsterWeekLimit - ToClient_RequestElementalPersonalInfoSize(__eMorningLandMosterPart1))
  elseif self._ui.rdo_MorningLandPart2:IsCheck() == true then
    local test = ToClient_RequestElementalPersonalInfoSize(2)
    conquestCount = tostring(__eElementalMonsterPart2WeekLimit - ToClient_RequestElementalPersonalInfoSize(__eMorningLandMosterPart2))
  end
  self._ui.txt_conqeustCount:SetText(conquestCount)
  self._ui.txt_conqeustCount:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:conqeustCountTooltip(true)")
  self._ui.txt_conqeustCount:addInputEvent("Mouse_Out", "PaGlobal_MorningLand_Boss_All:conqeustCountTooltip()")
  self._ui.txt_conqeustCountTitle:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:conqeustCountTooltip(true)")
  self._ui.txt_conqeustCountTitle:addInputEvent("Mouse_Out", "PaGlobal_MorningLand_Boss_All:conqeustCountTooltip()")
  self._ui.stc_keyGuide:SetShow(self._isConsole)
  if self._isConsole == true then
    if self._selectedBossGroupIndex < self._MORNINGLAND_PART1_BOSSCOUNT then
      self:alignKeyGuide(1)
    else
      self:alignKeyGuide(2)
    end
    self._ui.stc_keyGuide:SetPosY(Panel_Window_MorningLand_Boss_All:GetSizeY())
    local keyGuideSizeY = self._ui.stc_keyGuide:GetSizeY()
    if getScreenSizeY() <= Panel_Window_MorningLand_Boss_All:GetSizeY() + Panel_Window_MorningLand_Boss_All:GetPosY() + keyGuideSizeY then
      Panel_Window_MorningLand_Boss_All:SetScaleChild(0.9, 0.9)
      Panel_Window_MorningLand_Boss_All:SetPosY(Panel_Window_MorningLand_Boss_All:GetPosY() - keyGuideSizeY * 0.5)
      self._ui.btn_conquestEnter:SetPosY(self._ui.stc_difficulty:GetPosY() + self._ui.stc_difficulty:GetSizeY() + 70)
      self._ui.btn_conquestEnterParty:SetPosY(self._ui.stc_difficultyMorning2:GetPosY() + self._ui.stc_difficultyMorning2:GetSizeY() + 70)
      self._clearTimePosY = self._ui.stc_difficultyMorning2:GetPosY() + self._ui.stc_difficultyMorning2:GetSizeY() + 23
      self._ui.stc_keyGuide:SetSize(Panel_Window_MorningLand_Boss_All:GetSizeX(), self._ui.stc_keyGuide:GetSizeY())
      if self._selectedBossGroupIndex < self._MORNINGLAND_PART1_BOSSCOUNT then
        self:alignKeyGuide(1)
      else
        self:alignKeyGuide(2)
      end
      self._ui.stc_keyGuide:SetPosY(Panel_Window_MorningLand_Boss_All:GetSizeY() * 0.85)
    end
  end
  self._ui.list2_bossList:getElementManager():clearKey()
  for index = 1, #self._bossList do
    self._ui.list2_bossList:getElementManager():pushKey(index)
  end
  self._ui.list2_bossListMorning2:getElementManager():clearKey()
  for index = 1, #self._bossListMorning2 do
    self._ui.list2_bossListMorning2:getElementManager():pushKey(index)
  end
  if self._selectedBossGroupIndex < self._MORNINGLAND_PART1_BOSSCOUNT then
    self:openBossListMorning1()
    PaGlobal_MorningLand_Boss_All:selectBoss(self._selectedBossGroupIndex, selectedDifficulty)
  else
    self:openBossListMorning2()
    PaGlobal_MorningLand_Boss_All:selectBossMorning2(self._selectedBossGroupIndex, selectedDifficulty)
  end
  PaGlobal_MorningLand_Boss_All_UpdateRewardAble()
  PaGlobal_MorningLand_Boss_All:updateStatView()
  Panel_Window_MorningLand_Boss_All:SetShow(true)
end
function PaGlobal_MorningLand_Boss_All:prepareClose()
  if nil == Panel_Window_MorningLand_Boss_All then
    return
  end
  self._selectedBossGroup = 0
  self._selectedLevel = 0
  self._selectedMaxClearLevel = 0
  PaGlobalFunc_MorningBossRank_Close()
  PaGlobalFunc_MorningMyReward_Close()
  PaGlobal_MorningLand_ConquestHistory_All_Close()
  PaGlobalFunc_MorningLand_DetailReward_Close()
  Panel_Tooltip_Item_hideTooltip()
  self:reopenWorldMap()
  PaGlobal_MorningLand_Boss_All:close()
end
function PaGlobal_MorningLand_Boss_All:close()
  if nil == Panel_Window_MorningLand_Boss_All then
    return
  end
  Panel_Window_MorningLand_Boss_All:SetShow(false)
end
function PaGlobal_MorningLand_Boss_All:closeWorldMap()
  if Panel_Window_MorningLand_Boss_All == nil or Panel_Window_MorningLand_Boss_All:GetShow() == true then
    return
  end
  if self._isConsole == false then
    return
  end
  if WorldMapPopupManager == nil then
    return
  end
  if PaGlobalFunc_WorldMap_TopMenu_GetShow() == false and PaGlobalFunc_WorldMap_GetIsTownMode() == false then
    return
  end
  WorldMapPopupManager:increaseLayer(true)
  WorldMapPopupManager:push(Panel_Window_MorningLand_Boss_All, true)
  if PaGlobalFunc_WorldMap_SetIsTownMode ~= nil then
    PaGlobalFunc_WorldMap_SetIsTownMode(false)
  end
  if PaGlobalFunc_WorldMap_RingMenu_Close ~= nil then
    PaGlobalFunc_WorldMap_RingMenu_Close()
  end
  if PaGlobalFunc_WorldMap_BottomMenu_Close ~= nil then
    PaGlobalFunc_WorldMap_BottomMenu_Close()
  end
  if PaGlobalFunc_WorldMap_RightMenu_Close ~= nil then
    PaGlobalFunc_WorldMap_RightMenu_Close()
  end
  if PaGlobalFunc_WorldMap_TopMenu_Close ~= nil then
    PaGlobalFunc_WorldMap_TopMenu_Close()
  end
end
function PaGlobal_MorningLand_Boss_All:reopenWorldMap()
  if Panel_Window_MorningLand_Boss_All == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  if WorldMapPopupManager == nil then
    return
  end
  if self._isWorldMapOpen == false then
    return
  end
  self._isWorldMapOpen = false
  if PaGlobalFunc_ServantTransferList_All_GetShow == nil or PaGlobalFunc_ServantTransferList_All_CloseFromWorldmap == nil then
    return
  end
  if PaGlobalFunc_WorldMap_SetIsTownMode ~= nil then
    PaGlobalFunc_WorldMap_SetIsTownMode(false)
  end
  if PaGlobalFunc_WorldMap_RingMenu_Open ~= nil then
    PaGlobalFunc_WorldMap_RingMenu_Open()
  end
  if PaGlobalFunc_WorldMap_BottomMenu_Open ~= nil then
    PaGlobalFunc_WorldMap_BottomMenu_Open()
  end
  if PaGlobalFunc_WorldMap_TopMenu_Open ~= nil then
    PaGlobalFunc_WorldMap_TopMenu_Open()
  end
  if Panel_Window_MorningLand_Boss_All:GetShow() == true then
    WorldMapPopupManager:pop()
  end
end
function PaGlobal_MorningLand_Boss_All:toggleAttributeManager()
  PaGlobal_MorningLand_Boss_All:showTooltip(0, false)
  if self._ui.stc_mainArea:GetShow() == true then
    self._ui.stc_mainArea:SetShow(false)
    self._ui.stc_statManageArea:SetShow(true)
    self._ui.stc_statView:SetShow(true)
    self._ui.stc_statContents:SetShow(false)
    if self._isConsole == true then
      local statViewControl = self._statViewList[1]
      local attributeSetting = UI.getChildControl(statViewControl, "Button_StatManage")
      ToClient_padSnapChangeToTarget(attributeSetting)
    end
    PaGlobal_MorningLand_Boss_All:updateStatView()
  elseif self._ui.stc_statView:GetShow() == true then
    self._ui.stc_mainArea:SetShow(true)
    self._ui.stc_statManageArea:SetShow(false)
    self._ui.stc_statView:SetShow(false)
    self._ui.stc_statContents:SetShow(false)
  else
    self._ui.stc_mainArea:SetShow(false)
    self._ui.stc_statManageArea:SetShow(true)
    self._ui.stc_statView:SetShow(true)
    self._ui.stc_statContents:SetShow(false)
    PaGlobal_MorningLand_Boss_All:updateStatView()
  end
  PaGlobal_MorningLand_Boss_All:addInputEventForConsole(self._ui.stc_statContents:GetShow())
  PaGlobal_MorningLand_Boss_All:setPrincessBubbleText()
end
function PaGlobal_MorningLand_Boss_All:openAttributeManager(type)
  TooltipSimple_Hide()
  if self._ui.stc_statView:GetShow() == true then
    self._ui.stc_statView:SetShow(false)
    self._ui.stc_statContents:SetShow(true)
    PaGlobal_MorningLand_Boss_All:initSelectedElementalType(type)
  else
    self._ui.stc_statView:SetShow(true)
    self._ui.stc_statContents:SetShow(false)
    if self._isConsole == true then
      local statViewControl = self._statViewList[type]
      local attributeSetting = UI.getChildControl(statViewControl, "Button_StatManage")
      ToClient_padSnapChangeToTarget(attributeSetting)
    end
    PaGlobal_MorningLand_Boss_All:updateStatView()
  end
  PaGlobal_MorningLand_Boss_All:addInputEventForConsole(self._ui.stc_statContents:GetShow())
end
function PaGlobal_MorningLand_Boss_All:initSelectedElementalType(type)
  self._storedElementalStat[type][self._statType.Elemental] = 0
  self._storedElementalStat[type][self._statType.Offence] = 0
  self._storedElementalStat[type][self._statType.Deffence] = 0
  PaGlobal_MorningLand_Boss_All:selectedElementalType(type)
end
function PaGlobal_MorningLand_Boss_All:selectedElementalType(type)
  if self._selectedType ~= type then
    if type == __eElementalStat_Sun then
      audioPostEvent_SystemUi(34, 21)
    elseif type == __eElementalStat_Moon then
      audioPostEvent_SystemUi(34, 20)
    else
      audioPostEvent_SystemUi(34, 22)
    end
  end
  local stroredElementalPoint = self._storedElementalStat[type][self._statType.Elemental]
  local stroredOffencePoint = self._storedElementalStat[type][self._statType.Offence]
  local stroredDeffencePoint = self._storedElementalStat[type][self._statType.Deffence]
  self._selectedType = type
  self._ui.txt_effectDesc:SetText(PAGetString(Defines.StringSheet_GAME, self._attributeDetail[type]))
  local attributePoint = tostring(ToClient_GetRemainElementPoint() - stroredElementalPoint) .. " / " .. tostring(ToClient_GetMaxElementPoint())
  self._ui.txt_attributePoint:SetText(attributePoint)
  self._isAbleElementalReset = ToClient_GetRemainElementPoint() == ToClient_GetMaxElementPoint()
  if self._isConsle == false then
    self._ui.btn_attributeReset:SetMonoTone(self._isAbleElementalReset)
    self._ui.btn_attributeReset:SetIgnore(self._isAbleElementalReset)
  end
  self._effectChar = {
    [0] = "A",
    [1] = "B",
    [2] = "C"
  }
  for index = 1, #self._attributeList do
    local _btnAttribute = self._attributeList[index]
    if type + 1 == index then
      _btnAttribute:EraseAllEffect()
      _btnAttribute:AddEffect("fUI_Morning_BigButton_01" .. self._effectChar[type], true, 0, 0)
      _btnAttribute:SetMonoTone(false)
    else
      _btnAttribute:EraseAllEffect()
      _btnAttribute:SetMonoTone(true)
    end
  end
  local pointCountData = ToClient_GetElementVaryPontCount(type)
  local fixedPoint = 0
  local addedPoint = 0
  local offencePoint = 0
  local defencePoint = 0
  local calOffenceStat = 0
  local calDeffenceStat = 0
  local elementalPointStat = ToClient_GetElementPointStat(type)
  if elementalPointStat ~= nil then
    fixedPoint = elementalPointStat._fixedPoint
    addedPoint = elementalPointStat._addedPoint
    offencePoint = elementalPointStat._offencePoint
    defencePoint = elementalPointStat._defencePoint
    calOffenceStat = ToClient_GetCaculateOffenceStat(type)
    calDeffenceStat = ToClient_GetCaculateDffenceStat(type)
  end
  addedPoint = addedPoint + stroredElementalPoint
  offencePoint = offencePoint + stroredOffencePoint
  defencePoint = defencePoint + stroredDeffencePoint
  calOffenceStat = ToClient_GetTempCaculateOffenceStat(type, fixedPoint + addedPoint, offencePoint)
  calDeffenceStat = ToClient_GetTempCaculateDffenceStat(type, fixedPoint + addedPoint, defencePoint)
  self._isAbleStatReset = offencePoint + defencePoint - stroredOffencePoint - stroredDeffencePoint > 0
  if self._isConsle == false then
    self._ui.btn_myStatReset:SetMonoTone(not self._isAbleStatReset)
    self._ui.btn_myStatReset:SetIgnore(not self._isAbleStatReset)
  end
  self._ui.txt_myStatPoint:SetText((fixedPoint + addedPoint) * pointCountData - (offencePoint + defencePoint) .. " / " .. (fixedPoint + addedPoint) * pointCountData)
  if offencePoint == 0 then
    self._ui.txt_statAttack:SetText(calOffenceStat)
  else
    self._ui.txt_statAttack:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_ADDSTAT", "defaultstat", calOffenceStat, "addstat", offencePoint))
  end
  if defencePoint == 0 then
    self._ui.txt_statDeffence:SetText(calDeffenceStat)
  else
    self._ui.txt_statDeffence:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_ADDSTAT", "defaultstat", calDeffenceStat, "addstat", defencePoint))
  end
  if (fixedPoint + addedPoint) * pointCountData == offencePoint + defencePoint then
    self._ui.btn_attackUp:SetShow(false)
    self._ui.btn_deffenceUp:SetShow(false)
  else
    self._ui.btn_attackUp:SetShow(true)
    self._ui.btn_deffenceUp:SetShow(true)
  end
  local blackNormalIcon = "Combine_Etc_MorningLand_Boss_01_Icon_Bead_Black_Normal"
  local NormalIcon = "Combine_Etc_MorningLand_Boss_01_Icon_Bead_Black_Normal"
  for index = 1, self._elementStatMax do
    self._attributeEnergyList[index]._button:ChangeTextureInfoAndSizeByTextureIDKey(blackNormalIcon)
    self._attributeEnergyList[index]._button:setRenderTexture(self._attributeEnergyList[index]._button:getBaseTexture())
    self._attributeEnergyList[index]._button:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:useElementPointToElemental(" .. index .. ")")
    self._attributeEnergyList[index]._button:SetIgnore(true)
    self._attributeEnergyList[index]._button:EraseAllEffect()
  end
  if fixedPoint > 0 then
    local showFixedPoint = fixedPoint
    if showFixedPoint > self._elementStatMax then
      showFixedPoint = self._elementStatMax
    end
    for index = 1, showFixedPoint do
      self._attributeEnergyList[index]._button:ChangeTextureInfoAndSizeByTextureIDKey(self._attributeEnergyUV[type])
      self._attributeEnergyList[index]._button:setRenderTexture(self._attributeEnergyList[index]._button:getBaseTexture())
      self._attributeEnergyList[index]._button:SetIgnore(true)
      self._attributeEnergyList[index]._button:EraseAllEffect()
      self._attributeEnergyList[index]._button:AddEffect("fUI_Morning_EnergyButton_01" .. self._energyButtonEffectChar[type], true, 0, 0)
    end
  end
  if addedPoint > 0 then
    local showAddedPoint = fixedPoint + addedPoint
    if showAddedPoint > self._elementStatMax then
      showAddedPoint = self._elementStatMax
    end
    for index = fixedPoint + 1, showAddedPoint do
      self._attributeEnergyList[index]._button:ChangeTextureInfoAndSizeByTextureIDKey(self._zeroUV)
      self._attributeEnergyList[index]._button:setRenderTexture(self._attributeEnergyList[index]._button:getBaseTexture())
      self._attributeEnergyList[index]._button:SetIgnore(true)
      self._attributeEnergyList[index]._button:EraseAllEffect()
      if index == showAddedPoint and self._storedAddPoint ~= addedPoint and self._isAddEffect == true then
        self._attributeEnergyList[index]._button:AddEffect("fUI_Morning_EnergyButton_02A", true, 0, 0)
        audioPostEvent_SystemUi(34, 10)
        self._storedAddPoint = 0
        self._isAddEffect = false
      end
      self._attributeEnergyList[index]._button:AddEffect("fUI_Morning_EnergyButton_01A", true, 0, 0)
    end
  end
  local ablePoint = ToClient_GetRemainElementPoint() - stroredElementalPoint
  if ablePoint > 10 then
    ablePoint = 10
  end
  local energyCount = 0
  for index = fixedPoint + addedPoint + 1, self._elementStatMax do
    energyCount = energyCount + 1
    if ablePoint >= energyCount then
      self._attributeEnergyList[index]._button:ChangeTextureInfoAndSizeByTextureIDKey("Combine_Etc_MorningLand_Boss_01_Icon_Bead_Black_Plus_Normal")
      self._attributeEnergyList[index]._button:setRenderTexture(self._attributeEnergyList[index]._button:getBaseTexture())
      self._attributeEnergyList[index]._button:SetIgnore(false)
      self._attributeEnergyList[index]._isAble = true
    end
  end
  if stroredElementalPoint > 0 or stroredOffencePoint > 0 or stroredDeffencePoint > 0 then
    self._ui.btn_statApply:SetMonoTone(false)
    self._ui.btn_statApply:SetIgnore(false)
  else
    self._ui.btn_statApply:SetMonoTone(true)
    if self._isConsole == false then
      self._ui.btn_statApply:SetIgnore(true)
    end
  end
end
function PaGlobal_MorningLand_Boss_All:useElementPointToElemental(val)
  local elementalPointStat = ToClient_GetElementPointStat(self._selectedType)
  local fixedPoint = 0
  local addedPoint = 0
  if elementalPointStat ~= nil then
    fixedPoint = elementalPointStat._fixedPoint
    addedPoint = elementalPointStat._addedPoint
  end
  self._storedAddPoint = addedPoint
  self._isAddEffect = true
  local addVal = val - (fixedPoint + addedPoint)
  self._storedElementalStat[self._selectedType][self._statType.Elemental] = 0
  self._storedElementalStat[self._selectedType][self._statType.Elemental] = self._storedElementalStat[self._selectedType][self._statType.Elemental] + addVal
  local stroredElementalPoint = self._storedElementalStat[self._selectedType][self._statType.Elemental]
  FromClient_loadElementalStatPoint()
end
function PaGlobal_MorningLand_Boss_All:useElementsPointToStat(type)
  audioPostEvent_SystemUi(34, 11)
  local stroredElementalPoint = self._storedElementalStat[self._selectedType][self._statType.Elemental]
  local stroredOffencePoint = self._storedElementalStat[self._selectedType][self._statType.Offence]
  local stroredDeffencePoint = self._storedElementalStat[self._selectedType][self._statType.Deffence]
  local pointCountData = ToClient_GetElementVaryPontCount(self._selectedType)
  local fixedPoint = 0
  local addedPoint = 0
  local offencePoint = 0
  local defencePoint = 0
  local calOffenceStat = 0
  local calDeffenceStat = 0
  local elementalPointStat = ToClient_GetElementPointStat(self._selectedType)
  if elementalPointStat ~= nil then
    fixedPoint = elementalPointStat._fixedPoint
    addedPoint = elementalPointStat._addedPoint
    offencePoint = elementalPointStat._offencePoint
    defencePoint = elementalPointStat._defencePoint
    calOffenceStat = ToClient_GetCaculateOffenceStat(self._selectedType)
    calDeffenceStat = ToClient_GetCaculateDffenceStat(self._selectedType)
  end
  addedPoint = addedPoint + stroredElementalPoint
  offencePoint = offencePoint + stroredOffencePoint
  defencePoint = defencePoint + stroredDeffencePoint
  local remainStatPoint = (fixedPoint + addedPoint) * pointCountData - (offencePoint + defencePoint)
  if type == self._statType.Offence then
    local function ApplyStatPointOffence(inputNum)
      self._storedElementalStat[self._selectedType][self._statType.Offence] = self._storedElementalStat[self._selectedType][self._statType.Offence] + Int64toInt32(inputNum)
      self._ui.txt_statAttackTitle:EraseAllEffect()
      self._ui.txt_statAttackTitle:AddEffect("fUI_Morning_Upgrade_01A", false, 180, 0)
      FromClient_loadElementalStatPoint()
    end
    Panel_NumberPad_Show(true, toInt64(0, remainStatPoint), 0, ApplyStatPointOffence)
  else
    local function ApplyStatPointDeffence(inputNum)
      self._storedElementalStat[self._selectedType][self._statType.Deffence] = self._storedElementalStat[self._selectedType][self._statType.Deffence] + Int64toInt32(inputNum)
      self._ui.txt_statDefTitle:EraseAllEffect()
      self._ui.txt_statDefTitle:AddEffect("fUI_Morning_Upgrade_01A", false, 180, 0)
      FromClient_loadElementalStatPoint()
    end
    Panel_NumberPad_Show(true, toInt64(0, remainStatPoint), 0, ApplyStatPointDeffence)
  end
end
function PaGlobal_MorningLand_Boss_All:selectBoss(monsterGroup, level)
  self._ui.stc_statManageArea:SetShow(false)
  self._ui.stc_mainArea:SetShow(true)
  self._ui.txt_clearTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_CLEARTIME_NULL"))
  self._ui.txt_clearTimeRecord:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_CLEARTIME_NULL"))
  if ToClient_isElementalMonsterUnlockKnowledgeCondition(monsterGroup) == true then
    self._ui.stc_mainContentsLock:SetShow(false)
    self._ui.stc_mainContents:SetShow(true)
  else
    PaGlobal_MorningLand_Boss_All:lockMonsterSelect(monsterGroup)
    self._ui.stc_mainContentsLock:SetShow(true)
    self._ui.stc_mainContents:SetShow(false)
  end
  for index = 1, 10 do
    local difficulty = self._difficultyList[index]
    difficulty._select:SetShow(false)
    PaGlobal_MorningLand_Boss_All:changeTextureLevel(difficulty._talisman, index, self._levelUV.levelNormal)
  end
  local morningBossSSW = ToClient_getElementalMonsterInfo(monsterGroup, level)
  local maxClearLevel = 0
  if nil ~= morningBossSSW then
    local monsterKeyRaw = morningBossSSW:getCharacterKeyRaw()
    local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(monsterKeyRaw)
    local bossWeeknessUVString = self._frmBossWeeknessUV[morningBossSSW:getElementalStatType()]
    local bossMainUVString = self._bossMainUVStr[morningBossSSW:getGroup()]
    self._ui.txt_bossName:SetText(characterStaticStatusWarpper:getName())
    self._ui.txt_bossDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_DESC_" .. tostring(morningBossSSW:getGroup())))
    self._ui.txt_bossWeekness:ChangeTextureInfoAndSizeByTextureIDKey(bossWeeknessUVString)
    self._ui.txt_bossWeekness:setRenderTexture(self._ui.txt_bossWeekness:getBaseTexture())
    self._ui.txt_bossWeekness:SetText(PAGetString(Defines.StringSheet_GAME, self._attributeDesc[morningBossSSW:getElementalStatType()]))
    self._ui.stc_mainArea:ChangeTextureInfoNameAsync("/Combine/Etc/" .. bossMainUVString .. ".dds")
    self._ui.stc_mainArea:EraseAllEffect()
    self._ui.stc_mainArea:AddEffect("fUI_Morning_Boss_Aura_01" .. self._mainBossEffectChar[level + 1], true, 60, -90)
    for index = 1, 10 do
      local difficulty = self._difficultyList[index]
      local isClear = false
      local difficultyBossSSW = ToClient_getElementalMonsterInfo(monsterGroup, index - 1)
      local difficultyMonsterKeyRaw = 0
      if difficultyBossSSW ~= nil then
        difficultyMonsterKeyRaw = difficultyBossSSW:getCharacterKeyRaw()
        local historyInfo = ToClient_getElementalMonsterHistoryInfoByCharacterKey(difficultyMonsterKeyRaw)
        local personalInfo = ToClient_getElementalMonsterPersonalInfoByCharacterKey(difficultyMonsterKeyRaw)
        local characterNo = getSelfPlayer():getCharacterNo_64()
        if historyInfo ~= nil and historyInfo:getCharacterNo() == characterNo then
          isClear = true
          PaGlobal_MorningLand_Boss_All:changeTextureLevel(difficulty._talisman, index, self._levelUV.levelClear)
        else
          isClear = false
          PaGlobal_MorningLand_Boss_All:changeTextureLevel(difficulty._talisman, index, self._levelUV.levelNormal)
        end
        difficulty._isClear:SetShow(false)
        if personalInfo ~= nil and personalInfo._characterNo == characterNo then
          difficulty._isClear:SetShow(true)
          maxClearLevel = index
        end
        local unlockComplete = ToClient_GetElementalMonsterIsUnlockComplete(difficultyMonsterKeyRaw)
        local unlockAble = ToClient_GetElementalMonsterIsUnlockAble(difficultyMonsterKeyRaw)
        difficulty._button:SetShow(true)
        if unlockComplete or unlockAble then
          difficulty._button:addInputEvent("Mouse_On", "PaGlobal_MorningLand_Boss_All:difficultyOnOut(" .. index .. "," .. tostring(isClear) .. ", true)")
          difficulty._button:addInputEvent("Mouse_Out", "PaGlobal_MorningLand_Boss_All:difficultyOnOut(" .. index .. "," .. tostring(isClear) .. ", false)")
          difficulty._button:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:difficultySelect(" .. index .. "," .. difficultyMonsterKeyRaw .. ")")
          difficulty._button:SetMonoTone(false)
          difficulty._talisman:SetMonoTone(false)
        else
          difficulty._button:removeInputEvent("Mouse_On")
          difficulty._button:removeInputEvent("Mouse_Out")
          difficulty._button:removeInputEvent("Mouse_LUp")
          difficulty._button:EraseAllEffect()
          difficulty._button:SetMonoTone(true)
          difficulty._talisman:EraseAllEffect()
          difficulty._talisman:SetMonoTone(true)
        end
      else
        difficulty._button:SetShow(true)
        difficulty._button:removeInputEvent("Mouse_On")
        difficulty._button:removeInputEvent("Mouse_Out")
        difficulty._button:removeInputEvent("Mouse_LUp")
        difficulty._button:EraseAllEffect()
        difficulty._button:SetMonoTone(true)
        difficulty._talisman:EraseAllEffect()
        difficulty._talisman:SetMonoTone(true)
        PaGlobal_MorningLand_Boss_All:changeTextureLevel(difficulty._talisman, index, self._levelUV.levelNormal)
        difficulty._isClear:SetShow(false)
      end
    end
    local personalInfo = ToClient_getElementalMonsterPersonalInfoByCharacterKey(monsterKeyRaw)
    local historyInfo = ToClient_getElementalMonsterHistoryInfoByCharacterKey(monsterKeyRaw)
    local characterNo = getSelfPlayer():getCharacterNo_64()
    if personalInfo ~= nil and personalInfo._characterNo == characterNo then
      local minute = math.floor(Int64toInt32(personalInfo._recordTick) / 1000 / 60)
      local second = math.floor(Int64toInt32(personalInfo._recordTick) / 1000 % 60)
      local timeStr = string.format("%.02d", minute) .. ":" .. string.format("%.02d", second)
      self._ui.txt_clearTime:SetText(timeStr)
    end
    if historyInfo ~= nil and historyInfo:getCharacterNo() == characterNo then
      local minute = math.floor(Int64toInt32(historyInfo:getTickCount()) / 1000 / 60)
      local second = math.floor(Int64toInt32(historyInfo:getTickCount()) / 1000 % 60)
      local timeStr = string.format("%.02d", minute) .. ":" .. string.format("%.02d", second)
      self._ui.txt_clearTimeRecord:SetText(timeStr)
    end
    local selectedLevel = level
    local selectedMonsterKey = monsterKeyRaw
    local ingMonsterKey = self._selectedBoss
    if ingMonsterKey ~= nil and ingMonsterKey > 0 then
      local ingMorningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(ingMonsterKey)
      if nil ~= ingMorningBossSSW and ingMorningBossSSW:getGroup() == monsterGroup then
        selectedLevel = ingMorningBossSSW:getLevel()
        selectedMonsterKey = ingMonsterKey
      end
    end
    PaGlobal_MorningLand_Boss_All:difficultySelect(selectedLevel + 1, selectedMonsterKey)
    self._selectedLevel = selectedLevel
  end
  if PaGlobalFunc_MorningBossRank_SetSelectedBossGroupIndex ~= nil then
    PaGlobalFunc_MorningBossRank_SetSelectedBossGroupIndex(monsterGroup)
  end
  self._selectedBossGroup = monsterGroup
  self._selectedMaxClearLevel = maxClearLevel
  PaGlobal_MorningLand_Boss_All:setPrincessBubbleText()
end
function PaGlobal_MorningLand_Boss_All:selectBossMorning2(monsterGroup, level)
  self._ui.stc_statManageArea:SetShow(false)
  self._ui.stc_mainArea:SetShow(true)
  self._ui.txt_clearTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_CLEARTIME_NULL"))
  self._ui.txt_clearTimeRecord:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_CLEARTIME_NULL"))
  if ToClient_isElementalMonsterUnlockKnowledgeCondition(monsterGroup) == true then
    self._ui.stc_mainContentsLock:SetShow(false)
    self._ui.stc_mainContents:SetShow(true)
  else
    PaGlobal_MorningLand_Boss_All:lockMonsterSelect(monsterGroup)
    self._ui.stc_mainContentsLock:SetShow(true)
    self._ui.stc_mainContents:SetShow(false)
  end
  local morningBossSSW = ToClient_getElementalMonsterInfo(monsterGroup, level)
  local maxClearLevel = 0
  if nil ~= morningBossSSW then
    local monsterKeyRaw = morningBossSSW:getCharacterKeyRaw()
    local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(monsterKeyRaw)
    local bossMainUVString = self._bossMainUVStr[morningBossSSW:getGroup()]
    self._selectedBoss = monsterKeyRaw
    self._ui.stc_mainArea:ChangeTextureInfoNameAsync("/Combine/Etc/" .. bossMainUVString .. ".dds")
    self._ui.stc_mainArea:EraseAllEffect()
    self._ui.txt_bossName:SetText(characterStaticStatusWarpper:getName())
    self._ui.txt_bossDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_DESC_" .. tostring(morningBossSSW:getGroup())))
    local personalInfo = ToClient_getElementalMonsterPersonalInfoByCharacterKey(monsterKeyRaw)
    local historyInfo = ToClient_getElementalMonsterHistoryInfoByCharacterKey(monsterKeyRaw)
    local characterNo = getSelfPlayer():getCharacterNo_64()
    if personalInfo ~= nil and personalInfo._characterNo == characterNo then
      local minute = math.floor(Int64toInt32(personalInfo._recordTick) / 1000 / 60)
      local second = math.floor(Int64toInt32(personalInfo._recordTick) / 1000 % 60)
      local timeStr = string.format("%.02d", minute) .. ":" .. string.format("%.02d", second)
      self._ui.txt_clearTime:SetText(timeStr)
    end
    if historyInfo ~= nil and historyInfo:getCharacterNo() == characterNo then
      local minute = math.floor(Int64toInt32(historyInfo:getTickCount()) / 1000 / 60)
      local second = math.floor(Int64toInt32(historyInfo:getTickCount()) / 1000 % 60)
      local timeStr = string.format("%.02d", minute) .. ":" .. string.format("%.02d", second)
      self._ui.txt_clearTimeRecord:SetText(timeStr)
    end
    local isClear = false
    local difficultyBossSSW = ToClient_getElementalMonsterInfo(monsterGroup, 0)
    local difficultyMonsterKeyRaw = 0
    if difficultyBossSSW ~= nil then
      difficultyMonsterKeyRaw = difficultyBossSSW:getCharacterKeyRaw()
      local historyInfo = ToClient_getElementalMonsterHistoryInfoByCharacterKey(difficultyMonsterKeyRaw)
      local personalInfo = ToClient_getElementalMonsterPersonalInfoByCharacterKey(difficultyMonsterKeyRaw)
      self._ui.rdo_difficultyMorning2_Easy:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:difficultySelectMorning2(" .. 0 .. "," .. difficultyMonsterKeyRaw .. ")")
    end
    difficultyBossSSW = ToClient_getElementalMonsterInfo(monsterGroup, 1)
    difficultyMonsterKeyRaw = 0
    if difficultyBossSSW ~= nil then
      difficultyMonsterKeyRaw = difficultyBossSSW:getCharacterKeyRaw()
      local historyInfo = ToClient_getElementalMonsterHistoryInfoByCharacterKey(difficultyMonsterKeyRaw)
      local personalInfo = ToClient_getElementalMonsterPersonalInfoByCharacterKey(difficultyMonsterKeyRaw)
      self._ui.rdo_difficultyMorning2_Hard:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Boss_All:difficultySelectMorning2(" .. 1 .. "," .. difficultyMonsterKeyRaw .. ")")
    end
    local selectedLevel = 0
    local selectedMonsterKey = monsterKeyRaw
    PaGlobal_MorningLand_Boss_All:difficultySelectMorning2(selectedLevel, selectedMonsterKey)
    self._selectedLevel = selectedLevel
  end
  if PaGlobalFunc_MorningBossRank_SetSelectedBossGroupIndex ~= nil then
    PaGlobalFunc_MorningBossRank_SetSelectedBossGroupIndex(monsterGroup)
  end
  self._selectedBossGroup = monsterGroup
  self._selectedMaxClearLevel = maxClearLevel
  PaGlobal_MorningLand_Boss_All:setPrincessBubbleText()
end
function PaGlobal_MorningLand_Boss_All:difficultyOnOut(index, isClear, isOn)
  if self._difficultyList[index] == nil then
    return
  end
  local difficulty = self._difficultyList[index]
  if isOn == true then
    if isClear == true then
      PaGlobal_MorningLand_Boss_All:changeTextureLevel(difficulty._talisman, index, self._levelUV.levelClearOver)
    else
      PaGlobal_MorningLand_Boss_All:changeTextureLevel(difficulty._talisman, index, self._levelUV.levelNormalOver)
    end
    local control = difficulty._button
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_DIFFICULTY_" .. tostring(index - 1))
    local desc = ""
    local pos = {
      x = control:GetParentPosX() + control:GetSizeX(),
      y = control:GetParentPosY()
    }
    if self._isConsole == true then
      TooltipSimple_ShowSetSetPos_Console(pos, name, desc)
      local tooltipSizeX = Panel_Tooltip_SimpleText:GetSizeX()
      if getScreenSizeX() < pos.x + tooltipSizeX then
        TooltipSimple_Common_Pos(control:GetParentPosX() - tooltipSizeX, Panel_Tooltip_SimpleText:GetPosY())
      end
    else
      TooltipSimple_Show(control, name, desc)
    end
  else
    if isClear == true then
      PaGlobal_MorningLand_Boss_All:changeTextureLevel(difficulty._talisman, index, self._levelUV.levelClear)
    else
      PaGlobal_MorningLand_Boss_All:changeTextureLevel(difficulty._talisman, index, self._levelUV.levelNormal)
    end
    TooltipSimple_Hide()
  end
end
function PaGlobal_MorningLand_Boss_All:difficultySelect(index, monsterKeyRaw)
  local isShow = Panel_Window_MorningLand_Boss_All:GetShow()
  if isShow == true then
    audioPostEvent_SystemUi(34, 1)
  end
  self._ui.txt_clearTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_CLEARTIME_NULL"))
  self._ui.txt_clearTimeRecord:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_CLEARTIME_NULL"))
  for ii = 1, 10 do
    local difficulty = self._difficultyList[ii]
    if ii == index then
      self._selectedBoss = monsterKeyRaw
      self._lastSelectedBossGroupMorning1 = monsterKeyRaw
      local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(monsterKeyRaw)
      if nil ~= morningBossSSW then
        self._ui.stc_mainArea:EraseAllEffect()
        self._ui.stc_mainArea:AddEffect("fUI_Morning_Boss_Aura_01" .. self._mainBossEffectChar[morningBossSSW:getLevel() + 1], true, 60, -90)
        if morningBossSSW:getLevel() + 1 <= 5 then
          if isShow == true then
            audioPostEvent_SystemUi(34, 3)
          end
        elseif morningBossSSW:getLevel() + 1 <= 8 then
          if isShow == true then
            audioPostEvent_SystemUi(34, 4)
          end
        elseif isShow == true then
          audioPostEvent_SystemUi(34, 5)
        end
      end
      local bossMainUVString = self._bossMainUVStr[morningBossSSW:getGroup()]
      if index >= 8 then
        bossMainUVString = self._hardBossListUV[morningBossSSW:getGroup()]
        self._ui.txt_bossWeekness:SetShow(false)
        self._ui.txt_impossibleIcon:SetShow(true)
        self._ui.btn_attributeManage:SetShow(false)
        self._ui.btn_attributeDisable:SetShow(true)
      else
        self._ui.txt_bossWeekness:SetShow(true)
        self._ui.txt_impossibleIcon:SetShow(false)
        self._ui.btn_attributeManage:SetShow(true)
        self._ui.btn_attributeDisable:SetShow(false)
      end
      self._ui.stc_mainArea:ChangeTextureInfoNameAsync("/Combine/Etc/" .. bossMainUVString .. ".dds")
      local personalInfo = ToClient_getElementalMonsterPersonalInfoByCharacterKey(monsterKeyRaw)
      local historyInfo = ToClient_getElementalMonsterHistoryInfoByCharacterKey(monsterKeyRaw)
      local characterNo = getSelfPlayer():getCharacterNo_64()
      difficulty._isClear:SetShow(false)
      if personalInfo ~= nil and personalInfo._characterNo == characterNo then
        local minute = math.floor(Int64toInt32(personalInfo._recordTick) / 1000 / 60)
        local second = math.floor(Int64toInt32(personalInfo._recordTick) / 1000 % 60)
        local timeStr = string.format("%.02d", minute) .. ":" .. string.format("%.02d", second)
        self._ui.txt_clearTime:SetText(timeStr)
        difficulty._isClear:SetShow(true)
      end
      local clearSSW = ToClient_getElementalMonsterInfoByCharacterKey(monsterKeyRaw)
      if clearSSW ~= nil then
        local unlockSystemInfo = ToClient_GetUnlockSystemInfo(0, getSelfPlayer():getClassType(), clearSSW:getGroup(), clearSSW:getLevel())
        if unlockSystemInfo ~= nil then
        end
      end
      if historyInfo ~= nil and historyInfo:getCharacterNo() == characterNo then
        local minute = math.floor(Int64toInt32(historyInfo:getTickCount()) / 1000 / 60)
        local second = math.floor(Int64toInt32(historyInfo:getTickCount()) / 1000 % 60)
        local timeStr = string.format("%.02d", minute) .. ":" .. string.format("%.02d", second)
        self._ui.txt_clearTimeRecord:SetText(timeStr)
        difficulty._talisman:EraseAllEffect()
        difficulty._button:EraseAllEffect()
        local difficultyEffectChar = {
          [1] = "A",
          [2] = "A",
          [3] = "B",
          [4] = "A",
          [5] = "B",
          [6] = "A",
          [7] = "B",
          [8] = "C",
          [9] = "C",
          [10] = "C"
        }
        difficulty._talisman:AddEffect("fUI_Morning_CardBurn_02" .. difficultyEffectChar[index], true, 0, 0)
        difficulty._button:AddEffect("fUI_Morning_CardBurn_01A", true, 0, 0)
      else
        difficulty._talisman:EraseAllEffect()
        difficulty._button:EraseAllEffect()
        difficulty._button:AddEffect("fUI_Morning_CardBurn_01A", true, 0, 0)
      end
      if historyInfo ~= nil and historyInfo:getCharacterNo() == characterNo then
        self._ui.stc_clearTimeRecord:SetShow(true)
        self._ui.stc_clearTime:SetPosY(self._clearTimePosY)
      else
        self._ui.stc_clearTimeRecord:SetShow(false)
        self._ui.stc_clearTime:SetPosY(self._clearTimePosY - self._ui.stc_clearTime:GetSizeY() / 2)
      end
      local rewardCount = ToClient_getElementalMonsterShowRewardItemCount(monsterKeyRaw)
      for index = 1, rewardCount do
        local slot = self._listShowRewardSlots[index]
        local itemEnchantKeyRaw = ToClient_getElementalMonsterShowRewardItemKey(monsterKeyRaw, index - 1)
        local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKeyRaw))
        slot:setItemByStaticStatus(itemSSW, 1)
        slot._item = itemEnchantKeyRaw
        if _ContentsGroup_UsePadSnapping == false then
          slot.icon:addInputEvent("Mouse_On", "HandleEventLUp_MorningLand_Boss_Reward_Tooltip(" .. tostring(index) .. "," .. tostring(monsterKeyRaw) .. "," .. tostring(false) .. ")")
          slot.icon:addInputEvent("Mouse_Out", "HandleEventLUp_MorningLand_Boss_Reward_Tooltip(" .. tostring(index) .. "," .. tostring(monsterKeyRaw) .. "," .. tostring(true) .. ")")
        else
          self._tooltipInfo_Pad._index = index
          self._tooltipInfo_Pad._monsterKeyRaw = monsterKeyRaw
        end
        slot.icon:SetShow(true)
        self._rewardBtnList[index]:SetShow(true)
      end
      local unlockComplete = ToClient_GetElementalMonsterIsUnlockComplete(monsterKeyRaw)
      local unlockAble = ToClient_GetElementalMonsterIsUnlockAble(monsterKeyRaw)
      self._ui.btn_conquestEnter:SetMonoTone(false)
      self._ui.btn_conquestEnter:SetIgnore(false)
      if unlockComplete or unlockAble then
        self._ui.btn_conquestStart:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_BUTTON_0"))
        self._ui.btn_conquestStart:SetIgnore(false)
      else
        self._ui.btn_conquestStart:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_BUTTON_2"))
        self._ui.btn_conquestStart:SetIgnore(true)
      end
      local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(monsterKeyRaw)
      if nil ~= morningBossSSW then
        local attackValNew = ToClient_getAttackDisplayOffence(__eSkillTypeParam_Normal, false)
        local awakenAttackValNew = ToClient_getAttackDisplayOffence(__eSkillTypeParam_Awaken, false)
        self._ui.stc_limitAttackPoint:SetShow(false)
        self._ui.stc_liimtAPValue:SetShow(false)
        self._ui.stc_myAPValue:SetShow(false)
        if 0 < morningBossSSW:getMinAP() then
          local attackVal = 0
          if attackValNew <= awakenAttackValNew then
            attackVal = awakenAttackValNew
          else
            attackVal = attackValNew
          end
          self._ui.stc_liimtAPValue:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_MORNINGBOSS_LIMITAPVALUE", "value", morningBossSSW:getMinAP()))
          local myap = ""
          if attackValNew < morningBossSSW:getMinAP() and awakenAttackValNew < morningBossSSW:getMinAP() then
            myap = "<PAColor0xffd05d48>" .. attackVal .. "<PAOldColor>"
          else
            myap = "<PAColor0xfff5ba3a>" .. attackVal .. "<PAOldColor>"
          end
          self._ui.stc_myAPValue:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_MORNINGBOSS_MYAP", "value", myap))
          self._ui.stc_limitAttackPoint:SetShow(true)
          self._ui.stc_liimtAPValue:SetShow(true)
          self._ui.stc_myAPValue:SetShow(true)
        end
        if attackValNew < morningBossSSW:getMinAP() and awakenAttackValNew < morningBossSSW:getMinAP() then
          self._ui.btn_conquestEnter:SetMonoTone(true)
          self._ui.btn_conquestEnter:SetIgnore(true)
        end
      end
      if ToClient_GetSeletedElementalMonsterKey() == monsterKeyRaw then
        self._ui.btn_conquestStart:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_BUTTON_1"))
      end
      if _ContentsGroup_MorningLandTierGo == true then
        local enterTXTWidth = self._ui.txt_enter:GetTextSizeX() + 5
        self._ui.txt_enter:SetSpanSize(-(enterTXTWidth / 2), 0)
        if _ContentsGroup_MorningLandTierParty == true then
          enterTXTWidth = self._ui.txt_enterParty:GetTextSizeX() + 5
          self._ui.txt_enterParty:SetSpanSize(-(enterTXTWidth / 2), 0)
        end
      end
      local name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_DIFFICULTY_" .. tostring(index - 1))
      self._ui.txt_difficulty:SetText(name)
      self._ui.txt_difficulty:SetShow(true)
    else
      difficulty._talisman:EraseAllEffect()
      difficulty._button:EraseAllEffect()
      difficulty._select:SetShow(false)
    end
  end
  if PaGlobalFunc_MorningBossRank_SetSelectedLevel ~= nil then
    PaGlobalFunc_MorningBossRank_SetSelectedLevel(index - 1)
  end
  self._selectedLevel = index
  self:setPrincessBubbleText()
end
function PaGlobal_MorningLand_Boss_All:changeTextureLevel(control, index, type)
  if control == nil then
    return
  end
  if type == self._levelUV.levelNormal then
    type = "Normal"
  elseif type == self._levelUV.levelNormalOver then
    type = "Over"
  elseif type == self._levelUV.levelClear then
    type = "Clear"
  elseif type == self._levelUV.levelClearOver then
    type = "Clear_Over"
  end
  if type == nil then
    return
  end
  local IconString = tostring("Combine_Etc_MorningLand_Boss_01_Btn_Level_" .. tostring(index) .. "_" .. tostring(type))
  control:ChangeTextureInfoAndSizeByTextureIDKey(IconString)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_MorningLand_Boss_All:clearElementPoint(isAll)
  local resetCost = 0
  local morningLandManager = ToClient_getMorningLandOptionManager()
  if morningLandManager ~= nil then
    if isAll == true then
      resetCost = morningLandManager.getAllStatsResetCost
    else
      resetCost = morningLandManager.getStateResetCost
    end
  end
  local function doClearElementPoint()
    ToClient_ClearElementPoint(isAll, self._selectedType)
    self._storedElementalStat[self._selectedType][self._statType.Elemental] = 0
    self._storedElementalStat[self._selectedType][self._statType.Offence] = 0
    self._storedElementalStat[self._selectedType][self._statType.Deffence] = 0
  end
  local messageboxMemo = ""
  if isAll == true then
    messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_ATTROINT_RESET", "silver", makeDotMoney(resetCost))
  else
    messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_MYSTAT_RESET", "silver", makeDotMoney(resetCost))
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageboxMemo,
    functionApply = doClearElementPoint,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBoxCheck.showMessageBox(messageboxData)
end
function PaGlobal_MorningLand_Boss_All:conquestStart()
  if ToClient_IsAnySiegeBeingOfMyChannel() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantEnterDuringSiegeBeing"))
    return
  end
  local selfPlayer = getSelfPlayer():get()
  if selfPlayer == nil then
    return
  end
  if selfPlayer:isInGuildMansion() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRestrictContentsByRegion"))
    return
  end
  if selfPlayer:hasParty() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantWithParty"))
    return
  end
  if ToClient_IsEnterMirrorField() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantEnterInMirrorField"))
    return
  end
  if ToClient_GetSeletedElementalMonsterKey() == self._selectedBoss then
    ToClient_RequestClearElementalMonster()
    return
  end
  audioPostEvent_SystemUi(34, 31)
  local function doConquestStart()
    ToClient_RequestSetElementalMonster(self._selectedBoss)
  end
  local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(self._selectedBoss)
  if nil ~= morningBossSSW then
    local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(self._selectedBoss)
    local bossName = characterStaticStatusWarpper:getName()
    local difficulty = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_DIFFICULTY_" .. tostring(morningBossSSW:getLevel()))
    local messageboxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_START", "bossname", bossName, "difficulty", difficulty)
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = messageboxMemo,
      functionApply = doConquestStart,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    if _ContentsGroup_MorningLandTierGo == true then
      messageboxData.functionApply = PaGlobalFunc_MorningLand_Boss_CheckTeleportToMorningLandBoss
    end
    MessageBox.showMessageBox(messageboxData)
  end
end
function PaGlobal_MorningLand_Boss_All:conquestPartyStart()
  if _ContentsGroup_MorningLandTierParty == false then
    return
  end
  local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(self._selectedBoss)
  if morningBossSSW == nil then
    return
  end
  ToClient_InviteMorningLandBossParty(self._selectedBoss)
end
function PaGlobal_MorningLand_Boss_All:setWayPoint()
  if nil == PaGlobal_MorningLand_Boss_All then
    return
  end
  local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(self._selectedBoss)
  if nil ~= morningBossSSW then
    ToClient_DeleteNaviGuideByGroup(0)
    local posX = morningBossSSW:getPosition().x
    local posY = morningBossSSW:getPosition().y
    local posZ = morningBossSSW:getPosition().z
    worldmapNavigatorStart(float3(posX, posY, posZ), NavigationGuideParam(), false, false, false)
  end
end
function PaGlobal_MorningLand_Boss_All:updateStatView()
  local blackNormalIcon = "Combine_Etc_MorningLand_Boss_01_Icon_Bead_Black_Normal"
  for index = 1, #self._statViewList do
    local type = index - 1
    local myStatPointBox = UI.getChildControl(self._statViewList[index], "Static_MyStatPointBox")
    local myStatPoint = UI.getChildControl(myStatPointBox, "StaticText_MyStatPoint")
    local attackBox = UI.getChildControl(self._statViewList[index], "Static_Stat_AttackBox")
    local statAttack = UI.getChildControl(attackBox, "StaticText_Stat_Attack")
    local defenceBox = UI.getChildControl(self._statViewList[index], "Static_Stat_DefenceBox")
    local statDefence = UI.getChildControl(defenceBox, "StaticText_Stat_Defence")
    local pointCountData = ToClient_GetElementVaryPontCount(type)
    local fixedPoint = 0
    local addedPoint = 0
    local offencePoint = 0
    local defencePoint = 0
    local calOffenceStat = 0
    local calDeffenceStat = 0
    local elementalPointStat = ToClient_GetElementPointStat(type)
    if elementalPointStat ~= nil then
      fixedPoint = elementalPointStat._fixedPoint
      addedPoint = elementalPointStat._addedPoint
      offencePoint = elementalPointStat._offencePoint
      defencePoint = elementalPointStat._defencePoint
      calOffenceStat = ToClient_GetCaculateOffenceStat(type)
      calDeffenceStat = ToClient_GetCaculateDffenceStat(type)
    end
    myStatPoint:SetText((fixedPoint + addedPoint) * pointCountData - (offencePoint + defencePoint) .. " / " .. (fixedPoint + addedPoint) * pointCountData)
    if offencePoint == 0 then
      statAttack:SetText(calOffenceStat)
    else
      statAttack:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_ADDSTAT", "defaultstat", calOffenceStat, "addstat", offencePoint))
    end
    if defencePoint == 0 then
      statDefence:SetText(calDeffenceStat)
    else
      statDefence:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_ADDSTAT", "defaultstat", calDeffenceStat, "addstat", defencePoint))
    end
    for ii = 1, self._elementStatMax do
      self._attributeEnergyViewList[type][ii]:ChangeTextureInfoAndSizeByTextureIDKey(blackNormalIcon)
      self._attributeEnergyViewList[type][ii]:setRenderTexture(self._attributeEnergyViewList[type][ii]:getBaseTexture())
      self._attributeEnergyViewList[type][ii]:EraseAllEffect()
      self._attributeEnergyViewList[type][ii]:SetIgnore(true)
    end
    if fixedPoint > 0 then
      local showFixedPoint = fixedPoint
      if showFixedPoint > self._elementStatMax then
        showFixedPoint = self._elementStatMax
      end
      for ii = 1, showFixedPoint do
        self._attributeEnergyViewList[type][ii]:ChangeTextureInfoAndSizeByTextureIDKey(self._attributeEnergyUV[type])
        self._attributeEnergyViewList[type][ii]:setRenderTexture(self._attributeEnergyViewList[type][ii]:getBaseTexture())
        self._attributeEnergyViewList[type][ii]:SetIgnore(true)
        self._attributeEnergyViewList[type][ii]:EraseAllEffect()
        self._attributeEnergyViewList[type][ii]:AddEffect("fUI_Morning_EnergyButton_01" .. self._energyButtonEffectChar[type], true, 0, 0)
      end
    end
    if addedPoint > 0 then
      local showAddedPoint = fixedPoint + addedPoint
      if showAddedPoint > self._elementStatMax then
        showAddedPoint = self._elementStatMax
      end
      for ii = fixedPoint + 1, showAddedPoint do
        self._attributeEnergyViewList[type][ii]:ChangeTextureInfoAndSizeByTextureIDKey(self._zeroUV)
        self._attributeEnergyViewList[type][ii]:setRenderTexture(self._attributeEnergyViewList[type][ii]:getBaseTexture())
        self._attributeEnergyViewList[type][ii]:SetIgnore(true)
        self._attributeEnergyViewList[type][ii]:EraseAllEffect()
        self._attributeEnergyViewList[type][ii]:AddEffect("fUI_Morning_EnergyButton_01A", true, 0, 0)
      end
    end
  end
  local attributePoint = tostring(ToClient_GetRemainElementPoint()) .. " / " .. tostring(ToClient_GetMaxElementPoint())
  self._ui.txt_attributeViewPoint:SetText(attributePoint)
  self._isAbleElementalReset = ToClient_GetRemainElementPoint() == ToClient_GetMaxElementPoint()
  if self._isConsle == false then
    self._ui.btn_attributeViewReset:SetMonoTone(self._isAbleElementalReset)
    self._ui.btn_attributeViewReset:SetIgnore(self._isAbleElementalReset)
  end
  self._ui.btn_attributeManage:EraseAllEffect()
  if 0 < ToClient_GetRemainElementPoint() then
    self._ui.btn_attributeManage:AddEffect("fUI_Ingame_Button_01A", true, 0, 0)
  end
end
function PaGlobal_MorningLand_Boss_All:showTooltip(descType, isShow)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local targetControl
  if descType == self._descType.history then
    targetControl = self._ui.btn_conquestHistory
  elseif descType == self._descType.week then
    targetControl = self._ui.txt_bossWeeknessTitle
  elseif descType == self._descType.statManage then
    targetControl = self._ui.btn_attributeManage
  elseif descType == self._descType.rank then
    targetControl = self._ui.btn_rankingView
  elseif descType == self._descType.reward then
    targetControl = self._ui.btn_MyReward
  elseif descType == self._descType.sun then
    targetControl = self._statViewList[__eElementalStat_Sun + 1]
  elseif descType == self._descType.moon then
    targetControl = self._statViewList[__eElementalStat_Moon + 1]
  elseif descType == self._descType.land then
    targetControl = self._statViewList[__eElementalStat_Land + 1]
  elseif descType == self._descType.sunDetail then
    targetControl = self._ui.btn_attribute0
    descType = self._descType.sun
  elseif descType == self._descType.moonDetail then
    targetControl = self._ui.btn_attribute1
    descType = self._descType.moon
  elseif descType == self._descType.landDetail then
    targetControl = self._ui.btn_attribute2
    descType = self._descType.land
  elseif descType == self._descType.light then
    targetControl = self._ui.stc_attributeViewPointBox
    descType = self._descType.light
  elseif descType == self._descType.lightDetail then
    targetControl = self._ui.stc_attributePointBox
    descType = self._descType.light
  elseif descType == self._descType.addPoint then
    targetControl = self._ui.stc_myStatPointBox
  elseif descType == self._descType.guildRank then
    targetControl = self._ui.btn_rankingViewMorning2
  end
  if targetControl == nil then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_TOOLTIP_" .. tostring(descType))
  local desc = ""
  local pos = {
    x = targetControl:GetParentPosX() + targetControl:GetSizeX(),
    y = targetControl:GetParentPosY()
  }
  if self._isConsole == true then
    TooltipSimple_ShowSetSetPos_Console(pos, name, desc)
    local tooltipSizeX = Panel_Tooltip_SimpleText:GetSizeX()
    if getScreenSizeX() < pos.x + tooltipSizeX then
      TooltipSimple_Common_Pos(targetControl:GetParentPosX() - tooltipSizeX, Panel_Tooltip_SimpleText:GetPosY())
    end
  else
    TooltipSimple_Show(targetControl, name, desc, false)
  end
end
function PaGlobal_MorningLand_Boss_All:applyAllStat()
  self._clearStatType = self._statConfirmType.Elemental
  local statTypeName = PAGetString(Defines.StringSheet_GAME, self._attributeDesc[self._selectedType])
  local stroredElementalPoint = self._storedElementalStat[self._selectedType][self._statType.Elemental]
  local stroredOffencePoint = self._storedElementalStat[self._selectedType][self._statType.Offence]
  local stroredDeffencePoint = self._storedElementalStat[self._selectedType][self._statType.Deffence]
  if stroredElementalPoint == 0 and stroredOffencePoint == 0 and stroredDeffencePoint == 0 then
    return
  end
  local messageboxMemo = ""
  if stroredElementalPoint ~= 0 then
    if stroredOffencePoint ~= 0 or stroredDeffencePoint ~= 0 then
      self._clearStatType = self._statConfirmType.Both
      messageboxMemo = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_APPLY_2", "power", statTypeName, "count", stroredElementalPoint, "value", stroredOffencePoint, "value1", stroredDeffencePoint)
    else
      self._clearStatType = self._statConfirmType.Elemental
      messageboxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_APPLY_0", "power", statTypeName, "count", stroredElementalPoint)
    end
  elseif stroredOffencePoint ~= 0 or stroredDeffencePoint ~= 0 then
    self._clearStatType = self._statConfirmType.Stat
    messageboxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_APPLY_1", "value", stroredOffencePoint, "value1", stroredDeffencePoint)
  end
  local function doApplyStart()
    ToClient_UseElementPointToStat(self._selectedType, stroredElementalPoint, stroredOffencePoint, stroredDeffencePoint)
    self._storedElementalStat[self._selectedType][self._statType.Elemental] = 0
    self._storedElementalStat[self._selectedType][self._statType.Offence] = 0
    self._storedElementalStat[self._selectedType][self._statType.Deffence] = 0
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageboxMemo,
    functionApply = doApplyStart,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_MorningLand_Boss_All:lockMonsterSelect(group)
  if ToClient_isElementalMonsterUnlockKnowledgeCondition(group) == false then
    self._ui.stc_mainContentsLock:SetShow(true)
    self._ui.stc_mainContents:SetShow(false)
    local morningBossSSW = ToClient_getElementalMonsterInfo(group, 0)
    local mentalCardKey = morningBossSSW:getUnlockConditionMentalCardKeyRaw()
    local mentalCardSSW = ToClinet_getMentalCardStaticStatus(mentalCardKey)
    if mentalCardSSW ~= nil then
      local mentalCardName = mentalCardSSW:getName()
      local txtConditionLock = UI.getChildControl(self._ui.stc_mainContentsLock, "StaticText_Condition_Lock")
      txtConditionLock:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_LOCK", "knowledge", mentalCardName))
    end
    self._selectedBossGroup = group
    self:setPrincessBubbleText()
  end
end
function PaGlobal_MorningLand_Boss_All:addInputEventForConsole(isOn)
  if isOn == true then
    Panel_Window_MorningLand_Boss_All:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "PaGlobal_MorningLand_Boss_All:DpadDownEvent()")
    Panel_Window_MorningLand_Boss_All:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "PaGlobal_MorningLand_Boss_All:DpadUpEvent()")
  else
    Panel_Window_MorningLand_Boss_All:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "")
    Panel_Window_MorningLand_Boss_All:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "")
  end
end
function PaGlobal_MorningLand_Boss_All:DpadDownEvent()
  local currentControl = ToClient_getSnappedControl()
  if currentControl == nil then
    return
  end
  local targetTemp, resultTarget
  for ii = 1, #self._targetControlList do
    targetTemp = self._targetControlList[ii]
    if targetTemp:GetShow() == true and targetTemp:IsIgnore() == false and targetTemp ~= currentControl and currentControl:GetParentPosY() < targetTemp:GetParentPosY() then
      if resultTarget == nil then
        resultTarget = targetTemp
      else
        local prevDiffX = math.abs(currentControl:GetParentPosX() - resultTarget:GetParentPosX())
        local prevDiffY = math.abs(currentControl:GetParentPosY() - resultTarget:GetParentPosY())
        local curDiffX = math.abs(currentControl:GetParentPosX() - targetTemp:GetParentPosX())
        local curDiffY = math.abs(currentControl:GetParentPosY() - targetTemp:GetParentPosY())
        if prevDiffY > curDiffY and prevDiffX >= curDiffX then
          resultTarget = targetTemp
        end
      end
    end
  end
  if resultTarget ~= nil then
    ToClient_padSnapChangeToTarget(resultTarget)
  end
end
function PaGlobal_MorningLand_Boss_All:DpadUpEvent()
  local currentControl = ToClient_getSnappedControl()
  if currentControl == nil then
    return
  end
  local targetTemp, resultTarget
  for ii = 1, #self._targetControlList do
    targetTemp = self._targetControlList[ii]
    if targetTemp:GetShow() == true and targetTemp:IsIgnore() == false and targetTemp ~= currentControl and currentControl:GetParentPosY() > targetTemp:GetParentPosY() then
      if resultTarget == nil then
        resultTarget = targetTemp
      else
        local prevDiffX = math.abs(currentControl:GetParentPosX() - resultTarget:GetParentPosX())
        local prevDiffY = math.abs(currentControl:GetParentPosY() - resultTarget:GetParentPosY())
        local curDiffX = math.abs(currentControl:GetParentPosX() - targetTemp:GetParentPosX())
        local curDiffY = math.abs(currentControl:GetParentPosY() - targetTemp:GetParentPosY())
        if prevDiffY > curDiffY and prevDiffX >= curDiffX then
          resultTarget = targetTemp
        end
      end
    end
  end
  if resultTarget ~= nil then
    ToClient_padSnapChangeToTarget(resultTarget)
  end
end
function PaGlobal_MorningLand_Boss_All:setPrincessBubbleText()
  local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(self._lastSelectedBossGroupMorning1)
  local isOriginalEquip = false
  if morningBossSSW ~= nil and 0 < morningBossSSW:getMinAP() then
    isOriginalEquip = true
  end
  if _ContentsGroup_MorningLandTierGo == false or isOriginalEquip == true then
    self._ui.stc_txtBubble:SetShow(false)
    self._ui.stc_princessImage:SetShow(false)
    self._ui.txt_bubble:SetShow(false)
    return
  else
    self._ui.stc_txtBubble:SetShow(true)
    self._ui.stc_princessImage:SetShow(true)
    self._ui.txt_bubble:SetShow(true)
  end
  if self._ui.rdo_MorningLandPart1:IsCheck() == true then
    if ToClient_RequestElementalPersonalInfoSize(__eMorningLandMosterPart1) == __eElementalMonsterWeekLimit then
      self._ui.txt_bubble:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLAND_BOSSGUIDE_1"))
      return
    end
    if ToClient_isElementalMonsterUnlockKnowledgeCondition(self._selectedBossGroup) == false then
      self._ui.txt_bubble:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLAND_BOSSGUIDE_2"))
      return
    end
    if 0 < ToClient_GetRemainElementPoint() then
      self._ui.txt_bubble:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLAND_BOSSGUIDE_3"))
      return
    end
    if morningBossSSW ~= nil then
      local bossElementalType = morningBossSSW:getElementalStatType()
      local bossElementalTypePointStat = ToClient_GetElementPointStat(bossElementalType)
      if bossElementalTypePointStat ~= nil then
        local addedPoint = bossElementalTypePointStat._addedPoint
        local maxElementPoint = ToClient_GetMaxElementPoint()
        if addedPoint ~= maxElementPoint then
          self._ui.txt_bubble:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLAND_BOSSGUIDE_4"))
          return
        end
      end
    end
    if self._selectedMaxClearLevel > self._selectedLevel then
      self._ui.txt_bubble:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLAND_BOSSGUIDE_5"))
      return
    end
    if 0 < ToClient_ElementalBossRewardInfoCount() then
      self._ui.txt_bubble:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLAND_BOSSGUIDE_6"))
      return
    end
    self._ui.txt_bubble:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLAND_BOSSGUIDE_7"))
  elseif self._ui.rdo_MorningLandPart2:IsCheck() == true then
    if ToClient_RequestElementalPersonalInfoSize(__eMorningLandMosterPart2) == __eElementalMonsterPart2WeekLimit then
      self._ui.txt_bubble:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLAND2_BOSSGUIDE_1"))
      return
    end
    if 0 < ToClient_ElementalBossRewardInfoCount() then
      self._ui.txt_bubble:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLAND2_BOSSGUIDE_3"))
      return
    end
    self._ui.txt_bubble:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLAND2_BOSSGUIDE_4"))
  end
end
function PaGlobal_MorningLand_Boss_All:openBossListMorning1()
  self._ui.list2_bossList:SetShow(true)
  self._ui.stc_difficulty:SetShow(true)
  self:updateSideButtonPosition(self._sideBtnShowList)
  if self._ui.stc_statManageArea:GetShow() == true then
    self._ui.stc_statView:SetShow(true)
    self._ui.stc_statContents:SetShow(false)
  end
  self._ui.btn_conquestEnter:SetShow(_ContentsGroup_MorningLandTierGo == true)
  self._ui.btn_conquestEnterParty:SetShow(false)
  self._ui.stc_difficultyMorning2:SetShow(false)
  self._ui.list2_bossListMorning2:SetShow(false)
  self._ui.rdo_MorningLandPart1:SetCheck(true)
  self._ui.rdo_MorningLandPart2:SetCheck(false)
  self._ui.stc_selectBar:SetSpanSize(self._ui.rdo_MorningLandPart1:GetSpanSize().x, 0)
  if self._isConsole == true then
    Panel_Window_MorningLand_Boss_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "PaGlobal_MorningLand_Boss_All:toggleAttributeManager()")
    Panel_Window_MorningLand_Boss_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobalFunc_MorningBossRank_Open()")
    PaGlobal_MorningLand_Boss_All:alignKeyGuide(1)
  end
  self._ui.txt_bossWeeknessTitle:SetShow(true)
  self._ui.stc_bossWeeknessBg:SetShow(true)
  self._selectedBossGroupIndex = 0
  local selectedDifficulty = 0
  local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(self._lastSelectedBossGroupMorning1)
  if nil ~= morningBossSSW then
    self._selectedBossGroupIndex = morningBossSSW:getGroup()
    selectedDifficulty = morningBossSSW:getLevel()
  end
  local conquestCount = tostring(__eElementalMonsterWeekLimit - ToClient_RequestElementalPersonalInfoSize(__eMorningLandMosterPart1))
  self._ui.txt_conqeustCount:SetText(conquestCount)
  local noticeString = ""
  if ToClient_isXBox() == true or ToClient_isPS() == true then
    noticeString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING_ATTRBOSS_NOTICE_CS")
  else
    noticeString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING_ATTRBOSS_NOTICE")
  end
  self._ui.stc_noticeAreaText:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_noticeAreaText:SetText(noticeString)
  self._ui.stc_noticeArea:SetSize(self._ui.stc_noticeArea:GetSizeX(), self._ui.stc_noticeAreaText:GetTextSizeY() + 10)
  self._ui.stc_noticeAreaText:ComputePos()
  local panelSizeY = self._ui.stc_titleArea:GetSizeY() + self._ui.stc_tabArea:GetSizeY() + self._ui.stc_mainArea:GetSizeY() + self._ui.stc_noticeArea:GetSizeY() + 20
  Panel_Window_MorningLand_Boss_All:SetSize(Panel_Window_MorningLand_Boss_All:GetSizeX(), panelSizeY)
  self._ui.stc_keyGuide:SetPosY(Panel_Window_MorningLand_Boss_All:GetSizeY())
  PaGlobal_MorningLand_Boss_All:selectBoss(self._selectedBossGroupIndex, selectedDifficulty)
  TooltipSimple_Hide()
  if ToClient_isConsole() == true then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobal_MorningLand_Boss_All:openBossListMorning2()
  self._ui.stc_mainArea:SetShow(true)
  self._ui.list2_bossListMorning2:SetShow(true)
  self._ui.stc_difficultyMorning2:SetShow(true)
  self:updateSideButtonPosition(self._sideBtnShowListMorning2)
  self._ui.btn_conquestEnterParty:SetShow(_ContentsGroup_MorningLandTierParty == true)
  self._ui.stc_statManageArea:SetShow(false)
  self._ui.btn_conquestEnter:SetShow(false)
  self._ui.stc_difficulty:SetShow(false)
  self._ui.stc_statView:SetShow(false)
  self._ui.stc_statContents:SetShow(false)
  self._ui.list2_bossList:SetShow(false)
  self._ui.rdo_MorningLandPart2:SetCheck(true)
  self._ui.rdo_MorningLandPart1:SetCheck(false)
  self._ui.stc_selectBar:SetSpanSize(self._ui.rdo_MorningLandPart2:GetSpanSize().x, 0)
  self._ui.stc_limitAttackPoint:SetShow(false)
  self._ui.stc_liimtAPValue:SetShow(false)
  self._ui.stc_myAPValue:SetShow(false)
  if self._isConsole == true then
    Panel_Window_MorningLand_Boss_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "")
    Panel_Window_MorningLand_Boss_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobalFunc_MorningBossGuildRank_Open()")
    PaGlobal_MorningLand_Boss_All:alignKeyGuide(2)
  end
  self._ui.txt_bossWeeknessTitle:SetShow(false)
  self._ui.stc_bossWeeknessBg:SetShow(false)
  self._selectedBossGroupIndex = self._MORNINGLAND_PART1_BOSSCOUNT
  local selectedDifficulty = 0
  local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(self._lastSelectedBossGroupMorning2)
  if nil ~= morningBossSSW then
    self._selectedBossGroupIndex = morningBossSSW:getGroup()
    selectedDifficulty = morningBossSSW:getLevel()
  end
  local conquestCount = tostring(__eElementalMonsterPart2WeekLimit - ToClient_RequestElementalPersonalInfoSize(__eMorningLandMosterPart2))
  self._ui.txt_conqeustCount:SetText(conquestCount)
  local noticeString = ""
  if ToClient_isXBox() == true or ToClient_isPS() == true then
    noticeString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING2_ATTRBOSS_NOTICE_CS")
  else
    noticeString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING2_ATTRBOSS_NOTICE")
  end
  self._ui.stc_noticeAreaText:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_noticeAreaText:SetText(noticeString)
  self._ui.stc_noticeArea:SetSize(self._ui.stc_noticeArea:GetSizeX(), self._ui.stc_noticeAreaText:GetTextSizeY() + 10)
  self._ui.stc_noticeAreaText:ComputePos()
  local panelSizeY = self._ui.stc_titleArea:GetSizeY() + self._ui.stc_tabArea:GetSizeY() + self._ui.stc_mainArea:GetSizeY() + self._ui.stc_noticeArea:GetSizeY() + 20
  Panel_Window_MorningLand_Boss_All:SetSize(Panel_Window_MorningLand_Boss_All:GetSizeX(), panelSizeY)
  self._ui.stc_keyGuide:SetPosY(Panel_Window_MorningLand_Boss_All:GetSizeY())
  PaGlobal_MorningLand_Boss_All:selectBossMorning2(self._selectedBossGroupIndex, selectedDifficulty)
  TooltipSimple_Hide()
  if ToClient_isConsole() == true then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobal_MorningLand_Boss_All:difficultySelectMorning2(difficulty, monsterKeyRaw)
  local isShow = Panel_Window_MorningLand_Boss_All:GetShow()
  if isShow == true then
    audioPostEvent_SystemUi(34, 1)
  end
  self._ui.txt_clearTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_CLEARTIME_NULL"))
  self._ui.txt_clearTimeRecord:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_CLEARTIME_NULL"))
  self._selectedBoss = monsterKeyRaw
  self._lastSelectedBossGroupMorning2 = monsterKeyRaw
  local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(monsterKeyRaw)
  if nil ~= morningBossSSW then
    self._ui.stc_mainArea:EraseAllEffect()
    self._ui.stc_mainArea:AddEffect("fUI_Morning_Boss_Aura_01" .. self._mainBossEffectChar[morningBossSSW:getLevel() + 1], true, 60, -90)
    if morningBossSSW:getLevel() + 1 <= 5 then
      if isShow == true then
        audioPostEvent_SystemUi(34, 3)
      end
    elseif morningBossSSW:getLevel() + 1 <= 8 then
      if isShow == true then
        audioPostEvent_SystemUi(34, 4)
      end
    elseif isShow == true then
      audioPostEvent_SystemUi(34, 5)
    end
  end
  local personalInfo = ToClient_getElementalMonsterPersonalInfoByCharacterKey(monsterKeyRaw)
  local characterNo = getSelfPlayer():getCharacterNo_64()
  if personalInfo ~= nil and personalInfo._characterNo == characterNo then
    local minute = math.floor(Int64toInt32(personalInfo._recordTick) / 1000 / 60)
    local second = math.floor(Int64toInt32(personalInfo._recordTick) / 1000 % 60)
    local timeStr = string.format("%.02d", minute) .. ":" .. string.format("%.02d", second)
    self._ui.txt_clearTime:SetText(timeStr)
  end
  local historyInfo = ToClient_getElementalMonsterHistoryInfoByCharacterKey(monsterKeyRaw)
  if historyInfo ~= nil and historyInfo:getCharacterNo() == characterNo then
    local minute = math.floor(Int64toInt32(historyInfo:getTickCount()) / 1000 / 60)
    local second = math.floor(Int64toInt32(historyInfo:getTickCount()) / 1000 % 60)
    local timeStr = string.format("%.02d", minute) .. ":" .. string.format("%.02d", second)
    self._ui.txt_clearTimeRecord:SetText(timeStr)
    self._ui.stc_clearTimeRecord:SetShow(true)
    self._ui.stc_clearTime:SetPosY(self._clearTimePosY)
  else
    self._ui.stc_clearTimeRecord:SetShow(false)
    self._ui.stc_clearTime:SetPosY(self._clearTimePosY - self._ui.stc_clearTime:GetSizeY() / 2)
  end
  local rewardCount = ToClient_getElementalMonsterShowRewardItemCount(monsterKeyRaw)
  for index = 1, rewardCount do
    local slot = self._listShowRewardSlots[index]
    local itemEnchantKeyRaw = ToClient_getElementalMonsterShowRewardItemKey(monsterKeyRaw, index - 1)
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKeyRaw))
    slot:setItemByStaticStatus(itemSSW, 1)
    slot._item = itemEnchantKeyRaw
    if _ContentsGroup_UsePadSnapping == false then
      slot.icon:addInputEvent("Mouse_On", "HandleEventLUp_MorningLand_Boss_Reward_Tooltip(" .. tostring(index) .. "," .. tostring(monsterKeyRaw) .. "," .. tostring(false) .. ")")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventLUp_MorningLand_Boss_Reward_Tooltip(" .. tostring(index) .. "," .. tostring(monsterKeyRaw) .. "," .. tostring(true) .. ")")
    else
      self._tooltipInfo_Pad._index = index
      self._tooltipInfo_Pad._monsterKeyRaw = monsterKeyRaw
    end
    slot.icon:SetShow(true)
    self._rewardBtnList[index]:SetShow(true)
  end
  if difficulty == 0 then
    self._ui.rdo_difficultyMorning2_Easy:SetCheck(true)
    self._ui.rdo_difficultyMorning2_Easy:SetAlpha(1)
    self._ui.rdo_difficultyMorning2_Hard:SetCheck(false)
    self._ui.rdo_difficultyMorning2_Hard:SetAlpha(0.7)
  elseif difficulty == 1 then
    self._ui.rdo_difficultyMorning2_Hard:SetCheck(true)
    self._ui.rdo_difficultyMorning2_Hard:SetAlpha(1)
    self._ui.rdo_difficultyMorning2_Easy:SetCheck(false)
    self._ui.rdo_difficultyMorning2_Easy:SetAlpha(0.7)
  end
  if PaGlobalFunc_MorningBossRank_SetSelectedLevel ~= nil then
    PaGlobalFunc_MorningBossRank_SetSelectedLevel(difficulty)
  end
end
function PaGlobal_MorningLand_Boss_All:updateSideButtonPosition(showButtonList)
  for index = 1, #self._sideBtnList do
    if self._sideBtnList[index] ~= nil then
      self._sideBtnList[index]:SetShow(false)
    end
  end
  local showButtonCount = 0
  local DEFAULT_PAN_SIZE = 130
  for index = 1, #showButtonList do
    local buttonIndex = showButtonList[index]
    if self._sideBtnList[buttonIndex] ~= nil then
      self._sideBtnList[buttonIndex]:SetShow(true)
      self._sideBtnList[buttonIndex]:SetSpanSize(0, DEFAULT_PAN_SIZE * showButtonCount)
      showButtonCount = showButtonCount + 1
    end
  end
end
function PaGlobal_MorningLand_Boss_All:alignKeyGuide(index)
  if index == 1 then
    local keyGuideList = Array.new()
    self._ui.stc_key_LT_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING_ATTRBOSS_RANKING"))
    keyGuideList:push_back(self._ui.stc_key_B)
    keyGuideList:push_back(self._ui.stc_key_A)
    keyGuideList:push_back(self._ui.stc_key_X)
    keyGuideList:push_back(self._ui.stc_key_Y)
    keyGuideList:push_back(self._ui.stc_key_LT_A)
    keyGuideList:push_back(self._ui.stc_key_LT_X)
    keyGuideList:push_back(self._ui.stc_key_LT_Y)
    if _ContentsGroup_MorningLandTierParty == true then
      keyGuideList:push_back(self._ui.stc_key_LB)
      keyGuideList:push_back(self._ui.stc_key_RB)
    else
      self._ui.stc_key_RB:SetShow(false)
      self._ui.stc_key_LB:SetShow(false)
    end
    self._ui.stc_key_LT_Y:SetShow(true)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui.stc_keyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
    local keyGuideList = Array.new()
    self._ui.stc_key_LT_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_RANK_TITLE"))
    keyGuideList:push_back(self._ui.stc_key_B)
    keyGuideList:push_back(self._ui.stc_key_A)
    keyGuideList:push_back(self._ui.stc_key_X)
    keyGuideList:push_back(self._ui.stc_key_Y)
    keyGuideList:push_back(self._ui.stc_key_LT_A)
    keyGuideList:push_back(self._ui.stc_key_LT_X)
    if _ContentsGroup_MorningLandTierParty == true then
      keyGuideList:push_back(self._ui.stc_key_LB)
      keyGuideList:push_back(self._ui.stc_key_RB)
    else
      self._ui.stc_key_RB:SetShow(false)
      self._ui.stc_key_LB:SetShow(false)
    end
    self._ui.stc_key_LT_Y:SetShow(false)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui.stc_keyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_MorningLand_Boss_All:conqeustCountTooltip(isShow, index)
  if isShow == nil then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if self._ui.rdo_MorningLandPart1:IsCheck() == true then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLANDBOSS_HUNT_MAX_COUNT_TITLE")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNINGLANDBOSS_HUNT_MAX_COUNT_SINGLE_TOOLTIP", "param1", tostring(__eElementalMonsterWeekLimit))
  elseif self._ui.rdo_MorningLandPart2:IsCheck() == true then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLANDBOSS_HUNT_MAX_COUNT_TITLE")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNINGLANDBOSS_HUNT_MAX_COUNT_PARTY_TOOLTIP", "param1", tostring(__eElementalMonsterPart2WeekLimit))
  end
  control = self._ui.txt_conqeustCount
  TooltipSimple_Show(control, name, desc)
end
