function PaGlobal_Daily_Reward_Notice_All:initialize()
  if true == PaGlobal_Daily_Reward_Notice_All._initialize then
    return
  end
  self._ui.stc_today_reward = UI.getChildControl(Panel_Daily_Reward_Notice_All, "Static_Today_Reward")
  self._ui.stc_today_reward:SetShow(false)
  self._ui.stc_today_name = UI.getChildControl(self._ui.stc_today_reward, "MultilineText_Item_Name")
  self._ui.stc_today_desc = UI.getChildControl(self._ui.stc_today_reward, "MultilineText_Desc")
  self._ui.stc_today_type = UI.getChildControl(self._ui.stc_today_reward, "MultilineText_Reward_Type")
  self._ui.stc_itemSlotBox = UI.getChildControl(self._ui.stc_today_reward, "Static_Item_Box")
  self._ui.stc_tomorrow_reward = UI.getChildControl(Panel_Daily_Reward_Notice_All, "Static_Tomorrow_Reward")
  self._ui.stc_tomorrow_reward:SetShow(false)
  self._ui.txt_tomorrow = UI.getChildControl(Panel_Daily_Reward_Notice_All, "MultilineText_Tomorrow_Title")
  self:initSlot()
  self:resize()
  PaGlobal_Daily_Reward_Notice_All:registEventHandler()
  PaGlobal_Daily_Reward_Notice_All:validate()
  PaGlobal_Daily_Reward_Notice_All._initialize = true
end
function PaGlobal_Daily_Reward_Notice_All:initSlot()
  for index = 1, 7 do
    if nil == self._todayContent[index] then
      local todayReward = UI.cloneControl(self._ui.stc_today_reward, Panel_Daily_Reward_Notice_All, "Static_Today_Reward_" .. index)
      if nil ~= todayReward then
        self._todayContent[index] = {}
        self._todayContent[index].content = todayReward
        self._todayContent[index].item = UI.getChildControl(self._todayContent[index].content, "Static_Item_Box")
        self._todayContent[index].name = UI.getChildControl(self._todayContent[index].content, "MultilineText_Item_Name")
        self._todayContent[index].desc = UI.getChildControl(self._todayContent[index].content, "MultilineText_Desc")
        self._todayContent[index].type = UI.getChildControl(self._todayContent[index].content, "MultilineText_Reward_Type")
        self._todayContent[index].slot = {}
        SlotItem.new(self._todayContent[index].slot, "Daily_ToDay_Item_Box", index, self._todayContent[index].content, self._slotConfig)
        self._todayContent[index].slot:createChild()
        self._todayContent[index].slot.icon:SetPosX(self._todayContent[index].item:GetPosX() - 3)
        self._todayContent[index].slot.icon:SetPosY(self._todayContent[index].item:GetPosY() - 3)
        self._todayContent[index].content:SetShow(false)
      end
    end
    if nil == self._tomorrowContent[index] then
      local tomorrowReward = UI.cloneControl(self._ui.stc_tomorrow_reward, Panel_Daily_Reward_Notice_All, "Static_Tomorrow_Reward_" .. index)
      if nil ~= tomorrowReward then
        self._tomorrowContent[index] = {}
        self._tomorrowContent[index].content = tomorrowReward
        self._tomorrowContent[index].item = UI.getChildControl(self._tomorrowContent[index].content, "Static_Item")
        self._tomorrowContent[index].name = UI.getChildControl(self._tomorrowContent[index].content, "MultilineText_Item_Name")
        self._tomorrowContent[index].desc = UI.getChildControl(self._tomorrowContent[index].content, "MultilineText_Desc_Tomorrow")
        self._tomorrowContent[index].type = UI.getChildControl(self._tomorrowContent[index].content, "MultilineText_Reward_Type")
        self._tomorrowContent[index].slot = {}
        SlotItem.new(self._tomorrowContent[index].slot, "Daily_Tomorrow_ItemSlot", index, self._tomorrowContent[index].content, self._slotConfig)
        self._tomorrowContent[index].slot:createChild()
        self._tomorrowContent[index].slot.icon:SetPosX(self._tomorrowContent[index].item:GetPosX() - 3)
        self._tomorrowContent[index].slot.icon:SetPosY(self._tomorrowContent[index].item:GetPosY() - 3)
        self._tomorrowContent[index].content:SetShow(false)
      end
    end
  end
end
function PaGlobal_Daily_Reward_Notice_All:registEventHandler()
  if nil == Panel_Daily_Reward_Notice_All then
    return
  end
  registerEvent("onScreenResize", "PaGlobal_Daily_Reward_Notice_All_Resize")
  Panel_Daily_Reward_Notice_All:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_Daily_Reward_Notice_All_CloseAnimation()")
  Panel_Daily_Reward_Notice_All:addInputEvent("Mouse_RUp", "HandleEventLUp_PaGlobal_Daily_Reward_Notice_All_CloseAnimation()")
  Panel_Daily_Reward_Notice_All:RegisterShowEventFunc(false, "PaGlobal_Daily_Reward_Notice_All_HideAni()")
  Panel_Daily_Reward_Notice_All:RegisterShowEventFunc(true, "PaGlobal_Daily_Reward_Notice_All_ShowAni()")
  Panel_Daily_Reward_Notice_All:registerPadEvent(__eConsoleUIPadEvent_B, "PaGlobalFunc_Daily_Reward_Notice_All_Close()")
end
function PaGlobal_Daily_Reward_Notice_All:prepareOpen()
  if nil == Panel_Daily_Reward_Notice_All then
    return
  end
  ToClient_padSnapSetTargetPanel(Panel_Daily_Reward_Notice_All)
  Panel_Daily_Reward_Notice_All:ignorePadSnapMoveToOtherPanel()
  self._rewardTypeCount = ToClient_GetAttendanceInfoCount()
  self._originalTodayPosX = self._ui.stc_today_reward:GetSpanSize().x
  self._originalTodayPosY = self._ui.stc_today_reward:GetSpanSize().y
  self:update()
  PaGlobal_Daily_Reward_Notice_All:open()
end
function PaGlobal_Daily_Reward_Notice_All:open()
  if nil == Panel_Daily_Reward_Notice_All then
    return
  end
  Panel_Daily_Reward_Notice_All:SetShow(true)
end
function PaGlobal_Daily_Reward_Notice_All:prepareClose()
  if nil == Panel_Daily_Reward_Notice_All then
    return
  end
  self._firstOpen = false
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_Daily_Reward_Notice_All:close()
end
function PaGlobal_Daily_Reward_Notice_All:close()
  if nil == Panel_Daily_Reward_Notice_All then
    return
  end
  Panel_Daily_Reward_Notice_All:SetShow(false, true)
end
function PaGlobal_Daily_Reward_Notice_All:update()
  if nil == Panel_Daily_Reward_Notice_All then
    return
  end
  self._todayRewardCount = 0
  self._tomorrowRewardCount = 0
  for index = 1, self._rewardTypeCount do
    local rewardWrapper = ToClient_GetAttendanceInfoWrapper(index - 1)
    if nil ~= rewardWrapper then
      local totalCount = rewardWrapper:getRewardCount()
      local todayIndex = ToClient_getAttendanceCount(rewardWrapper:getKey()) - 1
      local yesterdayCount = rewardWrapper:getAttendanceYesterdayCount()
      if todayIndex < 0 then
        todayIndex = 0
      end
      if totalCount <= todayIndex or totalCount <= yesterdayCount then
        if nil ~= self._todayContent[index] then
          self._todayContent[index].content:SetShow(false)
        end
      else
        self._todayRewardCount = self._todayRewardCount + 1
        if nil ~= self._todayContent[index] then
          self._todayContent[index].content:SetShow(true)
          self._todayContent[index].type:SetText(rewardWrapper:getName())
          local itemWrapper = rewardWrapper:getRewardItem(todayIndex)
          if nil ~= itemWrapper then
            self._todayContent[index].name:SetText(itemWrapper:getStaticStatus():getName())
            self._todayContent[index].desc:SetText(rewardWrapper:getDescription(todayIndex))
            if string.len(self._todayContent[index].desc:GetText()) == 0 then
              self._todayContent[index].desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DAILY_REWARD_DATE", "date", todayIndex + 1))
            end
            self._todayContent[index].name:SetTextHorizonCenter()
            self._todayContent[index].desc:SetTextHorizonCenter()
            UI.setLimitAutoWrapTextAndAddTooltip(self._todayContent[index].name, 2, "", self._todayContent[index].name:GetText())
            UI.setLimitAutoWrapTextAndAddTooltip(self._todayContent[index].desc, 4, "", self._todayContent[index].desc:GetText())
            self._todayContent[index].slot:setItem(itemWrapper)
            if false == _ContentsGroup_UsePadSnapping then
              self._todayContent[index].slot.icon:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_Daily_Reward_Notice_All_ItemTooltip(" .. index .. ", " .. todayIndex .. ", true)")
              self._todayContent[index].slot.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
            elseif false == _ContentsGroup_RenewUI_Tooltip then
              self._todayContent[index].item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_PaGlobal_Daily_Reward_Notice_All_ItemTooltip(" .. index .. ", " .. todayIndex .. ", true)")
              self._todayContent[index].item:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
            else
              self._todayContent[index].item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_PaGlobal_Daily_Reward_Notice_All_ItemTooltipForConsole(" .. index .. ", " .. todayIndex .. ", true)")
              self._todayContent[index].item:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
            end
          end
        end
      end
      local tomorrowIndex = todayIndex + 1
      if totalCount <= tomorrowIndex then
        if nil ~= self._tomorrowContent[index] then
          self._tomorrowContent[index].content:SetShow(false)
        end
      else
        self._tomorrowRewardCount = self._tomorrowRewardCount + 1
        if nil ~= self._tomorrowContent[index] then
          self._tomorrowContent[index].content:SetShow(true)
          self._tomorrowContent[index].type:SetText(rewardWrapper:getName())
          local itemWrapper = rewardWrapper:getRewardItem(tomorrowIndex)
          if nil ~= itemWrapper then
            self._tomorrowContent[index].name:SetText(itemWrapper:getStaticStatus():getName())
            self._tomorrowContent[index].desc:SetText(rewardWrapper:getDescription(tomorrowIndex))
            if string.len(self._tomorrowContent[index].desc:GetText()) == 0 then
              self._tomorrowContent[index].desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DAILY_REWARD_DATE", "date", tomorrowIndex + 1))
            end
            self._tomorrowContent[index].name:SetTextHorizonCenter()
            self._tomorrowContent[index].desc:SetTextHorizonCenter()
            UI.setLimitAutoWrapTextAndAddTooltip(self._tomorrowContent[index].name, 2, "", self._tomorrowContent[index].name:GetText())
            UI.setLimitAutoWrapTextAndAddTooltip(self._tomorrowContent[index].desc, 4, "", self._tomorrowContent[index].desc:GetText())
            self._tomorrowContent[index].slot:setItem(itemWrapper)
            if false == _ContentsGroup_UsePadSnapping then
              self._tomorrowContent[index].slot.icon:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_Daily_Reward_Notice_All_ItemTooltip(" .. index .. ", " .. tomorrowIndex .. ", false)")
              self._tomorrowContent[index].slot.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
            elseif false == _ContentsGroup_RenewUI_Tooltip then
              self._tomorrowContent[index].item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_PaGlobal_Daily_Reward_Notice_All_ItemTooltip(" .. index .. ", " .. tomorrowIndex .. ", false)")
              self._tomorrowContent[index].item:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
            else
              self._tomorrowContent[index].item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_PaGlobal_Daily_Reward_Notice_All_ItemTooltipForConsole(" .. index .. ", " .. tomorrowIndex .. ", false)")
              self._tomorrowContent[index].item:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
            end
          end
        end
      end
    end
  end
  self:resize()
end
function PaGlobal_Daily_Reward_Notice_All:resize()
  if nil == Panel_Daily_Reward_Notice_All then
    return
  end
  Panel_Daily_Reward_Notice_All:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Daily_Reward_Notice_All:SetPosX(0)
  Panel_Daily_Reward_Notice_All:SetPosY(0)
  Panel_Daily_Reward_Notice_All:ComputePos()
  Panel_Daily_Reward_Notice_All:ComputePosAllChild()
  self._ui.stc_today_reward:ComputePos()
  self._ui.stc_tomorrow_reward:ComputePos()
  local firstPosition = self._originalTodayPosX - self._ui.stc_today_reward:GetSizeX() / 2 * (self._todayRewardCount - 1)
  local tomorrowPosition = self._ui.stc_tomorrow_reward:GetSpanSize().x - self._ui.stc_tomorrow_reward:GetSizeX() / 2 * (self._tomorrowRewardCount - 1)
  for index = 1, self._rewardTypeCount do
    if nil ~= self._todayContent[index] and true == self._todayContent[index].content:GetShow() then
      self._todayContent[index].content:SetSpanSize(firstPosition, self._originalTodayPosY)
      self._todayContent[index].content:SetSize(self._ui.stc_today_reward:GetSizeX(), self._ui.stc_today_reward:GetSizeY())
      self._todayContent[index].content:ComputePos()
      self._todayContent[index].content:ComputePosAllChild()
      firstPosition = firstPosition + self._ui.stc_today_reward:GetSizeX() + 10
    end
  end
  for index = 1, self._rewardTypeCount do
    if nil ~= self._tomorrowContent[index] and true == self._tomorrowContent[index].content:GetShow(true) then
      self._tomorrowContent[index].content:SetSpanSize(tomorrowPosition, self._tomorrowContent[index].content:GetSpanSize().y)
      self._tomorrowContent[index].content:ComputePos()
      tomorrowPosition = tomorrowPosition + self._ui.stc_tomorrow_reward:GetSizeX() + 10
    end
  end
end
function PaGlobal_Daily_Reward_Notice_All:validate()
  if nil == Panel_Daily_Reward_Notice_All then
    return
  end
end
