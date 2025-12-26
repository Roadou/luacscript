PaGlobal_QuestDirectAlert_All = {
  _ui = {
    txt_title = UI.getChildControl(Panel_Widget_QuestAlert, "StaticText_Title"),
    txt_desc = UI.getChildControl(Panel_Widget_QuestAlert, "StaticText_Desc")
  },
  _messageTitle = {
    [1] = string.gsub(PAGetString(Defines.StringSheet_GAME, "LUA_QUESTACQUIRE_NEWQUEST"), "-", ""),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTACQUIRE_PATIALACCOMPLISHED"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTACQUIRE_ACCOMPLISHED"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTACQUIRE_COMPLETE")
  },
  _fontColor = {
    [1] = Defines.Color.C_FFEDE699,
    [2] = Defines.Color.C_FFB5FF6D,
    [3] = Defines.Color.C_FFEF9C7F,
    [4] = Defines.Color.C_FF00C0D7
  },
  _animateTime = 0,
  _animateEndTime = 3,
  _screenSizeX = nil,
  _questDataCache = {}
}
function PaGlobal_QuestDirectAlert_All:registEventHandler()
  registerEvent("EventQuestUpdateNotify", "FromClient_QuestDirectAlert_Accept")
  registerEvent("updateProgressQuestList", "FromClient_QuestDirectAlert_Update")
  registerEvent("onScreenResize", "FromClient_OnScreenResize_QuestDirectAlert")
  Panel_Widget_QuestAlert:RegisterUpdateFunc("PaGlobalFunc_QeustDirectAlert_UpdateFunc")
end
function PaGlobal_QuestDirectAlert_All:open()
  local ImageMoveAni = Panel_Widget_QuestAlert:addMoveAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageMoveAni:SetStartPosition(self._screenSizeX + 10, Panel_Widget_QuestAlert:GetPosY())
  ImageMoveAni:SetEndPosition(self._screenSizeX - (Panel_Widget_QuestAlert:GetSizeX() + 10), Panel_Widget_QuestAlert:GetPosY())
  Panel_Widget_QuestAlert:CalcUIAniPos(ImageMoveAni)
  ImageMoveAni:SetDisableWhileAni(true)
  self._animateTime = 0
  Panel_Widget_QuestAlert:SetShow(true)
end
function PaGlobal_QuestDirectAlert_All:close()
  local ImageMoveAni = Panel_Widget_QuestAlert:addMoveAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageMoveAni:SetStartPosition(self._screenSizeX - (Panel_Widget_QuestAlert:GetSizeX() + 10), Panel_Widget_QuestAlert:GetPosY())
  ImageMoveAni:SetEndPosition(self._screenSizeX + 10, Panel_Widget_QuestAlert:GetPosY())
  Panel_Widget_QuestAlert:CalcUIAniPos(ImageMoveAni)
  ImageMoveAni:SetDisableWhileAni(true)
  ImageMoveAni:SetHideAtEnd(true)
end
function PaGlobal_QuestDirectAlert_All:validate()
  if nil == Panel_Widget_QuestAlert then
    return
  end
  self._ui.txt_title:isValidate()
  self._ui.txt_desc:isValidate()
end
function FromClient_QuestDirectAlert_Accept(isAccept, questNoRaw)
  if nil == questNoRaw then
    UI.ASSERT(nil ~= questNoRaw, "questNoRaw \236\157\180\235\169\180 \236\149\136\235\144\169\235\139\136\235\139\164.")
    return
  end
  local questInfoWrapper = questList_getQuestInfo(questNoRaw)
  if nil == questInfoWrapper then
    return
  end
  if isAccept == true and questInfoWrapper:isAutoAcceptQuest() == true then
    return
  end
  if questInfoWrapper:isSpecialType() or questInfoWrapper:isSeasonPassType() or questInfoWrapper:isGrowthPassType() or 11 == questInfoWrapper:getQuestType() or questInfoWrapper:isOlviaAcademyPassType() == true then
    return
  end
  if true == isAccept then
    PaGlobal_QuestDirectAlert_All._ui.txt_title:SetFontColor(PaGlobal_QuestDirectAlert_All._fontColor[1])
    PaGlobal_QuestDirectAlert_All._ui.txt_title:SetText(PaGlobal_QuestDirectAlert_All._messageTitle[1])
    PaGlobal_QuestDirectAlert_All._ui.txt_desc:SetText(questInfoWrapper:getTitle())
    audioPostEvent_SystemUi(4, 0)
    _AudioPostEvent_SystemUiForXBOX(4, 0)
  else
    PaGlobal_QuestDirectAlert_All._ui.txt_title:SetFontColor(PaGlobal_QuestDirectAlert_All._fontColor[4])
    PaGlobal_QuestDirectAlert_All._ui.txt_title:SetText(PaGlobal_QuestDirectAlert_All._messageTitle[4])
    PaGlobal_QuestDirectAlert_All._ui.txt_desc:SetText(questInfoWrapper:getTitle())
    audioPostEvent_SystemUi(4, 2)
    _AudioPostEvent_SystemUiForXBOX(4, 2)
  end
  PaGlobal_QuestDirectAlert_All:open()
end
function FromClient_QuestDirectAlert_Update(questNoRaw)
  if questNoRaw == nil then
    return
  end
  local questData = ToClient_getProgressingQuestAtKey(questNoRaw)
  if questData == nil then
    return
  end
  if false == questData:isSpecialType() and false == questData:isSeasonPassType() and false == questData:isGrowthPassType() and 11 ~= questData:getQuestType() and questData:isOlviaAcademyPassType() == false then
    local questKey = questData:getKey()
    local prevCache = PaGlobal_QuestDirectAlert_All._questDataCache[questKey]
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
      if currentCache[demandIndex] ~= prevCache[demandIndex] then
        diffIndex = demandIndex
      end
    end
    if questNoRaw == questKey and -1 ~= diffIndex then
      local demand = questData:getDemandAt(diffIndex)
      if demand._destCount <= demand._currentCount then
        if true == isComplete then
          PaGlobal_QuestDirectAlert_All._ui.txt_title:SetFontColor(PaGlobal_QuestDirectAlert_All._fontColor[3])
          PaGlobal_QuestDirectAlert_All._ui.txt_title:SetText(PaGlobal_QuestDirectAlert_All._messageTitle[3])
          PaGlobal_QuestDirectAlert_All._ui.txt_desc:SetText(questData:getTitle())
          audioPostEvent_SystemUi(4, 2)
          _AudioPostEvent_SystemUiForXBOX(4, 2)
          if _ContentsGroup_QuestAcceptReinteraction == true and dialog_isTalking() == true and questData:getCompleteNpc():get() == dialog_getTalkNpcKey() then
            HandleEventLUp_DialogMain_All_BackClick()
          end
        else
          PaGlobal_QuestDirectAlert_All._ui.txt_title:SetFontColor(PaGlobal_QuestDirectAlert_All._fontColor[2])
          PaGlobal_QuestDirectAlert_All._ui.txt_title:SetText(PaGlobal_QuestDirectAlert_All._messageTitle[2])
          PaGlobal_QuestDirectAlert_All._ui.txt_desc:SetText(questData:getTitle())
        end
        PaGlobal_QuestDirectAlert_All:open()
      end
    end
    PaGlobal_QuestDirectAlert_All._questDataCache[questKey] = currentCache
  end
end
function FromClient_OnScreenResize_QuestDirectAlert()
  PaGlobal_QuestDirectAlert_All._screenSizeX = getScreenSizeX()
end
function PaGlobalFunc_QeustDirectAlert_UpdateFunc(deltaTime)
  PaGlobal_QuestDirectAlert_All._animateTime = PaGlobal_QuestDirectAlert_All._animateTime + deltaTime
  if PaGlobal_QuestDirectAlert_All._animateEndTime < PaGlobal_QuestDirectAlert_All._animateTime then
    PaGlobal_QuestDirectAlert_All._animateTime = 0
    PaGlobal_QuestDirectAlert_All:close()
  end
end
function PaGlobal_QuestDirectAlert_All_Init()
  PaGlobal_QuestDirectAlert_All._ui.txt_title:SetTextMode(__eTextMode_LimitText)
  PaGlobal_QuestDirectAlert_All._ui.txt_desc:SetTextMode(__eTextMode_Limit_AutoWrap)
  PaGlobal_QuestDirectAlert_All._ui.txt_desc:setLineCountByLimitAutoWrap(2)
  PaGlobal_QuestDirectAlert_All._screenSizeX = getScreenSizeX()
  PaGlobal_QuestDirectAlert_All:registEventHandler()
  PaGlobal_QuestDirectAlert_All:validate()
end
registerEvent("FromClient_luaLoadComplete", "PaGlobal_QuestDirectAlert_All_Init")
