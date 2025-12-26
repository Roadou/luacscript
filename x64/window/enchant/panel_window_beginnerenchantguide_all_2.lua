local self = PaGlobal_BeginnerEnchantGuide_All
function PaGlobalFunc_BeginnerEnchantGuide_Open()
  if self == nil then
    return
  end
  self:prepareOpen()
  ToClient_padSnapSetTargetPanel(Panel_Window_BeginnerEnchantGuide_All)
end
function PaGlobalFunc_BeginnerEnchantGuide_Close()
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_BeginnerEnchantGuide_IsShow()
  if Panel_Window_BeginnerEnchantGuide_All == nil then
    return false
  end
  return Panel_Window_BeginnerEnchantGuide_All:GetShow()
end
function HandleEventLUp_PaGlobal_BeginnerEnchantGuide_All_ChangePage(dir)
  if Panel_Window_BeginnerEnchantGuide_All == nil then
    return
  end
  if self == nil then
    return
  end
  local prevPageNum = self._curPageNum
  if dir == 0 then
    if self._curPageNum > self._PAGE_BOUND._MIN then
      self._curPageNum = self._curPageNum - 1
    else
      self._curPageNum = self._PAGE_BOUND._MAX
    end
  elseif dir == 1 then
    if self._curPageNum < self._PAGE_BOUND._MAX then
      self._curPageNum = self._curPageNum + 1
    else
      self._curPageNum = self._PAGE_BOUND._MIN
    end
  else
    return
  end
  PaGlobal_BeginnerEnchantGuide_All_DrawPage(self._curPageNum)
  PaGlobal_BeginnerEnchantGuide_All_ErasePage(prevPageNum)
end
function PaGlobal_BeginnerEnchantGuide_All_DrawPage(num)
  if self == nil then
    return
  end
  if num == 1 then
    self._ui._stc_Image_1:SetShow(true)
    self._ui._stc_Dot_1:SetShow(true)
  elseif num == 2 then
    self._ui._stc_Image_2:SetShow(true)
    self._ui._stc_Dot_2:SetShow(true)
  elseif num == 3 then
    self._ui._stc_Image_3:SetShow(true)
    self._ui._stc_Dot_3:SetShow(true)
  elseif num == 4 then
    self._ui._stc_Image_4:SetShow(true)
    self._ui._stc_Dot_4:SetShow(true)
  elseif num == 5 then
    self._ui._stc_Image_5:SetShow(true)
    self._ui._stc_Dot_5:SetShow(true)
  elseif num == 6 then
    self._ui._stc_Image_6:SetShow(true)
    self._ui._stc_Dot_6:SetShow(true)
  else
    return
  end
  self._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_BEGINNERENCHANTGUIDE_TITLE_" .. tostring(num)))
  self._ui._multxt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_BEGINNERENCHANTGUIDE_DESC_" .. tostring(num)))
end
function PaGlobal_BeginnerEnchantGuide_All_ErasePage(num)
  if self == nil then
    return
  end
  if num == 1 then
    self._ui._stc_Image_1:SetShow(false)
    self._ui._stc_Dot_1:SetShow(false)
  elseif num == 2 then
    self._ui._stc_Image_2:SetShow(false)
    self._ui._stc_Dot_2:SetShow(false)
  elseif num == 3 then
    self._ui._stc_Image_3:SetShow(false)
    self._ui._stc_Dot_3:SetShow(false)
  elseif num == 4 then
    self._ui._stc_Image_4:SetShow(false)
    self._ui._stc_Dot_4:SetShow(false)
  elseif num == 5 then
    self._ui._stc_Image_5:SetShow(false)
    self._ui._stc_Dot_5:SetShow(false)
  elseif num == 6 then
    self._ui._stc_Image_6:SetShow(false)
    self._ui._stc_Dot_6:SetShow(false)
  else
    return
  end
end
registerEvent("FromClient_AppleDataUpdate", "FromClient_BeginnerEnchantGuide_All_updateAppleList")
