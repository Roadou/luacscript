function PaGlobal_MorningLand_QuestBoard_All:initialize()
  if PaGlobal_MorningLand_QuestBoard_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local titleArea = UI.getChildControl(Panel_MorningLand_QuestBoard_All, "Static_TitleArea")
  self._ui.stc_Title = UI.getChildControl(titleArea, "StaticText_Title")
  self._ui_pc.btn_Close = UI.getChildControl(titleArea, "Button_Close_PCUI")
  self._ui_pc.btn_Question = UI.getChildControl(titleArea, "Button_Question_PCUI")
  local scrollArea = UI.getChildControl(Panel_MorningLand_QuestBoard_All, "Static_ScrollArea")
  local frame = UI.getChildControl(scrollArea, "Frame_1_Content")
  self._ui.stc_Effect = UI.getChildControl(frame, "Static_AddEffect")
  self._ui.btn_Scroll_L = UI.getChildControl(frame, "Button_Scroll_L")
  self._ui.btn_Scroll_R = UI.getChildControl(frame, "Button_Scroll_R")
  self._ui_console.txt_KeyGuideL = UI.getChildControl(self._ui.btn_Scroll_L, "Static_KeyGuide_LB_ConsoleUI")
  self._ui_console.txt_KeyGuideR = UI.getChildControl(self._ui.btn_Scroll_R, "Static_KeyGuide_RB_ConsoleUI")
  self._ui.stc_QuestNormalArea = UI.getChildControl(frame, "Static_QuestNormalArea")
  local questNormalCanvas = UI.getChildControl(self._ui.stc_QuestNormalArea, "Static_QuestNormalCanvas")
  for index = 1, self._normalQuestCount do
    self._ui.btn_QuestNormal[index] = {}
    local normalInfo = self._ui.btn_QuestNormal[index]
    normalInfo.bg = UI.getChildControl(questNormalCanvas, "Button_QuestNormal_" .. tostring(index - 1))
    normalInfo.stc_complete = UI.getChildControl(normalInfo.bg, "Static_QuestComplete")
    normalInfo.txt_name = UI.getChildControl(normalInfo.bg, "StaticText_BossName")
    normalInfo.stcProgressBg = UI.getChildControl(normalInfo.bg, "Static_ProgressBG_0")
    normalInfo.stcProgress = UI.getChildControl(normalInfo.stcProgressBg, "Progress2_QuestProgress")
    normalInfo.stc_detail = UI.getChildControl(normalInfo.bg, "Button_Detail_View")
    normalInfo.stc_storyNameBG = UI.getChildControl(normalInfo.bg, "Static_StoryTitleBg")
    normalInfo.txt_storyName = UI.getChildControl(normalInfo.stc_storyNameBG, "StaticText_StoryTitle")
  end
  self._ui.stc_QuestHiddenArea = UI.getChildControl(frame, "Static_QuestHiddenArea")
  local questHiddenCanvas = UI.getChildControl(self._ui.stc_QuestHiddenArea, "Static_QuestHiddenCanvas")
  for index = 1, self._hoddenQuestCount do
    self._ui.btn_QuestHidden[index] = {}
    local hiddenInfo = self._ui.btn_QuestHidden[index]
    hiddenInfo.bg = UI.getChildControl(questHiddenCanvas, "Static_QuestHidden_" .. tostring(index - 1))
    hiddenInfo.stc_Texture = UI.getChildControl(hiddenInfo.bg, "Static_QuestVisual")
    hiddenInfo.stc_complete = UI.getChildControl(hiddenInfo.bg, "Static_QuestComplete")
    hiddenInfo.txt_name = UI.getChildControl(hiddenInfo.bg, "StaticText_BossName")
    hiddenInfo.stcProgressBg = UI.getChildControl(hiddenInfo.bg, "Static_ProgressBG_0")
    hiddenInfo.stcProgress = UI.getChildControl(hiddenInfo.stcProgressBg, "Progress2_QuestProgress")
    hiddenInfo.stc_detail = UI.getChildControl(hiddenInfo.bg, "Button_Detail_View")
    hiddenInfo.stc_storyNameBG = UI.getChildControl(hiddenInfo.bg, "Static_StoryTitleBg")
    hiddenInfo.txt_storyName = UI.getChildControl(hiddenInfo.stc_storyNameBG, "StaticText_StoryTitle")
    if index == 4 then
      hiddenInfo.hide = UI.getChildControl(hiddenInfo.bg, "Static_QuestVisual_Hidden")
    elseif index == 5 then
      hiddenInfo.epilogue = UI.getChildControl(hiddenInfo.bg, "StaticText_Epilogue")
      hiddenInfo.hide = UI.getChildControl(hiddenInfo.bg, "Static_QuestVisual_Hidden")
    end
  end
  local noticeBg = UI.getChildControl(Panel_MorningLand_QuestBoard_All, "Static_NoticeArea")
  self._ui.stc_NoticeBg = UI.getChildControl(noticeBg, "Static_NoticBG")
  self._ui.txt_Notice = UI.getChildControl(self._ui.stc_NoticeBg, "StaticText_Notice")
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(Panel_MorningLand_QuestBoard_All, "Static_KeyGuide_ConsoleUI_Import")
  self._ui_console.txt_KeyGuideA = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_A_ConsoleUI")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_B_ConsoleUI")
  self._isGameTypeKorea = isGameTypeKorea()
  PaGlobal_MorningLand_QuestBoard_All:validate()
  local baseNoticeSizeY = self._ui.txt_Notice:GetTextSizeY()
  self._ui.txt_Notice:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Notice:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING_QUESTBOARD_NOTICE"))
  local gap = self._ui.txt_Notice:GetTextSizeY() - baseNoticeSizeY
  self._ui.txt_Notice:SetSize(self._ui.txt_Notice:GetSizeX(), self._ui.txt_Notice:GetTextSizeY())
  self._ui.stc_NoticeBg:SetSize(self._ui.stc_NoticeBg:GetSizeX(), self._ui.txt_Notice:GetTextSizeY())
  self._ui.txt_Notice:ComputePos()
  Panel_MorningLand_QuestBoard_All:SetSize(Panel_MorningLand_QuestBoard_All:GetSizeX(), Panel_MorningLand_QuestBoard_All:GetSizeY() + gap)
  Panel_MorningLand_QuestBoard_All:ComputePosAllChild()
  PaGlobal_MorningLand_QuestBoard_All:changePlatform()
  PaGlobal_MorningLand_QuestBoard_All:registEventHandler()
  PaGlobal_MorningLand_QuestBoard_All._initialize = true
end
function PaGlobal_MorningLand_QuestBoard_All:changePlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
  self._ui_pc.btn_Question:SetShow(false)
  if _ContentsGroup_UsePadSnapping == true then
    local keyguides = {
      self._ui_console.txt_KeyGuideA,
      self._ui_console.txt_KeyGuideB
    }
    self._ui_console.stc_KeyGuideBG:SetShow(_ContentsGroup_UsePadSnapping)
    Panel_MorningLand_QuestBoard_All:SetScaleChild(0.85, 0.85)
    Panel_MorningLand_QuestBoard_All:ComputePosAllChild()
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, self._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_MorningLand_QuestBoard_All:registEventHandler()
  if Panel_MorningLand_QuestBoard_All == nil then
    return
  end
  self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_QuestBoard_All_Close()")
  self._ui.btn_Scroll_L:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_QuestBoard_All_UpdateQuestTab()")
  self._ui.btn_Scroll_R:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_QuestBoard_All_UpdateQuestTab()")
  Panel_MorningLand_QuestBoard_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_MorningLand_QuestBoard_All_Close()")
  Panel_MorningLand_QuestBoard_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_MorningLand_QuestBoard_All_UpdateQuestPadTab(true)")
  Panel_MorningLand_QuestBoard_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_MorningLand_QuestBoard_All_UpdateQuestPadTab(false)")
  registerEvent("executeLuaFunc", "PaGlobal_MorningLand_QuestBoard_All_ExecuteLuaFunc")
  registerEvent("EventQuestUpdateNotify", "PaGlobal_MorningLand_QuestBoard_All_CheckStamp")
end
function PaGlobal_MorningLand_QuestBoard_All:prepareOpen()
  if Panel_MorningLand_QuestBoard_All == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  self._ui.stc_Title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_TITLE", "charName", selfPlayer:getName()))
  self._selectTabType = self._eQuestTab.eNormal
  if PaGlobal_MorningLand_QuestBoard_All:isNormalQuestAllComplete() == true then
    self._ui.stc_QuestNormalArea:SetPosX(-1254)
    self._ui.stc_QuestHiddenArea:SetPosX(0)
    self._selectTabType = self._eQuestTab.eHidden
  else
    self._ui.stc_QuestNormalArea:SetPosX(0)
    self._ui.stc_QuestHiddenArea:SetPosX(1254)
    self._selectTabType = self._eQuestTab.eNormal
  end
  PaGlobal_MorningLand_QuestBoard_All:update()
  PaGlobal_MorningLand_QuestBoard_All:open()
  PaGlobal_MorningLand_QuestBoard_All:refreshSnapTarget()
end
function PaGlobal_MorningLand_QuestBoard_All:open()
  if Panel_MorningLand_QuestBoard_All == nil then
    return
  end
  Panel_MorningLand_QuestBoard_All:SetShow(true)
end
function PaGlobal_MorningLand_QuestBoard_All:prepareClose()
  if Panel_MorningLand_QuestBoard_All == nil then
    return
  end
  Panel_MorningLand_QuestBoard_All:ClearUpdateLuaFunc()
  PaGlobal_MorningLand_Scenario_All_Close()
  PaGlobal_MorningLand_QuestBoard_All:close()
end
function PaGlobal_MorningLand_QuestBoard_All:close()
  if Panel_MorningLand_QuestBoard_All == nil then
    return
  end
  Panel_MorningLand_QuestBoard_All:SetShow(false)
end
function PaGlobal_MorningLand_QuestBoard_All:showAni_Back(deltaTime)
  local move = self._speed * deltaTime
  self._ui.stc_QuestHiddenArea:SetPosX(self._ui.stc_QuestHiddenArea:GetPosX() + move)
  self._ui.stc_QuestNormalArea:SetPosX(self._ui.stc_QuestNormalArea:GetPosX() + move)
  if self._ui.stc_QuestNormalArea:GetPosX() >= 0 then
    Panel_MorningLand_QuestBoard_All:ClearUpdateLuaFunc()
    self._ui.stc_QuestNormalArea:SetPosX(0)
    self._ui.stc_QuestHiddenArea:SetPosX(1254)
    PaGlobal_MorningLand_QuestBoard_All:refreshSnapTarget()
  end
end
function PaGlobal_MorningLand_QuestBoard_All:refreshSnapTarget()
  if _ContentsGroup_UsePadSnapping == false then
    return
  end
  for index = 1, self._normalQuestCount do
    local normalInfo = self._ui.btn_QuestNormal[index]
    normalInfo.bg:SetIgnore(self._selectTabType ~= self._eQuestTab.eNormal)
  end
  for index = 1, self._hoddenQuestCount do
    local hiddenInfo = self._ui.btn_QuestHidden[index]
    hiddenInfo.stc_Texture:SetIgnore(self._selectTabType ~= self._eQuestTab.eHidden)
  end
  ToClient_padSnapResetControl()
  if self._ui.btn_QuestNormal[1] ~= nil and self._selectTabType == self._eQuestTab.eNormal then
    ToClient_padSnapChangeToTarget(self._ui.btn_QuestNormal[1].bg)
  end
  if self._ui.btn_QuestHidden[1] ~= nil and self._selectTabType == self._eQuestTab.eHidden then
    ToClient_padSnapChangeToTarget(self._ui.btn_QuestHidden[1].stc_Texture)
  end
end
function PaGlobal_MorningLand_QuestBoard_All:showAni_Next(deltaTime)
  local move = self._speed * deltaTime
  self._ui.stc_QuestHiddenArea:SetPosX(self._ui.stc_QuestHiddenArea:GetPosX() - move)
  self._ui.stc_QuestNormalArea:SetPosX(self._ui.stc_QuestNormalArea:GetPosX() - move)
  if self._ui.stc_QuestNormalArea:GetPosX() + self._ui.stc_QuestNormalArea:GetSizeX() <= 0 then
    Panel_MorningLand_QuestBoard_All:ClearUpdateLuaFunc()
    self._ui.stc_QuestNormalArea:SetPosX(-1254)
    self._ui.stc_QuestHiddenArea:SetPosX(0)
    PaGlobal_MorningLand_QuestBoard_All:refreshSnapTarget()
  end
end
function PaGlobal_MorningLand_QuestBoard_All_BackPageChangeAni(deltaTime)
  PaGlobal_MorningLand_QuestBoard_All:showAni_Back(deltaTime)
end
function PaGlobal_MorningLand_QuestBoard_All_NextPageChangeAni(deltaTime)
  PaGlobal_MorningLand_QuestBoard_All:showAni_Next(deltaTime)
end
function PaGlobal_MorningLand_QuestBoard_All:backPage()
  Panel_MorningLand_QuestBoard_All:RegisterUpdateFunc("PaGlobal_MorningLand_QuestBoard_All_BackPageChangeAni")
end
function PaGlobal_MorningLand_QuestBoard_All:nextPage()
  Panel_MorningLand_QuestBoard_All:RegisterUpdateFunc("PaGlobal_MorningLand_QuestBoard_All_NextPageChangeAni")
end
function PaGlobal_MorningLand_QuestBoard_All:updateQuestTab()
  if Panel_MorningLand_QuestBoard_All == nil then
    return
  end
  PaGlobal_MorningLand_Scenario_All_Close()
  self._selectTabType = math.floor((self._selectTabType + 1) % 2)
  if self._selectTabType == self._eQuestTab.eNormal then
    PaGlobal_MorningLand_QuestBoard_All:backPage()
  elseif self._selectTabType == self._eQuestTab.eHidden then
    PaGlobal_MorningLand_QuestBoard_All:nextPage()
  end
  PaGlobal_MorningLand_QuestBoard_All:update()
end
function PaGlobal_MorningLand_QuestBoard_All:updateQuestPadTab(isLeft)
  if Panel_MorningLand_QuestBoard_All == nil then
    return
  end
  if isLeft == false and PaGlobal_MorningLand_QuestBoard_All:isNormalQuestAllComplete() == false then
    return
  end
  PaGlobal_MorningLand_Scenario_All_Close()
  if self._selectTabType == self._eQuestTab.eNormal and isLeft == true then
    return
  elseif self._selectTabType == self._eQuestTab.eHidden and isLeft == false then
    return
  end
  self._selectTabType = math.floor((self._selectTabType + 1) % 2)
  if self._selectTabType == self._eQuestTab.eNormal then
    PaGlobal_MorningLand_QuestBoard_All:backPage()
  elseif self._selectTabType == self._eQuestTab.eHidden then
    PaGlobal_MorningLand_QuestBoard_All:nextPage()
  end
  PaGlobal_MorningLand_QuestBoard_All:update()
end
function PaGlobal_MorningLand_QuestBoard_All:update()
  if Panel_MorningLand_QuestBoard_All == nil then
    return
  end
  self._ui.stc_QuestNormalArea:SetShow(true)
  self._ui.stc_QuestHiddenArea:SetShow(true)
  self._ui.btn_Scroll_L:SetShow(false)
  self._ui.btn_Scroll_R:SetShow(false)
  self._ui.stc_QuestNormalArea:SetIgnore(true)
  self._ui.stc_QuestHiddenArea:SetIgnore(true)
  for index = 1, self._normalQuestCount do
    local normalInfo = self._ui.btn_QuestNormal[index]
    normalInfo.stc_detail:SetIgnore(true)
  end
  for index = 1, self._hoddenQuestCount do
    local hiddenInfo = self._ui.btn_QuestHidden[index]
    hiddenInfo.stc_detail:SetIgnore(true)
  end
  if self._selectTabType == self._eQuestTab.eNormal then
    self._ui.stc_QuestNormalArea:SetShow(true)
    self._ui.stc_QuestNormalArea:SetIgnore(false)
    if PaGlobal_MorningLand_QuestBoard_All:isNormalQuestAllComplete() == true then
      self._ui.btn_Scroll_R:SetShow(true)
    else
      self._ui.btn_Scroll_R:SetShow(false)
    end
    for index = 1, self._normalQuestCount do
      local normalInfo = self._ui.btn_QuestNormal[index]
      local progressPercent = PaGlobal_MorningLand_QuestBoard_All:getProgressPercent(index)
      local isComplete = false
      if progressPercent >= 100 then
        isComplete = true
      end
      normalInfo.bg:SetMonoTone(PaGlobal_MorningLand_QuestBoard_All:isMonoToneTexture(index))
      PaGlobal_MorningLand_QuestBoard_All:setTexture(index, progressPercent)
      normalInfo.stc_complete:SetShow(isComplete)
      normalInfo.bg:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_QuestBoard_All_OpenBookShelfQuest(" .. index .. "," .. tostring(self._normalInfo[index]._booKSelfGroupId) .. "," .. tostring(self._normalInfo[index]._booKSelfQuestId) .. ")")
      normalInfo.stc_complete:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_QuestBoard_All_OpenBookShelfQuest(" .. index .. "," .. tostring(self._normalInfo[index]._booKSelfGroupId) .. "," .. tostring(self._normalInfo[index]._booKSelfQuestId) .. ")")
      normalInfo.txt_name:SetShow(false)
      normalInfo.stcProgress:SetProgressRate(progressPercent)
      normalInfo.stc_detail:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Scenario_All_Open(" .. 1 .. "," .. tostring(index) .. ")")
      normalInfo.stcProgressBg:SetShow(not isComplete)
      normalInfo.stc_detail:SetShow(not isComplete)
      normalInfo.stc_detail:SetIgnore(false)
      normalInfo.bg:SetIgnore(not isComplete)
      normalInfo.stc_complete:EraseAllEffect()
      if self._stampQuest == self._normalPercentInfo[index]._groupId and isComplete == true then
        normalInfo.stc_complete:AddEffect("fUI_Stamp_01C", false, 0, 0)
        audioPostEvent_SystemUi(0, 23)
        _AudioPostEvent_SystemUiForXBOX(0, 23)
        self._stampQuest = 0
      end
      if self._isGameTypeKorea == false then
        if isComplete == false then
          normalInfo.bg:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Scenario_All_Open(" .. 1 .. "," .. tostring(index) .. ")")
          normalInfo.stc_complete:addInputEvent("Mouse_LUp", "")
        end
        normalInfo.bg:SetIgnore(false)
        normalInfo.stc_storyNameBG:SetShow(true)
        normalInfo.stc_complete:SetPosY(normalInfo.stc_storyNameBG:GetPosY() - normalInfo.stc_complete:GetSizeY())
        normalInfo.txt_storyName:SetTextMode(__eTextMode_AutoWrap)
        normalInfo.txt_storyName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGMAINPROGRESS_TITLE_" .. string.format("%02d", index)))
        normalInfo.txt_storyName:ComputePos()
        normalInfo.stc_detail:SetShow(false)
      end
    end
  elseif self._selectTabType == self._eQuestTab.eHidden then
    self._ui.stc_QuestHiddenArea:SetShow(true)
    self._ui.stc_QuestHiddenArea:SetIgnore(false)
    self._ui.btn_Scroll_L:SetShow(true)
    for index = 1, self._hoddenQuestCount do
      local hiddenInfo = self._ui.btn_QuestHidden[index]
      local progressPercent = PaGlobal_MorningLand_QuestBoard_All:getProgressPercent(index)
      local isComplete = false
      if progressPercent >= 100 then
        isComplete = true
      end
      hiddenInfo.bg:SetMonoTone(PaGlobal_MorningLand_QuestBoard_All:isMonoToneTexture(index))
      PaGlobal_MorningLand_QuestBoard_All:setTexture(index, progressPercent)
      hiddenInfo.stc_complete:SetShow(isComplete)
      hiddenInfo.bg:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_QuestBoard_All_OpenBookShelfQuest(" .. index .. "," .. tostring(self._hiddenInfo[index]._booKSelfGroupId) .. "," .. tostring(self._hiddenInfo[index]._booKSelfQuestId) .. ")")
      hiddenInfo.stc_Texture:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_QuestBoard_All_OpenBookShelfQuest(" .. index .. "," .. tostring(self._hiddenInfo[index]._booKSelfGroupId) .. "," .. tostring(self._hiddenInfo[index]._booKSelfQuestId) .. ")")
      hiddenInfo.stc_complete:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_QuestBoard_All_OpenBookShelfQuest(" .. index .. "," .. tostring(self._hiddenInfo[index]._booKSelfGroupId) .. "," .. tostring(self._hiddenInfo[index]._booKSelfQuestId) .. ")")
      hiddenInfo.txt_name:SetShow(false)
      hiddenInfo.stcProgress:SetProgressRate(progressPercent)
      hiddenInfo.stc_detail:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Scenario_All_Open(" .. 2 .. "," .. tostring(index) .. ")")
      hiddenInfo.stcProgressBg:SetShow(not isComplete)
      hiddenInfo.stc_complete:EraseAllEffect()
      local isShowName = true
      if index == 4 then
        local progressPercent = PaGlobal_MorningLand_QuestBoard_All:getProgressPercent(index - 1)
        if progressPercent >= 100 then
          hiddenInfo.hide:SetShow(false)
          hiddenInfo.stc_detail:SetShow(true)
          hiddenInfo.bg:SetMonoTone(false)
        else
          hiddenInfo.hide:SetShow(true)
          hiddenInfo.stc_detail:SetShow(false)
          hiddenInfo.bg:SetMonoTone(true)
          isShowName = false
        end
      elseif index == 5 then
        local progressPercent = PaGlobal_MorningLand_QuestBoard_All:getProgressPercent(index - 1)
        if progressPercent >= 100 then
          hiddenInfo.epilogue:SetShow(true)
          hiddenInfo.hide:SetShow(false)
          hiddenInfo.stc_detail:SetShow(true)
          hiddenInfo.bg:SetMonoTone(false)
        else
          hiddenInfo.epilogue:SetShow(false)
          hiddenInfo.hide:SetShow(true)
          hiddenInfo.stc_detail:SetShow(false)
          hiddenInfo.bg:SetMonoTone(true)
          isShowName = false
        end
      end
      hiddenInfo.stc_detail:SetShow(not isComplete)
      hiddenInfo.stc_detail:SetIgnore(false)
      if self._stampQuest == self._hiddenPercentInfo[index]._groupId and isComplete == true then
        hiddenInfo.stc_complete:AddEffect("fUI_Stamp_01B", false, 0, 0)
        audioPostEvent_SystemUi(0, 21)
        _AudioPostEvent_SystemUiForXBOX(0, 21)
        self._stampQuest = 0
      end
      if self._isGameTypeKorea == false then
        if isComplete == false then
          hiddenInfo.bg:removeInputEvent("Mouse_LUp")
          hiddenInfo.stc_Texture:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Scenario_All_Open(" .. 2 .. "," .. tostring(index) .. ")")
          hiddenInfo.stc_complete:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Scenario_All_Open(" .. 2 .. "," .. tostring(index) .. ")")
        end
        hiddenInfo.bg:SetIgnore(true)
        hiddenInfo.stc_storyNameBG:SetShow(isShowName)
        hiddenInfo.txt_storyName:SetTextMode(__eTextMode_AutoWrap)
        hiddenInfo.txt_storyName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGMAINPROGRESS_TITLE_" .. string.format("%02d", self._normalQuestCount + index)))
        hiddenInfo.txt_storyName:ComputePos()
        hiddenInfo.stc_detail:SetShow(false)
      end
    end
  end
end
function PaGlobal_MorningLand_QuestBoard_All:isNormalQuestAllComplete()
  for index = 1, self._normalQuestCount do
    local normalInfo = self._ui.btn_QuestNormal[index]
    local progressPercent = PaGlobal_MorningLand_QuestBoard_All:getProgressPercent(index)
    if progressPercent < 100 then
      return false
    end
  end
  return true
end
function PaGlobal_MorningLand_QuestBoard_All:isZeroPercentProgress()
  if self._selectTabType == self._eQuestTab.eNormal then
    for index = 1, self._normalQuestCount do
      local progressPercent = PaGlobal_MorningLand_QuestBoard_All:getProgressPercent(index)
      if progressPercent > 0 then
        return false
      end
      local groupId = self._normalPercentInfo[index]._groupId
      local questId = 1
      local uiQuestInfo = ToClient_GetQuestInfo(groupId, questId)
      if nil ~= uiQuestInfo and uiQuestInfo._isProgressing == true then
        return false
      end
    end
  elseif self._selectTabType == self._eQuestTab.eHidden then
    for index = 1, self._hoddenQuestCount do
      local progressPercent = PaGlobal_MorningLand_QuestBoard_All:getProgressPercent(index)
      if progressPercent > 0 then
        return false
      end
      local groupId = self._hiddenPercentInfo[index]._groupId
      local questId = 1
      local uiQuestInfo = ToClient_GetQuestInfo(groupId, questId)
      if nil ~= uiQuestInfo and uiQuestInfo._isProgressing == true then
        return false
      end
    end
  end
  return true
end
function PaGlobal_MorningLand_QuestBoard_All:isStartNewQuest()
  if self._selectTabType == self._eQuestTab.eNormal then
    for index = 1, self._normalQuestCount do
      local progressPercent = PaGlobal_MorningLand_QuestBoard_All:getProgressPercent(index)
      if progressPercent < 100 and progressPercent > 0 then
        return false
      end
      local groupId = self._normalPercentInfo[index]._groupId
      local questId = 1
      local uiQuestInfo = ToClient_GetQuestInfo(groupId, questId)
      if nil ~= uiQuestInfo and uiQuestInfo._isProgressing == true then
        return false
      end
    end
  elseif self._selectTabType == self._eQuestTab.eHidden then
    for index = 1, self._hoddenQuestCount do
      local progressPercent = PaGlobal_MorningLand_QuestBoard_All:getProgressPercent(index)
      if progressPercent < 100 and progressPercent > 0 then
        return false
      end
      local groupId = self._hiddenPercentInfo[index]._groupId
      local questId = 1
      local uiQuestInfo = ToClient_GetQuestInfo(groupId, questId)
      if nil ~= uiQuestInfo and uiQuestInfo._isProgressing == true then
        return false
      end
    end
  end
  return true
end
function PaGlobal_MorningLand_QuestBoard_All:isMonoToneTexture(index)
  if index == nil then
    return true
  end
  if PaGlobal_MorningLand_QuestBoard_All:isZeroPercentProgress() == true then
    return false
  end
  if PaGlobal_MorningLand_QuestBoard_All:isStartNewQuest() == true then
    return false
  end
  local progressPercent = PaGlobal_MorningLand_QuestBoard_All:getProgressPercent(index)
  if progressPercent > 0 then
    return false
  end
  if self._selectTabType == self._eQuestTab.eNormal then
    local groupId = self._normalPercentInfo[index]._groupId
    local questId = 1
    local uiQuestInfo = ToClient_GetQuestInfo(groupId, questId)
    if nil ~= uiQuestInfo and uiQuestInfo._isProgressing == true then
      return false
    end
  elseif self._selectTabType == self._eQuestTab.eHidden then
    local groupId = self._hiddenPercentInfo[index]._groupId
    local questId = 1
    local uiQuestInfo = ToClient_GetQuestInfo(groupId, questId)
    if nil ~= uiQuestInfo and uiQuestInfo._isProgressing == true then
      return false
    end
  end
  return true
end
function PaGlobal_MorningLand_QuestBoard_All:isHideNavi(index)
  if index == nil then
    return true
  end
  if PaGlobal_MorningLand_QuestBoard_All:isZeroPercentProgress() == true then
    return false
  end
  local progressPercent = PaGlobal_MorningLand_QuestBoard_All:getProgressPercent(index)
  if progressPercent >= 100 then
    return true
  end
  if PaGlobal_MorningLand_QuestBoard_All:isStartNewQuest() == true then
    return false
  end
  if progressPercent <= 0 then
    if self._selectTabType == self._eQuestTab.eNormal then
      local groupId = self._normalPercentInfo[index]._groupId
      local questId = 1
      local uiQuestInfo = ToClient_GetQuestInfo(groupId, questId)
      if nil ~= uiQuestInfo and uiQuestInfo._isProgressing == true then
        return false
      end
    elseif self._selectTabType == self._eQuestTab.eHidden then
      local groupId = self._hiddenPercentInfo[index]._groupId
      local questId = 1
      local uiQuestInfo = ToClient_GetQuestInfo(groupId, questId)
      if nil ~= uiQuestInfo and uiQuestInfo._isProgressing == true then
        return false
      end
    end
  end
  return true
end
function PaGlobal_MorningLand_QuestBoard_All:getProgressPercent(index)
  if index == nil then
    return 0
  end
  local percent = 0
  if self._selectTabType == self._eQuestTab.eNormal then
    if index <= 0 or index > self._normalQuestCount then
      return 0
    end
    local groupId = self._normalPercentInfo[index]._groupId
    for ii = 1, #self._normalPercentInfo[index].info do
      local questId = ii
      if questList_isClearQuest(groupId, questId) == true then
        percent = percent + self._normalPercentInfo[index].info[ii]
        if self._normalPercentInfo[index]._finalId == questId then
          percent = 100
        end
      end
    end
  elseif self._selectTabType == self._eQuestTab.eHidden then
    if index <= 0 or index > self._hoddenQuestCount then
      return 0
    end
    local groupId = self._hiddenPercentInfo[index]._groupId
    for ii = 1, #self._hiddenPercentInfo[index].info do
      local questId = ii
      if questList_isClearQuest(groupId, questId) == true then
        percent = percent + self._hiddenPercentInfo[index].info[ii]
        if self._hiddenPercentInfo[index]._finalId == questId then
          percent = 100
        end
      end
    end
  end
  return percent
end
function PaGlobal_MorningLand_QuestBoard_All:setTexture(index, progressPercent)
  if self._selectTabType == self._eQuestTab.eNormal then
    if index <= 0 or index > self._normalQuestCount then
      return
    end
    local groupId = self._normalPercentInfo[index]._groupId
    for jj = 1, #self._normalInfo[index]._completeUV do
      if progressPercent >= 100 and questList_isClearQuest(groupId, self._normalInfo[index]._completeUV[jj]._questId) == true then
        dds = self._normalInfo[index]._completeUV[jj]._dds
        baseUV = self._normalInfo[index]._completeUV[jj]._base
        onUV = self._normalInfo[index]._completeUV[jj]._on
        self._ui.btn_QuestNormal[index].bg:ChangeTextureInfoNameAsync(dds)
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui.btn_QuestNormal[index].bg, baseUV.x1, baseUV.y1, baseUV.x2, baseUV.y2)
        self._ui.btn_QuestNormal[index].bg:getBaseTexture():setUV(x1, y1, x2, y2)
        self._ui.btn_QuestNormal[index].bg:setRenderTexture(self._ui.btn_QuestNormal[index].bg:getBaseTexture())
        self._ui.btn_QuestNormal[index].bg:ChangeOnTextureInfoNameAsync(dds)
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui.btn_QuestNormal[index].bg, onUV.x1, onUV.y1, onUV.x2, onUV.y2)
        self._ui.btn_QuestNormal[index].bg:getOnTexture():setUV(x1, y1, x2, y2)
        self._ui.btn_QuestNormal[index].bg:ChangeClickTextureInfoNameAsync(dds)
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui.btn_QuestNormal[index].bg, onUV.x1, onUV.y1, onUV.x2, onUV.y2)
        self._ui.btn_QuestNormal[index].bg:getClickTexture():setUV(x1, y1, x2, y2)
        break
      end
    end
  elseif self._selectTabType == self._eQuestTab.eHidden then
    if index <= 0 or index > self._hoddenQuestCount then
      return
    end
    local groupId = self._hiddenPercentInfo[index]._groupId
    for jj = 1, #self._hiddenInfo[index]._completeUV do
      if progressPercent >= 100 and questList_isClearQuest(groupId, self._hiddenInfo[index]._completeUV[jj]._questId) == true then
        dds = self._hiddenInfo[index]._completeUV[jj]._dds
        baseUV = self._hiddenInfo[index]._completeUV[jj]._base
        onUV = self._hiddenInfo[index]._completeUV[jj]._on
        self._ui.btn_QuestHidden[index].stc_Texture:ChangeTextureInfoNameAsync(dds)
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui.btn_QuestHidden[index].stc_Texture, baseUV.x1, baseUV.y1, baseUV.x2, baseUV.y2)
        self._ui.btn_QuestHidden[index].stc_Texture:getBaseTexture():setUV(x1, y1, x2, y2)
        self._ui.btn_QuestHidden[index].stc_Texture:setRenderTexture(self._ui.btn_QuestHidden[index].stc_Texture:getBaseTexture())
        self._ui.btn_QuestHidden[index].stc_Texture:ChangeOnTextureInfoNameAsync(dds)
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui.btn_QuestHidden[index].stc_Texture, onUV.x1, onUV.y1, onUV.x2, onUV.y2)
        self._ui.btn_QuestHidden[index].stc_Texture:getOnTexture():setUV(x1, y1, x2, y2)
        self._ui.btn_QuestHidden[index].stc_Texture:ChangeClickTextureInfoNameAsync(dds)
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui.btn_QuestHidden[index].stc_Texture, onUV.x1, onUV.y1, onUV.x2, onUV.y2)
        self._ui.btn_QuestHidden[index].stc_Texture:getClickTexture():setUV(x1, y1, x2, y2)
        break
      end
    end
  end
end
function PaGlobal_MorningLand_QuestBoard_All:showNameToggle(isOn, index)
  if self._selectTabType == self._eQuestTab.eNormal then
    if index <= 0 or index > self._normalQuestCount then
      return
    end
    if isOn == false or self._isGameTypeKorea == true then
      self._ui.btn_QuestNormal[index].txt_name:SetShow(false)
      return
    end
    self._ui.btn_QuestNormal[index].txt_name:SetText(self._normalInfo[index]._name)
    self._ui.btn_QuestNormal[index].txt_name:SetShow(true)
  elseif self._selectTabType == self._eQuestTab.eHidden then
    if index <= 0 or index > self._hoddenQuestCount then
      return
    end
    if isOn == false or self._isGameTypeKorea == true then
      self._ui.btn_QuestHidden[index].txt_name:SetShow(false)
      return
    end
    self._ui.btn_QuestHidden[index].txt_name:SetText(self._hiddenInfo[index]._name)
    self._ui.btn_QuestHidden[index].txt_name:SetShow(true)
  end
end
function PaGlobal_MorningLand_QuestBoard_All:getFirstQuestNo(isNormal, index)
  if isNormal == nil or index == nil then
    return 0
  end
  if isNormal == true then
    local groupId = self._normalPercentInfo[index]._groupId
    for ii = 1, #self._normalPercentInfo[index].info do
      local questId = ii
      local uiQuestInfo = ToClient_GetQuestInfo(groupId, questId)
      if nil ~= uiQuestInfo then
        return ii
      end
    end
  else
    local groupId = self._hiddenPercentInfo[index]._groupId
    for ii = 1, #self._hiddenPercentInfo[index].info do
      local questId = ii
      local uiQuestInfo = ToClient_GetQuestInfo(groupId, questId)
      if nil ~= uiQuestInfo then
        return ii
      end
    end
  end
end
function PaGlobal_MorningLand_QuestBoard_All:isMorningQuestBordQuest(questGroupID)
  for ii = 1, #self._normalPercentInfo do
    if self._normalPercentInfo[ii]._groupId == questGroupID then
      return true
    end
  end
  for ii = 1, #self._hiddenPercentInfo do
    if self._hiddenPercentInfo[ii]._groupId == questGroupID then
      return true
    end
  end
  return false
end
function PaGlobal_MorningLand_QuestBoard_All:validate()
  if Panel_MorningLand_QuestBoard_All == nil then
    return
  end
end
