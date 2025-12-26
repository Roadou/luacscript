PaGlobal_FantasyHorseGuide_Console = {_initialize = false}
registerEvent("FromClient_luaLoadComplete", "FromClient_FantasyHorseGuide_ConsoleInit")
function FromClient_FantasyHorseGuide_ConsoleInit()
  PaGlobal_FantasyHorseGuide_Console:initialize()
end
function PaGlobal_FantasyHorseGuide_Console:initialize()
  local keyGuide = UI.getChildControl(Panel_Window_FantasyHorseGuide_Console, "Static_KeyGuideBG_ConsoleUI")
  local keyGuideA = UI.getChildControl(keyGuide, "StaticText_KeyGuideB")
  PaGlobalFunc_ConsoleKeyGuide_SetAlign({keyGuideA}, keyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._initialize = true
  registerEvent("selfPlayer_regionChangedOnlyUsedSafeZone", "PaGlobalFunc_FantasyHorseGuide_Console_Check")
end
function PaGlobal_FantasyHorseGuide_Console:prepareOpen()
  self:open()
end
function PaGlobal_FantasyHorseGuide_Console:open()
  Panel_Window_FantasyHorseGuide_Console:SetShow(true)
end
function PaGlobal_FantasyHorseGuide_Console:prepareClose()
  self:close()
end
function PaGlobal_FantasyHorseGuide_Console:close()
  Panel_Window_FantasyHorseGuide_Console:SetShow(false)
end
function PaGlobalFunc_FantasyHorseGuide_Console_Open()
  if PaGlobal_FantasyHorseGuide_Console == nil then
    return
  end
  PaGlobal_FantasyHorseGuide_Console:prepareOpen()
end
function PaGlobalFunc_FantasyHorseGuide_Console_Close()
  if PaGlobal_FantasyHorseGuide_Console == nil then
    return
  end
  PaGlobal_FantasyHorseGuide_Console:prepareClose()
end
function PaGlobalFunc_FantasyHorseGuide_Console_Check(isSafeZone)
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  if selfPlayerWrapper:isDead() == true then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  if isGameServiceTypeConsole() == true then
    if selfPlayer:getLevel() < 5 then
      return
    end
  elseif selfPlayer:getLevel() < 20 then
    return
  end
  if isSafeZone == false then
    return
  end
  if ToClient_hasVipicoChallengeProgess() == false then
    return
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) == true then
    return
  end
  PaGlobalFunc_FantasyHorseGuide_Console_Open()
  ToClient_skipVipicoTutorial()
end
