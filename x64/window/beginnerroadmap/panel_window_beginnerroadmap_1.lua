function PaGlobal_BeginnerRoadMap:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_roadMapMain = UI.getChildControl(Panel_Window_BeginnerRoadmap, "Static_RealMain")
  self._originalRoadMapSizeX = self._ui._stc_roadMapMain:GetSizeX()
  self._originalRoadMapSizeY = self._ui._stc_roadMapMain:GetSizeY()
  self._ui._stc_roadMapMain:SetShow(_ContentsGroup_UseBeginnerRoadMap)
  self:initialize_topArea()
  self:initialize_centerFrameArea()
  self:initialize_bottomTooltipArea()
  self:loadAndMakeLayout()
  HandleEventLUp_RoadMap_ShowDetailTolltip(0)
  self:registEventHandler()
  self:validate()
  FromClient_BlackspiritPassAndRoadMap_ResizePanel()
  self._initialize = true
end
function PaGlobal_BeginnerRoadMap:initialize_topArea()
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  self._ui._stc_roadMapTopArea = UI.getChildControl(self._ui._stc_roadMapMain, "Static_Category_Roadmap")
  local playLoadMapBg = UI.getChildControl(self._ui._stc_roadMapTopArea, "Static_SlotBG")
  self._ui._stc_roadMapPlayTime = UI.getChildControl(playLoadMapBg, "StaticText_NeedCount")
  self._ui._btn_roadMapClose = UI.getChildControl(self._ui._stc_roadMapTopArea, "Button_Close")
  self._ui._stc_roadMapClose_Console = UI.getChildControl(self._ui._stc_roadMapTopArea, "StaticText_Close_Console")
  local helpBg = UI.getChildControl(self._ui._stc_roadMapTopArea, "Static_SeasonMap_Loona")
  local loonaHelpButton = UI.getChildControl(helpBg, "Button_Loona_Icon")
  helpBg:addInputEvent("Mouse_LUp", "HandleEventLUp_RoadMap_HelpChat()")
  loonaHelpButton:addInputEvent("Mouse_LUp", "HandleEventLUp_RoadMap_HelpChat()")
  if self._isConsole == true then
    self._ui._stc_roadMapClose_Console:SetShow(true)
    self._ui._btn_roadMapClose:SetShow(false)
  else
    self._ui._stc_roadMapClose_Console:SetShow(false)
    self._ui._btn_roadMapClose:SetShow(true)
    self._ui._btn_roadMapClose:addInputEvent("Mouse_LUp", "PaGlobalFunc_SeasonPassAndRoadMap_Close()")
  end
end
function PaGlobal_BeginnerRoadMap:initialize_centerFrameArea()
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  self._ui._frm_roadMap = UI.getChildControl(self._ui._stc_roadMapMain, "Frame_RoadMap")
  self._ui._frm_content_roadMap = UI.getChildControl(self._ui._frm_roadMap, "Frame_RoadMap_Content")
  self._ui._stc_frameCenterLine = UI.getChildControl(self._ui._frm_content_roadMap, "Static_Line")
end
function PaGlobal_BeginnerRoadMap:initialize_bottomTooltipArea()
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  self._ui._stc_roadMapDetailTooltip = UI.getChildControl(self._ui._stc_roadMapMain, "Static_Tooltip_BG")
  self._ui._stc_roadMapTooltipTitle = UI.getChildControl(self._ui._stc_roadMapDetailTooltip, "StaticText_Tooltip_Title")
  self._ui._stc_roadMapTooltipDesc = UI.getChildControl(self._ui._stc_roadMapDetailTooltip, "StaticText_Tooltip_Desc")
  self._ui._btn_roadMapTooltipEvent = UI.getChildControl(self._ui._stc_roadMapDetailTooltip, "Button_Event")
  self._ui._btn_roadMapTooltipAdventureNote = UI.getChildControl(self._ui._stc_roadMapDetailTooltip, "Button_OpenAdventureNote")
end
function PaGlobal_BeginnerRoadMap:loadAndMakeLayout()
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  if _ContentsGroup_UseBeginnerRoadMap == false then
    return
  end
  local template_box = UI.getChildControl(self._ui._frm_content_roadMap, "Roadmap_Box_Template")
  local template_line_up = UI.getChildControl(self._ui._frm_content_roadMap, "Static_Line_Top_Template")
  local template_line_down = UI.getChildControl(self._ui._frm_content_roadMap, "Static_Line_Bottom_Template")
  local lastClonedControl
  local roadMapDataCount = ToClient_getBeginnerRoadMapDataCount()
  for index = 0, roadMapDataCount - 1 do
    local roadMapDataKey = ToClient_getBeginnerRoadMapDataKey(index)
    local roadMapDataSSW = ToClient_getBeginnerRoadMapStaticStatusWrapper(roadMapDataKey)
    if roadMapDataSSW ~= nil then
      local cloneControl = UI.cloneControl(template_box, self._ui._frm_content_roadMap, "Button_RoadMap_Data_" .. tostring(index))
      if cloneControl ~= nil then
        local stc_backGroundTexture = UI.getChildControl(cloneControl, "Static_Slot_BG")
        local stc_characterTexture = UI.getChildControl(cloneControl, "Static_Slot_CharacterImage")
        local stc_icon = UI.getChildControl(cloneControl, "Static_Roadmap_Icon")
        local stc_title = UI.getChildControl(cloneControl, "StaticText_Roadmap_Title")
        local stc_desc = UI.getChildControl(cloneControl, "StaticText_Roadmap_Desc")
        stc_backGroundTexture:ChangeTextureInfoTextureIDAsync(roadMapDataSSW:getBackGroundTextureId(), 0)
        stc_backGroundTexture:ChangeTextureInfoTextureIDAsync(roadMapDataSSW:getBackGroundTextureId() .. "_Over", 1)
        stc_backGroundTexture:ChangeTextureInfoTextureIDAsync(roadMapDataSSW:getBackGroundTextureId() .. "_Click", 2)
        stc_backGroundTexture:setRenderTexture(stc_backGroundTexture:getBaseTexture())
        stc_characterTexture:ChangeTextureInfoTextureIDAsync(roadMapDataSSW:getCharacterTextureId())
        stc_characterTexture:setRenderTexture(stc_characterTexture:getBaseTexture())
        stc_icon:ChangeTextureInfoTextureIDAsync(roadMapDataSSW:getIconTextureId())
        stc_icon:setRenderTexture(stc_icon:getBaseTexture())
        stc_title:SetTextMode(__eTextMode_LimitText)
        stc_title:SetText(roadMapDataSSW:getTitle())
        stc_desc:SetTextMode(__eTextMode_Limit_AutoWrap)
        stc_desc:setLineCountByLimitAutoWrap(5)
        stc_desc:SetText(roadMapDataSSW:getDesc())
        stc_backGroundTexture:addInputEvent("Mouse_On", "PaGlobalFunc_BlackspiritPass_SetSnapFocus(false)")
        stc_backGroundTexture:addInputEvent("Mouse_LUp", "HandleEventLUp_RoadMap_ShowDetailTolltip(" .. tostring(index) .. ")")
        local gapX = 50
        local gapY = template_line_up:GetSizeY() + cloneControl:GetSizeY() / 2
        local beginSpanX = 30
        local newSpanX = beginSpanX + (cloneControl:GetSizeX() / 2 + gapX) * index
        local isUp = index % 2 == 0
        if isUp == true then
          cloneControl:SetSpanSize(newSpanX, -gapY)
        else
          cloneControl:SetSpanSize(newSpanX, gapY)
        end
        cloneControl:ComputePos()
        cloneControl:SetShow(true)
        local newLineControl
        if isUp == true then
          newLineControl = UI.cloneControl(template_line_up, self._ui._frm_content_roadMap, "Static_RoadMap_Line_Up_" .. tostring(index))
        else
          newLineControl = UI.cloneControl(template_line_down, self._ui._frm_content_roadMap, "Static_RoadMap_Line_Up_" .. tostring(index))
        end
        if newLineControl ~= nil then
          local newLineSpanX = newSpanX + cloneControl:GetSizeX() / 2 - newLineControl:GetSizeX() / 2
          newLineControl:SetSpanSize(newLineSpanX, newLineControl:GetSpanSize().y)
          newLineControl:ComputePos()
          newLineControl:SetShow(true)
        end
        lastClonedControl = cloneControl
      end
    end
  end
  if lastClonedControl ~= nil then
    local lastSpanX = lastClonedControl:GetSpanSize().x
    local lastWidgetSizeX = lastClonedControl:GetSizeX()
    local line_left = UI.getChildControl(self._ui._stc_frameCenterLine, "Static_Line_Left")
    local line_middle = UI.getChildControl(self._ui._stc_frameCenterLine, "Static_Line_Middle")
    local line_right = UI.getChildControl(self._ui._stc_frameCenterLine, "Static_Line_Right")
    self._ui._stc_frameCenterLine:SetSize(lastSpanX + lastWidgetSizeX + line_left:GetSpanSize().x, self._ui._stc_frameCenterLine:GetSizeY())
    local newMiddleLineSizeX = self._ui._stc_frameCenterLine:GetSizeX() - line_left:GetSpanSize().x - line_left:GetSizeX() - line_right:GetSpanSize().x - line_right:GetSizeX()
    line_middle:SetSize(newMiddleLineSizeX, line_middle:GetSizeY())
    line_left:ComputePos()
    line_middle:ComputePos()
    line_right:ComputePos()
    self._ui._frm_content_roadMap:SetSize(self._ui._stc_frameCenterLine:GetSizeX(), self._ui._frm_content_roadMap:GetSizeY())
    self._ui._frm_content_roadMap:ComputePos()
  end
  self._ui._frm_roadMap:GetHScroll():SetControlPos(0)
  self._ui._frm_roadMap:GetHScroll():SetInterval(10)
  self._ui._frm_roadMap:UpdateContentPos()
  UI.deleteControl(template_box)
  UI.deleteControl(template_line_up)
  UI.deleteControl(template_line_down)
end
function PaGlobal_BeginnerRoadMap:registEventHandler()
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_BlackspiritPassAndRoadMap_ResizePanel")
  Panel_Window_BeginnerRoadmap:RegisterShowEventFunc(true, "PaGlobalFunc_SeasonPassAndRoadMap_ShowEvent()")
  Panel_Window_BeginnerRoadmap:RegisterShowEventFunc(false, "PaGlobalFunc_SeasonPassAndRoadMap_HideEvent()")
end
function PaGlobal_BeginnerRoadMap:prepareOpen()
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  local selfPlayerActorProxy = getSelfPlayer()
  if selfPlayerActorProxy == nil then
    return
  end
  local selfPlayer = selfPlayerActorProxy:get()
  if selfPlayer == nil then
    return
  end
  if Panel_Window_StackExtraction_All ~= nil and Panel_Window_StackExtraction_All:GetShow() == true then
    return
  end
  local doShowAnimation = false
  local isSeasonCharacter = selfPlayer:isSeasonCharacter()
  if isSeasonCharacter == true then
    doShowAnimation = PaGlobal_BlackspiritPass_Open()
  else
    if PaGlobal_BlackspiritPass_GetShow() == true then
      PaGlobal_BlackspiritPass_Close()
    end
    if _ContentsGroup_UseBeginnerRoadMap == false then
      return
    end
    PaGlobalFunc_BeginnerRoadMap_Open(true)
  end
  self:open(doShowAnimation)
end
function PaGlobal_BeginnerRoadMap:open(doShowAnimation)
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  if ToClient_isConsole() == true then
    local uioffset = ToClient_GetConsoleUIOffset()
    local resizedRatioX = getScreenSizeX() * uioffset
    local resizedRatioY = getScreenSizeY() * uioffset
    Panel_Window_BeginnerRoadmap:SetPosX(Panel_Window_BeginnerRoadmap:GetPosX() + resizedRatioX)
    Panel_Window_BeginnerRoadmap:SetPosY(Panel_Window_BeginnerRoadmap:GetPosY() + resizedRatioY)
  end
  if doShowAnimation == true then
    local seasonPassArea = UI.getChildControl(Panel_Window_BeginnerRoadmap, "Static_BlackspiritPass")
    Panel_Window_BeginnerRoadmap:SetPosX(Panel_Window_BeginnerRoadmap:GetPosX() - seasonPassArea:GetSizeX())
  end
  Panel_Window_BeginnerRoadmap:SetShow(true, doShowAnimation)
end
function PaGlobal_BeginnerRoadMap:prepareClose(isSeasonPassDontHideAnimation)
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  local selfPlayerActorProxy = getSelfPlayer()
  if selfPlayerActorProxy == nil then
    return
  end
  local selfPlayer = selfPlayerActorProxy:get()
  if selfPlayer == nil then
    return
  end
  local doShowAnimation = false
  local isSeasonCharacter = selfPlayer:isSeasonCharacter()
  if isSeasonCharacter == true then
    doShowAnimation = PaGlobal_BlackspiritPass_Close()
  else
    PaGlobalFunc_BeginnerRoadMap_Close()
  end
  if isSeasonPassDontHideAnimation ~= nil and isSeasonPassDontHideAnimation == true then
    doShowAnimation = false
  end
  self:close(doShowAnimation)
end
function PaGlobal_BeginnerRoadMap:close(doShowAnimation)
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  Panel_Window_BeginnerRoadmap:SetShow(false, doShowAnimation)
end
function PaGlobal_BeginnerRoadMap:roadMap_open(isFullScreenMode)
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  local currentFrameScrollPos = self._ui._frm_roadMap:GetHScroll():GetControlPos()
  if isFullScreenMode == true then
    local consoleUIOffset = 1
    if ToClient_isConsole() == true then
      consoleUIOffset = ToClient_GetConsoleUIOffset()
    end
    local screenSizeX = getScreenSizeX() * consoleUIOffset + 1
    local screenSizeY = getScreenSizeY() * consoleUIOffset
    self._ui._stc_roadMapMain:SetSize(screenSizeX, screenSizeY)
    self._ui._stc_roadMapTopArea:SetSpanSize(self._ui._stc_roadMapTopArea:GetSpanSize().x, 0)
    self._ui._stc_roadMapTopArea:SetSize(screenSizeX, self._ui._stc_roadMapTopArea:GetSizeY())
    self._ui._frm_roadMap:SetSize(screenSizeX, self._ui._frm_roadMap:GetSizeY())
    self._ui._stc_roadMapDetailTooltip:SetSize(screenSizeX, self._ui._stc_roadMapDetailTooltip:GetSizeY())
  else
    self._ui._stc_roadMapMain:SetSize(self._originalRoadMapSizeX, self._originalRoadMapSizeY)
    self._ui._stc_roadMapTopArea:SetSpanSize(self._ui._stc_roadMapTopArea:GetSpanSize().x, 15)
    self._ui._stc_roadMapTopArea:SetSize(self._originalRoadMapSizeX, self._ui._stc_roadMapTopArea:GetSizeY())
    self._ui._frm_roadMap:SetSize(self._originalRoadMapSizeX, self._ui._frm_roadMap:GetSizeY())
    self._ui._stc_roadMapDetailTooltip:SetSize(self._originalRoadMapSizeX, self._ui._stc_roadMapDetailTooltip:GetSizeY())
  end
  self._ui._stc_roadMapMain:ComputePos()
  self._ui._stc_roadMapTopArea:ComputePosAllChild()
  self._ui._frm_roadMap:ComputePosAllChild()
  self._ui._stc_roadMapDetailTooltip:ComputePosAllChild()
  self._ui._frm_roadMap:GetHScroll():SetControlPos(currentFrameScrollPos)
  self._ui._frm_roadMap:UpdateContentPos()
  self:updatePlayTime()
  self._ui._stc_roadMapMain:SetShow(true)
end
function PaGlobal_BeginnerRoadMap:roadMap_close()
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  self._ui._stc_roadMapMain:SetShow(false)
end
function PaGlobal_BeginnerRoadMap:validate()
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  self._ui._stc_roadMapMain:isValidate()
  self._ui._stc_roadMapTopArea:isValidate()
  self._ui._stc_roadMapPlayTime:isValidate()
  self._ui._btn_roadMapClose:isValidate()
  self._ui._stc_roadMapClose_Console:isValidate()
  self._ui._frm_roadMap:isValidate()
  self._ui._frm_content_roadMap:isValidate()
  self._ui._stc_frameCenterLine:isValidate()
  self._ui._stc_roadMapDetailTooltip:isValidate()
  self._ui._stc_roadMapTooltipTitle:isValidate()
  self._ui._stc_roadMapTooltipDesc:isValidate()
  self._ui._btn_roadMapTooltipEvent:isValidate()
  self._ui._btn_roadMapTooltipAdventureNote:isValidate()
end
function PaGlobal_BeginnerRoadMap:updatePlayTime()
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  local totalPlayTime = Util.Time.timeFormatting_Minute(Int64toInt32(ToClient_GetCharacterPlayTime()))
  self._ui._stc_roadMapPlayTime:SetFontColor(Defines.Color.C_FFF5BA3A)
  self._ui._stc_roadMapPlayTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PLAYROADMAP_START_ADVENTUR", "time", totalPlayTime))
  self._ui._stc_roadMapPlayTime:SetSize(self._ui._stc_roadMapPlayTime:GetTextSizeX(), self._ui._stc_roadMapPlayTime:GetSizeY())
end
function PaGlobal_BeginnerRoadMap:updateDetailToolip(index)
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  local roadMapDataKey = ToClient_getBeginnerRoadMapDataKey(index)
  local roadMapDataSSW = ToClient_getBeginnerRoadMapStaticStatusWrapper(roadMapDataKey)
  if roadMapDataSSW == nil then
    self._ui._stc_roadMapDetailTooltip:SetShow(false)
    return
  end
  if self._ui._stc_roadMapDetailTooltip:GetShow() == false then
    self._ui._stc_roadMapDetailTooltip:SetShow(true)
  end
  self._ui._stc_roadMapTooltipTitle:SetTextMode(__eTextMode_LimitText)
  self._ui._stc_roadMapTooltipTitle:SetText(roadMapDataSSW:getTitle())
  self._ui._stc_roadMapTooltipDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
  self._ui._stc_roadMapTooltipDesc:setLineCountByLimitAutoWrap(4)
  self._ui._stc_roadMapTooltipDesc:SetText(roadMapDataSSW:getDesc())
  if roadMapDataSSW:isHaveEvent() == true then
    self._ui._btn_roadMapTooltipEvent:SetShow(true)
    self._ui._btn_roadMapTooltipEvent:addInputEvent("Mouse_LUp", "HandleEventLUp_RoadMap_ClickEventButtom(" .. tostring(index) .. ")")
    local stc_eventName = UI.getChildControl(self._ui._btn_roadMapTooltipEvent, "StaticText_EventName")
    stc_eventName:SetText(roadMapDataSSW:getEventName())
  else
    self._ui._btn_roadMapTooltipEvent:SetShow(false)
    self._ui._btn_roadMapTooltipEvent:addInputEvent("Mouse_LUp", "")
  end
  if self._ui._btn_roadMapTooltipEvent:GetShow() == true then
    self._ui._btn_roadMapTooltipAdventureNote:SetSpanSize(130, self._ui._btn_roadMapTooltipAdventureNote:GetSpanSize().y)
  else
    self._ui._btn_roadMapTooltipAdventureNote:SetSpanSize(0, self._ui._btn_roadMapTooltipAdventureNote:GetSpanSize().y)
  end
  local adventureNoteUrl = roadMapDataSSW:getAdventureNoteURL()
  if adventureNoteUrl == nil or adventureNoteUrl == "" then
    self._ui._btn_roadMapTooltipAdventureNote:SetMonoTone(true)
    self._ui._btn_roadMapTooltipAdventureNote:SetIgnore(true)
  else
    self._ui._btn_roadMapTooltipAdventureNote:SetMonoTone(false)
    self._ui._btn_roadMapTooltipAdventureNote:SetIgnore(false)
    self._ui._btn_roadMapTooltipAdventureNote:addInputEvent("Mouse_LUp", "HandleEventLUp_RoadMap_ClickAdventureNote(" .. tostring(index) .. ")")
  end
end
function PaGlobal_BeginnerRoadMap:processRoadMapEvent(index)
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  local roadMapDataKey = ToClient_getBeginnerRoadMapDataKey(index)
  local roadMapDataSSW = ToClient_getBeginnerRoadMapStaticStatusWrapper(roadMapDataKey)
  if roadMapDataSSW == nil then
    return
  end
  if roadMapDataSSW:isHaveEvent() == false then
    return
  end
  local paramList = Array.new()
  local constParamCount = roadMapDataSSW:getEventParameterCount()
  for paramIndex = 0, constParamCount - 1 do
    paramList:push_back(roadMapDataSSW:getEventParameter(paramIndex))
  end
  local undefinedLoadMapEventParamValue = -1
  if paramList[1] == nil or paramList[1] == undefinedLoadMapEventParamValue then
    UI.ASSERT_NAME(false, "\236\157\180\235\178\164\237\138\184 \236\157\180\235\166\132\236\157\128 \236\160\149\236\157\152\235\144\152\236\150\180 \236\158\136\235\138\148\235\141\176, \236\157\180\235\178\164\237\138\184 \237\150\137\236\156\132\235\138\148 \236\160\149\236\157\152\235\144\152\236\150\180 \236\158\136\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!", "\236\157\180\236\163\188")
    return
  end
  local eventCategory = paramList[1]
  if eventCategory == 1 then
    local targetUIIndex = paramList[2]
    if targetUIIndex == undefinedLoadMapEventParamValue then
      UI.ASSERT_NAME(false, "\236\150\180\235\138\144 UI\235\165\188 \236\151\180\236\150\180\236\149\188 \237\149\160\234\185\140\236\154\148?", "\236\157\180\236\163\188")
      return
    end
    if targetUIIndex == 1 then
      Process_UIMode_CommonWindow_QuestHistory()
      HandleEventLUp_Quest_All_SetTabMenu(PaGlobal_Quest_All._TABTYPE.MAIN)
    elseif targetUIIndex == 2 then
      PaGlobalFunc_SeasonPassAndRoadMap_Close()
      Process_UIMode_CommonWindow_BlackSpirit()
    else
      UI.ASSERT_NAME(false, "\235\161\156\235\147\156\235\167\181 UI \235\141\176\236\157\180\237\132\176\236\151\144\236\132\156 \237\138\185\236\160\149 UI\235\165\188 \236\151\180\236\150\180\236\163\188\235\138\148 \236\157\180\235\178\164\237\138\184\234\176\128 \236\182\148\234\176\128\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164. \237\148\132\235\161\156\234\183\184\235\158\168\237\140\128\236\151\144\236\132\156\235\143\132 \236\158\145\236\151\133\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
  elseif eventCategory == 2 then
  else
    UI.ASSERT_NAME(false, "\235\161\156\235\147\156\235\167\181 UI Event Parameter\236\157\152 \236\178\152\235\166\172 \234\179\188\236\160\149\236\157\132 \236\160\149\236\157\152\237\149\180\236\163\188\236\132\184\236\154\148. \235\141\176\236\157\180\237\132\176\235\167\140 \236\182\148\234\176\128\237\149\152\235\169\180 \236\149\136\235\144\169\235\139\136\235\139\164. \237\148\132\235\161\156\234\183\184\235\158\168\237\140\128\236\151\144\236\132\156\235\143\132 \236\158\145\236\151\133\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
end
