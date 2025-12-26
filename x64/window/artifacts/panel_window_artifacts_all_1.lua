function PaGlobal_Artifacts_All:initialize()
  if true == PaGlobal_Artifacts_All._initialize then
    return
  end
  PaGlobal_Artifacts_All:controlAll_Init()
  PaGlobal_Artifacts_All:controlPc_Init()
  PaGlobal_Artifacts_All:controlConsole_Init()
  PaGlobal_Artifacts_All:setControlSetting()
  PaGlobal_Artifacts_All:registEventHandler()
  PaGlobal_Artifacts_All:validate()
  PaGlobal_Artifacts_All._initialize = true
end
function PaGlobal_Artifacts_All:controlAll_Init()
  if nil == Panel_Window_Artifacts_All then
    return
  end
  self._ui.stc_leftMainArea = UI.getChildControl(Panel_Window_Artifacts_All, "Static_LeftMainArea")
  self._ui.stc_rightTopArea = UI.getChildControl(Panel_Window_Artifacts_All, "Static_RightTopArea")
  self._ui.stc_rightBottomArea = UI.getChildControl(Panel_Window_Artifacts_All, "Static_RightBottomArea")
  self._ui.stc_imageArea = UI.getChildControl(self._ui.stc_leftMainArea, "Static_BottomImageArea")
  local stc_artifacts_bg = UI.getChildControl(self._ui.stc_imageArea, "Static_Artifacts_BG")
  local stc_descArea = UI.getChildControl(self._ui.stc_leftMainArea, "Static_TopDescArea")
  self._ui.txt_desc = UI.getChildControl(stc_descArea, "StaticText_LeftTopDesc")
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(self._ui.txt_desc:GetText())
  self._ui.stc_setOn = UI.getChildControl(self._ui.stc_leftMainArea, "Static_Option_BG_On")
  self._ui.txt_setTitle = UI.getChildControl(self._ui.stc_setOn, "MultilineText_SetOption_Title")
  self._ui.txt_setDesc = UI.getChildControl(self._ui.stc_setOn, "MultilineText_SetOption_Desc")
  self._ui.txt_setTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_setDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_setOff = UI.getChildControl(self._ui.stc_leftMainArea, "Static_Option_BG_Off")
  self._ui.txt_setNone = UI.getChildControl(self._ui.stc_setOff, "MultilineText_SetOption_None")
  self._ui.txt_setNone:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_setNone:SetText(self._ui.txt_setNone:GetText())
  self._ui.btn_artifact = {}
  self._ui.stc_artifactsSlotBg = {}
  self._ui.stc_artifactSlot = {}
  self._ui.stc_lightStoneInfoBg = {}
  self._ui.stc_lightStoneInfo = {}
  self._ui.stc_lightStoneSlotBg = {}
  self._ui.stc_lightStoneSlot = {}
  self._artifactItemSlotInfo = {}
  for artifactIdx = 0, self._artifactSlotCount - 1 do
    self._artifactItemSlotInfo[artifactIdx] = {}
    local stc_temp = UI.getChildControl(stc_artifacts_bg, "Static_LightStone_" .. artifactIdx .. "_BG")
    self._ui.btn_artifact[artifactIdx] = UI.getChildControl(stc_artifacts_bg, "RadioButton_Artifacts_" .. artifactIdx)
    self._ui.stc_artifactsSlotBg[artifactIdx] = UI.getChildControl(stc_temp, "Static_MainEquipSlot_BG")
    self._ui.stc_artifactSlot[artifactIdx] = UI.getChildControl(self._ui.stc_artifactsSlotBg[artifactIdx], "Static_MainEquipSlot")
    local artifactSlot = {}
    SlotItem.new(artifactSlot, "ArtifactsEquip_" .. tostring(artifactIdx), 0, self._ui.stc_artifactSlot[artifactIdx], self._slotConfig)
    artifactSlot:createChild()
    artifactSlot.empty = true
    artifactSlot:clearItem()
    artifactSlot.border:SetSize(44, 44)
    self._artifactItemSlotInfo[artifactIdx].slot = artifactSlot
    self._artifactItemSlotInfo[artifactIdx].slotNo = -1
    self._artifactItemSlotInfo[artifactIdx].empty = true
    for idx = 1, self._lightStoneSlotCount do
      local lightStoneIdx = artifactIdx * self._artifactSlotCount + idx
      self._ui.stc_lightStoneInfoBg[lightStoneIdx] = UI.getChildControl(stc_temp, "Static_LightStoneInfo" .. idx)
      self._ui.stc_lightStoneSlotBg[lightStoneIdx] = UI.getChildControl(stc_temp, "Static_LightStoneItemSlotBG" .. idx)
      self._ui.stc_lightStoneInfo[lightStoneIdx] = {}
      self._ui.stc_lightStoneInfo[lightStoneIdx].name = UI.getChildControl(self._ui.stc_lightStoneInfoBg[lightStoneIdx], "StaticText_LightStoneName")
      self._ui.stc_lightStoneInfo[lightStoneIdx].desc = UI.getChildControl(self._ui.stc_lightStoneInfoBg[lightStoneIdx], "StaticText_LightStoneDesc")
      self._ui.stc_lightStoneInfo[lightStoneIdx].txt_empty = UI.getChildControl(self._ui.stc_lightStoneInfoBg[lightStoneIdx], "MultilineText_Empty")
      self._ui.stc_lightStoneInfo[lightStoneIdx].slotDecoOn = UI.getChildControl(self._ui.stc_lightStoneSlotBg[lightStoneIdx], "Static_SlotDeco_On")
      self._ui.stc_lightStoneInfo[lightStoneIdx].setTexture = UI.getChildControl(self._ui.stc_lightStoneInfoBg[lightStoneIdx], "Static_SetTexture")
      self._ui.stc_lightStoneInfo[lightStoneIdx].empty = true
      self._ui.stc_lightStoneSlot[lightStoneIdx] = UI.getChildControl(self._ui.stc_lightStoneSlotBg[lightStoneIdx], "Static_" .. idx)
      local lightStoneSlot = {}
      SlotItem.new(lightStoneSlot, "ArtifactsLightStone_" .. tostring(lightStoneIdx), 0, self._ui.stc_lightStoneSlot[lightStoneIdx], self._slotConfig)
      lightStoneSlot:createChild()
      lightStoneSlot.empty = true
      lightStoneSlot:clearItem()
      lightStoneSlot.icon:SetPosX(1)
      lightStoneSlot.icon:SetPosY(1)
      lightStoneSlot.border:SetSize(44, 44)
      self._ui.stc_lightStoneInfo[lightStoneIdx].slot = lightStoneSlot
    end
  end
  self._ui.stc_tabTypeBg = UI.getChildControl(Panel_Window_Artifacts_All, "Static_TabTypeBg")
  self._ui.btn_tab = {}
  local btnName = ""
  for tabIdx = 1, 2 do
    if 1 == tabIdx then
      btnName = "Radiobutton_Equipment"
    else
      btnName = "Radiobutton_Crystal"
    end
    self._ui.btn_tab[tabIdx] = UI.getChildControl(self._ui.stc_tabTypeBg, btnName)
  end
  self._ui.stc_selectBar = UI.getChildControl(self._ui.stc_tabTypeBg, "Static_SelectBar")
  self._ui.list_artifact = UI.getChildControl(self._ui.stc_rightTopArea, "List2_ExtractableItemList")
  local artifactListContent = UI.getChildControl(self._ui.list_artifact, "List2_1_Content")
  local artifactBtn = UI.getChildControl(artifactListContent, "RadioButton_ExtractableItem")
  local stc_artifactListSlotBg = UI.getChildControl(artifactBtn, "Static_ItemSlotBG")
  local stc_artifactListSlot = UI.getChildControl(stc_artifactListSlotBg, "Static_ItemIcon")
  local artifactListSlot = {}
  SlotItem.new(artifactListSlot, "ArtifactListSlot_", 0, stc_artifactListSlot, self._slotConfig)
  artifactListSlot:createChild()
  artifactListSlot.empty = true
  artifactListSlot:clearItem()
  artifactListSlot.icon:SetPosX(1)
  artifactListSlot.icon:SetPosY(1)
  artifactListSlot.border:SetSize(44, 44)
  self._ui.vscroll_artifactList = self._ui.list_artifact:GetVScroll()
  self._ui.list_lightStone = UI.getChildControl(self._ui.stc_rightBottomArea, "List2_ExtractionMaterialItemList")
  local lightStoneListContent = UI.getChildControl(self._ui.list_lightStone, "List2_1_Content")
  local lightStoneBtn = UI.getChildControl(lightStoneListContent, "RadioButton_ExtractionMaterialItem")
  local stc_lightStoneListSlotBg = UI.getChildControl(lightStoneBtn, "Static_ItemSlotBG")
  local stc_lightStoneListSlot = UI.getChildControl(stc_lightStoneListSlotBg, "Static_ItemIcon")
  local lightStoneListSlot = {}
  SlotItem.new(lightStoneListSlot, "LightStoneListSlot_", 0, stc_lightStoneListSlot, self._slotConfig)
  lightStoneListSlot:createChild()
  lightStoneListSlot.empty = true
  lightStoneListSlot:clearItem()
  lightStoneListSlot.icon:SetPosX(1)
  lightStoneListSlot.icon:SetPosY(1)
  lightStoneListSlot.border:SetSize(44, 44)
  self._ui.vscroll_lightStoneList = self._ui.list_lightStone:GetVScroll()
  self._ui.txt_emptyArtifact = UI.getChildControl(self._ui.stc_rightTopArea, "MultilineText_Empty_Desc")
  self._ui.txt_emptyLightStone = UI.getChildControl(self._ui.stc_rightBottomArea, "MultilineText_Empty_Desc")
  self._ui.btn_showList = UI.getChildControl(Panel_Window_Artifacts_All, "Button_ShowList")
end
function PaGlobal_Artifacts_All:controlPc_Init()
  if nil == Panel_Window_Artifacts_All then
    return
  end
  local stc_titlebarArea = UI.getChildControl(Panel_Window_Artifacts_All, "Static_TitlebarArea")
  self._ui_pc.btn_close = UI.getChildControl(stc_titlebarArea, "Button_Close")
  self._ui_pc.btn_question = UI.getChildControl(stc_titlebarArea, "Button_Question")
  self._ui_pc.stc_LClick = UI.getChildControl(Panel_Window_Artifacts_All, "StaticText_LClick")
  self._ui_pc.stc_RClick = UI.getChildControl(Panel_Window_Artifacts_All, "StaticText_RClick")
end
function PaGlobal_Artifacts_All:controlConsole_Init()
  if nil == Panel_Window_Artifacts_All then
    return
  end
  self._ui_console.stc_guideBg = UI.getChildControl(Panel_Window_Artifacts_All, "Static_BottomConsoleButtons")
  self._ui_console.stc_iconLB = UI.getChildControl(self._ui.stc_tabTypeBg, "Static_LB_ConsoleUI")
  self._ui_console.stc_iconRB = UI.getChildControl(self._ui.stc_tabTypeBg, "Static_RB_ConsoleUI")
  self._ui_console.stc_select = UI.getChildControl(self._ui_console.stc_guideBg, "Button_Select")
  self._ui_console.stc_cancle = UI.getChildControl(self._ui_console.stc_guideBg, "Button_Cancel")
  self._ui_console.stc_detail = UI.getChildControl(self._ui_console.stc_guideBg, "Button_Detail")
  self._ui_console.stc_remove_lightStone = UI.getChildControl(self._ui_console.stc_guideBg, "Button_Delete")
  self._ui_console.stc_remove_artifact = UI.getChildControl(self._ui_console.stc_guideBg, "StaticText_Y_ConsoleUI")
end
function PaGlobal_Artifacts_All:setControlSetting()
  if nil == Panel_Window_Artifacts_All then
    return
  end
  self._ui_pc.btn_close:SetShow(false == self._isConsole)
  self._ui_pc.btn_question:SetShow(false == self._isConsole)
  self._ui_pc.stc_LClick:SetShow(false == self._isConsole)
  self._ui_pc.stc_RClick:SetShow(false == self._isConsole)
  self._ui_console.stc_guideBg:SetShow(true == self._isConsole)
  self._ui_console.stc_iconLB:SetShow(true == self._isConsole)
  self._ui_console.stc_iconRB:SetShow(true == self._isConsole)
  if false == self._isConsole then
  else
    for tabIdx = 1, self._tabCount do
      self._ui.btn_tab[tabIdx]:SetIgnore(true)
    end
    for artifactIdx = 0, 1 do
      self._artifactItemSlotInfo[artifactIdx].slot.icon:SetIgnore(true)
      self._ui.stc_artifactsSlotBg[artifactIdx]:SetIgnore(true)
      self._ui.stc_artifactSlot[artifactIdx]:SetIgnore(true)
    end
  end
  self:changePadSnapState(self._PAD_SNAP_STATE.Default)
end
function PaGlobal_Artifacts_All:registEventHandler()
  if nil == Panel_Window_Artifacts_All then
    return
  end
  registerEvent("onScreenResize", "PaGlobalFunc_Artifacts_All_Resize")
  registerEvent("FromClient_ChangeArtifactSocket", "FromClient_Artifacts_All_ChangeArtifactSocket")
  registerEvent("FromClient_InventoryUpdate", "FromClient_Artifacts_All_updateArtifactList")
  registerEvent("EventEquipmentUpdate", "FromClient_Artifacts_All_updateArtifactList")
  self._ui.list_artifact:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_Artifacts_All_UpdateArtifactList")
  self._ui.list_artifact:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list_lightStone:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_Artifacts_All_UpdateLightStoneList")
  self._ui.list_lightStone:createChildContent(__ePAUIList2ElementManagerType_List)
  if ToClient_isConsole() == true then
    self._ui.btn_showList:addInputEvent("Mouse_LUp", "PaGlobalFunc_Artifacts_All_OpenAllList()")
  else
    self._ui.btn_showList:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowArtifactList\" )")
  end
  if false == self._isConsole then
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Artifacts_All_Close()")
    self._ui_pc.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowArtifact\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui_pc.btn_question, "\"PanelWindowArtifact\"")
    for tabIdx = 1, self._tabCount do
      self._ui.btn_tab[tabIdx]:addInputEvent("Mouse_LUp", "HandleEventLUp_Artifacts_All_SelectTab(" .. tabIdx .. ")")
    end
  else
    Panel_Window_Artifacts_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLBRB_Artifacts_All_MoveTab(-1)")
    Panel_Window_Artifacts_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventLBRB_Artifacts_All_MoveTab(1)")
  end
  for artifactIdx = 0, self._artifactSlotCount - 1 do
    self._ui.btn_artifact[artifactIdx]:addInputEvent("Mouse_LUp", "HandleEventLUp_Artifacts_All_SelectArtifactSlot(" .. artifactIdx .. ")")
    if false == self._isConsole then
      self._ui.btn_artifact[artifactIdx]:addInputEvent("Mouse_LUp", "HandleEventLUp_Artifacts_All_SelectArtifactSlot(" .. artifactIdx .. ")")
      self._artifactItemSlotInfo[artifactIdx].slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Artifacts_All_ClearArtifactSlot(" .. artifactIdx .. ")")
      for idx = 1, self._lightStoneSlotCount do
        local lightStoneIdx = artifactIdx * self._artifactSlotCount + idx
        self._ui.stc_lightStoneInfo[lightStoneIdx].slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Artifacts_All_RemoveLightStone(" .. artifactIdx .. ", " .. idx .. ", " .. lightStoneIdx .. ")")
      end
    else
      self._ui.btn_artifact[artifactIdx]:addInputEvent("Mouse_On", "HandleEventOn_Artifacts_All_MainSlot(true)")
      self._ui.btn_artifact[artifactIdx]:addInputEvent("Mouse_Out", "HandleEventOn_Artifacts_All_MainSlot(false)")
      self._ui.btn_artifact[artifactIdx]:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventRUp_Artifacts_All_ClearArtifactSlot(" .. artifactIdx .. ")")
      self._artifactItemSlotInfo[artifactIdx].slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Artifacts_All_SelectArtifactSlot(" .. artifactIdx .. ")")
      for idx = 1, self._lightStoneSlotCount do
        local lightStoneIdx = artifactIdx * self._artifactSlotCount + idx
        self._ui.stc_lightStoneSlot[lightStoneIdx]:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventRUp_Artifacts_All_RemoveLightStone(" .. artifactIdx .. ", " .. idx .. ", " .. lightStoneIdx .. ")")
      end
    end
  end
end
function PaGlobal_Artifacts_All:updateArtifactRadio()
  for idx = 0, 1 do
    if idx ~= self._selectArtifactIndex then
      self._ui.btn_artifact[idx]:SetCheck(false)
    else
      self._ui.btn_artifact[idx]:SetCheck(true)
    end
  end
end
function PaGlobal_Artifacts_All:prepareOpen()
  if nil == Panel_Window_Artifacts_All then
    return
  end
  if self._isConsole == false then
    if _ContentsGroup_LightStoneBag == true and Panel_Window_LightStoneBag ~= nil and PaGlobalFunc_LightStoneBag_IsShow ~= nil then
      self._isOpenLightStoneBag = PaGlobalFunc_LightStoneBag_IsShow()
      if self._isOpenLightStoneBag == true and PaGlobalFunc_LightStoneBag_Close ~= nil then
        PaGlobalFunc_LightStoneBag_Close()
      end
    end
    if Panel_Window_Inventory_All ~= nil then
      if Panel_Window_Inventory_All:GetShow() == true then
        self._isOpenInven = true
        PaGlobalFunc_Inventory_All_Close()
      else
        self._isOpenInven = false
      end
    end
  end
  self._indexPopSocket = -1
  self._slotNoPopArtifact = -1
  self._lightStoneIndexPop = -1
  self._slotNo = -1
  self._selectArtifactIndex = 0
  self._whereType = CppEnums.ItemWhereType.eInventory
  Panel_Window_Artifacts_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  self:resize()
  self:clearAllSlots()
  self._ui.list_artifact:moveTopIndex()
  self._ui.list_lightStone:moveTopIndex()
  self:selectTab(self._TAB.ARTIFACT)
  self:updateArtifactRadio()
  self:open()
end
function PaGlobal_Artifacts_All:open()
  if nil == Panel_Window_Artifacts_All then
    return
  end
  Panel_Window_Artifacts_All:SetShow(true)
end
function PaGlobal_Artifacts_All:prepareClose()
  if nil == Panel_Window_Artifacts_All then
    return
  end
  getSocketInformation():clearLightStoneInvenInfoList()
  self:changePadSnapState(self._PAD_SNAP_STATE.Default)
  Panel_Window_Artifacts_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  PaGlobal_Artifacts_All:close()
end
function PaGlobal_Artifacts_All:close()
  if nil == Panel_Window_Artifacts_All then
    return
  end
  Panel_Window_Artifacts_All:SetShow(false)
end
function PaGlobal_Artifacts_All:validate()
  if nil == Panel_Window_Artifacts_All then
    return
  end
end
function PaGlobal_Artifacts_All:resize()
  if nil == Panel_Window_Artifacts_All then
    return
  end
  local RPosX = self._ui.stc_leftMainArea:GetPosX() + self._ui.stc_leftMainArea:GetSizeX() - self._ui_pc.stc_RClick:GetTextSizeX() - self._ui_pc.stc_RClick:GetSizeX()
  self._ui_pc.stc_RClick:SetPosX(RPosX - 30)
  local LPosX = self._ui_pc.stc_RClick:GetPosX() - self._ui_pc.stc_LClick:GetTextSizeX() - self._ui_pc.stc_LClick:GetSizeX()
  self._ui_pc.stc_LClick:SetPosX(LPosX - 20)
  Panel_Window_Artifacts_All:ComputePos()
end
function PaGlobal_Artifacts_All:changePadSnapState(padSnapState)
  if Panel_Window_Artifacts_All == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  local showKeyGuideList = Array.new()
  local hideKeyGuideList = Array.new()
  if padSnapState == nil or padSnapState == self._PAD_SNAP_STATE.Default then
    showKeyGuideList:push_back(self._ui_console.stc_detail)
    showKeyGuideList:push_back(self._ui_console.stc_select)
    showKeyGuideList:push_back(self._ui_console.stc_cancle)
    hideKeyGuideList:push_back(self._ui_console.stc_remove_lightStone)
    hideKeyGuideList:push_back(self._ui_console.stc_remove_artifact)
  elseif padSnapState == self._PAD_SNAP_STATE.OnMainSlot then
    showKeyGuideList:push_back(self._ui_console.stc_remove_artifact)
    showKeyGuideList:push_back(self._ui_console.stc_detail)
    showKeyGuideList:push_back(self._ui_console.stc_select)
    showKeyGuideList:push_back(self._ui_console.stc_cancle)
    hideKeyGuideList:push_back(self._ui_console.stc_remove_lightStone)
  elseif padSnapState == self._PAD_SNAP_STATE.OnSubSlot then
    showKeyGuideList:push_back(self._ui_console.stc_remove_lightStone)
    showKeyGuideList:push_back(self._ui_console.stc_detail)
    showKeyGuideList:push_back(self._ui_console.stc_select)
    showKeyGuideList:push_back(self._ui_console.stc_cancle)
    hideKeyGuideList:push_back(self._ui_console.stc_remove_artifact)
  else
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
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(showKeyGuideList, self._ui_console.stc_guideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
end
function PaGlobal_Artifacts_All:updateArtifactList()
  if nil == Panel_Window_Artifacts_All then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local invenSize = selfPlayer:getInventorySlotCount(false)
  local listCount = -1
  local toIndex = self._ui.list_artifact:getCurrenttoIndex()
  local scrollValue = self._ui.vscroll_artifactList:GetControlPos()
  self._ui.list_artifact:getElementManager():clearKey()
  self._indexInvenEnd = -1
  self._artifactList = {}
  self._slotIconList = {}
  for idx = 0, invenSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, idx)
    if nil ~= itemWrapper and true == self:filterInvenArtifact(idx, itemWrapper, CppEnums.ItemWhereType.eInventory) then
      listCount = listCount + 1
      self._artifactList[listCount] = idx
      self._ui.list_artifact:getElementManager():pushKey(toInt64(0, listCount))
    end
  end
  self._indexInvenEnd = listCount
  for equipIdx = __eEquipSlotNoRightHand, __eEquipSlotNoCount do
    local itemWrapper = ToClient_getEquipmentItem(equipIdx)
    if nil ~= itemWrapper and true == self:filterEquipArtifact(equipIdx, itemWrapper) then
      listCount = listCount + 1
      self._artifactList[listCount] = equipIdx
      self._ui.list_artifact:getElementManager():pushKey(toInt64(0, listCount))
    end
  end
  self._ui.list_artifact:setCurrenttoIndex(toIndex)
  if false == self._ui.list_artifact:IsIgnoreVerticalScroll() then
    self._ui.vscroll_artifactList:SetControlPos(scrollValue)
  end
  self._ui.list_artifact:SetShow(false)
  self._ui.txt_emptyArtifact:SetShow(false)
  if listCount >= 0 then
    self._ui.list_artifact:SetShow(true)
  else
    self._ui.txt_emptyArtifact:SetShow(true)
  end
end
function PaGlobal_Artifacts_All:updateLightStoneList()
  if nil == Panel_Window_Artifacts_All then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local invenSize = selfPlayer:getInventorySlotCount(false)
  local listCount = -1
  local toIndex = self._ui.list_lightStone:getCurrenttoIndex()
  local scrollValue = self._ui.vscroll_lightStoneList:GetControlPos()
  self._ui.list_lightStone:getElementManager():clearKey()
  self._lightStoneList = {}
  self._slotIconList = {}
  local lightStoneCountAtInven = getSocketInformation():getCountLightStoneAtInventoryAfterSort()
  for idx = 0, lightStoneCountAtInven - 1 do
    local slotNo = getSocketInformation():getLightStoneInventorySlotNo(idx)
    self._lightStoneList[idx] = slotNo
    self._ui.list_lightStone:getElementManager():pushKey(toInt64(0, idx))
  end
  self._ui.list_lightStone:setCurrenttoIndex(toIndex)
  if false == self._ui.list_lightStone:IsIgnoreVerticalScroll() then
    self._ui.vscroll_lightStoneList:SetControlPos(scrollValue)
  end
  self._ui.list_lightStone:SetShow(false)
  self._ui.txt_emptyLightStone:SetShow(false)
  if lightStoneCountAtInven > 0 then
    self._ui.list_lightStone:SetShow(true)
  else
    self._ui.txt_emptyLightStone:SetShow(true)
  end
end
function PaGlobal_Artifacts_All:filterInvenArtifact(slotNo, itemWrapper, whereType)
  if nil == itemWrapper then
    return
  end
  if true == ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    return false
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if true == itemSSW:get():isArtifact() then
    return true
  end
  return false
end
function PaGlobal_Artifacts_All:filterEquipArtifact(slotNo, itemWrapper)
  if nil == itemWrapper then
    return
  end
  if true == ToClient_EquipSlot_CheckItemLock(slotNo, CppEnums.ItemWhereType.eEquip) then
    return false
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if true == itemSSW:get():isArtifact() then
    return true
  end
  return false
end
function PaGlobal_Artifacts_All:filterLightStone(slotNo, itemWrapper)
  if nil == itemWrapper then
    return
  end
  if true == ToClient_Inventory_CheckItemLock(slotNo, CppEnums.ItemWhereType.eInventory) then
    return false
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if true == itemSSW:get():isLightStone() then
    return true
  end
  return false
end
function PaGlobal_Artifacts_All:clearArtifactSlot(artifactIdx)
  if nil == artifactIdx then
    PaGlobal_Artifacts_All:clearAllSlots()
    return
  end
  if self._selectArtifactIndex == artifactIdx then
    getSocketInformation():popEquip()
  end
  self._artifactItemSlotInfo[artifactIdx].slotNo = -1
  self._artifactItemSlotInfo[artifactIdx].slot:clearItem()
  self._artifactItemSlotInfo[artifactIdx].slot.icon:SetShow(false)
  self._artifactItemSlotInfo[artifactIdx].empty = true
  for idx = 1, self._lightStoneSlotCount do
    local lightStoneIdx = artifactIdx * self._artifactSlotCount + idx
    self._ui.stc_lightStoneInfo[lightStoneIdx].name:SetText("")
    self._ui.stc_lightStoneInfo[lightStoneIdx].desc:SetText("")
    self._ui.stc_lightStoneInfo[lightStoneIdx].txt_empty:SetShow(true)
    self._ui.stc_lightStoneInfo[lightStoneIdx].slotDecoOn:SetShow(false)
    self._ui.stc_lightStoneInfo[lightStoneIdx].setTexture:SetShow(false)
    self._ui.stc_lightStoneInfo[lightStoneIdx].slot:clearItem()
    self._ui.stc_lightStoneInfo[lightStoneIdx].slot.icon:addInputEvent("Mouse_On", "")
    self._ui.stc_lightStoneInfo[lightStoneIdx].slot.icon:addInputEvent("Mouse_Out", "")
    self._ui.stc_lightStoneSlot[lightStoneIdx]:addInputEvent("Mouse_On", "")
    self._ui.stc_lightStoneSlot[lightStoneIdx]:addInputEvent("Mouse_Out", "")
    self._ui.stc_lightStoneInfo[lightStoneIdx].slot.icon:EraseAllEffect()
    self._ui.stc_lightStoneInfo[lightStoneIdx].empty = true
  end
  self:updateLightStoneSet()
end
function PaGlobal_Artifacts_All:clearAllSlots()
  for artifactIdx = 0, self._artifactSlotCount - 1 do
    self:clearArtifactSlot(artifactIdx)
  end
  getSocketInformation():clearData()
  PaGlobal_Artifacts_All._ui.list_artifact:requestUpdateVisible()
end
function PaGlobal_Artifacts_All:selectTab(tabIdx)
  self._ui.stc_rightTopArea:SetShow(false)
  self._ui.stc_rightBottomArea:SetShow(false)
  self._selectTab = tabIdx
  if self._TAB.ARTIFACT == tabIdx then
    self._ui.stc_rightTopArea:SetShow(true)
    self:updateArtifactList()
  else
    self._ui.stc_rightBottomArea:SetShow(true)
    self:updateLightStoneList()
  end
  local tabControl = self._ui.btn_tab[tabIdx]
  if nil == tabControl then
    self._ui.stc_selectBar:SetShow(false)
    return
  end
  self._ui.stc_selectBar:SetShow(true)
  self._ui.stc_selectBar:SetPosX(tabControl:GetPosX() + tabControl:GetSizeX() / 2 - self._ui.stc_selectBar:GetSizeX() / 2)
  tabControl:SetCheck(true)
end
function PaGlobal_Artifacts_All:updateArtifactSlot(artifactIdx)
  if true == self._artifactItemSlotInfo[artifactIdx].empty then
    return
  end
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, self._artifactItemSlotInfo[artifactIdx].slotNo)
  if nil == itemWrapper then
    return
  end
  self._ui.btn_artifact[artifactIdx]:EraseAllEffect()
  self._ui.btn_artifact[artifactIdx]:AddEffect("fUI_GuildCompensation_01A", false, -226, 0)
  audioPostEvent_SystemUi(5, 6)
  _AudioPostEvent_SystemUiForXBOX(5, 6)
  local lightStoneCount = itemWrapper:get():getUsableItemSocketCount()
  local classType = getSelfPlayer():getClassType()
  for idx = 1, lightStoneCount do
    local lightStoneIdx = artifactIdx * self._artifactSlotCount + idx
    local lightStoneSlot = self._ui.stc_lightStoneInfo[lightStoneIdx].slot
    local itemSW = itemWrapper:getPushedItem(idx - 1)
    if nil == itemSW then
      lightStoneSlot.icon:SetShow(false)
      lightStoneSlot:clearItem()
      lightStoneSlot.empty = true
      self._ui.stc_lightStoneInfo[lightStoneIdx].name:SetText("")
      self._ui.stc_lightStoneInfo[lightStoneIdx].desc:SetText("")
      self._ui.stc_lightStoneInfo[lightStoneIdx].txt_empty:SetShow(true)
      self._ui.stc_lightStoneInfo[lightStoneIdx].slotDecoOn:SetShow(false)
      self._ui.stc_lightStoneInfo[lightStoneIdx].setTexture:SetShow(false)
      self._ui.stc_lightStoneInfo[lightStoneIdx].empty = true
      if true == self._isConsole then
        self._ui.stc_lightStoneSlot[lightStoneIdx]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
        self._ui.stc_lightStoneSlot[lightStoneIdx]:addInputEvent("Mouse_On", "")
        self._ui.stc_lightStoneSlot[lightStoneIdx]:addInputEvent("Mouse_Out", "")
        lightStoneSlot.icon:addInputEvent("Mouse_On", "")
        lightStoneSlot.icon:addInputEvent("Mouse_Out", "")
      else
        self._ui.stc_lightStoneInfo[lightStoneIdx].slot.icon:SetIgnore(true)
        self._ui.stc_lightStoneInfo[lightStoneIdx].slot.icon:addInputEvent("Mouse_On", "")
        self._ui.stc_lightStoneInfo[lightStoneIdx].slot.icon:addInputEvent("Mouse_Out", "")
      end
    else
      local itemKey = itemSW:get()._key:getItemKey()
      self._ui.stc_lightStoneInfo[lightStoneIdx].txt_empty:SetShow(false)
      self._ui.stc_lightStoneInfo[lightStoneIdx].slotDecoOn:SetShow(true)
      self._ui.stc_lightStoneInfo[lightStoneIdx].setTexture:SetShow(false)
      lightStoneSlot.icon:SetShow(true)
      lightStoneSlot:setItemByStaticStatus(itemSW, 0)
      local lightStoneName = itemSW:getName()
      local stringSplit = string.split(lightStoneName, "-")
      self._ui.stc_lightStoneInfo[lightStoneIdx].name:SetTextMode(__eTextMode_Limit_AutoWrap)
      self._ui.stc_lightStoneInfo[lightStoneIdx].name:SetText(stringSplit[1])
      PAGlobalFunc_SetItemTextColor(self._ui.stc_lightStoneInfo[lightStoneIdx].name, itemSW)
      self._ui.stc_lightStoneInfo[lightStoneIdx].empty = false
      if true == self._isConsole then
        self._ui.stc_lightStoneSlot[lightStoneIdx]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Artifacts_All_LightStoneSlotTooltip(" .. itemKey .. ",true," .. lightStoneIdx .. ")")
        lightStoneSlot.icon:addInputEvent("Mouse_On", "HandleEventOn_Artifacts_All_LightStoneSlot(true)")
        lightStoneSlot.icon:addInputEvent("Mouse_Out", "HandleEventOn_Artifacts_All_LightStoneSlot(false)")
      else
        self._ui.stc_lightStoneInfo[lightStoneIdx].slot.icon:SetIgnore(false)
        self._ui.stc_lightStoneInfo[lightStoneIdx].slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Artifacts_All_LightStoneSlotTooltip(" .. itemKey .. ",true," .. lightStoneIdx .. ")")
        self._ui.stc_lightStoneInfo[lightStoneIdx].slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Artifacts_All_LightStoneSlotTooltip(" .. itemKey .. ",false," .. lightStoneIdx .. ")")
      end
      local jewelSkillStaticWrapper = itemSW:getSkillByIdx(classType)
      if nil ~= jewelSkillStaticWrapper then
        local buffCount = jewelSkillStaticWrapper:getBuffCount()
        local descText = ""
        for buffIdx = 0, buffCount - 1 do
          local descCurrent = jewelSkillStaticWrapper:getBuffDescription(buffIdx)
          if "" == descCurrent then
            break
          end
          if 0 == buffIdx then
            descText = descCurrent
          else
            descText = descText .. "\n" .. descCurrent
          end
        end
        self._ui.stc_lightStoneInfo[lightStoneIdx].desc:SetTextMode(__eTextMode_AutoWrap)
        self._ui.stc_lightStoneInfo[lightStoneIdx].desc:SetText(descText)
      end
      self._ui.stc_lightStoneInfo[lightStoneIdx].slot.icon:EraseAllEffect()
      if 1 == idx then
        self._ui.stc_lightStoneInfo[lightStoneIdx].slot.icon:AddEffect("fUI_InstallCrystal_02A", true, 0, 0)
      elseif 2 == idx then
        self._ui.stc_lightStoneInfo[lightStoneIdx].slot.icon:AddEffect("fUI_InstallCrystal_02B", true, 0, 0)
      end
    end
  end
  self:updateArtifactRadio()
end
function PaGlobal_Artifacts_All:updateLightStoneSet()
  if true == self._artifactItemSlotInfo[0].empty or true == self._artifactItemSlotInfo[1].empty then
    self._ui.stc_setOn:EraseAllEffect()
    self._ui.stc_setOn:SetShow(false)
    self._ui.stc_setOff:SetShow(true)
    return
  end
  if nil == self._artifactItemSlotInfo[0].slotNo or nil == self._artifactItemSlotInfo[1].slotNo then
    self._ui.stc_setOn:EraseAllEffect()
    self._ui.stc_setOn:SetShow(false)
    self._ui.stc_setOff:SetShow(true)
    return
  end
  local slotNo1 = self._artifactItemSlotInfo[0].slotNo
  local slotNo2 = self._artifactItemSlotInfo[1].slotNo
  local desc = ToClient_getLightStoneSetByInvenSlotNo(slotNo1, slotNo2)
  if nil == desc then
    self._ui.stc_setOn:EraseAllEffect()
    self._ui.stc_setOn:SetShow(false)
    self._ui.stc_setOff:SetShow(true)
    return
  end
  self._ui.stc_setOn:EraseAllEffect()
  self._ui.stc_setOn:SetShow(true)
  self._ui.stc_setOff:SetShow(false)
  self._ui.stc_setOn:AddEffect("fUI_Alchemy_Unite_Upgrade_01C", false, 0, 0)
  audioPostEvent_SystemUi(5, 6)
  _AudioPostEvent_SystemUiForXBOX(5, 6)
  self._ui.txt_setDesc:SetText(desc)
end
