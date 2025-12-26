function FromClient_updateDamageLogList()
  PaGlobal_DamageLog:prepareOpen()
end
function PaGlobalFunc_DamageLog_ListUpdate(contents, key)
  local index = Int64toInt32(key)
  local logMgrWrapper = ToClient_getFrameEventDamageInfoWrapper(index)
  if nil == logMgrWrapper then
    UI.ASSERT_NAME(false, "\235\141\176\235\175\184\236\167\128 \235\161\156\234\183\184 \235\167\164\235\139\136\236\160\128 Wrapper\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\235\176\149\234\183\156\235\130\152")
    return
  end
  local attackType = logMgrWrapper:getAttackType()
  local btn_frame = UI.getChildControl(contents, "RadioButton_Frame")
  local stc_title = UI.getChildControl(btn_frame, "StaticText_Frame_No")
  local stc_desc0 = UI.getChildControl(btn_frame, "StaticText_Frame_Sub_0")
  local stc_desc1 = UI.getChildControl(btn_frame, "StaticText_Frame_Sub_1")
  local stc_desc2 = UI.getChildControl(btn_frame, "StaticText_Frame_Sub_2")
  local self = PaGlobal_DamageLog
  local txt_buffName = self:getBuffName(logMgrWrapper)
  local txt_additionalDamageType = self:getAdditionalDamageType(logMgrWrapper)
  local txt_attackResult = self:getAttackResult(logMgrWrapper)
  local txt_damage = tostring(self:getDamage(logMgrWrapper))
  local hitCount = logMgrWrapper:getHitCount()
  local txt_attackRv = ""
  for ii = __eAttackResultSuccess, __eAttackResultCount - 1 do
    local currentCount = logMgrWrapper:getAttackResult(ii)
    if currentCount > 0 then
      if "" ~= txt_attackRv then
        txt_attackRv = txt_attackRv .. ", "
      end
      local calculatedPct = currentCount * 100 / hitCount
      local txt_percent = string.format("%.2f%%", calculatedPct)
      if ii == __eAttackResultSuccess then
        txt_attackRv = txt_attackRv .. "\236\132\177\234\179\181(" .. txt_percent .. ")"
      elseif ii == __eAttackResultCritical then
        txt_attackRv = txt_attackRv .. "\237\129\172\235\166\172\237\139\176\236\187\172(" .. txt_percent .. ")"
      elseif ii == __eAttackResultGuard then
        txt_attackRv = txt_attackRv .. "\234\176\128\235\147\156(" .. txt_percent .. ")"
      elseif ii == __eAttackResultProtection then
        txt_attackRv = txt_attackRv .. "\235\179\180\237\152\184(" .. txt_percent .. ")"
      elseif ii == __eAttackResultKilling then
        txt_attackRv = txt_attackRv .. "\237\130\172(" .. txt_percent .. ")"
      elseif ii == __eAttackResultImmune then
        txt_attackRv = txt_attackRv .. "\236\157\180\235\174\180(" .. txt_percent .. ")"
      elseif ii == __eAttackResultMiss then
        txt_attackRv = txt_attackRv .. "\235\175\184\236\138\164(" .. txt_percent .. ")"
      elseif ii == __eAttackResultMissCritical then
        txt_attackRv = txt_attackRv .. "\235\175\184\236\138\164 \237\129\172\235\166\172\237\139\176\236\187\172(" .. txt_percent .. ")"
      end
    end
  end
  local txt_avgDamage = tostring(logMgrWrapper:getAvgDamage())
  stc_title:SetText(tostring(index + 1) .. ". " .. txt_buffName)
  stc_desc0:SetText(string.format("%s, %s, \235\141\176\235\175\184\236\167\128=%s", txt_additionalDamageType, txt_attackResult, txt_damage))
  stc_desc1:SetText(string.format("%s, \237\143\137\234\183\160\235\141\176\235\175\184\236\167\128=%s(%d\237\154\140)", txt_attackRv, txt_avgDamage, hitCount))
  stc_desc2:SetText(self:getAttackeeInfo(logMgrWrapper))
  btn_frame:addInputEvent("Mouse_LUp", "PaGlobal_DamageLog:showLogs(" .. tostring(index) .. ")")
end
