local QuestRewardItem_LogManager = {
  _init = false,
  _panel = Panel_Widget_QuestRewardItem,
  _config = {_maxShowingLogSize = 17},
  _ui = {
    stc_controlBg,
    stc_icon,
    txt_name,
    stc_itemBg = {},
    stc_itemIcon = {},
    txt_itemName = {}
  },
  _rewardLogs = {},
  _totalCount = 0,
  _remainTime = 3.2,
  _termTime = 0.2,
  _updateTime = 0,
  _aniIndex = 0,
  _aniTime = 0.3
}
function QuestRewardItem_LogManager:init()
  self._ui.stc_controlBg = UI.getChildControl(Panel_Widget_QuestRewardItem, "Static_Bg")
  self._ui.stc_icon = UI.getChildControl(self._ui.stc_controlBg, "Static_IconBg")
  self._ui.txt_name = UI.getChildControl(self._ui.stc_controlBg, "StaticText_ItemLog")
  self._ui.stc_controlBg:SetShow(false)
  self._ui.stc_icon:SetShow(false)
  self._ui.txt_name:SetShow(false)
  for index = 0, self._config._maxShowingLogSize - 1 do
    self._ui.stc_itemBg[index] = UI.cloneControl(self._ui.stc_controlBg, Panel_Widget_QuestRewardItem, "_itemBg_" .. index)
    self._ui.stc_itemBg[index]:SetPosY(self._ui.stc_itemBg[index]:GetSizeY() * index * -1)
    self._ui.stc_itemIcon[index] = UI.cloneControl(self._ui.stc_icon, self._ui.stc_itemBg[index], "_itemIcon_" .. index)
    self._ui.txt_itemName[index] = UI.cloneControl(self._ui.txt_name, self._ui.stc_itemBg[index], "_itemName_" .. index)
    self._ui.stc_itemBg[index]:SetShow(false)
    self._ui.stc_itemIcon[index]:SetShow(true)
    self._ui.txt_itemName[index]:SetShow(true)
  end
end
function QuestRewardItem_LogManager_Init()
  QuestRewardItem_LogManager:init()
end
function PaGlobalFunc_RewardItemLogPerFrameUpdate(deltaTime)
  local self = QuestRewardItem_LogManager
  self._updateTime = self._updateTime + deltaTime
  if self._remainTime < self._updateTime then
    if self._aniIndex < self._totalCount then
      if self._remainTime + self._aniIndex * self._termTime < self._updateTime then
        QuestRewardItem_LogManager:SetHideAni(self._aniIndex)
        self._aniIndex = self._aniIndex + 1
      end
    else
      QuestRewardItem_LogManager:clear()
    end
  end
end
function PaGlobalFunc_QuestRewardItemLogManager_Clear()
  local self = QuestRewardItem_LogManager
  if self == nil then
    return
  end
  QuestRewardItem_LogManager:clear()
end
function QuestRewardItem_LogManager:clear()
  Panel_Widget_QuestRewardItem:SetShow(false)
  Panel_Widget_QuestRewardItem:ClearUpdateLuaFunc()
  self._updateTime = 0
  self._aniIndex = 0
  self._totalCount = 0
  for index = 0, self._config._maxShowingLogSize - 1 do
    self._ui.stc_itemBg[index]:SetShow(false)
  end
end
function QuestRewardItem_LogManager:setData(totalCount)
  self:clear()
  for index = 0, totalCount - 1 do
    self._ui.stc_itemBg[index]:SetColor(Defines.Color.C_00FFFFFF)
    self._ui.stc_itemIcon[index]:SetColor(Defines.Color.C_00FFFFFF)
    self._ui.txt_itemName[index]:SetColor(Defines.Color.C_00FFFFFF)
    self._ui.stc_itemBg[index]:ChangeTextureInfoNameAsync("renewal/frame/console_frame_00.dds")
    local grade = self._rewardLogs[index]._grade
    if 4 == grade then
      local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_itemBg[index], 1, 407, 305, 413)
      self._ui.stc_itemBg[index]:getBaseTexture():setUV(x1, y1, x2, y2)
    elseif 3 == grade then
      local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_itemBg[index], 1, 414, 305, 420)
      self._ui.stc_itemBg[index]:getBaseTexture():setUV(x1, y1, x2, y2)
    elseif 2 == grade then
      local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_itemBg[index], 1, 421, 305, 427)
      self._ui.stc_itemBg[index]:getBaseTexture():setUV(x1, y1, x2, y2)
    elseif 1 == grade then
      local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_itemBg[index], 1, 428, 305, 434)
      self._ui.stc_itemBg[index]:getBaseTexture():setUV(x1, y1, x2, y2)
    else
      local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_itemBg[index], 1, 435, 305, 441)
      self._ui.stc_itemBg[index]:getBaseTexture():setUV(x1, y1, x2, y2)
    end
    self._ui.stc_itemBg[index]:setRenderTexture(self._ui.stc_itemBg[index]:getBaseTexture())
    if nil ~= self._rewardLogs[index]._count and 1 < self._rewardLogs[index]._count then
      self._ui.txt_itemName[index]:SetText(self._rewardLogs[index]._itemName .. " x " .. tostring(self._rewardLogs[index]._count))
    else
      self._ui.txt_itemName[index]:SetText(self._rewardLogs[index]._itemName)
    end
    self._ui.stc_itemIcon[index]:ChangeTextureInfoNameAsync(self._rewardLogs[index]._iconPath)
    self._ui.stc_itemIcon[index]:setRenderTexture(self._ui.stc_itemIcon[index]:getBaseTexture())
    self:SetShowAni(index)
  end
  self._totalCount = totalCount
  Panel_Widget_QuestRewardItem:SetShow(true)
  Panel_Widget_QuestRewardItem:RegisterUpdateFunc("PaGlobalFunc_RewardItemLogPerFrameUpdate")
end
function QuestRewardItem_LogManager:SetShowAni(index)
  local control = self._ui.stc_itemBg[index]
  control:SetPosX(control:GetSizeX() * 2)
  control:SetShow(true)
  self._ui.stc_itemIcon[index]:SetShow(true)
  self._ui.txt_itemName[index]:SetShow(true)
  local aniInfo1 = control:addMoveAnimation(0 + index * self._aniTime, self._aniTime + index * self._aniTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartPosition(control:GetSizeX() * 2, control:GetPosY())
  aniInfo1:SetEndPosition(0, control:GetPosY())
  local aniInfo2 = control:addColorAnimation(0 + index * self._aniTime, self._aniTime + index * self._aniTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo2:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo2:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo2.IsChangeChild = true
end
function QuestRewardItem_LogManager:SetHideAni(index)
  local control = self._ui.stc_itemBg[index]
  local aniInfo = control:addColorAnimation(0, self._aniTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo.IsChangeChild = true
  aniInfo:SetHideAtEnd(true)
end
function PaGlobalFunc_QuestRewardItemLog(selectIndex)
  local dialogData = ToClient_GetCurrentDialogData()
  QuestRewardItem_LogManager._rewardLogs = {}
  local baseCount = dialogData:getBaseRewardCount()
  local totalCount = baseCount
  for index = 0, baseCount - 1 do
    QuestRewardItem_LogManager._rewardLogs[index] = {}
    local baseReward = dialogData:getBaseRewardAt(index)
    if __eRewardExp == baseReward._type then
      QuestRewardItem_LogManager._rewardLogs[index]._itemName = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_EXP")
      QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds"
      QuestRewardItem_LogManager._rewardLogs[index]._grade = 0
      QuestRewardItem_LogManager._rewardLogs[index]._count = 1
    elseif __eRewardSkillExp == baseReward._type then
      QuestRewardItem_LogManager._rewardLogs[index]._itemName = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_SKILLEXP")
      QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/SkillExp.dds"
      QuestRewardItem_LogManager._rewardLogs[index]._grade = 0
      QuestRewardItem_LogManager._rewardLogs[index]._count = 1
    elseif __eRewardLifeExp == baseReward._type then
      QuestRewardItem_LogManager._rewardLogs[index]._itemName = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_PRODUCTEXP")
      QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds"
      QuestRewardItem_LogManager._rewardLogs[index]._grade = 0
      QuestRewardItem_LogManager._rewardLogs[index]._count = 1
    elseif __eRewardExpGrade == baseReward._type then
      QuestRewardItem_LogManager._rewardLogs[index]._itemName = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_EXP_GRADE")
      QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/ExpGrade.dds"
      QuestRewardItem_LogManager._rewardLogs[index]._grade = 0
      QuestRewardItem_LogManager._rewardLogs[index]._count = 1
    elseif __eRewardSkillExpGrade == baseReward._type then
      QuestRewardItem_LogManager._rewardLogs[index]._itemName = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_SKILLEXP_GRADE")
      QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/SkillExpGrade.dds"
      QuestRewardItem_LogManager._rewardLogs[index]._grade = 0
      QuestRewardItem_LogManager._rewardLogs[index]._count = 1
    elseif __eRewardItem == baseReward._type then
      local baseRewardEnchantKey = baseReward:getItemEnchantKey()
      local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(baseRewardEnchantKey))
      QuestRewardItem_LogManager._rewardLogs[index]._itemName = itemSSW:getName()
      QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "icon/" .. itemSSW:getIconPath()
      QuestRewardItem_LogManager._rewardLogs[index]._grade = itemSSW:getGradeType()
      QuestRewardItem_LogManager._rewardLogs[index]._count = Int64toInt32(baseReward._itemCount)
    elseif __eRewardIntimacy == baseReward._type then
      local characterKey = baseReward:getIntimacyCharacter()
      local characterSSW = ToClient_GetCharacterStaticStatusWrapper(characterKey)
      local npcName = characterSSW:getName()
      local value = baseReward._intimacyValue
      QuestRewardItem_LogManager._rewardLogs[index]._itemName = npcName .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_INTIMACY") .. " " .. value
      QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/00000000_Special_Contributiveness.dds"
      QuestRewardItem_LogManager._rewardLogs[index]._grade = 4
      QuestRewardItem_LogManager._rewardLogs[index]._count = 1
    elseif __eRewardKnowledge == baseReward._type then
      local mentalCardKey = baseReward:getMentalCardKey()
      local mentalCardSSW = ToClinet_getMentalCardStaticStatus(mentalCardKey)
      local mentalCardName = mentalCardSSW:getName()
      QuestRewardItem_LogManager._rewardLogs[index]._itemName = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REWARDITEM_KNOWLEDGE", "mentalCardName", tostring(mentalCardName))
      QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/00000000_know_icon.dds"
      QuestRewardItem_LogManager._rewardLogs[index]._grade = 4
      QuestRewardItem_LogManager._rewardLogs[index]._count = 1
    elseif __eRewardSeasonReward == baseReward._type then
      QuestRewardItem_LogManager._rewardLogs[index]._itemName = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_COMPLETE_SEASON")
      QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/00750592.dds"
      QuestRewardItem_LogManager._rewardLogs[index]._grade = 4
      QuestRewardItem_LogManager._rewardLogs[index]._count = 1
    elseif __eRewardExploreExp == baseReward._type then
      local exploreExp = Int64toInt32(baseReward._exploreExp)
      QuestRewardItem_LogManager._rewardLogs[index]._itemName = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_QUESTREWARD_EXPLOREEXP", "exp", tostring(exploreExp))
      QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/Explore.dds"
      QuestRewardItem_LogManager._rewardLogs[index]._grade = 0
      QuestRewardItem_LogManager._rewardLogs[index]._count = 1
    elseif __eRewardFamilyStat == baseReward._type then
      local baseRewardWrapper = dialogData:getBaseRewardWrapperAt(index)
      local familyStatType = baseRewardWrapper:getFamilyStatType()
      local familyStatValue = PaGlobalFunc_GetRewardFamilyStatValue(baseRewardWrapper)
      QuestRewardItem_LogManager._rewardLogs[index]._itemName = PaGlobalFunc_GetFamiltyStatRewardToolipText_Desc(familyStatType, familyStatValue)
      QuestRewardItem_LogManager._rewardLogs[index]._iconPath = PaGlobalFunc_GetFamilyStatRewardIconName(familyStatType)
      QuestRewardItem_LogManager._rewardLogs[index]._grade = 4
      QuestRewardItem_LogManager._rewardLogs[index]._count = 1
    elseif __eRewardCharacterStat == baseReward._type then
      QuestRewardItem_LogManager._rewardLogs[index]._itemName = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_CHARACTERSTAT")
      QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/03_Quest_Item/familystat_001.dds"
      QuestRewardItem_LogManager._rewardLogs[index]._grade = 4
      QuestRewardItem_LogManager._rewardLogs[index]._count = 1
    elseif __eeRewardFeverPoint == baseReward._type then
      local maxFeverPoint = baseReward:getMaxFeverPoint()
      local addFeverPoint = baseReward:getAddFeverPoint()
      local feverDropRate = baseReward:getAddFeverDropRate()
      local str
      if maxFeverPoint > 0 then
        str = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ACHIEVEMENT_REWARD_TYPE_MAXFEVERPOINT", "maxFeverPoint", maxFeverPoint)
      elseif addFeverPoint > 0 then
        str = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ACHIEVEMENT_REWARD_TYPE_ADDFEVERPOINT", "addFeverPoint", addFeverPoint)
      elseif feverDropRate > 0 then
        feverDropRate = feverDropRate / 10000
        str = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ACHIEVEMENT_REWARD_TYPE_FEVERDROPRATE", "feverDropRate", feverDropRate)
      end
      QuestRewardItem_LogManager._rewardLogs[index]._itemName = str
      QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/03_Quest_Item/familystat_001.dds"
      QuestRewardItem_LogManager._rewardLogs[index]._grade = 4
      QuestRewardItem_LogManager._rewardLogs[index]._count = 1
    else
      totalCount = totalCount - 1
    end
  end
  if nil ~= selectIndex then
    local selectReward = dialogData:getSelectRewardAt(selectIndex)
    if nil ~= selectReward then
      local index = totalCount
      totalCount = totalCount + 1
      QuestRewardItem_LogManager._rewardLogs[index] = {}
      if __eRewardExp == selectReward._type then
        QuestRewardItem_LogManager._rewardLogs[index]._itemName = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_EXP")
        QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds"
        QuestRewardItem_LogManager._rewardLogs[index]._grade = 0
        QuestRewardItem_LogManager._rewardLogs[index]._count = 1
      elseif __eRewardSkillExp == selectReward._type then
        QuestRewardItem_LogManager._rewardLogs[index]._itemName = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_SKILLEXP")
        QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/SkillExp.dds"
        QuestRewardItem_LogManager._rewardLogs[index]._grade = 0
        QuestRewardItem_LogManager._rewardLogs[index]._count = 1
      elseif __eRewardLifeExp == selectReward._type then
        QuestRewardItem_LogManager._rewardLogs[index]._itemName = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_PRODUCTEXP")
        QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds"
        QuestRewardItem_LogManager._rewardLogs[index]._grade = 0
        QuestRewardItem_LogManager._rewardLogs[index]._count = 1
      elseif __eRewardExpGrade == selectReward._type then
        QuestRewardItem_LogManager._rewardLogs[index]._itemName = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_EXP_GRADE")
        QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/ExpGrade.dds"
        QuestRewardItem_LogManager._rewardLogs[index]._grade = 0
        QuestRewardItem_LogManager._rewardLogs[index]._count = 1
      elseif __eRewardSkillExpGrade == selectReward._type then
        QuestRewardItem_LogManager._rewardLogs[index]._itemName = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_SKILLEXP_GRADE")
        QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/SkillExpGrade.dds"
        QuestRewardItem_LogManager._rewardLogs[index]._grade = 0
        QuestRewardItem_LogManager._rewardLogs[index]._count = 1
      elseif __eRewardItem == selectReward._type then
        local selectRewardEnchantKey = selectReward:getItemEnchantKey()
        local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(selectRewardEnchantKey))
        QuestRewardItem_LogManager._rewardLogs[index]._itemName = itemSSW:getName()
        QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "icon/" .. itemSSW:getIconPath()
        QuestRewardItem_LogManager._rewardLogs[index]._grade = itemSSW:getGradeType()
        QuestRewardItem_LogManager._rewardLogs[index]._count = Int64toInt32(selectReward._itemCount)
      elseif __eRewardIntimacy == selectReward._type then
        local characterKey = selectReward:getIntimacyCharacter()
        local characterSSW = ToClient_GetCharacterStaticStatusWrapper(characterKey)
        local npcName = characterSSW:getName()
        local value = selectReward._intimacyValue
        QuestRewardItem_LogManager._rewardLogs[index]._itemName = npcName .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_INTIMACY") .. " " .. value
        QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/00000000_Special_Contributiveness.dds"
        QuestRewardItem_LogManager._rewardLogs[index]._grade = 4
        QuestRewardItem_LogManager._rewardLogs[index]._count = 1
      elseif __eRewardKnowledge == selectReward._type then
        local mentalCardKey = selectReward:getMentalCardKey()
        local mentalCardSSW = ToClinet_getMentalCardStaticStatus(mentalCardKey)
        local mentalCardName = mentalCardSSW:getName()
        QuestRewardItem_LogManager._rewardLogs[index]._itemName = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REWARDITEM_KNOWLEDGE", "mentalCardName", tostring(mentalCardName))
        QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/00000000_know_icon.dds"
        QuestRewardItem_LogManager._rewardLogs[index]._grade = 4
        QuestRewardItem_LogManager._rewardLogs[index]._count = 1
      elseif __eRewardSeasonReward == selectReward._type then
        QuestRewardItem_LogManager._rewardLogs[index]._itemName = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_COMPLETE_SEASON")
        QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/00750592.dds"
        QuestRewardItem_LogManager._rewardLogs[index]._grade = 4
        QuestRewardItem_LogManager._rewardLogs[index]._count = 1
      elseif __eRewardExploreExp == selectReward._type then
        local exploreExp = Int64toInt32(selectReward._exploreExp)
        QuestRewardItem_LogManager._rewardLogs[index]._itemName = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REWARDITEM_EXPLOREPOINT", "exploreExp", tostring(exploreExp))
        QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/Explore.dds"
        QuestRewardItem_LogManager._rewardLogs[index]._grade = 0
        QuestRewardItem_LogManager._rewardLogs[index]._count = 1
      elseif __eRewardFamilyStat == selectReward._type then
        local baseRewardWrapper = dialogData:getBaseRewardWrapperAt(index)
        local familyStatType = baseRewardWrapper:getFamilyStatType()
        local familyStatValue = PaGlobalFunc_GetRewardFamilyStatValue(baseRewardWrapper)
        QuestRewardItem_LogManager._rewardLogs[index]._itemName = PaGlobalFunc_GetFamiltyStatRewardToolipText_Desc(familyStatType, familyStatValue)
        QuestRewardItem_LogManager._rewardLogs[index]._iconPath = PaGlobalFunc_GetFamilyStatRewardIconName(familyStatType)
        QuestRewardItem_LogManager._rewardLogs[index]._grade = 4
        QuestRewardItem_LogManager._rewardLogs[index]._count = 1
      elseif __eRewardCharacterStat == selectReward._type then
        QuestRewardItem_LogManager._rewardLogs[index]._itemName = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_CHARACTERSTAT")
        QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/03_Quest_Item/familystat_001.dds"
        QuestRewardItem_LogManager._rewardLogs[index]._grade = 4
        QuestRewardItem_LogManager._rewardLogs[index]._count = 1
      elseif __eeRewardFeverPoint == selectReward._type then
        local maxFeverPoint = selectReward:getMaxFeverPoint()
        local addFeverPoint = selectReward:getAddFeverPoint()
        local feverDropRate = selectReward:getAddFeverDropRate()
        if maxFeverPoint > 0 then
          str = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ACHIEVEMENT_REWARD_TYPE_MAXFEVERPOINT", "maxFeverPoint", maxFeverPoint)
        elseif addFeverPoint > 0 then
          str = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ACHIEVEMENT_REWARD_TYPE_ADDFEVERPOINT", "addFeverPoint", addFeverPoint)
        elseif feverDropRate > 0 then
          feverDropRate = feverDropRate / 10000
          str = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ACHIEVEMENT_REWARD_TYPE_FEVERDROPRATE", "feverDropRate", feverDropRate)
        end
        QuestRewardItem_LogManager._rewardLogs[index]._itemName = str
        QuestRewardItem_LogManager._rewardLogs[index]._iconPath = "Icon/New_Icon/03_ETC/03_Quest_Item/familystat_001.dds"
        QuestRewardItem_LogManager._rewardLogs[index]._grade = 4
        QuestRewardItem_LogManager._rewardLogs[index]._count = 1
      else
        totalCount = totalCount - 1
      end
    end
  end
  QuestRewardItem_LogManager:setData(totalCount)
end
registerEvent("FromClient_luaLoadComplete", "QuestRewardItem_LogManager_Init")
