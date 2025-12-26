local UI_SERVICE_RESOURCE = CppEnums.ServiceResourceType
function PaGlobal_Steam_Redemption()
  if isSteamClient() then
    if not isSteamInGameOverlayEnabled() then
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_STEAM_ALERT")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
        content = messageBoxMemo,
        functionYes = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    else
      Steam_Redemption()
    end
    return
  end
end
function Steam_Redemption()
  ToClient_requestRedeemAuthSessionTicket()
  local url
  url = ToClient_getInGameSteamWebStorage()
  if isGameTypeNA() then
    local nationType = getServiceNationType()
    if 1 == nationType then
      url = url .. "&regionType=1"
    else
      url = url .. "&regionType=0"
    end
  end
  if nil ~= url then
    steamOverlayToWebPage(url)
  end
end
function FromClient_SteamRedeemAuthTicketReady()
  local url = ToClient_getInGameSteamWebStorage()
  if isGameTypeNA() then
    local nationType = getServiceNationType()
    if 1 == nationType then
      url = url .. "&regionType=1"
    else
      url = url .. "&regionType=0"
    end
  end
  steamOverlayToWebPage(url)
end
registerEvent("FromClient_SteamRedeemAuthTicketReady", "FromClient_SteamRedeemAuthTicketReady")
