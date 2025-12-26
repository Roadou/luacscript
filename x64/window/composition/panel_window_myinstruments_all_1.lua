function PaGlobal_MyInstruments_All:initialize()
  if true == PaGlobal_MyInstruments_All._initialize then
    return
  end
  local stc_TitleBG = UI.getChildControl(Panel_Window_MyInstruments_All, "Static_TitleBG")
  self._ui._btn_Close_PC = UI.getChildControl(stc_TitleBG, "Button_Win_Close_PC")
  local stc_MainBG = UI.getChildControl(Panel_Window_MyInstruments_All, "Static_MainBg")
  self._ui._btn_WayPoint_Shop = UI.getChildControl(stc_MainBG, "Button_WayPoint_Shop")
  local stc_BottomGroup = UI.getChildControl(Panel_Window_MyInstruments_All, "Static_BottomGroup")
  self._ui._btn_Confirm = UI.getChildControl(stc_BottomGroup, "Button_Confirm")
  local stc_MainBg = UI.getChildControl(Panel_Window_MyInstruments_All, "Static_MainBg")
  self._ui._txt_subTitle_template = UI.getChildControl(stc_MainBG, "StaticText_SubTitle_Template")
  self._ui._txt_instruments_template = UI.getChildControl(stc_MainBG, "Static_Instruments_Template")
  PaGlobal_MyInstruments_All:registEventHandler()
  PaGlobal_MyInstruments_All:validate()
  PaGlobal_MyInstruments_All:controlSetting()
  PaGlobal_MyInstruments_All._initialize = true
end
function PaGlobal_MyInstruments_All:controlSetting()
  local stc_MainBg = UI.getChildControl(Panel_Window_MyInstruments_All, "Static_MainBg")
  local posIndex = 0
  if true == _ContentsGroup_AdvancedMusic then
    for typeIndex = __eInstrumentAdvancedType_Novice, __eInstrumentAdvancedType_Count - 1 do
      local temp1 = UI.cloneControl(self._ui._txt_subTitle_template, stc_MainBg, "StaticText_SubTitle_" .. tostring(typeIndex))
      temp1:SetText(PAGetString(Defines.StringSheet_GAME, self._AdvancedTextTable[typeIndex + 1]))
      temp1:SetPosY(self._ui._txt_subTitle_template:GetPosY() + 90 * posIndex)
      local basePosX = 15
      local index = 0
      for _, table in pairs(self._instrumentsString[typeIndex]) do
        local isSkip = false
        if 20 < table.midiIndex and table.midiIndex <= 23 or table.midiIndex > 24 and table.midiIndex <= 27 or table.midiIndex > 28 and table.midiIndex <= 31 or table.midiIndex > 32 and table.midiIndex <= 35 then
          isSkip = true
        end
        local temp2 = UI.cloneControl(self._ui._txt_instruments_template, stc_MainBg, "Static_Instrument_" .. tostring(table.midiIndex))
        self._instrumentsIcon[table.midiIndex] = temp2
        self._instrumentsIcon[table.midiIndex]:addInputEvent("Mouse_On", "HandleEventOnOut_MyInstruments_Show(" .. table._itemKey .. ")")
        self._instrumentsIcon[table.midiIndex]:addInputEvent("Mouse_Out", "HandleEventOnOut_MyInstruments_Show()")
        if false == isSkip then
          self:setContent(temp2, table.midiIndex)
          temp2:SetPosX(basePosX + (temp2:GetSizeX() + 10) * index)
          temp2:SetPosY(temp1:GetPosY() + 25)
          temp2:SetMonoTone(true)
          temp2:SetIgnore(false)
          index = index + 1
        end
      end
      posIndex = posIndex + 1
    end
  else
    local typeIndex = __eInstrumentAdvancedType_Novice
    local temp1 = UI.cloneControl(self._ui._txt_subTitle_template, stc_MainBg, "StaticText_SubTitle_" .. tostring(typeIndex))
    local basePosX = 15
    local index = 0
    for _, table in pairs(self._instrumentsString[typeIndex]) do
      local temp2 = UI.cloneControl(self._ui._txt_instruments_template, stc_MainBg, "Static_Instrument_" .. tostring(table))
      self:setContent(temp2, table.midiIndex)
      temp2:SetPosX(basePosX + (temp2:GetSizeX() + 10) * index)
      temp2:SetPosY(temp1:GetPosY() + 25)
      temp2:SetMonoTone(true)
      self._instrumentsIcon[table.midiIndex] = temp2
      self._instrumentsIcon[table.midiIndex]:addInputEvent("Mouse_On", "HandleEventOnOut_MyInstruments_Show(" .. table._itemKey .. ")")
      self._instrumentsIcon[table.midiIndex]:addInputEvent("Mouse_Out", "HandleEventOnOut_MyInstruments_Show()")
      index = index + 1
    end
  end
  self._ui._txt_subTitle_template:SetShow(false)
  self._ui._txt_instruments_template:SetShow(false)
end
function PaGlobal_MyInstruments_All:createFrameControl()
  if true == _ContentsGroup_AdvancedMusic then
    for index = __eInstrumentAdvancedType_Novice, __eInstrumentAdvancedType_Count - 1 do
      self:makeForType(index)
    end
  else
    self:makeForType(__eInstrumentAdvancedType_Novice)
  end
end
function PaGlobal_MyInstruments_All:registEventHandler()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "PaGlobal_MyInstruments_All_Close()")
  self._ui._btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobal_MyInstruments_All_Close()")
  self._ui._btn_WayPoint_Shop:addInputEvent("Mouse_LUp", "HandleClicked_TownNpcIcon_NaviStart(40)")
end
function PaGlobal_MyInstruments_All:prepareOpen()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  PaGlobal_MyInstruments_All:createFrameControl()
  PaGlobal_MyInstruments_All:open()
end
function PaGlobal_MyInstruments_All:open()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  Panel_Window_MyInstruments_All:SetShow(true)
end
function PaGlobal_MyInstruments_All:prepareClose()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_MyInstruments_All:close()
end
function PaGlobal_MyInstruments_All:close()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  Panel_Window_MyInstruments_All:SetShow(false)
end
function PaGlobal_MyInstruments_All:validate()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  self._ui._btn_Close_PC:isValidate()
  self._ui._btn_WayPoint_Shop:isValidate()
  self._ui._btn_Confirm:isValidate()
end
function PaGlobal_MyInstruments_All:makeForType(advancedType)
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  local instrumentCount = Toclient_MidiInstrumentTrackCount()
  local insertInstrumentTable = {}
  local checkIndex = 1
  for index = 0, instrumentCount - 1 do
    local midiType = Toclient_getInstrumentByIndex(index)
    if -1 ~= midiType then
      local isOpen = ToClient_getInstrumentIsOpenedByIndex(midiType)
      local advancedTypeClient = ToClient_getAdvancedTypeByIndex(midiType)
      if advancedTypeClient == advancedType and true == isOpen then
        for typeIndex = __eInstrumentAdvancedType_Novice, __eInstrumentAdvancedType_Count - 1 do
          for _, table in pairs(self._instrumentsString[typeIndex]) do
            if table.midiIndex == midiType and nil ~= self._instrumentsIcon[table.midiIndex] then
              self._instrumentsIcon[table.midiIndex]:SetMonoTone(false)
              self._instrumentsIcon[table.midiIndex]:SetColor(4294827616)
              insertInstrumentTable[table.midiIndex] = true
              break
            end
          end
        end
      end
    end
  end
  return insertInstrumentTable
end
function PaGlobal_MyInstruments_All:setContent(control, index)
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  control:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Concert_00.dds")
  local normalUV
  if 0 == index then
    normalUV = {
      x1 = 187,
      y1 = 149,
      x2 = 217,
      y2 = 179
    }
  elseif 1 == index then
    normalUV = {
      x1 = 1,
      y1 = 149,
      x2 = 31,
      y2 = 179
    }
  elseif 2 == index then
    normalUV = {
      x1 = 404,
      y1 = 149,
      x2 = 434,
      y2 = 179
    }
  elseif 3 == index then
    normalUV = {
      x1 = 156,
      y1 = 149,
      x2 = 186,
      y2 = 179
    }
  elseif 4 == index then
    normalUV = {
      x1 = 94,
      y1 = 149,
      x2 = 124,
      y2 = 179
    }
  elseif 5 == index then
    normalUV = {
      x1 = 63,
      y1 = 149,
      x2 = 93,
      y2 = 179
    }
  elseif 6 == index then
    normalUV = {
      x1 = 125,
      y1 = 149,
      x2 = 155,
      y2 = 179
    }
  elseif 7 == index then
    normalUV = {
      x1 = 342,
      y1 = 149,
      x2 = 372,
      y2 = 179
    }
  elseif 8 == index then
    normalUV = {
      x1 = 311,
      y1 = 149,
      x2 = 341,
      y2 = 179
    }
  elseif 9 == index then
    normalUV = {
      x1 = 373,
      y1 = 149,
      x2 = 403,
      y2 = 179
    }
  elseif 10 == index then
    normalUV = {
      x1 = 187,
      y1 = 149,
      x2 = 217,
      y2 = 179
    }
  elseif 11 == index then
    normalUV = {
      x1 = 1,
      y1 = 149,
      x2 = 31,
      y2 = 179
    }
  elseif 12 == index then
    normalUV = {
      x1 = 404,
      y1 = 149,
      x2 = 434,
      y2 = 179
    }
  elseif 13 == index then
    normalUV = {
      x1 = 311,
      y1 = 242,
      x2 = 341,
      y2 = 272
    }
  elseif 16 == index then
    normalUV = {
      x1 = 125,
      y1 = 149,
      x2 = 155,
      y2 = 179
    }
  elseif 17 == index then
    normalUV = {
      x1 = 342,
      y1 = 149,
      x2 = 372,
      y2 = 179
    }
  elseif 18 == index then
    normalUV = {
      x1 = 311,
      y1 = 149,
      x2 = 341,
      y2 = 179
    }
  elseif 19 == index then
    normalUV = {
      x1 = 373,
      y1 = 149,
      x2 = 403,
      y2 = 179
    }
  end
  if nil == normalUV then
    if 10 == index or 0 == index then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_Guitar_Click", 0)
    elseif 11 == index or 1 == index then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_Flute_Click", 0)
    elseif 2 == index then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LRecorder_Click", 0)
    elseif 4 == index then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LDjembe_Click", 0)
    elseif 5 == index then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LCymbals_Click", 0)
    elseif 13 == index then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LDurmSet_Click", 0)
    elseif 14 == index then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnibass_Click", 0)
    elseif 15 == index then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LDoublebass_Click", 0)
    elseif 16 == index or 6 == index then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LHarp_Click", 0)
    elseif 17 == index or 7 == index then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LPiano_Cick", 0)
    elseif 18 == index or 8 == index then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LVioiln_Click", 0)
    elseif 19 == index then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LPandurm_Cick", 0)
    elseif index >= 20 and index <= 23 then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnion_A_Click", 0)
    elseif index >= 24 and index <= 27 then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnion_B_Click", 0)
    elseif index >= 28 and index <= 31 then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnion_C_Click", 0)
    elseif index >= 32 and index <= 35 then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_LMarnion_D_Click", 0)
    elseif 36 == index then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_ElectricGuitar_Silverwaves_Cick", 0)
    elseif 37 == index then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_ElectricGuitar_Highway_Cick", 0)
    elseif 38 == index then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_ElectricGuitar_Hexeglam_Cick", 0)
    elseif 39 == index then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_Clarinet_Cick", 0)
    elseif 40 == index then
      control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Concert_Horn_Cick", 0)
    end
    control:setRenderTexture(control:getBaseTexture())
    return
  end
  local x1, y1, x2, y2 = setTextureUV_Func(control, normalUV.x1, normalUV.y1, normalUV.x2, normalUV.y2)
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
