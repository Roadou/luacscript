function PaGlobal_MaidActorRegist:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_blackBg = UI.getChildControl(Panel_Window_MaidActorRegist_All, "Static_BlackBG")
  self._ui.stc_title = UI.getChildControl(Panel_Window_MaidActorRegist_All, "Static_Title")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_title, "Button_Close")
  self._ui.btn_close:SetShow(self._isConsole == false)
  self._ui.frm_list = UI.getChildControl(Panel_Window_MaidActorRegist_All, "Frame_MaidSelect")
  self._ui.fct_list = UI.getChildControl(self._ui.frm_list, "Frame_1_Content")
  self._ui.rdo_template = UI.getChildControl(self._ui.fct_list, "RadioButton_Select_Template")
  self._ui.rdo_template:SetShow(false)
  self._ui.stc_registerBG = UI.getChildControl(Panel_Window_MaidActorRegist_All, "Static_MaidRegisterBG")
  self._ui.btn_regist = UI.getChildControl(Panel_Window_MaidActorRegist_All, "Button_MaidCreate")
  self._ui.btn_regist:SetShow(self._isConsole == false)
  self._ui.edt_name = UI.getChildControl(self._ui.stc_registerBG, "Edit_Naming")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_registerBG, "StaticText_Description")
  self._ui.txt_desc:SetText(PAGetStringParam2(Defines.StringSheet_RESOURCE, "PANEL_CUSTOM_MAID_CREATE_DESC", "min", tostring(getGameServiceTypeNameMinLength()), "max", ToClient_GetMaidActorNameLengthMax()))
  self._ui.txt_desc:SetSize(self._ui.txt_desc:GetSizeX(), self._ui.txt_desc:GetTextSizeY())
  self._ui.edt_name:SetSpanSize(0, 10)
  self._ui.edt_name:ComputePos()
  self._ui.txt_desc:SetSpanSize(0, self._ui.edt_name:GetSpanSize().y + self._ui.edt_name:GetSizeY() + 5)
  self._ui.txt_desc:ComputePos()
  self._ui.stc_registerBG:SetSize(self._ui.stc_registerBG:GetSizeX(), self._ui.txt_desc:GetSpanSize().y + self._ui.txt_desc:GetSizeY() + 10)
  self._ui.stc_registerBG:ComputePos()
  self._ui.stc_keyGuideBg = UI.getChildControl(Panel_Window_MaidActorRegist_All, "Static_KeyGuide_ConsoleUI_Import")
  self._ui.stc_keyGuideA = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_A_ConsoleUI")
  self._ui.stc_keyGuideB = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_B_ConsoleUI")
  self._ui.stc_keyGuideX = UI.getChildControl(self._ui.edt_name, "StaticText_KeyGuide_X_ConsoleUI")
  self._ui.stc_keyGuideY = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_Y_ConsoleUI")
  self._ui.stc_keyGuideBg:SetShow(self._isConsole == true)
  self._ui.stc_keyGuideA:SetShow(self._isConsole == true)
  self._ui.stc_keyGuideB:SetShow(self._isConsole == true)
  self._ui.stc_keyGuideX:SetShow(self._isConsole == true)
  self._ui.stc_keyGuideY:SetShow(self._isConsole == true)
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_MaidActorRegist:registEventHandler()
  if Panel_Window_MaidActorRegist_All == nil then
    return
  end
  if self._isConsole == true then
    Panel_Window_MaidActorRegist_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_MaidActorRegist_DoRegist()")
    Panel_Window_MaidActorRegist_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventUpX_MaidActorRegist_InputEditMode()")
    Panel_Window_MaidActorRegist_All:ignorePadSnapMoveToOtherPanel()
  else
    self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_MaidActorRegist_Close()")
    self._ui.btn_regist:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidActorRegist_DoRegist()")
  end
  self._ui.edt_name:SetMaxInput(ToClient_GetMaidActorNameLengthMax())
  self._ui.edt_name:RegistReturnKeyEvent("HandleEventLUp_MaidActorRegist_DoRegist()")
  registerEvent("FromClient_MaidActorEvent", "FromClient_MaidActorRegist_MaidActorEvent")
end
function PaGlobal_MaidActorRegist:prepareOpen(openType)
  if Panel_Window_MaidActorRegist_All == nil then
    return
  end
  self._openType = openType
  if self._openType == self._eOpenType.MAID_LIST then
  elseif self._openType == self._eOpenType.MAID_ACTOR_LIST then
    PaGlobalFunc_MaidActorList_Close()
  end
  self:updateFrame()
  self:selectSlot(1)
  self._ui.edt_name:SetEditText("")
  if self._isConsole == false then
    SetFocusEdit(self._ui.edt_name)
  end
  self._ui.frm_list:GetVScroll():SetControlPos(0)
  self._ui.frm_list:UpdateContentPos()
  self:open()
end
function PaGlobal_MaidActorRegist:open()
  if Panel_Window_MaidActorRegist_All == nil then
    return
  end
  self._ui.stc_blackBg:SetSize(getScreenSizeX() + 500, getScreenSizeY() + 500)
  self._ui.stc_blackBg:ComputePos()
  Panel_Window_MaidActorRegist_All:SetShow(true)
end
function PaGlobal_MaidActorRegist:prepareClose()
  if Panel_Window_MaidActorRegist_All == nil then
    return
  end
  if self._openType == self._eOpenType.MAID_LIST then
  elseif self._openType == self._eOpenType.MAID_ACTOR_LIST then
    PaGlobalFunc_MaidActorList_Open()
  end
  self._openType = nil
  self:close()
end
function PaGlobal_MaidActorRegist:close()
  if Panel_Window_MaidActorRegist_All == nil then
    return
  end
  Panel_Window_MaidActorRegist_All:SetShow(false)
end
function PaGlobal_MaidActorRegist:updateFrame()
  if Panel_Window_MaidActorRegist_All == nil then
    return
  end
  if self._slots == nil then
    self._slots = Array.new()
  end
  for _, slotData in pairs(self._slots) do
    if slotData ~= nil then
      slotData._control:SetShow(false)
      slotData._control:SetCheck(false)
      slotData._control:removeInputEvent("Mouse_LUp")
      slotData._maidCharacterKeyRaw = nil
    end
  end
  local pcClassTypeCount = ToClient_GetPossibleClassListSize()
  local isCreateSlot = false
  for ii = 1, pcClassTypeCount do
    local pcClassTypeRaw = ToClient_GetPossibleClassTypeRaw(ii - 1)
    local maidCharacterKeyRaw = ToClient_GetMaidActorCharacterKeyByPCClassType(pcClassTypeRaw)
    if maidCharacterKeyRaw > 0 then
      local slotData = self._slots[ii]
      if slotData == nil then
        local slotDataTemplate = {_control = nil, _maidCharacterKeyRaw = nil}
        slotDataTemplate._control = UI.cloneControl(self._ui.rdo_template, self._ui.fct_list, "RadioButton_MaidCharacterSlot_" .. tostring(ii))
        slotData = slotDataTemplate
        self._slots[ii] = slotDataTemplate
        isCreateSlot = true
      end
      slotData._control:SetShow(true)
      slotData._control:addInputEvent("Mouse_On", "HandleEventLOnOut_MaidActorRegist_OverSlot(true," .. tostring(ii) .. ")")
      slotData._control:addInputEvent("Mouse_Out", "HandleEventLOnOut_MaidActorRegist_OverSlot(false," .. tostring(ii) .. ")")
      slotData._control:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidActorRegist_ClickSlot(" .. tostring(ii) .. ")")
      slotData._maidCharacterKeyRaw = maidCharacterKeyRaw
      local txt_name = UI.getChildControl(slotData._control, "StaticText_Name_Template")
      local newClassTypeData = NewClassData.newClass_String[pcClassTypeRaw]
      if newClassTypeData == nil then
        pcClassTypeRaw = -1
      end
      PaGlobalFunc_Util_SetCharacterCreateClassIcon(slotData._control, pcClassTypeRaw)
      txt_name:SetText(NewClassData.newClass_String[pcClassTypeRaw]._classType2String)
      if self._selectSlotIndex ~= nil then
        slotData._control:SetCheck(self._selectSlotIndex == ii)
      end
      slotData._control:SetMonoTone(slotData._control:IsCheck() == false)
      slotData._control:SetVertexAniRun("Ani_Color_Reset", true)
      slotData._control:EraseAllEffect()
      if slotData._control:IsCheck() == true then
        slotData._control:AddEffect("UI_CharactorSelcect_Line", true, 10, 4)
      end
    end
  end
  if isCreateSlot == true then
    local colIdx = 0
    local rowIdx = 0
    local spanX = 0
    local spanY = 0
    local btnSizeX = self._ui.rdo_template:GetSizeX()
    local btnSizeY = self._ui.rdo_template:GetSizeY()
    local colCount = math.floor(self._ui.frm_list:GetSizeX() / btnSizeX)
    local termX = 5
    local termY = 5
    local frameSizeX = 0
    local frameSizeY = 0
    for key, slotData in pairs(self._slots) do
      if slotData ~= nil then
        if colIdx >= colCount then
          colIdx = 0
          rowIdx = rowIdx + 1
        end
        spanX = 10 + (btnSizeX + termX) * colIdx
        spanY = 10 + (btnSizeY + termY) * rowIdx
        slotData._control:SetSpanSize(spanX, spanY)
        slotData._control:ComputePos()
        colIdx = colIdx + 1
        local tempX = spanX + btnSizeX + 10
        if frameSizeX < tempX then
          frameSizeX = tempX
        end
        local tempY = spanY + btnSizeY + 10
        if frameSizeY < tempY then
          frameSizeY = tempY
        end
      end
    end
    self._ui.fct_list:SetSize(frameSizeX, frameSizeY)
    local frameVScroll = self._ui.frm_list:GetVScroll()
    frameVScroll:SetControlPos(0)
    self._ui.frm_list:UpdateContentPos()
    if self._ui.frm_list:GetSizeY() < self._ui.fct_list:GetSizeY() then
      frameVScroll:SetShow(true)
    else
      frameVScroll:SetShow(false)
    end
    local panelSizeX = frameSizeX + 10
    self._ui.stc_title:SetSize(panelSizeX, self._ui.stc_title:GetSizeY())
    self._ui.frm_list:SetSize(panelSizeX, self._ui.frm_list:GetSizeY())
    self._ui.stc_registerBG:SetSize(panelSizeX, self._ui.stc_registerBG:GetSizeY())
    local panelSizeY = 0
    if self._isConsole == true then
      panelSizeY = self._ui.stc_title:GetSizeY() + self._ui.frm_list:GetSizeY() + 10 + self._ui.stc_registerBG:GetSizeY() + 10
      self._ui.stc_keyGuideBg:SetSize(panelSizeX, self._ui.stc_keyGuideBg:GetSizeY())
    else
      panelSizeY = self._ui.stc_title:GetSizeY() + self._ui.frm_list:GetSizeY() + 10 + self._ui.stc_registerBG:GetSizeY() + 10 + self._ui.btn_regist:GetSizeY() + 10
    end
    Panel_Window_MaidActorRegist_All:SetSize(panelSizeX, panelSizeY)
    Panel_Window_MaidActorRegist_All:ComputePosAllChild()
    if self._isConsole == true then
      local keyGuideList = Array.new()
      keyGuideList:push_back(self._ui.stc_keyGuideY)
      keyGuideList:push_back(self._ui.stc_keyGuideA)
      keyGuideList:push_back(self._ui.stc_keyGuideB)
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    end
  end
end
function PaGlobal_MaidActorRegist:selectSlot(slotIndex)
  if Panel_Window_MaidActorRegist_All == nil then
    return
  end
  if self._slots == nil then
    return
  end
  for key, slotData in pairs(self._slots) do
    if slotData ~= nil then
      local isSelected = key == slotIndex
      slotData._control:SetCheck(isSelected == true)
      slotData._control:SetMonoTone(isSelected == false)
      slotData._control:SetVertexAniRun("Ani_Color_Reset", true)
      slotData._control:EraseAllEffect()
      if isSelected == true then
        slotData._control:AddEffect("UI_CharactorSelcect_Line", true, 10, 4)
      end
      self._selectSlotIndex = slotIndex
    end
  end
end
function PaGlobal_MaidActorRegist:overSlot(isOn, slotIndex)
  if Panel_Window_MaidActorRegist_All == nil then
    return
  end
  if self._slots == nil then
    return
  end
  for key, slotData in pairs(self._slots) do
    if slotData ~= nil then
      local isOn = key == slotIndex
      if isOn == true then
        slotData._control:SetVertexAniRun("Ani_Color_Bright", true)
      else
        slotData._control:ResetVertexAni()
        slotData._control:SetVertexAniRun("Ani_Color_Reset", true)
      end
    end
  end
end
