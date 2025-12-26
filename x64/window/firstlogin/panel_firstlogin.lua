Panel_FirstLogin:SetShow(false)
Panel_FirstLogin:setGlassBackground(true)
Panel_FirstLogin:RegisterShowEventFunc(true, "Panel_FirstLogin_ShowAni()")
Panel_FirstLogin:RegisterShowEventFunc(false, "Panel_FirstLogin_HideAni()")
if true == _ContentsGroup_UsePadSnapping then
  Panel_FirstLogin:ignorePadSnapMoveToOtherPanel()
end
function Panel_FirstLogin_ShowAni()
end
function Panel_FirstLogin_HideAni()
end
local FirstLogin = {
  blockBG = UI.getChildControl(Panel_FirstLogin, "Static_blockBG"),
  BTN_Next = UI.getChildControl(Panel_FirstLogin, "Button_Next"),
  BTN_Prev = UI.getChildControl(Panel_FirstLogin, "Button_Prev"),
  RecommendBG_Low = UI.getChildControl(Panel_FirstLogin, "Static_RecommendBG_Low"),
  RecommendBG_Normal = UI.getChildControl(Panel_FirstLogin, "Static_RecommendBG_Normal"),
  RecommendBG_High = UI.getChildControl(Panel_FirstLogin, "Static_RecommendBG_High"),
  Slider_Control = UI.getChildControl(Panel_FirstLogin, "Slider_Control"),
  Slider_0 = UI.getChildControl(Panel_FirstLogin, "StaticText_Slider_0"),
  Slider_50 = UI.getChildControl(Panel_FirstLogin, "StaticText_Slider_50"),
  Slider_100 = UI.getChildControl(Panel_FirstLogin, "StaticText_Slider_100"),
  Slider_DescBG = UI.getChildControl(Panel_FirstLogin, "Static_ContentBG"),
  Slider_Desc = UI.getChildControl(Panel_FirstLogin, "StaticText_ContentDesc"),
  Text_Title = UI.getChildControl(Panel_FirstLogin, "StaticText_ContentTitle"),
  RadioBTN_AllRound = UI.getChildControl(Panel_FirstLogin, "RadioButton_Taste_AllRound"),
  RadioBTN_Combat = UI.getChildControl(Panel_FirstLogin, "RadioButton_Taste_Combat"),
  RadioBTN_Product = UI.getChildControl(Panel_FirstLogin, "RadioButton_Taste_Product"),
  RadioBTN_Fishing = UI.getChildControl(Panel_FirstLogin, "RadioButton_Taste_Fishing"),
  Text_RadioBTN_Title = UI.getChildControl(Panel_FirstLogin, "StaticText_Taste_All_Title"),
  Text_RadioBTN_Desc = UI.getChildControl(Panel_FirstLogin, "StaticText_Taste_All_Desc"),
  RadioBTN_None = UI.getChildControl(Panel_FirstLogin, "RadioButton_NavGuideNone"),
  RadioBTN_Arrow = UI.getChildControl(Panel_FirstLogin, "RadioButton_NavGuideArrow"),
  RadioBTN_Effect = UI.getChildControl(Panel_FirstLogin, "RadioButton_NavGuideEffect"),
  RadioBTN_Fairy = UI.getChildControl(Panel_FirstLogin, "RadioButton_NavGuideFairy"),
  img_None = UI.getChildControl(Panel_FirstLogin, "Static_None"),
  img_Arrow = UI.getChildControl(Panel_FirstLogin, "Static_Arrow"),
  img_Effect = UI.getChildControl(Panel_FirstLogin, "Static_Effect"),
  img_Fairy = UI.getChildControl(Panel_FirstLogin, "Static_Fairy"),
  title_TexQuality = UI.getChildControl(Panel_FirstLogin, "StaticText_TextureQuality"),
  Button_TextureLow = UI.getChildControl(Panel_FirstLogin, "RadioButton_TextureLow"),
  Button_TextureNormal = UI.getChildControl(Panel_FirstLogin, "RadioButton_TextureNormal"),
  Button_TextureHigh = UI.getChildControl(Panel_FirstLogin, "RadioButton_TextureHigh"),
  RadioButton_TextureRemaster = UI.getChildControl(Panel_FirstLogin, "RadioButton_TextureRemaster"),
  _rdo_LowPower_Off = UI.getChildControl(Panel_FirstLogin, "RadioButton_LowPower_Off"),
  _rdo_LowPower_On = UI.getChildControl(Panel_FirstLogin, "RadioButton_LowPower_On"),
  _stc_Step6_Group = UI.getChildControl(Panel_FirstLogin, "Static_Group_Step6"),
  _rdo_hp1 = nil,
  _rdo_hp2 = nil,
  _stc_pageProgessBg = UI.getChildControl(Panel_FirstLogin, "Static_PageProgress"),
  _stc_nextArrowIcon = nil,
  _stc_keyGuide = UI.getChildControl(Panel_FirstLogin, "Static_Console_KeyGuide_BG"),
  _stc_backBg = UI.getChildControl(Panel_FirstLogin, "Static_BG"),
  _backBgBaseSize = 0,
  _progressIcon = Array.new(),
  _currentStep = 1,
  _stepMaxCount = 2,
  characterSelect = nil,
  TEXTURE_QUALITY_HIGH = 0,
  TEXTURE_QUALITY_NORMAL = 1,
  TEXTURE_QUALITY_LOW = 2,
  TEXTURE_QUALITY_COUNT = 3,
  GRAPHIC_OPTION_HIGH0 = 0,
  GRAPHIC_OPTION_HIGH1 = 1,
  GRAPHIC_OPTION_NORMAL0 = 2,
  GRAPHIC_OPTION_NORMAL1 = 3,
  GRAPHIC_OPTION_LOW0 = 4,
  GRAPHIC_OPTION_LOW1 = 5,
  GRAPHIC_OPTION_VERYLOW = 6,
  GRAPHIC_OPTION_HIGHFORWARD = 7,
  GRAPHIC_OPTION_ULTRAHIGH = 8,
  GRAPHIC_OPTION_ULTRALOW = 9,
  GRAPHIC_OPTION_COUNT = 10,
  currentTexGraphicOptionIdx = 0,
  currentGraphicOptionIdx = 0
}
FirstLogin.Slider_ControlBTN = UI.getChildControl(FirstLogin.Slider_Control, "Slider_Button")
FirstLogin._buttonQuestion = UI.getChildControl(Panel_FirstLogin, "Button_Question")
FirstLogin._buttonQuestion:SetShow(false)
function FirstLogin:initialize()
  self.BTN_Next:SetShow(false)
  self.BTN_Prev:SetShow(false)
  self.Text_Title:SetShow(false)
  self.Slider_Desc:SetShow(false)
  self.Slider_Control:SetShow(false)
  self.Slider_0:SetShow(false)
  self.Slider_50:SetShow(false)
  self.Slider_100:SetShow(false)
  self.Slider_DescBG:SetShow(false)
  self.RecommendBG_Low:SetShow(false)
  self.RecommendBG_Normal:SetShow(false)
  self.RecommendBG_High:SetShow(false)
  self.RadioBTN_AllRound:SetShow(false)
  self.RadioBTN_Combat:SetShow(false)
  self.RadioBTN_Product:SetShow(false)
  self.RadioBTN_Fishing:SetShow(false)
  self.Text_RadioBTN_Title:SetShow(false)
  self.Text_RadioBTN_Desc:SetShow(false)
  self.RadioBTN_None:SetShow(false)
  self.RadioBTN_Arrow:SetShow(false)
  self.RadioBTN_Effect:SetShow(false)
  self.RadioBTN_Fairy:SetShow(false)
  self.img_None:SetShow(false)
  self.img_Arrow:SetShow(false)
  self.img_Effect:SetShow(false)
  self.img_Fairy:SetShow(false)
  self.title_TexQuality:SetShow(false)
  self.Button_TextureLow:SetShow(false)
  self.Button_TextureNormal:SetShow(false)
  self.Button_TextureHigh:SetShow(false)
  self.RadioButton_TextureRemaster:SetShow(false)
  self._rdo_LowPower_On:SetCheck(true)
  self._rdo_LowPower_Off:SetShow(false)
  self._rdo_LowPower_On:SetShow(false)
  self._stc_Step6_Group:SetShow(false)
  self.Text_RadioBTN_Desc:SetTextMode(__eTextMode_AutoWrap)
  self.Slider_Desc:SetTextMode(__eTextMode_AutoWrap)
  self.Slider_DescBG:SetTextMode(__eTextMode_AutoWrap)
  self._rdo_hp1 = UI.getChildControl(self._stc_Step6_Group, "RadioButton_1")
  self._rdo_hp2 = UI.getChildControl(self._stc_Step6_Group, "RadioButton_2")
  self._stc_nextArrowIcon = UI.getChildControl(FirstLogin.BTN_Next, "Static_NextIcon")
  self._backBgBaseSize = self._stc_backBg:GetSizeY()
  FirstLogin._stc_keyGuide:SetShow(_ContentsGroup_UsePadSnapping)
  if true == _ContentsGroup_UsePadSnapping then
    local keyguideA = UI.getChildControl(FirstLogin._stc_keyGuide, "StaticText_Select")
    PaGlobalFunc_ConsoleKeyGuide_SetAlign({keyguideA}, FirstLogin._stc_keyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  for idx = 1, self._stepMaxCount do
    local bg = UI.getChildControl(self._stc_pageProgessBg, "Static_Page0" .. tostring(idx))
    local icons = {
      _icon_Complete = UI.getChildControl(bg, "Static_Complete0" .. tostring(idx)),
      _icon_Active = UI.getChildControl(bg, "Static_Active0" .. tostring(idx))
    }
    icons._icon_Complete:SetShow(false)
    icons._icon_Active:SetShow(false)
    self._progressIcon:push_back(icons)
  end
end
function FirstLogin:NewSetStep1()
  self.Text_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FIRSTLOGIN_STEPTITLE1"))
  self.BTN_Next:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FIRSTLOGIN_BTN_NEXT"))
  self.Slider_DescBG:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FIRSTLOGIN_STEPDESC1"))
  self._stc_nextArrowIcon:SetShow(true)
  self:PanelResize_ByFontSize()
  self.BTN_Next:SetShow(true)
  self.Text_Title:SetShow(true)
  self.Slider_Desc:SetShow(false)
  self.Slider_Control:SetShow(false)
  self.Slider_0:SetShow(false)
  self.Slider_50:SetShow(false)
  self.Slider_100:SetShow(false)
  self.Slider_DescBG:SetShow(true)
  self.RecommendBG_Low:SetShow(false)
  self.RecommendBG_Normal:SetShow(false)
  self.RecommendBG_High:SetShow(false)
  self.RadioBTN_AllRound:SetShow(false)
  self.RadioBTN_Combat:SetShow(false)
  self.RadioBTN_Product:SetShow(false)
  self.RadioBTN_Fishing:SetShow(false)
  self.Text_RadioBTN_Title:SetShow(false)
  self.Text_RadioBTN_Desc:SetShow(false)
  self.RadioBTN_None:SetShow(false)
  self.RadioBTN_Arrow:SetShow(false)
  self.RadioBTN_Effect:SetShow(false)
  self.RadioBTN_Fairy:SetShow(false)
  self.img_None:SetShow(false)
  self.img_Arrow:SetShow(false)
  self.img_Effect:SetShow(false)
  self.img_Fairy:SetShow(false)
  self.title_TexQuality:SetShow(true)
  self.Button_TextureLow:SetShow(true)
  self.Button_TextureLow:SetCheck(false)
  self.Button_TextureNormal:SetShow(true)
  self.Button_TextureNormal:SetCheck(false)
  self.Button_TextureHigh:SetShow(true)
  self.Button_TextureHigh:SetCheck(false)
  self.Button_TextureHigh:SetShow(true)
  self.Button_TextureHigh:SetCheck(false)
  self.RadioButton_TextureRemaster:SetShow(true)
  self.RadioButton_TextureRemaster:SetCheck(true)
  self._rdo_LowPower_Off:SetShow(false)
  self._rdo_LowPower_On:SetShow(false)
  self._stc_Step6_Group:SetShow(false)
  self.Button_TextureLow:ComputePos()
  self.Button_TextureNormal:ComputePos()
  self.Button_TextureHigh:ComputePos()
  self.RadioButton_TextureRemaster:ComputePos()
end
function FirstLogin:NewSetStep2()
  self.Text_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FIRSTLOGIN_STEPTITLE2"))
  self.BTN_Next:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FIRSTLOGIN_CONFIRM"))
  self.Slider_DescBG:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FIRSTLOGIN_STEPDESC2"))
  self._stc_nextArrowIcon:SetShow(false)
  self:PanelResize_ByFontSize()
  self.BTN_Next:SetShow(true)
  self.Text_Title:SetShow(true)
  self.Slider_Desc:SetShow(false)
  self.Slider_Control:SetShow(false)
  self.Slider_0:SetShow(false)
  self.Slider_50:SetShow(false)
  self.Slider_100:SetShow(false)
  self.Slider_DescBG:SetShow(true)
  self.RecommendBG_Low:SetShow(false)
  self.RecommendBG_Normal:SetShow(false)
  self.RecommendBG_High:SetShow(false)
  self.RadioBTN_AllRound:SetShow(false)
  self.RadioBTN_Combat:SetShow(false)
  self.RadioBTN_Product:SetShow(false)
  self.RadioBTN_Fishing:SetShow(false)
  self.Text_RadioBTN_Title:SetShow(false)
  self.Text_RadioBTN_Desc:SetShow(false)
  self.RadioBTN_None:SetShow(false)
  self.RadioBTN_Arrow:SetShow(false)
  self.RadioBTN_Effect:SetShow(false)
  self.RadioBTN_Fairy:SetShow(false)
  self.img_None:SetShow(false)
  self.img_Arrow:SetShow(false)
  self.img_Effect:SetShow(false)
  self.img_Fairy:SetShow(false)
  self.title_TexQuality:SetShow(false)
  self.Button_TextureLow:SetShow(false)
  self.Button_TextureLow:SetCheck(false)
  self.Button_TextureNormal:SetShow(false)
  self.Button_TextureNormal:SetCheck(false)
  self.Button_TextureHigh:SetShow(false)
  self.Button_TextureHigh:SetCheck(false)
  self.Button_TextureHigh:SetShow(false)
  self.Button_TextureHigh:SetCheck(false)
  self.RadioButton_TextureRemaster:SetShow(false)
  self.RadioButton_TextureRemaster:SetCheck(false)
  self._rdo_LowPower_Off:SetShow(true)
  self._rdo_LowPower_On:SetShow(true)
  self._stc_Step6_Group:SetShow(false)
end
function FirstLogin:NewSetStepEnd()
  setLoginOptionCameraShake(0.5)
  setLoginOptionMotionBlur(0.1)
  setLoginOptionNavPathEffectType(CppEnums.NavPathEffectType.eNavPathEffectType_Arrow)
  saveGameOption(false)
  if _ContentsOption_CH_GPM == true then
    ToClient_reportChinaGPM(__eReportClickConfirmInitialSetting, true)
  end
  local QuestListInfo = ToClient_GetQuestList()
  QuestListInfo:setQuestSelectType(0, true)
  QuestListInfo:setQuestSelectType(1, true)
  Panel_FirstLogin:SetShow(false, false)
  if true == isGameTypeNA() then
    ToClient_SetUIfontType(2)
    saveGameOption(false)
  end
  for idx = 0, 4 do
    local chat = ToClient_getChattingPanel(idx)
    if nil ~= chat then
      chat:setShowChatSystemType(CppEnums.ChatSystemType.Enchant, false)
    end
  end
  local function normalEnterGame()
    selectCharacter(FirstLogin.characterSelect, __ePlayerCreateNormal)
  end
  local function tutorialSkipEnterGame()
    if _ContentsGroup_SelectStartPosition == true then
      PaGlobalFunc_StartBranch_All_SelectOpen(FirstLogin.characterSelect)
    else
      ToClient_NewSequenceTutorialSkipChangeStartPosition(true, __eQuestTutorialBranch_0, FirstLogin.characterSelect)
    end
  end
  local function enterTutorial()
    PaGlobal_CharacterSelect_All._selectedCharIdx = FirstLogin.characterSelect
    ToClient_NewSequenceTutorialSkipChangeStartPosition(false, __eQuestTutorialBranch_0, PaGlobal_CharacterSelect_All._selectedCharIdx)
  end
  if true == _ContentsGroup_NewSequenceTutorial then
    local isTutorialComplete = ToClient_NewSequenceTutorialComplete(FirstLogin.characterSelect)
    local isHystriaTutorialComplete = ToClient_NewSequenceHystriaTutorialComplete(FirstLogin.characterSelect)
    local isNeedTutorial = ToClient_NewSequenceNeedTutorial(FirstLogin.characterSelect)
    local characterData = getCharacterDataByIndex(FirstLogin.characterSelect, __ePlayerCreateNormal)
    if 1 == characterData._level then
      if true == isTutorialComplete then
        normalEnterGame()
      elseif true == isHystriaTutorialComplete then
        tutorialSkipEnterGame()
      elseif true == ToClient_isSequenceTutorialSkipAble(FirstLogin.characterSelect) then
        local skipAbleTitle = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_SKIP_TITLE")
        local skipAbleString = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_SKIP_MSG")
        if true == _ContentsGroup_UsePadSnapping then
          PaGlobal_CharacterSelect_All:SetMsgDataAndShow(skipAbleTitle, skipAbleString, enterTutorial, tutorialSkipEnterGame, nil, CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_0, true)
        else
          PaGlobal_CharacterSelect_All:SetMsgDataAndShow(skipAbleTitle, skipAbleString, enterTutorial, tutorialSkipEnterGame, nil, CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_0, false)
        end
      else
        enterTutorial()
      end
    elseif 2 <= characterData._level and true == isNeedTutorial then
      tutorialSkipEnterGame()
    else
      normalEnterGame()
    end
  else
    normalEnterGame()
  end
end
function FirstLogin_SetStepData(isNext)
  if nil == isNext then
    return
  end
  if false == isNext then
    FirstLogin._currentStep = FirstLogin._currentStep - 1
    if FirstLogin._currentStep < 1 then
      FirstLogin._currentStep = 1
    end
  else
    FirstLogin:saveCurrentStepOption()
    FirstLogin._currentStep = FirstLogin._currentStep + 1
    if FirstLogin._stepMaxCount < FirstLogin._currentStep then
      FirstLogin:NewSetStepEnd()
      return
    end
  end
  FirstLogin:setCurrentStepIcon(FirstLogin._currentStep)
  if 1 == FirstLogin._currentStep then
    FirstLogin:NewSetStep1()
  elseif 2 == FirstLogin._currentStep then
    FirstLogin:NewSetStep2()
  end
  if true == _ContentsGroup_UsePadSnapping then
    FirstLogin._stc_keyGuide:ComputePos()
  end
end
function FirstLogin_FavorQuestType(questType)
  local self = FirstLogin
  local title, desc
  if 0 == questType then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_FIRSTLOGIN_QUESTTYPE1")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_FIRSTLOGIN_QUESTTYPETITLE1")
  elseif 1 == questType then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_FIRSTLOGIN_QUESTTYPE2")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_FIRSTLOGIN_QUESTTYPETITLE2")
  elseif 2 == questType then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_FIRSTLOGIN_QUESTTYPE3")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_FIRSTLOGIN_QUESTTYPETITLE3")
  elseif 3 == questType then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_FIRSTLOGIN_QUESTTYPE4")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_FIRSTLOGIN_QUESTTYPETITLE4")
  else
    title = ""
    desc = ""
  end
  desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FIRSTLOGIN_QUESTTYPE_MSG", "desc", desc)
  self.Text_RadioBTN_Title:SetText(title)
  self.Text_RadioBTN_Desc:SetText(desc)
end
function FGlobal_FirstLogin_Open(characterSelect)
  FirstLogin.characterSelect = characterSelect
  FirstLogin:NewSetStep1()
  FirstLogin:setCurrentStepIcon(1)
  Panel_FirstLogin:SetShow(true, true)
  FirstLogin._currentStep = 1
  if ToClient_GetOnStartCloudGame() == true then
    FirstLogin._currentStep = 3
    if FirstLogin._stepMaxCount < FirstLogin._currentStep then
      FirstLogin:NewSetStepEnd()
    end
  end
end
function FGlobal_FirstLogin_InGameClose()
  QuestWidget_ShowSelectQuestFavorType(1)
  Panel_FirstLogin:SetShow(false, false)
end
function FirstLogin_SetCurrentGraphicOption(graphicOptionIdx)
  if graphicOptionIdx >= 0 and graphicOptionIdx < FirstLogin.GRAPHIC_OPTION_COUNT then
    FirstLogin.currentGraphicOptionIdx = graphicOptionIdx
    FirstLogin_SetGraphicOptionText(graphicOptionIdx)
  end
end
function FirstLogin_SetCurrentTexGraphicOption(graphicOptionIdx)
  if graphicOptionIdx >= 0 and graphicOptionIdx < FirstLogin.GRAPHIC_OPTION_COUNT then
    FirstLogin.currentTexGraphicOptionIdx = graphicOptionIdx
    FirstLogin_SetTexGraphicOptionText(graphicOptionIdx)
  end
end
function FirstLogin_ClickedImage(imgType)
  local self = FirstLogin
  if 0 == imgType then
    self.RadioBTN_None:SetCheck(true)
    self.RadioBTN_Arrow:SetCheck(false)
    self.RadioBTN_Effect:SetCheck(false)
    self.RadioBTN_Fairy:SetCheck(false)
    self.img_None:SetCheck(true)
    self.img_Arrow:SetCheck(false)
    self.img_Effect:SetCheck(false)
    self.img_Fairy:SetCheck(false)
  elseif 1 == imgType then
    self.RadioBTN_None:SetCheck(false)
    self.RadioBTN_Arrow:SetCheck(true)
    self.RadioBTN_Effect:SetCheck(false)
    self.RadioBTN_Fairy:SetCheck(false)
    self.img_None:SetCheck(false)
    self.img_Arrow:SetCheck(true)
    self.img_Effect:SetCheck(false)
    self.img_Fairy:SetCheck(false)
  elseif 2 == imgType then
    self.RadioBTN_None:SetCheck(false)
    self.RadioBTN_Arrow:SetCheck(false)
    self.RadioBTN_Effect:SetCheck(true)
    self.RadioBTN_Fairy:SetCheck(false)
    self.img_None:SetCheck(false)
    self.img_Arrow:SetCheck(false)
    self.img_Effect:SetCheck(true)
    self.img_Fairy:SetCheck(false)
  elseif 3 == imgType then
    self.RadioBTN_None:SetCheck(false)
    self.RadioBTN_Arrow:SetCheck(false)
    self.RadioBTN_Effect:SetCheck(false)
    self.RadioBTN_Fairy:SetCheck(true)
    self.img_None:SetCheck(false)
    self.img_Arrow:SetCheck(false)
    self.img_Effect:SetCheck(false)
    self.img_Fairy:SetCheck(true)
  end
end
function FirstLogin_RemasterModeDesc()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_GRAPHICMODE_ALERTTITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_GRAPHICMODE_ALERTDESC"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FirstLogin:registEventHandler()
  self.BTN_Next:addInputEvent("Mouse_LUp", "FirstLogin_SetStepData(true)")
  self.RadioBTN_AllRound:addInputEvent("Mouse_LUp", "FirstLogin_FavorQuestType( " .. 0 .. " )")
  self.RadioBTN_Combat:addInputEvent("Mouse_LUp", "FirstLogin_FavorQuestType( " .. 1 .. " )")
  self.RadioBTN_Product:addInputEvent("Mouse_LUp", "FirstLogin_FavorQuestType( " .. 2 .. " )")
  self.RadioBTN_Fishing:addInputEvent("Mouse_LUp", "FirstLogin_FavorQuestType( " .. 3 .. " )")
  self.img_None:addInputEvent("Mouse_LUp", "FirstLogin_ClickedImage(" .. 0 .. ")")
  self.img_Arrow:addInputEvent("Mouse_LUp", "FirstLogin_ClickedImage(" .. 1 .. ")")
  self.img_Effect:addInputEvent("Mouse_LUp", "FirstLogin_ClickedImage(" .. 2 .. ")")
  self.img_Fairy:addInputEvent("Mouse_LUp", "FirstLogin_ClickedImage(" .. 3 .. ")")
  self.RadioBTN_None:addInputEvent("Mouse_LUp", "FirstLogin_ClickedImage(" .. 0 .. ")")
  self.RadioBTN_Arrow:addInputEvent("Mouse_LUp", "FirstLogin_ClickedImage(" .. 1 .. ")")
  self.RadioBTN_Effect:addInputEvent("Mouse_LUp", "FirstLogin_ClickedImage(" .. 2 .. ")")
  self.RadioBTN_Fairy:addInputEvent("Mouse_LUp", "FirstLogin_ClickedImage(" .. 3 .. ")")
  self.RadioButton_TextureRemaster:addInputEvent("Mouse_LUp", "FirstLogin_RemasterModeDesc()")
end
function FirstLogin:registMessageHandler()
end
local basePanelSizeY = Panel_FirstLogin:GetSizeY()
local baseBgSizeY = FirstLogin.Slider_DescBG:GetSizeY()
function FirstLogin:PanelResize_ByFontSize()
  if baseBgSizeY < self.Slider_DescBG:GetTextSizeY() then
    self.Slider_DescBG:SetSize(self.Slider_DescBG:GetSizeX(), self.Slider_DescBG:GetTextSizeY() + 20)
  else
    self.Slider_DescBG:SetSize(self.Slider_DescBG:GetSizeX(), baseBgSizeY)
  end
  local plusSizeY = self.Slider_DescBG:GetSizeY() - baseBgSizeY
  Panel_FirstLogin:SetSize(Panel_FirstLogin:GetSizeX(), basePanelSizeY + plusSizeY)
  self._stc_backBg:ComputePos()
  self._stc_backBg:SetSize(self._stc_backBg:GetSizeX(), self._backBgBaseSize + plusSizeY)
  self.Slider_DescBG:ComputePos()
  self.BTN_Next:ComputePos()
  ToClient_padSnapChangeToTarget(self.BTN_Next)
end
function FirstLogin:saveCurrentStepOption()
  if 1 == FirstLogin._currentStep then
    local isGraphicCheck = self.GRAPHIC_OPTION_NORMAL1
    local isLowCheck = self.Button_TextureLow:IsCheck()
    local isNormalCheck = self.Button_TextureNormal:IsCheck()
    local isHighCheck = self.Button_TextureHigh:IsCheck()
    local isRemaster = self.RadioButton_TextureRemaster:IsCheck()
    if true == isLowCheck then
      isGraphicCheck = self.GRAPHIC_OPTION_LOW1
    elseif true == isNormalCheck then
      isGraphicCheck = self.GRAPHIC_OPTION_NORMAL1
    elseif true == isHighCheck then
      isGraphicCheck = self.GRAPHIC_OPTION_HIGH0
    elseif true == isRemaster then
      isGraphicCheck = self.GRAPHIC_OPTION_ULTRALOW
    else
      isGraphicCheck = self.GRAPHIC_OPTION_NORMAL1
    end
    setLoginOptionGraphicOption(isGraphicCheck)
  elseif 2 == FirstLogin._currentStep then
    local isLowPower = self._rdo_LowPower_On:IsCheck()
    setPresentLock(isLowPower)
  end
end
function FirstLogin:setCurrentStepIcon(currentStep)
  if nil == currentStep or currentStep > self._stepMaxCount then
    return
  end
  for idx = 1, self._stepMaxCount do
    if nil ~= self._progressIcon[idx] then
      if idx < currentStep then
        self._progressIcon[idx]._icon_Complete:SetShow(true)
        self._progressIcon[idx]._icon_Active:SetShow(false)
      elseif idx == currentStep then
        self._progressIcon[idx]._icon_Active:SetShow(true)
        self._progressIcon[idx]._icon_Complete:SetShow(false)
      else
        self._progressIcon[idx]._icon_Complete:SetShow(false)
        self._progressIcon[idx]._icon_Active:SetShow(false)
      end
    end
  end
end
FirstLogin:initialize()
FirstLogin:registEventHandler()
FirstLogin:registMessageHandler()
