Panel_ConsoleKeyGuide:SetShow(_ContentsGroup_UsePadSnapping)
local _panel = Panel_ConsoleKeyGuide
local _actionType = CppEnums.ActionInputType
local KEYGUIDETYPE = Defines.ConsoleKeyGuideType
local ConsoleKeyGuide = {
  _ui = {
    _keyGuide = {}
  },
  _isChange = false,
  _glowFontColor = 4278190080,
  _maxConsoleGuideType = 0,
  _gapY = 40,
  _gapX = 45,
  _gapIconX = 15,
  _specifyGuideState = nil,
  _manualGuideState = nil,
  _screenShotGuideState = false,
  _currentState = nil,
  _actionKeyGuideType = nil,
  _uiModeKeyGuideType = nil,
  _isShowKeyGuide = false,
  _prevActionKeyGuideType = nil,
  _isSearchMode = false
}
local _consoleUIIconName = {
  buttonA = 0,
  buttonX = 1,
  buttonY = 2,
  buttonB = 3,
  buttonRSC = 4,
  buttonLSC = 5,
  buttonRSM = 6,
  buttonLSM = 7,
  buttonLB = 8,
  buttonRB = 9,
  buttonLT = 10,
  buttonRT = 11,
  buttonStart = 12,
  IconPlus = 13,
  IconOr = 14,
  buttonDpad = 15,
  buttonDpadUp = 16,
  buttonDpadDown = 17,
  buttonDpadLeft = 18,
  buttonDpadRight = 19,
  buttonLSLeftRight = 20,
  buttonLSUpDown = 21,
  buttonRSLeftRight = 22,
  buttonLSDown = 23
}
local _consoleUIIconUV = {
  [0] = {
    x1 = 1,
    y1 = 1,
    x2 = 45,
    y2 = 45
  },
  {
    x1 = 136,
    y1 = 1,
    x2 = 180,
    y2 = 45
  },
  {
    x1 = 46,
    y1 = 1,
    x2 = 90,
    y2 = 45
  },
  {
    x1 = 91,
    y1 = 1,
    x2 = 135,
    y2 = 45
  },
  {
    x1 = 46,
    y1 = 91,
    x2 = 90,
    y2 = 135
  },
  {
    x1 = 1,
    y1 = 91,
    x2 = 45,
    y2 = 135
  },
  {
    x1 = 91,
    y1 = 46,
    x2 = 135,
    y2 = 90
  },
  {
    x1 = 136,
    y1 = 46,
    x2 = 180,
    y2 = 90
  },
  {
    x1 = 91,
    y1 = 136,
    x2 = 135,
    y2 = 180
  },
  {
    x1 = 136,
    y1 = 136,
    x2 = 180,
    y2 = 180
  },
  {
    x1 = 46,
    y1 = 181,
    x2 = 90,
    y2 = 225
  },
  {
    x1 = 1,
    y1 = 181,
    x2 = 45,
    y2 = 225
  },
  {
    x1 = 46,
    y1 = 46,
    x2 = 90,
    y2 = 90
  },
  {
    x1 = 91,
    y1 = 181,
    x2 = 103,
    y2 = 225
  },
  {
    x1 = 104,
    y1 = 181,
    x2 = 116,
    y2 = 225
  },
  {
    x1 = 181,
    y1 = 181,
    x2 = 225,
    y2 = 225
  },
  {
    x1 = 181,
    y1 = 136,
    x2 = 225,
    y2 = 180
  },
  {
    x1 = 181,
    y1 = 46,
    x2 = 225,
    y2 = 90
  },
  {
    x1 = 181,
    y1 = 91,
    x2 = 225,
    y2 = 135
  },
  {
    x1 = 181,
    y1 = 1,
    x2 = 225,
    y2 = 45
  },
  {
    x1 = 91,
    y1 = 91,
    x2 = 135,
    y2 = 135
  },
  {
    x1 = 136,
    y1 = 91,
    x2 = 180,
    y2 = 135
  },
  {
    x1 = 1,
    y1 = 136,
    x2 = 45,
    y2 = 180
  },
  {
    x1 = 271,
    y1 = 46,
    x2 = 315,
    y2 = 90
  }
}
local _customActionTypeString = {
  [4] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_INTERFACE_ACTION_Mouse_LB_2"),
  [5] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_INTERFACE_ACTION_Mouse_RB_2"),
  [6] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_INTERFACE_ACTION_Shift_1"),
  [7] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionJump"),
  [8] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionInteraction"),
  [12] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionCrouchOrSkill"),
  [13] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionGrabOrGuard"),
  [14] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionKick")
}
function ConsoleKeyGuide:init()
  self._ui.guideBg = UI.getChildControl(_panel, "Static_KeyGuideBg")
  self._ui.consoleUITemplate = UI.getChildControl(self._ui.guideBg, "Static_ConsoleKey")
  self._ui.keyStringTemplate = UI.getChildControl(self._ui.guideBg, "StaticText_KeyDesc")
  self:updateGuide()
  self:hideAllGuide()
  PaGlobalFunc_ConsoleKeyGuide_SetCommonKeyGuideInit()
  self:registEvent()
end
function ConsoleKeyGuide:registEvent()
  registerEvent("onScreenResize", "PaGlobalFunc_ConsoleKeyGuide_SetPos")
  registerEvent("FromClient_RenderModeChangeState", "FromClient_RenderModeChangeState_ConsoleKeyGuide")
  registerEvent("EventProcessorInputModeChange", "PaGlobalFunc_ConsoleKeyGuide_ChangeInputMode")
  registerEvent("EventSelfPlayerRideOn", "PaGlobalFunc_ConsoleKeyGuide_SetRideState()")
  registerEvent("EventSelfPlayerRideOff", "PaGlobalFunc_ConsoleKeyGuide_SetRideState()")
  registerEvent("FromClient_NotifyObserverModeStart", "FromClient_NotifyObserverModeStart")
  registerEvent("FromClient_NotifyObserverModeEnd", "FromClient_PanelInteraction_NotifyObserverModeEnd")
end
function PaGlobalFunc_ConsoleKeyGuide_SetCommonKeyGuideInit()
  local inputMode = getInputMode()
  if CppEnums.EProcessorInputMode.eProcessorInputMode_GameMode == inputMode then
    PaGlobalFunc_ConsoleKeyGuide_SetGuide(Defines.ConsoleKeyGuideType.common)
    PaGlobalFunc_ConsoleKeyGuide_SetActionKeyGuide(Defines.ConsoleKeyGuideType.common)
  end
end
function FromClient_NotifyObserverModeStart()
  ConsoleKeyGuide._prevActionKeyGuideType = ConsoleKeyGuide._actionKeyGuideType
  PaGlobalFunc_ConsoleKeyGuide_SetGuide(Defines.ConsoleKeyGuideType.observeMode)
  PaGlobalFunc_ConsoleKeyGuide_SetActionKeyGuide(Defines.ConsoleKeyGuideType.observeMode)
  ConsoleKeyGuide._isSearchMode = true
end
function PaGlobalFunc_ConsoleKeyGuide_SolareObserverInit()
  ConsoleKeyGuide._prevActionKeyGuideType = ConsoleKeyGuide._actionKeyGuideType
  PaGlobalFunc_ConsoleKeyGuide_SetGuide(Defines.ConsoleKeyGuideType.solareObserver)
  PaGlobalFunc_ConsoleKeyGuide_SetActionKeyGuide(Defines.ConsoleKeyGuideType.solareObserver)
end
function FromClient_PanelInteraction_NotifyObserverModeEnd()
  PaGlobalFunc_ConsoleKeyGuide_PopGuide()
  PaGlobalFunc_ConsoleKeyGuide_SetActionKeyGuide(ConsoleKeyGuide._prevActionKeyGuideType)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if true == selfPlayer:isDead() then
    PaGlobalFunc_DeadMessage_All_Open()
  end
  ConsoleKeyGuide._isSearchMode = false
end
function ConsoleKeyGuide:setGlowFont(control)
  control:useGlowFont(true, "RealFont_22_Glow", self._glowFontColor)
end
function ConsoleKeyGuide:setGuide(currentState)
  if nil == currentState then
    ConsoleKeyGuide:hideAllGuide()
    return
  end
  if KEYGUIDETYPE.undefined == currentState then
    ConsoleKeyGuide:hideAllGuide()
    return
  end
  for index = 0, self._maxConsoleGuideType - 1 do
    if nil ~= self._ui._keyGuide[index] then
      self._ui._keyGuide[index].guideBg:SetShow(index == currentState)
    end
  end
  self._isShowKeyGuide = true
end
function ConsoleKeyGuide:pushStack(state)
  self:setGuide(state)
end
function ConsoleKeyGuide:popStack()
  self:hideAllGuide()
end
function ConsoleKeyGuide:refreshGuide()
  local inputMode = getInputMode()
  PaGlobalFunc_ConsoleKeyGuide_SetPos()
  if CppEnums.EProcessorInputMode.eProcessorInputMode_GameMode == inputMode then
    if nil == self._actionKeyGuideType then
      self:setGuide(KEYGUIDETYPE.common)
    else
      self:setGuide(self._actionKeyGuideType)
    end
  else
    self:setGuide(self._uiModeKeyGuideType)
  end
end
function ConsoleKeyGuide:hideAllGuide()
  for index = 0, self._maxConsoleGuideType - 1 do
    if nil ~= self._ui._keyGuide[index] and true == self._ui._keyGuide[index].guideBg:GetShow() then
      self._ui._keyGuide[index].guideBg:SetShow(false)
    end
  end
  self._isShowKeyGuide = false
end
function PaGlobalFunc_ConsoleKeyGuide_GetShowKeyGuide()
  return ConsoleKeyGuide._isShowKeyGuide
end
function ConsoleKeyGuide:updateGuide()
  self._ui._keyGuide[KEYGUIDETYPE.screenshotGuide] = self:makeNewGuide(KEYGUIDETYPE.screenshotGuide)
  self._ui._keyGuide[KEYGUIDETYPE.common] = self:makeNewGuide(KEYGUIDETYPE.common)
  self._ui._keyGuide[KEYGUIDETYPE.observeMode] = self:makeNewGuide(KEYGUIDETYPE.observeMode)
  self._ui._keyGuide[KEYGUIDETYPE.searchMode] = self:makeNewGuide(KEYGUIDETYPE.searchMode)
  self._ui._keyGuide[KEYGUIDETYPE.pearlShop] = self:makeNewGuide(KEYGUIDETYPE.pearlShop)
  self._ui._keyGuide[KEYGUIDETYPE.crouch] = self:makeNewGuide(KEYGUIDETYPE.crouch)
  self._ui._keyGuide[KEYGUIDETYPE.creep] = self:makeNewGuide(KEYGUIDETYPE.creep)
  self._ui._keyGuide[KEYGUIDETYPE.rideHorse] = self:makeNewGuide(KEYGUIDETYPE.rideHorse)
  self._ui._keyGuide[KEYGUIDETYPE.rideShip] = self:makeNewGuide(KEYGUIDETYPE.rideShip)
  self._ui._keyGuide[KEYGUIDETYPE.matchlock] = self:makeNewGuide(KEYGUIDETYPE.matchlock)
  self._ui._keyGuide[KEYGUIDETYPE.packing] = self:makeNewGuide(KEYGUIDETYPE.packing)
  self._ui._keyGuide[KEYGUIDETYPE.rideCarriage] = self:makeNewGuide(KEYGUIDETYPE.rideCarriage)
  self._ui._keyGuide[KEYGUIDETYPE.cannon] = self:makeNewGuide(KEYGUIDETYPE.cannon)
  self._ui._keyGuide[KEYGUIDETYPE.shipCannon] = self:makeNewGuide(KEYGUIDETYPE.shipCannon)
  self._ui._keyGuide[KEYGUIDETYPE.flameTower] = self:makeNewGuide(KEYGUIDETYPE.flameTower)
  self._ui._keyGuide[KEYGUIDETYPE.hwacha] = self:makeNewGuide(KEYGUIDETYPE.hwacha)
  self._ui._keyGuide[KEYGUIDETYPE.upgradeHwacha] = self:makeNewGuide(KEYGUIDETYPE.upgradeHwacha)
  self._ui._keyGuide[KEYGUIDETYPE.battle] = self:makeNewGuide(KEYGUIDETYPE.battle)
  self._ui._keyGuide[KEYGUIDETYPE.cattlegate] = self:makeNewGuide(KEYGUIDETYPE.cattlegate)
  self._ui._keyGuide[KEYGUIDETYPE.elephantHead] = self:makeNewGuide(KEYGUIDETYPE.elephantHead)
  self._ui._keyGuide[KEYGUIDETYPE.elephantBack] = self:makeNewGuide(KEYGUIDETYPE.elephantBack)
  self._ui._keyGuide[KEYGUIDETYPE.rideShipDriver] = self:makeNewGuide(KEYGUIDETYPE.rideShipDriver)
  self._ui._keyGuide[KEYGUIDETYPE.rideRepairableCarriage] = self:makeNewGuide(KEYGUIDETYPE.rideRepairableCarriage)
  self._ui._keyGuide[KEYGUIDETYPE.rideShyDonkey] = self:makeNewGuide(KEYGUIDETYPE.rideShyDonkey)
  self._ui._keyGuide[KEYGUIDETYPE.rideBabyElephant] = self:makeNewGuide(KEYGUIDETYPE.rideBabyElephant)
  self._ui._keyGuide[KEYGUIDETYPE.rideCamel] = self:makeNewGuide(KEYGUIDETYPE.rideCamel)
  self._ui._keyGuide[KEYGUIDETYPE.rideDonkey] = self:makeNewGuide(KEYGUIDETYPE.rideDonkey)
  self._ui._keyGuide[KEYGUIDETYPE.practiceCannon] = self:makeNewGuide(KEYGUIDETYPE.practiceCannon)
  self._ui._keyGuide[KEYGUIDETYPE.cameraMode] = self:makeNewGuide(KEYGUIDETYPE.cameraMode)
  self._ui._keyGuide[KEYGUIDETYPE.upgradeFlameTower] = self:makeNewGuide(KEYGUIDETYPE.upgradeFlameTower)
  self._ui._keyGuide[KEYGUIDETYPE.train] = self:makeNewGuide(KEYGUIDETYPE.train)
  self._ui._keyGuide[KEYGUIDETYPE.solareObserver] = self:makeNewGuide(KEYGUIDETYPE.solareObserver)
end
function ConsoleKeyGuide:makeNewGuide(state_)
  local newGuide = {}
  newGuide.guideBg = UI.createAndCopyBasePropertyControl(_panel, "Static_KeyGuideBg", _panel, "GuideBg_" .. state_)
  newGuide.guideData = {}
  newGuide.guideIdx = 0
  newGuide.state = state_
  if state_ == KEYGUIDETYPE.battle then
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonStart
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MENU_RENEW_MENU_TITLE"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Attack2, PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_5"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Attack1, PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_4"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Jump, PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_7"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Dash, PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_XBOX_FASTRUN"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_WeaponInOut, PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_10"))
  elseif state_ == KEYGUIDETYPE.screenshotGuide then
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonB
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CLOSE"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonY
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CUSTOMSCREENSHOT_SCREENSHOT_RENEW"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRB
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CUSTOMSCREENSHOT_SCREENSHOT_RENEW_INCREASE"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRT
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CUSTOMSCREENSHOT_SCREENSHOT_RENEW_DECREASE"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSM
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_NPCSHOP_KEY_MOVE"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRSM
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_KEYGUIDE_CAMERA"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRSM,
      _consoleUIIconName.IconPlus,
      _consoleUIIconName.buttonLT
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_KEYGUIDE_ZOOM"))
  elseif state_ == KEYGUIDETYPE.common then
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonStart
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MENU_RENEW_MENU_TITLE"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Jump, PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_7"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Dash, PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_XBOX_FASTRUN"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRSM
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_KEYGUIDE_CAMERA"))
    if true == _ContentsGroup_PadCameraMoveMode then
      self:addGuide(newGuide, {
        _consoleUIIconName.buttonRSC
      }, PAGetString(Defines.StringSheet_GAME, "LUA_CAMERA_MODE_HOLD_RS"))
    end
    self:addCustomGuide(newGuide, _actionType.ActionInputType_WeaponInOut, PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_10"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSC
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionAutoRun"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_CrouchOrSkill, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_Action_CrouchOrStandUp"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Dash, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_INTERACTION"))
  elseif state_ == KEYGUIDETYPE.crouch then
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSM,
      _consoleUIIconName.IconPlus,
      _consoleUIIconName.buttonLT
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GLOBALMANUAL_RENEW_Action_ROLL"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSC
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionAutoRun"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Jump, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GLOBALMANUAL_RENEW_Action_CREEP"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_CrouchOrSkill, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GLOBALMANUAL_RENEW_Action_STANDUP"))
  elseif state_ == KEYGUIDETYPE.creep then
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Jump, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_INTERFACE_ACTION_Q_1"))
  elseif state_ == KEYGUIDETYPE.rideHorse then
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Jump, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionJump"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Dash, PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_XBOX_FASTRUN"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSC
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionAutoRun"))
    if nil ~= HorseMP_CheckAutoSpeedButton and true == HorseMP_CheckAutoSpeedButton() then
      local text = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_HORSE_CONSOLE")
      self:addGuide(newGuide, {
        _consoleUIIconName.buttonRSC
      }, text)
    end
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
    local datalist = {
      {
        _isCustomKey = true,
        _keyType = _actionType.ActionInputType_Interaction
      },
      {
        _isCustomKey = false,
        _keyType = _consoleUIIconName.IconPlus
      },
      {
        _isCustomKey = true,
        _keyType = _actionType.ActionInputType_MoveBack
      }
    }
    self:addCustomOrNotGuideWitList(newGuide, datalist, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_VEHICLE_RIDE_IMMEDIATELY_OFF"))
  elseif state_ == KEYGUIDETYPE.rideShip then
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSC
    }, PAGetString(Defines.StringSheet_GAME, "LUA_KEYGUIDE_AUTORUN"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
  elseif state_ == KEYGUIDETYPE.rideShipDriver then
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSC
    }, PAGetString(Defines.StringSheet_GAME, "LUA_KEYGUIDE_AUTORUN"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
    if true == _ContentsGroup_OceanCurrent then
      local string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILCONTROL_SHORTKEY") .. " / " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FISHING_SPREAD")
      self:addGuide(newGuide, {
        _consoleUIIconName.buttonRSC
      }, string)
      self:addGuide(newGuide, {
        _consoleUIIconName.buttonRSC,
        _consoleUIIconName.IconPlus,
        _consoleUIIconName.buttonLT
      }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPFASTMOVE_AUTOUSE"))
    end
    if _ContentsGroup_EmployeePresetJob == true then
      self:addGuide(newGuide, {
        _consoleUIIconName.buttonRSC,
        _consoleUIIconName.IconPlus,
        _consoleUIIconName.buttonRT
      }, PAGetString(Defines.StringSheet_GAME, "LUA_CAPTAIN_AUTO_USE_REPAIR_NAME"))
    end
  elseif state_ == KEYGUIDETYPE.observeMode then
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonB
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CLOSE"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRT
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WATCHINGCOMMAND_CAMERASPEED_FAST"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRB
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WATCHINGCOMMAND_CAMERASPEED_LOW"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonX
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WATCHINGMODE_MOVE_CAMERA2"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSM,
      _consoleUIIconName.IconPlus,
      _consoleUIIconName.buttonA
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WATCHINGMODE_MOVE_CAMERA0"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSM,
      _consoleUIIconName.IconPlus,
      _consoleUIIconName.buttonLT
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WATCHINGCOMMAND_CAMERASPEED_FAST"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRSM
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CUSTERMIZING_KEYGUIDE_2"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSM
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WATCHINGMODE_MOVE_CAMERA1"))
  elseif state_ == KEYGUIDETYPE.searchMode then
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRSM,
      _consoleUIIconName.IconPlus,
      _consoleUIIconName.buttonLT
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_KEYGUIDE_ZOOM"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRSM
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_UI_SETTING_CHKBTN_FIELDVIEW"))
  elseif state_ == KEYGUIDETYPE.rideCarriage then
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSC
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionAutoRun"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
    local datalist = {
      {
        _isCustomKey = true,
        _keyType = _actionType.ActionInputType_Interaction
      },
      {
        _isCustomKey = false,
        _keyType = _consoleUIIconName.IconPlus
      },
      {
        _isCustomKey = true,
        _keyType = _actionType.ActionInputType_MoveBack
      }
    }
    self:addCustomOrNotGuideWitList(newGuide, datalist, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_VEHICLE_RIDE_IMMEDIATELY_OFF"))
  elseif state_ == KEYGUIDETYPE.matchlock then
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Kick, PAGetString(Defines.StringSheet_GAME, "LUA_KEYGUIDE_F_BLACKSPIRIT"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Attack1, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_FIRE"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_CrouchOrSkill, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_Action_CrouchOrStandUp"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Dash, PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_XBOX_FASTRUN"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Attack2, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_RELOAD"))
  elseif state_ == KEYGUIDETYPE.packing then
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_ACTION_PUTDOWN"))
  elseif state_ == KEYGUIDETYPE.pearlShop then
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonDpad,
      _consoleUIIconName.IconPlus,
      _consoleUIIconName.buttonX
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WATCHINGMODE_MOVE_CAMERA1"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRSM,
      _consoleUIIconName.IconPlus,
      _consoleUIIconName.buttonLT
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_KEYGUIDE_ZOOM"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRSM
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CUSTERMIZING_KEYGUIDE_2"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRT
    }, PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_CHARACTER_ACTION"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonY,
      _consoleUIIconName.IconPlus,
      _consoleUIIconName.buttonLT
    }, PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_SUNICON"))
    if true == _ContentsGroup_PearlShopMileage and nil ~= PaGlobal_CashMileage_IsOpenCheck and true == PaGlobal_CashMileage_IsOpenCheck() then
      self:addGuide(newGuide, {
        _consoleUIIconName.buttonY,
        _consoleUIIconName.IconPlus,
        _consoleUIIconName.buttonRT
      }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_MILEAGE_TITLE"))
    end
    if _ContentsGroup_PearlShopMoonBlessingRenew == true and nil ~= PaGlobal_MoonBlessingRenew_IsOpenCheck and true == PaGlobal_MoonBlessingRenew_IsOpenCheck() then
      self:addGuide(newGuide, {
        _consoleUIIconName.buttonY,
        _consoleUIIconName.IconPlus,
        _consoleUIIconName.buttonRT
      }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_MILEAGE_TITLE"))
    end
  elseif state_ == KEYGUIDETYPE.shipCannon then
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRB,
      _consoleUIIconName.IconPlus,
      _consoleUIIconName.buttonLT
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_FIRE"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Dash, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_AIM"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
  elseif state_ == KEYGUIDETYPE.flameTower then
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Jump, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_FIRE"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRSLeftRight
    }, PAGetString(Defines.StringSheet_RESOURCE, "UI_CUSTOMIZATION_TEXTUREMENU_STCTXT_ROTATE"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
  elseif state_ == KEYGUIDETYPE.hwacha then
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Attack1, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SIEGEARROWTOWER_COMMAND_SKILL"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSUpDown,
      _consoleUIIconName.IconPlus,
      _consoleUIIconName.buttonLT
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_AIM"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSLeftRight
    }, PAGetString(Defines.StringSheet_RESOURCE, "UI_CUSTOMIZATION_TEXTUREMENU_STCTXT_ROTATE"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
  elseif state_ == KEYGUIDETYPE.upgradeHwacha then
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Attack1, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SIEGEARROWTOWER_COMMAND_SKILL"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonB,
      _consoleUIIconName.IconPlus,
      _consoleUIIconName.buttonLT
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SIEGEARROWUPGRADETOWER_COMMAND_SKILL"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSUpDown,
      _consoleUIIconName.IconPlus,
      _consoleUIIconName.buttonLT
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_AIM"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSLeftRight
    }, PAGetString(Defines.StringSheet_RESOURCE, "UI_CUSTOMIZATION_TEXTUREMENU_STCTXT_ROTATE"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
  elseif state_ == KEYGUIDETYPE.cattlegate then
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_ACTION_PUTDOWN"))
    if _ContentsGroup_ProjectAbyssOne == true and ToClient_isInAbyssOne() == true then
      self:addGuide(newGuide, {
        _consoleUIIconName.buttonRT
      }, PAGetString(Defines.StringSheet_GAME, "LUA_COMMANDGUIDE_DESC_CRANK_UP"))
      self:addGuide(newGuide, {
        _consoleUIIconName.buttonRT
      }, PAGetString(Defines.StringSheet_GAME, "LUA_COMMANDGUIDE_DESC_CRANK_DOWN"))
    else
      self:addGuide(newGuide, {
        _consoleUIIconName.buttonRT
      }, PAGetString(Defines.StringSheet_GAME, "LUA_COMMANDGUIDE_DESC_CATTLEGATE_DOWN"))
      self:addGuide(newGuide, {
        _consoleUIIconName.buttonRB
      }, PAGetString(Defines.StringSheet_GAME, "LUA_COMMANDGUIDE_DESC_CATTLEGATE_UP"))
    end
  elseif state_ == KEYGUIDETYPE.elephantHead then
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Dash, PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_XBOX_FASTRUN"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Attack1, PAGetString(Defines.StringSheet_GAME, "LUA_KEYGUIDE_ELEPHANTATTAK1"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Attack2, PAGetString(Defines.StringSheet_GAME, "LUA_KEYGUIDE_ELEPHANTATTAK2"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
  elseif state_ == KEYGUIDETYPE.elephantBack then
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Attack1, PAGetString(Defines.StringSheet_GAME, "LUA_KEYGUIDE_SPEARACTION1"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Attack2, PAGetString(Defines.StringSheet_GAME, "LUA_KEYGUIDE_SPEARACTION2"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
  elseif state_ == KEYGUIDETYPE.rideRepairableCarriage then
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSC
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionAutoRun"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
    local datalist = {
      {
        _isCustomKey = true,
        _keyType = _actionType.ActionInputType_Interaction
      },
      {
        _isCustomKey = false,
        _keyType = _consoleUIIconName.IconPlus
      },
      {
        _isCustomKey = true,
        _keyType = _actionType.ActionInputType_MoveBack
      }
    }
    self:addCustomOrNotGuideWitList(newGuide, datalist, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_VEHICLE_RIDE_IMMEDIATELY_OFF"))
    if nil ~= HorseMP_CheckAutoSpeedButton and true == HorseMP_CheckAutoSpeedButton() then
      text = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_CARRIAGE")
      self:addGuide(newGuide, {
        _consoleUIIconName.buttonRSC
      }, text)
    end
  elseif state_ == KEYGUIDETYPE.rideShyDonkey then
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Jump, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionJump"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Dash, PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_XBOX_FASTRUN"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSC
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionAutoRun"))
    if nil ~= HorseMP_CheckAutoSpeedButton and true == HorseMP_CheckAutoSpeedButton() then
      local text = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_DONKEY")
      self:addGuide(newGuide, {
        _consoleUIIconName.buttonRSC
      }, text)
    end
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
    local datalist = {
      {
        _isCustomKey = true,
        _keyType = _actionType.ActionInputType_Interaction
      },
      {
        _isCustomKey = false,
        _keyType = _consoleUIIconName.IconPlus
      },
      {
        _isCustomKey = true,
        _keyType = _actionType.ActionInputType_MoveBack
      }
    }
    self:addCustomOrNotGuideWitList(newGuide, datalist, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_VEHICLE_RIDE_IMMEDIATELY_OFF"))
  elseif state_ == KEYGUIDETYPE.rideBabyElephant then
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Jump, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionJump"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Dash, PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_XBOX_FASTRUN"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSC
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionAutoRun"))
    if nil ~= HorseMP_CheckAutoSpeedButton and true == HorseMP_CheckAutoSpeedButton() then
      local text = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_ELEPHANT")
      self:addGuide(newGuide, {
        _consoleUIIconName.buttonRSC
      }, text)
    end
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
    local datalist = {
      {
        _isCustomKey = true,
        _keyType = _actionType.ActionInputType_Interaction
      },
      {
        _isCustomKey = false,
        _keyType = _consoleUIIconName.IconPlus
      },
      {
        _isCustomKey = true,
        _keyType = _actionType.ActionInputType_MoveBack
      }
    }
    self:addCustomOrNotGuideWitList(newGuide, datalist, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_VEHICLE_RIDE_IMMEDIATELY_OFF"))
  elseif state_ == KEYGUIDETYPE.rideCamel then
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Jump, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionJump"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Dash, PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_XBOX_FASTRUN"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSC
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionAutoRun"))
    if nil ~= HorseMP_CheckAutoSpeedButton and true == HorseMP_CheckAutoSpeedButton() then
      local text = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_CAMEL")
      self:addGuide(newGuide, {
        _consoleUIIconName.buttonRSC
      }, text)
    end
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
    local datalist = {
      {
        _isCustomKey = true,
        _keyType = _actionType.ActionInputType_Interaction
      },
      {
        _isCustomKey = false,
        _keyType = _consoleUIIconName.IconPlus
      },
      {
        _isCustomKey = true,
        _keyType = _actionType.ActionInputType_MoveBack
      }
    }
    self:addCustomOrNotGuideWitList(newGuide, datalist, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_VEHICLE_RIDE_IMMEDIATELY_OFF"))
  elseif state_ == KEYGUIDETYPE.rideDonkey then
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Jump, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionJump"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Dash, PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_XBOX_FASTRUN"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSC
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionAutoRun"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
    local datalist = {
      {
        _isCustomKey = true,
        _keyType = _actionType.ActionInputType_Interaction
      },
      {
        _isCustomKey = false,
        _keyType = _consoleUIIconName.IconPlus
      },
      {
        _isCustomKey = true,
        _keyType = _actionType.ActionInputType_MoveBack
      }
    }
    self:addCustomOrNotGuideWitList(newGuide, datalist, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_VEHICLE_RIDE_IMMEDIATELY_OFF"))
  elseif state_ == KEYGUIDETYPE.practiceCannon then
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Dash, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_AIM"))
    local angleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_ANGLEHIGH") .. "/" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_ANGLELOW")
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSUpDown,
      _consoleUIIconName.IconPlus,
      _consoleUIIconName.buttonLT
    }, angleString)
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Attack1, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_FIRE"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
  elseif state_ == KEYGUIDETYPE.cannon then
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Attack1, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_FIRE"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Attack2, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_CHARGE"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Kick, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_RAPIDFIRE"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_CrouchOrSkill, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_ANGLELOW"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_GrabOrGuard, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_ANGLEHIGH"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
  elseif state_ == KEYGUIDETYPE.cameraMode then
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonB
    }, PAGetString(Defines.StringSheet_GAME, "LUA_CAMERA_MODE_CLOSE_AND_SAVE"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonLSM
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_CONTROLLER_CAMERADESC_POSITIONMOVE"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRSM
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_KEYGUIDE_ZOOM"))
  elseif state_ == KEYGUIDETYPE.upgradeFlameTower then
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Jump, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_FIRE"))
    if _ContentsGroup_UpgradeFlameTower == true then
      self:addCustomGuide(newGuide, _actionType.ActionInputType_Kick, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ADVANCEDFLAMETOWER_COMMAND_SKILL"))
    end
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRSLeftRight
    }, PAGetString(Defines.StringSheet_RESOURCE, "UI_CUSTOMIZATION_TEXTUREMENU_STCTXT_ROTATE"))
    self:addCustomGuide(newGuide, _actionType.ActionInputType_Interaction, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
  elseif state_ == KEYGUIDETYPE.train then
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonY
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLEKEYGUIDE_RideOff"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRSM
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_ANGLEHIGH"))
    self:addGuide(newGuide, {
      _consoleUIIconName.buttonRB
    }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CANNON_FIRE"))
  else
    if state_ == KEYGUIDETYPE.solareObserver then
      self:addGuide(newGuide, {
        _consoleUIIconName.buttonLSC
      }, PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_WATCH_LOCK"))
      self:addGuide(newGuide, {
        _consoleUIIconName.buttonRB
      }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTANCE_WATCHINGMODE_NEXTPARTYMEMBER_FIND"))
      self:addGuide(newGuide, {
        _consoleUIIconName.buttonLB
      }, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTANCE_WATCHINGMODE_STARTWATCHING"))
    else
    end
  end
  self._maxConsoleGuideType = self._maxConsoleGuideType + 1
  return newGuide
end
function ConsoleKeyGuide:addGuide(newGuide, consoleUI_, keyString_)
  if nil == newGuide then
    return
  end
  local guideData = {}
  local tableConsoleUI = {}
  local iconGapX = -self._gapX
  for index = 1, #consoleUI_ do
    local uiIcon = UI.createAndCopyBasePropertyControl(self._ui.guideBg, "Static_ConsoleKey", newGuide.guideBg, "ConsoleKey_" .. newGuide.state .. newGuide.guideIdx .. index)
    local uiIdx = consoleUI_[index]
    local x1, y1, x2, y2 = setTextureUV_Func(uiIcon, _consoleUIIconUV[uiIdx].x1, _consoleUIIconUV[uiIdx].y1, _consoleUIIconUV[uiIdx].x2, _consoleUIIconUV[uiIdx].y2)
    uiIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    uiIcon:setRenderTexture(uiIcon:getBaseTexture())
    if uiIdx == _consoleUIIconName.IconPlus or uiIdx == _consoleUIIconName.IconOr then
      uiIcon:SetSize(12, 44)
      iconGapX = iconGapX + self._gapIconX
    else
      iconGapX = iconGapX + self._gapX
    end
    uiIcon:SetPosX(uiIcon:GetPosX() - iconGapX)
    uiIcon:SetPosY(uiIcon:GetPosY() - newGuide.guideIdx * self._gapY)
    tableConsoleUI[index] = uiIcon
  end
  local tableString = UI.createAndCopyBasePropertyControl(self._ui.guideBg, "StaticText_KeyDesc", newGuide.guideBg, "String_" .. newGuide.state .. newGuide.guideIdx)
  tableString:SetText(keyString_)
  tableString:SetPosY(tableString:GetPosY() - newGuide.guideIdx * self._gapY)
  tableString:SetTextSpan(0, -10)
  self:setGlowFont(tableString)
  guideData.uiIcon = tableConsoleUI
  guideData.keyString = tableString
  guideData.isCustomGuide = false
  newGuide.guideData[newGuide.guideIdx] = guideData
  newGuide.guideIdx = newGuide.guideIdx + 1
end
function ConsoleKeyGuide:addCustomGuide(newGuide, actionInputType, keyString_)
  if nil == newGuide then
    return
  end
  local guideData = {}
  local iconGapX = -self._gapX
  local uiIcon = UI.createAndCopyBasePropertyControl(self._ui.guideBg, "Static_ConsoleKey", newGuide.guideBg, "ConsoleKey_" .. newGuide.state .. newGuide.guideIdx .. 1)
  local uiIdx = PaGlobalFunc_ConsoleKeyGuide_ConvertActionInputTypeToIconIndex(actionInputType)
  local x1, y1, x2, y2 = setTextureUV_Func(uiIcon, _consoleUIIconUV[uiIdx].x1, _consoleUIIconUV[uiIdx].y1, _consoleUIIconUV[uiIdx].x2, _consoleUIIconUV[uiIdx].y2)
  uiIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  uiIcon:setRenderTexture(uiIcon:getBaseTexture())
  if uiIdx == _consoleUIIconName.IconPlus or uiIdx == _consoleUIIconName.IconOr then
    uiIcon:SetSize(12, 44)
    iconGapX = iconGapX + self._gapIconX
  else
    iconGapX = iconGapX + self._gapX
  end
  uiIcon:SetPosX(uiIcon:GetPosX() - iconGapX)
  uiIcon:SetPosY(uiIcon:GetPosY() - newGuide.guideIdx * self._gapY)
  local tableString = UI.createAndCopyBasePropertyControl(self._ui.guideBg, "StaticText_KeyDesc", newGuide.guideBg, "String_" .. newGuide.state .. newGuide.guideIdx)
  tableString:SetText(keyString_)
  tableString:SetPosY(tableString:GetPosY() - newGuide.guideIdx * self._gapY)
  tableString:SetTextSpan(0, -10)
  self:setGlowFont(tableString)
  guideData.actionInputType = actionInputType
  guideData.uiIcon = uiIcon
  guideData.keyString = tableString
  guideData.isCustomGuide = true
  newGuide.guideData[newGuide.guideIdx] = guideData
  newGuide.guideIdx = newGuide.guideIdx + 1
end
function ConsoleKeyGuide:addCustomOrNotGuideWitList(newGuide, keyInputDataList_, keyString_)
  if nil == newGuide then
    return
  end
  local guideData = {}
  local tableConsoleUI = {}
  local iconGapX = -self._gapX
  for index = 1, #keyInputDataList_ do
    local uiIcon = UI.createAndCopyBasePropertyControl(self._ui.guideBg, "Static_ConsoleKey", newGuide.guideBg, "ConsoleKey_" .. newGuide.state .. newGuide.guideIdx .. index)
    local uiIdx
    local keyInputData = keyInputDataList_[index]
    if keyInputData._isCustomKey == true then
      local actionInputType = keyInputData._keyType
      uiIdx = PaGlobalFunc_ConsoleKeyGuide_ConvertActionInputTypeToIconIndex(actionInputType)
    else
      uiIdx = keyInputData._keyType
    end
    local x1, y1, x2, y2 = setTextureUV_Func(uiIcon, _consoleUIIconUV[uiIdx].x1, _consoleUIIconUV[uiIdx].y1, _consoleUIIconUV[uiIdx].x2, _consoleUIIconUV[uiIdx].y2)
    uiIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    uiIcon:setRenderTexture(uiIcon:getBaseTexture())
    if keyInputData._isCustomKey == false then
      if uiIdx == _consoleUIIconName.IconPlus or uiIdx == _consoleUIIconName.IconOr then
        uiIcon:SetSize(12, 44)
        iconGapX = iconGapX + self._gapIconX
      else
        iconGapX = iconGapX + self._gapX
      end
    else
      iconGapX = iconGapX + self._gapX
    end
    uiIcon:SetPosX(uiIcon:GetPosX() - iconGapX)
    uiIcon:SetPosY(uiIcon:GetPosY() - newGuide.guideIdx * self._gapY)
    tableConsoleUI[index] = uiIcon
  end
  local tableString = UI.createAndCopyBasePropertyControl(self._ui.guideBg, "StaticText_KeyDesc", newGuide.guideBg, "String_" .. newGuide.state .. newGuide.guideIdx)
  tableString:SetText(keyString_)
  tableString:SetPosY(tableString:GetPosY() - newGuide.guideIdx * self._gapY)
  tableString:SetTextSpan(0, -10)
  self:setGlowFont(tableString)
  guideData.uiIcon = tableConsoleUI
  guideData.keyString = tableString
  guideData.isCustomGuide = false
  newGuide.guideData[newGuide.guideIdx] = guideData
  newGuide.guideIdx = newGuide.guideIdx + 1
end
function ConsoleKeyGuide:updateCustomGuide(guideData)
  if nil == guideData then
    return
  end
  if false == guideData.isCustomGuide then
    return
  end
  local actionInputType = guideData.actionInputType
  if nil == actionInputType then
    return
  end
  local uiIcon = guideData.uiIcon
  if nil == uiIcon then
    return
  end
  local uiIdx = PaGlobalFunc_ConsoleKeyGuide_ConvertActionInputTypeToIconIndex(actionInputType)
  if nil == uiIdx then
    uiIcon:SetShow(false)
    return
  end
  local x1, y1, x2, y2 = setTextureUV_Func(uiIcon, _consoleUIIconUV[uiIdx].x1, _consoleUIIconUV[uiIdx].y1, _consoleUIIconUV[uiIdx].x2, _consoleUIIconUV[uiIdx].y2)
  uiIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  uiIcon:setRenderTexture(uiIcon:getBaseTexture())
end
function ConsoleKeyGuide:getState()
  if PaGlobalFunc_SearchMode_IsSearchMode() then
    return KEYGUIDETYPE.searchMode
  end
  if true == _ContentsGroup_PadCameraMoveMode and nil ~= Panel_Widget_CameraMode_All and Panel_Widget_CameraMode_All:GetShow() then
    return KEYGUIDETYPE.cameraMode
  end
  if getInputMode() == CppEnums.EProcessorInputMode.eProcessorInputMode_GameMode then
    if PaGlobalFunc_ConsoleKeyGuide_IsSearchModeKeyGudieShow() then
      return KEYGUIDETYPE.observeMode
    elseif ToClient_isWeaponOutForConsole() then
      return KEYGUIDETYPE.battle
    else
      return nil
    end
  else
    if nil ~= Panel_Pearlshop_Category and Panel_Pearlshop_Category:GetShow() then
      return KEYGUIDETYPE.pearlShop
    end
    if nil ~= Panel_Widget_ScreenShotFrame and Panel_Widget_ScreenShotFrame:GetShow() then
      return KEYGUIDETYPE.screenshotGuide
    end
  end
  return nil
end
function FGlobal_KeyGuideTypeCheck(deltaTime)
  if true == PaGlobalFunc_ConsoleKeyGuide_IsHideGuideException() then
    ConsoleKeyGuide:hideAllGuide()
    return
  end
  local currentState = ConsoleKeyGuide:getState()
  if KEYGUIDETYPE.battle == currentState or KEYGUIDETYPE.screenshotGuide == currentState or KEYGUIDETYPE.pearlShop == currentState or KEYGUIDETYPE.cameraMode == currentState then
    ConsoleKeyGuide:setGuide(currentState)
  else
    ConsoleKeyGuide:refreshGuide()
  end
end
function PaGlobalFunc_ConsoleKeyGuide_IsHideGuideException()
  if false == PaGlobalFunc_SearchMode_IsSearchMode() and Defines.UIMode.eUIMode_NpcDialog == GetUIMode() then
    return true
  end
  if false == PaGlobalFunc_SearchMode_IsSearchMode() and Defines.UIMode.eUIMode_NpcDialog_Dummy == GetUIMode() then
    return true
  end
  if true == _ContentsGroup_PadCameraMoveMode and nil ~= Panel_Widget_CameraMode_All and Panel_Widget_CameraMode_All:GetShow() then
    return false
  end
  if true == isObserverMode() then
    return false
  end
  if GetUIMode() == Defines.UIMode.eUIMode_InGameCashShop then
    return false
  end
  if true == Panel_Widget_ScreenShotFrame:GetShow() then
    return false
  end
  if getInputMode() == CppEnums.EProcessorInputMode.eProcessorInputMode_GameMode and ConsoleKeyGuide._actionKeyGuideType == KEYGUIDETYPE.matchlock then
    return false
  end
  if true == _ContentsGroup_UsePadSnapping and false == _ContentsGroup_RenewUI and nil ~= ConsoleKeyGuide._actionKeyGuideType then
    if KEYGUIDETYPE.rideShipDriver == ConsoleKeyGuide._actionKeyGuideType then
      return false
    elseif KEYGUIDETYPE.rideShip == ConsoleKeyGuide._actionKeyGuideType then
      return true
    elseif KEYGUIDETYPE.shipCannon == ConsoleKeyGuide._actionKeyGuideType then
      return true
    end
  end
  if nil ~= ConsoleKeyGuide._actionKeyGuideType and KEYGUIDETYPE.common ~= ConsoleKeyGuide._actionKeyGuideType then
    return false
  end
  local actorKeyRaw = getSelfPlayer():get():getRideVehicleActorKeyRaw()
  local servantWrapper = getServantInfoFromActorKey(actorKeyRaw)
  if nil ~= servantWrapper then
    local vehicleType = servantWrapper:getVehicleType()
    if CppEnums.VehicleType.Type_CampingTent == vehicleType then
      return true
    else
      return false
    end
  end
  if true == IsSelfPlayerSwimmingAction() then
    return true
  end
  local limitedLevel = 50
  if false == PaGlobalFunc_SearchMode_IsSearchMode() and limitedLevel < getSelfPlayer():get():getLevel() then
    return true
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) == true and KEYGUIDETYPE.solareObserver == ConsoleKeyGuide._actionKeyGuideType then
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return false
    end
    if false == selfPlayer:isDead() then
      return true
    end
  end
  return false
end
function PaGlobalFunc_ConsoleKeyGuide_Init()
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  local self = ConsoleKeyGuide
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ConsoleKeyGuide")
    return
  end
  self:init()
end
function PaGlobalFunc_ConsoleKeyGuide_ConvertKeyToIconIndex(padInputType)
  local iconIdx
  if __eJoyPadInputType_LeftShoulder == padInputType then
    iconIdx = _consoleUIIconName.buttonLB
  elseif __eJoyPadInputType_RightShoulder == padInputType then
    iconIdx = _consoleUIIconName.buttonRB
  elseif __eJoyPadInputType_A == padInputType then
    iconIdx = _consoleUIIconName.buttonA
  elseif __eJoyPadInputType_B == padInputType then
    iconIdx = _consoleUIIconName.buttonB
  elseif __eJoyPadInputType_X == padInputType then
    iconIdx = _consoleUIIconName.buttonX
  elseif __eJoyPadInputType_Y == padInputType then
    iconIdx = _consoleUIIconName.buttonY
  elseif __eJoyPadInputType_LeftTrigger == padInputType then
    iconIdx = _consoleUIIconName.buttonLT
  elseif __eJoyPadInputType_RightTrigger == padInputType then
    iconIdx = _consoleUIIconName.buttonRT
  elseif __eJoyPadInputType_LeftThumb == padInputType then
    iconIdx = _consoleUIIconName.buttonLSC
  elseif __eJoyPadInputType_RightThumb == padInputType then
    iconIdx = _consoleUIIconName.buttonRSC
  elseif __eJoyPadInputType_Start == padInputType then
    iconIdx = _consoleUIIconName.buttonStart
  end
  return iconIdx
end
function PaGlobalFunc_ConsoleKeyGuide_ConvertActionInputTypeToIconIndex(actionInputType)
  local iconIdx
  local keyName = keyCustom_GetString_ActionPad(actionInputType)
  if "LeftShoulder" == keyName then
    iconIdx = _consoleUIIconName.buttonLB
  elseif "RightShoulder" == keyName then
    iconIdx = _consoleUIIconName.buttonRB
  elseif "A" == keyName then
    iconIdx = _consoleUIIconName.buttonA
  elseif "B" == keyName then
    iconIdx = _consoleUIIconName.buttonB
  elseif "X" == keyName then
    iconIdx = _consoleUIIconName.buttonX
  elseif "Y" == keyName then
    iconIdx = _consoleUIIconName.buttonY
  elseif "LTrigger" == keyName then
    iconIdx = _consoleUIIconName.buttonLT
  elseif "RTrigger" == keyName then
    iconIdx = _consoleUIIconName.buttonRT
  elseif "LeftThumb" == keyName then
    iconIdx = _consoleUIIconName.buttonLSC
  elseif "RightThumb" == keyName then
    iconIdx = _consoleUIIconName.buttonRSC
  elseif "Start" == keyName then
    iconIdx = _consoleUIIconName.buttonStart
  else
    if "LStick Down" == keyName then
      iconIdx = _consoleUIIconName.buttonLSDown
    else
    end
  end
  return iconIdx
end
function PaGlobalFunc_ConsoleKeyGuide_SetControlIconWithActionType(control, actionInputType)
  if nil == control then
    return false
  end
  control:SetShow(false)
  local iconIdx = PaGlobalFunc_ConsoleKeyGuide_ConvertActionInputTypeToIconIndex(actionInputType)
  if nil == iconIdx then
    return false
  end
  control:ChangeTextureInfoNameAsync("renewal/ui_icon/console_xboxkey_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(control, _consoleUIIconUV[iconIdx].x1, _consoleUIIconUV[iconIdx].y1, _consoleUIIconUV[iconIdx].x2, _consoleUIIconUV[iconIdx].y2)
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  control:SetShow(true)
  return true
end
local currentRenderMode = Defines.RenderMode.eRenderMode_Default
function FromClient_RenderModeChangeState_ConsoleKeyGuide(prevRenderModeList, nextRenderModeList)
  currentRenderMode = nextRenderModeList
end
function PaGlobalFunc_ConsoleKeyGuide_ChangeInputMode()
  local self = ConsoleKeyGuide
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ConsoleKeyGuide")
    return
  end
  self:refreshGuide()
end
function PaGlobalFunc_ConsoleKeyGuide_SetScreenShotGuideState(state)
  local self = ConsoleKeyGuide
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ConsoleKeyGuide")
    return
  end
  if true == state then
    PaGlobalFunc_ConsoleKeyGuide_SetUiModeKeyGuide(KEYGUIDETYPE.screenshotGuide)
  else
    PaGlobalFunc_ConsoleKeyGuide_SetUiModeKeyGuide(nil)
  end
end
function PaGlobalFunc_ConsoleKeyGuide_SetUiModeKeyGuide(state)
  local self = ConsoleKeyGuide
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ConsoleKeyGuide")
    return
  end
  self._uiModeKeyGuideType = state
  self:refreshGuide()
end
function PaGlobalFunc_ConsoleKeyGuide_SetActionKeyGuide(state)
  local self = ConsoleKeyGuide
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ConsoleKeyGuide")
    return
  end
  self._actionKeyGuideType = state
  self:refreshGuide()
end
function PaGlobalFunc_ConsoleKeyGuide_UpdateKeyCustom()
  local self = ConsoleKeyGuide
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ConsoleKeyGuide")
    return
  end
  for index = 0, self._maxConsoleGuideType - 1 do
    if nil ~= self._ui._keyGuide[index] then
      for keyIdx = 0, self._ui._keyGuide[index].guideIdx - 1 do
        local guideData = self._ui._keyGuide[index].guideData[keyIdx]
        self:updateCustomGuide(guideData)
      end
    end
  end
end
function PaGlobalFunc_ConsoleKeyGuide_SetRideState()
  local self = ConsoleKeyGuide
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ConsoleKeyGuide")
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local selfProxy = selfPlayer:get()
  if selfProxy == nil then
    return
  end
  local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
  local vehicleProxy = getVehicleActor(actorKeyRaw)
  local guideState
  if vehicleProxy == nil then
    guideState = nil
  else
    local characterKey = vehicleProxy:getCharacterKey()
    local vehicleType = vehicleProxy:get():getVehicleType()
    local vehicleSubType = vehicleProxy:get():getVehicleSubType()
    if CppEnums.VehicleType.Type_Horse == vehicleType then
      guideState = KEYGUIDETYPE.rideHorse
    elseif CppEnums.VehicleType.Type_Camel == vehicleType then
      guideState = KEYGUIDETYPE.rideCamel
    elseif CppEnums.VehicleType.Type_Donkey == vehicleType then
      if nil ~= characterKey and (9113 == characterKey or 9114 == characterKey or 9115 == characterKey) then
        guideState = KEYGUIDETYPE.rideShyDonkey
      else
        guideState = KEYGUIDETYPE.rideDonkey
      end
    elseif CppEnums.VehicleType.Type_Elephant == vehicleType then
      local seatPosition = getSelfPlayer():get():getVehicleSeatIndex()
      if 0 == seatPosition then
        guideState = KEYGUIDETYPE.elephantHead
      else
        guideState = KEYGUIDETYPE.elephantBack
      end
    elseif CppEnums.VehicleType.Type_Carriage == vehicleType or CppEnums.VehicleType.Type_CowCarriage == vehicleType then
      guideState = KEYGUIDETYPE.rideCarriage
    elseif true == ToClient_isVehicleTypeWarter(vehicleType) then
      local seatPosition = getSelfPlayer():get():getVehicleSeatIndex()
      if 0 ~= seatPosition and 13 ~= seatPosition and 3 ~= seatPosition and 1 ~= seatPosition and 2 ~= seatPosition and ToClient_IsVehiclePaddleSeatIndex(vehicleType, seatPosition) == false then
        guideState = KEYGUIDETYPE.shipCannon
      elseif 0 == seatPosition and true == _ContentsGroup_OceanCurrent and vehicleProxy:isOceanShip() then
        guideState = KEYGUIDETYPE.rideShipDriver
        PaGlobalFunc_ConsoleKeyGuide_SetRideShipKeyGuide()
      else
        guideState = KEYGUIDETYPE.rideShip
      end
    elseif CppEnums.VehicleType.Type_Cannon == vehicleType or 31046 == characterKey then
      guideState = KEYGUIDETYPE.cannon
      if 9013 == characterKey then
        guideState = KEYGUIDETYPE.practiceCannon
      end
    elseif CppEnums.VehicleType.Type_PracticeCannon == vehicleType then
      guideState = KEYGUIDETYPE.practiceCannon
    elseif CppEnums.VehicleType.Type_ThrowStone == vehicleType then
      if vehicleSubType == 0 then
        guideState = KEYGUIDETYPE.hwacha
      elseif vehicleSubType == 1 then
        guideState = KEYGUIDETYPE.upgradeHwacha
      else
        UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. \236\139\160\234\184\176\236\160\132\236\157\152 vehicleSubType\236\157\180 0\235\143\132 \236\149\132\235\139\136\234\179\160 1\235\143\132 \236\149\132\235\139\153\235\139\136\235\139\164.", "\236\157\180\236\163\188")
        guideState = nil
      end
    elseif CppEnums.VehicleType.Type_ThrowFire == vehicleType then
      local isUpgrade = 9088 == characterKey or 31073 == characterKey or 31074 == characterKey or 31075 == characterKey or 31132 == characterKey or 31133 == characterKey or 62405 == characterKey or 62410 == characterKey
      if true == isUpgrade then
        guideState = KEYGUIDETYPE.upgradeFlameTower
      else
        guideState = KEYGUIDETYPE.flameTower
      end
    elseif CppEnums.VehicleType.Type_RepairableCarriage == vehicleType then
      guideState = KEYGUIDETYPE.rideRepairableCarriage
    elseif CppEnums.VehicleType.Type_RidableBabyElephant == vehicleType then
      guideState = KEYGUIDETYPE.rideBabyElephant
    elseif CppEnums.VehicleType.Type_Train == vehicleType then
      guideState = KEYGUIDETYPE.train
    else
      guideState = nil
    end
  end
  PaGlobalFunc_ConsoleKeyGuide_SetActionKeyGuide(guideState)
end
function PaGlobalFunc_ConsoleKeyGuide_SetSearchState()
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  PaGlobalFunc_ConsoleKeyGuide_SetUiModeKeyGuide(0)
end
function PaGlobalFunc_ConsoleKeyGuide_SetGuide(state)
  PaGlobalFunc_ConsoleKeyGuide_SetUiModeKeyGuide(state)
end
function PaGlobalFunc_ConsoleKeyGuide_PopGuide()
  PaGlobalFunc_ConsoleKeyGuide_SetUiModeKeyGuide(nil)
end
function PaGlobalFunc_ConsoleKeyGuide_SetState(state_)
end
function PaGlobalFunc_ConsoleKeyGuide_SetFishingIdleMode()
end
function PaGlobalFunc_ConsoleKeyGuide_SetFishingWaitHookMode()
end
function PaGlobalFunc_ConsoleKeyGuide_SetfishingStartHook()
end
function PaGlobalFunc_ConsoleKeyGuide_SetfishingHookMini1()
end
function PaGlobalFunc_ConsoleKeyGuide_SetfishingHookMini2()
end
function PaGlobalFunc_ConsoleKeyGuide_SetPearlShop()
end
function PaGlobalFunc_ConsoleKeyGuide_On()
end
function PaGlobalFunc_ConsoleKeyGuide_Off()
end
function PaGlobalFunc_ConsoleKeyGuide_SetManualState(state_)
end
function PaGlobalFunc_ConsoleKeyGuide_SetPos()
  local screenGapSizeX = (getOriginScreenSizeX() - getScreenSizeX()) / 2
  local screenGapSizeY = (getOriginScreenSizeY() - getScreenSizeY()) / 2
  if false == PaGlobalFunc_SearchMode_IsSearchMode() then
    _panel:SetPosX(getScreenSizeX() - _panel:GetSizeX() - 50 + screenGapSizeX)
    _panel:SetPosY(getScreenSizeY() - _panel:GetSizeY() - 50 + screenGapSizeY)
  elseif true == _ContentsGroup_RenewUI_SearchMode then
    _panel:SetPosX(getScreenSizeX() - _panel:GetSizeX() + screenGapSizeX + 50)
    _panel:SetPosY(560 + screenGapSizeY)
  end
end
registerEvent("FromClient_luaLoadComplete", "PaGlobalFunc_ConsoleKeyGuide_Init")
function PaGlobalFunc_ConsoleKeyGuide_ConvertActionTypeToString(padInputType)
  if nil == padInputType then
    return
  end
  local actionType = keyCustom_getPadDefineAction(padInputType)
  local actionString = _customActionTypeString[actionType]
  if nil ~= actionString then
    return actionString
  else
    return "[None]"
  end
end
function PaGlobalFunc_ConsoleKeyGuide_GetKeyGuideIconUV(key)
  local IconIndex = _consoleUIIconName[key]
  if nil == IconIndex then
    return 0, 0, 0, 0
  end
  local IconUV = _consoleUIIconUV[IconIndex]
  if nil == IconUV then
    return 0, 0, 0, 0
  end
  return IconUV.x1, IconUV.y1, IconUV.x2, IconUV.y2
end
function PaGlobalFunc_ConsoleKeyGuide_GetKeyGuideIconUVByIndex(index)
  local IconUV = _consoleUIIconUV[index]
  if nil == IconUV then
    return 0, 0, 0, 0
  end
  return IconUV.x1, IconUV.y1, IconUV.x2, IconUV.y2
end
function PaGlobalFunc_ConsoleKeyGuide_IsSearchModeKeyGudieShow()
  return ConsoleKeyGuide._isSearchMode
end
function PaGlobalFunc_ConsoleKeyGuide_SetRideShipKeyGuide()
  if true == _ContentsGroup_OceanCurrent then
    local oceanShipSkillUI = false
    local selfProxy = getSelfPlayer():get()
    if nil == selfProxy then
      return
    end
    local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
    local vehicleProxy = getVehicleActor(actorKeyRaw)
    if nil == vehicleProxy then
      return
    end
    local characterKey = vehicleProxy:getCharacterKey()
    local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
    if nil ~= shipStaticStatus and true == shipStaticStatus:getOceanShipSkillUI() and 0 == selfProxy:getVehicleSeatIndex() then
      oceanShipSkillUI = true
    end
    local fastMoveKeyGuide = ConsoleKeyGuide._ui._keyGuide[KEYGUIDETYPE.rideShipDriver].guideData[3]
    if nil ~= fastMoveKeyGuide then
      if 20 < selfProxy:getLifeExperienceLevel(9) and true == oceanShipSkillUI then
        for ii = 1, #fastMoveKeyGuide.uiIcon do
          fastMoveKeyGuide.uiIcon[ii]:SetShow(true)
        end
        fastMoveKeyGuide.keyString:SetShow(true)
      else
        for ii = 1, #fastMoveKeyGuide.uiIcon do
          fastMoveKeyGuide.uiIcon[ii]:SetShow(false)
        end
        fastMoveKeyGuide.keyString:SetShow(false)
      end
    end
    local spreadKeyGuide = ConsoleKeyGuide._ui._keyGuide[KEYGUIDETYPE.rideShipDriver].guideData[2]
    if nil ~= spreadKeyGuide then
      local isSpread = ToClient_GetRideShipSpread()
      if true == isSpread then
        spreadKeyGuide.keyString:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_KEYGUIDE_SAILCONTROL_ON"))
      else
        spreadKeyGuide.keyString:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_KEYGUIDE_SAILCONTROL_OFF"))
      end
    end
  end
  if _ContentsGroup_EmployeePresetJob == true then
    local autoFixKeyGuide = ConsoleKeyGuide._ui._keyGuide[KEYGUIDETYPE.rideShipDriver].guideData[4]
    if autoFixKeyGuide ~= nil then
      if ToClient_CheckViceCaptainAbility(__eEmployeeAbility_Servant_AutoFix) then
        for ii = 1, #autoFixKeyGuide.uiIcon do
          autoFixKeyGuide.uiIcon[ii]:SetShow(true)
        end
        autoFixKeyGuide.keyString:SetShow(true)
      else
        for ii = 1, #autoFixKeyGuide.uiIcon do
          autoFixKeyGuide.uiIcon[ii]:SetShow(false)
        end
        autoFixKeyGuide.keyString:SetShow(false)
      end
    end
  end
end
