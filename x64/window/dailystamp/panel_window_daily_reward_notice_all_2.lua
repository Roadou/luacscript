function PaGlobalFunc_Daily_Reward_Notice_All_Open()
  if nil == Panel_Daily_Reward_Notice_All then
    return
  end
  if true == Panel_Daily_Reward_Notice_All:GetShow() then
    return
  end
  if false == PaGlobal_Daily_Reward_Notice_All._firstOpen then
    return
  end
  if ToClient_UserHasOverLevelCharacter(60) == false then
    return
  end
  PaGlobal_Daily_Reward_Notice_All:prepareOpen()
end
function PaGlobalFunc_Daily_Reward_Notice_All_Close()
  if nil == Panel_Daily_Reward_Notice_All then
    return
  end
  if false == Panel_Daily_Reward_Notice_All:GetShow() then
    return
  end
  PaGlobal_Daily_Reward_Notice_All:prepareClose()
end
function HandleEventLUp_PaGlobal_Daily_Reward_Notice_All_CloseAnimation()
  if nil == Panel_Daily_Reward_Notice_All then
    return
  end
  PaGlobalFunc_Daily_Reward_Notice_All_Close()
end
function PaGlobal_Daily_Reward_Notice_All_Resize()
  PaGlobal_Daily_Reward_Notice_All:resize()
end
function HandleEventOn_PaGlobal_Daily_Reward_Notice_All_ItemTooltip(type, index, isToday)
  if nil == Panel_Daily_Reward_Notice_All then
    return
  end
  if nil == type or nil == index then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if true == _ContentsGroup_UsePadSnapping and false == _ContentsGroup_NewUI_Tooltip_All and nil ~= Panel_Tooltip_Item and true == Panel_Tooltip_Item:GetShow() then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local rewardWrapper = ToClient_GetAttendanceInfoWrapper(type - 1)
  if nil ~= rewardWrapper then
    local itemWrapper = rewardWrapper:getRewardItem(index)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      if true == isToday then
        local uiBase = PaGlobal_Daily_Reward_Notice_All._todayContent[type].slot.icon
        Panel_Tooltip_Item_Show(itemSSW, uiBase, true, false)
      else
        local uiBase = PaGlobal_Daily_Reward_Notice_All._tomorrowContent[type].slot.icon
        Panel_Tooltip_Item_Show(itemSSW, uiBase, true, false)
      end
    end
  end
end
function HandleEventOn_PaGlobal_Daily_Reward_Notice_All_ItemTooltipForConsole(type, index, isToday)
  if nil == Panel_Daily_Reward_Notice_All then
    return
  end
  if nil == type or nil == index then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local rewardWrapper = ToClient_GetAttendanceInfoWrapper(type - 1)
  if nil ~= rewardWrapper then
    local itemWrapper = rewardWrapper:getRewardItem(index)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      if true == isToday then
        local uiBase = PaGlobal_Daily_Reward_Notice_All._todayContent[type].slot.icon
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item)
      else
        local uiBase = PaGlobal_Daily_Reward_Notice_All._tomorrowContent[type].slot.icon
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item)
      end
    end
  end
end
function PaGlobal_Daily_Reward_Notice_All_ShowAni()
  if nil == Panel_Daily_Reward_Notice_All then
    return
  end
end
function PaGlobal_Daily_Reward_Notice_All_HideAni()
  if nil == Panel_Daily_Reward_Notice_All then
    return
  end
  local self = PaGlobal_Daily_Reward_Notice_All
  local targetX = getScreenSizeX()
  local targetY = getScreenSizeX()
  if nil ~= Panel_UIMain then
    targetX = Panel_Widget_Alert_info_GetPanelPositionX() + Panel_Widget_Alert_info_GetTotalRewardPositionX()
    targetY = Panel_Widget_Alert_info_GetPanelPositionY() + Panel_Widget_Alert_info_GetTotalRewardPositionY()
  end
  for index = 1, self._rewardTypeCount do
    if nil ~= self._todayContent[index] then
      local aniInfoMove = self._todayContent[index].content:addMoveAnimation(0, 1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
      aniInfoMove:SetStartPosition(self._todayContent[index].content:GetPosX(), self._todayContent[index].content:GetPosY())
      aniInfoMove:SetEndPosition(targetX, targetY)
      aniInfoMove:SetHideAtEnd(true)
      aniInfoMove.IsChangeChild = true
      aniInfoMove:SetDisableWhileAni(true)
      local aniInfoSize = self._todayContent[index].content:addScaleAnimation(0, 1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
      aniInfoSize:SetStartScale(1)
      aniInfoSize:SetHideAtEnd(true)
      aniInfoSize:SetEndScale(0.5)
      aniInfoSize.IsChangeChild = true
    end
  end
  local HideAni = UIAni.AlphaAnimation(0, Panel_Daily_Reward_Notice_All, 0, 1)
  HideAni:SetHideAtEnd(true)
  if false == _ContentsGroup_RenewUI then
    Panel_Widget_Alert_info_AddRewardNoticeEffect()
  end
end
