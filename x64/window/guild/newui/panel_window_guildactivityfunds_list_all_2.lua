function PaGlobal_GuildActivityFunds_List_All_Open()
  if Panel_Window_GuildActivityFunds_List_All == nil then
    return
  end
  PaGlobal_GuildActivityFunds_List_All:prepareOpen()
end
function PaGlobal_GuildActivityFunds_List_All_Close()
  if Panel_Window_GuildActivityFunds_List_All == nil then
    return
  end
  PaGlobal_GuildActivityFunds_List_All:prepareClose()
end
function PaGlobal_GuildActivityFunds_List_All_Confirm()
  if Panel_Window_GuildActivityFunds_List_All == nil then
    return
  end
  ToClient_SetAllGuildMemberPriceLimit()
end
function PaGlobal_GuildActivityFunds_List_All_Update()
  if nil == Panel_Window_GuildActivityFunds_List_All then
    return
  end
  if Panel_Window_GuildActivityFunds_List_All:GetShow() == false then
    return
  end
  PaGlobal_GuildActivityFunds_List_All:update()
end
function HandleEventScroll_GuildActivityFunds_All_Scroll(isUp)
  if nil == Panel_Window_GuildActivityFunds_List_All then
    return
  end
  if isUp == nil then
    return
  end
  if Panel_Window_GuildActivityFunds_List_All:GetShow() == false then
    return
  end
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  local memberCount = guildWrapper:getMemberCount()
  UIScroll.ScrollEvent(PaGlobal_GuildActivityFunds_List_All._ui.scroll_vs, isUp, memberCount, memberCount, 0, 1)
  PaGlobal_GuildActivityFunds_List_All_Update()
end
function HandleEventLUp_GuildActivityFunds_All_Grade(index)
  if nil == Panel_Window_GuildActivityFunds_List_All then
    return
  end
  if index == nil then
    return
  end
  PaGlobal_GuildActivityFunds_List_All._memberIndex = index
  Panel_NumberPad_Show(true, toInt64(0, __eGuildActivityGradeMax), 0, PaGlobalFunc_GuildActivityFunds_All_GradeCallBack)
end
function PaGlobalFunc_GuildActivityFunds_All_GradeCallBack(count)
  if nil == Panel_Window_GuildActivityFunds_List_All then
    return
  end
  if count == nil then
    return
  end
  local index = PaGlobal_GuildActivityFunds_List_All._memberIndex
  local dataIdx = PaGlobal_GuildActivityFunds_List_All._memberlistData[index + 1].idx
  ToClient_RequestUpdateGuildFundGrade(dataIdx, __eGuildFundSettingType_Activity, Int64toInt32(count))
end
