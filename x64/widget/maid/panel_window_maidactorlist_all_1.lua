function PaGlobal_MaidActorList:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_blackBg = UI.getChildControl(Panel_Window_MaidActorList_All, "Static_BlackBG")
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_MaidActorList_All, "Static_TitleBG")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Close")
  self._ui.btn_close:SetShow(self._isConsole == false)
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_MaidActorList_All, "Static_MainBG")
  self._ui.frm_main = UI.getChildControl(self._ui.stc_mainBg, "Frame_CharacterAllList")
  self._ui.fct_main = UI.getChildControl(self._ui.frm_main, "Frame_1_Content")
  self._ui.rdo_slotTemplate = UI.getChildControl(self._ui.fct_main, "RadioButton_SlotTemplate")
  self._ui.rdo_slotTemplate:SetShow(false)
  self._ui.stc_applyMaid = UI.getChildControl(self._ui.fct_main, "Static_ApplyMaid")
  self._ui.stc_click = UI.getChildControl(self._ui.fct_main, "Static_Click")
  self._ui.btn_create = UI.getChildControl(Panel_Window_MaidActorList_All, "Button_Create")
  self._ui.btn_unregist = UI.getChildControl(Panel_Window_MaidActorList_All, "Button_Unregist")
  self._ui.btn_apply = UI.getChildControl(Panel_Window_MaidActorList_All, "Button_Apply")
  self._ui.btn_changeName = UI.getChildControl(Panel_Window_MaidActorList_All, "Button_ChangeName")
  self._ui.stc_changeNameIcon = UI.getChildControl(Panel_Window_MaidActorList_All, "Static_Icon_ChangeName")
  self._ui.stc_keyGuideBg = UI.getChildControl(Panel_Window_MaidActorList_All, "Static_KeyGuide_ConsoleUI_Import")
  self._ui.stc_keyGuideA = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_A_ConsoleUI")
  self._ui.stc_keyGuideB = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_B_ConsoleUI")
  self._ui.stc_keyGuideY = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_Y_ConsoleUI")
  self._ui.stc_keyGuideLS = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_LS_ConsoleUI")
  self._ui.stc_keyGuideRS = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_RS_ConsoleUI")
  self._ui.stc_keyGuideBg:SetShow(self._isConsole == true)
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_MaidActorList:registEventHandler()
  if Panel_Window_MaidActorList_All == nil then
    return
  end
  if self._isConsole == true then
    Panel_Window_MaidActorList_All:ignorePadSnapMoveToOtherPanel()
  else
    self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_MaidActorList_Close()")
    self._ui.btn_create:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidActorList_RegistMaidActor()")
    self._ui.btn_unregist:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidActorList_UnregistMaidActor()")
    self._ui.btn_apply:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidActorList_ChangeHeadMaidActor()")
    self._ui.btn_changeName:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidActorList_ChangeName()")
  end
  registerEvent("FromClient_MaidActorEvent", "FromClient_MaidActorList_MaidActorEvent")
  registerEvent("FromClient_AddMaidActorSlot", "FromClient_MaidActorList_AddSlot")
end
function PaGlobal_MaidActorList:prepareOpen()
  if Panel_Window_MaidActorList_All == nil then
    return
  end
  self:updateSlot()
  self:selectSlot(1)
  self:open()
end
function PaGlobal_MaidActorList:open()
  if Panel_Window_MaidActorList_All == nil then
    return
  end
  self._ui.stc_blackBg:SetSize(getScreenSizeX() + 500, getScreenSizeY() + 500)
  self._ui.stc_blackBg:ComputePos()
  Panel_Window_MaidActorList_All:SetShow(true)
end
function PaGlobal_MaidActorList:prepareClose()
  if Panel_Window_MaidActorList_All == nil then
    return
  end
  self:close()
end
function PaGlobal_MaidActorList:close()
  if Panel_Window_MaidActorList_All == nil then
    return
  end
  Panel_Window_MaidActorList_All:SetShow(false)
end
function PaGlobal_MaidActorList:updateSlot()
  if Panel_Window_MaidActorList_All == nil then
    return
  end
  local slotCountMax = ToClient_GetMaidActorSlotCountMax()
  local activateSlotCount = ToClient_GetMaidActorSlotCount()
  local deactivateSlotCount = slotCountMax - activateSlotCount
  if self._slots == nil then
    self._slots = Array.new()
  end
  for _, slot in pairs(self._slots) do
    if slot ~= nil then
      slot:SetShow(false)
      slot:removeInputEvent("Mouse_LUp")
      slot:removeInputEvent("Mouse_LDClick")
    end
  end
  self._ui.stc_applyMaid:SetShow(false)
  local hasMaidCount = ToClient_GetMaidActorListSize()
  local isCreateSlot = false
  for ii = 1, slotCountMax do
    local slot = self._slots[ii]
    if slot == nil then
      isCreateSlot = true
      slot = UI.cloneControl(self._ui.rdo_slotTemplate, self._ui.fct_main, "RadioButton_MaidActorSlot_" .. tostring(ii))
      self._slots[ii] = slot
    end
    local stc_select = UI.getChildControl(slot, "Static_SelectMaid")
    local btn_buy = UI.getChildControl(slot, "Button_Buy")
    local stc_lock = UI.getChildControl(slot, "Static_Lock")
    local stc_photo = UI.getChildControl(slot, "Static_CharPhoto")
    local txt_name = UI.getChildControl(slot, "StaticText_MaidName")
    slot:SetShow(true)
    if self._isConsole == true then
      slot:addInputEvent("Mouse_On", "HandleEventLOnOut_MaidActorList_OverSlot(true, " .. tostring(ii) .. ")")
      slot:addInputEvent("Mouse_Out", "HandleEventLOnOut_MaidActorList_OverSlot(false, " .. tostring(ii) .. ")")
    else
      slot:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidActorList_ClickSlot(" .. tostring(ii) .. ")")
      slot:addInputEvent("Mouse_LDClick", "HandleEventLUp_MaidActorList_DoubleClickSlot(" .. tostring(ii) .. ")")
    end
    stc_photo:SetShow(false)
    txt_name:SetText("")
    UI.setLimitTextAndAddTooltip(txt_name)
    if activateSlotCount >= ii then
      slot:SetEnable(true)
      slot:SetIgnore(false)
      slot:SetMonoTone(false)
      stc_select:SetShow(false)
      btn_buy:SetShow(false)
      btn_buy:removeInputEvent("Mouse_LUp")
      stc_lock:SetShow(false)
      if ii <= hasMaidCount then
        local maidInfo = ToClient_GetMaidActorSimpleInfo(ii - 1)
        if maidInfo ~= nil then
          txt_name:SetText(maidInfo:getMaidName())
          local maidClassTypeRaw = maidInfo:getClassTypeRaw()
          local photoFileName = ToClient_GetMaidActorFaceTexturePathFromClient(maidInfo:getMaidNo())
          local isExistPhotoFile = stc_photo:ChangeTextureInfoNameNotDDS(photoFileName, maidClassTypeRaw, true)
          if isExistPhotoFile == true then
            stc_photo:getBaseTexture():setUV(0, 0, 1, 1)
            stc_photo:setRenderTexture(stc_photo:getBaseTexture())
            stc_photo:SetShow(true)
          else
            local newClassTexutreIDData = NewClassData.newClass_Texture_ID[maidClassTypeRaw]
            if newClassTexutreIDData == nil then
              maidClassTypeRaw = -1
            end
            local defaultFace = NewClassData.newClass_Texture_ID[maidClassTypeRaw]._defaultFaceTextureTID
            if defaultFace ~= nil then
              stc_photo:ChangeTextureInfoTextureIDAsync(defaultFace, 0)
              stc_photo:setRenderTexture(stc_photo:getBaseTexture())
              stc_photo:SetShow(true)
            end
          end
          if maidInfo:getIsHead() == true then
            local diffX = self._ui.stc_applyMaid:GetSizeX() - slot:GetSizeX()
            local diffY = self._ui.stc_applyMaid:GetSizeY() - slot:GetSizeY()
            self._ui.stc_applyMaid:SetSpanSize(slot:GetSpanSize().x - diffX / 2, slot:GetSpanSize().y - diffY / 2)
            self._ui.stc_applyMaid:ComputePos()
            self._ui.stc_applyMaid:SetShow(true)
          end
        end
      end
    elseif deactivateSlotCount > 0 and ii == activateSlotCount + 1 then
      slot:SetEnable(true)
      slot:SetIgnore(false)
      slot:SetMonoTone(false)
      stc_select:SetShow(false)
      btn_buy:SetShow(true)
      if self._isConsole == true then
        btn_buy:addInputEvent("Mouse_On", "HandleEventLOnOut_MaidActorList_OverSlot(true, " .. tostring(ii) .. ")")
        btn_buy:addInputEvent("Mouse_Out", "HandleEventLOnOut_MaidActorList_OverSlot(false, " .. tostring(ii) .. ")")
      end
      btn_buy:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidActorList_BuySlot(" .. tostring(ii) .. ")")
      stc_lock:SetShow(false)
    else
      slot:SetEnable(false)
      slot:SetIgnore(true)
      slot:SetMonoTone(true)
      stc_select:SetShow(false)
      btn_buy:SetShow(false)
      btn_buy:removeInputEvent("Mouse_LUp")
      stc_lock:SetShow(true)
    end
  end
  if isCreateSlot == true then
    local colCount = 5
    local colIdx = 0
    local rowIdx = 0
    local spanX = 0
    local spanY = 0
    local btnSizeX = self._ui.rdo_slotTemplate:GetSizeX()
    local btnSizeY = self._ui.rdo_slotTemplate:GetSizeY()
    local termX = 5
    local termY = 5
    local frameSizeX = 0
    local frameSizeY = 0
    for key, value in pairs(self._slots) do
      if value ~= nil then
        if colCount <= colIdx then
          colIdx = 0
          rowIdx = rowIdx + 1
        end
        spanX = 10 + (btnSizeX + termX) * colIdx
        spanY = 10 + (btnSizeY + termY) * rowIdx
        value:SetSpanSize(spanX, spanY)
        value:ComputePos()
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
    self._ui.fct_main:SetSize(frameSizeX, frameSizeY)
    self._ui.frm_main:SetSize(frameSizeX, frameSizeY)
    self._ui.stc_mainBg:SetSize(frameSizeX, frameSizeY)
    self._ui.stc_titleBg:SetSize(frameSizeX, self._ui.stc_titleBg:GetSizeY())
    if self._isConsole == true then
      self._ui.stc_keyGuideBg:SetSize(frameSizeX, self._ui.stc_keyGuideBg:GetSizeY())
      Panel_Window_MaidActorList_All:SetSize(frameSizeX, self._ui.stc_titleBg:GetSizeY() + self._ui.stc_mainBg:GetSizeY())
    else
      Panel_Window_MaidActorList_All:SetSize(frameSizeX, self._ui.stc_titleBg:GetSizeY() + self._ui.stc_mainBg:GetSizeY() + self._ui.btn_apply:GetSizeY() + 20)
    end
    Panel_Window_MaidActorList_All:ComputePosAllChild()
    if self._isConsole == false then
      local btnList = Array.new()
      btnList:push_back(self._ui.btn_apply)
      btnList:push_back(self._ui.btn_create)
      btnList:push_back(self._ui.btn_unregist)
      local showBtnCount = #btnList
      local showBtnIndex = 0
      local btnTermX = 5
      local btnSizeX = self._ui.btn_create:GetSizeX()
      local btnAreaSizeX = showBtnCount * btnSizeX + btnTermX * (showBtnCount - 1)
      local spanX = (Panel_Window_MaidActorList_All:GetSizeX() - btnAreaSizeX) / 2
      for _, btn in pairs(btnList) do
        if btn ~= nil then
          btn:SetSpanSize(spanX + showBtnIndex * (btnSizeX + btnTermX), btn:GetSpanSize().y)
          btn:ComputePos()
          showBtnIndex = showBtnIndex + 1
        end
      end
    end
    self._ui.fct_main:SetChildIndex(self._ui.stc_click, 9999)
    self._ui.fct_main:SetChildIndex(self._ui.stc_applyMaid, 9999)
    for _, slot in pairs(self._slots) do
      if slot ~= nil then
        self._ui.fct_main:SetChildIndex(slot, 1)
      end
    end
  end
end
function PaGlobal_MaidActorList:selectSlot(slotIndex)
  if Panel_Window_MaidActorList_All == nil then
    return
  end
  if self._slots == nil then
    return
  end
  local slot = self._slots[slotIndex]
  if slot == nil then
    return
  end
  local diffX = self._ui.stc_click:GetSizeX() - slot:GetSizeX()
  local diffY = self._ui.stc_click:GetSizeY() - slot:GetSizeY()
  self._ui.stc_click:SetSpanSize(slot:GetSpanSize().x - diffX / 2, slot:GetSpanSize().y - diffY / 2)
  self._ui.stc_click:ComputePos()
  self._ui.stc_click:SetShow(true)
  slot:SetCheck(true)
  self._selectSlotIndex = slotIndex
  self:updateBottomButton()
end
function PaGlobal_MaidActorList:updateBottomButton()
  if Panel_Window_MaidActorList_All == nil then
    return
  end
  if self._selectSlotIndex == nil then
    return
  end
  self._ui.btn_create:SetShow(self._isConsole == false)
  self._ui.btn_unregist:SetShow(self._isConsole == false)
  self._ui.btn_apply:SetShow(self._isConsole == false)
  self._ui.btn_changeName:SetShow(self._isConsole == false)
  self._ui.stc_changeNameIcon:SetShow(self._isConsole == false)
  if self._isConsole == true then
    self._ui.stc_keyGuideLS:SetShow(false)
    self._ui.stc_keyGuideRS:SetShow(false)
    self._ui.stc_keyGuideY:SetShow(false)
    self._ui.stc_keyGuideA:SetShow(false)
  else
    self._ui.btn_create:SetEnable(false)
    self._ui.btn_unregist:SetEnable(false)
    self._ui.btn_apply:SetEnable(false)
    self._ui.btn_changeName:SetEnable(false)
    self._ui.stc_changeNameIcon:SetEnable(false)
    self._ui.btn_create:SetMonoTone(true)
    self._ui.btn_unregist:SetMonoTone(true)
    self._ui.btn_apply:SetMonoTone(true)
    self._ui.btn_changeName:SetMonoTone(true)
    self._ui.stc_changeNameIcon:SetMonoTone(true)
  end
  local useButtonArray = Array.new()
  local activateSlotCount = ToClient_GetMaidActorSlotCount()
  if activateSlotCount >= self._selectSlotIndex then
    local maidInfo = ToClient_GetMaidActorSimpleInfo(self._selectSlotIndex - 1)
    if maidInfo == nil then
      if self._isConsole == true then
        self._ui.stc_keyGuideY:SetShow(true)
      else
        useButtonArray:push_back(self._ui.btn_create)
      end
    else
      if self._isConsole == true then
        self._ui.stc_keyGuideLS:SetShow(true)
        self._ui.stc_keyGuideRS:SetShow(true)
      else
        useButtonArray:push_back(self._ui.btn_unregist)
        useButtonArray:push_back(self._ui.btn_changeName)
        useButtonArray:push_back(self._ui.stc_changeNameIcon)
      end
      if maidInfo:getIsHead() == false then
        if self._isConsole == true then
          self._ui.stc_keyGuideA:SetShow(true)
        else
          useButtonArray:push_back(self._ui.btn_apply)
        end
      end
    end
  end
  if self._isConsole == false then
    for _, btn in pairs(useButtonArray) do
      if btn ~= nil then
        btn:SetEnable(true)
        btn:SetMonoTone(false)
      end
    end
  end
  self:updateKeyGuide()
end
function PaGlobal_MaidActorList:updateKeyGuide()
  if Panel_Window_MaidActorList_All == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  if self._ui.stc_keyGuideA:GetShow() == true then
    Panel_Window_MaidActorList_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_MaidActorList_ChangeHeadMaidActor()")
  else
    Panel_Window_MaidActorList_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  end
  if self._ui.stc_keyGuideY:GetShow() == true then
    Panel_Window_MaidActorList_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_MaidActorList_RegistMaidActor()")
  else
    Panel_Window_MaidActorList_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  end
  if self._ui.stc_keyGuideLS:GetShow() == true then
    Panel_Window_MaidActorList_All:registerPadEvent(__eConsoleUIPadEvent_Up_LSClick, "HandleEventLUp_MaidActorList_UnregistMaidActor()")
  else
    Panel_Window_MaidActorList_All:registerPadEvent(__eConsoleUIPadEvent_Up_LSClick, "")
  end
  if self._ui.stc_keyGuideRS:GetShow() == true then
    Panel_Window_MaidActorList_All:registerPadEvent(__eConsoleUIPadEvent_Up_RSClick, "HandleEventLUp_MaidActorList_ChangeName()")
  else
    Panel_Window_MaidActorList_All:registerPadEvent(__eConsoleUIPadEvent_Up_RSClick, "")
  end
  local keyGuideList = Array.new()
  keyGuideList:push_back(self._ui.stc_keyGuideLS)
  keyGuideList:push_back(self._ui.stc_keyGuideRS)
  keyGuideList:push_back(self._ui.stc_keyGuideY)
  keyGuideList:push_back(self._ui.stc_keyGuideA)
  keyGuideList:push_back(self._ui.stc_keyGuideB)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
