function PaGlobalFunc_EventGuide_Total_Open()
  local self = PaGlobal_EventGuide_Total
  self:prepareOpen()
  if Panel_Widget_Menu_Remake ~= nil then
    PaGlobal_Menu_Remake:prepareClose()
  end
end
function PaGlobalFunc_EventGuide_Total_Close()
  local self = PaGlobal_EventGuide_Total
  self:prepareClose()
end
function PaGlobal_EventGuide_Total_ListCreate_All()
  local self = PaGlobal_EventGuide_Total
  self:updateQuestList()
end
function FromClient_EventGuide_Total_List2Update(content, key)
  local self = PaGlobal_EventGuide_Total
  local key32 = Int64toInt32(key)
  local chk_event = UI.getChildControl(content, "Static_TotalEvent_Content")
  local txt_eventTitle = UI.getChildControl(chk_event, "StaticText_Event_Name")
  local stc_eventIcon = UI.getChildControl(chk_event, "Static_Event_Icon")
  local stc_selectBox = UI.getChildControl(content, "Static_Event_SelectBox")
  local eventGuideSS = ToClient_RequestEventGuideAt(key32)
  if eventGuideSS == nil then
    return
  end
  if key32 == self._currentPage then
    chk_event:setRenderTexture(chk_event:getClickTexture())
  else
    chk_event:setRenderTexture(chk_event:getBaseTexture())
  end
  local tag = eventGuideSS:getTag()
  if tag == __eEventGuideTag_Hot then
    UI.getChildControl(chk_event, "Static_HotTag"):SetShow(true)
    UI.getChildControl(chk_event, "Static_NewTag"):SetShow(false)
  elseif tag == __eEventGuideTag_New then
    UI.getChildControl(chk_event, "Static_HotTag"):SetShow(false)
    UI.getChildControl(chk_event, "Static_NewTag"):SetShow(true)
  else
    UI.getChildControl(chk_event, "Static_HotTag"):SetShow(false)
    UI.getChildControl(chk_event, "Static_NewTag"):SetShow(false)
  end
  stc_eventIcon:ChangeTextureInfoTextureIDAsync(eventGuideSS:getIcon())
  stc_eventIcon:setRenderTexture(stc_eventIcon:getBaseTexture())
  if eventGuideSS:onDeadLineAlert(getServerUtc64()) == true then
    UI.getChildControl(chk_event, "Static_Timer"):SetShow(true)
    txt_eventTitle:SetSpanSize(110, 0)
    txt_eventTitle:SetSize(270, 40)
    txt_eventTitle:SetEnableArea(0, 0, 270, 40)
  else
    UI.getChildControl(chk_event, "Static_Timer"):SetShow(false)
    txt_eventTitle:SetSpanSize(70, 0)
    txt_eventTitle:SetSize(310, 40)
    txt_eventTitle:SetEnableArea(0, 0, 310, 40)
  end
  txt_eventTitle:SetText(eventGuideSS:getMainTitle())
  UI.setLimitTextAndAddTooltip(txt_eventTitle, txt_eventTitle:GetText())
  txt_eventTitle:addInputEvent("Mouse_LUp", "HandleEventLUp_EventGuide_Total_UpdateMainPage(" .. key32 .. ")")
  stc_selectBox:addInputEvent("Mouse_LUp", "HandleEventLUp_EventGuide_Total_UpdateMainPage(" .. key32 .. ")")
end
function HandleEventLUp_EventGuide_Total_UpdateMainPage(index)
  local self = PaGlobal_EventGuide_Total
  if index < 0 then
    UI.ASSERT_NAME(false, "Event Guide Page\236\157\152 Index\235\138\148 \236\157\140\236\136\152\236\157\188 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164. (Index : " .. index .. ")", "\234\185\128\236\132\177\234\183\156")
  end
  self._oldSelectedIndex = self._selectedIndex
  self._currentPage = index
  self:updateMainPage()
end
function HandleEventLUp_EventGuide_Total_Forum()
  local self = PaGlobal_EventGuide_Total
  if _ContentsOption_CH_GameType == true then
    ToClient_OpenRailBrowser("https://bd.qq.com/cp/a20240715gwyqyy/activitycenter.html", 4)
    return
  end
  local eventGuideSS = ToClient_RequestEventGuideAt(self._currentPage)
  if eventGuideSS == nil then
    return
  end
  PaGlobalFunc_ExpirienceWiki_WebDetailDescLinkOpen(eventGuideSS:getWebKeyword(), eventGuideSS:getWebHashID())
end
function HandleEventOnOut_EventGuide_Total_ItemTooltip(index, rewardItemKey, isOn)
  local self = PaGlobal_EventGuide_Total
  if self == nil then
    return
  end
  if isOn == false or index == nil or rewardItemKey == nil then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemEnchantKey = ItemEnchantKey(rewardItemKey, 0)
  local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
  Panel_Tooltip_Item_Show(itemSSW, self._ui.rewardSlotList[index].icon, true, false)
end
function HandleEventOnOut_EventGuide_Total_ForumTooltip(isOn)
  local self = PaGlobal_EventGuide_Total
  if self == nil or control == nil then
    return
  end
  if isOn == true then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TOTAL_WEBPAGE_TITLE")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TOTAL_WEBPAGE_DESC")
    registTooltipControl(self._ui.btn_forum, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(self._ui.btn_forum, name, desc, false)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventOnOut_EventGuide_Total_FunctionTooltip(isOn)
  local self = PaGlobal_EventGuide_Total
  if self == nil or control == nil then
    return
  end
  if isOn == true then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TOTAL_WAYPOINT_TITLE")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TOTAL_WAYPOINT_DESC")
    registTooltipControl(self._ui.btn_rewardConfirm, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(self._ui.btn_rewardConfirm, name, desc, false)
  else
    TooltipSimple_Hide()
  end
end
function FromClient_EventGuide_Total_OpenUI(uiType)
  local stringLower = string.lower(uiType)
  if stringLower == "exchangecoin" then
    PaGlobalFunc_ExchangeCoin_All_Open()
  elseif stringLower == "challenge" then
    HandleEventLUp_MenuRemake_Present()
  elseif stringLower == "attendance" then
    PaGlobalFunc_Menu_All_DailyStamp_Open()
  elseif stringLower == "inventory" then
    HandleEventLUp_MenuRemake_Inventory()
  elseif stringLower == "cashshop" then
    HandleEventLUp_MenuRemake_CashShop()
  elseif stringLower == "specialpass" then
    PaGlobal_Event_SpecialPass_Open()
  elseif stringLower == "solare" then
    HandleEventLUp_MenuRemake_SolrareMatchingOpen()
  elseif stringLower == "redbattlefield" then
    HandleEventLUp_MenuRemake_Localwar()
  elseif stringLower == "horseracing" then
    FromClient_HorseRacingEnter_Open()
  elseif stringLower == "morninglandboss" then
    PaGlobal_MorningLand_Boss_All_Open()
  elseif stringLower == "newquest" then
    PaGlobalFunc_Quest_All_Open()
    HandleEventLUp_Quest_All_SetTabMenu(PaGlobal_Quest_All._TABTYPE.NEW)
  elseif stringLower == "recommendquest" then
    PaGlobalFunc_Quest_All_Open()
    HandleEventLUp_Quest_All_SetTabMenu(PaGlobal_Quest_All._TABTYPE.RECOMMEND)
  end
end
