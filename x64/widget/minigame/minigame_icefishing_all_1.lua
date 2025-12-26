function PaGlobal_MiniGame_IceFishing_All:initialize()
  if true == PaGlobal_MiniGame_IceFishing_All._initialize then
    return
  end
  self._ui.stc_game_borad = UI.getChildControl(Panel_MiniGame_IceFishing_All, "Static_GameBoard_BG")
  self._ui.stc_waterBG = UI.getChildControl(self._ui.stc_game_borad, "Static_Water_BG")
  self._ui.stc_fising_area = UI.getChildControl(self._ui.stc_waterBG, "Static_FishingArea")
  for index = 0, 2 do
    self._ui.stc_hook[index] = UI.getChildControl(self._ui.stc_waterBG, "Static_Hook_" .. tostring(index))
  end
  self._ui.stc_fish_up = UI.getChildControl(self._ui.stc_waterBG, "Static_Fish_Up")
  self._ui.stc_fish_down = UI.getChildControl(self._ui.stc_waterBG, "Static_Fish_Down")
  self._ui.txt_leftTime = UI.getChildControl(self._ui.stc_game_borad, "StaticText_Time")
  self._ui.stc_space = UI.getChildControl(self._ui.stc_game_borad, "Static_SpaceBar")
  self._ui.txt_space_pc = UI.getChildControl(self._ui.stc_space, "StaticText_KeyBind")
  self._ui.txt_space_console = UI.getChildControl(self._ui.stc_game_borad, "StaticText_A_ConsoleUI")
  self._ui.stc_fish_msg_BG = UI.getChildControl(self._ui.stc_game_borad, "StaticText_MSG_BG")
  self._ui.stc_fish_title = UI.getChildControl(self._ui.stc_fish_msg_BG, "Static_Minigame_Fish_Title")
  self._ui.stc_fish_stateBG[self.FISH_STATE.NORMAL] = UI.getChildControl(self._ui.stc_fish_msg_BG, "StaticText_MSG_normal")
  self._ui.stc_fish_stateBG[self.FISH_STATE.WARNING] = UI.getChildControl(self._ui.stc_fish_msg_BG, "StaticText_MSG_warning")
  self._ui.stc_fish_stateBG[self.FISH_STATE.SUCCESS] = UI.getChildControl(self._ui.stc_fish_msg_BG, "StaticText_MSG_success")
  self._ui.txt_fish_state = UI.getChildControl(self._ui.stc_fish_msg_BG, "MultilineText_desc")
  self._ui.stc_key_Guide_BG = UI.getChildControl(self._ui.stc_game_borad, "Static_KeyGuide_BG")
  self._ui.stc_aim = UI.getChildControl(self._ui.stc_key_Guide_BG, "Static_AimGuide")
  self._ui.stc_mouse_PC = UI.getChildControl(self._ui.stc_key_Guide_BG, "Static_Mouse_PCUI")
  self._ui.stc_rs_Console = UI.getChildControl(self._ui.stc_key_Guide_BG, "Static_Rs_ConsoleUI")
  self._ui.stc_direct_Left = UI.getChildControl(self._ui.stc_key_Guide_BG, "Static_Direc_Left")
  self._ui.stc_direct_Right = UI.getChildControl(self._ui.stc_key_Guide_BG, "Static_Direc_Right")
  self._ui.txt_keyGuide = UI.getChildControl(self._ui.stc_key_Guide_BG, "StaticText_Desc")
  self._ui.stc_fishHp_BG = UI.getChildControl(self._ui.stc_game_borad, "Static_Fish_HP_BG")
  self._ui.progress_fishHp = UI.getChildControl(self._ui.stc_game_borad, "Progress2_Fish_HP")
  self._ui.stc_fishHpHead = UI.getChildControl(self._ui.progress_fishHp, "Progress2_1_Bar_Head")
  self._ui.stc_result_board = UI.getChildControl(Panel_MiniGame_IceFishing_All, "StaticText_Resurt_BG")
  self._ui.stc_success = UI.getChildControl(self._ui.stc_result_board, "Static_Success")
  self._ui.stc_fail = UI.getChildControl(self._ui.stc_result_board, "Static_Fail")
  if true == _ContentsGroup_UsePadSnapping then
    self._ui.stc_rs_Console:SetShow(true)
    self._ui.stc_mouse_PC:SetShow(false)
  else
    self._ui.stc_rs_Console:SetShow(false)
    self._ui.stc_mouse_PC:SetShow(true)
  end
  self._originalPlayerPosY = self._ui.stc_hook[0]:GetPosY()
  self._originalUpFishPosY = self._ui.stc_fish_up:GetPosY()
  self._originalDownFishPosY = self._ui.stc_fish_down:GetPosY()
  PaGlobal_MiniGame_IceFishing_All:registEventHandler()
  self._ui.stc_aim:SetIgnore(false)
  PaGlobal_MiniGame_IceFishing_All:validate()
  PaGlobal_MiniGame_IceFishing_All._initialize = true
end
function PaGlobal_MiniGame_IceFishing_All:registEventHandler()
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  registerEvent("FromClient_IceFishingLeftTimeAndLeftHP", "FromClient_IceFishingLeftTimeAndLeftHP")
  registerEvent("FromClient_IceFishingMovePos", "FromClient_IceFishingMovePos")
  registerEvent("FromClient_IceFishingCurrentEndurance", "FromClient_IceFishingCurrentEndurance")
  registerEvent("FromClient_IceFishingNoticeDirect", "FromClient_IceFishingNoticeDirect")
  registerEvent("FromClient_IceFishingFail", "PaGlobal_MiniGame_IceFishing_All_Fail")
  registerEvent("FromClient_IceFishingSuccess", "PaGlobal_MiniGame_IceFishing_All_Success")
  registerEvent("FromClient_IceFishingCriticalDamage", "FromClient_IceFishingCriticalDamage")
end
function PaGlobal_MiniGame_IceFishing_All:prepareOpen()
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  PaGlobal_MiniGame_IceFishing_All:open()
end
function PaGlobal_MiniGame_IceFishing_All:open()
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  Panel_MiniGame_IceFishing_All:SetShow(true)
end
function PaGlobal_MiniGame_IceFishing_All:prepareClose()
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  ToClient_EndIceFishingMiniGame()
  PaGlobal_MiniGame_IceFishing_All:close()
end
function PaGlobal_MiniGame_IceFishing_All:close()
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  Panel_MiniGame_IceFishing_All:SetShow(false)
end
function PaGlobal_MiniGame_IceFishing_All:update()
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
end
function PaGlobal_MiniGame_IceFishing_All:validate()
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  self._ui.stc_game_borad:isValidate()
  self._ui.stc_waterBG:isValidate()
  self._ui.stc_fising_area:isValidate()
  for index = 0, 2 do
    self._ui.stc_hook[index]:isValidate()
  end
  self._ui.stc_fish_up:isValidate()
  self._ui.stc_fish_down:isValidate()
  self._ui.txt_leftTime:isValidate()
  self._ui.stc_space:isValidate()
  self._ui.txt_space_pc:isValidate()
  self._ui.txt_space_console:isValidate()
  self._ui.stc_fish_msg_BG:isValidate()
  self._ui.stc_fish_title:isValidate()
  self._ui.stc_fish_stateBG[self.FISH_STATE.NORMAL]:isValidate()
  self._ui.stc_fish_stateBG[self.FISH_STATE.WARNING]:isValidate()
  self._ui.stc_fish_stateBG[self.FISH_STATE.SUCCESS]:isValidate()
  self._ui.txt_fish_state:isValidate()
  self._ui.stc_key_Guide_BG:isValidate()
  self._ui.stc_aim:isValidate()
  self._ui.stc_mouse_PC:isValidate()
  self._ui.stc_rs_Console:isValidate()
  self._ui.stc_direct_Left:isValidate()
  self._ui.stc_direct_Right:isValidate()
  self._ui.txt_keyGuide:isValidate()
  self._ui.stc_fishHp_BG:isValidate()
  self._ui.progress_fishHp:isValidate()
  self._ui.stc_fishHpHead:isValidate()
  self._ui.stc_result_board:isValidate()
  self._ui.stc_success:isValidate()
  self._ui.stc_fail:isValidate()
end
function PaGlobal_MiniGame_IceFishing_All:setProgressData()
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  if self._fishHp <= 0 then
    self._ui.progress_fishHp:SetProgressRate(0)
  else
    self._ui.progress_fishHp:SetProgressRate(self._fishHp / self._fishTotalHp * 100)
  end
  if 0 >= self._leftTime then
    self._ui.txt_leftTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ICEFISHING_TIME", "time", tostring(0)))
  else
    self._ui.txt_leftTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ICEFISHING_TIME", "time", tostring(self._leftTime)))
  end
  if true == ToClient_GetCanFinishIceFishingGameForHp() then
    self._ui.stc_fish_stateBG[self.FISH_STATE.WARNING]:SetShow(false)
    self._ui.stc_fish_stateBG[self.FISH_STATE.SUCCESS]:SetShow(true)
    self._ui.txt_fish_state:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ICEFISHING_DESC_FINISH"))
    if false == _ContentsGroup_UsePadSnapping then
      self._ui.stc_space:SetShow(true)
      self._ui.txt_space_console:SetShow(false)
    else
      self._ui.stc_space:SetShow(false)
      self._ui.txt_space_console:SetShow(true)
    end
    self._ui.stc_fishHpHead:SetShow(false)
  else
    self._ui.stc_fishHpHead:SetShow(true)
  end
end
function PaGlobal_MiniGame_IceFishing_All:setPositionData()
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  for index = 0, 2 do
    self._ui.stc_hook[index]:SetPosY(self._originalPlayerPosY + self._currentPlayerPosY)
  end
  if self.FISH_DIRECTION.UP == self._currentFishDirection then
    self._ui.stc_fish_up:SetPosY(self._originalUpFishPosY + self._currentPlayerPosY)
    self._ui.stc_fish_up:SetShow(true)
    self._ui.stc_fish_down:SetShow(false)
  elseif self.FISH_DIRECTION.DOWN == self._currentFishDirection then
    self._ui.stc_fish_down:SetPosY(self._originalDownFishPosY + self._currentPlayerPosY)
    self._ui.stc_fish_up:SetShow(false)
    self._ui.stc_fish_down:SetShow(true)
  end
end
