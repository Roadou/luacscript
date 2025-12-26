function PaGlobal_FishCompetitionRewardInfo:initialize()
  if nil == Panel_Window_FishCompetitionRewardInfo or true == PaGlobal_FishCompetitionRewardInfo._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlInit()
  self:setConsoleUI()
  self:registerEventHandler()
  self._initialize = true
end
function PaGlobal_FishCompetitionRewardInfo:controlInit()
  self._ui.stc_titleArea = UI.getChildControl(Panel_Window_FishCompetitionRewardInfo, "Static_TitleArea")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleArea, "Button_Close_PCUI")
  self._ui.stc_contentsArea = UI.getChildControl(Panel_Window_FishCompetitionRewardInfo, "Static_ContentsArea")
  for index = 1, self._rewardCount do
    self._ui.stc_tierBg[index] = UI.getChildControl(self._ui.stc_contentsArea, "Static_" .. index .. "TierBg")
  end
  for grade = self._startGrade, self._endGrade do
    self._ui.stc_gradeSlot[grade] = {}
  end
  for index = 1, self._rewardCount do
    self._ui.txt_rank[index] = UI.getChildControl(self._ui.stc_tierBg[index], "StaticText_" .. index .. "Tier")
    self._ui.stc_gradeSlot[2][index] = UI.getChildControl(self._ui.stc_tierBg[index], "Static_Slot_BlueBg")
    self._ui.stc_gradeSlot[3][index] = UI.getChildControl(self._ui.stc_tierBg[index], "Static_Slot_YellowBg")
    self._ui.stc_gradeSlot[4][index] = UI.getChildControl(self._ui.stc_tierBg[index], "Static_Slot_RedBg")
  end
  for index = 1, self._rewardCount do
    for grade = self._startGrade, self._endGrade do
      local slot = {}
      SlotItem.new(slot, "fishRewardSlot_" .. grade, index, self._ui.stc_gradeSlot[grade][index], self._slotConfig)
      slot:createChild()
      slot.empty = true
      slot:clearItem()
      slot.icon:SetPosX(1)
      slot.icon:SetPosY(1)
      slot.icon:SetSize(40, 40)
    end
  end
end
function PaGlobal_FishCompetitionRewardInfo:setConsoleUI()
  self._ui.btn_close:SetShow(self._isConsole == false)
  if _ContentsGroup_UsePadSnapping == true then
    local bg = UI.getChildControl(Panel_Window_FishCompetitionRewardInfo, "Static_KeyGuide_ConsoleUI_Import")
    local keyguide_B = UI.getChildControl(bg, "StaticText_B_ConsoleUI")
    local keyguide_X = UI.getChildControl(bg, "StaticText_X_ConsoleUI")
    PaGlobalFunc_ConsoleKeyGuide_SetAlign({keyguide_X, keyguide_B}, bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_FishCompetitionRewardInfo:registerEventHandler()
  if Panel_Window_FishCompetitionRewardInfo == nil then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_FishCompetitionRewardInfo_Close()")
end
function PaGlobal_FishCompetitionRewardInfo:prepareOpen()
  if Panel_Window_FishCompetitionRewardInfo == nil then
    return
  end
  self:update()
  self:open()
end
function PaGlobal_FishCompetitionRewardInfo:open()
  if Panel_Window_FishCompetitionRewardInfo == nil or true == Panel_Window_FishCompetitionRewardInfo:GetShow() then
    return
  end
  Panel_Window_FishCompetitionRewardInfo:SetShow(true)
end
function PaGlobal_FishCompetitionRewardInfo:prepareClose()
  if Panel_Window_FishCompetitionRewardInfo == nil or false == Panel_Window_FishCompetitionRewardInfo:GetShow() then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  self:close()
end
function PaGlobal_FishCompetitionRewardInfo:close()
  if Panel_Window_FishCompetitionRewardInfo == nil or false == Panel_Window_FishCompetitionRewardInfo:GetShow() then
    return
  end
  Panel_Window_FishCompetitionRewardInfo:SetShow(false)
end
function PaGlobal_FishCompetitionRewardInfo:update()
  for grade = self._startGrade, self._endGrade do
    self._rewardItemKeyList[grade] = {}
  end
  for index = 1, self._rewardCount do
    local rankRange = ToClient_GetFishCompetitionRankByIndex(index - 1)
    if index <= self._singleRankCount then
      self._ui.txt_rank[index]:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_FISHEVENT_MYRANK", "rank", tostring(rankRange)))
    else
      self._ui.txt_rank[index]:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_FISHEVENT_RANKARRANGE", "rank", tostring(rankRange)))
    end
    for grade = self._startGrade, self._endGrade do
      self._rewardItemKeyList[grade][index] = ToClient_GetCompetitionRewardByGradeAndIndex(grade, index - 1)
      slot = {}
      SlotItem.reInclude(slot, "fishRewardSlot_" .. grade, index, self._ui.stc_gradeSlot[grade][index], self._slotConfig)
      slot:clearItem()
      slot.icon:SetShow(true)
      local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(self._rewardItemKeyList[grade][index]))
      slot:setItemByStaticStatus(itemSSW, 1)
      if _ContentsGroup_UsePadSnapping == true then
        self._ui.stc_gradeSlot[grade][index]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_FishCompetitionRewardInfo_Tooltip(" .. tostring(grade) .. "," .. tostring(index) .. "," .. tostring(false) .. ")")
      else
        slot.icon:addInputEvent("Mouse_On", "HandleEventLUp_FishCompetitionRewardInfo_Tooltip(" .. tostring(grade) .. "," .. tostring(index) .. "," .. tostring(false) .. ")")
        slot.icon:addInputEvent("Mouse_Out", "HandleEventLUp_FishCompetitionRewardInfo_Tooltip(" .. tostring(grade) .. "," .. tostring(index) .. "," .. tostring(true) .. ")")
      end
    end
  end
end
