function PaGlobal_FishCompetitionMyReward:initialize()
  if nil == Panel_Window_FishCompetitionMyReward or true == PaGlobal_FishCompetitionMyReward._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlInit()
  self:setConsoleUI()
  self:registerEventHandler()
  self._initialize = true
end
function PaGlobal_FishCompetitionMyReward:controlInit()
  self._ui.stc_titleArea = UI.getChildControl(Panel_Window_FishCompetitionMyReward, "Static_TitleArea")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleArea, "Button_Close_PCUI")
  self._ui.stc_contentsArea = UI.getChildControl(Panel_Window_FishCompetitionMyReward, "Static_ContentsArea")
  self._ui.list2_myReward = UI.getChildControl(self._ui.stc_contentsArea, "List2_MyReward")
  self._ui.txt_noReward = UI.getChildControl(self._ui.stc_contentsArea, "StaticText_Noreward")
  self._ui.btn_receive = UI.getChildControl(self._ui.stc_contentsArea, "Button_Recieve")
  local listContent = UI.getChildControl(self._ui.list2_myReward, "List2_1_Content")
  local stc_template = UI.getChildControl(listContent, "Static_RewardBg_Template")
  local itemSlot = UI.getChildControl(stc_template, "Static_Slot_BgTemplate")
  local titleItemSlot = UI.getChildControl(stc_template, "Static_Slot_BgTemplate_1")
  local slot = {}
  SlotItem.new(slot, "myRewardSlot_", 0, itemSlot, self._slotConfig)
  slot:createChild()
  slot.empty = true
  slot:clearItem()
  slot.icon:SetPosX(1)
  slot.icon:SetPosY(1)
  slot.icon:SetSize(40, 40)
  local titleSlot = {}
  SlotItem.new(titleSlot, "myRewardTitleSlot_", 0, titleItemSlot, self._slotConfig)
  titleSlot:createChild()
  titleSlot.empty = true
  titleSlot:clearItem()
  titleSlot.icon:SetPosX(1)
  titleSlot.icon:SetPosY(1)
  titleSlot.icon:SetSize(40, 40)
end
function PaGlobal_FishCompetitionMyReward:setConsoleUI()
  self._ui.btn_close:SetShow(self._isConsole == false)
end
function PaGlobal_FishCompetitionMyReward:registerEventHandler()
  if Panel_Window_FishCompetitionMyReward == nil then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_FishCompetitionMyReward_Close()")
  self._ui.btn_receive:addInputEvent("Mouse_LUp", "PaGlobal_FishCompetitionMyReward_ReceiveReward()")
  self._ui.list2_myReward:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_FishCompetitionMyReward_CreateContent")
  self._ui.list2_myReward:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_UpdateFishCompetitionMyReward", "FromClient_UpdateFishCompetitionMyReward")
end
function PaGlobal_FishCompetitionMyReward:prepareOpen()
  if Panel_Window_FishCompetitionMyReward == nil then
    return
  end
  self:open()
end
function PaGlobal_FishCompetitionMyReward:open()
  if Panel_Window_FishCompetitionMyReward == nil or true == Panel_Window_FishCompetitionMyReward:GetShow() then
    return
  end
  Panel_Window_FishCompetitionMyReward:SetShow(true)
end
function PaGlobal_FishCompetitionMyReward:prepareClose()
  if Panel_Window_FishCompetitionMyReward == nil or false == Panel_Window_FishCompetitionMyReward:GetShow() then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  self:close()
end
function PaGlobal_FishCompetitionMyReward:close()
  if Panel_Window_FishCompetitionMyReward == nil or false == Panel_Window_FishCompetitionMyReward:GetShow() then
    return
  end
  Panel_Window_FishCompetitionMyReward:SetShow(false)
end
function PaGlobal_FishCompetitionMyReward:update()
  if Panel_Window_FishCompetitionMyReward == nil then
    return
  end
  local rewardSize = ToClient_GetMyRewardSize()
  self._ui.txt_noReward:SetShow(rewardSize == 0)
  self._ui.btn_receive:SetShow(rewardSize ~= 0)
  local listManager = self._ui.list2_myReward:getElementManager()
  listManager:clearKey()
  for index = 0, rewardSize - 1 do
    listManager:pushKey(toInt64(0, index))
  end
end
function PaGlobal_FishCompetitionMyReward:createContent(content, key)
  if Panel_Window_FishCompetitionMyReward == nil or content == nil or key == nil then
    return
  end
  local index = Int64toInt32(key)
  local myReward = ToClient_GetFishCompetitionMyReward(index)
  local itemKey = myReward:getRewardItemKey()
  local stc_background = UI.getChildControl(content, "Static_RewardBg_Template")
  local txt_fishName = UI.getChildControl(stc_background, "StaticText_FishName")
  txt_fishName:SetText(myReward:getFishName())
  txt_fishName:SetFontColor(PaGlobal_FishCompetition._gradeColor[myReward:getFishGrade()])
  local txt_myRank = UI.getChildControl(stc_background, "StaticText_TierTamplate")
  txt_myRank:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_FISHEVENT_MYRANK", "rank", tostring(myReward:getMyRank())))
  local stc_slotBackground = UI.getChildControl(stc_background, "Static_Slot_BgTemplate")
  local stc_titleSlotBackground = UI.getChildControl(stc_background, "Static_Slot_BgTemplate_1")
  slot = {}
  SlotItem.reInclude(slot, "myRewardSlot_", 0, stc_slotBackground, self._slotConfig)
  slot:clearItem()
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  slot:setItemByStaticStatus(itemSSW, 1)
  slot.icon:addInputEvent("Mouse_On", "HandleEventLUp_FishCompetitionMyReward_Tooltip(" .. tostring(index) .. "," .. tostring(false) .. "," .. tostring(false) .. ")")
  slot.icon:addInputEvent("Mouse_Out", "HandleEventLUp_FishCompetitionMyReward_Tooltip(" .. tostring(index) .. "," .. tostring(true) .. "," .. tostring(false) .. ")")
  local titleItemKey = myReward:getRewardTitleKey()
  if titleItemKey == __eItemKeyUndefined then
    stc_titleSlotBackground:SetShow(false)
    return
  else
    stc_titleSlotBackground:SetShow(true)
  end
  titleSlot = {}
  SlotItem.reInclude(titleSlot, "myRewardTitleSlot_", 0, stc_titleSlotBackground, self._slotConfig)
  titleSlot:clearItem()
  titleSlot.icon:SetShow(true)
  local titleItemSSW = getItemEnchantStaticStatus(ItemEnchantKey(titleItemKey))
  titleSlot:setItemByStaticStatus(titleItemSSW, 1)
  titleSlot.icon:addInputEvent("Mouse_On", "HandleEventLUp_FishCompetitionMyReward_Tooltip(" .. tostring(index) .. "," .. tostring(false) .. "," .. tostring(true) .. ")")
  titleSlot.icon:addInputEvent("Mouse_Out", "HandleEventLUp_FishCompetitionMyReward_Tooltip(" .. tostring(index) .. "," .. tostring(true) .. "," .. tostring(true) .. ")")
end
