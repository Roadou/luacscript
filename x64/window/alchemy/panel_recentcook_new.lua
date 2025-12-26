local UseRecordFailReasons = {
  NoError = 0,
  InvalidRecord = 1,
  NoMaterial = 2,
  NoMaterialCount = 3
}
PaGlobal_RecentCook = {
  _isCook = false,
  _maxRecordCount = 10,
  _ui = {
    _buttonClose = UI.getChildControl(Panel_RecentCook, "Button_Close"),
    _title = UI.getChildControl(Panel_RecentCook, "StaticText_TitleName"),
    _Bg = UI.getChildControl(Panel_RecentCook, "Static_CookBG"),
    _titleBg = UI.getChildControl(Panel_RecentCook, "StaticText_Title"),
    _keyGuideBg = UI.getChildControl(Panel_RecentCook, "Static_KeyGuide_Console")
  }
}
function PaGlobal_RecentCook:initialize()
  local ui = self._ui
  local recentRecordGroup = {}
  self._maxMaterialCount = 5
  recentRecordGroup[1] = UI.getChildControl(Panel_RecentCook, "Static_CookRecipeBG")
  local posY = recentRecordGroup[1]:GetPosY()
  for recordIndex = 2, self._maxRecordCount do
    posY = posY + recentRecordGroup[1]:GetSizeY() + 2
    recentRecordGroup[recordIndex] = UI.cloneControl(recentRecordGroup[1], Panel_RecentCook, "Static_CookRecipeBG_" .. recordIndex)
    recentRecordGroup[recordIndex]:SetPosY(posY)
  end
  ui._keyGuideBg:SetShow(_ContentsGroup_UsePadSnapping)
  ui._keyGuideA = UI.getChildControl(ui._keyGuideBg, "StaticText_Select")
  ui._keyGuideB = UI.getChildControl(ui._keyGuideBg, "StaticText_Close")
  ui._keyGuideY = UI.getChildControl(ui._keyGuideBg, "StaticText_Delete")
  ui._buttonClose:addInputEvent("Mouse_LUp", "PaGlobal_RecentCook:closePanel()")
  ui._recordList = {}
  local selectButtonSizeX = UI.getChildControl(recentRecordGroup[1], "Button_Setup"):GetSizeX()
  local deleteButtonSizeX = UI.getChildControl(recentRecordGroup[1], "Button_Remove"):GetSizeX()
  for recordIndex = 1, self._maxRecordCount do
    local uiRecordRow = {
      _staticBackground = recentRecordGroup[recordIndex],
      _staticTextRecordNumber = UI.getChildControl(recentRecordGroup[recordIndex], "StaticText_RecentCookNum"),
      _staticMaterialIcon = {},
      _buttonSetup = UI.getChildControl(recentRecordGroup[recordIndex], "Button_Setup"),
      _buttonDeleteRecent = UI.getChildControl(recentRecordGroup[recordIndex], "Button_Remove")
    }
    uiRecordRow._stc_padFocus = UI.getChildControl(uiRecordRow._staticTextRecordNumber, "Static_Focus")
    uiRecordRow._stc_padFocus:SetShow(_ContentsGroup_UsePadSnapping)
    uiRecordRow._staticTextRecordNumber:SetText(recordIndex)
    if _ContentsGroup_UsePadSnapping == false then
      uiRecordRow._buttonSetup:addInputEvent("Mouse_LUp", "PaGlobal_RecentCook:selectAlchemyRecord(" .. recordIndex .. ")")
      uiRecordRow._buttonDeleteRecent:addInputEvent("Mouse_LUp", "PaGlobal_RecentCook:deleteAlchemyRecord(" .. recordIndex .. ")")
    else
      uiRecordRow._stc_padFocus:SetShow(true)
      uiRecordRow._buttonSetup:SetShow(false)
      uiRecordRow._buttonDeleteRecent:SetShow(false)
      if _ContentsGroup_DeleteRecentAlchemyCookList == true then
        uiRecordRow._staticTextRecordNumber:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobal_RecentCook:deleteAlchemyRecord(" .. recordIndex .. ")")
      end
      uiRecordRow._staticTextRecordNumber:registerPadEvent(__eConsoleUIPadEvent_A, "PaGlobal_RecentCook:selectAlchemyRecord(" .. recordIndex .. ")")
    end
    for i = 1, self._maxMaterialCount do
      local slotIconParent = UI.getChildControl(recentRecordGroup[recordIndex], "Static_IconSlot" .. i)
      local slotIcon = {}
      slotIcon = SlotItem.new(slotIcon, "MaterialIcon_" .. recordIndex .. "_" .. i, i, slotIconParent, {
        createIcon = true,
        createBorder = true,
        createCount = true,
        createCash = true
      })
      slotIcon:createChild()
      slotIcon.icon:SetSize(slotIconParent:GetSizeX(), slotIconParent:GetSizeY())
      slotIcon.icon:addInputEvent("Mouse_On", "PaGlobal_RecentCook:handleMouseOn_MaterialIcon(" .. recordIndex .. "," .. i .. ")")
      slotIcon.icon:addInputEvent("Mouse_Out", "PaGlobal_RecentCook:handleMouseOut_MaterialIcon()")
      slotIcon.count:SetSize(slotIconParent:GetSizeX(), slotIconParent:GetSizeY() / 2)
      slotIcon.count:SetVerticalBottom()
      slotIcon.border:SetSize(slotIconParent:GetSizeX(), slotIconParent:GetSizeY())
      slotIcon.border:SetPosXY(0, 0)
      uiRecordRow._staticMaterialIcon[i] = slotIcon
    end
    ui._recordList[recordIndex] = uiRecordRow
  end
  if _ContentsGroup_UsePadSnapping == true then
    local gap = 30
    Panel_RecentCook:SetSize(Panel_RecentCook:GetSizeX() - (selectButtonSizeX + deleteButtonSizeX + gap), Panel_RecentCook:GetSizeY())
    ui._Bg:SetSize(ui._Bg:GetSizeX() - (selectButtonSizeX + deleteButtonSizeX + gap), ui._Bg:GetSizeY())
    ui._titleBg:SetSize(ui._titleBg:GetSizeX() - (selectButtonSizeX + deleteButtonSizeX + gap), ui._titleBg:GetSizeY())
    self._ui._keyGuideBg:SetSize(Panel_RecentCook:GetSizeX(), self._ui._keyGuideBg:GetSizeY())
    self._ui._keyGuideBg:ComputePos()
    PaGlobal_RecentCook:alignKeyGuide()
  end
  self:clearAlchemyRecord()
end
function PaGlobal_RecentCook:showPanel(knowledgeIndex, isCook, posX, posY)
  self:clearAlchemyRecord()
  ToClient_AlchemyRequestRecord(knowledgeIndex)
  self._isCook = isCook
  Panel_RecentCook:SetShow(true)
  Panel_RecentCook:SetPosXY(posX, posY)
  if isCook then
    self._ui._title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_RECENTCOOKTITLE"))
  else
    self._ui._title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_RECENTALCHEMYTITLE"))
  end
  PaGlobal_RecentCook:alignKeyGuide()
  if _ContentsGroup_LifeSimulator and PaGloabl_Alchemy_RateViewList_IsShow ~= nil and PaGloabl_Alchemy_RateViewList_IsShow() == true then
    PaGloabl_Alchemy_RateViewList_Close(false)
  end
end
function PaGlobal_RecentCook:alignKeyGuide()
  local tempkeyGuide = {
    self._ui._keyGuideY,
    self._ui._keyGuideA,
    self._ui._keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempkeyGuide, self._ui._keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_RecentCook:closePanel()
  Panel_RecentCook:SetShow(false)
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_RecentCook:clearAlchemyRecord()
  for recordIndex = 1, self._maxRecordCount do
    local materials = self._ui._recordList[recordIndex]._staticMaterialIcon
    for mtlIndex = 1, self._maxMaterialCount do
      materials[mtlIndex]:clearItem()
      materials[mtlIndex].icon:SetIgnore(true)
    end
    self._ui._recordList[recordIndex]._staticBackground:SetAlpha(0)
    self._ui._recordList[recordIndex]._staticTextRecordNumber:SetShow(false)
    if _ContentsGroup_UsePadSnapping == false then
      self._ui._recordList[recordIndex]._buttonSetup:SetIgnore(true)
      self._ui._recordList[recordIndex]._buttonSetup:SetShow(true)
      self._ui._recordList[recordIndex]._buttonSetup:SetMonoTone(true)
      self._ui._recordList[recordIndex]._buttonDeleteRecent:SetShow(false)
      self._ui._recordList[recordIndex]._buttonSetup:SetText("<PAColor0xFF686869>" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_GUILDHOUSE_CHANGEWORKER_SELECTBTN") .. "<PAOldColor>")
    else
      self._ui._keyGuideY:SetShow(false)
      self._ui._recordList[recordIndex]._staticTextRecordNumber:registerPadEvent(__eConsoleUIPadEvent_Y, "")
      self._ui._recordList[recordIndex]._staticTextRecordNumber:registerPadEvent(__eConsoleUIPadEvent_A, "")
    end
  end
  PaGlobal_RecentCook:alignKeyGuide()
end
function PaGlobal_RecentCook:updateAlchemyRecord()
  if true == _ContentsGroup_UsePadSnapping or true == _ContentsGroup_RenewUI then
    if true == PaGlobalFunc_Alchemy_All_IsCook() then
      self._ui._title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_RECENTCOOKTITLE"))
    else
      self._ui._title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_RECENTALCHEMYTITLE"))
    end
    Panel_RecentCook:SetShow(true)
    Panel_RecentCook:SetPosXY(Panel_Window_Alchemy_All:GetPosX() - (Panel_RecentCook:GetSizeX() + 5), Panel_Window_Alchemy_All:GetPosY())
    Panel_RecentCook:ComputePos()
    PaGlobal_RecentCook:alignKeyGuide()
  end
  local recordCount = ToClient_AlchemyGetRecordCount()
  for recordIndex = 1, recordCount do
    local recordWrapper = ToClient_AlchemyGetRecord(recordIndex - 1)
    _PA_ASSERT(nil ~= recordWrapper, "\235\176\152\237\153\152\235\144\156 RecordCount\236\153\128 \236\139\164\236\160\156 RecordCount\236\157\152 \234\176\156\236\136\152\234\176\128 \236\157\188\236\185\152\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.")
    local materialCount = recordWrapper:getMaterialCount()
    local uiRecord = self._ui._recordList[recordIndex]
    for i = 1, materialCount do
      local itemStaticWrapper = recordWrapper:getItemStaticStatusWrapper(i - 1)
      local itemCount = recordWrapper:getItemCount(i - 1)
      uiRecord._staticMaterialIcon[i]:setItemByStaticStatus(itemStaticWrapper, itemCount)
      uiRecord._staticMaterialIcon[i].icon:SetIgnore(false)
    end
    uiRecord._staticBackground:SetAlpha(1)
    uiRecord._staticTextRecordNumber:SetShow(true)
    if _ContentsGroup_UsePadSnapping == false then
      uiRecord._buttonSetup:SetIgnore(false)
      uiRecord._buttonSetup:SetShow(true)
      uiRecord._buttonSetup:SetMonoTone(false)
      self._ui._recordList[recordIndex]._buttonDeleteRecent:SetShow(_ContentsGroup_DeleteRecentAlchemyCookList)
      self._ui._recordList[recordIndex]._buttonSetup:SetText("<PAColor0xFFEDEDEE>" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_GUILDHOUSE_CHANGEWORKER_SELECTBTN") .. "<PAOldColor>")
    else
      self._ui._keyGuideY:SetShow(_ContentsGroup_DeleteRecentAlchemyCookList)
      if _ContentsGroup_DeleteRecentAlchemyCookList == true then
        self._ui._recordList[recordIndex]._staticTextRecordNumber:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobal_RecentCook:deleteAlchemyRecord(" .. recordIndex .. ")")
      end
      self._ui._recordList[recordIndex]._staticTextRecordNumber:registerPadEvent(__eConsoleUIPadEvent_A, "PaGlobal_RecentCook:selectAlchemyRecord(" .. recordIndex .. ")")
    end
  end
  PaGlobal_RecentCook:alignKeyGuide()
end
function PaGlobal_RecentCook:selectAlchemyRecord(recordIndex)
  if recordIndex < 1 or recordIndex > self._maxRecordCount then
    _PA_ASSERT("\236\157\180\236\158\172\236\164\128", "Record index\234\176\128 \236\160\149\236\131\129 \235\178\148\236\156\132\235\165\188 \235\132\152\236\150\180\234\176\148\236\138\181\235\139\136\235\139\164(" .. recordIndex .. ")")
    return
  end
  local result = ToClient_AlchemyTryUseRecord(recordIndex - 1)
  if UseRecordFailReasons.NoError == result then
    PaGlobal_Alchemy_All_UpdateMaterialSlot()
  elseif UseRecordFailReasons.NoMaterial == result then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_NO_MATERIAL"))
  elseif UseRecordFailReasons.NoMaterialCount == result then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_NO_MATERIAL_COUNT"))
  elseif UseRecordFailReasons.InvalidRecord == result then
    _PA_ASSERT(false, "\236\156\132\236\151\144\236\132\156 record index\235\165\188 \236\178\180\237\129\172\237\150\136\234\184\176 \235\149\140\235\172\184\236\151\144 \236\157\180 \236\161\176\234\177\180\236\157\180 \235\176\156\236\131\157\237\149\160 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164.")
  else
    _PA_ASSERT(false, "\236\138\164\237\129\172\235\166\189\237\138\184\236\151\144 \235\176\152\236\152\129\235\144\152\236\167\128 \236\149\138\236\157\128 \236\131\136\235\161\156\236\154\180 FailReason\236\157\180 \236\182\148\234\176\128\235\144\156 \234\178\131 \234\176\153\236\138\181\235\139\136\235\139\164.")
  end
  if _ContentsGroup_LifeSimulator == true and PaGlobalFunc_Alchemy_All_IsCook ~= nil then
    if PaGlobalFunc_Alchemy_All_IsCook() == true then
      PaGloabl_Alchemy_RateViewList_CalculateCook()
    else
      PaGloabl_Alchemy_RateViewList_CalculateAlchemy()
    end
  end
end
function PaGlobal_RecentCook:deleteAlchemyRecord(recordIndex)
  if recordIndex < 1 or recordIndex > self._maxRecordCount then
    return
  end
  if _ContentsGroup_DeleteRecentAlchemyCookList == false then
    return
  end
  local function doDelete()
    ToClient_AlchemyRequestDeleteRecord(recordIndex - 1)
  end
  messageboxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_DELETE_BUTTON"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RECENT_COOK_REMOVE_MSG", "colum", recordIndex) .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_RECENT_COOK_REMOVE_MSG2"),
    functionYes = doDelete,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if _ContentsGroup_UsePadSnapping == false then
    MessageBox.showMessageBox(messageboxData, nil, nil, false)
  else
    MessageBox.showMessageBox(messageboxData)
  end
end
function PaGlobal_RecentCook:handleMouseOn_MaterialIcon(recordIndex, materialIndex)
  local recordWrapper = ToClient_AlchemyGetRecord(recordIndex - 1)
  if nil == recordWrapper then
    return
  end
  local itemStaticWrapper = recordWrapper:getItemStaticStatusWrapper(materialIndex - 1)
  if nil == itemStaticWrapper then
    return
  end
  local icon = self._ui._recordList[recordIndex]._staticMaterialIcon[materialIndex].icon
  Panel_Tooltip_Item_Show(itemStaticWrapper, icon, true, false, nil)
end
function PaGlobal_RecentCook:handleMouseOut_MaterialIcon()
  Panel_Tooltip_Item_hideTooltip()
end
function FromClient_UpdateAlchemyRecord_RecentCook(itemKey)
  PaGlobal_RecentCook:clearAlchemyRecord()
  PaGlobal_RecentCook:updateAlchemyRecord()
end
function FromClient_luaLoadComplete_PaGlobal_RecentCook()
  PaGlobal_RecentCook:initialize()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_PaGlobal_RecentCook")
registerEvent("FromClient_UpdateAlchemyRecord", "FromClient_UpdateAlchemyRecord_RecentCook")
