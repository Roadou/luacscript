function PaGlobal_BoxReward_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.txt_GetRewardMain = UI.getChildControl(Panel_Widget_Reward_All, "MultilineText_Main")
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(Panel_Widget_Reward_All, "Static_ConsoleUI")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_B_ConsoleUI")
  self._ui_console.txt_KeyGuideX = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_X_ConsoleUI")
  self:registerEventHandler()
  self:validate()
  self:createSlots()
  local keyguides = {
    self._ui_console.txt_KeyGuideX,
    self._ui_console.txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, self._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self:changePlatform()
  self._initialize = true
end
function PaGlobal_BoxReward_All:changePlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
end
function PaGlobal_BoxReward_All:registerEventHandler()
  if Panel_Widget_Reward_All == nil then
    return
  end
  registerEvent("FromClient_BoxRewardUIOpen", "FromClient_BoxReward_All_Open")
end
function PaGlobal_BoxReward_All:validate()
  if Panel_Widget_Reward_All == nil then
    return
  end
end
function PaGlobal_BoxReward_All:createSlots()
  if Panel_Widget_Reward_All == nil then
    return
  end
  local slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true
  }
  self._bgSlots = Array.new()
  self._slots = Array.new()
  local mainBG = UI.getChildControl(Panel_Widget_Reward_All, "Static_MainBG")
  self._ui.frame = UI.getChildControl(mainBG, "Frame_Item")
  self._ui.frame:SetIgnoreMouseUpDownScroll(true)
  self._ui.frame_Content = UI.getChildControl(self._ui.frame, "Frame_2_Content")
  self._ui.frame_SlideBg = UI.getChildControl(self._ui.frame, "Frame_2_HorizontalScroll")
  self._ui.frame_SlideBtn = UI.getChildControl(self._ui.frame_SlideBg, "Frame_2_HorizontalScroll_CtrlButton")
  UIScroll.InputEventByControl(self._ui.frame_SlideBg, "PaGlobalFunc_BoxReward_ScrollUpdate")
  UIScroll.InputEventByControl(self._ui.frame_SlideBtn, "PaGlobalFunc_BoxReward_ScrollUpdate")
  self._ui.frame_SlideBg:addInputEvent("Mouse_LDown", "PaGlobalFunc_BoxReward_ScrollBtnUpdate()")
  self._ui.frame_SlideBg:addInputEvent("Mouse_LPress", "PaGlobalFunc_BoxReward_ScrollBtnUpdate()")
  local verticalScroll = UI.getChildControl(self._ui.frame, "Frame_2_VerticalScroll")
  verticalScroll:SetEnable(false)
  local itemSlot = UI.getChildControl(self._ui.frame_Content, "Static_ItemSlot")
  for i = 1, self._maxSlotCount do
    local cloneItemSlot = UI.cloneControl(itemSlot, self._ui.frame_Content, "slot_Background_" .. i)
    local slotNo = i - 1
    local slot = {}
    SlotItem.new(slot, "Reward_item_" .. slotNo, slotNo, cloneItemSlot, slotConfig)
    slot:createChild()
    slot.icon:SetPosXY(1, 1)
    self._bgSlots[i] = cloneItemSlot
    self._slots[i] = slot
  end
  itemSlot:SetShow(false)
  self._frameSizeX = self._ui.frame:GetSizeX()
  self._frameContentSizeX = self._ui.frame:GetSizeX()
  self._frameContentSizeY = self._ui.frame_Content:GetSizeY()
end
function PaGlobal_BoxReward_All:prepareOpen()
  if Panel_Widget_Reward_All == nil then
    return
  end
  Panel_Widget_Reward_All:RegisterUpdateFunc("PaGlobalFunc_BoxReward_All_Update")
  PaGlobal_BoxReward_All:updateRewardSlots()
  if self._isConsole == true then
    Panel_Widget_Reward_All:ignorePadSnapUpdate(true)
  end
  self:open()
end
function PaGlobal_BoxReward_All:open()
  if Panel_Widget_Reward_All == nil then
    return
  end
  Panel_Widget_Reward_All:SetShow(true)
end
function PaGlobal_BoxReward_All:prepareClose()
  if Panel_Widget_Reward_All == nil then
    return
  end
  Panel_Widget_Reward_All:ClearUpdateLuaFunc()
  Panel_Widget_Reward_All:ignorePadSnapUpdate(false)
  if self._isConsole == true then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  self:close()
end
function PaGlobal_BoxReward_All:close()
  if Panel_Widget_Reward_All == nil then
    return
  end
  Panel_Widget_Reward_All:SetShow(false)
end
function PaGlobal_BoxReward_All:updateRewardSlots()
  if Panel_Widget_Reward_All == nil then
    return
  end
  self._isShowEnd = false
  self._rewardRootingItemCount = 0
  self._rewardRootingItemIndex = 1
  local validItemList = {}
  self._itemKeyList = {}
  for index = 1, self._maxSlotCount do
    local slot = self._slots[index]
    local bgSlot = self._bgSlots[index]
    local itemWrapper = ToClient_GetBoxItemList(index - 1)
    bgSlot:SetShow(false)
    if itemWrapper == nil then
      slot:clearItem()
    else
      slot:setItem(itemWrapper)
      self._itemKeyList[index] = itemWrapper:get():getKey():getItemKey()
      if self._isPadsnapping == true then
        bgSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_BoxReward_ShowSlotToolTip(true, " .. index .. ")")
        bgSlot:addInputEvent("Mouse_Out", "HandleEventOnOut_BoxReward_ShowSlotToolTip(false, " .. index .. ")")
      else
        slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_BoxReward_ShowSlotToolTip(true, " .. index .. ")")
        slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_BoxReward_ShowSlotToolTip(false, " .. index .. ")")
      end
      table.insert(validItemList, index)
    end
  end
  self._itemCheck = validItemList
  self._rewardRootingItemCount = #validItemList
  local mainBG = UI.getChildControl(Panel_Widget_Reward_All, "Static_MainBG")
  local itemSlot = UI.getChildControl(self._ui.frame_Content, "Static_ItemSlot")
  local posXStart = 4
  local posYStart = itemSlot:GetPosY()
  self._maxFrameContentSizeX = posXStart * 2 + (itemSlot:GetSizeX() + 10) * self._rewardRootingItemCount
  self._frameContentSizeX = posXStart * 2 + (itemSlot:GetSizeX() + 10) * self._viewCount
  if self._rewardRootingItemCount <= self._viewCount then
    self._ui.frame_Content:SetSize(self._maxFrameContentSizeX, self._ui.frame_Content:GetSizeY())
    self._isAnimationEnd = true
  else
    self._ui.frame_Content:SetSize(self._frameContentSizeX, self._ui.frame_Content:GetSizeY())
    self._isAnimationEnd = false
  end
  self._ui.frame_Content:ComputePos()
  self._ui.frame_SlideBg:SetShow(false)
  local posX = posXStart
  local posY = posYStart
  for k, value in pairs(validItemList) do
    local bgSlot = self._bgSlots[value]
    if bgSlot ~= nil then
      bgSlot:SetPosXY(posX, posY)
      posX = posX + itemSlot:GetSizeX() + 10
    end
  end
end
function PaGlobal_BoxReward_All:update(deltaTime)
  self._showItemTerm = self._showItemTerm + deltaTime
  if false == self._isAnimationEnd and self._viewCount < self._rewardRootingItemCount and self._viewCount < self._rewardRootingItemIndex then
    self._frameContentSizeX = math.min(self._frameContentSizeX + self._frameMoveSpeed, self._maxFrameContentSizeX)
    self._ui.frame_Content:SetSize(self._frameContentSizeX, self._frameContentSizeY)
    self._ui.frame_Content:SetPosX(self._frameSizeX - self._frameContentSizeX)
    if self._maxFrameContentSizeX <= self._frameContentSizeX then
      self._ui.frame_SlideBg:SetInterval(self._rewardRootingItemCount - self._viewCount + 1)
      self._ui.frame_SlideBtn:SetPosX(self._ui.frame_SlideBg:GetSizeX() - self._ui.frame_SlideBtn:GetSizeX())
      self._ui.frame_SlideBg:SetShow(true)
      self._isAnimationEnd = true
    end
  end
  if self._showItemTerm < self._nextItemShowTime then
    return
  end
  if false == self._isShowEnd then
    self:check()
    return
  end
end
function PaGlobal_BoxReward_All:check()
  if self._rewardRootingItemCount < self._rewardRootingItemIndex then
    self._isShowEnd = true
    Panel_Widget_Reward_All:ignorePadSnapUpdate(false)
    return
  end
  local bgSlot = self._bgSlots[self._rewardRootingItemIndex]
  local itemMoveAni = function(control)
    control:SetPosY(control:GetPosY() + 30)
    local ImageMoveAni = control:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    ImageMoveAni:SetStartPosition(control:GetPosX(), control:GetPosY())
    ImageMoveAni:SetEndPosition(control:GetPosX(), control:GetPosY() - 30)
    ImageMoveAni.IsChangeChild = true
    control:CalcUIAniPos(ImageMoveAni)
  end
  if nil ~= bgSlot then
    itemMoveAni(bgSlot)
    bgSlot:SetShow(true)
    bgSlot:EraseAllEffect()
    bgSlot:AddEffect("fUI_Boss_ItemDrop_01A", true, 0, 0)
    self._rewardRootingItemIndex = self._rewardRootingItemIndex + 1
    self._showItemTerm = 0
  end
end
