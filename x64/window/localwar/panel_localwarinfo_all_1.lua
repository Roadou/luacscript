function PaGlobal_LocalWarInfo_All_New:initialize()
  if true == self._initialize then
    return
  end
  PaGlobal_LocalWarInfo_All_New:controlAll_Init()
  PaGlobal_LocalWarInfo_All_New:controlPc_Init()
  PaGlobal_LocalWarInfo_All_New:controlConsole_Init()
  PaGlobal_LocalWarInfo_All_New:controlSetShow()
  PaGlobal_LocalWarInfo_All_New:registEventHandler()
  PaGlobal_LocalWarInfo_All_New:validate()
  PaGlobal_LocalWarInfo_All_New:setDescriptionString(false)
  FromClient_LocalWarInfo_All_ResizePanel()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._isOccupationDesc = _ContentsGroup_LocalWarOccupation
  self._initialize = true
end
function PaGlobal_LocalWarInfo_All_New:controlAll_Init()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  self._ui._stc_titleBG = UI.getChildControl(Panel_LocalWarInfo_All, "Static_TitleBG")
  self._ui._stc_leftBG = UI.getChildControl(Panel_LocalWarInfo_All, "Static_LeftBG")
  self._ui._stc_rightBG = UI.getChildControl(Panel_LocalWarInfo_All, "Static_RightArea")
  local subTitleBg = UI.getChildControl(self._ui._stc_leftBG, "Static_SubTitleGroup")
  self._ui._list2_serverList = UI.getChildControl(subTitleBg, "List2_ServerList")
  self._ui._stc_banner = UI.getChildControl(self._ui._stc_leftBG, "Static_EventBanner")
  local eventDate = UI.getChildControl(self._ui._stc_banner, "StaticText_Date")
  if false == isGameTypeKorea() then
    eventDate:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TERMIAN_PVSC_DATE_GLOBAL"))
  end
  self._ui._txt_season = UI.getChildControl(self._ui._stc_leftBG, "StaticText_Season")
  self._ui._txt_disableCamo = UI.getChildControl(self._ui._stc_leftBG, "StaticText_DisableCamo")
  self._ui._stc_rewardAreaBG = UI.getChildControl(self._ui._stc_rightBG, "Static_RewardAreaBg")
  self._ui._stc_winRewardSlotBG = UI.getChildControl(self._ui._stc_rewardAreaBG, "Static_WinRewardSlotBg")
  self._ui._stc_loseRewardSlotBG = UI.getChildControl(self._ui._stc_rewardAreaBG, "Static_LoseRewardSlotBg")
  self._ui._frame_desc = UI.getChildControl(self._ui._stc_rightBG, "Frame_Description")
  local content = self._ui._frame_desc:GetFrameContent()
  local vScroll = self._ui._frame_desc:GetVScroll()
  self._ui._penalty._txt_title = UI.getChildControl(content, "RadioButton_Penalty")
  self._ui._penalty._stc_background = UI.getChildControl(content, "Static_BG_1")
  for index = 1, self._penaltyCount do
    self._ui._penalty._txt_content[index - 1] = UI.getChildControl(self._ui._penalty._stc_background, "StaticText_Desc_Penalty_" .. tostring(index))
  end
  self._ui._rule._txt_title = UI.getChildControl(content, "StaticText_LocalWar_Rule")
  self._ui._rule._stc_background = UI.getChildControl(content, "Static_BG_2")
  for index = 1, self._ruleCount do
    self._ui._rule._txt_content[index - 1] = UI.getChildControl(self._ui._rule._stc_background, "StaticText_Desc_Rule_" .. tostring(index))
  end
  self._ui._explanation._txt_title = UI.getChildControl(content, "StaticText_LocalWar_Explanation")
  self._ui._explanation._stc_background = UI.getChildControl(content, "Static_BG_3")
  for index = 1, self._explanationCount do
    self._ui._explanation._txt_content[index - 1] = UI.getChildControl(self._ui._explanation._stc_background, "StaticText_Desc_Explanation_" .. tostring(index))
  end
  local winItemSlot = {}
  SlotItem.new(winItemSlot, "WinSlot", 0, self._ui._stc_winRewardSlotBG, self._slotConfig)
  winItemSlot:createChild()
  local winItemSSW = getItemEnchantStaticStatus(ToClient_GetRedBattleFieldRewardItemKey(true))
  winItemSlot:setItemByStaticStatus(winItemSSW, ToClient_GetRedBattleFieldRewardItemCount(true))
  winItemSlot.icon:addInputEvent("Mouse_On", "PaGlobal_LocalWarInfo_All_ShowRewardTooltip(true,true)")
  winItemSlot.icon:addInputEvent("Mouse_Out", "PaGlobal_LocalWarInfo_All_ShowRewardTooltip(true,false)")
  local loseItemSlot = {}
  SlotItem.new(loseItemSlot, "LoseSlot", 0, self._ui._stc_loseRewardSlotBG, self._slotConfig)
  loseItemSlot:createChild()
  local loseItemSSW = getItemEnchantStaticStatus(ToClient_GetRedBattleFieldRewardItemKey(false))
  loseItemSlot:setItemByStaticStatus(loseItemSSW, ToClient_GetRedBattleFieldRewardItemCount(false))
  loseItemSlot.icon:addInputEvent("Mouse_On", "PaGlobal_LocalWarInfo_All_ShowRewardTooltip(false,true)")
  loseItemSlot.icon:addInputEvent("Mouse_Out", "PaGlobal_LocalWarInfo_All_ShowRewardTooltip(false,false)")
end
function PaGlobal_LocalWarInfo_All_New:createInstanceRoomList()
  local roomCount = ToClient_requestGetInstancePrivateRoomCountWithType(__eInstanceContentsType_RedBattleField)
  if roomCount <= 0 then
    return
  end
  self._ui._list2_serverList:getElementManager():clearKey()
  for index = 0, roomCount - 1 do
    self._ui._list2_serverList:getElementManager():pushKey(index)
  end
end
function PaGlobal_LocalWarInfo_All_New:controlPc_Init()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  local titleBG = UI.getChildControl(Panel_LocalWarInfo_All, "Static_TitleBG")
  self._ui_pc._btn_close = UI.getChildControl(titleBG, "Button_Win_Close")
end
function PaGlobal_LocalWarInfo_All_New:controlConsole_Init()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  self._ui_console._stc_keyguideBG = UI.getChildControl(Panel_LocalWarInfo_All, "Static_KeyGuide_Console")
  self._ui_console._stc_keyguideA = UI.getChildControl(self._ui_console._stc_keyguideBG, "StaticText_A_ConsoleUI")
  self._ui_console._stc_keyguideB = UI.getChildControl(self._ui_console._stc_keyguideBG, "StaticText_B_ConsoleUI")
  PaGlobal_LocalWarInfo_All_New:alignKeyGuides()
end
function PaGlobal_LocalWarInfo_All_New:alignKeyGuides()
  local keyGuides = {
    self._ui_console._stc_keyguideA,
    self._ui_console._stc_keyguideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console._stc_keyguideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_LocalWarInfo_All_New:controlSetShow()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  self._ui_pc._btn_close:SetShow(not self._isConsole)
  self._ui_console._stc_keyguideBG:SetShow(self._isConsole)
end
function PaGlobal_LocalWarInfo_All_New:registEventHandler()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_LocalWarInfo_All_ResizePanel")
  registerEvent("FromClient_UpdateRedBattleFieldStatus", "FromClient_LocalWarInfo_All_New_UpdateLocalWarStatus")
  registerEvent("FromClient_responseInstancePrivateRoomIndexByType", "FromClient_LocalWarInfo_All_New_UpdateInstanceRoom")
  self._ui._list2_serverList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_LocalWarInfo_All_New_UpdateServerList")
  self._ui._list2_serverList:createChildContent(__ePAUIList2ElementManagerType_List)
  if true == self._isConsole then
  else
    self._ui_pc._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_LocalWarInfo_All_New_Close()")
    self._ui._penalty._txt_title:addInputEvent("Mouse_LUp", "HandleEventLUp_LocalWarInfo_All_DescriptionCheck(0)")
    self._ui._rule._txt_title:addInputEvent("Mouse_LUp", "HandleEventLUp_LocalWarInfo_All_DescriptionCheck(1)")
    self._ui._explanation._txt_title:addInputEvent("Mouse_LUp", "HandleEventLUp_LocalWarInfo_All_DescriptionCheck(2)")
    self._ui._txt_season:addInputEvent("Mouse_On", "HandleEventOnOut_LocalWarInfo_All_SeasonIconTooltip(true)")
    self._ui._txt_season:addInputEvent("Mouse_Out", "HandleEventOnOut_LocalWarInfo_All_SeasonIconTooltip(false)")
    self._ui._txt_disableCamo:addInputEvent("Mouse_On", "HandleEventOnOut_LocalWarInfo_All_DisableCamoIconTooltip(true)")
    self._ui._txt_disableCamo:addInputEvent("Mouse_Out", "HandleEventOnOut_LocalWarInfo_All_DisableCamoIconTooltip(false)")
  end
end
function PaGlobal_LocalWarInfo_All_New:prepareOpen()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  ToClient_requestInstanceFieldRoomList(true, __eInstanceContentsType_RedBattleField)
  if false == self._isConsole then
    audioPostEvent_SystemUi(1, 6)
  else
    _AudioPostEvent_SystemUiForXBOX(1, 18)
  end
  Panel_LocalWarInfo_All:RegisterUpdateFunc("PaGlobal_LocalWarInfo_All_New_InformationUpdate")
  self._ui._penalty._txt_title:SetCheck(true)
  self._ui._penalty._stc_background:SetShow(false)
  self._ui._penalty._stc_background:SetSize(self._ui._penalty._stc_background:GetSizeX(), 1)
  self._ui._rule._txt_title:SetCheck(false)
  self._ui._rule._stc_background:SetShow(false)
  self._ui._rule._stc_background:SetSize(self._ui._rule._stc_background:GetSizeX(), 1)
  self._ui._explanation._txt_title:SetCheck(false)
  self._ui._explanation._stc_background:SetShow(false)
  self._ui._explanation._stc_background:SetSize(self._ui._explanation._stc_background:GetSizeX(), 1)
  PaGlobal_LocalWarInfo_All_New:open()
end
function PaGlobal_LocalWarInfo_All_New:open()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  Panel_LocalWarInfo_All:SetShow(true, true)
end
function PaGlobal_LocalWarInfo_All_New:prepareClose()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  if false == self._isConsole then
    audioPostEvent_SystemUi(1, 1)
  else
    _AudioPostEvent_SystemUiForXBOX(1, 17)
  end
  self._openDesc = -1
  self._ui._penalty._txt_title:SetCheck(false)
  self._ui._rule._txt_title:SetCheck(false)
  self._ui._explanation._txt_title:SetCheck(false)
  self._ui._penalty._stc_background:SetShow(false)
  self._ui._rule._stc_background:SetShow(false)
  self._ui._explanation._stc_background:SetShow(false)
  self._ui._penalty._stc_background:SetSize(self._ui._penalty._stc_background:GetSizeX(), 1)
  self._ui._rule._stc_background:SetSize(self._ui._rule._stc_background:GetSizeX(), 1)
  self._ui._explanation._stc_background:SetSize(self._ui._explanation._stc_background:GetSizeX(), 1)
  TooltipSimple_Hide()
  Panel_LocalWarInfo_All:ClearUpdateLuaFunc()
  PaGlobal_LocalWarInfo_All_New:close()
end
function PaGlobal_LocalWarInfo_All_New:close()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  Panel_LocalWarInfo_All:SetShow(false, true)
end
function PaGlobal_LocalWarInfo_All_New:validate()
  if nil == Panel_LocalWarInfo_All then
    return
  end
end
function PaGlobal_LocalWarInfo_All_New:setDescriptionString()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  self._maxRuleSize = 40
  local ruleStringHeader = "LUA_LOCALWARINFO_DESC_RULETEXT_"
  if true == self._isOccupationDesc then
    ruleStringHeader = "LUA_JOIN_LOCALWAR_1_RULE"
  end
  for index = 1, self._penaltyCount do
    local control = self._ui._penalty._txt_content[index - 1]
    control:SetTextMode(__eTextMode_AutoWrap)
    control:SetAutoResize(true)
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_REDBATTLEFIELDINFO_DESC_KICKOUT_" .. tostring(index)))
    self._maxPenaltySize = self._maxPenaltySize + control:GetTextSizeY()
  end
  for index = 1, self._ruleCount do
    local control = self._ui._rule._txt_content[index - 1]
    control:SetTextMode(__eTextMode_AutoWrap)
    control:SetAutoResize(true)
    if index == 2 then
      control:SetText(PAGetStringParam2(Defines.StringSheet_GAME, ruleStringHeader .. tostring(index), "playTime", ToClient_GetPlayingTimeRedBattleField() / 60, "intrusionTime", ToClient_GetIntrusionTimeRedBattleField() / 60))
    else
      control:SetText(PAGetString(Defines.StringSheet_GAME, ruleStringHeader .. tostring(index)))
    end
    self._maxRuleSize = self._maxRuleSize + control:GetTextSizeY()
  end
  for index = 1, self._explanationCount do
    local control = self._ui._explanation._txt_content[index - 1]
    control:SetTextMode(__eTextMode_AutoWrap)
    control:SetAutoResize(true)
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_DESC_EXPLANATION_" .. tostring(index)))
    self._maxExplanationSize = self._maxExplanationSize + control:GetTextSizeY()
  end
  for index = 0, #self._ui._penalty._txt_content do
    self._ui._penalty._txt_content[index]:SetPosX(5)
  end
  self._ui._penalty._txt_content[0]:SetPosY(5)
  self._ui._penalty._txt_content[1]:SetPosY(self._ui._penalty._txt_content[0]:GetPosY() + self._ui._penalty._txt_content[0]:GetTextSizeY() + 2)
  for index = 0, #self._ui._rule._txt_content do
    self._ui._rule._txt_content[index]:SetPosX(5)
  end
  self._ui._rule._txt_content[0]:SetPosY(5)
  self._ui._rule._txt_content[1]:SetPosY(self._ui._rule._txt_content[0]:GetPosY() + self._ui._rule._txt_content[0]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[2]:SetPosY(self._ui._rule._txt_content[1]:GetPosY() + self._ui._rule._txt_content[1]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[3]:SetPosY(self._ui._rule._txt_content[2]:GetPosY() + self._ui._rule._txt_content[2]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[4]:SetPosY(self._ui._rule._txt_content[3]:GetPosY() + self._ui._rule._txt_content[3]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[5]:SetPosY(self._ui._rule._txt_content[4]:GetPosY() + self._ui._rule._txt_content[4]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[6]:SetPosY(self._ui._rule._txt_content[5]:GetPosY() + self._ui._rule._txt_content[5]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[7]:SetPosY(self._ui._rule._txt_content[6]:GetPosY() + self._ui._rule._txt_content[6]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[8]:SetPosY(self._ui._rule._txt_content[7]:GetPosY() + self._ui._rule._txt_content[7]:GetTextSizeY() + 2)
  for index = 0, #self._ui._explanation._txt_content do
    self._ui._explanation._txt_content[index]:SetPosX(5)
  end
  self._ui._explanation._txt_content[0]:SetPosY(5)
  self._ui._explanation._txt_content[1]:SetPosY(self._ui._explanation._txt_content[0]:GetPosY() + self._ui._explanation._txt_content[0]:GetTextSizeY() + 2)
  self._ui._explanation._txt_content[2]:SetPosY(self._ui._explanation._txt_content[1]:GetPosY() + self._ui._explanation._txt_content[1]:GetTextSizeY() + 2)
end
