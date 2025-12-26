function PaGlobal_ArtifactPreset_All:initialize()
  if Panel_Window_ArtifactPreset_All == nil then
    return
  end
  if self._initialize == true then
    return
  end
  self._isPadSnapping = ToClient_isUsePadSnapping()
  local title = UI.getChildControl(Panel_Window_ArtifactPreset_All, "Static_Title")
  self._ui._btn_editPreset = UI.getChildControl(Panel_Window_ArtifactPreset_All, "CheckButton_Preset")
  self._ui._txt_presetCount = UI.getChildControl(Panel_Window_ArtifactPreset_All, "StaticText_PresetCount")
  self._ui._btn_presetBuy = UI.getChildControl(Panel_Window_ArtifactPreset_All, "Button_PresetAdd")
  self._ui._list2_artifactPreset = UI.getChildControl(Panel_Window_ArtifactPreset_All, "List2_PresetList")
  self._ui._txt_editPreset = nil
  local btn_editPreset_PC = UI.getChildControl(self._ui._btn_editPreset, "StaticText_String")
  local btn_editPreset_Console = UI.getChildControl(self._ui._btn_editPreset, "Static_LT_ConsoleUI")
  btn_editPreset_PC:SetShow(not self._isPadSnapping)
  btn_editPreset_Console:SetShow(self._isPadSnapping)
  if self._isPadSnapping == true then
    self._ui._txt_editPreset = btn_editPreset_Console
  else
    self._ui._txt_editPreset = btn_editPreset_PC
  end
  local artifactPreset_content = UI.getChildControl(self._ui._list2_artifactPreset, "List2_1_Content")
  local artifactPreset_rdoBtn = UI.getChildControl(artifactPreset_content, "RadioButton_ArtifactPreset")
  local artifactPreset_leftSlotBG = UI.getChildControl(artifactPreset_rdoBtn, "Static_ItemSlotBG_L")
  local artifactPreset_leftSlotIcon = UI.getChildControl(artifactPreset_leftSlotBG, "Static_ItemIcon")
  local artifactPreset_leftPushedSlot_0_BG = UI.getChildControl(artifactPreset_rdoBtn, "Static_LightStone_BG_L_0")
  local artifactPreset_leftPushedSlot_0 = UI.getChildControl(artifactPreset_leftPushedSlot_0_BG, "Static_Icon")
  local artifactPreset_leftPushedSlot_1_BG = UI.getChildControl(artifactPreset_rdoBtn, "Static_LightStone_BG_L_1")
  local artifactPreset_leftPushedSlot_1 = UI.getChildControl(artifactPreset_leftPushedSlot_1_BG, "Static_Icon")
  local artifactPreset_rightSlotBG = UI.getChildControl(artifactPreset_rdoBtn, "Static_ItemSlotBG_R")
  local artifactPreset_rightSlotIcon = UI.getChildControl(artifactPreset_rightSlotBG, "Static_ItemIcon")
  local artifactPreset_rightPushedSlot_0_BG = UI.getChildControl(artifactPreset_rdoBtn, "Static_LightStone_BG_R_0")
  local artifactPreset_rightPushedSlot_0 = UI.getChildControl(artifactPreset_rightPushedSlot_0_BG, "Static_Icon")
  local artifactPreset_rightPushedSlot_1_BG = UI.getChildControl(artifactPreset_rdoBtn, "Static_LightStone_BG_R_1")
  local artifactPreset_rightPushedSlot_1 = UI.getChildControl(artifactPreset_rightPushedSlot_1_BG, "Static_Icon")
  local artifactPreset_leftArtifactSlot = {}
  SlotItem.new(artifactPreset_leftArtifactSlot, "ArtifactPreset_Left_Slot_", 0, artifactPreset_leftSlotIcon, self._slotConfig)
  artifactPreset_leftArtifactSlot:createChild()
  artifactPreset_leftArtifactSlot:clearItem()
  artifactPreset_leftArtifactSlot.icon:SetPosX(0)
  artifactPreset_leftArtifactSlot.icon:SetPosY(0)
  artifactPreset_leftArtifactSlot.border:SetSize(44, 44)
  local artifactPreset_leftSubSlot_0 = {}
  SlotItem.new(artifactPreset_leftSubSlot_0, "ArtifactPreset_Left_SubSlot_0_", 0, artifactPreset_leftPushedSlot_0, self._subSlotConfig)
  artifactPreset_leftSubSlot_0:createChild()
  artifactPreset_leftSubSlot_0:clearItem()
  artifactPreset_leftSubSlot_0.icon:SetPosX(0)
  artifactPreset_leftSubSlot_0.icon:SetPosY(0)
  artifactPreset_leftSubSlot_0.icon:SetSize(20, 20)
  local artifactPreset_leftSubSlot_1 = {}
  SlotItem.new(artifactPreset_leftSubSlot_1, "ArtifactPreset_Left_SubSlot_1_", 0, artifactPreset_leftPushedSlot_1, self._subSlotConfig)
  artifactPreset_leftSubSlot_1:createChild()
  artifactPreset_leftSubSlot_1:clearItem()
  artifactPreset_leftSubSlot_1.icon:SetPosX(0)
  artifactPreset_leftSubSlot_1.icon:SetPosY(0)
  artifactPreset_leftSubSlot_1.icon:SetSize(20, 20)
  local artifactPreset_rightArtifactSlot = {}
  SlotItem.new(artifactPreset_rightArtifactSlot, "ArtifactPreset_Right_Slot_", 0, artifactPreset_rightSlotIcon, self._slotConfig)
  artifactPreset_rightArtifactSlot:createChild()
  artifactPreset_rightArtifactSlot:clearItem()
  artifactPreset_rightArtifactSlot.icon:SetPosX(0)
  artifactPreset_rightArtifactSlot.icon:SetPosY(0)
  artifactPreset_rightArtifactSlot.border:SetSize(44, 44)
  local artifactPreset_rightSubSlot_0 = {}
  SlotItem.new(artifactPreset_rightSubSlot_0, "ArtifactPreset_Right_SubSlot_0_", 0, artifactPreset_rightPushedSlot_0, self._subSlotConfig)
  artifactPreset_rightSubSlot_0:createChild()
  artifactPreset_rightSubSlot_0:clearItem()
  artifactPreset_rightSubSlot_0.icon:SetPosX(0)
  artifactPreset_rightSubSlot_0.icon:SetPosY(0)
  artifactPreset_rightSubSlot_0.icon:SetSize(20, 20)
  local artifactPreset_rightSubSlot_1 = {}
  SlotItem.new(artifactPreset_rightSubSlot_1, "ArtifactPreset_Right_SubSlot_1_", 0, artifactPreset_rightPushedSlot_1, self._subSlotConfig)
  artifactPreset_rightSubSlot_1:createChild()
  artifactPreset_rightSubSlot_1:clearItem()
  artifactPreset_rightSubSlot_1.icon:SetPosX(0)
  artifactPreset_rightSubSlot_1.icon:SetPosY(0)
  artifactPreset_rightSubSlot_1.icon:SetSize(20, 20)
  self._ui._stc_keyGuideBG = UI.getChildControl(Panel_Window_ArtifactPreset_All, "Static_KeyGuide_Bg")
  self._ui._stc_keyGuideBG:SetShow(self._isPadSnapping == true)
  self._ui._stc_keyGuide_RTX = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_RT_ArtifactPreset_ConsoleUI")
  self._ui._stc_keyGuide_Y = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_Y_ConsoleUI")
  self._ui._stc_keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_A_ConsoleUI")
  self._ui._stc_keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_B_ConsoleUI")
  self._ui._stc_keyGuide_X = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_X_ConsoleUI")
  self._beforePadSnapState = LightStoneBagConsoleSnapState.SnapOnPreset
  if _ContentsGroup_ArtifactPresetExtend == true and ToClient_isConsole() == false then
    self._ui._btn_presetBuy:SetShow(true)
  else
    self._ui._btn_presetBuy:SetShow(false)
    self._ui._txt_presetCount:SetPosX(self._ui._txt_presetCount:GetPosX() + self._ui._btn_presetBuy:GetSizeX())
  end
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ArtifactPreset_All:registEventHandler()
  if Panel_Window_ArtifactPreset_All == nil then
    return
  end
  if self._isPadSnapping == true then
    Panel_Window_ArtifactPreset_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "PaGlobalFunc_ArtifactPreset_All_ToggleEditMode()")
  else
    self._ui._btn_editPreset:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_All_ToggleEditMode()")
  end
  self._ui._btn_presetBuy:addInputEvent("Mouse_LUp", "PaGlobalFunc_EasyBuy_Open( 136 )")
  self._ui._list2_artifactPreset:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ArtifactPreset_All_UpdateArtifactPresetList")
  self._ui._list2_artifactPreset:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_UpdateArtifactPresetData", "FromClient_ArtifactPreset_All_UpdateArtifactPresetData")
  registerEvent("FromClient_ArtifactPreset_All_UpdateCurrentPresetName", "FromClient_ArtifactPreset_All_UpdateCurrentPresetName")
end
function PaGlobal_ArtifactPreset_All:prepareOpen()
  if Panel_Window_ArtifactPreset_All == nil then
    return
  end
  ToClient_copyArtifactBagPresetDataListForLua()
  Panel_Window_ArtifactPreset_All:SetPosXY(Panel_Window_LightStoneBag:GetPosX() - Panel_Window_ArtifactPreset_All:GetSizeX() - 5, Panel_Window_LightStoneBag:GetPosY())
  self:loadArtifactPresetList(false)
  self._beforePadSnapState = LightStoneBagConsoleSnapState.SnapOnPreset
  PaGlobalFunc_ArtifactPreset_All_ToggleEditMode(true)
  self:open()
end
function PaGlobal_ArtifactPreset_All:open()
  if Panel_Window_ArtifactPreset_All == nil then
    return
  end
  Panel_Window_ArtifactPreset_All:SetShow(true)
end
function PaGlobal_ArtifactPreset_All:prepareClose()
  if Panel_Window_ArtifactPreset_All == nil then
    return
  end
  if _ContentsGroup_ArtifactPresetExtend == true and self._ui._btn_editPreset:IsCheck() == true then
    self:checkSavePreset()
    return false
  end
  ToClient_clearArtifactBagPresetDataForLua()
  self._ui._btn_editPreset:SetCheck(false)
  self._currentSelectedPresetIndex_s64 = nil
  self._currentCloseType = nil
  self:close()
end
function PaGlobal_ArtifactPreset_All:close()
  if Panel_Window_ArtifactPreset_All == nil then
    return
  end
  Panel_Window_ArtifactPreset_All:SetShow(false)
end
function PaGlobal_ArtifactPreset_All:loadArtifactPresetList(isHoldScroll)
  if Panel_Window_ArtifactPreset_All == nil then
    return
  end
  local currentScrollIndex = self._ui._list2_artifactPreset:getCurrenttoIndex()
  local currentControlPos = self._ui._list2_artifactPreset:GetVScroll():GetControlPos()
  local useExtendItem = false
  local currentContentCount = Int64toInt32(self._ui._list2_artifactPreset:getElementManager():getSize())
  if currentContentCount < ToClient_getMyArtifactBagPresetMaxCount() then
    useExtendItem = true
  end
  self._ui._list2_artifactPreset:getElementManager():clearKey()
  local artifactPresetMaxCount = ToClient_getMyArtifactBagPresetMaxCount()
  for index = 1, artifactPresetMaxCount do
    self._ui._list2_artifactPreset:getElementManager():pushKey(toInt64(0, index))
  end
  if isHoldScroll ~= nil and isHoldScroll == true then
    self._ui._list2_artifactPreset:setCurrenttoIndex(currentScrollIndex)
    self._ui._list2_artifactPreset:GetVScroll():SetControlPos(currentControlPos)
    if useExtendItem == true and currentControlPos == 1 then
      self._ui._list2_artifactPreset:GetVScroll():SetControlPos(currentContentCount / ToClient_getMyArtifactBagPresetMaxCount())
    end
  end
  self:updatePresetCount()
end
function PaGlobal_ArtifactPreset_All:updatePresetCount()
  if Panel_Window_ArtifactPreset_All == nil then
    return
  end
  local usingCount = ToClient_getMyArtifactBagPresetUsingCount()
  local myMaxCount = ToClient_getMyArtifactBagPresetMaxCount()
  if usingCount > myMaxCount then
    usingCount = myMaxCount
  end
  local presetCountString = usingCount .. "/" .. myMaxCount
  self._ui._txt_presetCount:SetText(presetCountString)
end
function PaGlobal_ArtifactPreset_All:reloadArtifactPresetList()
  if Panel_Window_ArtifactPreset_All == nil then
    return
  end
  local currentContentCount = Int64toInt32(self._ui._list2_artifactPreset:getElementManager():getSize())
  for index = 0, currentContentCount - 1 do
    local s64_key = self._ui._list2_artifactPreset:getKeyByIndex(index)
    local content = self._ui._list2_artifactPreset:GetContentByKey(s64_key)
    if content ~= nil then
      PaGlobalFunc_ArtifactPreset_All_UpdateArtifactPresetList(content, s64_key)
    end
  end
end
function PaGlobal_ArtifactPreset_All:changePadSnapState(newState, isForceChange)
  if Panel_Window_LightStoneBag == nil then
    return
  end
  if self._isPadSnapping == false then
    return
  end
  if newState ~= LightStoneBagConsoleSnapState.SnapOnPreset and newState ~= LightStoneBagConsoleSnapState.SnapOnEditMode then
    UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 PadSnapState \236\158\133\235\139\136\235\139\164.", "\236\152\164\236\131\129\235\175\188")
    return
  end
  local isChangedState = self._currentPadSnapState ~= newState or self._beforePadSnapState ~= newState
  if newState ~= LightStoneBagConsoleSnapState.SnapOnEditMode then
    self._beforePadSnapState = newState
  end
  if self._currentPadSnapState ~= LightStoneBagConsoleSnapState.SnapOnEditMode or isForceChange ~= nil and isForceChange == true then
    self._currentPadSnapState = newState
  end
  if isChangedState == true then
    self:setKeyGuideState()
  end
end
function PaGlobal_ArtifactPreset_All:setKeyGuideState()
  if Panel_Window_ArtifactPreset_All == nil then
    return
  end
  if self._isPadSnapping == false then
    return
  end
  local showKeyGuideList = Array.new()
  local hideKeyGuideList = Array.new()
  if self._currentPadSnapState == LightStoneBagConsoleSnapState.SnapOnPreset then
    self._ui._stc_keyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARTIFACTS_PRESET_BTN_USE"))
    showKeyGuideList:push_back(self._ui._stc_keyGuide_A)
    showKeyGuideList:push_back(self._ui._stc_keyGuide_Y)
    showKeyGuideList:push_back(self._ui._stc_keyGuide_B)
    hideKeyGuideList:push_back(self._ui._stc_keyGuide_X)
    hideKeyGuideList:push_back(self._ui._stc_keyGuide_RTX)
  elseif self._currentPadSnapState == LightStoneBagConsoleSnapState.SnapOnEditMode then
    self._ui._stc_keyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_SELECT"))
    if self._beforePadSnapState == LightStoneBagConsoleSnapState.SnapOnPreset then
      showKeyGuideList:push_back(self._ui._stc_keyGuide_RTX)
      showKeyGuideList:push_back(self._ui._stc_keyGuide_A)
      showKeyGuideList:push_back(self._ui._stc_keyGuide_B)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_X)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_Y)
    else
      showKeyGuideList:push_back(self._ui._stc_keyGuide_RTX)
      showKeyGuideList:push_back(self._ui._stc_keyGuide_A)
      showKeyGuideList:push_back(self._ui._stc_keyGuide_B)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_X)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_Y)
    end
  else
    UI.ASSERT_NAME(false, "\237\152\132\236\158\172 self._currentPadSnapState\236\157\152 \234\176\146\236\151\144 \235\140\128\237\149\156 \236\178\152\235\166\172\234\176\128 \236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.", "\236\152\164\236\131\129\235\175\188")
    return
  end
  for key, control in pairs(showKeyGuideList) do
    if control ~= nil then
      control:SetShow(true)
    end
  end
  for key, control in pairs(hideKeyGuideList) do
    if control ~= nil then
      control:SetShow(false)
    end
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(showKeyGuideList, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
end
function PaGlobal_ArtifactPreset_All:checkSavePreset()
  if Panel_Window_ArtifactPreset_All == nil then
    return
  end
  if self._currentCloseType == nil then
    return
  end
  local function checkSavePresetYes()
    if self._currentSelectedPresetIndex_s64 ~= nil then
      PaGlobalFunc_ArtifactPreset_All_SetPresetName(self._currentSelectedPresetIndex_s64)
    end
    ToClient_saveArtifactBagPresetDataListForLua()
    self._ui._btn_editPreset:SetCheck(false)
    if self._currentCloseType == self._closeType._closePanel then
      PaGlobal_LightStoneBag:prepareClose()
    elseif self._currentCloseType == self._closeType._changeTab then
      PaGlobal_LightStoneBag:onClickedTab(LightStoneBagTabIndex.LightStone)
    end
  end
  local function checkSavePresetNo()
    self._ui._btn_editPreset:SetCheck(false)
    if self._currentCloseType == self._closeType._closePanel then
      PaGlobal_LightStoneBag:prepareClose()
    elseif self._currentCloseType == self._closeType._changeTab then
      PaGlobal_LightStoneBag:onClickedTab(LightStoneBagTabIndex.LightStone)
    end
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_ARTIFACTS_PRESET_WARNING_DESC"),
    functionYes = checkSavePresetYes,
    functionNo = checkSavePresetNo,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
end
function PaGlobal_ArtifactPreset_All:validate()
  if Panel_Window_ArtifactPreset_All == nil then
    return
  end
  self._ui._btn_editPreset:isValidate()
  self._ui._txt_editPreset:isValidate()
  self._ui._txt_presetCount:isValidate()
  self._ui._btn_presetBuy:isValidate()
  self._ui._list2_artifactPreset:isValidate()
end
