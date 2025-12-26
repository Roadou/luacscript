PaGlobal_MorningLand_ConquestHistory_All = {
  _ui = {
    txt_historyTitle = nil,
    btn_closePC = nil,
    txt_BossTitle = nil,
    list2_ConquestHistory = nil,
    stc_NoData = nil
  },
  _bossWeeknessUV = {
    [__eElementalStat_Sun] = "Combine_Etc_MorningLand_Boss_01_Icon_Quality_Sun",
    [__eElementalStat_Moon] = "Combine_Etc_MorningLand_Boss_01_Icon_Quality_Moon",
    [__eElementalStat_Land] = "Combine_Etc_MorningLand_Boss_01_Icon_Quality_Land"
  },
  _bossListUV = {
    [0] = "Combine_Etc_MorningLand_Boss_02_Record_Sun_Profile_01",
    [1] = "Combine_Etc_MorningLand_Boss_02_Record_Sun_Profile_02",
    [2] = "Combine_Etc_MorningLand_Boss_02_Record_Sun_Profile_03",
    [3] = "Combine_Etc_MorningLand_Boss_02_Record_Moon_Profile_01",
    [4] = "Combine_Etc_MorningLand_Boss_02_Record_Moon_Profile_02",
    [5] = "Combine_Etc_MorningLand_Boss_02_Record_Moon_Profile_03",
    [6] = "Combine_Etc_MorningLand_Boss_02_Record_Land_Profile_01",
    [7] = "Combine_Etc_MorningLand_Boss_02_Record_Land_Profile_02",
    [8] = "Combine_Etc_MorningLand_Boss_02_Record_Land_Profile_03",
    [9] = "Combine_Etc_MorningLand_Boss_02_Record_Land_Profile_04",
    [10] = "Combine_Etc_MorningLand_Boss_02_Record_Profile_01",
    [11] = "Combine_Etc_MorningLand_Boss_04_Record_Profile_09",
    [12] = "Combine_Etc_MorningLand_Boss_04_Record_Profile_03",
    [13] = "Combine_Etc_MorningLand_Boss_04_Record_Profile_10",
    [14] = "Combine_Etc_MorningLand_Boss_04_Record_Profile_06",
    [15] = "Combine_Etc_MorningLand_Boss_04_Record_Profile_08",
    [16] = "Combine_Etc_MorningLand_Boss_04_Record_Profile_07",
    [17] = "Combine_Etc_MorningLand_Boss_04_Record_Profile_11",
    [18] = "Combine_Etc_MorningLand_Boss_04_Record_Profile_05",
    [19] = "Combine_Etc_MorningLand_Boss_04_Record_Profile_04",
    [20] = "Combine_Etc_MorningLand_Boss_02_Record_Profile_02",
    [21] = "Combine_Etc_MorningLand_Boss_04_Record_Profile_12"
  },
  _rankingIcon = {
    [1] = "Combine_Etc_MorningLand_Boss_02_Ranking_1st",
    [2] = "Combine_Etc_MorningLand_Boss_02_Ranking_2nd",
    [3] = "Combine_Etc_MorningLand_Boss_02_Ranking_3rd"
  },
  _isShowMyRankInfo = false,
  _defaultSpanSizeY = 0,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_MorningLand_ConquestHistory_Init")
function FromClient_MorningLand_ConquestHistory_Init()
  PaGlobal_MorningLand_ConquestHistory_All:initialize()
end
function PaGlobal_MorningLand_ConquestHistory_All:initialize()
  if self._isInitialize == true then
    return
  end
  if _ContentsGroup_MorningLand == false then
    return
  end
  if Panel_MorningLand_ConquestHistory == nil then
    return
  end
  local titleBg = UI.getChildControl(Panel_MorningLand_ConquestHistory, "StaticText_ConquestHistoryTitle")
  self._ui.txt_historyTitle = UI.getChildControl(titleBg, "StaticText_Title")
  self._ui.btn_closePC = UI.getChildControl(titleBg, "Button_Close_PCUI")
  self._ui.stc_contentsArea = UI.getChildControl(Panel_MorningLand_ConquestHistory, "Static_ContentsArea")
  local Static_THeader = UI.getChildControl(self._ui.stc_contentsArea, "Static_THeader")
  self._ui.txt_BossTitle = UI.getChildControl(Static_THeader, "StaticText_TH_Bossname")
  self._ui.list2_ConquestHistory = UI.getChildControl(self._ui.stc_contentsArea, "List2_ConquestHistory")
  self._ui.stc_NoData = UI.getChildControl(Panel_MorningLand_ConquestHistory, "StaticText_NoStatic")
  self._isConsole = _ContentsGroup_UsePadSnapping
  Panel_MorningLand_ConquestHistory:ComputePosAllChild()
  PaGlobal_MorningLand_ConquestHistory_All:registEventHandler()
  if self._isConsole == true then
    local consoleBG = UI.getChildControl(Panel_MorningLand_ConquestHistory, "Static_KeyGuide_ConsoleUI_Import")
    local consoleKeyB = UI.getChildControl(consoleBG, "StaticText_B_ConsoleUI")
    PaGlobalFunc_ConsoleKeyGuide_SetAlign({consoleKeyB}, consoleBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui.btn_closePC:SetShow(false)
  end
  PaGlobal_MorningLand_ConquestHistory_All._initialize = true
end
function PaGlobal_MorningLand_ConquestHistory_All:registEventHandler()
  if Panel_MorningLand_ConquestHistory == nil then
    return
  end
  self._ui.btn_closePC:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_ConquestHistory_All_Close()")
  self._ui.list2_ConquestHistory:registEvent(__ePAUIList2EventType_LuaChangeContent, "ConquestHistoryListControlCreate")
  self._ui.list2_ConquestHistory:createChildContent(__ePAUIList2ElementManagerType_List)
  if self._isConsole == true then
  end
end
function PaGlobal_MorningLand_ConquestHistory_All:prepareOpen()
  if _ContentsGroup_MorningLand == false then
    return
  end
  if Panel_MorningLand_ConquestHistory == nil then
    return
  end
  self._ui.txt_BossTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_TH_BOSS"))
  if self._isShowMyRankInfo == false then
    self._ui.stc_NoData:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_NO_RECORDDATA"))
    self._ui.txt_historyTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_HISTORY"))
  else
    self._ui.stc_NoData:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_NO_RANKINGDATA"))
    self._ui.txt_historyTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_MYRANKING"))
  end
  local count = 0
  if self._isShowMyRankInfo == false then
    count = ToClient_RequestElementalPersonalInfoSize(__eMorningLandMosterPartCount)
  else
    count = ToClient_ElementalBossMyRankInfoCount()
  end
  if count == 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_NO_RECORDDATA"))
    return
  end
  self._ui.stc_contentsArea:SetShow(count > 0)
  self._ui.stc_NoData:SetShow(count <= 0)
  self._ui.list2_ConquestHistory:getElementManager():clearKey()
  for index = 0, count - 1 do
    self._ui.list2_ConquestHistory:getElementManager():pushKey(index)
  end
  self:open()
end
function PaGlobal_MorningLand_ConquestHistory_All:open()
  if nil == Panel_MorningLand_ConquestHistory then
    return
  end
  Panel_MorningLand_ConquestHistory:SetShow(true)
end
function PaGlobal_MorningLand_ConquestHistory_All:prepareClose()
  if nil == Panel_MorningLand_ConquestHistory then
    return
  end
  PaGlobal_MorningLand_ConquestHistory_All:close()
end
function PaGlobal_MorningLand_ConquestHistory_All:close()
  if nil == Panel_MorningLand_ConquestHistory then
    return
  end
  Panel_MorningLand_ConquestHistory:SetShow(false)
end
function ConquestHistoryListControlCreate(content, key)
  local self = PaGlobal_MorningLand_ConquestHistory_All
  local conquestInfo, morningBossSSW
  local monsterKey32 = 0
  local index = Int64toInt32(key)
  local control = UI.getChildControl(content, "Static_ConquestHistory_0")
  if self._isShowMyRankInfo == false then
    conquestInfo = ToClient_getElementalMonsterPersonalInfoAt(index)
  else
    conquestInfo = ToClient_ElementalBossMyRankInfoCountIndex(index)
  end
  if conquestInfo ~= nil then
    monsterKey32 = conquestInfo:getChracterKeyRaw()
  end
  if monsterKey32 ~= nil then
    morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(monsterKey32)
  end
  if nil ~= morningBossSSW then
    local monsterKeyRaw = morningBossSSW:getCharacterKeyRaw()
    local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(monsterKeyRaw)
    local stc_conquestHistory_Weakness = UI.getChildControl(control, "Static_ConquestHistory_Weakness")
    local txt_conquestHistory_Name = UI.getChildControl(control, "StaticText_ConquestHistory_Name")
    local stc_conquestHistory_RankIcon = UI.getChildControl(control, "Static_ConquestHistory_RankIcon")
    local txt_conquestHistory_Rank = UI.getChildControl(control, "StaticText_ConquestHistory_Rank")
    local txt_conquestHistory_Level = UI.getChildControl(control, "StaticText_ConquestHistory_Level")
    local txt_conquestHistory_Charname = UI.getChildControl(control, "StaticText_ConquestHistory_Charname")
    local stc_conquestHistory_DifficultyBox = UI.getChildControl(control, "Static_Difficulty_Box")
    local stc_conquestHistory_DifficultyTalisman = UI.getChildControl(stc_conquestHistory_DifficultyBox, "Static_Difficulty_Talisman")
    local txt_conquestHistory_Difficulty = UI.getChildControl(stc_conquestHistory_DifficultyBox, "StaticText_ConquestHistory_Difficulty")
    local txt_conquestHistory_ClearTime = UI.getChildControl(control, "StaticText_ConquestHistory_Time")
    local isMorningLandPart1 = conquestInfo:getMorningLandMonsterPart() == __eMorningLandMosterPart1
    local bossGroup = morningBossSSW:getGroup()
    local bossListVisualUV = self._bossListUV[bossGroup]
    control:ChangeTextureInfoTextureIDAsync(bossListVisualUV)
    control:setRenderTexture(control:getBaseTexture())
    local bossWeeknessIconString = self._bossWeeknessUV[morningBossSSW:getElementalStatType()]
    stc_conquestHistory_Weakness:ChangeTextureInfoTextureIDAsync(bossWeeknessIconString)
    stc_conquestHistory_Weakness:setRenderTexture(stc_conquestHistory_Weakness:getBaseTexture())
    txt_conquestHistory_Name:SetTextMode(__eTextMode_AutoWrap)
    txt_conquestHistory_Name:SetText(characterStaticStatusWarpper:getName())
    txt_conquestHistory_Name:ComputePos()
    if self._isShowMyRankInfo == false then
      stc_conquestHistory_Weakness:SetSpanSize(stc_conquestHistory_Weakness:GetSpanSize().x, 0)
      txt_conquestHistory_Name:SetSpanSize(txt_conquestHistory_Name:GetSpanSize().x, 0)
    else
      stc_conquestHistory_Weakness:SetSpanSize(stc_conquestHistory_Weakness:GetSpanSize().x, self._defaultSpanSizeY)
      txt_conquestHistory_Name:SetSpanSize(txt_conquestHistory_Name:GetSpanSize().x, self._defaultSpanSizeY)
    end
    stc_conquestHistory_Weakness:SetShow(isMorningLandPart1)
    local rankIndex
    if self._isShowMyRankInfo == true then
      rankIndex = conquestInfo:getRankIndex()
    end
    local rankIcon
    if rankIndex ~= nil and rankIndex ~= 0 and rankIndex <= 3 then
      local rankIconString = self._rankingIcon[rankIndex]
      stc_conquestHistory_RankIcon:ChangeTextureInfoTextureIDAsync(rankIconString)
      stc_conquestHistory_RankIcon:setRenderTexture(stc_conquestHistory_RankIcon:getBaseTexture())
      stc_conquestHistory_RankIcon:SetShow(isMorningLandPart1)
    else
      stc_conquestHistory_RankIcon:SetShow(false)
    end
    local rank
    if self._isShowMyRankInfo == true then
      rank = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_RANK", "rank", rankIndex)
      if rankIndex > 20 then
        local rankPercentDesc = conquestInfo:getRankPercent()
        if rankPercentDesc >= 10 and rankPercentDesc < 20 then
          rankPercentDesc = 10
        elseif rankPercentDesc >= 20 and rankPercentDesc < 30 then
          rankPercentDesc = 20
        elseif rankPercentDesc >= 30 and rankPercentDesc < 40 then
          rankPercentDesc = 30
        elseif rankPercentDesc >= 40 and rankPercentDesc < 50 then
          rankPercentDesc = 40
        elseif rankPercentDesc >= 50 and rankPercentDesc < 60 then
          rankPercentDesc = 50
        elseif rankPercentDesc >= 60 and rankPercentDesc < 70 then
          rankPercentDesc = 60
        elseif rankPercentDesc >= 70 and rankPercentDesc < 80 then
          rankPercentDesc = 70
        elseif rankPercentDesc >= 80 and rankPercentDesc < 90 then
          rankPercentDesc = 80
        elseif rankPercentDesc >= 90 and rankPercentDesc < 100 then
          rankPercentDesc = 90
        end
        rank = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_PERCENT", "rank", rankPercentDesc) .. " %"
      end
    end
    if rank ~= nil then
      txt_conquestHistory_Rank:SetText(rank)
      txt_conquestHistory_Rank:SetShow(isMorningLandPart1)
    else
      txt_conquestHistory_Rank:SetShow(false)
    end
    local classType = conquestInfo:getClassType()
    local classIconStr = NewClassData.newClass_Texture_ID[classType]._classSymbolIconTID
    txt_conquestHistory_Level:ChangeTextureInfoTextureIDAsync(classIconStr)
    txt_conquestHistory_Level:setRenderTexture(txt_conquestHistory_Level:getBaseTexture())
    local level = "Lv." .. tostring(conquestInfo:getLevel())
    txt_conquestHistory_Level:SetText(level)
    if self._isShowMyRankInfo == false then
      txt_conquestHistory_Charname:SetText(conquestInfo:getChracterNickName())
    else
      txt_conquestHistory_Charname:SetText(conquestInfo:getUserNickName())
    end
    local levelIdx = conquestInfo:getConquestLevel()
    txt_conquestHistory_Difficulty:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_DIFFICULTY_" .. tostring(levelIdx)))
    if isMorningLandPart1 == false then
      if levelIdx == 0 then
        txt_conquestHistory_Difficulty:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING2_EASY"))
      elseif levelIdx == 1 then
        txt_conquestHistory_Difficulty:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING2_HARD"))
      end
    end
    local talismanIconStr = tostring("Combine_Etc_MorningLand_Boss_01_Btn_Level_" .. tostring(levelIdx + 1) .. "_Normal")
    stc_conquestHistory_DifficultyTalisman:ChangeTextureInfoTextureIDAsync(talismanIconStr)
    stc_conquestHistory_DifficultyTalisman:setRenderTexture(stc_conquestHistory_DifficultyTalisman:getBaseTexture())
    stc_conquestHistory_DifficultyTalisman:SetShow(isMorningLandPart1)
    local minute = 0
    local second = 0
    if self._isShowMyRankInfo == false then
      minute = math.floor(Int64toInt32(conquestInfo._recordTick) / 1000 / 60)
      second = math.floor(Int64toInt32(conquestInfo._recordTick) / 1000 % 60)
    else
      minute = math.floor(Int64toInt32(conquestInfo:getRecordTick64()) / 1000 / 60)
      second = math.floor(Int64toInt32(conquestInfo:getRecordTick64()) / 1000 % 60)
    end
    local timeStr = string.format("%.02d", minute) .. ":" .. string.format("%.02d", second)
    txt_conquestHistory_ClearTime:SetText(timeStr)
    morningBossSSW, monsterKey32 = nil, nil
    control:SetShow(true)
  else
    control:SetShow(false)
  end
end
function PaGlobal_MorningLand_ConquestHistory_All_Close()
  if nil == Panel_MorningLand_ConquestHistory then
    return
  end
  PaGlobal_MorningLand_ConquestHistory_All:prepareClose()
end
function PaGlobal_MorningLand_ConquestHistory_All_Open()
  if nil == PaGlobal_MorningLand_ConquestHistory_All then
    return
  end
  PaGlobal_MorningLand_ConquestHistory_All._isShowMyRankInfo = false
  PaGlobal_MorningLand_ConquestHistory_All:prepareOpen()
end
function PaGlobal_MorningLand_ConquestHistory_All_OpenByRankPanel()
  if nil == PaGlobal_MorningLand_ConquestHistory_All then
    return
  end
  PaGlobal_MorningLand_ConquestHistory_All._isShowMyRankInfo = true
  PaGlobal_MorningLand_ConquestHistory_All:prepareOpen()
end
