function PaGlobal_GuildPointMenu_All_Open()
  if Panel_Window_GuildPointMenu_All == nil then
    return
  end
  PaGlobal_GuildPointMenu_All:prepareOpen()
end
function PaGlobal_GuildPointMenu_All_Close()
  if Panel_Window_GuildPointMenu_All == nil then
    return
  end
  PaGlobal_GuildPointMenu_All:prepareClose()
end
