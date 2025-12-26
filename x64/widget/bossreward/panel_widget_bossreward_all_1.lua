local NEXTITEM_SHOWTIME = 0.2
local ROWMAXCOUNT = 40
local VIEWCOUNT = 20
function PaGlobal_BossReward:initialize()
  if self._initialize == true then
    return
  end
  self._ui.stc_LootingMainBG = UI.getChildControl(Panel_Widget_BossLooting, "Static_MainBG")
  self._ui.stc_Progress = UI.getChildControl(self._ui.stc_LootingMainBG, "Static_ProgressBG")
  self._ui.progress_Gauge = UI.getChildControl(self._ui.stc_LootingMainBG, "CircularProgress_1")
  self._ui.btn_Reward = UI.getChildControl(self._ui.stc_LootingMainBG, "Button_Reward")
  local stc_TextBG = UI.getChildControl(Panel_Widget_BossLooting, "Static_TextBG")
  self._ui.txt_GetReward = UI.getChildControl(stc_TextBG, "MultilineText_Sub")
  self._ui.txt_GetRewardMain = UI.getChildControl(Panel_Widget_BossReward, "MultilineText_Main")
  self._ui.stc_keyGuideConsole = UI.getChildControl(self._ui.stc_LootingMainBG, "Static_KeyGuide_A_ConsoleUI")
  self._ui.stc_ConsoleUI = UI.getChildControl(Panel_Widget_BossReward, "Static_ConsoleUI")
  self._ui.stc_Console_B_Button = UI.getChildControl(self._ui.stc_ConsoleUI, "StaticText_B_ConsoleUI")
  self._ui.stc_Console_X_Button = UI.getChildControl(self._ui.stc_ConsoleUI, "StaticText_X_ConsoleUI")
  self:registerEventHandler()
  self:validate()
  self:createSlots()
  self._txtGetRewardMainPosY = self._ui.txt_GetRewardMain:GetPosY()
  ToClient_SetWorldBossLootingPanel(Panel_Widget_BossLooting)
  self._initialize = true
end
function PaGlobal_BossReward:registerEventHandler()
  if Panel_Widget_BossReward == nil or Panel_Widget_BossLooting == nil then
    return
  end
  registerEvent("FromClient_BossRewardUIOpen", "FromClient_BossRewardUIOpen")
  registerEvent("FromClient_ChangeToGetRewardUI", "FromClient_ChangeToGetRewardUI")
  self._ui.progress_Gauge:ComputePos()
  self._ui.progress_Gauge:SetCurrentControlPos(0)
  self._ui.progress_Gauge:SetProgressRate(0)
  self._ui.progress_Gauge:SetSmoothMode(true)
  self._ui.btn_Reward:addInputEvent("Mouse_LUp", "HandleEventLUp_GetBossReward()")
  if self._isPadsnapping == true then
    self._ui.stc_keyGuideConsole:SetIgnore(false)
    self._ui.stc_keyGuideConsole:SetShow(true)
  end
end
function PaGlobal_BossReward:validate()
  if Panel_Widget_BossReward == nil or Panel_Widget_BossLooting == nil then
    return
  end
  self._ui.stc_LootingMainBG:isValidate()
  self._ui.stc_Progress:isValidate()
  self._ui.progress_Gauge:isValidate()
  self._ui.btn_Reward:isValidate()
  self._ui.txt_GetReward:isValidate()
  self._ui.txt_GetRewardMain:isValidate()
  self._ui.stc_ConsoleUI:isValidate()
  self._ui.stc_Console_B_Button:isValidate()
  self._ui.stc_Console_X_Button:isValidate()
end
function PaGlobal_BossReward:createSlots()
  if Panel_Widget_BossReward == nil or Panel_Widget_BossLooting == nil then
    return
  end
  local slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true
  }
  self._bgSlots = Array.new()
  self._slots = Array.new()
  local mainBG = UI.getChildControl(Panel_Widget_BossReward, "Static_MainBG")
  self._ui.frame = UI.getChildControl(mainBG, "Frame_Item")
  self._ui.frame:SetIgnoreMouseUpDownScroll(true)
  self._ui.frame_Content = UI.getChildControl(self._ui.frame, "Frame_2_Content")
  self._ui.frame_SlideBg = UI.getChildControl(self._ui.frame, "Frame_2_HorizontalScroll")
  self._ui.frame_SlideBtn = UI.getChildControl(self._ui.frame_SlideBg, "Frame_2_HorizontalScroll_CtrlButton")
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
end
function PaGlobal_BossReward:prepareOpen()
  if Panel_Widget_BossReward == nil or Panel_Widget_BossLooting == nil then
    return
  end
  self._ui.progress_Gauge:SetCurrentControlPos(0)
  self._randomTime = math.random(10, 15)
  self._autoBossRewardGetTime = self._randomTime
  self._ui.progress_Gauge:SetAniSpeed(self._randomTime)
  self._frameSizeX = self._ui.frame:GetSizeX()
  self._frameContentSizeX = self._ui.frame:GetSizeX()
  self._frameContentSizeY = self._ui.frame_Content:GetSizeY()
  Panel_Widget_BossLooting:RegisterUpdateFunc("Update_BossRewardLooting")
  Panel_Widget_BossReward:RegisterUpdateFunc("Update_BossRewardMaintain")
  if self._isPadsnapping == true then
    Panel_Widget_BossReward:ignorePadSnapUpdate(true)
    self._ui.stc_ConsoleUI:SetShow(true)
  else
    self._ui.stc_ConsoleUI:SetShow(false)
  end
  self:open()
end
function PaGlobal_BossReward:open()
  if Panel_Widget_BossReward == nil or Panel_Widget_BossLooting == nil then
    return
  end
  Panel_Widget_BossLooting:SetShow(true)
end
function PaGlobal_BossReward:prepareClose()
  if Panel_Widget_BossReward == nil or Panel_Widget_BossLooting == nil then
    return
  end
  self._ui.progress_Gauge:SetCurrentControlPos(0)
  self._autoBossRewardGetTime = math.random(10, 15)
  self._maintainGetRewardTime = MAINTAIN_GETREWARDTIME
  Panel_Widget_BossLooting:ClearUpdateLuaFunc()
  Panel_Widget_BossReward:ClearUpdateLuaFunc()
  Panel_Widget_BossReward:ignorePadSnapUpdate(false)
  if self._isConsole == true then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  self:close()
end
function PaGlobal_BossReward:close()
  if Panel_Widget_BossReward == nil or Panel_Widget_BossLooting == nil then
    return
  end
  Panel_Widget_BossLooting:SetShow(false)
  Panel_Widget_BossReward:SetShow(false)
end
function PaGlobal_BossReward:changeToGetRewardUI()
  if Panel_Widget_BossLooting:GetShow() == false then
    return
  end
  self:updateRewardSlots()
  Panel_Widget_BossReward:SetShow(true)
  looting_pickWorldBossItem()
  Panel_Widget_BossLooting:SetShow(false)
end
function PaGlobal_BossReward:updateRewardSlots()
  if Panel_Widget_BossReward == nil or Panel_Widget_BossLooting == nil then
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
    local itemWrapper = looting_getItem(index - 1)
    bgSlot:SetShow(false)
    if itemWrapper == nil then
      slot:clearItem()
    else
      slot:setItem(itemWrapper)
      self._itemKeyList[index] = itemWrapper:get():getKey():getItemKey()
      if self._isPadsnapping == true then
        bgSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_BossReward_ShowSlotToolTip(true, " .. index .. ")")
        bgSlot:addInputEvent("Mouse_Out", "HandleEventOnOut_BossReward_ShowSlotToolTip(false, " .. index .. ")")
      else
        slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_BossReward_ShowSlotToolTip(true, " .. index .. ")")
        slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_BossReward_ShowSlotToolTip(false, " .. index .. ")")
      end
      table.insert(validItemList, index)
    end
  end
  self._itemCheck = validItemList
  self._rewardRootingItemCount = #validItemList
  local mainBG = UI.getChildControl(Panel_Widget_BossReward, "Static_MainBG")
  local itemSlot = UI.getChildControl(self._ui.frame_Content, "Static_ItemSlot")
  local posXStart = 4
  local posYStart = itemSlot:GetPosY()
  self._maxFrameContentSizeX = posXStart * 2 + (itemSlot:GetSizeX() + 10) * self._rewardRootingItemCount
  self._frameContentSizeX = posXStart * 2 + (itemSlot:GetSizeX() + 10) * VIEWCOUNT
  if self._rewardRootingItemCount <= VIEWCOUNT then
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
function Update_BossRewardLooting(deltaTime)
  PaGlobal_BossReward._autoBossRewardGetTime = PaGlobal_BossReward._autoBossRewardGetTime - deltaTime
  PaGlobal_BossReward._ui.progress_Gauge:SetProgressRate(100 - PaGlobal_BossReward._autoBossRewardGetTime * (100 / PaGlobal_BossReward._randomTime))
  local strTime = tostring(math.ceil(PaGlobal_BossReward._autoBossRewardGetTime))
  PaGlobal_BossReward._ui.txt_GetReward:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_WIDGET_BOSSREWARD_DESC_COUNT", "timer", strTime))
  if PaGlobal_BossReward._isPadsnapping == true and isPadUp(__eJoyPadInputType_A) == true then
    PaGlobal_BossReward:changeToGetRewardUI()
  end
  if PaGlobal_BossReward._autoBossRewardGetTime > 0 then
    return
  end
  PaGlobal_BossReward:changeToGetRewardUI()
end
function PaGlobal_BossReward:check()
  if self._rewardRootingItemCount < self._rewardRootingItemIndex then
    self._isShowEnd = true
    Panel_Widget_BossReward:ignorePadSnapUpdate(false)
    return
  end
  local bgSlot = self._bgSlots[self._rewardRootingItemIndex]
  local itemMoveAni = function(control)
    control:SetPosY(control:GetPosY() + 30)
    local ImageMoveAni = control:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
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
function Update_BossRewardMaintain(deltaTime)
  local self = PaGlobal_BossReward
  self._showItemTerm = self._showItemTerm + deltaTime
  if false == self._isAnimationEnd and VIEWCOUNT < self._rewardRootingItemCount and VIEWCOUNT < self._rewardRootingItemIndex then
    self._frameContentSizeX = math.min(self._frameContentSizeX + self._frameMoveSpeed, self._maxFrameContentSizeX)
    self._ui.frame_Content:SetSize(self._frameContentSizeX, self._frameContentSizeY)
    self._ui.frame_Content:SetPosX(self._frameSizeX - self._frameContentSizeX)
    if self._maxFrameContentSizeX <= self._frameContentSizeX then
      self._ui.frame_SlideBg:SetInterval(self._rewardRootingItemCount - VIEWCOUNT + 1)
      self._ui.frame_SlideBtn:SetPosX(self._ui.frame_SlideBg:GetSizeX() - self._ui.frame_SlideBtn:GetSizeX())
      self._ui.frame_SlideBg:SetShow(true)
      self._isAnimationEnd = true
    end
  end
  if self._showItemTerm < NEXTITEM_SHOWTIME then
    return
  end
  if false == self._isShowEnd then
    self:check()
    return
  end
end
function FromClient_BossRewardUIOpen(isOpen, isLackInventory)
  if isOpen == nil then
    return
  end
  if isOpen == true and PaGlobalFunc_BossReward_Open ~= nil then
    PaGlobalFunc_BossReward_Open()
  elseif isOpen == false and PaGlobalFunc_BossReward_Close ~= nil then
    PaGlobalFunc_BossReward_Close()
    if isLackInventory == true then
      local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_UPDATE_POPUP_BTN_CONFIRM")
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_BOSSREWARD_POPUP_DESC")
      if PaGlobal_BossReward._isPadsnapping == true then
        local messageBoxData = {
          title = messageBoxTitle,
          content = messageBoxMemo,
          functionApply = MessageBox_Empty_function,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageBoxData, nil, false, true)
      else
        local messageBoxData = {
          title = messageBoxTitle,
          content = messageBoxMemo,
          functionApply = MessageBox_Empty_function,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageBoxData, nil, nil, false)
      end
    end
  end
end
function FromClient_ChangeToGetRewardUI()
  PaGlobal_BossReward:changeToGetRewardUI()
end
