registerEvent("executeLuaFunc", "executeLuaFunc")
function executeLuaFunc(funcText)
  if getSelfPlayer() == nil then
    return
  end
  if funcText == "AbyssOneFirstclear" and PaGlobalFunc_AbyssOne_FirstClearMessage_Open ~= nil then
    PaGlobalFunc_AbyssOne_FirstClearMessage_Open()
  end
end
