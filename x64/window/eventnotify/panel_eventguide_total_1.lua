function PaGlobal_EventGuide_Total:initialize()
  if self._initialize == true then
    return
  end
  self._ui.txt_mainBg = UI.getChildControl(Panel_EventGuide_Total, "StaticText_TotalEvent_Main_BG")
  self._ui.stc_contentBg = UI.getChildControl(self._ui.txt_mainBg, "Static_TotalEvent_ContentBG")
  self._ui.btn_Close = UI.getChildControl(UI.getChildControl(Panel_EventGuide_Total, "StaticText_TotalEvent_Title_BG"), "Button_Close_PCUI")
  self._ui.stc_eventBg = UI.getChildControl(self._ui.stc_contentBg, "Static_Event_BG")
  self._ui.stc_deco = UI.getChildControl(self._ui.stc_contentBg, "Static_Deco")
  self._ui.btn_forum = UI.getChildControl(self._ui.stc_contentBg, "Button_TotalEvent_Contents_ForumLink")
  self._ui.stc_icon = UI.getChildControl(self._ui.btn_forum, "Static_Icon")
  self._ui.txt_periodDesc = UI.getChildControl(self._ui.stc_contentBg, "Static_TotalEvent_ContentsTitle_BG")
  self._ui.txt_mainDesc = UI.getChildControl(self._ui.stc_contentBg, "StaticText_TotalEvent_Contents_Desc")
  self._ui.txt_subDesc = UI.getChildControl(self._ui.stc_contentBg, "StaticText_TotalEvent_Contents_Desc2")
  self._ui.stc_rewardBg = UI.getChildControl(self._ui.txt_mainBg, "Static_TotalEvent_RewardBG")
  self._ui.btn_rewardConfirm = UI.getChildControl(self._ui.stc_rewardBg, "Button_TotalEvent_RewardConfirm")
  self._ui.txt_rewardConfirm = UI.getChildControl(self._ui.btn_rewardConfirm, "StaticText_TotalEvent_RewardConfirm")
  self._ui.stc_rewardGroup = UI.getChildControl(self._ui.stc_rewardBg, "Static_TotalEvent_RewardGroup")
  self._ui.stc_rewardSlot = UI.getChildControl(self._ui.stc_rewardGroup, "Static_TotalEvent_RewardSlot")
  self._ui.stc_deco_left = UI.getChildControl(self._ui.stc_rewardGroup, "Static_Deco_Left")
  self._ui.stc_deco_right = UI.getChildControl(self._ui.stc_rewardGroup, "Static_Deco_Right")
  for index = 0, self._config.maxRewardSlotCount - 1 do
    local rewardSlot = UI.cloneControl(self._ui.stc_rewardSlot, self._ui.stc_rewardGroup, "Static_TotalEvent_RewardSlot_" .. index)
    rewardSlot:SetShow(false)
    local slot = {}
    SlotItem.new(slot, "EventReward_RewardIcon_" .. index, index, rewardSlot, self._rewardSlotConfig)
    slot:createChild()
    self._ui.rewardSlotList[index] = slot
  end
  self._ui.list2_totalEvent = UI.getChildControl(self._ui.txt_mainBg, "List2_TotalEvent")
  self._ui.list2_Content = UI.getChildControl(self._ui.list2_totalEvent, "List2_TotalEvent_Content")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_KeyGuide_Bg = UI.getChildControl(Panel_EventGuide_Total, "Static_TotalEvent_BottomBg_ConsoleUI")
  self._ui.btn_KeyGuide_A = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "Button_A_ConsoleUI")
  self._ui.btn_KeyGuide_B = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "Button_B_ConsoleUI")
  self._ui.btn_KeyGuide_X = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "Button_X_ConsoleUI")
  self._ui.btn_KeyGuide_Y = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "Button_Y_ConsoleUI")
  self:switchPlatForm(self._isConsole)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_EventGuide_Total:validate()
  self._ui.txt_mainBg:isValidate()
  self._ui.stc_contentBg:isValidate()
  self._ui.stc_eventBg:isValidate()
  self._ui.stc_deco:isValidate()
  self._ui.btn_forum:isValidate()
  self._ui.stc_icon:isValidate()
  self._ui.txt_periodDesc:isValidate()
  self._ui.txt_mainDesc:isValidate()
  self._ui.txt_subDesc:isValidate()
  self._ui.stc_rewardBg:isValidate()
  self._ui.btn_rewardConfirm:isValidate()
  self._ui.txt_rewardConfirm:isValidate()
  self._ui.stc_rewardGroup:isValidate()
  self._ui.stc_rewardSlot:isValidate()
  self._ui.stc_deco_left:isValidate()
  self._ui.stc_deco_right:isValidate()
  self._ui.list2_totalEvent:isValidate()
  self._ui.list2_Content:isValidate()
  if _ContentsGroup_UsePadSnapping == true then
    self._ui.stc_KeyGuide_Bg:isValidate()
    self._ui.btn_KeyGuide_A:isValidate()
    self._ui.btn_KeyGuide_B:isValidate()
    self._ui.btn_KeyGuide_X:isValidate()
    self._ui.btn_KeyGuide_Y:isValidate()
  end
end
function PaGlobal_EventGuide_Total:switchPlatForm(isConsole)
  if isConsole == false then
    return
  end
  self._ui.btn_forum:SetShow(not isConsole)
  self._ui.stc_KeyGuide_Bg:SetShow(isConsole)
  self._ui.btn_KeyGuide_A:SetShow(isConsole)
  self._ui.btn_KeyGuide_B:SetShow(isConsole)
  self._ui.btn_KeyGuide_X:SetShow(isConsole)
  self._ui.btn_KeyGuide_Y:SetShow(isConsole)
  local keyguide = {
    self._ui.btn_KeyGuide_A,
    self._ui.btn_KeyGuide_B,
    self._ui.btn_KeyGuide_X,
    self._ui.btn_KeyGuide_Y
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui.stc_KeyGuide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_EventGuide_Total:registEventHandler()
  registerEvent("FromClient_UpdateEventGuide_Total", "FromClient_EventGuide_Total_List2Update")
  registerEvent("FromClient_EventGuide_Total_OpenUI", "FromClient_EventGuide_Total_OpenUI")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_EventGuide_Total_Close()")
  self._ui.btn_forum:addInputEvent("Mouse_LUp", "HandleEventLUp_EventGuide_Total_Forum()")
  self._ui.btn_forum:addInputEvent("Mouse_On", "HandleEventOnOut_EventGuide_Total_ForumTooltip(true)")
  self._ui.btn_forum:addInputEvent("Mouse_Out", "HandleEventOnOut_EventGuide_Total_ForumTooltip(false)")
  self._ui.btn_rewardConfirm:addInputEvent("Mouse_LUp", "PaGlobal_EventGuide_Total:rewardConfirm()")
  self._ui.btn_rewardConfirm:addInputEvent("Mouse_On", "HandleEventOnOut_EventGuide_Total_FunctionTooltip(true)")
  self._ui.btn_rewardConfirm:addInputEvent("Mouse_Out", "HandleEventOnOut_EventGuide_Total_FunctionTooltip(false)")
  self._ui.txt_rewardConfirm:addInputEvent("Mouse_LUp", "PaGlobal_EventGuide_Total:rewardConfirm()")
  self._ui.list2_totalEvent:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_EventGuide_Total_List2Update")
  self._ui.list2_totalEvent:createChildContent(__ePAUIList2ElementManagerType_List)
  if self._isConsole == true then
    Panel_EventGuide_Total:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventLUp_EventGuide_Total_Forum()")
    Panel_EventGuide_Total:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobal_EventGuide_Total:rewardConfirm()")
  end
end
function PaGlobal_EventGuide_Total:prepareOpen()
  ToClient_RequestEventGuideOpen()
  self:updateEventList()
  self:updateMainPage()
  self:open()
end
function PaGlobal_EventGuide_Total:open()
  Panel_EventGuide_Total:SetShow(true)
end
function PaGlobal_EventGuide_Total:prepareClose()
  TooltipSimple_Hide()
  Panel_Tooltip_Item_hideTooltip()
  self:close()
end
function PaGlobal_EventGuide_Total:close()
  Panel_EventGuide_Total:SetShow(false)
end
function PaGlobal_EventGuide_Total:updateEventList()
  if Panel_EventGuide_Total == nil then
    return
  end
  self._ui.list2_totalEvent:getElementManager():clearKey()
  local eventGuideListCount = ToClient_RequestEventGuideCount()
  for index = 0, eventGuideListCount - 1 do
    local eventGuideSS = ToClient_RequestEventGuideAt(Int64toInt32(index))
    if eventGuideSS ~= nil and eventGuideSS:isEnd(getServerUtc64()) == false then
      self._ui.list2_totalEvent:getElementManager():pushKey(index)
    end
  end
end
function PaGlobal_EventGuide_Total:updateMainPage()
  if Panel_EventGuide_Total == nil then
    return
  end
  local eventGuideSS = ToClient_RequestEventGuideAt(self._currentPage)
  local textureBg = eventGuideSS:getTextureBg()
  local periodDesc = eventGuideSS:getPeriodDesc()
  local mainDesc = eventGuideSS:getMainDesc()
  local subDesc = eventGuideSS:getSubDesc()
  self._ui.stc_eventBg:ChangeTextureInfoTextureIDAsync(textureBg)
  self._ui.txt_periodDesc:SetText(periodDesc)
  local periodDescLen = math.min(self._ui.txt_periodDesc:GetTextSizeX() + 150, 890)
  self._ui.txt_periodDesc:SetSize(periodDescLen, self._ui.txt_periodDesc:GetSizeY())
  UI.setLimitTextAndAddTooltip(self._ui.txt_periodDesc, self._ui.txt_periodDesc:GetText())
  self._ui.txt_mainDesc:SetText(mainDesc)
  UI.setLimitTextAndAddTooltip(self._ui.txt_mainDesc, self._ui.txt_mainDesc:GetText())
  self._ui.txt_subDesc:SetText(subDesc)
  self._ui.stc_eventBg:setRenderTexture(self._ui.stc_eventBg:getBaseTexture())
  self:updateRewardGroup()
  if eventGuideSS:isFunctionEmpty() == true then
    self._ui.btn_rewardConfirm:SetShow(false)
    self._ui.btn_KeyGuide_Y:SetShow(false)
  else
    self._ui.btn_rewardConfirm:SetShow(true)
    self._ui.txt_rewardConfirm:SetText(eventGuideSS:getFunctionDesc())
    UI.setLimitTextAndAddTooltip(self._ui.txt_rewardConfirm, self._ui.txt_rewardConfirm:GetText())
    self._ui.btn_KeyGuide_Y:SetShow(true)
    self._ui.btn_KeyGuide_Y:SetText(eventGuideSS:getFunctionDesc())
  end
  local keyguide = {
    self._ui.btn_KeyGuide_A,
    self._ui.btn_KeyGuide_B,
    self._ui.btn_KeyGuide_X,
    self._ui.btn_KeyGuide_Y
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui.stc_KeyGuide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  if eventGuideSS:isWebKeywordEmpty() == false or _ContentsOption_CH_GameType == true then
    self._ui.btn_forum:SetShow(true)
  else
    self._ui.btn_forum:SetShow(false)
  end
  for ii = 0, 11 do
    local content = UI.getChildControl(self._ui.list2_totalEvent, "List2_TotalEvent_Content_" .. ii)
    if content ~= nil then
      local chk_event = UI.getChildControl(content, "Static_TotalEvent_Content")
      local txt_eventTitle = UI.getChildControl(chk_event, "StaticText_Event_Name")
      if txt_eventTitle ~= nil then
        if txt_eventTitle:GetText() == eventGuideSS:getMainTitle() then
          chk_event:setRenderTexture(chk_event:getClickTexture())
        else
          chk_event:setRenderTexture(chk_event:getBaseTexture())
        end
      end
    end
  end
end
function PaGlobal_EventGuide_Total:updateRewardGroup()
  if Panel_EventGuide_Total == nil then
    return
  end
  local eventGuideSS = ToClient_RequestEventGuideAt(self._currentPage)
  local rewardCount = math.min(eventGuideSS:getRewardCount(), self._config.maxRewardSlotCount)
  if rewardCount == 0 then
    self._ui.stc_rewardGroup:SetShow(false)
  else
    self._ui.stc_rewardGroup:SetShow(true)
  end
  for index = 0, rewardCount - 1 do
    local rewardItemKey = eventGuideSS:getRewardAt(index)
    local itemEnchantKey = ItemEnchantKey(rewardItemKey, 0)
    local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
    local rewardSlot = UI.getChildControl(self._ui.stc_rewardGroup, "Static_TotalEvent_RewardSlot_" .. index)
    local icon = self._ui.rewardSlotList[index].icon
    icon:ChangeTextureInfoNameAsync("Icon/" .. itemSSW:getIconPath())
    icon:setRenderTexture(icon:getBaseTexture())
    SlotItem:setItemBorder(self._ui.rewardSlotList[index].border, itemSSW:getGradeType())
    local rewardName = UI.getChildControl(rewardSlot, "StaticText_TotalEvent_RewardName")
    rewardName:SetText(itemSSW:getName())
    local posX, posY = 0, 0
    local offset = (self._ui.stc_rewardGroup:GetSizeX() + 40) / (rewardCount + 1)
    posX = -40 + (index + 1) * offset
    rewardSlot:SetPosX(posX)
    if index == 0 then
      self._ui.stc_deco_left:SetPosX(posX - 170)
    end
    if index == rewardCount - 1 then
      self._ui.stc_deco_right:SetPosX(posX + 100)
    end
    if rewardCount > 4 then
      self._ui.stc_deco_left:SetShow(false)
      self._ui.stc_deco_right:SetShow(false)
      rewardName:SetSize(100, 50)
      rewardName:SetSpanSize(0, -50)
    else
      self._ui.stc_deco_left:SetShow(true)
      self._ui.stc_deco_right:SetShow(true)
      rewardName:SetSize(160, 50)
      rewardName:SetSpanSize(rewardName:GetSpanSize().x, -50)
    end
    UI.setLimitTextAndAddTooltip(rewardName, rewardName:GetText())
    icon:addInputEvent("Mouse_On", "HandleEventOnOut_EventGuide_Total_ItemTooltip(" .. index .. "," .. rewardItemKey .. ",true)")
    icon:addInputEvent("Mouse_Out", "HandleEventOnOut_EventGuide_Total_ItemTooltip(" .. index .. "," .. rewardItemKey .. ",false)")
    Panel_Tooltip_Item_SetPosition(index, self._ui.rewardSlotList[index], "eventGuideReward")
    rewardSlot:SetShow(true)
  end
  for index = rewardCount, self._config.maxRewardSlotCount - 1 do
    local rewardSlot = UI.getChildControl(self._ui.stc_rewardGroup, "Static_TotalEvent_RewardSlot_" .. index)
    local icon = self._ui.rewardSlotList[index].icon
    icon:removeInputEvent("Mouse_On")
    icon:removeInputEvent("Mouse_Out")
    rewardSlot:SetShow(false)
  end
end
function PaGlobal_EventGuide_Total:rewardConfirm()
  ToClient_RequestEventGuideFunctionAt(self._currentPage)
end
