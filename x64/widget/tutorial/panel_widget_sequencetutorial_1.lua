function PaGlobal_SequenceTutorial:initialize()
  if Panel_SequenceTutorial_Quest == nil then
    return
  end
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_mainBg = UI.getChildControl(Panel_SequenceTutorial_Quest, "Static_MainBG")
  self._ui._txt_Desc = UI.getChildControl(self._ui._stc_mainBg, "MultilineText_Desc")
  self._ui._txt_goal_1 = UI.getChildControl(self._ui._stc_mainBg, "StaticText_Desc")
  self._ui._txt_goal_2 = UI.getChildControl(self._ui._stc_mainBg, "StaticText_1")
  self._ui._txt_goal_3 = UI.getChildControl(self._ui._stc_mainBg, "StaticText_2")
  self._ui._stc_descBg = UI.getChildControl(Panel_SequenceTutorial_Quest, "Static_DescBG")
  self._ui._txt_subDesc = UI.getChildControl(self._ui._stc_descBg, "StaticText_SubDesc")
  self._ui._stc_skillGuideBg = UI.getChildControl(Panel_SequenceTutorial_Quest, "Static_SkillGuide_BG")
  for ii = 1, self._maxSkillCount do
    local skillGuide = {
      bg = nil,
      skillIcon = nil,
      skillName = nil,
      command_bg = nil,
      command_Key = nil,
      command_Plus = nil,
      command_LB = nil,
      command_RB = nil
    }
    skillGuide.bg = UI.getChildControl(self._ui._stc_skillGuideBg, "Static_MainBG_" .. ii)
    skillGuide.skillIcon = UI.getChildControl(skillGuide.bg, "Static_SkillIcon")
    skillGuide.skillName = UI.getChildControl(skillGuide.bg, "StaticText_SkillName")
    skillGuide.command_bg = UI.getChildControl(skillGuide.bg, "Static_SkillCommand_Body")
    skillGuide.command_Key = UI.getChildControl(skillGuide.command_bg, "StaticText_SkillKey")
    skillGuide.command_Plus = UI.getChildControl(skillGuide.command_bg, "StaticText_Plus")
    skillGuide.command_LB = UI.getChildControl(skillGuide.command_bg, "Static_MLB")
    skillGuide.command_RB = UI.getChildControl(skillGuide.command_bg, "Static_MRB")
    self._ui._stc_skillGuide[ii] = skillGuide
  end
  self._ui._btn_servantIcon = UI.getChildControl(Panel_SequenceTutorial_Quest, "Button_ServantIcon_template")
  self._ui._stc_failBg = UI.getChildControl(Panel_SequenceTutorial_Quest, "Static_Fail_BG")
  self._ui._txt_failTitle = UI.getChildControl(self._ui._stc_failBg, "StaticText_Title")
  self._ui._txt_failTime = UI.getChildControl(self._ui._stc_failBg, "StaticText_Time")
  self:setButtonKeyGuideTextureUI()
  self._ui._txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  Panel_SequenceTutorial_Quest:SetFadeOverRender()
  self:validate()
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_SequenceTutorial:setButtonKeyGuideTextureUI()
  if Panel_SequenceTutorial_Quest == nil then
    return
  end
  local keyGuideBG = UI.getChildControl(Panel_SequenceTutorial_Quest, "Static_KeyGuide_PS")
  keyGuideBG:SetShow(false)
  keyGuideBG = UI.getChildControl(Panel_SequenceTutorial_Quest, "Static_KeyGuide_PS5")
  keyGuideBG:SetShow(false)
  keyGuideBG = UI.getChildControl(Panel_SequenceTutorial_Quest, "Static_KeyGuide_XB")
  keyGuideBG:SetShow(false)
  keyGuideBG = UI.getChildControl(Panel_SequenceTutorial_Quest, "Static_KeyGuide")
  keyGuideBG:SetShow(false)
  if self._isConsole == true then
    if ToClient_isConsole() == true and (_ContentsGroup_isPS4UI == true or ToClient_isPS5() == true) then
      if ToClient_isPS5() == true then
        self._ui._stc_keyGuideBg = UI.getChildControl(Panel_SequenceTutorial_Quest, "Static_KeyGuide_PS5")
      else
        self._ui._stc_keyGuideBg = UI.getChildControl(Panel_SequenceTutorial_Quest, "Static_KeyGuide_PS")
      end
      self._ui._keyToVirtualKey._attack1._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Attack1")
      self._ui._keyToVirtualKey._attack2._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Attack2")
      self._ui._keyToVirtualKey._crouch._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Crouch")
      self._ui._keyToVirtualKey._moveFront._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_MoveFront")
      self._ui._keyToVirtualKey._moveLeft._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_MoveLeft")
      self._ui._keyToVirtualKey._moveBack._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_MoveBack")
      self._ui._keyToVirtualKey._moveRight._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_MoveRight")
      self._ui._keyToVirtualKey._moveFrontLeft._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_MoveFront_Left")
      self._ui._keyToVirtualKey._moveFrontRight._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_MoveFront_Right")
      self._ui._keyToVirtualKey._moveBackLeft._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_MoveBack_Left")
      self._ui._keyToVirtualKey._moveBackRight._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_MoveBack_Right")
      self._ui._keyToVirtualKey._interaction._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Interaction")
      self._ui._keyToVirtualKey._grab._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Grab")
      self._ui._keyToVirtualKey._kick._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Kick")
      self._ui._keyToVirtualKey._servantOrder3._on = nil
      self._ui._keyToVirtualKey._weaponInOut._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_WeaponInOut")
      self._ui._keyToVirtualKey._dash._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Dash")
      self._ui._keyToVirtualKey._jump._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Jump")
      self._ui._keyToVirtualKey._attack1._off = nil
      self._ui._keyToVirtualKey._attack2._off = nil
      self._ui._keyToVirtualKey._crouch._off = nil
      self._ui._keyToVirtualKey._moveFront._off = nil
      self._ui._keyToVirtualKey._moveLeft._off = nil
      self._ui._keyToVirtualKey._moveBack._off = nil
      self._ui._keyToVirtualKey._moveRight._off = nil
      self._ui._keyToVirtualKey._moveFrontLeft._off = nil
      self._ui._keyToVirtualKey._moveFrontRight._off = nil
      self._ui._keyToVirtualKey._moveBackLeft._off = nil
      self._ui._keyToVirtualKey._moveBackRight._off = nil
      self._ui._keyToVirtualKey._interaction._off = nil
      self._ui._keyToVirtualKey._grab._off = nil
      self._ui._keyToVirtualKey._kick._off = nil
      self._ui._keyToVirtualKey._servantOrder3._off = nil
      self._ui._keyToVirtualKey._weaponInOut._off = nil
      self._ui._keyToVirtualKey._dash._off = nil
      self._ui._keyToVirtualKey._jump._off = nil
      self._ui._cameraMove._front._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_CameraFront")
      self._ui._cameraMove._left._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_CameraLeft")
      self._ui._cameraMove._back._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_CameraBack")
      self._ui._cameraMove._right._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_CameraRight")
      self._ui._cameraMove._frontLeft._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_CameraFront_Left")
      self._ui._cameraMove._frontRight._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_CameraFront_Right")
      self._ui._cameraMove._backLeft._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_CameraBack_Left")
      self._ui._cameraMove._backRight._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_CameraBack_Right")
      self._ui._keyGuideSubChild._stc_Console_Left = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Left")
      self._ui._keyGuideSubChild._stc_Console_Left_LT = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Left, "StaticText_LT")
      self._ui._keyGuideSubChild._stc_Console_Left_LB = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Left, "StaticText_LB")
      self._ui._keyGuideSubChild._stc_Console_Right = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Right")
      self._ui._keyGuideSubChild._stc_Console_Right_RT = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Right, "StaticText_RT")
      self._ui._keyGuideSubChild._stc_Console_Right_RB = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Right, "StaticText_RB")
      self._ui._keyGuideSubChild._stc_Console_Btn_D = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_D")
      self._ui._keyGuideSubChild._stc_Console_Btn_D_Y = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Btn_D, "StaticText_Y")
      self._ui._keyGuideSubChild._stc_Console_Btn_D_B = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Btn_D, "StaticText_B")
      self._ui._keyGuideSubChild._stc_Console_Btn_D_A = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Btn_D, "StaticText_A")
      self._ui._keyGuideSubChild._stc_Console_Btn_D_X = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Btn_D, "StaticText_X")
      self._ui._keyGuideSubChild._stc_Console_Btn_R = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_R")
      self._ui._keyGuideSubChild._stc_Console_Btn_R_RS = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Btn_R, "StaticText_RS")
      self._ui._keyGuideSubChild._stc_Console_Move = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_KeyGuide_Move")
      self._ui._keyGuideSubChild._stc_Console_Move_Move = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Move, "StaticText_Move")
      self._ui._stc_keyGuideSub = self._ui._keyGuideSubChild._stc_Console_Left
    else
      self._ui._stc_keyGuideBg = UI.getChildControl(Panel_SequenceTutorial_Quest, "Static_KeyGuide_XB")
      self._ui._keyToVirtualKey._attack1._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Attack1")
      self._ui._keyToVirtualKey._attack2._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Attack2")
      self._ui._keyToVirtualKey._crouch._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Crouch")
      self._ui._keyToVirtualKey._moveFront._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_MoveFront")
      self._ui._keyToVirtualKey._moveLeft._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_MoveLeft")
      self._ui._keyToVirtualKey._moveBack._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_MoveBack")
      self._ui._keyToVirtualKey._moveRight._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_MoveRight")
      self._ui._keyToVirtualKey._moveFrontLeft._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_MoveFront_Left")
      self._ui._keyToVirtualKey._moveFrontRight._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_MoveFront_Right")
      self._ui._keyToVirtualKey._moveBackLeft._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_MoveBack_Left")
      self._ui._keyToVirtualKey._moveBackRight._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_MoveBack_Right")
      self._ui._keyToVirtualKey._interaction._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Interaction")
      self._ui._keyToVirtualKey._grab._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Grab")
      self._ui._keyToVirtualKey._kick._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Kick")
      self._ui._keyToVirtualKey._servantOrder3._on = nil
      self._ui._keyToVirtualKey._weaponInOut._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_WeaponInOut")
      self._ui._keyToVirtualKey._dash._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Dash")
      self._ui._keyToVirtualKey._jump._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Jump")
      self._ui._keyToVirtualKey._attack1._off = nil
      self._ui._keyToVirtualKey._attack2._off = nil
      self._ui._keyToVirtualKey._crouch._off = nil
      self._ui._keyToVirtualKey._moveFront._off = nil
      self._ui._keyToVirtualKey._moveLeft._off = nil
      self._ui._keyToVirtualKey._moveBack._off = nil
      self._ui._keyToVirtualKey._moveRight._off = nil
      self._ui._keyToVirtualKey._moveFrontLeft._off = nil
      self._ui._keyToVirtualKey._moveFrontRight._off = nil
      self._ui._keyToVirtualKey._moveBackLeft._off = nil
      self._ui._keyToVirtualKey._moveBackRight._off = nil
      self._ui._keyToVirtualKey._interaction._off = nil
      self._ui._keyToVirtualKey._grab._off = nil
      self._ui._keyToVirtualKey._kick._off = nil
      self._ui._keyToVirtualKey._servantOrder3._off = nil
      self._ui._keyToVirtualKey._weaponInOut._off = nil
      self._ui._keyToVirtualKey._dash._off = nil
      self._ui._keyToVirtualKey._jump._off = nil
      self._ui._cameraMove._front._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_CameraFront")
      self._ui._cameraMove._left._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_CameraLeft")
      self._ui._cameraMove._back._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_CameraBack")
      self._ui._cameraMove._right._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_CameraRight")
      self._ui._cameraMove._frontLeft._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_CameraFront_Left")
      self._ui._cameraMove._frontRight._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_CameraFront_Right")
      self._ui._cameraMove._backLeft._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_CameraBack_Left")
      self._ui._cameraMove._backRight._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_CameraBack_Right")
      self._ui._keyGuideSubChild._stc_Console_Left = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Left")
      self._ui._keyGuideSubChild._stc_Console_Left_LT = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Left, "StaticText_LT")
      self._ui._keyGuideSubChild._stc_Console_Left_LB = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Left, "StaticText_LB")
      self._ui._keyGuideSubChild._stc_Console_Right = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Right")
      self._ui._keyGuideSubChild._stc_Console_Right_RT = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Right, "StaticText_RT")
      self._ui._keyGuideSubChild._stc_Console_Right_RB = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Right, "StaticText_RB")
      self._ui._keyGuideSubChild._stc_Console_Btn_D = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_D")
      self._ui._keyGuideSubChild._stc_Console_Btn_D_Y = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Btn_D, "StaticText_Y")
      self._ui._keyGuideSubChild._stc_Console_Btn_D_B = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Btn_D, "StaticText_B")
      self._ui._keyGuideSubChild._stc_Console_Btn_D_A = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Btn_D, "StaticText_A")
      self._ui._keyGuideSubChild._stc_Console_Btn_D_X = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Btn_D, "StaticText_X")
      self._ui._keyGuideSubChild._stc_Console_Btn_R = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_R")
      self._ui._keyGuideSubChild._stc_Console_Btn_R_RS = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Btn_R, "StaticText_RS")
      self._ui._keyGuideSubChild._stc_Console_Move = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_KeyGuide_Move")
      self._ui._keyGuideSubChild._stc_Console_Move_Move = UI.getChildControl(self._ui._keyGuideSubChild._stc_Console_Move, "StaticText_Move")
      self._ui._stc_keyGuideSub = self._ui._keyGuideSubChild._stc_Console_Left
    end
  else
    self._ui._stc_keyGuideBg = UI.getChildControl(Panel_SequenceTutorial_Quest, "Static_KeyGuide")
    self._ui._keyToVirtualKey._attack1._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_M0_2")
    self._ui._keyToVirtualKey._attack2._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_M1_2")
    self._ui._keyToVirtualKey._crouch._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_Q_2")
    self._ui._keyToVirtualKey._moveFront._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_W_2")
    self._ui._keyToVirtualKey._moveLeft._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_A_2")
    self._ui._keyToVirtualKey._moveBack._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_S_2")
    self._ui._keyToVirtualKey._moveRight._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_D_2")
    self._ui._keyToVirtualKey._moveFrontLeft._on = nil
    self._ui._keyToVirtualKey._moveFrontRight._on = nil
    self._ui._keyToVirtualKey._moveBackLeft._on = nil
    self._ui._keyToVirtualKey._moveBackRight._on = nil
    self._ui._keyToVirtualKey._autoRun._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_T_2")
    self._ui._keyToVirtualKey._interaction._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_R_2")
    self._ui._keyToVirtualKey._grab._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_E_2")
    self._ui._keyToVirtualKey._kick._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_F_2")
    self._ui._keyToVirtualKey._servantOrder3._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_C_2")
    self._ui._keyToVirtualKey._weaponInOut._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_Tab_2")
    self._ui._keyToVirtualKey._dash._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_Shift_2")
    self._ui._keyToVirtualKey._jump._on = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_Space_2")
    self._ui._keyToVirtualKey._attack1._off = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_M0")
    self._ui._keyToVirtualKey._attack2._off = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_M1")
    self._ui._keyToVirtualKey._crouch._off = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_Q")
    self._ui._keyToVirtualKey._moveFront._off = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_W")
    self._ui._keyToVirtualKey._moveLeft._off = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_A")
    self._ui._keyToVirtualKey._moveBack._off = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_S")
    self._ui._keyToVirtualKey._moveRight._off = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_D")
    self._ui._keyToVirtualKey._moveFrontLeft._off = nil
    self._ui._keyToVirtualKey._moveFrontRight._off = nil
    self._ui._keyToVirtualKey._moveBackLeft._off = nil
    self._ui._keyToVirtualKey._moveBackRight._off = nil
    self._ui._keyToVirtualKey._autoRun._off = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_T")
    self._ui._keyToVirtualKey._interaction._off = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_R")
    self._ui._keyToVirtualKey._grab._off = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_E")
    self._ui._keyToVirtualKey._kick._off = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_F")
    self._ui._keyToVirtualKey._servantOrder3._off = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_C")
    self._ui._keyToVirtualKey._weaponInOut._off = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_Tab")
    self._ui._keyToVirtualKey._dash._off = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_Shift")
    self._ui._keyToVirtualKey._jump._off = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Btn_Space")
    self._ui._stc_keyGuideSub = UI.getChildControl(self._ui._stc_keyGuideBg, "Static_KeyGuide_Sub")
    self._ui._keyGuideSubChild._stc_TextBG_WASD = UI.getChildControl(self._ui._stc_keyGuideSub, "StaticText_TextBG_WASD")
    self._ui._keyGuideSubChild._stc_TextBG_Tab = UI.getChildControl(self._ui._stc_keyGuideSub, "StaticText_TextBG_Tab")
    self._ui._keyGuideSubChild._stc_TextBG_Shift = UI.getChildControl(self._ui._stc_keyGuideSub, "StaticText_TextBG_Shift")
    self._ui._keyGuideSubChild._stc_TextBG_R = UI.getChildControl(self._ui._stc_keyGuideSub, "StaticText_TextBG_R")
    self._ui._keyGuideSubChild._stc_TextBG_MB = UI.getChildControl(self._ui._stc_keyGuideSub, "StaticText_TextBG_MB")
    self._ui._keyGuideSubChild._stc_TextBG_Space = UI.getChildControl(self._ui._stc_keyGuideSub, "StaticText_TextBG_Space")
    self._ui._keyGuideSubChild._stc_Line_WASD = UI.getChildControl(self._ui._stc_keyGuideSub, "Static_Line_WASD")
    self._ui._keyGuideSubChild._stc_Line_Tab = UI.getChildControl(self._ui._stc_keyGuideSub, "Static_Line_Tab")
    self._ui._keyGuideSubChild._stc_Line_Shift = UI.getChildControl(self._ui._stc_keyGuideSub, "Static_Line_Shift")
    self._ui._keyGuideSubChild._stc_Line_R = UI.getChildControl(self._ui._stc_keyGuideSub, "Static_Line_R")
    self._ui._keyGuideSubChild._stc_Line_MB = UI.getChildControl(self._ui._stc_keyGuideSub, "Static_Line_MB")
    self._ui._keyGuideSubChild._stc_Line_Space = UI.getChildControl(self._ui._stc_keyGuideSub, "Static_Line_Space")
    self._keyGuideX = self._ui._stc_keyGuideBg:GetSizeX()
    self._keyGuideY = self._ui._stc_keyGuideBg:GetSizeY()
  end
end
function PaGlobal_SequenceTutorial:prepareOpen()
  if Panel_SequenceTutorial_Quest == nil then
    return
  end
  if _ContentsGroup_NewSequenceTutorial == false then
    return
  end
  self._ui._stc_skillGuideBg:SetShow(false)
  self._ui._btn_servantIcon:SetShow(false)
  self._ui._stc_failBg:SetShow(false)
  self._ui._stc_mainBg:SetShow(false)
  self._ui._stc_descBg:SetShow(false)
  self._ui._stc_keyGuideBg:SetShow(true)
  if self._ui._stc_keyGuideSub ~= nil then
    self._keyGuideSubTick = 0
    self._keyGuideSubAlpha = 0
    self:keyGuideSubSetAlpha(self._keyGuideSubAlpha)
    self._ui._stc_keyGuideSub:SetShow(true)
    if self._isConsole == true then
      self._ui._keyGuideSubChild._stc_Console_Left:SetShow(true)
      self._ui._keyGuideSubChild._stc_Console_Right:SetShow(true)
      self._ui._keyGuideSubChild._stc_Console_Btn_D:SetShow(true)
      self._ui._keyGuideSubChild._stc_Console_Btn_R:SetShow(true)
      self._ui._keyGuideSubChild._stc_Console_Move:SetShow(true)
    end
  end
  self:open()
  self:resize()
  Panel_SequenceTutorial_Quest:RegisterUpdateFunc("Panel_tutorial_KeyViewerUpdate")
end
function PaGlobal_SequenceTutorial:open()
  if Panel_SequenceTutorial_Quest == nil then
    return
  end
  Panel_SequenceTutorial_Quest:SetShow(true)
end
function PaGlobal_SequenceTutorial:prepareClose()
  if Panel_SequenceTutorial_Quest == nil then
    return
  end
  self._mainDescCount = 0
  self._subDescCount = 0
  self._failMainDescCount = 0
  self._failSubDescCount = 0
  Panel_SequenceTutorial_Quest:ClearUpdateLuaFunc()
  self:close()
end
function PaGlobal_SequenceTutorial:close()
  if Panel_SequenceTutorial_Quest == nil then
    return
  end
  Panel_SequenceTutorial_Quest:SetShow(false)
end
function PaGlobal_SequenceTutorial:setMainDesc()
  if Panel_SequenceTutorial_Quest == nil then
    return
  end
  local resultStr = ""
  local count = ToClient_getGimmickMainDescStringKeySize()
  local emptyCheck = true
  for i = 0, count do
    local getStr = ToClient_getGimmickMainDescString(i)
    if 0 < string.len(getStr) then
      emptyCheck = false
      resultStr = resultStr .. PAGetString(Defines.StringSheet_CUTSCENE, getStr) .. "\n"
    end
  end
  if emptyCheck == false then
    self._ui._stc_mainBg:SetShow(true)
  end
  self._ui._txt_Desc:SetText(resultStr)
end
function PaGlobal_SequenceTutorial:setSubDesc()
  if Panel_SequenceTutorial_Quest == nil then
    return
  end
  local resultStr = ""
  local count = ToClient_getGimmickSubDescStringKeySize()
end
function PaGlobal_SequenceTutorial:setFailMainDesc()
  if Panel_SequenceTutorial_Quest == nil then
    return
  end
  local resultStr = ""
  local count = ToClient_getFailGimmickMainDescStringKeySize()
end
function PaGlobal_SequenceTutorial:setFailSubDesc()
  if Panel_SequenceTutorial_Quest == nil then
    return
  end
  local resultStr = ""
  local count = ToClient_getFailGimmickSubDescStringKeySize()
end
function PaGlobal_SequenceTutorial:updateSkillGuide(skillData)
  for ii = 1, self._maxSkillCount do
    if nil ~= self._ui._stc_skillGuide[ii] then
      self._ui._stc_skillGuide[ii].bg:SetShow(false)
      if nil ~= skillData[ii] then
        local skillWrapper = getSkillStaticStatus(skillData[ii], 1)
        if nil ~= skillWrapper then
          local skillTypeWrapper = skillWrapper:getSkillTypeStaticStatusWrapper()
          if nil ~= skillTypeWrapper then
            self._ui._stc_skillGuide[ii].bg:SetShow(true)
            self._ui._stc_skillGuide[ii].skillIcon:ChangeTextureInfoNameAsync("Icon/" .. skillTypeWrapper:getIconPath())
            self._ui._stc_skillGuide[ii].skillIcon:setRenderTexture(self._ui._stc_skillGuide[ii].skillIcon:getBaseTexture())
            self._ui._stc_skillGuide[ii].skillName:SetText(skillTypeWrapper:getName())
            local command = skillTypeWrapper:getSimpleCommand()
            if nil == command or "" == command then
              self._ui._stc_skillGuide[ii].command_bg:SetShow(false)
            else
              self._ui._stc_skillGuide[ii].command_bg:SetShow(true)
              local commandIndex = string.find(command, "<")
              local stringIndex = string.find(command, "[%[]")
              local plusIndex = string.find(command, "+")
              local LBstring = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_MouseLB")
              local LBstringIndex = string.find(command, LBstring)
              local RBstring = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_MouseRB")
              local RBstringIndex = string.find(command, RBstring)
              if nil == plusIndex then
                self._ui._stc_skillGuide[ii].command_Plus:SetShow(false)
              else
                self._ui._stc_skillGuide[ii].command_Plus:SetShow(true)
              end
              if nil == LBstringIndex then
                self._ui._stc_skillGuide[ii].command_LB:SetShow(false)
              else
                self._ui._stc_skillGuide[ii].command_LB:SetShow(true)
              end
              if nil == RBstringIndex then
                self._ui._stc_skillGuide[ii].command_RB:SetShow(false)
              else
                self._ui._stc_skillGuide[ii].command_RB:SetShow(true)
              end
              self._ui._stc_skillGuide[ii].command_Key:SetShow(false)
              if nil == plusIndex then
                local text = string.sub(command, string.find(command, ">") + 1, string.find(command, "<PAOldColor>") - 1)
                if nil == string.find(text, LBstring) and nil == string.find(text, RBstring) then
                  self._ui._stc_skillGuide[ii].command_Key:SetText(text)
                  self._ui._stc_skillGuide[ii].command_Key:SetShow(true)
                end
              else
                local keyText = ""
                local text = string.sub(command, string.find(command, ">") + 1, plusIndex - 1)
                if nil == string.find(text, LBstring) and nil == string.find(text, RBstring) then
                  keyText = text
                end
                local test2 = string.sub(command, plusIndex + 1, string.find(command, "<PAOldColor>") - 1)
                if nil == string.find(test2, LBstring) and nil == string.find(test2, RBstring) then
                  if "" ~= keyText then
                    keyText = keyText .. " + " .. test2
                    self._ui._stc_skillGuide[ii].command_Plus:SetShow(false)
                  else
                    keyText = test2
                  end
                end
                if "" ~= keyText then
                  self._ui._stc_skillGuide[ii].command_Key:SetShow(true)
                  self._ui._stc_skillGuide[ii].command_Key:SetText(keyText)
                end
              end
              local posX = self._ui._stc_skillGuide[ii].command_Key:GetSpanSize().x
              local padding = 5
              local checkPlus = false
              if true == self._ui._stc_skillGuide[ii].command_Key:GetShow() then
                posX = posX + self._ui._stc_skillGuide[ii].command_Key:GetTextSizeX() + padding
                if true == self._ui._stc_skillGuide[ii].command_Plus:GetShow() then
                  self._ui._stc_skillGuide[ii].command_Plus:SetSpanSize(posX, self._ui._stc_skillGuide[ii].command_Plus:GetSpanSize().y)
                  posX = posX + self._ui._stc_skillGuide[ii].command_Plus:GetSizeX() + padding
                  checkPlus = true
                end
              end
              if true == self._ui._stc_skillGuide[ii].command_LB:GetShow() then
                self._ui._stc_skillGuide[ii].command_LB:SetSpanSize(posX, self._ui._stc_skillGuide[ii].command_LB:GetSpanSize().y)
                posX = posX + self._ui._stc_skillGuide[ii].command_LB:GetSizeX() + padding
                if true == self._ui._stc_skillGuide[ii].command_Plus:GetShow() and false == checkPlus then
                  self._ui._stc_skillGuide[ii].command_Plus:SetSpanSize(posX, self._ui._stc_skillGuide[ii].command_Plus:GetSpanSize().y)
                  posX = posX + self._ui._stc_skillGuide[ii].command_Plus:GetSizeX() + padding
                end
              end
              if true == self._ui._stc_skillGuide[ii].command_RB:GetShow() then
                self._ui._stc_skillGuide[ii].command_RB:SetSpanSize(posX, self._ui._stc_skillGuide[ii].command_RB:GetSpanSize().y)
              end
            end
          end
        end
      end
    end
  end
end
function PaGlobal_SequenceTutorial:registEventHandler()
  if Panel_SequenceTutorial_Quest == nil then
    return
  end
  registerEvent("onScreenResize", "")
  registerEvent("FromClient_SequenceTutorialSkillGuideShow", "PaGlobal_SequenceTutorial_SkillGuideShow")
  registerEvent("FromClient_SequenceTutorialGuideSet", "FromClient_SequenceTutorialGuideSet")
end
function PaGlobal_SequenceTutorial:validate()
  if Panel_SequenceTutorial_Quest == nil then
    return
  end
  for key, value in pairs(self._ui._keyToVirtualKey) do
    if value._on ~= nil then
      value._on:isValidate()
    end
    if value._off ~= nil then
      value._off:isValidate()
    end
  end
end
function PaGlobal_SequenceTutorial:resize()
  if Panel_SequenceTutorial_Quest == nil then
    return
  end
  Panel_SequenceTutorial_Quest:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_SequenceTutorial_Quest:ComputePos()
  self._ui._stc_mainBg:ComputePos()
  self._ui._stc_descBg:ComputePos()
  self._ui._stc_keyGuideBg:ComputePos()
  if self._isConsole == true then
    self._ui._stc_keyGuideBg:SetPosX(getScreenSizeX() - self._ui._stc_keyGuideBg:GetSizeX() - 150)
  elseif _ContentsOption_CH_GameType == true then
    if getScreenSizeX() / 3 < self._keyGuideX then
      local ratioX = getScreenSizeX() / 1920 / 3
      local ratioY = getScreenSizeY() / 1080 / 3
      self._ui._stc_keyGuideBg:SetSize(self._keyGuideX * ratioX, self._keyGuideY * ratioY)
      self._ui._stc_keyGuideBg:ComputePos()
      self._ui._stc_keyGuideBg:SetPosX(getScreenSizeX() - self._keyGuideX)
    else
      self._ui._stc_keyGuideBg:SetPosX(getScreenSizeX() - self._ui._stc_keyGuideBg:GetSizeX() - 150)
    end
  else
    self._ui._stc_keyGuideBg:SetPosX(getScreenSizeX() - self._ui._stc_keyGuideBg:GetSizeX() - 250)
  end
end
function Panel_tutorial_KeyViewerUpdate(delta)
  if PaGlobal_SequenceTutorial == nil then
    return
  end
  PaGlobal_SequenceTutorial:updateKeyInputUI()
  PaGlobal_SequenceTutorial:updateCameraInputUI()
  PaGlobal_SequenceTutorial:updateKeyGuideDesc(delta)
end
function PaGlobal_SequenceTutorial:keyGuideSubSetAlpha(alpha)
  for k, v in pairs(self._ui._keyGuideSubChild) do
    if v ~= nil then
      v:SetAlpha(alpha)
      v:SetFontAlpha(alpha)
    end
  end
end
function PaGlobal_SequenceTutorial:updateKeyGuideDesc(delta)
  if self._ui._stc_keyGuideSub == nil then
    return
  end
  if self._ui._stc_keyGuideSub:GetShow() == true then
    if IsSelfPlayerWaitAction() == false then
      self._ui._stc_keyGuideSub:SetShow(false)
      if self._isConsole == true then
        self._ui._keyGuideSubChild._stc_Console_Left:SetShow(false)
        self._ui._keyGuideSubChild._stc_Console_Right:SetShow(false)
        self._ui._keyGuideSubChild._stc_Console_Btn_D:SetShow(false)
        self._ui._keyGuideSubChild._stc_Console_Btn_R:SetShow(false)
        self._ui._keyGuideSubChild._stc_Console_Move:SetShow(false)
      end
      return
    end
    self._keyGuideSubTick = self._keyGuideSubTick + delta
    if self._keyGuideSubTick < 1.5 then
      return
    end
    self._keyGuideSubAlpha = self._keyGuideSubAlpha + delta
    if self._keyGuideSubAlpha > 1 then
      self._keyGuideSubAlpha = 1
    end
    self:keyGuideSubSetAlpha(self._keyGuideSubAlpha)
    if self._keyGuideSubAlpha >= 1 then
      self._ui._stc_keyGuideSub:SetShow(true)
      if self._isConsole == true then
        self._ui._keyGuideSubChild._stc_Console_Left:SetShow(true)
        self._ui._keyGuideSubChild._stc_Console_Right:SetShow(true)
        self._ui._keyGuideSubChild._stc_Console_Btn_D:SetShow(true)
        self._ui._keyGuideSubChild._stc_Console_Btn_R:SetShow(true)
        self._ui._keyGuideSubChild._stc_Console_Move:SetShow(true)
      end
    end
  elseif IsSelfPlayerWaitAction() == true then
    self._keyGuideSubTick = 0
    self._keyGuideSubAlpha = 0
    self:keyGuideSubSetAlpha(self._keyGuideSubAlpha)
    self._ui._stc_keyGuideSub:SetShow(true)
    if self._isConsole == true then
      self._ui._keyGuideSubChild._stc_Console_Left:SetShow(true)
      self._ui._keyGuideSubChild._stc_Console_Right:SetShow(true)
      self._ui._keyGuideSubChild._stc_Console_Btn_D:SetShow(true)
      self._ui._keyGuideSubChild._stc_Console_Btn_R:SetShow(true)
      self._ui._keyGuideSubChild._stc_Console_Move:SetShow(true)
    end
    return
  end
end
function PaGlobal_SequenceTutorial:updateKeyInputUI()
  if Panel_SequenceTutorial_Quest == nil then
    return
  end
  for key, value in pairs(self._ui._keyToVirtualKey) do
    local isPressValue1 = keyCustom_IsPressed_Action(value._value)
    local isPressValue2 = true
    if value._value2 ~= nil then
      isPressValue2 = keyCustom_IsPressed_Action(value._value2)
    end
    if self._isConsole == true then
      local isMoveFront = value._value == __eActionInputType_MoveFront and value._value2 == nil
      local isMoveLeft = value._value == __eActionInputType_MoveLeft and value._value2 == nil
      local isMoveBack = value._value == __eActionInputType_MoveBack and value._value2 == nil
      local isMoveRight = value._value == __eActionInputType_MoveRight and value._value2 == nil
      if isMoveFront == true then
        local isMoveFrontLeft = keyCustom_IsPressed_Action(__eActionInputType_MoveFront) == true and keyCustom_IsPressed_Action(__eActionInputType_MoveLeft) == true
        local isMoveFrontRight = keyCustom_IsPressed_Action(__eActionInputType_MoveFront) == true and keyCustom_IsPressed_Action(__eActionInputType_MoveRight) == true
        if isMoveFrontLeft == true or isMoveFrontRight == true then
          isPressValue1 = false
          isPressValue2 = false
        end
      elseif isMoveLeft == true then
        local isMoveFrontLeft = keyCustom_IsPressed_Action(__eActionInputType_MoveFront) == true and keyCustom_IsPressed_Action(__eActionInputType_MoveLeft) == true
        local isMoveBackLeft = keyCustom_IsPressed_Action(__eActionInputType_MoveBack) == true and keyCustom_IsPressed_Action(__eActionInputType_MoveLeft) == true
        if isMoveFrontLeft == true or isMoveBackLeft == true then
          isPressValue1 = false
          isPressValue2 = false
        end
      elseif isMoveBack == true then
        local isMoveBackLeft = keyCustom_IsPressed_Action(__eActionInputType_MoveBack) == true and keyCustom_IsPressed_Action(__eActionInputType_MoveLeft) == true
        local isMoveBackRight = keyCustom_IsPressed_Action(__eActionInputType_MoveBack) == true and keyCustom_IsPressed_Action(__eActionInputType_MoveRight) == true
        if isMoveBackLeft == true or isMoveBackRight == true then
          isPressValue1 = false
          isPressValue2 = false
        end
      elseif isMoveRight == true then
        local isMoveFrontRight = keyCustom_IsPressed_Action(__eActionInputType_MoveFront) == true and keyCustom_IsPressed_Action(__eActionInputType_MoveRight) == true
        local isMoveBackRight = keyCustom_IsPressed_Action(__eActionInputType_MoveBack) == true and keyCustom_IsPressed_Action(__eActionInputType_MoveRight) == true
        if isMoveFrontRight == true or isMoveBackRight == true then
          isPressValue1 = false
          isPressValue2 = false
        end
      end
    end
    if isPressValue1 == true and isPressValue2 == true then
      if value._on ~= nil then
        value._on:SetAlpha(1)
      end
      if value._off ~= nil then
        value._off:SetAlpha(0)
      end
    else
      if value._on ~= nil then
        value._on:SetAlpha(0)
      end
      if value._off ~= nil then
        value._off:SetAlpha(1)
      end
    end
  end
end
function PaGlobal_SequenceTutorial:updateCameraInputUI()
  if Panel_SequenceTutorial_Quest == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  for key, value in pairs(self._ui._cameraMove) do
    local isPressValue1 = isPadPressed(value._value)
    local isPressValue2 = true
    if value._value2 ~= nil then
      isPressValue2 = isPadPressed(value._value2)
    end
    local isCameraFront = value._value == __eJoyPadInputType_RightStick_Up and value._value2 == nil
    local isCameraLeft = value._value == __eJoyPadInputType_RightStick_Left and value._value2 == nil
    local isCameraBack = value._value == __eJoyPadInputType_RightStick_Down and value._value2 == nil
    local isCameraRight = value._value == __eJoyPadInputType_RightStick_Right and value._value2 == nil
    if isCameraFront == true then
      local isCameraFrontLeft = isPadPressed(__eJoyPadInputType_RightStick_Up) == true and isPadPressed(__eJoyPadInputType_RightStick_Left) == true
      local isCameraFrontRight = isPadPressed(__eJoyPadInputType_RightStick_Up) == true and isPadPressed(__eJoyPadInputType_RightStick_Right) == true
      if isCameraFrontLeft == true or isCameraFrontRight == true then
        isPressValue1 = false
        isPressValue2 = false
      end
    elseif isCameraLeft == true then
      local isCameraFrontLeft = isPadPressed(__eJoyPadInputType_RightStick_Up) == true and isPadPressed(__eJoyPadInputType_RightStick_Left) == true
      local isCameraBackLeft = isPadPressed(__eJoyPadInputType_RightStick_Down) == true and isPadPressed(__eJoyPadInputType_RightStick_Left) == true
      if isCameraFrontLeft == true or isCameraBackLeft == true then
        isPressValue1 = false
        isPressValue2 = false
      end
    elseif isCameraBack == true then
      local isCameraBackLeft = isPadPressed(__eJoyPadInputType_RightStick_Down) == true and isPadPressed(__eJoyPadInputType_RightStick_Left) == true
      local isCameraBackRight = isPadPressed(__eJoyPadInputType_RightStick_Down) == true and isPadPressed(__eJoyPadInputType_RightStick_Right) == true
      if isCameraBackLeft == true or isCameraBackRight == true then
        isPressValue1 = false
        isPressValue2 = false
      end
    elseif isCameraRight == true then
      local isCameraFrontRight = isPadPressed(__eJoyPadInputType_RightStick_Up) == true and isPadPressed(__eJoyPadInputType_RightStick_Right) == true
      local isCameraBackRight = isPadPressed(__eJoyPadInputType_RightStick_Down) == true and isPadPressed(__eJoyPadInputType_RightStick_Right) == true
      if isCameraFrontRight == true or isCameraBackRight == true then
        isPressValue1 = false
        isPressValue2 = false
      end
    end
    if isPressValue1 == true and isPressValue2 == true then
      if value._on ~= nil then
        value._on:SetAlpha(1)
      end
    elseif value._on ~= nil then
      value._on:SetAlpha(0)
    end
  end
end
