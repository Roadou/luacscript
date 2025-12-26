function PaGlobal_GuildInfo_All:initialize()
  if true == PaGlobal_GuildInfo_All._initialize or nil == Panel_GuildInfo_All then
    return
  end
  self._ui.stc_LeftBg = UI.getChildControl(Panel_GuildInfo_All, "Static_LeftArea")
  self._ui.stc_TopBg = UI.getChildControl(self._ui.stc_LeftBg, "Static_TopArea")
  self._ui.stc_MarkBg = UI.getChildControl(self._ui.stc_TopBg, "Static_GuildMarkBG")
  self._ui.stc_Mark = UI.getChildControl(self._ui.stc_MarkBg, "Static_GuildMark")
  self._ui.stc_MarkOutLine = UI.getChildControl(self._ui.stc_MarkBg, "Static_GuildMarkInsideLine")
  self._ui.txt_Name = UI.getChildControl(self._ui.stc_TopBg, "StaticText_GuildName")
  self._ui.txt_MasterName = UI.getChildControl(self._ui.stc_TopBg, "StaticText_GuildMasterName")
  self._ui.stc_GuildServer = UI.getChildControl(self._ui.stc_TopBg, "Static_GuildServer")
  self._ui.txt_GuildServerName = UI.getChildControl(self._ui.stc_GuildServer, "StaticText_1")
  self._ui.btn_GuildServer = UI.getChildControl(self._ui.stc_TopBg, "Button_GuildServer")
  self._ui.stc_GuildMansion = UI.getChildControl(self._ui.stc_TopBg, "Static_GuildMansion")
  self._ui.txt_GuildMansionName = UI.getChildControl(self._ui.stc_GuildMansion, "StaticText_1")
  self._ui.btn_GuildMansion = UI.getChildControl(self._ui.stc_TopBg, "Button_GuildMansion")
  self._ui.stc_GuildMansion:SetShow(_ContentsGroup_GuildMansion)
  self._ui.btn_GuildMansion:SetShow(_ContentsGroup_GuildMansion)
  self._ui.btn_InfoWeb = UI.getChildControl(self._ui.stc_TopBg, "Button_GuildInfoWeb")
  self._ui.btn_MarkChange = UI.getChildControl(self._ui.stc_TopBg, "Button_GuildMarkChange")
  self._ui.txt_Grade = UI.getChildControl(self._ui.stc_TopBg, "StaticText_GuildRank")
  self._ui.btn_GradeUp = UI.getChildControl(self._ui.stc_TopBg, "Button_RankUp")
  self._ui.txt_ProtectedCount = UI.getChildControl(self._ui.stc_TopBg, "StaticText_Protect")
  self._ui.btn_IncreaseProtectedCount = UI.getChildControl(self._ui.stc_TopBg, "Button_ProtectAdd")
  self._ui.txt_GuildPoint = UI.getChildControl(self._ui.stc_TopBg, "StaticText_GuildPoint")
  self._ui.txt_RoseWarApplyPoint = UI.getChildControl(self._ui.stc_TopBg, "StaticText_RoseWarApplyPoint")
  self._ui.txt_OwnedArea = UI.getChildControl(self._ui.stc_TopBg, "StaticText_Territory")
  self._ui.btn_GuildColor = UI.getChildControl(self._ui.txt_OwnedArea, "Button_SiegeGuildColor")
  self._ui.btn_MinorSiegeJoinable = UI.getChildControl(self._ui.txt_OwnedArea, "Button_SiegeGuildPayBackPoint")
  self._ui.btn_MajorSiegeJoinable = UI.getChildControl(self._ui.txt_OwnedArea, "Button_TerritorySiegeGuild")
  self._ui.btn_DropRate = UI.getChildControl(self._ui.txt_OwnedArea, "Button_DropRate")
  self._ui.stc_MinorSiegeJoinableIcon = UI.getChildControl(self._ui.btn_MinorSiegeJoinable, "Static_Icon")
  self._ui.stc_MajorSiegeJoinableIcon = UI.getChildControl(self._ui.btn_MajorSiegeJoinable, "Static_Icon")
  self._ui.txt_Vehicle = UI.getChildControl(self._ui.stc_TopBg, "StaticText_Vehicle")
  self._ui.stc_VehicleHelp = UI.getChildControl(self._ui.stc_TopBg, "Static_GuildVehicleHelp")
  self._ui.stc_WarHpSet = UI.getChildControl(self._ui.stc_TopBg, "Static_WarHPSet")
  self._ui.stc_Reload = UI.getChildControl(self._ui.stc_TopBg, "Button_Reload")
  local moneyBg = UI.getChildControl(self._ui.stc_TopBg, "Static_MoneyBG")
  self._ui.txt_Money = UI.getChildControl(moneyBg, "StaticText_Money")
  self._ui.btn_WareHouse = UI.getChildControl(moneyBg, "Button_GuildWarehouse")
  self._ui.btn_ItemShare = UI.getChildControl(moneyBg, "Button_ItemShare")
  self._ui.btn_GuildLifeFund = UI.getChildControl(moneyBg, "Button_GuildLifeFund")
  self._ui.btn_ItemShare:SetShow(_ContentsGroup_GuildShareItemWareHouse and false == _ContentsGroup_UsePadSnapping)
  self._ui.btn_Arsha = UI.getChildControl(self._ui.stc_TopBg, "Button_Arsha")
  self._ui.btn_GetMaster = UI.getChildControl(self._ui.stc_TopBg, "Button_GetMaster")
  self._ui.btn_Recruit = UI.getChildControl(self._ui.stc_TopBg, "Button_Recruitment")
  self._ui.btn_giveaway = UI.getChildControl(self._ui.stc_TopBg, "Button_GuildPearlReward")
  self._ui.txt_giveawayCount = UI.getChildControl(self._ui.btn_giveaway, "StaticText_Count")
  self._ui.btn_MiningReward = UI.getChildControl(self._ui.stc_TopBg, "Button_MiningReward")
  self._ui.stc_MiningRewardBaseIcon = UI.getChildControl(self._ui.btn_MiningReward, "Static_Icon")
  self._ui.stc_MiningRewardAlertIcon = UI.getChildControl(self._ui.btn_MiningReward, "Static_Icon_Alert")
  self._ui.btn_GuildParty = UI.getChildControl(self._ui.stc_TopBg, "Button_GuildParty")
  self._ui.btn_Introduce = UI.getChildControl(self._ui.stc_TopBg, "Button_Introduce")
  self._ui.btn_Vaction = UI.getChildControl(self._ui.stc_TopBg, "Button_Vacation")
  self._ui.btn_VactionReturn = UI.getChildControl(self._ui.stc_TopBg, "Button_VacationReturn")
  self._ui.btn_Dismiss = UI.getChildControl(self._ui.stc_TopBg, "Button_GuildDestroyed")
  self._ui.stc_LeftBottomBg = UI.getChildControl(self._ui.stc_LeftBg, "Static_BottomArea")
  self._ui.stc_Notice_Title = UI.getChildControl(self._ui.stc_LeftBottomBg, "StaticText_NoticeTitle")
  local stc_NoticeSquareBg = UI.getChildControl(self._ui.stc_LeftBottomBg, "Stactic_NoticeSquareBg")
  self._ui.edit_NoticeCover = UI.getChildControl(stc_NoticeSquareBg, "MultilineEdit_CoverBox")
  self._ui.edit_Notice = UI.getChildControl(stc_NoticeSquareBg, "MultilineEdit_NoticeSquare")
  self._ui.btn_SaveNotice = UI.getChildControl(self._ui.edit_Notice, "Button_Write")
  local rightArea = UI.getChildControl(Panel_GuildInfo_All, "Static_RightArea")
  self._ui.stc_QuestionWar = UI.getChildControl(rightArea, "StaticText_QuestionWar")
  self._ui.stc_RightBg = UI.getChildControl(rightArea, "Static_RadioGroup")
  self._ui.rdo_Decleared = UI.getChildControl(self._ui.stc_RightBg, "RadioButton_Tab0")
  self._ui.rdo_Recieved = UI.getChildControl(self._ui.stc_RightBg, "RadioButton_Tab1")
  self._ui.stc_SelectLine = UI.getChildControl(self._ui.stc_RightBg, "Static_SelctLine")
  self._ui.stc_KeyGuide_LT = UI.getChildControl(self._ui.stc_RightBg, "Static_SelectLB_C")
  self._ui.stc_KeyGuide_RT = UI.getChildControl(self._ui.stc_RightBg, "Static_SelectRB_C")
  self._ui.stc_WarGuildList = UI.getChildControl(rightArea, "Static_WarGuildList")
  self._ui.list2_WarInfo = UI.getChildControl(self._ui.stc_WarGuildList, "List2_ToWar")
  self._ui.stc_TodayCommentBg = UI.getChildControl(rightArea, "Static_BottomArea")
  self._ui.btn_TaxPayment = UI.getChildControl(rightArea, "Button_GuildhouseTax")
  self._ui.stc_GuildMark_Console = UI.getChildControl(self._ui.stc_TopBg, "Static_GuildMark_Console")
  self._ui.stc_GuildBg_Console = UI.getChildControl(self._ui.stc_TopBg, "Static_GuildMarkBg_Console")
  self._ui.txt_TadayCommentTitle = UI.getChildControl(self._ui.stc_TodayCommentBg, "StaticText_TodayComment")
  self._ui.stc_ConsoleOnly = UI.getChildControl(self._ui.stc_TodayCommentBg, "Static_ConsoleOnlyImage")
  self._isUsePad = _ContentsGroup_UsePadSnapping
  self._isConsole = _ContentsGroup_RenewUI
  self._selfPlayer = getSelfPlayer()
  if nil == self._selfPlayer then
    UI.ASSERT_NAME(false, "GuildInfo_All_1.lua / getSelfPlayer is nil", "-")
    return
  end
  if false == _ContentsGroup_RenewUI then
    self._ui.stc_TodayCommentBg:SetAlpha(0.5)
    self._ui.stc_webControl = UI.createControl(__ePAUIControl_WebControl, self._ui.stc_TodayCommentBg, "WebControl_TodayComment")
    self._ui.stc_webControl:SetShow(true)
    self._ui.stc_webControl:SetSize(self._ui.stc_TodayCommentBg:GetSizeX() - 5, self._ui.stc_TodayCommentBg:GetSizeY() - 35)
    self._ui.stc_webControl:SetHorizonCenter()
    self._ui.stc_webControl:SetVerticalBottom()
    self._ui.stc_webControl:SetSpanSize(self._ui.stc_webControl:GetSpanSize().x, self._ui.stc_webControl:GetSpanSize().y + 5)
    self._ui.stc_webControl:ResetUrl()
    Panel_GuildInfo_All:SetChildIndex(self._ui.stc_webControl, 9999)
  end
  self._ui.txt_OwnedArea:SetTextMode(__eTextMode_LimitText)
  UI.setLimitTextAndAddTooltip(self._ui.txt_OwnedArea)
  UI.setLimitTextAndAddTooltip(self._ui.txt_Vehicle)
  self._ui.stc_WarHpSet:SetShow(false)
  if false == _ContentsGroup_Siege then
    self._ui.txt_OwnedArea:SetShow(false)
    self._ui.txt_Vehicle:SetShow(false)
    self._ui.stc_VehicleHelp:SetShow(false)
    self._ui.stc_WarHpSet:SetShow(false)
  end
  if false == _ContentsGroup_GuildServerWar then
    self._ui.stc_GuildServer:SetShow(false)
    self._ui.btn_GuildServer:SetShow(false)
    self._ui.txt_MasterName:SetSpanSize(140, self._ui.txt_MasterName:GetSpanSize().y)
  end
  self._contentsOption.isGuildBattle = ToClient_IsContentsGroupOpen("280")
  self._contentsOption.isProtectGuildMember = ToClient_IsContentsGroupOpen("52")
  self._contentsOption.isContentsGuildDuel = ToClient_IsContentsGroupOpen("69") and not self._contentsOption.isGuildBattle
  self._contentsOption.isContentsGuildInfo = ToClient_IsContentsGroupOpen("206")
  self._contentsOption.isContentsArsha = _ContentsGroup_Arsha
  self._contentsOption.isContentsGuildHouse = ToClient_IsContentsGroupOpen("36")
  self._contentsOption.isPopUpContentsEnable = ToClient_IsContentsGroupOpen("240")
  PaGlobal_GuildInfo_All:validate()
  PaGlobal_GuildInfo_All:registEventHandler(self._isUsePad)
  PaGlobal_GuildInfo_All:swichPlatform(self._isUsePad)
  PaGlobal_GuildInfo_All._initialize = true
end
function PaGlobal_GuildInfo_All:computeDescAreaPos()
  if Panel_GuildInfo_All == nil then
    return
  end
  local beginSpanY = 170
  local spanY = 30
  if _ContentsGroup_RoseWar == true then
    self._ui.txt_Grade:SetSpanSize(self._ui.txt_Grade:GetSpanSize().x, beginSpanY)
    self._ui.txt_Grade:ComputePos()
    self._ui.btn_GradeUp:SetPosXY(self._ui.txt_Grade:GetPosX() + self._ui.txt_Grade:GetSizeX() + 5, self._ui.txt_Grade:GetPosY() + self._ui.txt_Grade:GetSizeY() / 2 - self._ui.btn_GradeUp:GetSizeY() / 2)
    self._ui.stc_Reload:SetPosXY(self._ui.btn_GradeUp:GetPosX() + self._ui.btn_GradeUp:GetSizeX() + 5, self._ui.btn_GradeUp:GetPosY())
    self._ui.txt_ProtectedCount:SetSpanSize(270, self._ui.txt_Grade:GetSpanSize().y)
    self._ui.txt_ProtectedCount:ComputePos()
    self._ui.btn_IncreaseProtectedCount:SetPosXY(self._ui.txt_ProtectedCount:GetPosX() + self._ui.txt_ProtectedCount:GetSizeX() + 5, self._ui.txt_ProtectedCount:GetPosY() + self._ui.txt_ProtectedCount:GetSizeY() / 2 - self._ui.btn_IncreaseProtectedCount:GetSizeY() / 2)
    self._ui.txt_GuildPoint:SetSpanSize(self._ui.txt_GuildPoint:GetSpanSize().x, self._ui.txt_Grade:GetSpanSize().y + spanY)
    self._ui.txt_GuildPoint:ComputePos()
    self._ui.txt_OwnedArea:SetSpanSize(self._ui.txt_OwnedArea:GetSpanSize().x, self._ui.txt_GuildPoint:GetSpanSize().y + spanY)
    self._ui.txt_OwnedArea:ComputePos()
    self._ui.txt_RoseWarApplyPoint:SetSpanSize(self._ui.txt_RoseWarApplyPoint:GetSpanSize().x, self._ui.txt_OwnedArea:GetSpanSize().y + spanY)
    self._ui.txt_RoseWarApplyPoint:ComputePos()
    self._ui.txt_Vehicle:SetSpanSize(self._ui.txt_Vehicle:GetSpanSize().x, self._ui.txt_RoseWarApplyPoint:GetSpanSize().y + spanY)
    self._ui.txt_Vehicle:ComputePos()
    self._ui.stc_VehicleHelp:SetSpanSize(self._ui.txt_Vehicle:GetSpanSize().x + self._ui.txt_Vehicle:GetTextSizeX() + 10, self._ui.txt_RoseWarApplyPoint:GetSpanSize().y + spanY - 5)
    self._ui.stc_VehicleHelp:ComputePos()
    self._ui.txt_RoseWarApplyPoint:SetShow(true)
  else
    self._ui.txt_Grade:SetSpanSize(self._ui.txt_Grade:GetSpanSize().x, beginSpanY)
    self._ui.txt_Grade:ComputePos()
    self._ui.btn_GradeUp:SetPosXY(self._ui.txt_Grade:GetPosX() + self._ui.txt_Grade:GetSizeX() + 5, self._ui.txt_Grade:GetPosY() + self._ui.txt_Grade:GetSizeY() / 2 - self._ui.btn_GradeUp:GetSizeY() / 2)
    self._ui.stc_Reload:SetPosXY(self._ui.btn_GradeUp:GetPosX() + self._ui.btn_GradeUp:GetSizeX() + 5, self._ui.btn_GradeUp:GetPosY())
    self._ui.txt_ProtectedCount:SetSpanSize(self._ui.txt_ProtectedCount:GetSpanSize().x, self._ui.txt_Grade:GetSpanSize().y + spanY)
    self._ui.txt_ProtectedCount:ComputePos()
    self._ui.btn_IncreaseProtectedCount:SetPosXY(self._ui.txt_ProtectedCount:GetPosX() + self._ui.txt_ProtectedCount:GetSizeX() + 5, self._ui.txt_ProtectedCount:GetPosY() + self._ui.txt_ProtectedCount:GetSizeY() / 2 - self._ui.btn_IncreaseProtectedCount:GetSizeY() / 2)
    self._ui.txt_GuildPoint:SetSpanSize(self._ui.txt_GuildPoint:GetSpanSize().x, self._ui.txt_ProtectedCount:GetSpanSize().y + spanY)
    self._ui.txt_GuildPoint:ComputePos()
    self._ui.txt_OwnedArea:SetSpanSize(self._ui.txt_OwnedArea:GetSpanSize().x, self._ui.txt_GuildPoint:GetSpanSize().y + spanY)
    self._ui.txt_OwnedArea:ComputePos()
    self._ui.txt_Vehicle:SetSpanSize(self._ui.txt_Vehicle:GetSpanSize().x, self._ui.txt_OwnedArea:GetSpanSize().y + spanY)
    self._ui.txt_Vehicle:ComputePos()
    self._ui.stc_VehicleHelp:SetSpanSize(self._ui.txt_Vehicle:GetSpanSize().x + self._ui.txt_Vehicle:GetTextSizeX() + 10, self._ui.txt_OwnedArea:GetSpanSize().y + (spanY - 5))
    self._ui.stc_VehicleHelp:ComputePos()
    self._ui.txt_RoseWarApplyPoint:SetShow(false)
  end
end
function PaGlobal_GuildInfo_All:registEventHandler(isUsePad)
  if nil == Panel_GuildInfo_All then
    return
  end
  if true == isUsePad then
    PaGlobal_GuildInfo_All:registerInputEvent_Console()
  else
    PaGlobal_GuildInfo_All:registerInputEvent_PC()
  end
  registerEvent("FromClient_UpdateGuildCacheData", "FromClient_GuildInfo_All_ResponseDeclareGuildWarToMyGuild")
  registerEvent("FromClient_ResponseGuildUpdate", "FromClient_GuildInfo_All_GuildUpdate")
  registerEvent("ResponseGuild_invite", "FromClient_GuildInfo_All_ResonseGuildInvite")
  registerEvent("ResponseGuild_refuse", "FromClient_GuildInfo_All_ResonseGuildRefuse")
  registerEvent("EventChangeGuildInfo", "FromClient_GuildInfo_All_ActorChangeGuildInfo")
  registerEvent("FromClient_UpdateGuildContract", "FromClient_GuildInfo_All_ResponseArkMessage")
  registerEvent("FromClient_NotifyGuildMessage", "FromClient_GuildInfo_All_NotifyGuildMessage")
  registerEvent("FromClient_GuildInviteForGuildGrade", "FromClient_GuildInfo_All_GuildInviteForGuildGrade")
  registerEvent("FromClient_ResponseDeclareGuildWarToMyGuild ", "FromClient_GuildInfo_All_ResponseDeclareGuildWarToMyGuild")
  registerEvent("FromClient_RequestGuildWar", "FromClient_GuildInfo_All_ReceivedGuildWar")
  registerEvent("FromClient_ResponseGuildNotice", "FromClient_GuildInfo_All_ResponseGuildNotice")
  registerEvent("FromClient_applyVacationResult", "FromClient_GuildInfo_All_UpdateGuildNotice")
  registerEvent("FromClient_ChangeGuildMainServer", "FromClient_GuildInfo_All_GuildServerNameUpdate")
  registerEvent("FromClient_ResponseChangeMansionGuildMember", "FromClient_GuildInfo_All_GuildMansionNameUpdate")
  registerEvent("FromWeb_WebPageError", "FromWeb_GuildInfo_All_WebPageError")
  registerEvent("FromClient_ChangeUserNicknameDirectly", "FromClient_ChangeUserNicknameDirectly_GuildInfo")
  self._ui.list2_WarInfo:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_GuildInfo_All_List2Update")
  self._ui.list2_WarInfo:createChildContent(__ePAUIList2ElementManagerType_List)
  if isGameTypeTaiwan() then
    self._ui.edit_Notice:SetMaxEditLine(7)
  else
    self._ui.edit_Notice:SetMaxEditLine(10)
  end
  self._ui.edit_Notice:SetMaxInput(250)
end
function PaGlobal_GuildInfo_All:registerInputEvent_PC()
  if true == self._isUsePad then
    return
  end
  local localFunc_addTooltip = function(control, name, idx)
    if nil == control then
      return
    end
    control:addInputEvent("Mouse_On", tostring(name) .. "(true," .. idx .. ")")
    control:addInputEvent("Mouse_Out", tostring(name) .. "(false)")
  end
  localFunc_addTooltip(self._ui.btn_GetMaster, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 1)
  localFunc_addTooltip(self._ui.btn_MarkChange, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 2)
  localFunc_addTooltip(self._ui.btn_Dismiss, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 3)
  if false == isGameTypeNA() then
    localFunc_addTooltip(self._ui.txt_Name, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 4)
    localFunc_addTooltip(self._ui.txt_MasterName, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 5)
  end
  localFunc_addTooltip(self._ui.btn_InfoWeb, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 6)
  localFunc_addTooltip(self._ui.btn_WareHouse, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 7)
  localFunc_addTooltip(self._ui.btn_Arsha, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 8)
  localFunc_addTooltip(self._ui.stc_Notice_Title, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 9)
  localFunc_addTooltip(self._ui.btn_SaveNotice, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 10)
  localFunc_addTooltip(self._ui.stc_QuestionWar, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 12)
  localFunc_addTooltip(self._ui.btn_Introduce, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 13)
  localFunc_addTooltip(self._ui.btn_Vaction, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 14)
  localFunc_addTooltip(self._ui.btn_VactionReturn, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 15)
  localFunc_addTooltip(self._ui.btn_GradeUp, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 16)
  localFunc_addTooltip(self._ui.btn_Recruit, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 17)
  localFunc_addTooltip(self._ui.btn_IncreaseProtectedCount, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 18)
  localFunc_addTooltip(self._ui.txt_Vehicle, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 19)
  localFunc_addTooltip(self._ui.stc_VehicleHelp, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 29)
  localFunc_addTooltip(self._ui.btn_giveaway, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 21)
  localFunc_addTooltip(self._ui.btn_MiningReward, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 22)
  localFunc_addTooltip(self._ui.btn_ItemShare, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 23)
  localFunc_addTooltip(self._ui.btn_GuildParty, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 24)
  localFunc_addTooltip(self._ui.btn_GuildColor, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 25)
  localFunc_addTooltip(self._ui.btn_MinorSiegeJoinable, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 26)
  localFunc_addTooltip(self._ui.btn_GuildLifeFund, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 27)
  localFunc_addTooltip(self._ui.stc_Reload, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 28)
  localFunc_addTooltip(self._ui.btn_MajorSiegeJoinable, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 31)
  localFunc_addTooltip(self._ui.btn_DropRate, "HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip", 30)
  self._ui.btn_TaxPayment:addInputEvent("Mouse_On", "HandleEventOnOut_GuildInfo_All_ShowUnpaidTooltip( true )")
  self._ui.btn_TaxPayment:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildInfo_All_ShowUnpaidTooltip( false )")
  self._ui.btn_Vaction:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_GetVaction()")
  self._ui.btn_VactionReturn:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_ReturnVaction()")
  self._ui.btn_Dismiss:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_DismissGuild()")
  self._ui.btn_MarkChange:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_ChangeGuildMark()")
  self._ui.btn_GradeUp:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_IncreaseMember()")
  self._ui.btn_IncreaseProtectedCount:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_IncreaseProtectedMember()")
  local contentsOptionWeb = ToClient_IsContentsGroupOpen("206")
  self._ui.btn_InfoWeb:SetShow(contentsOptionWeb)
  self._ui.btn_InfoWeb:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildInfo_All_OpenGuildInfoWeb()")
  self._ui.btn_WareHouse:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_RequestWareHouseOpen()")
  self._ui.rdo_Decleared:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_WarInfoChange(0)")
  self._ui.rdo_Recieved:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_WarInfoChange(1)")
  self._ui.edit_NoticeCover:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_SetFocusEdit()")
  self._ui.btn_SaveNotice:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_SaveNoticeText()")
  self._ui.btn_Introduce:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_OpenIntroduce()")
  self._ui.btn_GetMaster:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_GuildMasterMandateConfirmMSG()")
  self._ui.btn_TaxPayment:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_TaxPayment()")
  self._ui.stc_GuildServer:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_OpenGuildServerSet()")
  self._ui.btn_GuildServer:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_OpenGuildServerSet()")
  self._ui.stc_GuildMansion:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_OpenSelectGuildMansion()")
  self._ui.btn_GuildMansion:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_ShowGuildMansionTeleportMessageBox()")
  self._ui.btn_ItemShare:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_RequestItemShareWareHouse()")
  self._ui.btn_GuildColor:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_OpenSetGuildColorPanel()")
  self._ui.btn_GuildLifeFund:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_RequestGuildWelfare()")
  self._ui.stc_VehicleHelp:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_HelpWikiOpen()")
  self._ui.txt_GuildServerName:SetTextMode(__eTextMode_LimitText)
  self._ui.txt_GuildMansionName:SetTextMode(__eTextMode_LimitText)
  if true == self._contentsOption.isContentsArsha and true == ToClient_IsCanDoReservationArsha() then
    self._ui.btn_Arsha:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_RequestArsha()")
  end
  if true == _ContentsGroup_Guild_JoinRequest and nil ~= Panel_Guild_JoinRequestSet then
    self._ui.btn_Recruit:addInputEvent("Mouse_LUp", "PaGlobal_GuildJoinRequestSet:open()")
  end
  if true == _ContentsGroup_GuildGiveaway then
    self._ui.btn_giveaway:addInputEvent("Mouse_LUp", "PaGlobal_GuildInfo_All:requestGiveawayList()")
  end
  if true == _ContentsGroup_SummonGuildDrill then
    self._ui.btn_MiningReward:addInputEvent("Mouse_LUp", "PaGlobal_GuildInfo_All:requestGuildRewardList()")
  end
  self._ui.btn_GuildParty:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildPartyList_All_Open()")
  self._ui.stc_Reload:addInputEvent("Mouse_LUp", "PaGlobal_GuildInfo_All:requestReloadGuildMember()")
end
function PaGlobal_GuildInfo_All:registerInputEvent_Console()
  if false == self._isUsePad then
    return
  end
  PaGlobal_GuildMain_All._ui.stc_BasicInfo_Bg:registerPadEvent(__eConsoleUIPadEvent_LT, "HandleEventPadUp_GuildInfo_All_DeclareWar()")
  PaGlobal_GuildMain_All._ui.stc_BasicInfo_Bg:registerPadEvent(__eConsoleUIPadEvent_RT, "HandleEventPadUp_GuildInfo_All_DeclareWar()")
  PaGlobal_GuildMain_All._ui.stc_BasicInfo_Bg:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_GuildFunctionPanel_All_OpenByGuildInfo()")
  self._ui.edit_Notice:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_GuildInfo_All_EndVirtualKeyboard")
end
function PaGlobal_GuildInfo_All:swichPlatform(isUsePad)
  self._ui.btn_InfoWeb:SetShow(not isUsePad)
  self._ui.btn_MarkChange:SetShow(not isUsePad)
  self._ui.btn_GradeUp:SetShow(not isUsePad)
  self._ui.btn_IncreaseProtectedCount:SetShow(not isUsePad)
  self._ui.btn_WareHouse:SetShow(not isUsePad)
  self._ui.btn_Arsha:SetShow(not isUsePad)
  self._ui.btn_GetMaster:SetShow(not isUsePad)
  self._ui.btn_Recruit:SetShow(not isUsePad)
  self._ui.btn_Introduce:SetShow(not isUsePad)
  self._ui.btn_Vaction:SetShow(not isUsePad)
  self._ui.btn_VactionReturn:SetShow(not isUsePad)
  self._ui.btn_Dismiss:SetShow(not isUsePad)
  self._ui.btn_SaveNotice:SetShow(not isUsePad)
  self._ui.stc_MarkBg:SetShow(not self._isConsole and _ContentsOption_CH_NoCustomGuildMark == false)
  self._ui.txt_TadayCommentTitle:SetShow(not self._isConsole)
  self._ui.stc_QuestionWar:SetShow(not isUsePad)
  self._ui.stc_ConsoleOnly:SetShow(self._isConsole)
  self._ui.stc_KeyGuide_LT:SetShow(isUsePad)
  self._ui.stc_KeyGuide_RT:SetShow(isUsePad)
  self._ui.stc_GuildMark_Console:SetShow(self._isConsole or _ContentsOption_CH_NoCustomGuildMark == true)
  self._ui.stc_GuildBg_Console:SetShow(self._isConsole or _ContentsOption_CH_NoCustomGuildMark == true)
  self._ui.btn_ItemShare:SetShow(_ContentsGroup_GuildShareItemWareHouse and false == _ContentsGroup_UsePadSnapping)
  self._ui.btn_GuildParty:SetShow(not isUsePad)
  self._ui.btn_MinorSiegeJoinable:SetShow(not isUsePad)
  self._ui.btn_MajorSiegeJoinable:SetShow(isUsePad == false)
  self._ui.btn_DropRate:SetShow(isUsePad == false)
  self._ui.btn_GuildLifeFund:SetShow(not isUsePad)
  self._ui.stc_Reload:SetShow(not isUsePad)
  self._ui.btn_TaxPayment:SetShow(true)
  if true == isUsePad then
    self._ui.btn_TaxPayment:SetIgnore(true)
    self._ui.btn_TaxPayment:ChangeTextureInfoNameAsync("")
    self._ui.btn_TaxPayment:SetTextHorizonRight()
  end
  if _ContentsGroup_GuildAuthoritySeparation == true then
    self._ui.btn_GuildColor:SetShow(_ContentsGroup_EditGuildColor == true and _ContentsGroup_UsePadSnapping == false and (PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_EditGuildColor) == true or ToClient_isWarCorresspondent() == true))
  else
    self._ui.btn_GuildColor:SetShow(_ContentsGroup_EditGuildColor == true and _ContentsGroup_UsePadSnapping == false and (PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_EditGuildColor) == true or ToClient_isWarCorresspondent() == true))
  end
  self:updateMinorSiegeJoinableIcon()
  self:updateMajorSiegeJoinableIcon()
  self:updateDropRateButton()
end
function PaGlobal_GuildInfo_All:update()
  if nil == Panel_GuildInfo_All then
    return
  end
  if nil == self._selfPlayer then
    UI.ASSERT_NAME(false, "GuildInfo_All_1.lua / getSelfPlayer is nil", "-")
    return
  end
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    UI.ASSERT_NAME(false, "ToClient_GetguildWrapperWrapper is nil", "-")
    return
  end
  HandleEventLUp_GuildInfo_All_WarInfoChange(self._currentTabIdx)
  PaGlobal_GuildInfo_All:checkShowButton(guildWrapper)
  PaGlobal_GuildInfo_All:CheckUnpaidTaxConsole(guildWrapper)
  PaGlobal_GuildInfo_All:alignButton()
  PaGlobal_GuildInfo_All:guildInfoUpdate(guildWrapper)
  PaGlobal_GuildInfo_All:guildWarListUpdate()
  PaGlobal_GuildInfo_All:guildNoticeUpdate(guildWrapper)
  PaGlobal_GuildInfo_All:guildServerNameUpdate(guildWrapper)
  PaGlobal_GuildInfo_All:guildMansionNameUpdate(guildWrapper)
end
function PaGlobal_GuildInfo_All:CheckUnpaidTaxConsole(guildWrapper)
  if false == self._isUsePad or nil == guildWrapper then
    return
  end
  local accumulateTax_s64 = guildWrapper:getAccumulateTax()
  local accumulateCost_s64 = guildWrapper:getAccumulateGuildHouseCost()
  local businessFunds_s64 = guildWrapper:getGuildBusinessFunds_s64()
  self._ui.btn_TaxPayment:SetShow(true)
  local unpaidTax = ""
  if accumulateTax_s64 > toInt64(0, 0) or accumulateCost_s64 > toInt64(0, 0) then
    if toInt64(0, 0) < guildWrapper:getAccumulateTax() then
      unpaidTax = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_UNPAIDTAX", "getAccumulateTax", tostring(guildWrapper:getAccumulateTax()))
    elseif toInt64(0, 0) < guildWrapper:getAccumulateGuildHouseCost() then
      unpaidTax = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_UNPAIDTAX_HOUSE", "getAccumulateGuildHouseCost", tostring(guildWrapper:getAccumulateGuildHouseCost()))
    end
  end
  self._ui.btn_TaxPayment:SetText(unpaidTax)
end
function PaGlobal_GuildInfo_All:checkShowButton(guildWrapper)
  if nil == Panel_GuildInfo_All or nil == guildWrapper or true == self._isUsePad then
    return
  end
  local isGuildMaster = self._selfPlayer:get():isGuildMaster()
  local isGuildSubMaster = self._selfPlayer:get():isGuildSubMaster()
  local isMasters = true == isGuildSubMaster or true == isGuildMaster
  local isRightGetMaster = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isRightGetMaster = guildWrapper:canMemberGetMaster(getSelfPlayer():getGuildMemberGrade())
  else
    isRightGetMaster = PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_GetMaster) == true or PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_GetMasterLowGrade) == true
  end
  self._ui.btn_GetMaster:SetIgnore(false)
  self._ui.btn_GetMaster:SetMonoTone(false)
  self._ui.btn_GetMaster:SetShow(false)
  if toInt64(0, -1) == guildWrapper:getGuildMasterUserNo() then
    if false == isGuildMaster then
      self._ui.btn_GetMaster:SetShow(true)
    end
  elseif isRightGetMaster and true == ToClient_IsAbleChangeMaster() then
    self._ui.btn_GetMaster:SetShow(true)
  end
  local isRightLifeFund = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isRightLifeFund = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_WelfareMoney)
  else
    isRightLifeFund = PaGlboalFunc_GuildMemberList_All_GetRightCheck(__eGuildRightType_WelfareMoney)
  end
  self._ui.btn_GuildLifeFund:SetShow(isRightLifeFund and false == self._isConsole)
  local isRightGuildRecruit = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isRightGuildRecruit = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_Promotion)
  else
    isRightGuildRecruit = PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_Recruitment)
  end
  self._ui.btn_Recruit:SetShow(false)
  if true == _ContentsGroup_Guild_JoinRequest then
    self._ui.btn_Recruit:SetShow(isRightGuildRecruit)
  end
  if true == _ContentsGroup_GuildGiveaway then
    self._ui.btn_giveaway:SetShow(true)
    local itemCount = ToClient_getGiveawayDataCount()
    self._ui.txt_giveawayCount:SetText(tostring(itemCount))
    self._ui.txt_giveawayCount:SetShow(itemCount > 0)
  else
    self._ui.btn_giveaway:SetShow(false)
    self._ui.txt_giveawayCount:SetShow(false)
  end
  if true == _ContentsGroup_SummonGuildDrill then
    self._ui.btn_MiningReward:SetShow(true)
    self._ui.stc_MiningRewardBaseIcon:SetShow(true)
  else
    self._ui.btn_MiningReward:SetShow(false)
    self._ui.stc_MiningRewardBaseIcon:SetShow(false)
  end
  local isIntroduceAble = true == ToClient_IsConferenceMode() or true == self._contentsOption.isContentsGuildInfo
  self._ui.btn_Introduce:SetShow(isIntroduceAble)
  local isRightIncreaseProtectedCount = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isRightIncreaseProtectedCount = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_ProtectMember)
  else
    isRightIncreaseProtectedCount = PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_ChangeProtectMemberCount)
  end
  local isProtectedAble = self._contentsOption.isProtectGuildMember and isRightIncreaseProtectedCount
  self._ui.btn_IncreaseProtectedCount:SetShow(isProtectedAble)
  local isRightArsha = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isRightArsha = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_Competition)
  else
    isRightArsha = PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_Competition)
  end
  local isArsha = true == self._contentsOption.isContentsArsha and true == ToClient_IsCanDoReservationArsha() and true == isRightArsha
  self._ui.btn_Arsha:SetShow(isArsha)
  local isWareAble = self._contentsOption.isContentsGuildHouse
  self._ui.btn_WareHouse:SetShow(isWareAble)
  local accumulateTax_s64 = guildWrapper:getAccumulateTax()
  local accumulateCost_s64 = guildWrapper:getAccumulateGuildHouseCost()
  local businessFunds_s64 = guildWrapper:getGuildBusinessFunds_s64()
  self._ui.btn_TaxPayment:SetShow(false)
  if false == self._isUsePad then
    if accumulateTax_s64 > toInt64(0, 0) or accumulateCost_s64 > toInt64(0, 0) then
      self._ui.btn_TaxPayment:SetShow(true)
      local gap = 0
      if self._ui.btn_TaxPayment:GetSizeX() < self._ui.btn_TaxPayment:GetTextSizeX() then
        gap = math.abs(self._ui.btn_TaxPayment:GetSizeX() - self._ui.btn_TaxPayment:GetTextSizeX()) + 10
      end
      self._ui.btn_TaxPayment:SetSize(self._ui.btn_TaxPayment:GetSizeX() + gap, self._ui.btn_TaxPayment:GetSizeY())
      self._ui.btn_TaxPayment:ComputePos()
    end
    if _ContentsGroup_GuildAuthoritySeparation == true then
      local isRightPayCost = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_PayGuildCost)
      self._ui.btn_TaxPayment:SetIgnore(not isRightPayCost)
    else
      self._ui.btn_TaxPayment:SetIgnore(not isMasters)
    end
  end
  local isRightMarkChange = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isRightMarkChange = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_SetGuildNameMark)
  else
    isRightMarkChange = PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_SetGuildMark)
  end
  self._ui.btn_MarkChange:SetShow(isRightMarkChange)
  local isRightGradeUp = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isRightGradeUp = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_ChangeMemberMaxCount)
  else
    isRightGradeUp = PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_ChangeMemberMaxCount)
  end
  self._ui.btn_GradeUp:SetShow(isRightGradeUp)
  local memberReload = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    memberReload = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_ReloadMemberList)
  else
    memberReload = PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_ReloadMemberList)
  end
  self._ui.stc_Reload:SetShow(memberReload)
  local isRightNotice = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isRightNotice = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_Notice)
  else
    isRightNotice = PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_Notice)
  end
  self._ui.edit_NoticeCover:SetIgnore(not isRightNotice)
  self._ui.btn_SaveNotice:SetShow(isRightNotice)
  local isRightGuildServerSet = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isRightGuildServerSet = getSelfPlayer():get():isGuildMaster()
  else
    isRightGuildServerSet = PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_GuildDestroy)
  end
  if false == isRightGuildServerSet then
    self._ui.stc_GuildServer:SetIgnore(true)
    self._ui.btn_GuildServer:SetIgnore(true)
  end
  local guildMansionOwnerNickname = guildWrapper:getGuildMansionOwnerNickname()
  self._ui.btn_GuildMansion:SetIgnore(guildMansionOwnerNickname == nil)
  if _ContentsGroup_GuildAuthoritySeparation == true then
    self._ui.btn_GuildColor:SetShow(_ContentsGroup_EditGuildColor == true and _ContentsGroup_UsePadSnapping == false and (PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_EditGuildColor) == true or ToClient_isWarCorresspondent() == true))
  else
    self._ui.btn_GuildColor:SetShow(_ContentsGroup_EditGuildColor == true and _ContentsGroup_UsePadSnapping == false and (PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_EditGuildColor) == true or ToClient_isWarCorresspondent() == true))
  end
  self:updateMinorSiegeJoinableIcon()
  self:updateMajorSiegeJoinableIcon()
  self:updateDropRateButton()
  if true == isGuildMaster then
    self._ui.btn_Vaction:SetShow(false)
    self._ui.btn_VactionReturn:SetShow(false)
    return
  end
  if false == _ContentsGroup_BattleFieldVolunteer then
    self._ui.btn_Vaction:SetShow(false)
    self._ui.btn_VactionReturn:SetShow(false)
    return
  end
  if true == PaGlobalFunc_GuildMain_All_CheckIsMecernary() then
    self._ui.btn_Vaction:SetShow(false)
    self._ui.btn_VactionReturn:SetShow(false)
    self._ui.btn_Dismiss:SetShow(false)
    self._ui.btn_Recruit:SetShow(false)
    self._ui.btn_MarkChange:SetShow(false)
    self._ui.btn_WareHouse:SetShow(false)
    self._ui.btn_ItemShare:SetShow(false)
    return
  end
  local guildMemberCount = guildWrapper:getMemberCount()
  for idx = 1, guildMemberCount do
    local memberInfo = guildWrapper:getMember(idx - 1)
    local userNo = memberInfo:getUserNo()
    local myUserNo = getSelfPlayer():get():getUserNo()
    if nil ~= memberInfo and (true == memberInfo:isSelf() or userNo == myUserNo) then
      self._isVacation = memberInfo:isVacation()
      self._ui.btn_Vaction:SetShow(not self._isVacation)
      self._ui.btn_VactionReturn:SetShow(self._isVacation)
      break
    end
  end
  self._ui.btn_ItemShare:SetShow(_ContentsGroup_GuildShareItemWareHouse and false == PaGlobalFunc_GuildMain_All_CheckIsMecernary() and false == _ContentsGroup_UsePadSnapping)
end
function PaGlobal_GuildInfo_All:alignButton()
  local btnTable = {
    [0] = self._ui.btn_Dismiss,
    self._ui.btn_Vaction,
    self._ui.btn_VactionReturn,
    self._ui.btn_Introduce,
    self._ui.btn_Recruit,
    self._ui.btn_GetMaster,
    self._ui.btn_Arsha,
    self._ui.btn_GuildParty
  }
  local count = 0
  local gap = 45
  local startPos = 10
  for idx = 0, #btnTable do
    if true == btnTable[idx]:GetShow() then
      btnTable[idx]:SetSpanSize(startPos + gap * count, btnTable[idx]:GetSpanSize().y)
      count = count + 1
    end
  end
  if true == self._ui.btn_Vaction:GetShow() then
    self._ui.btn_VactionReturn:SetSpanSize(self._ui.btn_Vaction:GetSpanSize().x, self._ui.btn_Vaction:GetSpanSize().y)
  elseif true == self._ui.btn_VactionReturn:GetShow() then
    self._ui.btn_Vaction:SetSpanSize(self._ui.btn_VactionReturn:GetSpanSize().x, self._ui.btn_VactionReturn:GetSpanSize().y)
  end
end
function PaGlobal_GuildInfo_All:guildInfoUpdate(guildWrapper)
  if nil == guildWrapper then
    return
  end
  local myGuildAllianceChair = ToClient_GetMyGuildAlliancChairGuild()
  local myGuildAllianceCache
  if nil ~= myGuildAllianceChair then
    myGuildAllianceCache = myGuildAllianceChair
  else
    myGuildAllianceCache = guildWrapper
  end
  if nil ~= guildWrapper then
    local guildRankTable = {
      [1] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_SMALL"),
      [2] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_MIDDLE"),
      [3] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIG"),
      [4] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIGGEST")
    }
    local guildRank = guildWrapper:getMemberCountLevel()
    local guildRankString = ""
    guildRankString = guildRankTable[guildRank]
    local skillPointInfo = ToClient_getSkillPointInfo(3)
    local skillPointPercent = string.format("%.0f", skillPointInfo._currentExp / skillPointInfo._nextLevelExp * 100)
    if 100 < tonumber(skillPointPercent) then
      skillPointPercent = 100
    end
    self._ui.txt_Name:SetText(guildWrapper:getName())
    local rankTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_GUILDRANK")
    self._ui.txt_Grade:SetText(rankTitle .. " " .. guildRankString .. "(" .. guildWrapper:getMemberCount() .. "/" .. guildWrapper:getJoinableMemberCount() .. ")")
    self._ui.txt_Grade:SetSize(self._ui.txt_Grade:GetTextSizeX(), self._ui.txt_Grade:GetSizeY())
    self._ui.txt_MasterName:SetText(guildWrapper:getGuildMasterName())
    self._ui.txt_MasterName:SetEnableArea(0, 0, self._ui.txt_MasterName:GetSizeX() + self._ui.txt_MasterName:GetTextSizeX() + 10, self._ui.txt_MasterName:GetSizeY())
    local ptTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_PROTECTMEMBER")
    self._ui.txt_ProtectedCount:SetText(ptTitle .. " " .. guildWrapper:getProtectGuildMemberCount() .. "/" .. guildWrapper:getAvaiableProtectGuildMemberCount())
    UI.setLimitTextAndAddTooltip(self._ui.txt_ProtectedCount)
    local pointTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_POINT")
    local percent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_SKILLPOINTPERCENT_SUBTITLE", "skillPointPercent", skillPointPercent)
    self._ui.txt_GuildPoint:SetText(pointTitle .. " " .. tostring(skillPointInfo._remainPoint) .. "/" .. tostring(skillPointInfo._acquirePoint - 1) .. " " .. percent)
    if _ContentsGroup_RoseWar == true then
      self._ui.txt_RoseWarApplyPoint:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDMAIN_BATTLEPOINT", "point", ToClient_GetRoseWarGuildApplyPoint()))
    end
    local guildMoney64 = guildWrapper:getGuildBusinessFunds_s64()
    local moneyTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_INCENTIVE_GUILDMONEY")
    self._ui.txt_Money:SetText(moneyTitle .. " " .. makeDotMoney(guildMoney64))
    local guildArea1 = ""
    local territoryKey = ""
    local territoryWarName = ""
    local areaTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_TERRITORY_TITLE")
    self._ui.txt_Vehicle:SetText("-")
    self._ui.txt_OwnedArea:SetText(areaTitle .. " - ")
    self._ui.txt_OwnedArea:removeInputEvent("Mouse_On")
    if 0 < myGuildAllianceCache:getTerritoryCount() then
      for idx = 0, myGuildAllianceCache:getTerritoryCount() - 1 do
        territoryKey = myGuildAllianceCache:getTerritoryKeyAt(idx)
        if territoryKey >= 0 then
          local territoryInfoWrapper = getTerritoryInfoWrapperByIndex(territoryKey)
          if nil ~= territoryInfoWrapper then
            guildArea1 = territoryInfoWrapper:getTerritoryName()
            local territoryComma = ", "
            if "" == territoryWarName then
              territoryComma = ""
            end
            territoryWarName = territoryWarName .. territoryComma .. guildArea1
          end
        end
      end
    end
    if "" ~= territoryWarName then
      self._ui.txt_OwnedArea:addInputEvent("Mouse_On", "HandleEventOnOut_GuildInfo_All_OwnedAreaTooltip(true, false)")
      self._ui.txt_OwnedArea:SetText(areaTitle .. " " .. territoryWarName)
    end
    local guildArea2 = ""
    local regionKey = ""
    local siegeWarName = ""
    if 0 < myGuildAllianceCache:getSiegeCount() then
      for idx = 0, myGuildAllianceCache:getSiegeCount() - 1 do
        regionKey = myGuildAllianceCache:getSiegeKeyAt(idx)
        if regionKey > 0 then
          local regionInfoWrapper = getRegionInfoWrapper(regionKey)
          if nil ~= regionInfoWrapper then
            guildArea2 = regionInfoWrapper:getAreaName()
            local siegeComma = ", "
            if "" == siegeWarName then
              siegeComma = ""
            end
            siegeWarName = siegeWarName .. siegeComma .. guildArea2
          end
        end
      end
    end
    if "" ~= siegeWarName then
      self._ui.txt_OwnedArea:addInputEvent("Mouse_On", "HandleEventOnOut_GuildInfo_All_OwnedAreaTooltip(true, true)")
      self._ui.txt_OwnedArea:SetText(areaTitle .. " " .. siegeWarName)
    end
    if "" ~= territoryWarName and "" ~= siegeWarName then
      self._ui.txt_OwnedArea:addInputEvent("Mouse_On", "HandleEventOnOut_GuildInfo_All_OwnedAreaTooltip(true, true)")
      self._ui.txt_OwnedArea:SetText(areaTitle .. " " .. territoryWarName .. ", " .. siegeWarName)
    end
    self._ui.txt_OwnedArea:SetEnableArea(0, 0, self._ui.txt_OwnedArea:GetTextSizeX(), self._ui.txt_OwnedArea:GetSizeY())
    local warHpText = self._ui.txt_OwnedArea:GetPosX() + self._ui.txt_OwnedArea:GetTextSizeX()
    self._ui.stc_WarHpSet:SetPosX(warHpText + 5)
    self._ui.txt_OwnedArea:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildInfo_All_OwnedAreaTooltip(false)")
    local guildServantElephantCount = guildStable_getServantCount(CppEnums.VehicleType.Type_Elephant)
    local guildServantShipCount = guildStable_getServantCount(CppEnums.VehicleType.Type_SailingBoat)
    local guildServantGuildDragonCount = guildStable_getServantCount(__eVehicleType_GuildDragon)
    local guilServantValueCount = ""
    if guildServantElephantCount > 0 then
      guilServantValueCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_SERVANTCOUNT_ELEPHANT_ONLY", "guildServantElephantCount", guildServantElephantCount)
    end
    if guildServantShipCount > 0 then
      if guilServantValueCount == "" then
        guilServantValueCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_SERVANTCOUNT_SAILBOAT_ONLY", "guildServantShipCount", guildServantShipCount)
      else
        guilServantValueCount = guilServantValueCount .. ", " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_SERVANTCOUNT_SAILBOAT_ONLY", "guildServantShipCount", guildServantShipCount)
      end
    end
    if guildServantGuildDragonCount > 0 then
      if guilServantValueCount == "" then
        guilServantValueCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_SERVANTCOUNT_GUILDDRAGON", "guildServantCount", guildServantGuildDragonCount)
      else
        guilServantValueCount = guilServantValueCount .. ", " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_SERVANTCOUNT_GUILDDRAGON", "guildServantCount", guildServantGuildDragonCount)
      end
    end
    local vehicleTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_SERVANT_TITLE")
    self._ui.txt_Vehicle:SetText(vehicleTitle .. " " .. guilServantValueCount)
    if false == self._isConsole and false == _ContentsOption_CH_NoCustomGuildMark then
      local isSet = setGuildTextureByGuildNo(guildWrapper:getGuildNo_s64(), self._ui.stc_Mark)
      local x1, y1, x2, y2 = 0, 0, 1, 1
      if false == isSet then
        self._ui.stc_Mark:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/Default_Buttons.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_Mark, 183, 1, 188, 6)
      end
      self._ui.stc_Mark:getBaseTexture():setUV(x1, y1, x2, y2)
      self._ui.stc_Mark:setRenderTexture(self._ui.stc_Mark:getBaseTexture())
    else
      local markData = getGuildMarkIndexByGuildNoForXBox(guildWrapper:getGuildNo_s64())
      if nil ~= markData then
        self._ui.stc_GuildBg_Console:ChangeTextureInfoNameAsync("renewal/commonicon/guildmark/console_icon_guildmark_00.dds")
        local bgx1, bgy1, bgx2, bgy2 = PaGlobalFunc_GuildMark_GetBackGroundUV(markData:getBackGroundIdx())
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_GuildBg_Console, bgx1, bgy1, bgx2, bgy2)
        self._ui.stc_GuildBg_Console:getBaseTexture():setUV(x1, y1, x2, y2)
        self._ui.stc_GuildBg_Console:setRenderTexture(self._ui.stc_GuildBg_Console:getBaseTexture())
        self._ui.stc_GuildMark_Console:ChangeTextureInfoNameAsync("renewal/commonicon/guildmark/console_icon_guildmark_00.dds")
        local iconx1, icony1, iconx2, icony2 = PaGlobalFunc_GuildMark_GetIconUV(markData:getIconIdx())
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_GuildMark_Console, iconx1, icony1, iconx2, icony2)
        self._ui.stc_GuildMark_Console:getBaseTexture():setUV(x1, y1, x2, y2)
        self._ui.stc_GuildMark_Console:setRenderTexture(self._ui.stc_GuildMark_Console:getBaseTexture())
      end
    end
    self._ui.btn_GuildColor:SetSpanSize(self._ui.txt_OwnedArea:GetTextSizeX() + 5, self._ui.btn_GuildColor:GetSpanSize().y)
    self:updateMinorSiegeJoinableIcon()
    self:updateMajorSiegeJoinableIcon()
    self:updateDropRateButton()
    self:computeDescAreaPos()
  end
end
function PaGlobal_GuildInfo_All:guildWarListUpdate()
  self._guildlistTable = {}
  self._ui.list2_WarInfo:getElementManager():clearKey()
  ToClient_RequestDeclareGuildWarToMyGuild()
  if true == self._ui.rdo_Decleared:IsCheck() then
    local listCount = ToClient_GetWarringGuildListCount()
    local maxCount = 6
    if 0 == listCount then
      if false == self._isUsePad then
        for index = 0, 1 do
          self._ui.list2_WarInfo:getElementManager():pushKey(index)
        end
      else
        self._ui.list2_WarInfo:getElementManager():pushKey(0)
      end
      return
    end
    if true == self._isUsePad then
      listCount = listCount - 1
    end
    if maxCount == listCount then
      for index = 0, listCount - 1 do
        self._ui.list2_WarInfo:getElementManager():pushKey(index)
      end
    else
      for index = 0, listCount do
        self._ui.list2_WarInfo:getElementManager():pushKey(index)
      end
    end
  else
    local listCount = ToClient_GetCountDeclareGuildWarToMyGuild()
    if 0 == listCount then
      self._ui.list2_WarInfo:getElementManager():pushKey(0)
      return
    end
    for index = 0, listCount - 1 do
      self._ui.list2_WarInfo:getElementManager():pushKey(index)
    end
  end
end
function PaGlobal_GuildInfo_All:warInfoUpdateByList2(contents, key)
  local key32 = Int64toInt32(key)
  local btn = UI.getChildControl(contents, "Button_WarGuildList_Temp")
  local txt_NameWithMark = UI.getChildControl(btn, "StaticText_GuildName")
  local stc_VertiLine1 = UI.getChildControl(btn, "Static_VerticalLine1")
  local stc_VertiLine2 = UI.getChildControl(btn, "Static_VerticalLine2")
  local txt_MasterName = UI.getChildControl(btn, "StaticText_MasterName")
  local txt_KillCount = UI.getChildControl(btn, "StaticText_KillCount")
  local txt_DeathCount = UI.getChildControl(btn, "StaticText_DeathCount")
  local btn_Cancel = UI.getChildControl(btn, "Button_Cancel")
  local btn_Add = UI.getChildControl(btn, "Button_Add")
  local txt_NoWar = UI.getChildControl(btn, "StaticText_NoWar")
  local guildMarkBgForConsole = UI.getChildControl(btn, "StaticText_GuildNameBgForConsole")
  local btn_Arbitration = UI.getChildControl(btn, "Button_Arbitration")
  btn:SetShow(true)
  btn:SetIgnore(false)
  btn:SetMonoTone(false)
  btn_Cancel:SetShow(false)
  btn_Add:SetShow(false)
  txt_NoWar:SetShow(false)
  txt_NameWithMark:SetShow(false)
  txt_MasterName:SetShow(false)
  stc_VertiLine1:SetShow(false)
  stc_VertiLine2:SetShow(false)
  txt_KillCount:SetShow(false)
  txt_DeathCount:SetShow(false)
  contents:SetShow(true)
  guildMarkBgForConsole:SetShow(false)
  txt_NameWithMark:SetText("")
  txt_MasterName:SetText("")
  btn_Arbitration:SetShow(false)
  btn_Arbitration:SetMonoTone(false)
  btn_Arbitration:SetIgnore(false)
  local declearedCount = ToClient_GetWarringGuildListCount()
  local receivedCount = ToClient_GetCountDeclareGuildWarToMyGuild()
  local isRightGuildWar = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isRightGuildWar = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_GuildWar)
  else
    isRightGuildWar = PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_GuildWar)
  end
  btn:addInputEvent("Mouse_LUp", "")
  btn:addInputEvent("Mouse_On", "")
  btn:addInputEvent("Mouse_Out", "")
  btn_Cancel:addInputEvent("Mouse_LUp", "")
  btn_Cancel:addInputEvent("Mouse_On", "")
  btn_Cancel:addInputEvent("Mouse_Out", "")
  if true == self._ui.rdo_Decleared:IsCheck() then
    if 0 == declearedCount then
      if 0 == key32 then
        txt_NoWar:SetShow(true)
        txt_NoWar:SetTextMode(__eTextMode_AutoWrap)
        txt_NoWar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_NOWAR"))
        btn:SetIgnore(true)
        btn:SetMonoTone(true)
      elseif 1 == key32 then
        if true == isRightGuildWar then
          btn_Add:SetShow(true)
          btn:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_DeclareWar()")
          btn:addInputEvent("Mouse_On", "HandleEventOnOut_GuildInfo_All_List2Tooltip( true," .. key32 .. ",0 )")
          btn:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildInfo_All_List2Tooltip( false)")
        else
          contents:SetShow(false)
        end
      end
    else
      local guildWrapper = ToClient_GetWarringGuildListAt(key32)
      if key32 < declearedCount then
        if nil ~= guildWrapper then
          local isMarkSet = false
          local guildNo64 = guildWrapper:getGuildNo()
          local isSet = setGuildTextureByGuildNo(guildNo64, txt_NameWithMark)
          btn:SetIgnore(not self._isUsePad)
          txt_NameWithMark:SetShow(true)
          txt_KillCount:SetShow(true)
          txt_DeathCount:SetShow(true)
          stc_VertiLine2:SetShow(true)
          if false == _ContentsOption_CH_NoCustomGuildMark then
            local x1, y1, x2, y2 = 0, 0, 1, 1
            if true == isSet then
              txt_NameWithMark:getBaseTexture():setUV(x1, y1, x2, y2)
              txt_NameWithMark:setRenderTexture(txt_NameWithMark:getBaseTexture())
            end
          elseif nil ~= PaGlobalFunc_ConsoleGuildMarkSet then
            guildMarkBgForConsole:SetShow(true)
            PaGlobalFunc_ConsoleGuildMarkSet(guildNo64, txt_NameWithMark, guildMarkBgForConsole)
          end
          if guildWrapper:isExist() then
            local guildName = guildWrapper:getGuildName()
            if nil == guildName then
              guildName = ""
            end
            txt_NameWithMark:SetMonoTone(false)
            txt_NameWithMark:SetText(guildName)
          else
            txt_NameWithMark:ReleaseTexture()
            txt_NameWithMark:ChangeTextureInfoNameAsync("")
            txt_NameWithMark:SetMonoTone(true)
            txt_NameWithMark:SetText(" " .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_DISSOLUTION"))
          end
          local killCount = tostring(Uint64toUint32(guildWrapper:getKillCount()))
          local deathCount = tostring(Uint64toUint32(guildWrapper:getDeathCount()))
          txt_KillCount:SetText(killCount)
          txt_DeathCount:SetText(deathCount)
          if false == self._isUsePad then
            btn_Cancel:SetShow(isRightGuildWar)
            if true == isRightGuildWar then
              btn_Cancel:addInputEvent("Mouse_On", "HandleEventOnOut_GuildInfo_All_List2Tooltip( true," .. key32 .. ",1 )")
              btn_Cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_StopWar(" .. key32 .. ")")
              btn_Cancel:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildInfo_All_List2Tooltip( false)")
            end
          elseif true == isRightGuildWar then
            btn:addInputEvent("Mouse_On", "HandleEventOnOut_GuildInfo_All_List2Tooltip( true," .. key32 .. ",1 )")
            btn:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_StopWar(" .. key32 .. ")")
            btn:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildInfo_All_List2Tooltip( false)")
          end
        end
      elseif key32 == declearedCount then
        if true == isRightGuildWar then
          btn_Add:SetShow(true)
          btn:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_DeclareWar()")
          btn:addInputEvent("Mouse_On", "HandleEventOnOut_GuildInfo_All_List2Tooltip( true," .. key32 .. ",0 )")
          btn:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildInfo_All_List2Tooltip( false)")
        else
          btn:SetShow(false)
        end
      end
    end
  elseif 0 == receivedCount then
    if 0 == key32 then
      txt_NoWar:SetShow(true)
      txt_NoWar:SetTextMode(__eTextMode_AutoWrap)
      txt_NoWar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_NOWAR"))
      btn:SetIgnore(true)
      btn:SetMonoTone(true)
    end
  else
    local guildNo = ToClient_GetDeclareGuildWarToMyGuild_s64(key32)
    local registerTime = ToClient_GetRegisterTimeDeclareGuildWarToMyGuild(key32)
    local guildWrapper = ToClient_GetGuildInfoWrapperByGuildNo(guildNo)
    if nil ~= guildWrapper then
      btn:SetIgnore(not self._isUsePad)
      txt_NameWithMark:SetShow(true)
      txt_MasterName:SetShow(true)
      stc_VertiLine1:SetShow(true)
      local isSet = setGuildTextureByGuildNo(guildWrapper:getGuildNo_s64(), txt_NameWithMark)
      local x1, y1, x2, y2 = 0, 0, 1, 1
      if false == isSet then
        txt_NameWithMark:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/Default_Buttons.dds")
        x1, y1, x2, y2 = setTextureUV_Func(txt_NameWithMark, 183, 1, 188, 6)
      end
      txt_NameWithMark:getBaseTexture():setUV(x1, y1, x2, y2)
      txt_NameWithMark:setRenderTexture(txt_NameWithMark:getBaseTexture())
      txt_NameWithMark:SetText(guildWrapper:getName())
      txt_MasterName:SetText(guildWrapper:getGuildMasterName())
      if true == PaGlobal_GuildInfo_All._isUsePad then
        btn:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_SaveNotice_Console()")
      end
      if ToClient_ShowArbitrationButton(key32) == true then
        btn_Arbitration:SetShow(true)
        if ToClient_isProgressingGuildQuest() == true then
          btn_Arbitration:SetMonoTone(true)
          btn_Arbitration:SetIgnore(true)
        else
          btn_Arbitration:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildInfo_All_OpenArbitration(" .. key32 .. ")")
          if PaGlobal_GuildInfo_All._isUsePad == true then
            btn:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_GuildInfo_All_OpenArbitration(" .. key32 .. ")")
          end
        end
      end
    end
  end
  local tempTable = {}
  tempTable._btn = btn
  tempTable._btn_Cancel = btn_Cancel
  tempTable._btn_Add = btn_Add
  self._guildlistTable[key32] = tempTable
end
function PaGlobal_GuildInfo_All:guildNoticeUpdate(guildWrapper)
  if true == self._ui.edit_Notice:GetFocusEdit() then
    return
  end
  if nil == guildWrapper then
    return
  end
  local guildNotice = guildWrapper:getGuildNotice()
  self._ui.edit_Notice:SetEditText(guildNotice, false)
end
function PaGlobal_GuildInfo_All:guildServerNameUpdate(guildWrapper)
  if nil == guildWrapper then
    return
  end
  if false == _ContentsGroup_GuildServerWar then
    return
  end
  local guildMainServerGroupNo = guildWrapper:getGuildMainServerGroupNo()
  if guildMainServerGroupNo <= 0 then
    self._ui.txt_GuildServerName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDSERVERSET_NOSET"))
    if true == self._ui.stc_GuildServer:IsIgnore() then
      self._ui.txt_GuildServerName:SetIgnore(false)
      UI.setLimitTextAndAddTooltip(self._ui.txt_GuildServerName)
      self._ui.stc_GuildServer:addInputEvent("Mouse_On", "")
      self._ui.stc_GuildServer:addInputEvent("Mouse_Out", "")
    else
      self._ui.txt_GuildServerName:SetIgnore(true)
      self._ui.txt_GuildServerName:SetTextMode(__eTextMode_LimitText)
      self._ui.txt_GuildServerName:SetText(self._ui.txt_GuildServerName:GetText())
      if true == self._ui.txt_GuildServerName:IsLimitText() then
        self._ui.stc_GuildServer:addInputEvent("Mouse_On", "PaGlobalFunc_GuildInfo_All_SetShowGuildServerTooltip(true)")
        self._ui.stc_GuildServer:addInputEvent("Mouse_Out", "PaGlobalFunc_GuildInfo_All_SetShowGuildServerTooltip(false)")
      else
        self._ui.stc_GuildServer:addInputEvent("Mouse_On", "")
        self._ui.stc_GuildServer:addInputEvent("Mouse_Out", "")
      end
    end
    return
  end
  local serverInfo = ToClient_GetNormalServerInfoByGroupNo(guildMainServerGroupNo)
  if 0 == serverInfo._serverNo then
    return
  end
  local groupName = ToClient_GetNormalServerGuildGroupNo(serverInfo._guildServerGroupNo)
  if nil == groupName then
    local channelName = getChannelName(serverInfo._worldNo, serverInfo._serverNo)
    groupName = PaGlobalFunc_Util_GetServerGroupName(channelName)
  end
  local serverName = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDSERVER_NAME", "serverName", groupName)
  self._ui.txt_GuildServerName:SetText(serverName)
  if true == self._ui.stc_GuildServer:IsIgnore() then
    self._ui.txt_GuildServerName:SetIgnore(false)
    UI.setLimitTextAndAddTooltip(self._ui.txt_GuildServerName)
    self._ui.stc_GuildServer:addInputEvent("Mouse_On", "")
    self._ui.stc_GuildServer:addInputEvent("Mouse_Out", "")
  else
    self._ui.txt_GuildServerName:SetIgnore(true)
    self._ui.txt_GuildServerName:SetTextMode(__eTextMode_LimitText)
    self._ui.txt_GuildServerName:SetText(self._ui.txt_GuildServerName:GetText())
    if true == self._ui.txt_GuildServerName:IsLimitText() then
      self._ui.stc_GuildServer:addInputEvent("Mouse_On", "PaGlobalFunc_GuildInfo_All_SetShowGuildServerTooltip(true)")
      self._ui.stc_GuildServer:addInputEvent("Mouse_Out", "PaGlobalFunc_GuildInfo_All_SetShowGuildServerTooltip(false)")
    else
      self._ui.stc_GuildServer:addInputEvent("Mouse_On", "")
      self._ui.stc_GuildServer:addInputEvent("Mouse_Out", "")
    end
  end
end
function PaGlobal_GuildInfo_All:guildMansionNameUpdate(guildWrapper)
  if nil == guildWrapper then
    return
  end
  local guildMansionOwnerNickname = guildWrapper:getGuildMansionOwnerNickname()
  if guildMansionOwnerNickname == nil then
    self._ui.txt_GuildMansionName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMANSION_NOSET"))
  else
    local guildMansionName = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDMANSION_NAME", "nickname", guildMansionOwnerNickname)
    self._ui.txt_GuildMansionName:SetText(guildMansionName)
  end
  local hasAuthority = guildWrapper:checkGuildMansionAuthority(getSelfPlayer():getGuildMemberGrade())
  if hasAuthority == false then
    self._ui.stc_GuildMansion:SetIgnore(true)
    self._ui.txt_GuildMansionName:SetIgnore(false)
    UI.setLimitTextAndAddTooltip(self._ui.txt_GuildMansionName)
    self._ui.stc_GuildMansion:addInputEvent("Mouse_On", "")
    self._ui.stc_GuildMansion:addInputEvent("Mouse_Out", "")
  else
    self._ui.stc_GuildMansion:SetIgnore(false)
    self._ui.txt_GuildMansionName:SetIgnore(true)
    self._ui.txt_GuildMansionName:SetTextMode(__eTextMode_LimitText)
    self._ui.txt_GuildMansionName:SetText(self._ui.txt_GuildMansionName:GetText())
    if true == self._ui.txt_GuildMansionName:IsLimitText() then
      self._ui.stc_GuildMansion:addInputEvent("Mouse_On", "PaGlobalFunc_GuildInfo_All_SetShowGuildMansionTooltip(true)")
      self._ui.stc_GuildMansion:addInputEvent("Mouse_Out", "PaGlobalFunc_GuildInfo_All_SetShowGuildMansionTooltip(false)")
    else
      self._ui.stc_GuildMansion:addInputEvent("Mouse_On", "")
      self._ui.stc_GuildMansion:addInputEvent("Mouse_Out", "")
    end
  end
end
function PaGlobal_GuildInfo_All:guildTodayCommentUpdate(guildWrapper)
  if nil == guildWrapper then
    return
  end
  local guildNo_s64 = guildWrapper:getGuildNo_s64()
  local myUserNo = getSelfPlayer():get():getUserNo()
  local cryptKey = getSelfPlayer():get():getWebAuthenticKeyCryptString()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  guildCommentsWebUrl = PaGlobal_URL_Check(worldNo)
  local isRightCommentAdmin = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isRightCommentAdmin = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_TodayComment)
  else
    isRightCommentAdmin = PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_TodayCommentAdmin)
  end
  local isAdmin = 0
  if true == isRightCommentAdmin then
    isAdmin = 1
  end
  if guildCommentsWebUrl ~= nil and self._isConsole == false then
    if nil == Panel_IME then
      UI.ASSERT_NAME(false, "Panel_IME is nil", "-")
      return
    end
    FGlobal_SetCandidate()
    local url = guildCommentsWebUrl .. "/guild?guildNo=" .. tostring(guildNo_s64) .. "&userNo=" .. tostring(myUserNo) .. "&certKey=" .. tostring(cryptKey) .. "&isMaster=" .. tostring(isAdmin)
    _urlCache = url
    self._ui.stc_webControl:ResetUrl()
    self._ui.stc_webControl:SetUrl(self._ui.stc_webControl:GetSizeX(), self._ui.stc_webControl:GetSizeY(), url, false, true)
    self._ui.stc_webControl:SetIME(true)
  end
end
function PaGlobal_GuildInfo_All:dataClear()
  self._currentTabIdx = 0
  self._targetGuildNo = nil
end
function PaGlobal_GuildInfo_All:updateMinorSiegeJoinableIcon()
  if Panel_GuildInfo_All == nil then
    return
  end
  if self._ui.btn_GuildColor:GetShow() == true then
    self._ui.btn_MinorSiegeJoinable:SetSpanSize(self._ui.btn_GuildColor:GetSpanSize().x + self._ui.btn_GuildColor:GetSizeX() + 5, self._ui.btn_GuildColor:GetSpanSize().y)
  else
    self._ui.btn_MinorSiegeJoinable:SetSpanSize(self._ui.btn_GuildColor:GetSpanSize().x, self._ui.btn_GuildColor:GetSpanSize().y)
  end
  if self._selfPlayer ~= nil then
    local isMinorSiegeJoinable = ToClient_IsMinorSiegeJoinable(self._selfPlayer:getGuildNo_s64())
    if isMinorSiegeJoinable == false then
      self._ui.stc_MinorSiegeJoinableIcon:SetColor(Defines.Color.C_FFD05D48)
    else
      self._ui.stc_MinorSiegeJoinableIcon:SetColor(Defines.Color.C_FFFFFFFF)
    end
  end
end
function PaGlobal_GuildInfo_All:updateMajorSiegeJoinableIcon()
  if Panel_GuildInfo_All == nil then
    return
  end
  if self._ui.btn_MinorSiegeJoinable:GetShow() == true then
    self._ui.btn_MajorSiegeJoinable:SetSpanSize(self._ui.btn_MinorSiegeJoinable:GetSpanSize().x + self._ui.btn_MinorSiegeJoinable:GetSizeX() + 5, self._ui.btn_MinorSiegeJoinable:GetSpanSize().y)
  else
    self._ui.btn_MajorSiegeJoinable:SetSpanSize(self._ui.btn_MinorSiegeJoinable:GetSpanSize().x, self._ui.btn_MinorSiegeJoinable:GetSpanSize().y)
  end
  if self._selfPlayer ~= nil then
    local isMajorSiegeJoinable = ToClient_IsMajorSiegeJoinableSiege2024()
    if isMajorSiegeJoinable == false then
      self._ui.stc_MajorSiegeJoinableIcon:SetColor(Defines.Color.C_FFD05D48)
    else
      self._ui.stc_MajorSiegeJoinableIcon:SetColor(Defines.Color.C_FFFFFFFF)
    end
  end
end
function PaGlobal_GuildInfo_All:updateDropRateButton()
  if Panel_GuildInfo_All == nil then
    return
  end
  if self._ui.btn_MajorSiegeJoinable:GetShow() == true then
    self._ui.btn_DropRate:SetSpanSize(self._ui.btn_MajorSiegeJoinable:GetSpanSize().x + self._ui.btn_MajorSiegeJoinable:GetSizeX() + 5, self._ui.btn_MajorSiegeJoinable:GetSpanSize().y)
  else
    self._ui.btn_DropRate:SetSpanSize(self._ui.btn_MajorSiegeJoinable:GetSpanSize().x, self._ui.btn_MajorSiegeJoinable:GetSpanSize().y)
  end
end
function PaGlobal_GuildInfo_All:validate()
  if nil == Panel_GuildInfo_All then
    return
  end
  self._ui.stc_LeftBg:isValidate()
  self._ui.stc_TopBg:isValidate()
  self._ui.stc_MarkBg:isValidate()
  self._ui.stc_Mark:isValidate()
  self._ui.stc_MarkOutLine:isValidate()
  self._ui.txt_Name:isValidate()
  self._ui.txt_MasterName:isValidate()
  self._ui.stc_GuildServer:isValidate()
  self._ui.txt_GuildServerName:isValidate()
  self._ui.btn_GuildServer:isValidate()
  self._ui.stc_GuildMansion:isValidate()
  self._ui.txt_GuildMansionName:isValidate()
  self._ui.btn_GuildMansion:isValidate()
  self._ui.btn_InfoWeb:isValidate()
  self._ui.btn_MarkChange:isValidate()
  self._ui.txt_Grade:isValidate()
  self._ui.btn_GradeUp:isValidate()
  self._ui.txt_ProtectedCount:isValidate()
  self._ui.btn_IncreaseProtectedCount:isValidate()
  self._ui.txt_GuildPoint:isValidate()
  self._ui.txt_RoseWarApplyPoint:isValidate()
  self._ui.txt_OwnedArea:isValidate()
  self._ui.txt_Vehicle:isValidate()
  self._ui.stc_VehicleHelp:isValidate()
  self._ui.txt_Money:isValidate()
  self._ui.btn_WareHouse:isValidate()
  self._ui.btn_Arsha:isValidate()
  self._ui.btn_GetMaster:isValidate()
  self._ui.btn_GuildColor:isValidate()
  self._ui.btn_MinorSiegeJoinable:isValidate()
  self._ui.btn_MajorSiegeJoinable:isValidate()
  self._ui.btn_DropRate:isValidate()
  self._ui.stc_MinorSiegeJoinableIcon:isValidate()
  self._ui.stc_MajorSiegeJoinableIcon:isValidate()
  self._ui.btn_Recruit:isValidate()
  self._ui.btn_Introduce:isValidate()
  self._ui.btn_Vaction:isValidate()
  self._ui.btn_VactionReturn:isValidate()
  self._ui.btn_Dismiss:isValidate()
  self._ui.stc_LeftBottomBg:isValidate()
  self._ui.stc_Notice_Title:isValidate()
  self._ui.edit_Notice:isValidate()
  self._ui.btn_SaveNotice:isValidate()
  self._ui.stc_QuestionWar:isValidate()
  self._ui.stc_RightBg:isValidate()
  self._ui.rdo_Decleared:isValidate()
  self._ui.rdo_Recieved:isValidate()
  self._ui.stc_SelectLine:isValidate()
  self._ui.stc_KeyGuide_LT:isValidate()
  self._ui.stc_KeyGuide_RT:isValidate()
  self._ui.stc_WarGuildList:isValidate()
  self._ui.list2_WarInfo:isValidate()
  self._ui.stc_TodayCommentBg:isValidate()
  self._ui.stc_WarHpSet:isValidate()
  self._ui.btn_TaxPayment:isValidate()
  self._ui.stc_GuildMark_Console:isValidate()
  self._ui.stc_GuildBg_Console:isValidate()
  self._ui.stc_ConsoleOnly:isValidate()
  self._ui.btn_giveaway:isValidate()
  self._ui.txt_giveawayCount:isValidate()
  self._ui.btn_MiningReward:isValidate()
  self._ui.btn_ItemShare:isValidate()
  self._ui.btn_GuildParty:isValidate()
end
function PaGlobal_GuildInfo_All:requestGiveawayList()
  local rewardCount = ToClient_getGiveawayDataCount()
  if 0 == rewardCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDGIVEAWAY_NO_REWARD"))
    return
  end
  InGameShop_OpenActual()
  PaGlobal_IngameCashshop_GuildGiveaway_Open()
end
function PaGlobal_GuildInfo_All:requestGuildRewardList()
  if true == _ContentsGroup_GuildReward then
    if true == PaGlobal_GuildReward_All_IsOpen() then
      return
    end
    ToClient_requestGuildRewardInfo()
  end
end
function PaGlobal_GuildInfo_All:requestReloadGuildMember()
  ToClient_ReloadGuildMember()
end
function PaGlobal_GuildInfo_All:showGuildMansionTeleportMessageBox()
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  local guildMansionOwnerNickname = guildWrapper:getGuildMansionOwnerNickname()
  local TeleportGuildMansion = function()
    ToClient_CallPreCoolTimeProgressBar(__ePreCoolTimeType_GuildMansionTeleport, 0)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDMANSION_ASK_TO_TELEPORT", "nickname", guildMansionOwnerNickname),
    functionYes = TeleportGuildMansion,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
