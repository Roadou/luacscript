function PaGlobalFunc_GuildWarColorList_All_Open()
  PaGlobal_GuildWarColorList_All:prepareOpen()
end
function PaGlobalFunc_GuildWarColorList_All_Close()
  PaGlobal_GuildWarColorList_All:prepareClose()
end
function HandleEventLUp_GuildWarColorList_All_Confirm()
  PaGlobal_GuildWarColorList_All:confirmGuildColor()
end
function HandleEventLUp_GuildWarColorList_All_SetAllGuildColor()
  PaGlobal_GuildWarColorList_All:setAllGuildColor()
end
function HandleEventLUp_GuildWarColorList_All_SelectColor(index)
  PaGlobal_GuildWarColorList_All:setSelectedIndex(index)
end
function HandleEventLUp_GuildWarColorList_All_Reset()
  if Panel_GuildWar_Color == nil then
    return
  end
  if PaGlobalFunc_GuildWarColor_All_ResetSelectGuildColor ~= nil then
    PaGlobalFunc_GuildWarColor_All_ResetSelectGuildColor()
  end
  for index = 0, PaGlobal_GuildWarColorList_All._colorMaxIndex do
    local btn_Color = PaGlobal_GuildWarColorList_All._ui._btn_color_list[index]
    if btn_Color ~= nil and btn_Color.radioBtn ~= nil then
      btn_Color.radioBtn:SetCheck(false)
    end
  end
  if PaGlobal_GuildWarColorList_All ~= nil then
    PaGlobal_GuildWarColorList_All._selectedColor = PaGlobal_GuildWarColorList_All._baseColor
  end
end
function FromClient_GuildWarColorList_All_Resize()
  PaGlobal_GuildWarColorList_All:resize()
end
