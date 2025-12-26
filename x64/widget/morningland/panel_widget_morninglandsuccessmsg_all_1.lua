local MSG_VISIBLETIME = 5
function PaGlobal_MorningLandSuccessMsg:initialize()
  if self._initialize == true then
    return
  end
  self._ui.txt_content = UI.getChildControl(Panel_MorningLandSuccessMsg_All, "StaticText_Content")
  self._ui.txt_timeLog = UI.getChildControl(Panel_MorningLandSuccessMsg_All, "StaticText_TimeLog")
  self._ui.stc_newIcon = UI.getChildControl(Panel_MorningLandSuccessMsg_All, "Static_NewIcon")
  self:registerEventHandler()
  self:validate()
  self._initialize = true
  Panel_MorningLandSuccessMsg_All:SetFadeOverRender()
end
function PaGlobal_MorningLandSuccessMsg:registerEventHandler()
  registerEvent("FromClient_StopSequence", "FromClient_StopSequence_MorningLandBoss")
end
function PaGlobal_MorningLandSuccessMsg:prepareOpen()
  if Panel_MorningLandSuccessMsg_All == nil then
    return
  end
  local miliseconds = Int64toInt32(self._clearTime)
  local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(self._elementalMonsterKey)
  if miliseconds <= 0 or morningBossSSW == nil then
    return
  end
  local seconds = miliseconds / 1000
  local minute = math.floor(seconds / 60)
  local restSeconds = math.floor(seconds - minute * 60)
  local strMinute = tostring(minute)
  local strSeconds = tostring(restSeconds)
  if minute < 10 then
    strMinute = tostring(0) .. strMinute
  end
  if restSeconds < 10 then
    strSeconds = tostring(0) .. strSeconds
  end
  local textTime = strMinute .. " : " .. strSeconds
  self._ui.txt_timeLog:SetText(textTime)
  local monsterKeyRaw = morningBossSSW:getCharacterKeyRaw()
  local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(monsterKeyRaw)
  self._ui.txt_content:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNINGLAND_BOSSCLEARMSG", "bossName", characterStaticStatusWarpper:getName()))
  local historyInfo = ToClient_getElementalMonsterHistoryInfoByCharacterKey(monsterKeyRaw)
  local characterNo = getSelfPlayer():getCharacterNo_64()
  if historyInfo ~= nil then
    if historyInfo:getCharacterNo() == characterNo then
      local historyMilliseconds = Int64toInt32(historyInfo:getTickCount())
      local historySeconds = historyMilliseconds / 1000
      if math.floor(seconds) < math.floor(historySeconds) then
        self._ui.stc_newIcon:SetShow(true)
      else
        self._ui.stc_newIcon:SetShow(false)
      end
    else
      self._ui.stc_newIcon:SetShow(true)
    end
  else
    self._ui.stc_newIcon:SetShow(true)
  end
  self._msgVisibleTime = MSG_VISIBLETIME
  Panel_MorningLandSuccessMsg_All:RegisterUpdateFunc("Update_MorningLandSuccessMsg")
  PaGlobal_MorningLandSuccessMsg_ShowAni()
  self:open()
end
function PaGlobal_MorningLandSuccessMsg:open()
  if Panel_MorningLandSuccessMsg_All == nil then
    return
  end
  Panel_MorningLandSuccessMsg_All:SetShow(true)
end
function PaGlobal_MorningLandSuccessMsg:prepareClose()
  if Panel_MorningLandSuccessMsg_All == nil then
    return
  end
  self._clearTime = 0
  self._elementalMonsterKey = 0
  Panel_MorningLandSuccessMsg_All:ClearUpdateLuaFunc()
  self:close()
end
function PaGlobal_MorningLandSuccessMsg:close()
  if Panel_MorningLandSuccessMsg_All == nil then
    return
  end
  Panel_MorningLandSuccessMsg_All:SetShow(false)
end
function Update_MorningLandSuccessMsg(deltaTime)
  local self = PaGlobal_MorningLandSuccessMsg
  if self == nil then
    return
  end
  self._msgVisibleTime = self._msgVisibleTime - deltaTime
  if self._msgVisibleTime > 0 then
    return
  end
  self:prepareClose()
end
function PaGlobal_MorningLandSuccessMsg:validate()
  if Panel_MorningLandSuccessMsg_All == nil then
    return
  end
  self._ui.txt_content:isValidate()
  self._ui.txt_timeLog:isValidate()
  self._ui.stc_newIcon:isValidate()
end
