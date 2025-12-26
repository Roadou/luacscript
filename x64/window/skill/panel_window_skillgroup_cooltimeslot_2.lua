function PaGlobalFunc_SkillGroup_CoolTimeSlot_Close()
  if nil == Panel_SkillGroup_CoolTimeSlot or false == Panel_SkillGroup_CoolTimeSlot:GetShow() then
    return
  end
  PaGlobal_SkillGroup_CoolTimeSlot:close()
end
function PaGlobal_SkillGroup_CoolTimeSlot_Toggle()
  if false == Panel_SkillGroup_CoolTimeSlot:GetShow() then
    PaGlobal_SkillGroup_CoolTimeSlot:open()
  else
    PaGlobal_SkillGroup_CoolTimeSlot:close()
  end
end
function FromClient_SkillGroupCoolTimeSlotUpdate()
  PaGlobal_SkillGroup_CoolTimeSlot:skillUpdate()
end
function PaGlobal_SkillGroup_CoolTimeSlot_GetMemo(skillNo)
  if _ContentsGroup_SkillCoolTimeMemo == false then
    return ""
  end
  local memo = ToClient_getSkillCoolTimeSlotMemo(skillNo)
  if memo == "" then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MEMOMAIN_NOMEMOALERT")
  end
  return memo
end
function PaGlobal_SkillGroup_CoolTimeSlot_ClickMemo(index)
  if _ContentsGroup_SkillCoolTimeMemo == false then
    return
  end
  PaGlobal_SkillGroup_CoolTimeSlot_SaveMemo()
  for idx = 1, PaGlobal_SkillGroup_CoolTimeSlot._skillCoolTimeSlotList_MaxCount do
    local memoControl = PaGlobal_SkillGroup_CoolTimeSlot._uiData[idx]._memo
    local skillNo = PaGlobal_SkillGroup_CoolTimeSlot._uiData[idx]._skillNo
    if memoControl ~= nil and skillNo ~= nil then
      local editMemoControl = UI.getChildControl(memoControl, "Editable_Memo")
      if editMemoControl ~= nil then
        if index == idx then
          if ToClient_isExistSkillCoolTimeMemo(skillNo) == false then
            editMemoControl:SetEditText("")
          end
        elseif ToClient_isExistSkillCoolTimeMemo(skillNo) == false then
          local slotNo = PaGlobal_SkillGroup_CoolTimeSlot._uiData[idx]._ComboBox:GetSelectIndex() - 1
          editMemoControl:SetEditText(PaGlobal_SkillGroup_CoolTimeSlot_GetMemo(slotNo))
        end
      end
    end
  end
end
function PaGlobal_SkillGroup_CoolTimeSlot_SaveMemo()
  if _ContentsGroup_SkillCoolTimeMemo == false then
    return
  end
  for idx = 1, PaGlobal_SkillGroup_CoolTimeSlot._skillCoolTimeSlotList_MaxCount do
    local skillNo = PaGlobal_SkillGroup_CoolTimeSlot._uiData[idx]._skillNo
    local memoControl = PaGlobal_SkillGroup_CoolTimeSlot._uiData[idx]._memo
    if memoControl ~= nil and skillNo ~= nil then
      local editMemoControl = UI.getChildControl(memoControl, "Editable_Memo")
      if editMemoControl ~= nil then
        local memo = editMemoControl:GetEditText()
        if memo == "" then
          ToClient_clearSkillCoolTimeMemo(skillNo)
          local slotNo = PaGlobal_SkillGroup_CoolTimeSlot:getSlotNoByComboBoxString(PaGlobal_SkillGroup_CoolTimeSlot._uiData[idx]._ComboBox:GetText()) - 1
          if slotNo >= 0 then
            local slot = PaGlobal_SkillCoolTimeQuickSlot._panelPool[slotNo]
            if slot ~= nil then
              slot.memo:SetText(memo)
            end
          end
        elseif memo ~= PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MEMOMAIN_NOMEMOALERT") then
          ToClient_setSkillCoolTimeSlotMemo(skillNo, memo)
          local slotNo = PaGlobal_SkillGroup_CoolTimeSlot:getSlotNoByComboBoxString(PaGlobal_SkillGroup_CoolTimeSlot._uiData[idx]._ComboBox:GetText()) - 1
          if slotNo >= 0 then
            local slot = PaGlobal_SkillCoolTimeQuickSlot._panelPool[slotNo]
            if slot ~= nil then
              slot.memo:SetText(memo)
            end
          end
        end
      end
    end
  end
end
