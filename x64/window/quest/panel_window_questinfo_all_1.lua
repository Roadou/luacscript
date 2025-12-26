function PaGlobal_QuestInfo_All:initialize()
  if true == PaGlobal_QuestInfo_All._initialize then
    return
  end
  PaGlobal_QuestInfo_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_QuestInfo_All:ControlAll_Init()
  PaGlobal_QuestInfo_All:ControlPc_Init()
  PaGlobal_QuestInfo_All:ControlConsole_Init()
  PaGlobal_QuestInfo_All:ControlSetShow()
  PaGlobal_QuestInfo_All:registEventHandler()
  PaGlobal_QuestInfo_All:validate()
  PaGlobal_QuestInfo_All._initialize = true
end
function PaGlobal_QuestInfo_All:ControlAll_Init()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_QuestInfo_All, "Static_TitleBg")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_titleBg, "StaticText_Title")
  self._ui.btn_temp1 = UI.getChildControl(self._ui.stc_titleBg, "Button_1")
  self._ui.stc_subBg = UI.getChildControl(Panel_Window_QuestInfo_All, "Static_SubBg")
  self._ui.txt_attributionType = UI.getChildControl(self._ui.stc_subBg, "StaticText_QuestAttribution")
  self._ui.txt_questGroupTitle = UI.getChildControl(self._ui.stc_subBg, "StaticText_GroupTitle")
  self._ui.txt_questTitle = UI.getChildControl(self._ui.stc_subBg, "StaticText_QuestTitle")
  self._ui.chk_autoNavi = UI.getChildControl(self._ui.stc_subBg, "CheckButton_ListMain_AutoNavi")
  self._ui.chk_questNavi = UI.getChildControl(self._ui.stc_subBg, "Checkbox_ListMain_QuestNavi")
  self._ui.chk_questGiveUp = UI.getChildControl(self._ui.stc_subBg, "Checkbox_ListMain_QuestGiveup")
  self._ui.chk_questTag = UI.getChildControl(self._ui.stc_subBg, "Checkbox_ListMain_QuestTag")
  self._ui.stc_questIconBg = UI.getChildControl(self._ui.stc_subBg, "Static_QuestIconBG")
  self._ui.stc_questIcon = UI.getChildControl(self._ui.stc_questIconBg, "Static_QuestIcon")
  self._ui.txt_acceptNPC = UI.getChildControl(self._ui.stc_subBg, "StaticText_QuestAcceptNPC")
  self._ui.txt_completeNPC = UI.getChildControl(self._ui.stc_subBg, "StaticText_QuestCompleteNpc")
  self._ui.txt_condition = UI.getChildControl(self._ui.stc_subBg, "StaticText_QuestCondition")
  self._ui.frame_questDesc = UI.getChildControl(self._ui.stc_subBg, "Frame_QuestDesc")
  self._ui.frame_content = UI.getChildControl(self._ui.frame_questDesc, "Frame_1_Content")
  self._ui.txt_frameDesc = UI.getChildControl(self._ui.frame_content, "StaticText_Desc")
  self._ui.stc_rewardGroupBg = UI.getChildControl(self._ui.stc_subBg, "Static_RewardGroup")
  self._ui.stc_baseRewardBg = UI.getChildControl(self._ui.stc_rewardGroupBg, "Static_BaseRewardBG")
  self._ui.txt_baseRewardTitle = UI.getChildControl(self._ui.stc_baseRewardBg, "Static_Menu_Reward")
  for index = 0, self._MAX_BASE_REWARD - 1 do
    self._ui._baseRewardSlotBg[index] = UI.getChildControl(self._ui.stc_baseRewardBg, "Static_Reward_Slot_" .. index)
    self._ui._baseRewardSlot[index] = UI.getChildControl(self._ui.stc_baseRewardBg, "Static_Slot_" .. index)
    if true == self._isConsole then
      self._ui._baseRewardSlotBg[index]:SetIgnore(false)
      self._ui._baseRewardSlot[index]:SetIgnore(true)
    end
  end
  self._ui.stc_moneyRewardBG = UI.getChildControl(self._ui.stc_rewardGroupBg, "Static_MoneyRewardBG")
  self._ui.stc_moneyTextValue = UI.getChildControl(self._ui.stc_moneyRewardBG, "StaticText_MoneyValue")
  self._ui._stc_agrisPointDesc = UI.getChildControl(self._ui.stc_subBg, "StaticText_Agris_Point_Desc")
  self._ui_pc._btn_accept = UI.getChildControl(Panel_Window_QuestInfo_All, "Button_Accept")
  self._ui_pc._btn_cancel = UI.getChildControl(Panel_Window_QuestInfo_All, "Button_Cancel")
  self._ui.stc_selectRewardBg = UI.getChildControl(self._ui.stc_rewardGroupBg, "Static_SelectRewardBG")
  self._ui.txt_selectRewardTitle = UI.getChildControl(self._ui.stc_baseRewardBg, "Static_Menu_Reward")
  for index = 0, self._MAX_SELECT_REWARD - 1 do
    self._ui._selectRewardSlotBg[index] = UI.getChildControl(self._ui.stc_selectRewardBg, "Static_Reward_Slot_" .. index)
    self._ui._selectRewardSlot[index] = UI.getChildControl(self._ui.stc_selectRewardBg, "Static_Slot_" .. index)
    if true == self._isConsole then
      self._ui._selectRewardSlotBg[index]:SetIgnore(false)
      self._ui._selectRewardSlot[index]:SetIgnore(true)
    end
  end
  for index = 0, self._MAX_BASE_REWARD - 1 do
    self._ui._baseRewardSlot[index]:SetIgnore(true)
    self._uiBackBaseReward[index] = self._ui._baseRewardSlot[index]
    local slot = {}
    SlotItem.new(slot, "BaseReward_" .. index, index, self._ui._baseRewardSlot[index], self._rewardSlotConfig)
    slot:createChild()
    slot.icon:SetPosX(1)
    slot.icon:SetPosY(1)
    slot.icon:SetSize(40, 40)
    slot.border:SetSize(42, 42)
    slot.icon:SetIgnore(false)
    slot.icon:addInputEvent("Mouse_On", "")
    slot.icon:addInputEvent("Mouse_On", "")
    if true == self._isConsole then
      slot.icon:SetIgnore(true)
    end
    self._listBaseRewardSlots[index] = slot
    Panel_Tooltip_Item_SetPosition(index, slot, "QuestReward_Base")
  end
  for index = 0, self._MAX_SELECT_REWARD - 1 do
    self._ui._selectRewardSlot[index]:SetIgnore(true)
    self._uiBackSelectReward[index] = self._ui._selectRewardSlot[index]
    local slot = {}
    SlotItem.new(slot, "SelectReward_" .. index, index, self._ui._selectRewardSlot[index], self._rewardSlotConfig)
    slot:createChild()
    slot.icon:SetPosX(1)
    slot.icon:SetPosY(1)
    slot.icon:SetSize(40, 40)
    slot.border:SetSize(42, 42)
    slot.icon:SetIgnore(false)
    slot.icon:addInputEvent("Mouse_On", "")
    slot.icon:addInputEvent("Mouse_On", "")
    if true == self._isConsole then
      slot.icon:SetIgnore(true)
    end
    self._listSelectRewardSlots[index] = slot
    Panel_Tooltip_Item_SetPosition(index, slot, "QuestReward_Select")
  end
  self._originDescBgSizeY = self._ui.frame_questDesc:GetSizeY()
end
function PaGlobal_QuestInfo_All:ControlPc_Init()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Win_Close")
  self._ui_pc.btn_callSpirit = UI.getChildControl(Panel_Window_QuestInfo_All, "Button_Quest_CallSpirit")
  self._ui_pc.btn_giveUp = UI.getChildControl(Panel_Window_QuestInfo_All, "Button_Quest_GiveUp")
  self._ui_pc.chk_questNavi = UI.getChildControl(Panel_Window_QuestInfo_All, "CheckBtn_Quest_Navi")
  self._ui_pc.chk_autoNavi = UI.getChildControl(Panel_Window_QuestInfo_All, "CheckBtn_Quest_AutoNavi")
  if self._isConsole == false then
    local icon_giveUp = UI.getChildControl(self._ui_pc.btn_giveUp, "Static_Icon")
    local text_giveUp = UI.getChildControl(self._ui_pc.btn_giveUp, "StaticText_ButtonName")
    local icon_navi = UI.getChildControl(self._ui_pc.chk_questNavi, "Static_Icon")
    local text_navi = UI.getChildControl(self._ui_pc.chk_questNavi, "StaticText_ButtonName")
    local icon_autoNavi = UI.getChildControl(self._ui_pc.chk_autoNavi, "Static_Icon")
    local text_autoNavi = UI.getChildControl(self._ui_pc.chk_autoNavi, "StaticText_ButtonName")
    local term = 5
    local txtMaxSize_giveUP = self._ui_pc.btn_giveUp:GetSizeX() - (term + icon_giveUp:GetSizeX() + term * 2)
    local txtMaxSize_navi = self._ui_pc.chk_questNavi:GetSizeX() - (term + icon_navi:GetSizeX() + term * 2)
    local txtMaxSize_autoNavi = self._ui_pc.chk_autoNavi:GetSizeX() - (term + icon_autoNavi:GetSizeX() + term * 2)
    text_giveUp:SetTextMode(__eTextMode_LimitText)
    text_giveUp:SetSize(txtMaxSize_giveUP, text_giveUp:GetSizeY())
    text_giveUp:SetText(text_giveUp:GetText())
    text_navi:SetTextMode(__eTextMode_LimitText)
    text_navi:SetSize(txtMaxSize_navi, text_navi:GetSizeY())
    text_navi:SetText(text_navi:GetText())
    text_autoNavi:SetTextMode(__eTextMode_LimitText)
    text_autoNavi:SetSize(txtMaxSize_autoNavi, text_autoNavi:GetSizeY())
    text_autoNavi:SetText(text_autoNavi:GetText())
    if text_giveUp:IsLimitText() == false then
      text_giveUp:SetSize(text_giveUp:GetTextSizeX(), text_giveUp:GetSizeY())
      local size = icon_giveUp:GetSizeX() + text_giveUp:GetSizeX() + term
      local beginPos = (self._ui_pc.btn_giveUp:GetSizeX() - size - term * 2) / 2
      icon_giveUp:SetSpanSize(beginPos, icon_giveUp:GetSpanSize().y)
      text_giveUp:SetSpanSize(beginPos + icon_giveUp:GetSizeX() + term, text_giveUp:GetSpanSize().y)
    else
      icon_giveUp:SetSpanSize(term, icon_giveUp:GetSpanSize().y)
      text_giveUp:SetSpanSize(term + icon_giveUp:GetSizeX() + term, text_giveUp:GetSpanSize().y)
      text_giveUp:SetSize(self._ui_pc.btn_giveUp:GetSizeX() - text_giveUp:GetSpanSize().x - term, text_giveUp:GetSizeY())
      self._ui_pc.btn_giveUp:addInputEvent("Mouse_On", "HandleEventLOnOut_QuestInfo_All_ButtonTooltip(true, 0)")
      self._ui_pc.btn_giveUp:addInputEvent("Mouse_Out", "HandleEventLOnOut_QuestInfo_All_ButtonTooltip(false, 0)")
    end
    if text_navi:IsLimitText() == false then
      text_navi:SetSize(text_navi:GetTextSizeX(), text_navi:GetSizeY())
      local size = icon_navi:GetSizeX() + text_navi:GetSizeX() + term
      local beginPos = (self._ui_pc.chk_questNavi:GetSizeX() - size - term * 2) / 2
      icon_navi:SetSpanSize(beginPos, icon_navi:GetSpanSize().y)
      text_navi:SetSpanSize(beginPos + icon_navi:GetSizeX() + term, text_navi:GetSpanSize().y)
    else
      icon_navi:SetSpanSize(term, icon_navi:GetSpanSize().y)
      text_navi:SetSpanSize(term + icon_navi:GetSizeX() + term, text_navi:GetSpanSize().y)
      text_navi:SetSize(self._ui_pc.chk_questNavi:GetSizeX() - text_navi:GetSpanSize().x - term, text_navi:GetSizeY())
      self._ui_pc.chk_questNavi:addInputEvent("Mouse_On", "HandleEventLOnOut_QuestInfo_All_ButtonTooltip(true, 1)")
      self._ui_pc.chk_questNavi:addInputEvent("Mouse_Out", "HandleEventLOnOut_QuestInfo_All_ButtonTooltip(false, 1)")
    end
    if text_autoNavi:IsLimitText() == false then
      text_autoNavi:SetSize(text_autoNavi:GetTextSizeX(), text_autoNavi:GetSizeY())
      local size = icon_autoNavi:GetSizeX() + text_autoNavi:GetSizeX() + term
      local beginPos = (self._ui_pc.chk_autoNavi:GetSizeX() - size - term * 2) / 2
      icon_autoNavi:SetSpanSize(beginPos, icon_autoNavi:GetSpanSize().y)
      text_autoNavi:SetSpanSize(beginPos + icon_autoNavi:GetSizeX() + term, text_autoNavi:GetSpanSize().y)
    else
      icon_autoNavi:SetSpanSize(term, icon_autoNavi:GetSpanSize().y)
      text_autoNavi:SetSpanSize(term + icon_autoNavi:GetSizeX() + term, text_autoNavi:GetSpanSize().y)
      text_autoNavi:SetSize(self._ui_pc.chk_autoNavi:GetSizeX() - text_autoNavi:GetSpanSize().x - term, text_autoNavi:GetSizeY())
      self._ui_pc.chk_autoNavi:addInputEvent("Mouse_On", "HandleEventLOnOut_QuestInfo_All_ButtonTooltip(true, 2)")
      self._ui_pc.chk_autoNavi:addInputEvent("Mouse_Out", "HandleEventLOnOut_QuestInfo_All_ButtonTooltip(false, 2)")
    end
  end
end
function PaGlobal_QuestInfo_All:ControlConsole_Init()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  self._ui_console.stc_keyGuideBg = UI.getChildControl(Panel_Window_QuestInfo_All, "Static_ConsoleKeyGuide")
  self._ui_console.stc_tooltip = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_ItemInfo")
  self._ui_console.stc_scroll = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Scroll")
  self._ui_console.stc_giveUp = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Giveup")
  self._ui_console.stc_navi = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Navi")
  self._ui_console.stc_close = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Close")
end
function PaGlobal_QuestInfo_All:ControlSetShow()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  if true == self._isConsole then
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.btn_giveUp:SetShow(false)
    self._ui_pc.btn_callSpirit:SetShow(false)
    self._ui_pc.chk_questNavi:SetShow(false)
    self._ui_pc.chk_autoNavi:SetShow(false)
    self._ui_console.stc_keyGuideBg:SetShow(true)
    self._ui_console.stc_scroll:SetShow(false)
  else
    self._ui_pc.btn_close:SetShow(true)
    self._ui_pc.btn_giveUp:SetShow(true)
    self._ui_pc.btn_callSpirit:SetShow(true)
    self._ui_pc.chk_questNavi:SetShow(true)
    self._ui_pc.chk_autoNavi:SetShow(true)
    self._ui_console.stc_keyGuideBg:SetShow(false)
    self._ui_console.stc_scroll:SetShow(false)
  end
end
function PaGlobal_QuestInfo_All:resetCheckButton()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  self._ui_pc.chk_questNavi:SetCheck(false)
  self._ui_pc.chk_autoNavi:SetCheck(false)
  self._ui.chk_autoNavi:SetCheck(false)
  self._ui.chk_questNavi:SetCheck(false)
end
function PaGlobal_QuestInfo_All:prepareOpen()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  PaGlobal_QuestInfo_All:resetControlShow()
  PaGlobal_QuestInfo_All:update()
  PaGlobal_QuestInfo_All:rePosition()
  if true == _ContentsGroup_RenewUI_WorldMap and true == self._OpenInfo._isWorldmapOpen then
    if nil ~= PaGlobalFunc_WorldMap_TopMenu_Close then
      PaGlobalFunc_WorldMap_TopMenu_Close()
    end
    if nil ~= PaGlobalFunc_WorldMap_RingMenu_Close then
      PaGlobalFunc_WorldMap_RingMenu_Close()
    end
    if nil ~= PaGlobalFunc_WorldMap_BottomMenu_Close then
      PaGlobalFunc_WorldMap_BottomMenu_Close()
    end
  end
  PaGlobal_QuestInfo_All:open()
end
function PaGlobal_QuestInfo_All:open()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  if true == Panel_Window_QuestInfo_All:GetShow() then
    return
  end
  if true == self._isConsole or true == Panel_Window_Quest_All:IsUISubApp() then
    Panel_Window_QuestInfo_All:SetShow(true)
  else
    Panel_Window_QuestInfo_All:SetShow(true, true)
  end
end
function PaGlobal_QuestInfo_All:prepareClose()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  if true == Panel_Window_QuestInfo_All:IsUISubApp() then
    Panel_Window_QuestInfo_All:CloseUISubApp()
  end
  Panel_Tooltip_Item_hideTooltip()
  if true == _ContentsGroup_RenewUI_WorldMap and true == self._OpenInfo._isWorldmapOpen then
    self._OpenInfo._isWorldmapOpen = false
    _AudioPostEvent_SystemUiForXBOX(50, 3)
    if nil ~= PaGlobalFunc_WorldMap_TopMenu_Open then
      PaGlobalFunc_WorldMap_TopMenu_Open()
    end
    if nil ~= PaGlobalFunc_WorldMap_RingMenu_Open then
      PaGlobalFunc_WorldMap_RingMenu_Open()
    end
    if nil ~= PaGlobalFunc_WorldMap_BottomMenu_Open then
      PaGlobalFunc_WorldMap_BottomMenu_Open()
    end
  end
  PaGlobal_QuestInfo_All:close()
end
function PaGlobal_QuestInfo_All:close()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  self._OpenInfo = {}
  Panel_Window_QuestInfo_All:SetShow(false, false)
end
function PaGlobal_QuestInfo_All:update()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  PaGlobal_QuestInfo_All:infoUpdate()
  PaGlobal_QuestInfo_All:rewardUpdate()
  PaGlobal_QuestInfo_All:resize()
  if true == Panel_Window_Quest_All:IsUISubApp() then
    PaGlobal_QuestInfo_All:rePosition()
  end
end
function PaGlobal_QuestInfo_All:openInfoSave(groupId, questId, uiCondition, groupTitle, questGroupCount, fromQuestWidget, isRecommand, isNextQuest, isCleared, isAccepted, uiIdx, isWorldmapOpen)
  for k, v in ipairs(self._OpenInfo) do
    v = nil
  end
  self._OpenInfo._groupId = groupId
  self._OpenInfo._questId = questId
  self._OpenInfo._uiCondition = uiCondition
  self._OpenInfo._groupTitle = groupTitle
  self._OpenInfo._questGroupCount = questGroupCount
  self._OpenInfo._fromQuestWidget = fromQuestWidget
  self._OpenInfo._isRecommand = isRecommand
  self._OpenInfo._isNextQuest = isNextQuest
  self._OpenInfo._isCleared = isCleared
  self._OpenInfo._isAccepted = isAccepted
  self._OpenInfo._uiIdx = uiIdx
  if nil ~= isWorldmapOpen and true == isWorldmapOpen then
    self._OpenInfo._isWorldmapOpen = true
  else
    self._OpenInfo._isWorldmapOpen = false
  end
  if nil == uiIdx then
    self._OpenInfo._uiIdx = -1
  end
end
function PaGlobal_QuestInfo_All:resetControlShow()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  if false == self._OpenInfo._isCleared or nil == self._OpenInfo._isCleared then
    if false == self._isConsole then
      self._ui_pc.btn_callSpirit:SetShow(true)
      self._ui_pc.btn_giveUp:SetShow(true)
      self._ui_pc.chk_questNavi:SetShow(true)
      self._ui_pc.chk_autoNavi:SetShow(true)
      self._ui.chk_autoNavi:SetShow(true)
      self._ui.chk_questNavi:SetShow(true)
      self._ui.chk_questGiveUp:SetShow(true)
      self._ui.chk_questTag:SetShow(_ContentsGroup_OlviaAcademy)
      self._ui._stc_agrisPointDesc:SetShow(false)
      self._ui_pc._btn_accept:SetShow(false)
      self._ui_pc._btn_cancel:SetShow(false)
    else
      self._ui_console.stc_tooltip:SetShow(true)
      self._ui_console.stc_giveUp:SetShow(true)
      self._ui_console.stc_navi:SetShow(true)
    end
    self._ui.txt_baseRewardTitle:SetShow(true)
    self._ui.txt_selectRewardTitle:SetShow(true)
    for i = 0, 11 do
    end
  end
  self._ui.stc_moneyRewardBG:SetShow(false)
end
function PaGlobal_QuestInfo_All:infoUpdate()
  local questStaticInfo = questList_getQuestStatic(self._OpenInfo._groupId, self._OpenInfo._questId)
  if nil == questStaticInfo then
    return
  end
  if nil == self._OpenInfo._isNextQuest then
    self._OpenInfo._isNextQuest = false
  end
  self._ui.txt_questGroupTitle:SetShow(true)
  if self._OpenInfo._groupTitle ~= "nil" then
    if self._OpenInfo._questGroupCount == nil then
      self._ui.txt_questGroupTitle:SetText(self._OpenInfo._groupTitle)
    else
      local tempValue = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_QUESTWIDGET_QUESTINFO_GROUP_TITLE_ALL", "groupTitle", self._OpenInfo._groupTitle, "questId", self._OpenInfo._questId, "questGroupCount", self._OpenInfo._questGroupCount)
      self._ui.txt_questGroupTitle:SetText(tempValue)
    end
  else
    self._ui.txt_questGroupTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_QUESTWIDGET_QUESTINFO_NORMAL_TITLE"))
  end
  self._ui.txt_questTitle:SetShow(true)
  self._ui.txt_questTitle:SetText(questStaticInfo:getTitle())
  if true == _ContentsGroup_DevelopKeyView then
    self._ui.btn_temp1:SetShow(true)
    self._ui.btn_temp1:SetText("(<PAColor0xfff5ba3a>" .. self._OpenInfo._groupId .. "/" .. self._OpenInfo._questId .. "<PAOldColor>)")
    self._ui.btn_temp1:SetSize(self._ui.btn_temp1:GetTextSizeX() + 20, 40)
    self._ui.btn_temp1:SetPosX(self._ui.txt_title:GetPosX() + self._ui.txt_title:GetTextSizeX() + 5)
    self._ui.btn_temp1:addInputEvent("Mouse_LUp", "questQAComplete(" .. self._OpenInfo._groupId .. ", " .. self._OpenInfo._questId .. ")")
    self._ui.btn_temp1:addInputEvent("Mouse_RUp", "questQACondition(" .. self._OpenInfo._groupId .. ", " .. self._OpenInfo._questId .. ")")
    self._ui.btn_temp1:addInputEvent("Mouse_MUp", "questQAAccept(" .. self._OpenInfo._groupId .. ", " .. self._OpenInfo._questId .. ")")
    self._ui.btn_temp1:addInputEvent("Mouse_On", "questInfoTooltip(true)")
    self._ui.btn_temp1:addInputEvent("Mouse_Out", "questInfoTooltip()")
  else
    self._ui.btn_temp1:SetShow(false)
    self._ui.btn_temp1:removeInputEvent("Mouse_LUp")
    self._ui.btn_temp1:removeInputEvent("Mouse_RUp")
    self._ui.btn_temp1:removeInputEvent("Mouse_MUp")
    self._ui.btn_temp1:removeInputEvent("Mouse_On")
    self._ui.btn_temp1:removeInputEvent("Mouse_Out")
  end
  if false == _ContentsGroup_UsePadSnapping then
    UI.setLimitTextAndAddTooltip(self._ui.txt_questGroupTitle)
    UI.setLimitTextAndAddTooltip(self._ui.txt_questTitle)
  else
    self._ui.txt_questTitle:SetSize(Panel_Window_QuestInfo_All:GetSizeX() - 30, self._ui.txt_questTitle:GetSizeY())
    self._ui.txt_questTitle:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_questTitle:SetAutoResize(true)
    self._ui.txt_questTitle:SetText(self._ui.txt_questTitle:GetText())
  end
  local isAgrisQuest = false
  local agrisPoint = questStaticInfo:getQuestFeverPoint()
  if true == _ContentsGroup_FeverQuest and true == self._OpenInfo._isWorldmapOpen and agrisPoint > 0 then
    isAgrisQuest = true
  end
  if false == self._isConsole then
    if true == isAgrisQuest then
      self._ui_pc._btn_accept:SetShow(true)
      self._ui_pc._btn_accept:addInputEvent("Mouse_LUp", "HandleEventLUp_QuestInfo_All_AgrisAcceptCheck(true," .. self._OpenInfo._groupId .. "," .. self._OpenInfo._questId .. ")")
      self._ui_pc._btn_cancel:SetShow(true)
      self._ui_pc._btn_cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_QuestInfo_All_AgrisAcceptCheck(false)")
      self._ui.chk_questNavi:SetShow(false)
      self._ui.chk_autoNavi:SetShow(false)
      self._ui.chk_questGiveUp:SetShow(false)
      self._ui.chk_questTag:SetShow(_ContentsGroup_OlviaAcademy == true)
      self._ui_pc.btn_giveUp:SetShow(false)
      self._ui_pc.btn_callSpirit:SetShow(false)
      self._ui_pc.chk_questNavi:SetShow(false)
      self._ui_pc.chk_autoNavi:SetShow(false)
    else
      self._ui.chk_questNavi:SetShow(true)
      self._ui.chk_questNavi:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_FindWayPrepare( " .. self._OpenInfo._groupId .. ", " .. self._OpenInfo._questId .. ", " .. self._OpenInfo._uiCondition .. ", false, " .. self._OpenInfo._uiIdx .. " )")
      self._ui.chk_autoNavi:SetShow(true)
      self._ui.chk_autoNavi:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_FindWayPrepare( " .. self._OpenInfo._groupId .. ", " .. self._OpenInfo._questId .. ", " .. self._OpenInfo._uiCondition .. ", true, " .. self._OpenInfo._uiIdx .. " )")
      local isProgressQuest = ToClient_isProgressingQuest(self._OpenInfo._groupId, self._OpenInfo._questId)
      self._ui.chk_questGiveUp:SetShow(isProgressQuest)
      self._ui.chk_questGiveUp:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_GiveUp(" .. self._OpenInfo._groupId .. "," .. self._OpenInfo._questId .. ")")
      self._ui.chk_questTag:SetShow(_ContentsGroup_OlviaAcademy == true)
      self._ui.chk_questTag:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_Tag(" .. self._OpenInfo._groupId .. "," .. self._OpenInfo._questId .. ")")
      self._ui_pc.btn_giveUp:SetShow(not self._OpenInfo._isNextQuest)
      self._ui_pc.btn_giveUp:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_GiveUp(" .. self._OpenInfo._groupId .. "," .. self._OpenInfo._questId .. ")")
      if nil ~= self._OpenInfo._isAccepted and 0 == self._OpenInfo._isAccepted then
        self._ui.chk_questGiveUp:SetShow(false)
        self._ui_pc.btn_giveUp:SetShow(false)
      end
      self._ui_pc.btn_callSpirit:SetShow(false)
      self._ui_pc.btn_callSpirit:addInputEvent("Mouse_LUp", "HandleEventLUp_QuestInfo_All_CallSpirit()")
      self._ui_pc.chk_questNavi:SetShow(true)
      self._ui_pc.chk_questNavi:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_FindWayPrepare( " .. self._OpenInfo._groupId .. ", " .. self._OpenInfo._questId .. ", " .. self._OpenInfo._uiCondition .. ", false, " .. self._OpenInfo._uiIdx .. " )")
      self._ui_pc.chk_autoNavi:SetShow(true)
      self._ui_pc.chk_autoNavi:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_FindWayPrepare( " .. self._OpenInfo._groupId .. ", " .. self._OpenInfo._questId .. ", " .. self._OpenInfo._uiCondition .. ", true, " .. self._OpenInfo._uiIdx .. " )")
      self._ui.chk_questNavi:SetCheck(false)
      self._ui_pc.chk_questNavi:SetCheck(false)
      self._ui.chk_autoNavi:SetCheck(false)
      self._ui_pc.chk_autoNavi:SetCheck(false)
      if _QuestWidget_ReturnQuestState ~= nil then
        local _questGroupId, _questId, _naviInfoAgain, _naviIsAutoRun = _QuestWidget_ReturnQuestState()
        if self._OpenInfo._groupId == _questGroupId and self._OpenInfo._questId == _questId then
          if true == _naviInfoAgain then
            self._ui.chk_questNavi:SetCheck(false)
            self._ui_pc.chk_questNavi:SetCheck(false)
          else
            self._ui.chk_questNavi:SetCheck(true)
            self._ui_pc.chk_questNavi:SetCheck(true)
            if true == _naviIsAutoRun then
              self._ui.chk_autoNavi:SetCheck(true)
              self._ui_pc.chk_autoNavi:SetCheck(true)
            end
          end
        end
      end
      if false == self._OpenInfo._isNextQuest then
        if 0 == self._OpenInfo._uiCondition and 0 == questStaticInfo:getCompleteNpc():get() then
          self._ui.chk_questNavi:SetShow(false)
          self._ui_pc.chk_questNavi:SetShow(false)
          self._ui.chk_autoNavi:SetShow(false)
          self._ui_pc.chk_autoNavi:SetShow(false)
          self._ui_pc.btn_callSpirit:SetShow(true)
        end
        local questPosCount = questStaticInfo:getQuestPositionCount()
        if 0 ~= self._OpenInfo._uiCondition and 0 == questPosCount then
          self._ui.chk_questNavi:SetShow(false)
          self._ui.chk_autoNavi:SetShow(false)
          self._ui_pc.chk_questNavi:SetShow(false)
          self._ui_pc.chk_autoNavi:SetShow(false)
        end
      end
    end
  elseif true == isAgrisQuest then
    self._ui_console.stc_tooltip:SetShow(false)
    self._ui_console.stc_navi:SetShow(false)
    Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    self._ui_console.stc_giveUp:SetShow(true)
    self._ui_console.stc_giveUp:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMPETITIONGAME_ACCEPT"))
    Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_QuestInfo_All_AgrisAcceptCheck(true," .. self._OpenInfo._groupId .. "," .. self._OpenInfo._questId .. ")")
  else
    self._ui_console.stc_giveUp:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHECKEDQUESTLIST_BTN_GIVEUP"))
    if false == self._OpenInfo._isNextQuest then
      self._ui_console.stc_giveUp:SetShow(true)
      Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleClicked_QuestWidget_QuestGiveUp(" .. self._OpenInfo._groupId .. "," .. self._OpenInfo._questId .. ")")
    else
      self._ui_console.stc_giveUp:SetShow(false)
      Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    end
    if nil ~= self._OpenInfo._isAccepted and 0 == self._OpenInfo._isAccepted then
      self._ui_console.stc_giveUp:SetShow(false)
      Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    end
    self._ui_console.stc_navi:SetShow(true)
    Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Quest_All_FindWayPrepare( " .. self._OpenInfo._groupId .. ", " .. self._OpenInfo._questId .. ", " .. self._OpenInfo._uiCondition .. ", false, " .. self._OpenInfo._uiIdx .. " )")
    if false == self._OpenInfo._isNextQuest then
      local questPosCount = questStaticInfo:getQuestPositionCount()
      if 0 == self._OpenInfo._uiCondition and 0 == questStaticInfo:getCompleteNpc():get() or 0 ~= self._OpenInfo._uiCondition and 0 == questPosCount then
        self._ui_console.stc_navi:SetShow(false)
        Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      end
    end
  end
  local titleGapY = self._ui.txt_questTitle:GetSpanSize().y + self._ui.txt_questTitle:GetSizeY() + 5
  local completeNpc = questStaticInfo:getCompleteDisplay()
  self._ui.txt_completeNPC:SetShow(true)
  self._ui.txt_completeNPC:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_completeNPC:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "QUESTLIST_COMPLETETARGET", "getCompleteDisplay", completeNpc))
  self._ui.txt_completeNPC:SetSpanSize(self._ui.txt_completeNPC:GetSpanSize().x, titleGapY)
  self._ui.stc_questIconBg:SetShow(true)
  self._ui.stc_questIcon:SetShow(true)
  ToClient_ChangeQuestIconFromIconPath(self._ui.stc_questIcon, questStaticInfo:getIconPath(), questStaticInfo:getQuestType())
  self._ui.stc_questIconBg:SetSpanSize(self._ui.stc_questIconBg:GetSpanSize().x, self._ui.txt_completeNPC:GetSpanSize().y)
  local demandCount = questStaticInfo:getDemadCount()
  local demandString = ""
  for demandIndex = 0, demandCount - 1 do
    local questInfo = ToClient_GetQuestInfo(self._OpenInfo._groupId, self._OpenInfo._questId)
    if questInfo ~= nil then
      local demand = questInfo:getDemandAt(demandIndex)
      if demand._destCount <= demand._currentCount then
        demandString = demandString .. "<PAColor0xFF626262>- " .. demand._desc .. " (" .. PAGetString(Defines.StringSheet_GAME, "DIALOG_BUTTON_QUEST_COMPLETE") .. ")<PAOldColor>\n"
      elseif demand._destCount == 1 then
        demandString = demandString .. "- " .. demand._desc .. "\n"
      else
        demandString = demandString .. "- " .. demand._desc .. " (" .. demand._currentCount .. "/" .. demand._destCount .. ")\n"
      end
    else
      local demand = questStaticInfo:getDemandAt(demandIndex)
      if 1 < demand._destCount then
        demandString = demandString .. "- " .. demand._desc .. " (0/" .. demand._destCount .. ")\n"
      else
        demandString = demandString .. "- " .. demand._desc .. "\n"
      end
    end
  end
  self._ui.txt_condition:SetShow(true)
  self._ui.txt_condition:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_condition:SetAutoResize(true)
  self._ui.txt_condition:SetText(tostring(ToClient_getReplaceDialog(demandString)))
  self._ui.txt_condition:SetSpanSize(self._ui.txt_condition:GetSpanSize().x, self._ui.stc_questIconBg:GetSpanSize().y + self._ui.stc_questIconBg:GetSizeY() + 5)
  local gabY = 20
  local descGabY = self._ui.txt_condition:GetSpanSize().y + self._ui.txt_condition:GetSizeY() + 5
  if true == _ContentsGroup_FeverQuest and agrisPoint > 0 then
    self._ui._stc_agrisPointDesc:SetShow(true)
    self._ui._stc_agrisPointDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_AGRISDESC", "point", tostring(agrisPoint)))
    self._ui._stc_agrisPointDesc:SetSpanSize(self._ui._stc_agrisPointDesc:GetSpanSize().x, descGabY)
    descGabY = descGabY + self._ui._stc_agrisPointDesc:GetSizeY() + 10
  else
    self._ui._stc_agrisPointDesc:SetShow(false)
  end
  self._ui.frame_questDesc:SetSpanSize(self._ui.frame_questDesc:GetSpanSize().x, descGabY)
  self._ui.txt_frameDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_frameDesc:SetText(ToClient_getReplaceDialog(questStaticInfo:getDesc()))
  self._ui.txt_frameDesc:setLocalizedStaticType(18)
  self._ui.txt_frameDesc:setLocalizedKey(questStaticInfo:getDescLocalizedKey())
  self._ui.txt_frameDesc:SetIgnore(true)
  self._ui.txt_frameDesc:SetSize(self._ui.txt_frameDesc:GetSizeX(), self._ui.txt_frameDesc:GetTextSizeY())
  self._ui.frame_content:SetSize(self._ui.txt_frameDesc:GetSizeX(), self._ui.txt_frameDesc:GetTextSizeY())
  if self._originDescBgSizeY < self._ui.txt_frameDesc:GetTextSizeY() + gabY then
    self._ui.frame_questDesc:SetSize(self._ui.frame_questDesc:GetSizeX(), self._originDescBgSizeY)
  else
    self._ui.frame_questDesc:SetSize(self._ui.frame_questDesc:GetSizeX(), self._ui.txt_frameDesc:GetTextSizeY() + gabY)
  end
  self._ui.frame_questDesc:GetVScroll():SetControlTop()
  self._ui.frame_questDesc:UpdateContentScroll()
  self._ui.frame_questDesc:UpdateContentPos()
  UIScroll.SetButtonSize(self._ui.frame_questDesc:GetVScroll(), self._ui.frame_questDesc:GetSizeY(), self._ui.frame_content:GetSizeY())
  self._ui.stc_rewardGroupBg:SetSpanSize(self._ui.stc_rewardGroupBg:GetSpanSize().x, self._ui.frame_questDesc:GetSpanSize().y + self._ui.frame_questDesc:GetSizeY() + 5)
  if true == self._isConsole then
    self._ui.chk_autoNavi:SetShow(false)
    self._ui.chk_questNavi:SetShow(false)
    self._ui.chk_questGiveUp:SetShow(false)
    self._ui.chk_questTag:SetShow(false)
    self._ui_pc.btn_giveUp:SetShow(false)
    self._ui_pc.btn_callSpirit:SetShow(false)
    self._ui_pc.chk_questNavi:SetShow(false)
    self._ui_pc.chk_autoNavi:SetShow(false)
    if true == self._ui.frame_questDesc:GetVScroll():GetShow() then
      self._ui_console.stc_scroll:SetShow(true)
    else
      self._ui_console.stc_scroll:SetShow(false)
    end
  end
end
function PaGlobal_QuestInfo_All:rewardUpdate()
  self._ui.stc_moneyRewardBG:SetShow(false)
  if true == self._OpenInfo._isCleared then
    if false == self._isConsole then
      self._ui.chk_autoNavi:SetShow(false)
      self._ui.chk_questNavi:SetShow(false)
      self._ui.chk_questGiveUp:SetShow(false)
      self._ui.chk_questTag:SetShow(false)
      self._ui_pc.btn_giveUp:SetShow(false)
      self._ui_pc.btn_callSpirit:SetShow(false)
      self._ui_pc.chk_questNavi:SetShow(false)
      self._ui_pc.chk_autoNavi:SetShow(false)
    else
      self._ui_console.stc_tooltip:SetShow(false)
      self._ui_console.stc_giveUp:SetShow(false)
      self._ui_console.stc_navi:SetShow(false)
      Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Y, "")
      Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_A, "")
    end
  end
  self._ui.stc_rewardGroupBg:SetShow(true)
  if nil == self._OpenInfo or nil == self._OpenInfo._groupId or nil == self._OpenInfo._questId then
    UI.ASSERT_NAME(nil ~= self._OpenInfo, "PaGlobal_QuestInfo_All:rewardUpdate() self._OpenInfo is nil.", "\234\185\128\236\156\164\236\167\128")
    UI.ASSERT_NAME(nil ~= self._OpenInfo._groupId, "PaGlobal_QuestInfo_All:rewardUpdate() self._OpenInfo._groupId is nil.", "\234\185\128\236\156\164\236\167\128")
    UI.ASSERT_NAME(nil ~= self._OpenInfo._questId, "PaGlobal_QuestInfo_All:rewardUpdate() self._OpenInfo._questId is nil.", "\234\185\128\236\156\164\236\167\128")
    return
  end
  local questStaticInfo = questList_getQuestStatic(self._OpenInfo._groupId, self._OpenInfo._questId)
  if nil == questStaticInfo then
    UI.ASSERT_NAME(nil ~= self._OpenInfo._questId, "PaGlobal_QuestInfo_All:rewardUpdate() questStaticInfo is nil.", "\234\185\128\236\156\164\236\167\128")
    return
  end
  local baseCount = questStaticInfo:getQuestBaseRewardCount()
  local selectCount = questStaticInfo:getQuestSelectRewardCount()
  self._baseReward = {}
  local baseRewardIndex = 1
  for baseIdx = 1, baseCount do
    local baseReward = questStaticInfo:getQuestBaseRewardAt(baseIdx - 1)
    self._baseReward[baseRewardIndex] = {}
    self._baseReward[baseRewardIndex]._type = baseReward:getType()
    self._baseReward[baseRewardIndex]._isMoney = baseReward:isMoney()
    if __eRewardExp == self._baseReward[baseRewardIndex]._type then
      self._baseReward[baseRewardIndex]._exp = baseReward:getExperience()
    elseif __eRewardSkillExp == self._baseReward[baseRewardIndex]._type then
      self._baseReward[baseRewardIndex]._exp = baseReward:getSkillExperience()
    elseif __eRewardLifeExp == self._baseReward[baseRewardIndex]._type then
      self._baseReward[baseRewardIndex]._exp = baseReward:getProductExperience()
    elseif __eRewardItem == self._baseReward[baseRewardIndex]._type then
      self._baseReward[baseRewardIndex]._item = baseReward:getItemEnchantKey()
      self._baseReward[baseRewardIndex]._count = baseReward:getItemCount()
    elseif __eRewardIntimacy == self._baseReward[baseRewardIndex]._type then
      self._baseReward[baseRewardIndex]._character = baseReward:getIntimacyCharacter()
      self._baseReward[baseRewardIndex]._value = baseReward:getIntimacyValue()
    elseif __eRewardKnowledge == self._baseReward[baseRewardIndex]._type then
      self._baseReward[baseRewardIndex]._mentalCard = baseReward:getMentalCardKey()
    elseif __eRewardSeasonReward == self._baseReward[baseRewardIndex]._type then
      self._baseReward[baseRewardIndex]._season = baseReward:getSeasonNo()
    elseif __eRewardExploreExp == self._baseReward[baseRewardIndex]._type then
      self._baseReward[baseRewardIndex]._exploreExp = Int64toInt32(baseReward:getExploreExperience())
    elseif __eRewardFamilyStat == self._baseReward[baseRewardIndex]._type then
      self._baseReward[baseRewardIndex]._familyStatType = baseReward:getFamilyStatType()
      self._baseReward[baseRewardIndex]._familyStatValue = PaGlobalFunc_GetRewardFamilyStatValue(baseReward)
    end
    if self._baseReward[baseRewardIndex]._isMoney == true then
      self._ui.stc_moneyRewardBG:SetShow(true)
      self._ui.stc_moneyTextValue:SetText(makeDotMoney(baseReward:getItemCount()))
      self._baseReward[baseRewardIndex] = nil
    else
      baseRewardIndex = baseRewardIndex + 1
    end
  end
  if true == self._ui.stc_moneyRewardBG:GetShow() then
    self._ui.stc_baseRewardBg:SetSpanSize(0, 40)
    self._ui.stc_selectRewardBg:SetSpanSize(0, 160)
  else
    self._ui.stc_baseRewardBg:SetSpanSize(0, 0)
    self._ui.stc_selectRewardBg:SetSpanSize(0, 120)
  end
  self._ui.stc_rewardGroupBg:SetSize(self._ui.stc_rewardGroupBg:GetSizeX(), self._ui.stc_selectRewardBg:GetPosY() + self._ui.stc_selectRewardBg:GetSizeY() + 10)
  self._selectReward = {}
  for selectIdx = 1, selectCount do
    local selectReward = questStaticInfo:getQuestSelectRewardAt(selectIdx - 1)
    self._selectReward[selectIdx] = {}
    self._selectReward[selectIdx]._type = selectReward:getType()
    if __eRewardExp == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._exp = selectReward:getExperience()
    elseif __eRewardSkillExp == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._exp = selectReward:getSkillExperience()
    elseif __eRewardLifeExp == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._exp = selectReward:getProductExperience()
    elseif __eRewardItem == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._item = selectReward:getItemEnchantKey()
      self._selectReward[selectIdx]._count = selectReward:getItemCount()
    elseif __eRewardIntimacy == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._character = selectReward:getIntimacyCharacter()
      self._selectReward[selectIdx]._value = selectReward:getIntimacyValue()
    elseif __eRewardKnowledge == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._mentalCard = selectReward:getMentalCardKey()
    elseif __eRewardSeasonReward == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._season = selectReward:getSeasonNo()
    elseif __eRewardExploreExp == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._exploreExp = Int64toInt32(selectReward:getExploreExperience())
    elseif __eRewardFamilyStat == self._baseReward[baseIdx]._type then
      self._selectReward[selectIdx]._familyStatType = selectReward:getFamilyStatType()
      self._selectReward[selectIdx]._familyStatValue = PaGlobalFunc_GetRewardFamilyStatValue(selectReward)
    end
  end
  for index = 0, self._MAX_BASE_REWARD - 1 do
    self._listBaseRewardSlots[index].icon:addInputEvent("Mouse_On", "")
    self._listBaseRewardSlots[index].icon:addInputEvent("Mouse_Out", "")
    self._ui._baseRewardSlotBg[index]:addInputEvent("Mouse_On", "")
    self._ui._baseRewardSlotBg[index]:addInputEvent("Mouse_Out", "")
    self._ui._baseRewardSlotBg[index]:registerPadEvent(__eConsoleUIPadEvent_X, "")
    self._uiBackBaseReward[index]:SetShow(false)
  end
  local baseRewardSlotIndex = 0
  for ii = 1, #self._baseReward do
    self:setReward(self._listBaseRewardSlots[baseRewardSlotIndex], self._baseReward[ii], baseRewardSlotIndex, "main")
    self._uiBackBaseReward[baseRewardSlotIndex]:SetShow(true)
    baseRewardSlotIndex = baseRewardSlotIndex + 1
  end
  for index = 0, self._MAX_SELECT_REWARD - 1 do
    self._listSelectRewardSlots[index].icon:addInputEvent("Mouse_On", "")
    self._listSelectRewardSlots[index].icon:addInputEvent("Mouse_Out", "")
    self._ui._selectRewardSlotBg[index]:addInputEvent("Mouse_On", "")
    self._ui._selectRewardSlotBg[index]:addInputEvent("Mouse_Out", "")
    self._ui._selectRewardSlotBg[index]:registerPadEvent(__eConsoleUIPadEvent_X, "")
    self._uiBackSelectReward[index]:SetShow(false)
    if index < #self._selectReward then
      self:setReward(self._listSelectRewardSlots[index], self._selectReward[index + 1], index, "sub")
      self._uiBackSelectReward[index]:SetShow(true)
    end
  end
end
function PaGlobal_QuestInfo_All:setReward(uiSlot, reward, index, questType)
  uiSlot._type = reward._type
  uiSlot:clearItem()
  if uiSlot.count ~= nil then
    uiSlot.count:SetText("")
  end
  uiSlot.icon:SetAlpha(1)
  uiSlot.icon:ChangeTextureInfoNameAsync("")
  local texturePathList = {
    [__eRewardExp] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds",
    [__eRewardSkillExp] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/SkillExp.dds",
    [__eRewardExpGrade] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/ExpGrade.dds",
    [__eRewardSkillExpGrade] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/SkillExpGrade.dds",
    [__eRewardLifeExp] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds",
    [__eRewardIntimacy] = "Icon/New_Icon/00000000_Special_Contributiveness.dds",
    [__eRewardKnowledge] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/00000000_know_icon.dds",
    [__eRewardCharacterStat] = "Icon/New_Icon/03_ETC/03_Quest_Item/familystat_001.dds",
    [__eRewardSeasonReward] = "Icon/New_Icon/03_ETC/00750592.dds",
    [__eRewardExploreExp] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/Explore.dds",
    [__eRewardFamilyStat] = ""
  }
  local typeStr = {
    [__eRewardExp] = "Exp",
    [__eRewardSkillExp] = "SkillExp",
    [__eRewardExpGrade] = "ExpGrade",
    [__eRewardSkillExpGrade] = "SkillExpGrade",
    [__eRewardLifeExp] = "ProductExp",
    [__eRewardIntimacy] = "Intimacy",
    [__eRewardKnowledge] = "Knowledge",
    [__eRewardCharacterStat] = "CharacterStat",
    [__eRewardSeasonReward] = "SeasonReward",
    [__eRewardExploreExp] = "ExploreExp",
    [__eRewardFamilyStat] = "FamilyStat"
  }
  local questTypeSlotBg
  if true == self._isConsole then
    if "main" == questType then
      questTypeSlotBg = self._ui._baseRewardSlotBg[index]
    else
      questTypeSlotBg = self._ui._selectRewardSlotBg[index]
    end
  end
  if nil ~= texturePathList[reward._type] then
    if uiSlot.count ~= nil then
      uiSlot.count:SetText("")
    end
    if reward._type == __eRewardFamilyStat then
      uiSlot.icon:ChangeTextureInfoNameAsync(PaGlobalFunc_GetFamilyStatRewardIconName(reward._familyStatType))
    else
      uiSlot.icon:ChangeTextureInfoNameAsync(texturePathList[reward._type])
    end
    if true == self._isConsole then
      questTypeSlotBg:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", true, \"" .. questType .. "\", " .. index .. " )")
      questTypeSlotBg:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", false, \"" .. questType .. "\", " .. index .. " )")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", true, \"" .. questType .. "\", " .. index .. " )")
      uiSlot.icon:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", false, \"" .. questType .. "\", " .. index .. " )")
    end
  end
  if __eRewardItem == reward._type then
    local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(reward._item))
    uiSlot:setItemByStaticStatus(itemStatic, reward._count)
    uiSlot._item = reward._item
    if true == self._isConsole then
      if true == _ContentsGroup_RenewUI_Tooltip then
        questTypeSlotBg:registerPadEvent(__eConsoleUIPadEvent_X, "HandlePadEventX_QuestInfo_All_RewardItemTooltip(" .. index .. ", \"" .. questType .. "\")")
      elseif "main" == questType then
        questTypeSlotBg:registerPadEvent(__eConsoleUIPadEvent_X, "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Base\",true)")
        questTypeSlotBg:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Base\",false)")
      else
        questTypeSlotBg:registerPadEvent(__eConsoleUIPadEvent_X, "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Select\",true)")
        questTypeSlotBg:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Select\",false)")
      end
    elseif "main" == questType then
      uiSlot.icon:addInputEvent("Mouse_On", "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Base\",true)")
      uiSlot.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Base\",false)")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Select\",true)")
      uiSlot.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Select\",false)")
    end
  elseif __eRewardIntimacy == reward._type then
    if true == self._isConsole then
      questTypeSlotBg:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", true, \"" .. questType .. "\", " .. index .. " , " .. reward._character .. ", " .. reward._value .. ")")
      questTypeSlotBg:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", false, \"" .. questType .. "\", " .. index .. " , " .. reward._character .. ", " .. reward._value .. ")")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"Intimacy\", true, \"" .. questType .. "\", " .. index .. " , " .. reward._character .. ", " .. reward._value .. ")")
      uiSlot.icon:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"Intimacy\", false, \"" .. questType .. "\", " .. index .. " , " .. reward._character .. ", " .. reward._value .. ")")
    end
  elseif __eRewardKnowledge == reward._type then
    if true == self._isConsole then
      questTypeSlotBg:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", true, \"" .. questType .. "\", " .. index .. "," .. reward._mentalCard .. " )")
      questTypeSlotBg:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", false, \"" .. questType .. "\", " .. index .. "," .. reward._mentalCard .. " )")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"Knowledge\", true, \"" .. questType .. "\", " .. index .. "," .. reward._mentalCard .. " )")
      uiSlot.icon:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"Knowledge\", false, \"" .. questType .. "\", " .. index .. "," .. reward._mentalCard .. " )")
    end
  elseif __eRewardSeasonReward == reward._type then
    if true == self._isConsole then
      questTypeSlotBg:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", true, \"" .. questType .. "\", " .. index .. "," .. reward._season .. ")")
      questTypeSlotBg:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", false, \"" .. questType .. "\", " .. index .. "," .. reward._season .. ")")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"SeasonReward\", true, \"" .. questType .. "\", " .. index .. "," .. reward._season .. ")")
      uiSlot.icon:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"SeasonReward\", false, \"" .. questType .. "\", " .. index .. "," .. reward._season .. ")")
    end
  elseif __eRewardExploreExp == reward._type then
    if true == self._isConsole then
      questTypeSlotBg:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", true, \"" .. questType .. "\", " .. index .. "," .. reward._exploreExp .. ")")
      questTypeSlotBg:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", false, \"" .. questType .. "\", " .. index .. "," .. reward._exploreExp .. ")")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"ExploreExp\", true, \"" .. questType .. "\", " .. index .. "," .. reward._exploreExp .. ")")
      uiSlot.icon:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"ExploreExp\", false, \"" .. questType .. "\", " .. index .. "," .. reward._exploreExp .. ")")
    end
  elseif __eRewardFamilyStat == reward._type then
    if true == self._isConsole then
      questTypeSlotBg:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"FamilyStat\", true, \"" .. questType .. "\", " .. index .. "," .. reward._familyStatType .. ", " .. reward._familyStatValue .. ")")
      questTypeSlotBg:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"FamilyStat\", false, \"" .. questType .. "\", " .. index .. "," .. reward._familyStatType .. ", " .. reward._familyStatValue .. ")")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"FamilyStat\", true, \"" .. questType .. "\", " .. index .. "," .. reward._familyStatType .. ", " .. reward._familyStatValue .. ")")
      uiSlot.icon:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"FamilyStat\", false, \"" .. questType .. "\", " .. index .. "," .. reward._familyStatType .. ", " .. reward._familyStatValue .. ")")
    end
  end
end
function PaGlobal_QuestInfo_All:registEventHandler()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  registerEvent("FromClient_Worldmap_RandomQuestClicked", "FromClient_QuestInfo_All_RandomQuestClicked")
  Panel_Window_QuestInfo_All:setGlassBackground(true)
  Panel_Window_QuestInfo_All:RegisterShowEventFunc(true, "PaGlobalFunc_QuestInfo_All_ShowAni()")
  Panel_Window_QuestInfo_All:RegisterShowEventFunc(false, "PaGlobalFunc_QuestInfo_All_HideAni()")
  if true == self._isConsole then
    Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Y, "")
    Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_A, "")
    Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_X, "")
    Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleRSticEvent_QuestInfo_All_MoveScroll(1)")
    Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleRSticEvent_QuestInfo_All_MoveScroll(-1)")
  else
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_QuestInfo_All_Close()")
  end
end
function PaGlobal_QuestInfo_All:validate()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.btn_temp1:isValidate()
  self._ui.stc_subBg:isValidate()
  self._ui.txt_attributionType:isValidate()
  self._ui.txt_questGroupTitle:isValidate()
  self._ui.txt_questTitle:isValidate()
  self._ui.chk_autoNavi:isValidate()
  self._ui.chk_questNavi:isValidate()
  self._ui.chk_questGiveUp:isValidate()
  self._ui.chk_questTag:isValidate()
  self._ui.stc_questIconBg:isValidate()
  self._ui.stc_questIcon:isValidate()
  self._ui.txt_acceptNPC:isValidate()
  self._ui.txt_completeNPC:isValidate()
  self._ui.txt_condition:isValidate()
  self._ui.frame_questDesc:isValidate()
  self._ui.frame_content:isValidate()
  self._ui.txt_frameDesc:isValidate()
  self._ui.stc_rewardGroupBg:isValidate()
  self._ui.stc_baseRewardBg:isValidate()
  self._ui.txt_baseRewardTitle:isValidate()
  self._ui.stc_selectRewardBg:isValidate()
  self._ui.txt_selectRewardTitle:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_giveUp:isValidate()
  self._ui_pc.btn_callSpirit:isValidate()
  self._ui_pc.chk_questNavi:isValidate()
  self._ui_pc.chk_autoNavi:isValidate()
  self._ui_console.stc_keyGuideBg:isValidate()
  self._ui_console.stc_tooltip:isValidate()
  self._ui_console.stc_giveUp:isValidate()
  self._ui_console.stc_scroll:isValidate()
  self._ui_console.stc_navi:isValidate()
  self._ui_console.stc_close:isValidate()
end
function PaGlobal_QuestInfo_All:resize()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  local subBgAddSizeList = {
    self._ui.txt_questTitle,
    self._ui.stc_questIconBg,
    self._ui.txt_condition,
    self._ui.frame_questDesc,
    self._ui.stc_rewardGroupBg
  }
  local subBgSizeY = 0
  local gabY = 95
  for k, v in ipairs(subBgAddSizeList) do
    if nil ~= v and true == v:GetShow() then
      subBgSizeY = subBgSizeY + v:GetSizeY()
    end
  end
  if true == self._ui._stc_agrisPointDesc:GetShow() then
    subBgSizeY = subBgSizeY + self._ui._stc_agrisPointDesc:GetSizeY()
    gabY = gabY + 10
  end
  self._ui.stc_subBg:SetSize(self._ui.stc_subBg:GetSizeX(), subBgSizeY + gabY)
  local pcAddBtnSizeY = self._ui_pc.chk_questNavi:GetSizeY()
  if self._isConsole == true or self._OpenInfo._isCleared == true then
    pcAddBtnSizeY = -10
  end
  local panelSizeY = self._ui.stc_titleBg:GetSizeY() + self._ui.stc_subBg:GetSizeY() + pcAddBtnSizeY
  Panel_Window_QuestInfo_All:SetSize(Panel_Window_QuestInfo_All:GetSizeX(), panelSizeY + 10)
  for k, v in ipairs(self._ui) do
    if nil ~= v and true == v:GetShow() then
      v:ComputePos()
    end
  end
  if true == self._isConsole then
    local keyGuideList = {
      self._ui_console.stc_tooltip,
      self._ui_console.stc_scroll,
      self._ui_console.stc_giveUp,
      self._ui_console.stc_navi,
      self._ui_console.stc_close
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui_console.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
    if true == self._ui_pc._btn_accept:GetShow() or true == self._ui_pc._btn_cancel:GetShow() then
      self._ui_pc._btn_accept:ComputePos()
      self._ui_pc._btn_cancel:ComputePos()
    end
    local bottomBtnList = {
      [1] = self._ui_pc.chk_autoNavi,
      [2] = self._ui_pc.chk_questNavi,
      [3] = self._ui_pc.btn_callSpirit,
      [4] = self._ui_pc.btn_giveUp
    }
    local spanSizeX = 10
    for i = 1, #bottomBtnList do
      if nil ~= bottomBtnList[i] and true == bottomBtnList[i]:GetShow() then
        bottomBtnList[i]:SetSpanSize(spanSizeX, bottomBtnList[i]:GetSpanSize().y)
        spanSizeX = spanSizeX + bottomBtnList[i]:GetSizeX() + 10
        bottomBtnList[i]:ComputePos()
      end
    end
  end
end
function PaGlobal_QuestInfo_All:rePosition()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  local parent
  if Panel_Window_Quest_All:GetShow() == true then
    parent = Panel_Window_Quest_All
  end
  if Panel_Window_TotalSearch ~= nil and Panel_Window_TotalSearch:GetShow() == true then
    parent = Panel_Window_TotalSearch
  end
  if parent ~= nil then
    if parent:IsUISubApp() == true then
      Panel_Window_QuestInfo_All:SetPosX(parent:GetScreenParentPosX() + parent:GetSizeX() + 5)
      Panel_Window_QuestInfo_All:SetPosY(parent:GetScreenParentPosY())
      PaGlobal_QuestInfo_All:open()
      Panel_Window_QuestInfo_All:OpenUISubApp()
    else
      Panel_Window_QuestInfo_All:SetPosX(parent:GetPosX() + parent:GetSizeX() + 5)
      Panel_Window_QuestInfo_All:SetPosY(parent:GetPosY())
    end
  else
    Panel_Window_QuestInfo_All:SetPosX(getScreenSizeX() - getScreenSizeX() / 2 - Panel_Window_QuestInfo_All:GetSizeX() / 2)
    Panel_Window_QuestInfo_All:SetPosY(getScreenSizeY() - getScreenSizeY() / 2 - Panel_Window_QuestInfo_All:GetSizeY() / 2)
  end
end
function questInfoTooltip(isShow)
  if nil == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = "\236\149\136\235\130\180"
  local desc = "\236\162\140\237\129\180\235\166\173 : \236\153\132\235\163\140\n\237\156\160\237\129\180\235\166\173 : \236\136\152\235\157\189\n\236\154\176\237\129\180\235\166\173 : \236\161\176\234\177\180 \235\139\172\236\132\177"
  local control = PaGlobal_QuestInfo_All._ui.btn_temp1
  TooltipSimple_Show(control, name, desc, false)
end
