Panel_QuestDirect:SetShow(false, false)
Panel_QuestDirect:setGlassBackground(true)
Panel_QuestDirect:setFlushAble(false)
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local QuestType = CppEnums.QuestType
local ui = {
  _backGround = UI.getChildControl(Panel_QuestDirect, "Static_BG"),
  _countingBG = UI.getChildControl(Panel_QuestDirect, "Static_CountBG"),
  _backEff = UI.getChildControl(Panel_QuestDirect, "Static_BackEffect"),
  _questImg = UI.getChildControl(Panel_QuestDirect, "Static_QuestImg"),
  _text_QuestDirect = UI.getChildControl(Panel_QuestDirect, "StaticText_QuestAccept"),
  _text_QuestTitle = UI.getChildControl(Panel_QuestDirect, "StaticText_QuestTitle"),
  _text_QuestDemand = UI.getChildControl(Panel_QuestDirect, "StaticText_QuestDemand"),
  _text_QuestTitle_2 = UI.getChildControl(Panel_QuestDirect, "StaticText_QuestTitle_2"),
  _text_QuestDemand_2 = UI.getChildControl(Panel_QuestDirect, "StaticText_QuestDemand_2")
}
local QuestDirect_ConstValue = {animationEndTime = 2}
local QuestDirect_Value = {
  elapsedTime = QuestDirect_ConstValue.animationEndTime
}
local nowDemand
local demandPreCount = 0
local constValue = {
  bgBottomGap = ui._backGround:GetSizeY() + ui._backGround:GetPosY() - (ui._text_QuestDemand:GetSizeY() + ui._text_QuestDemand:GetPosY()),
  questTitleBasePosY = ui._text_QuestTitle:GetPosY()
}
local _lastQuestInfo = {}
local _questNoRawXXX
local PaGlobal_AcquireQuestDirect = {_questLoadingDataList = nil}
local function init()
  ui._text_QuestTitle:SetTextMode(__eTextMode_AutoWrap)
  ui._text_QuestTitle:SetAutoResize(true)
  ui._text_QuestDemand:SetTextMode(__eTextMode_AutoWrap)
  ui._text_QuestDemand:SetAutoResize(true)
  ui._text_QuestTitle_2:SetTextMode(__eTextMode_AutoWrap)
  ui._text_QuestTitle_2:SetAutoResize(true)
  ui._text_QuestDemand_2:SetTextMode(__eTextMode_AutoWrap)
  ui._text_QuestDemand_2:SetAutoResize(true)
end
function QuestDirect_ReSize()
  local scrX = getOriginScreenSizeX()
  local scrY = getOriginScreenSizeY()
  Panel_QuestDirect:SetPosX(scrX / 2 - Panel_QuestDirect:GetSizeX() / 2)
end
function QuestComplete_Effect()
  local bg_sizeX = ui._backGround:GetSizeX()
  local bg_sizeY = ui._backGround:GetSizeY()
  local bg_posX = ui._backGround:GetPosX()
  local bg_posY = ui._backGround:GetPosY()
  ui._countingBG:SetSize(500, 200)
  ui._countingBG:SetSpanSize(ui._countingBG:GetSpanSize().x, 10)
  ui._text_QuestDemand:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_QUESTACQUIRE_COUNTDONE"))
  ui._text_QuestTitle:SetPosY(constValue.questTitleBasePosY)
  ui._text_QuestDemand:SetPosY(ui._text_QuestTitle:GetTextSizeY() + ui._text_QuestTitle:GetPosY())
  ui._backEff:SetSize(bg_sizeX, bg_sizeY)
  ui._backEff:SetPosX(bg_posX)
  ui._backEff:SetPosY(bg_posY)
  audioPostEvent_SystemUi(4, 3)
  _AudioPostEvent_SystemUiForXBOX(4, 3)
  ui._backEff:EraseAllEffect()
  ui._backEff:AddEffect("UI_QustPerform01", false, 0, -5)
  ui._backEff:AddEffect("UI_QustPerform02", false, 0, -5)
  ui._backEff:AddEffect("fUI_Light", false, 0, 0)
  AcquireQuestDirect_Start(8)
end
function AcquireQuestDirect_UpdateQuestDemand(questData, demand, isComplete)
  ui._backGround:SetShow(false)
  ui._countingBG:SetShow(true)
  ui._questImg:SetShow(false)
  ui._text_QuestDirect:SetText("")
  ui._text_QuestTitle:SetText("")
  ui._text_QuestTitle_2:SetText(ToClient_getReplaceDialog(demand._desc))
  ui._text_QuestTitle_2:SetPosY(-70)
  ui._text_QuestDemand_2:SetPosY(ui._text_QuestTitle_2:GetTextSizeY() + ui._text_QuestTitle_2:GetPosY())
  if demand._currentCount < demand._destCount then
    ui._countingBG:SetSize(500, 100)
    ui._countingBG:SetSpanSize(ui._countingBG:GetSpanSize().x, -70)
    ui._text_QuestTitle_2:AddEffect("fUI_Gauge_Blue", false, 0, 0)
    ui._text_QuestDemand:SetText("")
    local tracer1 = Profile_BeginUIFunction("checkedQuestWidget:update-1")
    local conditionCountMSg = demand._currentCount .. " / " .. demand._destCount
    chatting_sendMessage("", ToClient_getReplaceDialog(demand._desc) .. " : " .. conditionCountMSg, CppEnums.ChatType.System)
    Profile_EndUIFunction(tracer1)
    local tracer2 = Profile_BeginUIFunction("checkedQuestWidget:update-2")
    ui._text_QuestDemand_2:SetText(conditionCountMSg)
    AcquireQuestDirect_Start(5)
    Profile_EndUIFunction(tracer2)
    ui._text_QuestDemand_2:EraseAllEffect()
  else
    ui._text_QuestTitle_2:SetText("")
    ui._text_QuestDemand_2:SetText("")
    ui._text_QuestTitle:SetText(ToClient_getReplaceDialog(demand._desc))
    chatting_sendMessage("", PAGetStringParam1(Defines.StringSheet_GAME, "LUA_AQUIREMESSAGE_QUESTCOMPLETE", "desc", ToClient_getReplaceDialog(demand._desc)), CppEnums.ChatType.System)
    if isComplete then
      audioPostEvent_SystemUi(4, 2)
      _AudioPostEvent_SystemUiForXBOX(4, 2)
      ui._text_QuestDirect:SetFontColor(UI_color.C_FFB5FF6D)
      ui._text_QuestDirect:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_QUESTACQUIRE_ACCOMPLISHED"))
      QuestComplete_Effect()
    else
      audioPostEvent_SystemUi(4, 2)
      _AudioPostEvent_SystemUiForXBOX(4, 2)
      ui._text_QuestDirect:SetFontColor(UI_color.C_FFD8CABA)
      ui._text_QuestDirect:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_QUESTACQUIRE_PATIALACCOMPLISHED"))
      QuestComplete_Effect()
    end
  end
end
local questDataCache = {}
function AcquireDirect_QuestUpdate(questNoRaw)
  if questNoRaw == nil then
    return
  end
  local questData = ToClient_getProgressingQuestAtKey(questNoRaw)
  if questData == nil then
    return
  end
  local tracer1 = Profile_BeginUIFunction("AcquireDirect_QuestUpdate-" .. tostring(questNoRaw))
  if false == questData:isSpecialType() and 11 ~= questData:getQuestType() and false == questData:isSeasonPassType() and false == questData:isGrowthPassType() and questData:isOlviaAcademyPassType() == false then
    local questKey = questData:getKey()
    local prevCache = questDataCache[questKey]
    if nil == prevCache then
      prevCache = {}
    end
    local currentCache = {}
    local demandCount = questData:getDemadCount()
    local diffIndex = -1
    local isComplete = true
    for demandIndex = 0, demandCount - 1 do
      local demand = questData:getDemandAt(demandIndex)
      currentCache[demandIndex] = demand._currentCount
      if demand._currentCount ~= demand._destCount then
        isComplete = false
      end
      if currentCache[demandIndex] ~= nil and prevCache[demandIndex] ~= nil and currentCache[demandIndex] ~= prevCache[demandIndex] then
        diffIndex = demandIndex
      end
    end
    if questNoRaw == questKey and -1 ~= diffIndex then
      local demand = questData:getDemandAt(diffIndex)
      AcquireQuestDirect_UpdateQuestDemand(questData, demand, isComplete)
    end
    questDataCache[questKey] = currentCache
  end
  Profile_EndUIFunction(tracer1)
end
registerEvent("updateProgressQuestList", "AcquireDirect_QuestUpdate")
function AcquireDirecteReShowUpdate()
end
function AcquireQuestDirect_Start(remainTime)
  Panel_QuestDirect:SetShow(true, false)
  Panel_QuestDirect:ResetVertexAni()
  Panel_QuestDirect:SetScaleChild(1, 1)
  local aniInfo = Panel_QuestDirect:addColorAnimation(0, 0.25, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo.IsChangeChild = true
  local aniInfo1 = Panel_QuestDirect:addColorAnimation(0.25, remainTime - 1, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_QuestDirect:addColorAnimation(remainTime - 1, remainTime, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo2:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo2:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo2.IsChangeChild = true
end
init()
QuestDirect_ReSize()
function FromClient_eventCutscenePlay()
  close_attacked_WindowPanelList(true)
end
function FromClient_eventCutsceneStop()
  if Panel_QuestDirect:isPlayAnimation() == false then
    ui._backGround:EraseAllEffect()
  end
end
registerEvent("onScreenResize", "QuestDirect_ReSize")
registerEvent("FromClient_eventCutsceneStop", "FromClient_eventCutsceneStop")
registerEvent("FromClient_eventCutscenePlay", "FromClient_eventCutscenePlay")
local _guildQuestName
local _prevCurrentCount = {}
function FromClient_AcquireAcceptGuildQuestDirectUpdate()
  if ToClient_isGuildQuestOtherServer() then
    return
  end
  if true == ToClient_GetMessageFilter(9) then
    return
  end
  if PaGlobal_TutorialManager:isDoingTutorial() then
    return
  end
  for index = 0, 4 do
    _prevCurrentCount[index] = 0
  end
  ui._backGround:EraseAllEffect()
  ui._countingBG:SetShow(false)
  ui._questImg:SetShow(true)
  ui._backGround:SetShow(true)
  ui._questImg:ChangeTextureInfoNameAsync("new_ui_common_forlua/widget/acquire/Acquire_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(ui._questImg, 170, 66, 234, 130)
  ui._questImg:getBaseTexture():setUV(x1, y1, x2, y2)
  ui._questImg:setRenderTexture(ui._questImg:getBaseTexture())
  _guildQuestName = ToClient_getCurrentGuildQuestName()
  local msg = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_NEWQUEST") .. " '" .. _guildQuestName .. "'"
  ui._text_QuestDirect:SetText(msg)
  ui._text_QuestDirect:SetFontColor(UI_color.C_FFEDE699)
  ui._text_QuestTitle:SetText(" ")
  ui._text_QuestTitle_2:SetText(" ")
  ui._text_QuestTitle_2:EraseAllEffect()
  ui._text_QuestTitle:SetPosY(constValue.questTitleBasePosY)
  ui._text_QuestDemand:SetTextMode(__eTextMode_Limit_AutoWrap)
  ui._text_QuestDemand:SetPosY(ui._text_QuestTitle:GetPosY() + ui._text_QuestTitle:GetTextSizeY())
  ui._text_QuestDemand_2:SetTextMode(__eTextMode_Limit_AutoWrap)
  ui._text_QuestDemand_2:SetPosY(ui._text_QuestTitle_2:GetPosY() + ui._text_QuestTitle_2:GetTextSizeY())
  ui._text_QuestDemand:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_DESC") .. " " .. ToClient_getCurrentGuildQuestDesc())
  ui._text_QuestDemand_2:SetText("")
  audioPostEvent_SystemUi(4, 0)
  _AudioPostEvent_SystemUiForXBOX(4, 0)
  ui._backGround:EraseAllEffect()
  ui._backGround:AddEffect("fUI_Light", false, 0, 0)
  ui._backGround:AddEffect("UI_QustAccept01", false, 0, 30)
  ui._backGround:AddEffect("UI_QustAccept02", false, 0, 30)
  local spanSize = ui._questImg:GetSpanSize()
  ui._questImg:SetSpanSize((-ui._questImg:GetSizeX() - ui._text_QuestDirect:GetTextSizeX()) / 2, spanSize.y)
  ui._backGround:SetSize(ui._backGround:GetSizeX(), ui._text_QuestDemand:GetPosY() + ui._text_QuestDemand:GetSizeY() - ui._backGround:GetPosY() + constValue.bgBottomGap)
  AcquireQuestDirect_Start(8)
end
function FromClient_AcquireComplateGuildQuestDirectUpdate()
  if true == ToClient_GetMessageFilter(9) then
    return
  end
  if PaGlobal_TutorialManager:isDoingTutorial() then
    return
  end
  ui._backGround:EraseAllEffect()
  ui._countingBG:SetShow(false)
  ui._questImg:SetShow(true)
  ui._backGround:SetShow(true)
  ui._questImg:ChangeTextureInfoNameAsync("new_ui_common_forlua/widget/acquire/Acquire_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(ui._questImg, 170, 1, 234, 65)
  ui._questImg:getBaseTexture():setUV(x1, y1, x2, y2)
  ui._questImg:setRenderTexture(ui._questImg:getBaseTexture())
  ui._text_QuestDirect:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_ACQUIRE_COMPLATE"))
  ui._text_QuestDirect:SetFontColor(UI_color.C_FF00C0D7)
  ui._text_QuestTitle:SetText("")
  ui._text_QuestTitle_2:SetText("")
  ui._text_QuestDemand:SetText(" ")
  ui._text_QuestDemand_2:SetText(" ")
  ui._text_QuestDemand:SetTextMode(__eTextMode_Limit_AutoWrap)
  ui._text_QuestTitle:SetPosY(constValue.questTitleBasePosY)
  ui._text_QuestDemand:SetPosY(ui._text_QuestTitle:GetPosY() + ui._text_QuestTitle:GetTextSizeY())
  audioPostEvent_SystemUi(4, 3)
  _AudioPostEvent_SystemUiForXBOX(4, 3)
  ui._backGround:EraseAllEffect()
  ui._backGround:AddEffect("fUI_Light", false, 0, 0)
  ui._backGround:AddEffect("UI_QustComplete01", false, 0, 0)
  ui._backGround:AddEffect("UI_QustComplete02", false, 0, 0)
  ui._backGround:AddEffect("fUI_QuestComplete", false, 0, 0)
  local spanSize = ui._questImg:GetSpanSize()
  ui._questImg:SetSpanSize((-ui._questImg:GetSizeX() - ui._text_QuestDirect:GetTextSizeX()) / 2, spanSize.y)
  ui._backGround:SetSize(ui._backGround:GetSizeX(), ui._text_QuestDemand:GetPosY() + ui._text_QuestDemand:GetSizeY() - ui._backGround:GetPosY() + constValue.bgBottomGap)
  AcquireQuestDirect_Start(8)
end
function AcquireGuildQuestDemand(actorName, characterName, currentGuildQuestInfo, isComplete)
  ui._backGround:SetShow(false)
  ui._countingBG:SetShow(true)
  ui._questImg:SetShow(false)
  ui._text_QuestDirect:SetText("")
  ui._text_QuestTitle:SetText("")
  ui._text_QuestTitle_2:SetText(currentGuildQuestInfo._desc)
  ui._text_QuestTitle_2:SetPosY(-60)
  ui._text_QuestDemand:SetPosY(ui._text_QuestTitle:GetTextSizeY() + ui._text_QuestTitle:GetPosY())
  ui._text_QuestDemand_2:SetPosY(ui._text_QuestTitle_2:GetTextSizeY() + ui._text_QuestTitle_2:GetPosY())
  if currentGuildQuestInfo._currentCount < currentGuildQuestInfo._destCount then
    ui._countingBG:SetSize(500, 100)
    ui._text_QuestTitle:SetPosY(ui._text_QuestTitle_2:GetPosY())
    ui._countingBG:SetSpanSize(ui._countingBG:GetSpanSize().x, -70)
    ui._text_QuestTitle:AddEffect("fUI_Gauge_Blue", false, 0, 13)
    ui._text_QuestDemand:SetText("")
    local message = currentGuildQuestInfo._currentCount .. " / " .. currentGuildQuestInfo._destCount .. [[

<PAColor0xFFAAAAAA>]] .. actorName .. "(" .. characterName .. ")<PAOldColor>"
    local chat_message = currentGuildQuestInfo._desc .. " " .. currentGuildQuestInfo._currentCount .. " / " .. currentGuildQuestInfo._destCount .. " " .. PAGetStringParam2(Defines.StringSheet_GAME, "ACQUIRE_TITLEMESSAGE_25", "actorName", actorName, "characterName", characterName)
    ui._text_QuestDemand_2:SetTextMode(__eTextMode_AutoWrap)
    ui._text_QuestDemand_2:SetText(message)
    chatting_sendMessage("", chat_message, CppEnums.ChatType.System)
    AcquireQuestDirect_Start(5)
    ui._text_QuestDemand_2:EraseAllEffect()
  else
    ui._text_QuestTitle_2:SetText("")
    ui._text_QuestDemand_2:SetText("")
    ui._text_QuestTitle:SetText(currentGuildQuestInfo._desc)
    if isComplete then
      audioPostEvent_SystemUi(4, 1)
      _AudioPostEvent_SystemUiForXBOX(4, 1)
      ui._text_QuestDirect:SetFontColor(UI_color.C_FFB5FF6D)
      ui._text_QuestDirect:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_ACQUIRE_ACCOMPLISHED"))
      QuestComplete_Effect()
    else
      audioPostEvent_SystemUi(4, 1)
      _AudioPostEvent_SystemUiForXBOX(4, 1)
      ui._text_QuestDirect:SetFontColor(UI_color.C_FFD8CABA)
      ui._text_QuestDirect:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_ACQUIRE_PATIALACCOMPLISHED"))
      QuestComplete_Effect()
    end
  end
end
function FromClient_AcquireGuildQuestDirectUpdate(actorName, characterName)
  if true == ToClient_GetMessageFilter(9) then
    return
  end
  if PaGlobal_TutorialManager:isDoingTutorial() then
    return
  end
  if PaGlobal_PowerControl_All_GetShowPanel() then
    return
  end
  if true == ToClient_isProgressingGuildQuest() then
    local questConditionCount = ToClient_getCurrentGuildQuestConditionCount()
    local isComplete = true
    local diffIndex = -1
    if nil == _prevCurrentCount[0] then
      for index = 0, questConditionCount - 1 do
        local currentGuildQuestInfo = ToClient_getCurrentGuildQuestConditionAt(index)
        _prevCurrentCount[index] = currentGuildQuestInfo._currentCount
      end
    end
    for index = 0, questConditionCount - 1 do
      local currentGuildQuestInfo = ToClient_getCurrentGuildQuestConditionAt(index)
      if currentGuildQuestInfo._currentCount ~= currentGuildQuestInfo._destCount then
        isComplete = false
      else
        isComplete = true
      end
      if _prevCurrentCount[index] ~= currentGuildQuestInfo._currentCount then
        diffIndex = index
        _prevCurrentCount[index] = currentGuildQuestInfo._currentCount
      end
    end
    if -1 ~= diffIndex then
      local currentGuildQuestInfo = ToClient_getCurrentGuildQuestConditionAt(diffIndex)
      AcquireGuildQuestDemand(actorName, characterName, currentGuildQuestInfo, isComplete)
    end
  end
end
function AcquireQuestDirect_getLastQuestInfo()
  return _lastQuestInfo.group, _lastQuestInfo.quest
end
function AcquireQuestDirect_clearLastQuestInfo()
  _lastQuestInfo = {}
end
function AcquireQuestDirect_getLastQuestRaw()
  return _questNoRawXXX
end
function AcquireQuestDirect_clearLastQuestRaw()
  _questNoRawXXX = nil
end
registerEvent("ResponseAcceptGuildQuest", "FromClient_AcquireAcceptGuildQuestDirectUpdate")
registerEvent("ResponseCompleteGuildQuest", "FromClient_AcquireComplateGuildQuestDirectUpdate")
registerEvent("ResponseUpdateGuildQuest", "FromClient_AcquireGuildQuestDirectUpdate")
if _ContentsGroup_QuestBackEndLoading == true then
  registerEvent("FromClient_QuestBackEndLoadComplete", "FromClient_AcquireQuestDirect_QuestBackEndLoadComplete")
end
function PaGlobal_AcquireQuestDirect:clearQuestLoadingTable()
  if Panel_QuestDirect == nil or _ContentsGroup_QuestBackEndLoading == false then
    return
  end
  self._questLoadingDataList = Array.new()
end
function PaGlobal_AcquireQuestDirect:pushQuestLoadingData(questWrapper, isAccept)
  if Panel_QuestDirect == nil or _ContentsGroup_QuestBackEndLoading == false or questWrapper == nil or isAccept == nil then
    return
  end
  if self._questLoadingDataList == nil then
    self:clearQuestLoadingTable()
  end
  local newLoadingData = {
    _questNoRaw = questWrapper:getQuestNo()._raw,
    _isAccept = isAccept
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
  questWrapper:requestLoadBackEndData()
end
function PaGlobal_AcquireQuestDirect:isExistLoadingDataAnyOne()
  if Panel_QuestDirect == nil or _ContentsGroup_QuestBackEndLoading == false then
    return false
  end
  if self._questLoadingDataList == nil then
    return false
  end
  local isExistAnyOne = self._questLoadingDataList:length() ~= 0
  return isExistAnyOne
end
function FromClient_AcquireQuestDirect_QuestBackEndLoadComplete(s32_questNoRaw)
  if Panel_QuestDirect == nil or _ContentsGroup_QuestBackEndLoading == false then
    return
  end
  if PaGlobal_AcquireQuestDirect:isExistLoadingDataAnyOne() == false then
    return
  end
  local needUpdate = false
  local isAccept
  for index = 1, #PaGlobal_AcquireQuestDirect._questLoadingDataList do
    local value = PaGlobal_AcquireQuestDirect._questLoadingDataList[index]
    if value ~= nil and value._questNoRaw == s32_questNoRaw then
      needUpdate = true
      isAccept = value._isAccept
      table.remove(PaGlobal_AcquireQuestDirect._questLoadingDataList, index)
      break
    end
  end
  return
end
