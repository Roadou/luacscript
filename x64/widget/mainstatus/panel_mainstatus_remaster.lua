local _panel = Panel_MainStatus_Remaster
local _dangerPanel = Panel_Danger
local MainStatus = {
  _ui = {
    stc_ExpBG = UI.getChildControl(_panel, "Static_ExpBG"),
    progress_Exp = UI.getChildControl(_panel, "CircularProgress_EXP"),
    btn_PVP = UI.getChildControl(_panel, "CheckButton_PvP"),
    stc_HPBG = UI.getChildControl(_panel, "Static_HPBG"),
    progress_HPLater = UI.getChildControl(_panel, "Progress2_HP_Later"),
    stc_injury = UI.getChildControl(_panel, "Static_Injury"),
    progress_HPInjury = nil,
    progress_HP = UI.getChildControl(_panel, "Progress2_HP"),
    hpValue = UI.getChildControl(_panel, "StaticText_HpValue"),
    stc_MPBG = UI.getChildControl(_panel, "Static_MPBG"),
    progress_MPLater = UI.getChildControl(_panel, "Progress2_MP_Later"),
    progress_MP = UI.getChildControl(_panel, "Progress2_MP"),
    mpValue = UI.getChildControl(_panel, "StaticText_MpValue"),
    stc_RageBG = UI.getChildControl(_panel, "Static_RageBG"),
    progress_Rage = UI.getChildControl(_panel, "Progress2_Rage"),
    txt_RageValue = UI.getChildControl(_panel, "StaticText_RageValue"),
    stc_RageLock = UI.getChildControl(_panel, "Static_BlackSpiritLock"),
    txt_SkillPoint = UI.getChildControl(_panel, "StaticText_SkillPoint"),
    txt_Defence = UI.getChildControl(_panel, "StaticText_DefenceInfo"),
    txt_hardCorePoint = UI.getChildControl(_panel, "StaticText_HardcorePoint"),
    txt_BubbleAlert = UI.getChildControl(_panel, "StaticText_BubbleAlert"),
    stc_skillLearnGuideTail = nil,
    stc_skillLearnGuideBG = nil,
    stc_skillLearnGuide = nil,
    txt_skillLearnGuide = nil,
    txt_EnergyPoint = UI.getChildControl(_panel, "StaticText_EnergyPoint"),
    txt_ContributePoint = UI.getChildControl(_panel, "StaticText_ContributePoint"),
    stc_ClassResourceBG = UI.getChildControl(_panel, "Static_ClassResourceBG"),
    stc_DummyClassType3Effect = nil,
    stc_HPAlert = UI.getChildControl(_dangerPanel, "Static_Alert")
  },
  _statusTooltipType = {
    skill = 0,
    energy = 1,
    contribute = 2,
    resource0 = 3,
    resource1 = 4,
    blackSpirit = 5,
    pvp = 6,
    injury = 7,
    resource2 = 8,
    resource3 = 9,
    resource4 = 10,
    resourceCorsairBomb = 11,
    resourceCorsairBazooka = 12,
    resourceCorsairCannon = 13,
    kuno = 14,
    drakaniaSuccession = 15,
    drakaniaAwaken = 16
  },
  _contributeUsePoint = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_1"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_2"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_3")
  },
  _lastLevel = 0,
  _isSixteenLV = false,
  _lastSkillPoint = -1,
  _lastExplorePoint = 0,
  _lastRemainExplorePoint = 0,
  _lastContRate = 0,
  _isFirstExplore = false,
  _defaultSkillPoint = 15,
  _lastWP = -1,
  _prevHpAlertTime = 0,
  _prevHP = 0,
  _prevMaxHP = 0,
  _prevInjuryHP = 0,
  _percentHP = 0,
  _alertHpValue = 40,
  _strongMonsterAlert = false,
  _prevMP = 0,
  _prevMaxMP = 0,
  _isPvPOn = true,
  _isPvPUIInit = false,
  _maxTypeCount_Sorcerer = 3,
  _maxTypeCount_Combattant = 3,
  _maxTypeCount_Shy = 3,
  _maxTypeCount_Meahwa = 3,
  _maxTypeCount_Corsair = 3,
  _maxTypeCount_Kuno = 3,
  _resourceTypeSorcerer = {},
  _resourceTypeCombattant = {},
  _resourceTypeShy = {},
  _resourceTypeMeahwa = {},
  _resourceTypeCorsair = {},
  _resourceTypeKuno = {},
  _classResourceShowCheck = {
    [1] = false,
    [2] = false,
    [3] = false
  },
  _oldCharacter = false,
  _levelUpQuestClear = false,
  _isShowBladeMasterWomanEffect = false,
  _novaEffectTime = 0,
  _maxNovaEffectTime = 0.01,
  _isNovaProgressUp = false,
  _curNovaProgress = 0,
  _maxNovaProgress = 0,
  _isNovaEffectUpdate = false,
  _maxResourceCountForPQW = 18,
  _beforeCount = -1,
  _isDrakaniaDragonForm = nil,
  _iniCheck = false
}
function MainStatus:initialize()
  if true == _ContentsGroup_UsePadSnapping then
    _dangerPanel:SetOffsetIgnorePanel(true)
    _dangerPanel:ComputePos()
  end
  self._iniCheck = true
  self._ui.txt_LV = UI.getChildControl(self._ui.stc_ExpBG, "StaticText_Lv")
  self._ui.txt_EXP = UI.getChildControl(self._ui.stc_ExpBG, "StaticText_EXP")
  self._ui.progress_HPInjury = UI.getChildControl(self._ui.stc_injury, "Progress2_HP_Injury")
  self._ui.stc_skillLearnGuideTail = UI.getChildControl(self._ui.txt_SkillPoint, "Static_Bubble_Tail_Console")
  self._ui.stc_skillLearnGuideBG = UI.getChildControl(self._ui.stc_skillLearnGuideTail, "Static_blackBubble")
  self._ui.txt_skillLearnGuide = UI.getChildControl(self._ui.stc_skillLearnGuideBG, "StaticText_Desc_New")
  self._ui.txt_skillLearnGuide:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLRESET_GUIDE_NOTICE"))
  self._ui.txt_skillLearnGuide:SetSize(self._ui.txt_skillLearnGuide:GetTextSizeX() + 5, self._ui.txt_skillLearnGuide:GetTextSizeY())
  self._ui.stc_skillLearnGuideBG:SetSize(self._ui.txt_skillLearnGuide:GetSizeX() + 20, self._ui.txt_skillLearnGuide:GetSizeY() + 10)
  self._ui.stc_skillLearnGuideTail:SetShow(false)
  self._ui.stc_ClassResource_Sorcerer = UI.getChildControl(self._ui.stc_ClassResourceBG, "Static_ClassResource_Sorcerer")
  self._ui.txt_ResourceCount_Sorcerer = UI.getChildControl(self._ui.stc_ClassResource_Sorcerer, "StaticText_Count")
  if PaGlobalFunc_Util_IsSuccessionContentsOpen(__eClassType_Sorcerer) == true then
    local bg = UI.getChildControl(self._ui.stc_ClassResource_Sorcerer, "Static_Bg1")
    local gabX = bg:GetSizeX() + 5
    self._maxTypeCount_Sorcerer = 4
    self._ui.txt_ResourceCount_Sorcerer:SetSpanSize(self._ui.txt_ResourceCount_Sorcerer:GetSpanSize().x + gabX, self._ui.txt_ResourceCount_Sorcerer:GetSpanSize().y)
  end
  for idx = 1, self._maxTypeCount_Sorcerer do
    self._resourceTypeSorcerer[idx] = {}
    self._resourceTypeSorcerer[idx].bg = UI.getChildControl(self._ui.stc_ClassResource_Sorcerer, "Static_Bg" .. idx)
    self._resourceTypeSorcerer[idx].element = UI.getChildControl(self._ui.stc_ClassResource_Sorcerer, "Static_Element" .. idx)
    self._resourceTypeSorcerer[idx].bg:SetShow(true)
  end
  self._ui.stc_ClassResource_Combattant = UI.getChildControl(self._ui.stc_ClassResourceBG, "Static_ClassResource_Combattant")
  for idx = 1, self._maxTypeCount_Combattant do
    self._resourceTypeCombattant[idx] = {}
    self._resourceTypeCombattant[idx].bg = UI.getChildControl(self._ui.stc_ClassResource_Combattant, "Static_Bg" .. idx)
    self._resourceTypeCombattant[idx].element = UI.getChildControl(self._ui.stc_ClassResource_Combattant, "Static_Element" .. idx)
  end
  self._ui.stc_ClassResource_Shy = UI.getChildControl(self._ui.stc_ClassResourceBG, "Static_ClassResource_Shy")
  self._ui.txt_ResourceCount_Shy = UI.getChildControl(self._ui.stc_ClassResource_Shy, "StaticText_Count")
  for idx = 1, self._maxTypeCount_Shy do
    self._resourceTypeShy[idx] = {}
    self._resourceTypeShy[idx].bg = UI.getChildControl(self._ui.stc_ClassResource_Shy, "Static_Bg" .. idx)
    self._resourceTypeShy[idx].element = UI.getChildControl(self._ui.stc_ClassResource_Shy, "Static_Element" .. idx)
  end
  self._ui.stc_ClassResource_Meahwa = UI.getChildControl(self._ui.stc_ClassResourceBG, "Static_ClassResource_Meahwa")
  self._ui.stc_DummyClassType3Effect = UI.getChildControl(self._ui.stc_ClassResource_Meahwa, "Static_Dummy")
  for idx = 1, self._maxTypeCount_Meahwa do
    self._resourceTypeMeahwa[idx] = {}
    self._resourceTypeMeahwa[idx].bg = UI.getChildControl(self._ui.stc_ClassResource_Meahwa, "Static_Bg" .. idx)
    self._resourceTypeMeahwa[idx].element = UI.getChildControl(self._ui.stc_ClassResource_Meahwa, "Static_Element" .. idx)
  end
  self._ui.stc_ClassResource_Nova = UI.getChildControl(self._ui.stc_ClassResourceBG, "Static_ClassResource_Nova")
  self._ui.stc_ClassResource_NovaGauge = UI.getChildControl(self._ui.stc_ClassResource_Nova, "Progress2_NovaResource")
  self._ui.stc_ClassResource_NovaIcon = UI.getChildControl(self._ui.stc_ClassResource_Nova, "Static_1")
  self._ui.stc_ClassResource_Corsair = UI.getChildControl(self._ui.stc_ClassResourceBG, "Static_ClassResource_Corsair")
  for idx = 1, self._maxTypeCount_Corsair do
    self._resourceTypeCorsair[idx] = {}
    self._resourceTypeCorsair[idx].bg = UI.getChildControl(self._ui.stc_ClassResource_Corsair, "Static_Bg" .. idx)
    self._resourceTypeCorsair[idx].element = UI.getChildControl(self._ui.stc_ClassResource_Corsair, "Static_Element" .. idx)
  end
  self._ui.stc_DummyClassTypeCorsairEffect = UI.getChildControl(self._ui.stc_ClassResource_Corsair, "Static_Dummy")
  self._ui.stc_ClassResource_Kuno = UI.getChildControl(self._ui.stc_ClassResourceBG, "Static_ClassResource_Kuno")
  for idx = 1, self._maxTypeCount_Kuno do
    self._resourceTypeKuno[idx] = {}
    self._resourceTypeKuno[idx].bg = UI.getChildControl(self._ui.stc_ClassResource_Kuno, "Static_Bg" .. idx)
    self._resourceTypeKuno[idx].element = UI.getChildControl(self._ui.stc_ClassResource_Kuno, "Static_Element" .. idx)
    self._resourceTypeKuno[idx].bg:SetMonoTone(true)
  end
  self._ui.stc_ClassResource_Drakania_Inherit = UI.getChildControl(self._ui.stc_ClassResourceBG, "Static_ClassResource_Drakania_Inherit")
  self._ui.progress_PQW = UI.getChildControl(self._ui.stc_ClassResource_Drakania_Inherit, "Progress2_1")
  self._ui.pqwEffect = UI.getChildControl(self._ui.stc_ClassResource_Drakania_Inherit, "Static_Effect")
  self._ui.pqwEffect2 = UI.getChildControl(self._ui.stc_ClassResource_Drakania_Inherit, "Static_Effect2")
  self._ui.stc_ClassResource_Drakania_Awaken = UI.getChildControl(self._ui.stc_ClassResourceBG, "Static_ClassResource_Drakania_Awaken")
  self._ui.drakaniaNormalFormBG = UI.getChildControl(self._ui.stc_ClassResource_Drakania_Awaken, "Static_Bg1")
  self._ui.drakaniaDragonFormBG = UI.getChildControl(self._ui.stc_ClassResource_Drakania_Awaken, "Static_Bg2")
  self._ui.drakaniaNormalFormIcon = UI.getChildControl(self._ui.stc_ClassResource_Drakania_Awaken, "Static_Element1")
  self._ui.drakaniaDragonFormIcon = UI.getChildControl(self._ui.stc_ClassResource_Drakania_Awaken, "Static_Element2")
  if true == ToClient_getGameUIManagerWrapper():hasLuaCacheDataList(__eBlackSpiritSkillOnOff) and getSelfPlayer():isUseableBlackSpritSkill() ~= ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eBlackSpiritSkillOnOff) then
    requestBlackSpritSkill()
  end
  self:addStatusEffect()
  self:setMPBarTexture()
  self:registEventHandler()
  self._isNovaEffectUpdate = false
  self._ui.stc_ClassResource_Nova:EraseAllEffect()
  if nil ~= Panel_MainStatus_Remaster then
    Panel_MainStatus_Remaster:ClearUpdateLuaFunc()
  end
  self._ui.txt_BubbleAlert:SetShow(false)
  PaGlobalFunc_MainStatus_QuestCheck()
  self:updateAll()
  PaGlobalFunc_MainStatus_SetShow(true)
  MainStatus:unRenderPanel()
end
function MainStatus:registEventHandler()
  self._ui.btn_PVP:addInputEvent("Mouse_LUp", "PaGlobalFunc_MainStatus_RequestTogglePvP()")
  self._ui.btn_PVP:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.pvp .. ")")
  self._ui.btn_PVP:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  if _ContentsGroup_ShowOtherClassSkill == true then
    self._ui.stc_skillLearnGuideBG:addInputEvent("Mouse_LUp", "PaGlobalFunc_SkillGroup_All_HotKeyToggle()")
  else
    self._ui.stc_skillLearnGuideBG:addInputEvent("Mouse_LUp", "PaGlobalFunc_SkillGroup_HotKeyToggle()")
  end
  if _ContentsGroup_BlackSpiritLock then
    if true == _ContentsGroup_NewUI_BlackSpiritSkillLock_All then
      self._ui.stc_RageBG:addInputEvent("Mouse_LUp", "PaGlobalFunc_BlackSpiritSkillLock_All_Open(1)")
    else
      self._ui.stc_RageBG:addInputEvent("Mouse_LUp", "FGlobal_BlackSpiritSkillLock_Open(1)")
    end
  else
    self._ui.stc_RageBG:addInputEvent("Mouse_LUp", "requestBlackSpritSkill()")
  end
  self._ui.stc_RageBG:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.blackSpirit .. ")")
  self._ui.stc_RageBG:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._ui.stc_ClassResource_Sorcerer:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.resource0 .. ")")
  self._ui.stc_ClassResource_Sorcerer:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._ui.stc_ClassResource_Combattant:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.resource1 .. ")")
  self._ui.stc_ClassResource_Combattant:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._ui.stc_ClassResource_Shy:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.resource2 .. ")")
  self._ui.stc_ClassResource_Shy:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._ui.stc_ClassResource_Meahwa:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.resource3 .. ")")
  self._ui.stc_ClassResource_Meahwa:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._ui.stc_ClassResource_NovaIcon:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.resource4 .. ")")
  self._ui.stc_ClassResource_NovaIcon:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._ui.txt_SkillPoint:addInputEvent("Mouse_LUp", "GlobalKeyBinder_MouseKeyMap( __eUiInputType_Inventory )")
  self._ui.txt_SkillPoint:addInputEvent("Mouse_LUp", "GlobalKeyBinder_MouseKeyMap( __eUiInputType_Inventory )")
  self._ui.txt_Defence:addInputEvent("Mouse_LUp", "GlobalKeyBinder_MouseKeyMap( __eUiInputType_Inventory )")
  self._ui.txt_Defence:addInputEvent("Mouse_LUp", "GlobalKeyBinder_MouseKeyMap( __eUiInputType_Inventory )")
  self._ui.txt_EnergyPoint:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.energy .. ")")
  self._ui.txt_EnergyPoint:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._ui.txt_ContributePoint:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.contribute .. ")")
  self._ui.txt_ContributePoint:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  if _ContentsGroup_ContributePointList == true then
    self._ui.txt_ContributePoint:addInputEvent("Mouse_LUp", "PaGlobalFunc_ExplorePoint_UsingInfo_Open()")
  end
  self._ui.stc_ClassResource_Kuno:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.kuno .. ")")
  self._ui.stc_ClassResource_Kuno:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._resourceTypeCorsair[1].bg:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.resourceCorsairBomb .. ")")
  self._resourceTypeCorsair[1].bg:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._resourceTypeCorsair[2].bg:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.resourceCorsairBazooka .. ")")
  self._resourceTypeCorsair[2].bg:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._resourceTypeCorsair[3].bg:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.resourceCorsairCannon .. ")")
  self._resourceTypeCorsair[3].bg:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._ui.stc_ClassResource_Drakania_Inherit:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.drakaniaSuccession .. ")")
  self._ui.stc_ClassResource_Drakania_Inherit:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._ui.stc_ClassResource_Drakania_Awaken:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.drakaniaAwaken .. ")")
  self._ui.stc_ClassResource_Drakania_Awaken:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._ui.txt_BubbleAlert:addInputEvent("Mouse_LUp", "GlobalKeyBinder_MouseKeyMap(__eUiInputType_BlackSpirit)")
  registerEvent("EventCharacterInfoUpdate", "PaGlobalFunc_MainStatus_UpdateAll")
  registerEvent("FromClient_SelfPlayerHpChanged", "FromClient_MainStatus_UpdateHP")
  registerEvent("FromClient_ReplayHpChanged", "PaGlobalFunc_MainStatus_UpdateReplayHP")
  registerEvent("FromClient_ReplayMpChanged", "PaGlobalFunc_MainStatus_UpdateReplayMP")
  registerEvent("FromClient_SetReplayLevel", "PaGlobalFunc_MainStatus_UpdateReplayLevel")
  if true == _ContentsGroup_InjuryPercent then
    self._ui.stc_injury:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.injury .. ")")
    self._ui.stc_injury:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
    registerEvent("FromClient_SelfPlayerInjuryHpChanged", "PaGlobalFunc_MainStatus_UpdateInjuryHP")
  end
  registerEvent("FromClient_SelfPlayerMpChanged", "FromClient_MainStatus_UpdateMP")
  registerEvent("FromClient_SelfPlayerExpChanged", "PaGlobalFunc_MainStatus_UpdateEXP")
  registerEvent("EventSelfPlayerLevelUp", "PaGlobalFunc_MainStatus_UpdateLV")
  registerEvent("FromClient_SelfPlayerCombatSkillPointChanged", "PaGlobalFunc_MainStatus_UpdateEXP")
  registerEvent("subResourceChanged", "PaGlobalFunc_MainStatus_UpdateResource")
  registerEvent("FromClient_WpChanged", "PaGlobalFunc_MainStatus_UpdateEnergy")
  registerEvent("FromClient_UpdateExplorePoint", "PaGlobalFunc_MainStatus_UpdateContribute")
  registerEvent("FromClient_UpdateAdrenalin", "PaGlobalFunc_MainStatus_UpdateRage")
  registerEvent("FromClient_ChangeAdrenalinMode", "PaGlobalFunc_MainStatus_UpdateRage")
  registerEvent("FromClient_UseableBlackSpritSkill", "FromClient_MainStatus_BlackSpiritLock")
  registerEvent("FromClient_RenderModeChangeState", "FromClient_MainStatus_CheckHpAlertPostEvent")
  registerEvent("EventPvPModeChanged", "PaGlobalFunc_MainStatus_PVPModeChange")
  registerEvent("EventPlayerPvPAbleChanged", "PaGlobalFunc_MainStatus_PVPAbleChange")
  registerEvent("onScreenResize", "FromClient_MainStatus_OnResize")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "FromClient_MainStatus_OnResize")
  registerEvent("FromClient_HardCoreCharacterInfoChangedSelf", "PaGlobalFunc_MainStatus_HardCoreSurvivalPoint")
  registerEvent("FromClient_StartSequencePlayerControlable", "FromClient_StartSequencePlayerControlable_MainStatus_Remaster")
end
function FromClient_StartSequencePlayerControlable_MainStatus_Remaster()
  Panel_MainStatus_Remaster:SetAlpha(0)
  local aniInfo = UIAni.AlphaAnimation(1, Panel_MainStatus_Remaster, 0, 0.8)
  aniInfo:SetDisableWhileAni(true)
  if _ContentsGroup_NewUI_PartyWidget_All == true then
    Panel_Widget_Party_All:SetAlpha(0)
    local partyAniInfo = UIAni.AlphaAnimation(1, Panel_Widget_Party_All, 0, 0.8)
    partyAniInfo:SetDisableWhileAni(true)
  else
    Panel_Widget_Party:SetAlpha(0)
    local partyAniInfo = UIAni.AlphaAnimation(1, Panel_Widget_Party, 0, 0.8)
    partyAniInfo:SetDisableWhileAni(true)
  end
end
function PaGlobalFunc_MainStatus_RequestTogglePvP()
  requestTogglePvP()
end
function MainStatus:addStatusEffect()
  self._ui.progress_HP:EraseAllEffect()
  self._ui.progress_Rage:EraseAllEffect()
  self._ui.stc_RageBG:EraseAllEffect()
  self._ui.progress_HP:AddEffect("UI_Hp_Bar01A", true, 0, 0)
  self._ui.progress_HP:AddEffect("UI_Hp_Bar01B", true, 0, 0)
  self._ui.progress_HP:AddEffect("UI_Hp_Bar02A", true, 0, 0)
  self._ui.progress_HP:AddEffect("UI_Hp_Bar02B", true, 0, 0)
  self._ui.progress_HP:AddEffect("fUI_Hp_Bar01", true, 0, 0)
  self._ui.progress_Rage:AddEffect("UI_Rage_Bar01A", true, 0, 0)
  self._ui.progress_Rage:AddEffect("UI_Rage_Bar02A", true, 0, 0)
  self._ui.progress_Rage:AddEffect("UI_Rage_Bar02B", true, 0, 0)
  self._ui.progress_Rage:AddEffect("fUI_Rage_Bar01", true, 0, 0)
  self._ui.stc_RageBG:AddEffect("fN_DarkSpirit_Gage_01A", true, -107, 0)
end
function MainStatus:unRenderPanel()
  if nil == Panel_MainStatus_Remaster then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local bHide = false
  local hideCondition = {
    ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing),
    ToClient_IsRemoteInstallMode()
  }
  for k, v in ipairs(hideCondition) do
    if true == v then
      bHide = true
    end
  end
  if true == bHide then
    Panel_MainStatus_Remaster:SetRenderAndEventHide(true)
  else
    Panel_MainStatus_Remaster:SetRenderAndEventHide(false)
  end
end
function PaGlobalFunc_MainStatus_SetMPBarTexture()
  if false == _panel:GetShow() then
    return
  end
  MainStatus:setMPBarTexture()
end
function MainStatus:setMPBarTexture()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local classType = selfPlayer:getClassType()
  self._ui.progress_MP:EraseAllEffect()
  self._ui.progress_MP:ChangeTextureInfoNameAsync("Renewal/Progress/Console_Progressbar_03.dds")
  self._ui.progress_MPLater:ChangeTextureInfoNameAsync("Renewal/Progress/Console_Progressbar_03.dds")
  local mpType = NewClassData.newClass_CategoryType[classType]._mpType
  if mpType == CppEnums.MpBarColor.EP then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MP, 5, 402, 161, 426)
    self._ui.progress_MP:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MP:setRenderTexture(self._ui.progress_MP:getBaseTexture())
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MPLater, 169, 402, 325, 426)
    self._ui.progress_MPLater:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MPLater:setRenderTexture(self._ui.progress_MPLater:getBaseTexture())
    self._ui.progress_MP:AddEffect("UI_Mp_G_Bar01A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_G_Bar01B", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_G_Bar02A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_G_Bar02B", true, 0, 0)
    self._ui.progress_MP:AddEffect("fUI_Mp_G_Bar01", true, 0, 0)
  elseif mpType == CppEnums.MpBarColor.FP then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MP, 5, 452, 161, 476)
    self._ui.progress_MP:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MP:setRenderTexture(self._ui.progress_MP:getBaseTexture())
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MPLater, 169, 477, 325, 501)
    self._ui.progress_MPLater:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MPLater:setRenderTexture(self._ui.progress_MPLater:getBaseTexture())
    self._ui.progress_MP:AddEffect("UI_Mp_Bar01A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_Bar01B", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_Bar02A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_Bar02B", true, 0, 0)
    self._ui.progress_MP:AddEffect("fUI_Mp_Bar01", true, 0, 0)
  elseif mpType == CppEnums.MpBarColor.BP then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MP, 5, 477, 161, 501)
    self._ui.progress_MP:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MP:setRenderTexture(self._ui.progress_MP:getBaseTexture())
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MPLater, 169, 477, 325, 501)
    self._ui.progress_MPLater:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MPLater:setRenderTexture(self._ui.progress_MPLater:getBaseTexture())
    self._ui.progress_MP:AddEffect("UI_Mp_W_Bar01A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_W_Bar01B", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_W_Bar02A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_W_Bar02B", true, 0, 0)
    self._ui.progress_MP:AddEffect("fUI_Mp_W_Bar01", true, 0, 0)
  elseif mpType == CppEnums.MpBarColor.DARKELF then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MP, 5, 427, 161, 451)
    self._ui.progress_MP:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MP:setRenderTexture(self._ui.progress_MP:getBaseTexture())
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MPLater, 169, 427, 325, 451)
    self._ui.progress_MPLater:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MPLater:setRenderTexture(self._ui.progress_MPLater:getBaseTexture())
    self._ui.progress_MP:AddEffect("UI_Mp_P_Bar01A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_P_Bar01B", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_P_Bar02A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_P_Bar02B", true, 0, 0)
    self._ui.progress_MP:AddEffect("fUI_Mp_P_Bar01", true, 0, 0)
  elseif mpType == CppEnums.MpBarColor.MP then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MP, 5, 377, 161, 401)
    self._ui.progress_MP:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MP:setRenderTexture(self._ui.progress_MP:getBaseTexture())
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MPLater, 169, 377, 325, 401)
    self._ui.progress_MPLater:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MPLater:setRenderTexture(self._ui.progress_MPLater:getBaseTexture())
    self._ui.progress_MP:AddEffect("UI_Mp_B_Bar01A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_B_Bar01B", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_B_Bar02A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_B_Bar02B", true, 0, 0)
    self._ui.progress_MP:AddEffect("fUI_Mp_B_Bar01", true, 0, 0)
  end
  local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  if 1 == isColorBlindMode or 2 == isColorBlindMode then
    self._ui.progress_HP:ChangeTextureInfoNameAsync("Renewal/Progress/Console_Progressbar_02.dds")
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._ui.progress_HP, 1, 471, 156, 507)
    self._ui.progress_HP:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
    self._ui.progress_HP:setRenderTexture(self._ui.progress_HP:getBaseTexture())
    self._ui.progress_MP:ChangeTextureInfoNameAsync("Renewal/Progress/Console_Progressbar_02.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MP, 157, 483, 313, 507)
    self._ui.progress_MP:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MP:setRenderTexture(self._ui.progress_MP:getBaseTexture())
  else
    self._ui.progress_HP:ChangeTextureInfoNameAsync("Renewal/Progress/Console_Progressbar_03.dds")
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._ui.progress_HP, 6, 315, 161, 351)
    self._ui.progress_HP:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
    self._ui.progress_HP:setRenderTexture(self._ui.progress_HP:getBaseTexture())
  end
end
function MainStatus:updateAll()
  self:updateLV()
  self:updateEXP()
  self:updateHP()
  self:updateMP()
  self:updateRage()
  self:updateResource()
  self:updateSkillPoint()
  self:updateContribute()
  self:updateEnergy()
  self:updatePvP()
  self:updateInjuryHP()
  self:updateHardCorePoint()
  PaGlobalFunc_MainStatus_UpdateBuffList()
  PaGlobalFunc_BubbleText_49Level_Update()
end
function MainStatus:updateLV()
  if PaGlobalFunc_IsRemasterUIOption() == false then
    return
  end
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  self._ui.txt_LV:SetText(tostring(player:get():getLevel()))
  if self._lastLevel < player:get():getLevel() and 0 ~= self._lastLevel then
    self._ui.txt_LV:EraseAllEffect()
    self._ui.txt_LV:AddEffect("fUI_NewSkill01", false, 0, 0)
    self._ui.txt_LV:AddEffect("UI_NewSkill01", false, 0, 0)
  end
  local inMyLevel = player:get():getLevel()
  if 16 == inMyLevel and false == self._isSixteenLV then
    self._isSixteenLV = true
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "PANEL_SELFPLAYEREXPGAGE_LEVEL_WEATHERCHECK"))
  end
  self._lastLevel = player:get():getLevel()
end
function MainStatus:updateEXP()
  if PaGlobalFunc_IsRemasterUIOption() == false then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  local s64_needExp = player:getNeedExp_s64()
  local s64_exp = player:getExp_s64()
  local _const = Defines.s64_const
  local rate = 0
  local rateDisplay = 0
  local stringS64Exp = tostring64(s64_exp)
  local stringS64NeedExp = tostring64(s64_needExp)
  rate = tonumber(stringS64Exp) * 1000 * 100 / tonumber(stringS64NeedExp)
  local real_rate = rate / 1000
  if 100 == real_rate then
    rateDisplay = "100.000%"
  elseif 0 == real_rate then
    rateDisplay = "0.000%"
  elseif real_rate == real_rate - real_rate % 1 then
    rateDisplay = real_rate .. ".000%"
  elseif real_rate == real_rate - real_rate % 0.1 then
    rateDisplay = real_rate .. "00%"
  elseif real_rate == real_rate - real_rate % 0.01 then
    rateDisplay = real_rate .. "0%"
  else
    rateDisplay = real_rate .. "%"
  end
  self._ui.progress_Exp:SetProgressRate(real_rate)
  self._ui.stc_ExpBG:AddEffect("UI_Exp_Bar01", false, 3.1, -1)
  self._ui.txt_EXP:ComputePos()
  self._ui.txt_EXP:SetText(string.format("%.3f", real_rate) .. "%")
  PaGlobalFunc_BubbleText_49Level_Update()
end
function MainStatus:updateInjuryHP()
  if PaGlobalFunc_IsRemasterUIOption() == false then
    return
  end
  local player = getSelfPlayer():get()
  if nil == player then
    return
  end
  if false == _ContentsGroup_InjuryPercent then
    return
  end
  local maxHp = math.floor(player:getMaxHp())
  local injuryHp = math.floor(player:getInjuryHp())
  if self._prevInjuryHP == injuryHp then
    return
  end
  if injuryHp >= 0 then
    self._prevInjuryHP = injuryHp
    local injuryRate = injuryHp / maxHp * 100
    self._ui.progress_HPInjury:SetProgressRate(injuryRate)
    self._ui.stc_injury:SetSize(self._ui.progress_HPInjury:GetSizeX() * injuryRate / 100, self._ui.progress_HPInjury:GetSizeY())
    self._ui.stc_injury:ComputePos()
    self._ui.progress_HPInjury:ComputePos()
  end
end
function MainStatus:updateHP()
  if PaGlobalFunc_IsRemasterUIOption() == false then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  local regionKeyRaw = selfPlayer:getRegionKeyRaw()
  local regionWrapper = getRegionInfoWrapper(regionKeyRaw)
  local isArenaZone = regionWrapper:get():isArenaZone()
  if nil == player then
    return
  end
  local hp = math.floor(player:getHp())
  local maxHp = math.floor(player:getMaxHp())
  local minorSiegeMaxHp = maxHp
  local newMaxHp = math.floor(player:getMaxHpInMinorSiege())
  if newMaxHp > 0 and minorSiegeMaxHp > newMaxHp then
    minorSiegeMaxHp = newMaxHp
  end
  local percentHp = math.floor(hp / minorSiegeMaxHp * 100)
  self._percentHP = percentHp
  self:checkHpAlertPostEvent()
  if true == _panel:GetShow() and percentHp < 20 and hp < self._prevHP and self._prevHpAlertTime + 20 <= FGlobal_getLuaLoadTime() and not isArenaZone then
    if _ContentsGroup_UsePadSnapping == false then
      ToClient_RequestNakMessageRenewel(__eNakMessage_CharacterHPwarning)
    end
    self._prevHpAlertTime = FGlobal_getLuaLoadTime()
  end
  local effectSizeX = 185
  local effectPosX = 0
  local baseX = self._ui.stc_HPBG:GetSizeX()
  if 0 ~= maxHp and hp ~= self._prevHP or maxHp ~= self._prevMaxHP then
    self._ui.progress_HP:SetProgressRate(hp / maxHp * 100)
    self._ui.progress_HPLater:SetProgressRate(hp / maxHp * 100)
    self._prevHP = hp
    self._prevMaxHP = maxHp
    self:checkHpAlert(hp, minorSiegeMaxHp, false)
  end
  self._ui.hpValue:SetText(hp .. " / " .. maxHp)
end
function MainStatus:updateReplayHP()
  local isReplayObserver = ToClient_IsReplayObserver()
  if false == isReplayObserver then
    return
  end
  local player = getPlayerActor(ToClient_getObserverPlayerActorKey())
  if nil == player then
    return
  end
  local hp = math.floor(player:get():getHp())
  local maxHp = math.floor(player:get():getMaxHp())
  local percentHp = math.floor(hp / maxHp * 100)
  self._percentHP = percentHp
  self:checkHpAlertPostEvent()
  local effectSizeX = 185
  local effectPosX = 0
  local baseX = self._ui.stc_HPBG:GetSizeX()
  if 0 ~= maxHp and hp ~= self._prevHP or maxHp ~= self._prevMaxHP then
    self._ui.progress_HP:SetProgressRate(hp / maxHp * 100)
    self._ui.progress_HPLater:SetProgressRate(hp / maxHp * 100)
    self._prevHP = hp
    self._prevMaxHP = maxHp
    self:checkHpAlert(hp, maxHp, false)
  end
  self._ui.hpValue:SetText(hp .. " / " .. maxHp)
end
function MainStatus:updateReplayMP()
  local isReplayObserver = ToClient_IsReplayObserver()
  if false == isReplayObserver then
    return
  end
  local player = getPlayerActor(ToClient_getObserverPlayerActorKey())
  if nil == player then
    return
  end
  local mp = player:get():getMp()
  local maxMp = player:get():getMaxMp()
  local effectSizeX = 185
  local effectPosX = 0
  if 0 ~= maxMp and (mp ~= self._prevMP or maxMp ~= self._prevMaxMP) then
    self._ui.progress_MP:SetProgressRate(mp / maxMp * 100)
    self._ui.progress_MPLater:SetProgressRate(mp / maxMp * 100)
    self._prevMP = mp
    self._prevMaxMP = maxMp
    effectPosX = self._ui.stc_MPBG:GetSizeX() * mp / maxMp - effectSizeX
  end
  self._ui.mpValue:SetText(mp .. " / " .. maxMp)
  FGlobal_SettingMpBarTemp()
end
function MainStatus:updateReplayLevel()
  local isReplayObserver = ToClient_IsReplayObserver()
  if false == isReplayObserver then
    return
  end
  local player = getPlayerActor(ToClient_getObserverPlayerActorKey())
  if nil == player then
    return
  end
  self._ui.txt_LV:SetText(tostring(player:get():getLevel()))
end
function MainStatus:checkHpAlertPostEvent()
  if PaGlobalFunc_IsRemasterUIOption() == false then
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) and true == ToClient_IsObserverModeInSolrare() then
    _dangerPanel:SetShow(false)
    return
  end
  if ToClient_cutsceneIsPlay() == true then
    self._ui.stc_HPAlert:SetShow(false)
    _dangerPanel:SetShow(false)
    return
  end
  local wrapper = ToClient_getGameOptionControllerWrapper()
  if wrapper == nil then
    return
  end
  if wrapper:getAlertHp() == false then
    self._ui.stc_HPAlert:SetShow(false)
    _dangerPanel:SetShow(false)
    return
  end
  if self._alertHpValue < self._percentHP then
    self._ui.stc_HPAlert:SetShow(false)
    _dangerPanel:SetShow(false)
  else
    self._ui.stc_HPAlert:SetShow(true)
    _dangerPanel:SetShow(true)
    _dangerPanel:ComputePos()
    self._ui.stc_HPAlert:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
  end
end
function MainStatus:checkHpAlert(hp, maxHp, isLevelUp)
  local isUpdate = Defines.UIMode.eUIMode_Default == GetUIMode()
  if false == isLevelUp then
    return
  end
  local totalHp = hp / maxHp * 100
  if totalHp >= 40 and false == self._strongMonsterAlert then
    _dangerPanel:SetShow(false, false)
    self._ui.stc_HPAlert:SetAlpha(0)
  end
  if totalHp <= 39 and totalHp >= 20 then
    if false == _dangerPanel:GetShow() then
      _dangerPanel:SetShow(true, false)
      self._ui.stc_HPAlert:SetAlpha(1)
    end
    if false == self._ui.stc_HPAlert:GetShow() then
      self._ui.stc_HPAlert:SetShow(true)
    end
    self._ui.stc_HPAlert:SetVertexAniRun("Ani_Color_Danger0", true)
  end
  if totalHp <= 19 and totalHp >= 0 then
    if false == _dangerPanel:GetShow() then
      _dangerPanel:SetShow(true, false)
      self._ui.stc_HPAlert:SetAlpha(1)
    end
    if false == self._ui.stc_HPAlert:GetShow() then
      self._ui.stc_HPAlert:SetShow(true)
    end
    self._ui.stc_HPAlert:SetVertexAniRun("Ani_Color_Danger1", true)
  end
end
function MainStatus:updateMP()
  if getSelfPlayer() == nil then
    return
  end
  local player = getSelfPlayer():get()
  if player == nil then
    return
  end
  local mp = player:getMp()
  local maxMp = player:getMaxMp()
  local effectSizeX = 185
  local effectPosX = 0
  if 0 ~= maxMp and (mp ~= self._prevMP or maxMp ~= self._prevMaxMP) then
    self._ui.progress_MP:SetProgressRate(mp / maxMp * 100)
    self._ui.progress_MPLater:SetProgressRate(mp / maxMp * 100)
    self._prevMP = mp
    self._prevMaxMP = maxMp
    effectPosX = self._ui.stc_MPBG:GetSizeX() * mp / maxMp - effectSizeX
  end
  self._ui.mpValue:SetText(mp .. " / " .. maxMp)
  FGlobal_SettingMpBarTemp()
end
function MainStatus:updateRage()
  local selfPlayer = getSelfPlayer()
  local adrenallin = selfPlayer:getAdrenalin()
  adrenallin = adrenallin / 10
  adrenallin = math.floor(adrenallin) / 10
  adrenallin = string.format("%.1f", adrenallin)
  self._ui.progress_Rage:SetProgressRate(adrenallin)
  self._ui.txt_RageValue:SetText(tostring(adrenallin) .. " %")
  local isAdrenalin = selfPlayer:isEnableAdrenalin()
  self._ui.stc_RageBG:SetShow(isAdrenalin and not isRecordMode)
  self._ui.progress_Rage:SetShow(isAdrenalin and not isRecordMode)
  self._ui.txt_RageValue:SetShow(isAdrenalin and not isRecordMode)
  local isUseRage = getSelfPlayer():isUseableBlackSpritSkill()
  self._ui.stc_RageLock:SetShow(isAdrenalin and not isUseRage)
end
local showPqwLoopEffect = false
function MainStatus:updateResource()
  if self._ui.stc_ClassResourceBG == nil or self._ui.stc_ClassResourceBG:GetShow() == false then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  self._ui.stc_ClassResource_Sorcerer:SetShow(false)
  self._ui.stc_ClassResource_Combattant:SetShow(false)
  self._ui.stc_ClassResource_Shy:SetShow(false)
  self._ui.stc_ClassResource_Meahwa:SetShow(false)
  self._ui.stc_ClassResource_Nova:SetShow(false)
  self._ui.stc_ClassResource_Corsair:SetShow(false)
  self._ui.stc_ClassResource_Kuno:SetShow(false)
  self._ui.stc_ClassResource_Drakania_Inherit:SetShow(false)
  self._ui.stc_ClassResource_Drakania_Awaken:SetShow(false)
  local classType = selfPlayerWrapper:getClassType()
  if __eClassType_Sorcerer == classType then
    self._ui.stc_ClassResource_Sorcerer:SetShow(true)
    local resourceCount = selfPlayer:getSubResourcePoint()
    local showCount = math.floor(resourceCount / 10)
    for idx = 1, self._maxTypeCount_Sorcerer do
      self._resourceTypeSorcerer[idx].element:SetShow(idx <= showCount)
      if not self._classResourceShowCheck[idx] and idx <= showCount then
        self._resourceTypeSorcerer[idx].element:EraseAllEffect()
        self._resourceTypeSorcerer[idx].element:AddEffect("UI_Button_Hide", false, 0, 0)
      end
      self._classResourceShowCheck[idx] = idx <= showCount
    end
    self._ui.txt_ResourceCount_Sorcerer:SetText(resourceCount)
    self._ui.txt_ResourceCount_Sorcerer:useGlowFont(true, "BaseFont_12_Glow", 4278190080)
    self._ui.txt_ResourceCount_Sorcerer:SetShow(true)
  elseif __eClassType_Combattant == classType or __eClassType_Mystic == classType then
    self._ui.stc_ClassResource_Combattant:SetShow(true)
    local resourceCount = selfPlayer:getSubResourcePoint()
    local showCount = math.floor(resourceCount / 10)
    for idx = 1, self._maxTypeCount_Combattant do
      self._resourceTypeCombattant[idx].element:SetShow(idx <= showCount)
      if not self._classResourceShowCheck[idx] and idx <= showCount then
        self._resourceTypeCombattant[idx].element:EraseAllEffect()
        self._resourceTypeCombattant[idx].element:AddEffect("fUI_PCM_Energy_01A", false, 0, 0)
      end
      self._classResourceShowCheck[idx] = idx <= showCount
    end
  elseif __eClassType_ShyWaman == classType then
    self._ui.stc_ClassResource_Shy:SetShow(true)
    local resourceCount = selfPlayer:getSubResourcePoint()
    local showCount = math.floor(resourceCount / 10)
    for idx = 1, self._maxTypeCount_Shy do
      self._resourceTypeShy[idx].element:SetShow(idx <= showCount)
      if not self._classResourceShowCheck[idx] and idx <= showCount then
        self._resourceTypeShy[idx].element:EraseAllEffect()
        self._resourceTypeShy[idx].element:AddEffect("fUI_PLW_Energy_01E", true, 0, 0)
      end
      self._classResourceShowCheck[idx] = idx <= showCount
    end
    self._ui.txt_ResourceCount_Shy:SetText(resourceCount)
    self._ui.txt_ResourceCount_Shy:useGlowFont(true, "BaseFont_12_Glow", 4278190080)
    self._ui.txt_ResourceCount_Shy:SetShow(true)
  elseif __eClassType_BladeMasterWoman == classType then
    if PaGlobal_MainStatus_CanSuccessionIconEnable(__eClassType_BladeMasterWoman) == false then
      return
    end
    self._ui.stc_ClassResource_Meahwa:SetShow(true)
    local resourceCount = selfPlayer:getSubResourcePoint()
    local remainTime2 = PaGlobalAppliedBuffList:GetMaehwaBuff_RemainTime()
    if remainTime2 < 0 then
      self._ui.stc_DummyClassType3Effect:EraseAllEffect()
    end
    for idx = 1, self._maxTypeCount_Meahwa do
      self._resourceTypeMeahwa[idx].element:SetShow(idx <= resourceCount)
      if not self._classResourceShowCheck[idx] and idx <= resourceCount then
        self._resourceTypeMeahwa[idx].element:EraseAllEffect()
        self._resourceTypeMeahwa[idx].element:AddEffect("fUI_PKW_UP_Icon_03A", true, 0, 0)
        audioPostEvent_SystemUi(2, 5)
      end
      self._classResourceShowCheck[idx] = idx <= resourceCount
    end
    if resourceCount >= 2 then
      local remainTime = PaGlobalAppliedBuffList:GetMaehwaBuff_RemainTime()
      if remainTime > -1 then
        self._ui.stc_DummyClassType3Effect:EraseAllEffect()
        self._ui.stc_DummyClassType3Effect:AddEffect("fUI_PKW_UP_Icon_04A", true, 0, 0)
        audioPostEvent_SystemUi(2, 6)
        self._isShowBladeMasterWomanEffect = true
      end
    end
  elseif __eClassType_Nova == classType then
    if PaGlobal_MainStatus_CanAwakenIconEnable(__eClassType_Nova) == true then
      self._ui.stc_ClassResource_Nova:SetShow(true)
      local maxResourceCount = selfPlayer:getMaxSubResourcePoint(0)
      if maxResourceCount > 0 then
        local resourceCount = math.floor(selfPlayer:getSubResourcePoint(0))
        local showCount = resourceCount / maxResourceCount * 100
        if showCount > 100 then
          showCount = 100
        end
        self._novaEffectTime = self._maxNovaEffectTime
        self._isNovaProgressUp = showCount >= self._maxNovaProgress
        self._maxNovaProgress = showCount
        self._ui.stc_ClassResource_NovaIcon:EraseAllEffect()
        if showCount >= 100 then
          self._ui.stc_ClassResource_NovaIcon:AddEffect("fUI_PPW_ARO_Icon_02A", true, 0, 0)
        end
        if true == self._isNovaProgressUp then
          if nil ~= Panel_MainStatus_Remaster then
            Panel_MainStatus_Remaster:RegisterUpdateFunc("Panel_MainStatus_Remaster_UpdateNovaProgress")
          end
        else
          if nil ~= Panel_MainStatus_Remaster then
            Panel_MainStatus_Remaster:ClearUpdateLuaFunc()
          end
          if 1 > self._maxNovaProgress then
            self._isNovaEffectUpdate = false
            self._ui.stc_ClassResource_Nova:EraseAllEffect()
            self._curNovaProgress = 0
            self._maxNovaProgress = 0
          else
            self._curNovaProgress = self._maxNovaProgress
            if false == self._isNovaEffectUpdate then
              self._isNovaEffectUpdate = true
              self._ui.stc_ClassResource_Nova:AddEffect("fUI_test_Box", true, 0, 0)
            end
          end
          self._ui.stc_ClassResource_NovaGauge:SetProgressRate(self._curNovaProgress)
        end
      end
    else
      self._ui.stc_ClassResource_Nova:EraseAllEffect()
      self._ui.stc_ClassResource_NovaIcon:EraseAllEffect()
      Panel_MainStatus_Remaster:ClearUpdateLuaFunc()
    end
  elseif __eClassType_Corsair == classType then
    if PaGlobal_MainStatus_CanAwakenIconEnable(__eClassType_Corsair) == false then
      return
    end
    self._ui.stc_ClassResource_Corsair:SetShow(true)
    local resourceType = selfPlayer:getSubResourcePoint()
    for idx = 1, self._maxTypeCount_Corsair do
      self._resourceTypeCorsair[idx].element:EraseAllEffect()
      if idx == resourceType + 1 then
        self._resourceTypeCorsair[idx].element:SetShow(true)
        if false == self._classResourceShowCheck[idx] then
          if 0 == resourceType then
            self._resourceTypeCorsair[idx].element:AddEffect("fUI_PFW_ARO_Icon_01B", true, 0, 0)
          elseif 1 == resourceType then
            self._resourceTypeCorsair[idx].element:AddEffect("fUI_PFW_ARO_Icon_02B", true, 0, 0)
          elseif 2 == resourceType then
            self._resourceTypeCorsair[idx].element:AddEffect("fUI_PFW_ARO_Icon_03B", true, 0, 0)
          end
        end
        self._classResourceShowCheck[idx] = true
      else
        self._resourceTypeCorsair[idx].element:SetShow(false)
        self._classResourceShowCheck[idx] = false
      end
    end
  elseif __eClassType_Kunoichi == classType then
    self._ui.stc_ClassResource_Kuno:SetShow(PaGlobal_MainStatus_CanSuccessionIconEnable(__eClassType_Kunoichi))
  elseif __eClassType_Drakania == classType then
    if PaGlobal_MainStatus_CanSuccessionIconEnable(__eClassType_Drakania) == true then
      self._ui.stc_ClassResource_Drakania_Inherit:SetShow(true)
      local pqwResource = selfPlayer:getSubResourcePoint()
      if pqwResource == self._beforeCount then
        return
      end
      local rate = math.floor(pqwResource / self._maxResourceCountForPQW * 100)
      if pqwResource > self._maxResourceCountForPQW then
        rate = 100
      end
      if 0 == rate then
        self._ui.progress_PQW:EraseAllEffect()
      end
      if pqwResource < self._beforeCount then
        self._ui.progress_PQW:SetSmoothMode(false)
      else
        self._ui.progress_PQW:SetSmoothMode(true)
        self._ui.progress_PQW:SetAniSpeed(10)
      end
      self._ui.progress_PQW:SetProgressRate(rate)
      if self._maxResourceCountForPQW == pqwResource then
        self._ui.progress_PQW:EraseAllEffect()
        self._ui.progress_PQW:AddEffect("fUI_PQW_Resource_Circle_02A", true, 0, 0)
      else
        if pqwResource >= 3 and pqwResource % 3 == 0 then
          self._ui.progress_PQW:EraseAllEffect()
          if 3 == pqwResource then
            self._ui.progress_PQW:AddEffect("fUI_PQW_Resource_Circle_02A", true, 0, 0)
          elseif 6 == pqwResource then
            self._ui.progress_PQW:AddEffect("fUI_PQW_Resource_Circle_02A", true, 0, 0)
          elseif 9 == pqwResource then
            self._ui.progress_PQW:AddEffect("fUI_PQW_Resource_Circle_02A", true, 0, 0)
          elseif 12 == pqwResource then
            self._ui.progress_PQW:AddEffect("fUI_PQW_Resource_Circle_02A", true, 0, 0)
          elseif 15 == pqwResource then
            self._ui.progress_PQW:AddEffect("fUI_PQW_Resource_Circle_02A", true, 0, 0)
          end
        end
        if pqwResource >= 3 and false == showPqwLoopEffect then
          self._ui.pqwEffect2:EraseAllEffect()
          self._ui.pqwEffect2:AddEffect("fUI_PQW_Resource_Circle_02C", true, 0, 0)
          showPqwLoopEffect = true
        end
        if true == showPqwLoopEffect and pqwResource < 3 then
          self._ui.pqwEffect2:EraseAllEffect()
          showPqwLoopEffect = false
        end
        if pqwResource < self._beforeCount and (self._beforeCount - pqwResource) % 3 == 0 then
          self._ui.pqwEffect:EraseAllEffect()
          self._ui.pqwEffect:AddEffect("fUI_PQW_Resource_Circle_02B", false, 0, 0)
        end
      end
      self._beforeCount = pqwResource
    elseif PaGlobal_MainStatus_CanAwakenIconEnable(__eClassType_Drakania) == true then
      self._ui.stc_ClassResource_Drakania_Awaken:SetShow(true)
      local isChangeFormType = false
      local isDragonForm = ToClient_isDrakaniaDragonForm()
      if self._isDrakaniaDragonForm == nil then
        self._isDrakaniaDragonForm = isDragonForm
        isChangeFormType = true
      elseif self._isDrakaniaDragonForm ~= isDragonForm then
        self._isDrakaniaDragonForm = isDragonForm
        isChangeFormType = true
      end
      if isChangeFormType == true then
        self._ui.drakaniaNormalFormIcon:EraseAllEffect()
        self._ui.drakaniaDragonFormIcon:EraseAllEffect()
        if self._isDrakaniaDragonForm == true then
          self._ui.drakaniaDragonFormIcon:AddEffect("fUI_PQW_Remaster_Dragon_01A", true, 0, 0)
          self._ui.drakaniaNormalFormIcon:SetShow(false)
          self._ui.drakaniaDragonFormIcon:SetShow(true)
        else
          self._ui.drakaniaNormalFormIcon:AddEffect("fUI_PQW_Remaster_Dragon_02A", true, 0, 0)
          self._ui.drakaniaNormalFormIcon:SetShow(true)
          self._ui.drakaniaDragonFormIcon:SetShow(false)
        end
        if FromClient_SkillCommandDataSet ~= nil then
          FromClient_SkillCommandDataSet()
        end
      end
    end
  end
end
function Panel_MainStatus_Remaster_UpdateNovaProgress(deltaTime)
  if nil == Panel_MainStatus_Remaster then
    return
  end
  MainStatus._novaEffectTime = MainStatus._novaEffectTime + deltaTime
  if MainStatus._maxNovaEffectTime < MainStatus._novaEffectTime then
    MainStatus._novaEffectTime = 0
    if true == MainStatus._isNovaProgressUp then
      MainStatus._curNovaProgress = MainStatus._curNovaProgress + 1
      if MainStatus._maxNovaProgress <= MainStatus._curNovaProgress then
        MainStatus._curNovaProgress = MainStatus._maxNovaProgress
        Panel_MainStatus_Remaster:ClearUpdateLuaFunc()
      end
      MainStatus._ui.stc_ClassResource_NovaGauge:SetProgressRate(MainStatus._curNovaProgress)
    else
      Panel_MainStatus_Remaster:ClearUpdateLuaFunc()
    end
  end
end
function Panel_MainStatus_Remaster_PlayMaehwabuffSound()
  audioPostEvent_SystemUi(2, 7)
end
function Panel_MainStatus_Remaster_SetPQWResourceShow(isShow)
  if MainStatus._ui.stc_ClassResource_Drakania_Inherit == nil then
    return
  end
  if PaGlobalFunc_Util_IsSuccessionContentsOpen(__eClassType_Drakania) == false then
    MainStatus._ui.stc_ClassResource_Drakania_Inherit:SetShow(false)
    return
  end
  MainStatus._ui.stc_ClassResource_Drakania_Inherit:SetShow(isShow)
end
function Panel_MainStatus_Remaster_SetSuccessionResourceShow(checkClassType, isShow)
  local isSuccessionContentsOpen = PaGlobalFunc_Util_IsSuccessionContentsOpen(classType)
  if isSuccessionContentsOpen == false then
    isShow = false
  end
  if checkClassType == __eClassType_BladeMasterWoman then
    if MainStatus._ui.stc_ClassResource_Meahwa == nil then
      return
    end
    MainStatus._ui.stc_ClassResource_Meahwa:SetShow(isShow)
  elseif checkClassType == __eClassType_Kunoichi then
  else
    if checkClassType == __eClassType_Drakania then
      if MainStatus._ui.stc_ClassResource_Drakania_Inherit == nil then
        return
      end
      MainStatus._ui.stc_ClassResource_Drakania_Inherit:SetShow(isShow)
    else
    end
  end
end
function Panel_MainStatus_Remaster_SetAwakenResourceShow(checkClassType, isShow)
  local isAwakenContentsOpen = PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(checkClassType)
  if isAwakenContentsOpen == false then
    isShow = false
  end
  if checkClassType == __eClassType_Nova then
    if MainStatus._ui.stc_ClassResource_Nova == nil then
      return
    end
    MainStatus._ui.stc_ClassResource_Nova:SetShow(isShow)
  elseif checkClassType == __eClassType_Corsair then
    if MainStatus._ui.stc_ClassResource_Corsair == nil then
      return
    end
    MainStatus._ui.stc_ClassResource_Corsair:SetShow(isShow)
  else
    if checkClassType == __eClassType_Drakania then
      if MainStatus._ui.stc_ClassResource_Drakania_Awaken == nil then
        return
      end
      MainStatus._ui.stc_ClassResource_Drakania_Awaken:SetShow(isShow)
    else
    end
  end
end
function MainStatus:updateSkillPoint()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  PaGlobal_MainStatus_AttackStatusUpdate()
  if ToClient_isConsole() == false and enableSkill_UpdateData ~= nil then
    enableSkill_UpdateData()
  end
end
function PaGlobal_MainStatus_AttackStatusUpdate()
  local self = MainStatus
  if getSelfPlayer() == nil then
    return
  end
  local offenceStatus = 0
  local AwakenStatus = 0
  local DefenceStatus = 0
  local doUpdateColor = false
  if _ContentsGroup_RenewCharacterStatusViewMode == true and PaGlobalFunc_NotationAbility_IsLateInitialized ~= nil and PaGlobalFunc_NotationAbility_IsLateInitialized() == true then
    offenceStatus = PaGlobalFunc_NotationAbility_GetMyAtk()
    AwakenStatus = PaGlobalFunc_NotationAbility_GetMyAwakenAtk()
    DefenceStatus = PaGlobalFunc_NotationAbility_GetMyDef()
    doUpdateColor = true
  else
    if self._iniCheck == true then
      ToClient_updateAttackStat()
    end
    offenceStatus = ToClient_getOffence()
    AwakenStatus = ToClient_getAwakenOffence()
    DefenceStatus = ToClient_getDefence()
  end
  if doUpdateColor == true then
    local fontColor = PaGlobalFunc_NotationAbility_GetFontColor()
    local glowFontColor = PaGlobalFunc_NotationAbility_GetGlowFontColor()
    local iconColor = PaGlobalFunc_NotationAbility_GetIconColor()
    self._ui.txt_SkillPoint:SetColor(iconColor)
    self._ui.txt_Defence:SetColor(iconColor)
    self._ui.txt_SkillPoint:SetFontColor(fontColor)
    self._ui.txt_SkillPoint:useGlowFont(true, "BaseFont_10_Normal", glowFontColor)
    self._ui.txt_Defence:SetFontColor(fontColor)
    self._ui.txt_Defence:useGlowFont(true, "BaseFont_10_Normal", glowFontColor)
  else
    self._ui.txt_SkillPoint:SetFontColor(4294899677)
    self._ui.txt_SkillPoint:useGlowFont(true, "BaseFont_Glow", 4284572001)
    self._ui.txt_Defence:SetFontColor(4294899677)
    self._ui.txt_Defence:useGlowFont(true, "BaseFont_Glow", 4284572001)
  end
  local mySkillType = ToClient_GetCurrentPlayerSkillType()
  local isSetAwakenWeapon = ToClient_getEquipmentItem(__eEquipSlotNoAwakenWeapon)
  local isShyWomen = __eClassType_ShyWaman == getSelfPlayer():getClassType()
  local myAttakStatus = offenceStatus
  if mySkillType == __eSkillTypeParam_Inherit or mySkillType == __eSkillTypeParam_Normal then
    myAttakStatus = offenceStatus
  elseif mySkillType == __eSkillTypeParam_Awaken then
    myAttakStatus = AwakenStatus
  else
    myAttakStatus = offenceStatus
  end
  if nil ~= isSetAwakenWeapon then
    if true == isShyWomen then
      myAttakStatus = AwakenStatus
    end
  elseif true == isShyWomen then
    myAttakStatus = offenceStatus
  end
  PaGlobal_MainStatus_StatusIconChange(mySkillType, isSetAwakenWeapon, isShyWomen)
  self._ui.txt_SkillPoint:SetText(tostring(myAttakStatus))
  self._ui.txt_Defence:SetText(tostring(DefenceStatus))
  self._ui.txt_SkillPoint:addInputEvent("Mouse_On", "PaGlobal_MainStatus_StatusIconTooltip(true, " .. tostring(mySkillType) .. ", " .. tostring(isShyWomen) .. ")")
  self._ui.txt_SkillPoint:addInputEvent("Mouse_Out", "PaGlobal_MainStatus_StatusIconTooltip()")
  self._ui.txt_Defence:addInputEvent("Mouse_On", "PaGlobal_MainStatus_StatusIconTooltip(true, 99)")
  self._ui.txt_Defence:addInputEvent("Mouse_Out", "PaGlobal_MainStatus_StatusIconTooltip()")
end
function PaGlobal_MainStatus_StatusIconChange(attackType, isSetAwakenWeapon, isShyWomen)
  if attackType == nil then
    return
  end
  local self = MainStatus
  local textureIdKey = "Combine_Equip_Icon_Attack_Classic"
  if attackType == __eSkillTypeParam_Inherit then
    textureIdKey = "Combine_Equip_Icon_Attack_Classic"
  elseif attackType == __eSkillTypeParam_Awaken then
    textureIdKey = "Combine_Equip_Icon_Attack_Awaken"
  else
    textureIdKey = "Combine_Equip_Icon_Attack_Classic"
  end
  if nil ~= isSetAwakenWeapon then
    if true == isShyWomen then
      textureIdKey = "Combine_Equip_Icon_Shai"
    end
  elseif true == isShyWomen then
    textureIdKey = "Combine_Equip_Icon_Attack_Classic"
  end
  self._ui.txt_SkillPoint:ChangeTextureInfoTextureIDAsync(textureIdKey)
  self._ui.txt_SkillPoint:setRenderTexture(self._ui.txt_SkillPoint:getBaseTexture())
end
function PaGlobal_MainStatus_StatusIconTooltip(isShow, tipType, isShyWomen)
  if isShow == nil then
    TooltipSimple_Hide()
    return
  end
  local name = ""
  local desc = ""
  local control
  local isSetAwakenWeapon = ToClient_getEquipmentItem(__eEquipSlotNoAwakenWeapon)
  local _classType = getSelfPlayer():getClassType()
  if tipType == __eSkillTypeParam_Inherit or tipType == __eSkillTypeParam_Normal then
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_ATTACK")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_ATTACK_TEXT_TOOLTIP_DESC") .. [[

<PAColor0xffe7d583>- ]] .. PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TEXT_HIT") .. " : " .. tostring(ToClient_getHit()) .. "<PAOldColor>"
    if _classType == __eClassType_Scholar or _classType == __eClassType_RangerMan then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_ATTACK_TEXT_TOOLTIP_DESC2") .. [[

<PAColor0xffe7d583>- ]] .. PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TEXT_HIT") .. " : " .. tostring(ToClient_getHit()) .. "<PAOldColor>"
    end
    control = MainStatus._ui.txt_SkillPoint
  elseif tipType == 99 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_DEFENCE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_DEFENCE_TEXT_TOOLTIP_DESC") .. [[

<PAColor0xffe7d583>]] .. PAGetString(Defines.StringSheet_RESOURCE, "TOOLTIP_ITEM_TXT_DV") .. " " .. tostring(ToClient_getDv()) .. [[
<PAOldColor>
<PAColor0xffe7d583>]] .. PAGetString(Defines.StringSheet_RESOURCE, "TOOLTIP_ITEM_TXT_PV") .. " " .. tostring(ToClient_getPv()) .. "<PAOldColor>"
    control = MainStatus._ui.txt_Defence
  elseif tipType == __eSkillTypeParam_Awaken and isShyWomen == false then
    name = PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TOOLTIP_AWAKEN_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AWAKEN_TEXT_TOOLTIP_DESC") .. [[

<PAColor0xffe7d583>- ]] .. PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TEXT_HIT") .. " : " .. tostring(ToClient_getHit()) .. "<PAOldColor>"
    control = MainStatus._ui.txt_SkillPoint
  elseif isShyWomen == true then
    if isSetAwakenWeapon ~= nil then
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SHYSTAT_1")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SHYSTAT1_DESC") .. [[

<PAColor0xffe7d583>- ]] .. PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TEXT_HIT") .. " : " .. tostring(ToClient_getHit()) .. "<PAOldColor>"
      control = MainStatus._ui.txt_SkillPoint
    else
      name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_ATTACK")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_ATTACK_TEXT_TOOLTIP_DESC2") .. [[

<PAColor0xffe7d583>- ]] .. PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TEXT_HIT") .. " : " .. tostring(ToClient_getHit()) .. "<PAOldColor>"
      control = MainStatus._ui.txt_SkillPoint
    end
  else
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function MainStatus:updateContribute()
  self._ui.txt_ContributePoint:SetShow(true)
  local explorePoint = ToClient_getExplorePoint()
  if nil == explorePoint then
    self._ui.txt_ContributePoint:SetText("")
    return
  end
  local s64_exploreRequireExp = ToClient_getRequireExperienceToExplorePoint_s64()
  local cont_expRate = Int64toInt32(explorePoint:getExperience_s64()) / Int64toInt32(getRequireExplorationExperience_s64()) * 100
  local expString = string.format("%.2f", cont_expRate) .. "%"
  local nowRemainExpPoint = tostring(explorePoint:getRemainedPoint())
  local nowExpPoint = tostring(explorePoint:getAquiredPoint())
  if true == isGameServiceTypeDev() then
    self._ui.txt_ContributePoint:SetText(tostring(explorePoint:getRemainedPoint()) .. " / " .. tostring(explorePoint:getAquiredPoint()) .. " (" .. expString .. ")" .. " (" .. Int64toInt32(explorePoint:getExperience_s64()) .. " / " .. Int64toInt32(getRequireExplorationExperience_s64()) .. ")")
  else
    self._ui.txt_ContributePoint:SetText(tostring(explorePoint:getRemainedPoint()) .. " / " .. tostring(explorePoint:getAquiredPoint()) .. " (" .. expString .. ")")
  end
  if self._isFirstExplore == false then
    self._lastRemainExplorePoint = 0
    self._lastExplorePoint = 0
    self._isFirstExplore = true
    nowRemainExpPoint = 0
    nowExpPoint = 0
  end
  if self._lastContRate ~= cont_expRate then
    self._ui.txt_ContributePoint:SetNotAbleMasking(true)
    self._ui.txt_ContributePoint:EraseAllEffect()
    self._ui.txt_ContributePoint:AddEffect("fUI_Repair01", false, 0, 0)
  end
  if self._lastRemainExplorePoint ~= nowRemainExpPoint and self._isFirstExplore == true then
    audioPostEvent_SystemUi(3, 7)
    self._ui.txt_ContributePoint:EraseAllEffect()
    self._ui.txt_ContributePoint:AddEffect("UI_LevelUP_Skill", false, 0, 0)
  end
  if self._lastExplorePoint ~= nowExpPoint and self._isFirstExplore == true then
    audioPostEvent_SystemUi(3, 7)
    self._ui.txt_ContributePoint:EraseAllEffect()
    self._ui.txt_ContributePoint:AddEffect("UI_LevelUP_Skill", false, 0, 0)
  end
  self._ui.txt_ContributePoint:SetFontColor(4294899677)
  self._ui.txt_ContributePoint:useGlowFont(true, "BaseFont_Glow", 4284572001)
  self._lastContRate = cont_expRate
  self._lastRemainExplorePoint = tostring(explorePoint:getRemainedPoint())
  self._lastExplorePoint = tostring(explorePoint:getAquiredPoint())
end
function MainStatus:updateEnergy()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local Wp = selfPlayer:getWp()
  local maxWp = selfPlayer:getMaxWp()
  local wpSetProgress = 0
  if 0 ~= maxWp then
    wpSetProgress = Wp / maxWp * 100
  end
  if Wp > self._lastWP and -1 ~= self._lastWP then
    audioPostEvent_SystemUi(3, 13)
    self._ui.txt_EnergyPoint:EraseAllEffect()
    self._ui.txt_EnergyPoint:AddEffect("UI_LevelUP_Skill", false, 0, 0)
    self._ui.txt_EnergyPoint:AddEffect("fUI_LevelUP_Skill02", false, 0, 0)
  end
  self._ui.txt_EnergyPoint:SetText(tostring(Wp) .. " / " .. maxWp)
  self._ui.txt_EnergyPoint:SetEnableArea(0, 0, self._ui.txt_EnergyPoint:GetTextSizeX(), self._ui.txt_EnergyPoint:GetSizeY())
  self._ui.txt_EnergyPoint:SetFontColor(4294899677)
  self._ui.txt_EnergyPoint:useGlowFont(true, "BaseFont_Glow", 4284572001)
  self._lastWP = Wp
end
function MainStatus:updatePvP()
  if false == isPvpEnable() or false == ToClient_isAdultUser() or true == ToClient_isCantPvPChannel() then
    self._ui.btn_PVP:SetShow(false)
    return
  end
  if true == ToClient_isAdultUser() then
    self._ui.btn_PVP:SetShow(true)
  end
  if true == getPvPMode() and false == self._ui.btn_PVP:IsCheck() then
    self._ui.btn_PVP:EraseAllEffect()
    self._ui.btn_PVP:AddEffect("fUI_SkillButton02", true, 0, 0)
    self._ui.btn_PVP:AddEffect("fUI_PvPButtonLoop", true, 0, 0)
    self._ui.btn_PVP:SetCheck(true)
    self._isPvPOn = true
  elseif false == getPvPMode() and true == self._ui.btn_PVP:IsCheck() then
    self._ui.btn_PVP:EraseAllEffect()
    self._ui.btn_PVP:SetCheck(false)
    self._isPvPOn = false
  end
end
function MainStatus:setPVP(where, actorKeyRaw)
  if nil ~= actorKeyRaw then
    local actorProxyWrapper = getActor(actorKeyRaw)
    if nil == actorProxyWrapper then
      return
    end
    if false == actorProxyWrapper:get():isSelfPlayer() then
      return
    end
  end
  if false == ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eSwapRemasterUISetting) then
    return
  end
  if true == isPvpEnable() then
    self:showPVPBtn(true)
    if true == getPvPMode() then
      if self._isPvPUIInit == true then
        audioPostEvent_SystemUi(0, 9)
        audioPostEvent_SystemUi(9, 0)
        _AudioPostEvent_SystemUiForXBOX(0, 9)
        _AudioPostEvent_SystemUiForXBOX(9, 0)
      end
      self._ui.btn_PVP:SetCheck(true)
      self._ui.btn_PVP:EraseAllEffect()
      self._ui.btn_PVP:AddEffect("fUI_SkillButton02", true, 0, 0)
      self._ui.btn_PVP:AddEffect("fUI_PvPButtonLoop", true, 0, 0)
      if nil == where then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PVP_BUTTON_ON"), nil, nil, nil, not self._isPvPUIInit)
      end
      self._isPvPOn = true
    elseif true == self._isPvPOn then
      if self._isPvPUIInit == true then
        audioPostEvent_SystemUi(0, 11)
        _AudioPostEvent_SystemUiForXBOX(0, 11)
      end
      self._ui.btn_PVP:SetCheck(false)
      self._ui.btn_PVP:EraseAllEffect()
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PVP_BUTTON_OFF"), nil, nil, nil, not self._isPvPUIInit)
      self._isPvPOn = false
    else
      self._ui.btn_PVP:SetCheck(false)
    end
  else
    self:showPVPBtn(false)
  end
  self._isPvPUIInit = true
end
function MainStatus:showPVPBtn(isShow)
  if false == ToClient_isAdultUser() or true == ToClient_isCantPvPChannel() then
    self._ui.btn_PVP:SetShow(false)
    return
  end
  if self._ui.btn_PVP:GetShow() == isShow then
    return
  end
  self._ui.btn_PVP:SetShow(isShow)
end
function MainStatus:blackSpiritLock()
  if false == ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eSwapRemasterUISetting) then
    return
  end
  if false == getSelfPlayer():isEnableAdrenalin() then
    self._ui.stc_RageLock:SetShow(false)
  else
    local isUseRage = getSelfPlayer():isUseableBlackSpritSkill()
    if true == isUseRage then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_USEABLE_BLACKSPRITSKILL"), 5)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOTUSEABLE_BLACKSPRITSKILL"), 5)
    end
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eBlackSpiritSkillOnOff, isUseRage, CppEnums.VariableStorageType.eVariableStorageType_Character)
    self._ui.stc_RageLock:SetShow(not isUseRage)
  end
end
function MainStatus:updateHardCorePoint()
  local isHardCoreCharacter = _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreCharacter()
  if isHardCoreCharacter == false then
    self._ui.txt_hardCorePoint:SetShow(false)
    return
  end
  self._ui.txt_EnergyPoint:SetShow(false)
  self._ui.txt_ContributePoint:SetShow(false)
  self._ui.txt_hardCorePoint:SetText(ToClient_getHardCoreRankPoint())
  self._ui.txt_hardCorePoint:SetShow(true)
end
function PaGlobalFunc_MainStatus_UpdateAll()
  local self = MainStatus
  self:updateAll()
end
function PaGlobalFunc_MainStatus_UpdateLV()
  local self = MainStatus
  self:updateLV()
  self:checkHpAlertPostEvent()
end
function PaGlobalFunc_MainStatus_CheckHpAlertPostEvent()
  local self = MainStatus
  self:checkHpAlertPostEvent()
end
function PaGlobalFunc_MainStatus_UpdateEXP()
  local self = MainStatus
  self:updateEXP()
  self:updateSkillPoint()
end
function PaGlobalFunc_MainStatus_UpdateInjuryHP()
  local self = MainStatus
  self:updateInjuryHP()
end
function PaGlobalFunc_MainStatus_UpdateHP()
  local self = MainStatus
  self:updateHP()
end
function FromClient_MainStatus_UpdateHP(hp, maxHp, minorSiegeMaxHp, percentHp, percentProgress, isArenaZone, classType, combatResourceType)
  local self = MainStatus
  if PaGlobalFunc_IsRemasterUIOption() == false then
    return
  end
  self._percentHP = percentHp
  self:checkHpAlertPostEvent()
  if true == _panel:GetShow() and percentHp < 20 and hp < self._prevHP and self._prevHpAlertTime + 20 <= FGlobal_getLuaLoadTime() and not isArenaZone then
    if _ContentsGroup_UsePadSnapping == false then
      ToClient_RequestNakMessageRenewel(__eNakMessage_CharacterHPwarning)
    end
    self._prevHpAlertTime = FGlobal_getLuaLoadTime()
  end
  if 0 ~= maxHp and hp ~= self._prevHP or maxHp ~= self._prevMaxHP then
    self._ui.progress_HP:SetProgressRate(percentProgress)
    self._ui.progress_HPLater:SetProgressRate(percentProgress)
    self._prevHP = hp
    self._prevMaxHP = maxHp
    self:checkHpAlert(hp, minorSiegeMaxHp, false)
  end
  self._ui.hpValue:SetText(hp .. " / " .. maxHp)
end
function PaGlobalFunc_MainStatus_UpdateReplayHP()
  local self = MainStatus
end
function PaGlobalFunc_MainStatus_UpdateReplayMP()
  local self = MainStatus
end
function PaGlobalFunc_MainStatus_UpdateReplayLevel()
  local self = MainStatus
end
function PaGlobalFunc_MainStatus_UpdateMP()
  local self = MainStatus
  self:updateMP()
end
function FromClient_MainStatus_UpdateMP(mp, maxMp, percent)
  if 0 ~= maxMp and (mp ~= MainStatus._prevMP or maxMp ~= MainStatus._prevMaxMP) then
    MainStatus._ui.progress_MP:SetProgressRate(percent)
    MainStatus._ui.progress_MPLater:SetProgressRate(percent)
    MainStatus._prevMP = mp
    MainStatus._prevMaxMP = maxMp
  end
  MainStatus._ui.mpValue:SetText(mp .. " / " .. maxMp)
  FGlobal_SettingMpBarTemp()
end
function PaGlobalFunc_MainStatus_UpdateRage()
  local self = MainStatus
  self:updateRage()
end
function PaGlobalFunc_MainStatus_UpdateResource()
  local self = MainStatus
  self:updateResource()
end
function PaGlobalFunc_MainStatus_UpdateContribute()
  local self = MainStatus
  self:updateContribute()
end
function PaGlobalFunc_MainStatus_UpdateEnergy()
  local self = MainStatus
  self:updateEnergy()
end
function PaGlobalFunc_MainStatus_PVPModeChange(actorKeyRaw)
  local self = MainStatus
  if nil ~= actorKeyRaw then
    self:setPVP(nil, actorKeyRaw)
  end
end
function PaGlobalFunc_MainStatus_PVPAbleChange(actorKeyRaw)
  local self = MainStatus
  local selfWrapper = getSelfPlayer()
  if nil == selfWrapper then
    return
  end
  if selfWrapper:getActorKey() == actorKeyRaw then
    self:setPVP(selfWrapper)
  end
end
function PaGlobalFunc_MainStatus_Init()
  local self = MainStatus
  self:initialize()
end
function PaGlobalFunc_MainStatus_QuestCheck()
  local self = MainStatus
  self._oldCharacter = questList_isClearQuest(650, 1)
  if self._oldCharacter then
    self._levelUpQuestClear = questList_isClearQuest(677, 1)
  else
    self._levelUpQuestClear = questList_isClearQuest(21100, 7)
  end
end
function PaGlobalFunc_MainStatus_DangerAlertShow(isShow)
  local self = MainStatus
  if false == isShow then
    self._strongMonsterAlert = false
    return
  end
  self._strongMonsterAlert = true
  if true ~= _dangerPanel:GetShow() then
    _dangerPanel:SetShow(true, false)
    self._ui.stc_HPAlert:SetAlpha(1)
  end
  if false == self._ui.stc_HPAlert:GetShow() then
    self._ui.stc_HPAlert:SetShow(true)
  end
  self._ui.stc_HPAlert:SetVertexAniRun("Ani_Color_Danger1", true)
end
function PaGlobalFunc_MainStatus_GetPosY()
  return _panel:GetPosY()
end
function PaGlobalFunc_MainStatus_GetPosX()
  return _panel:GetPosX()
end
function PaGlobalFunc_MainStatus_GetSizeY()
  return _panel:GetSizeY()
end
function PaGlobalFunc_MainStatus_GetSizeX()
  return _panel:GetSizeX()
end
function InputMO_MainStatus_TooltipShow(isShow, tooltipType)
  local self = MainStatus
  local name = ""
  local desc = ""
  local uiControl
  if tooltipType == self._statusTooltipType.blackSpirit then
    local count = ToClient_GetApRegenAmount()
    local countString = string.format("%.2f", count / 10)
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ADRENALLIN_TOOLTIP_TITLE")
    if _ContentsGroup_BlackSpiritLock then
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ADRENALLIN_TOOLTIP_DESC_2", "count", tostring(countString))
    else
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ADRENALLIN_TOOLTIP_DESC", "count", tostring(countString))
    end
    uiControl = self._ui.progress_Rage
  elseif tooltipType == self._statusTooltipType.resource0 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PHANTOMCOUNT_MESSAGE")
    uiControl = self._ui.stc_ClassResource_Sorcerer
  elseif tooltipType == self._statusTooltipType.resource1 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_FIGHTER")
    uiControl = self._ui.stc_ClassResource_Combattant
  elseif tooltipType == self._statusTooltipType.resource2 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_SHY_DESC")
    uiControl = self._ui.stc_ClassResource_Shy
  elseif tooltipType == self._statusTooltipType.resource3 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_MAEHAW")
    uiControl = self._ui.stc_ClassResource_Meahwa
  elseif tooltipType == self._statusTooltipType.resource4 then
    local selfPlayerWrapper = getSelfPlayer()
    if nil == selfPlayerWrapper then
      return
    end
    local selfPlayer = selfPlayerWrapper:get()
    if nil == selfPlayer then
      return
    end
    local showCount = 0
    local maxResourceCount = selfPlayer:getMaxSubResourcePoint(0)
    if maxResourceCount > 0 then
      local resourceCount = math.floor(selfPlayer:getSubResourcePoint(0))
      showCount = resourceCount / maxResourceCount * 100
      if showCount > 100 then
        showCount = 100
      end
    end
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_NOVA_NAME")
    showCount = string.format("%.1f", showCount)
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_NOVA", "count", showCount)
    uiControl = self._ui.stc_ClassResource_Nova
  elseif tooltipType == self._statusTooltipType.resourceCorsairBomb then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_NAME_1")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_DESC_1")
    uiControl = self._ui.stc_ClassResource_Corsair
  elseif tooltipType == self._statusTooltipType.resourceCorsairBazooka then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_NAME_2")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_DESC_2")
    uiControl = self._ui.stc_ClassResource_Corsair
  elseif tooltipType == self._statusTooltipType.resourceCorsairCannon then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_NAME_3")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_DESC_3")
    uiControl = self._ui.stc_ClassResource_Corsair
  elseif tooltipType == self._statusTooltipType.skill then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MAINSTATUS_SKILLPOINTICON_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAINSTATUS_SKILLPOINTICON_DESC")
    uiControl = self._ui.txt_SkillPoint
  elseif tooltipType == self._statusTooltipType.energy then
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_MENTAL")
    desc = PAGetString(Defines.StringSheet_GAME, "MAINSTATUS_DESC_WP")
    uiControl = self._ui.txt_EnergyPoint
  elseif tooltipType == self._statusTooltipType.contribute then
    local _contributeBubbleText = ""
    if PaGlobal_ExplorePoint_UsingInfo == nil then
      return
    end
    PaGlobal_ExplorePoint_UsingInfo:searchHouseList()
    local houseTotal_uint32 = ToClient_getHouseTotalExplorePoint()
    PaGlobal_ExplorePoint_UsingInfo:searchNodeList()
    local nodeTotal_uint32 = ToClient_getNodeTotalExplorePoint()
    if ToClient_GetPalaceManageContentUsed() == true then
      nodeTotal_uint32 = nodeTotal_uint32 + ToClient_GetPalaceManageExplorationPoint()
    end
    PaGlobal_ExplorePoint_UsingInfo:searchItemList()
    local itemTotal_uint32 = ToClient_getItemTotalExplorePoint()
    local contributeUsePointInt = {
      houseTotal_uint32,
      nodeTotal_uint32,
      itemTotal_uint32
    }
    for i = 0, 2 do
      if 0 < contributeUsePointInt[i + 1] then
        if "" == _contributeBubbleText then
          _contributeBubbleText = self._contributeUsePoint[i] .. " " .. contributeUsePointInt[i + 1]
        else
          _contributeBubbleText = _contributeBubbleText .. " | " .. self._contributeUsePoint[i] .. " " .. contributeUsePointInt[i + 1]
        end
      end
    end
    if "" == _contributeBubbleText then
      _contributeBubbleText = PAGetString(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_4")
    elseif _ContentsGroup_UsePadSnapping == false then
      _contributeBubbleText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_5", "_contributeBubbleText", _contributeBubbleText)
    else
      _contributeBubbleText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_6", "_contributeBubbleText", _contributeBubbleText)
    end
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_GUIDE_CONTRIBUTIVENESS")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CONTRIBUTE_POINT_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_USINGEXPLOREPOINT_TOTALPOINT_TOOLTIP") .. "\n" .. _contributeBubbleText
    uiControl = self._ui.txt_ContributePoint
  elseif tooltipType == self._statusTooltipType.pvp then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PVP_TXT_ACTIVATE")
    desc = ""
    uiControl = self._ui.btn_PVP
  elseif tooltipType == self._statusTooltipType.injury then
    if false == _ContentsGroup_InjuryPercent then
      return
    end
    local player = getSelfPlayer()
    if nil == player:get() then
      return
    end
    local injuryHp = math.floor(player:get():getInjuryHp())
    if 0 == injuryHp then
      return
    end
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MAINSTATUS_INJURY_TOOLTIP_TITLE")
    desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MAINSTATUS_INJURY_TOOLTIP_DESC")
    uiControl = self._ui.stc_injury
  elseif tooltipType == self._statusTooltipType.kuno then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_KUNOICHI_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_KUNOICHI_DESC")
    uiControl = self._ui.stc_ClassResource_Kuno
  elseif tooltipType == self._statusTooltipType.drakaniaSuccession then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_PQW_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_PQW_DESC")
    uiControl = self._ui.stc_ClassResource_Drakania_Inherit
  elseif tooltipType == self._statusTooltipType.drakaniaAwaken then
    if self._isDrakaniaDragonForm == true then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_PQW_DRANGON_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_PQW_DRANGON_DESC")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_PQW_HUMAN_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_PQW_HUMAN_DESC")
    end
    uiControl = self._ui.stc_ClassResource_Drakania_Awaken
  end
  if true == isShow then
    TooltipSimple_Show(uiControl, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function FromClient_MainStatus_CheckHpAlertPostEvent(prevRenderModeList, nextRenderModeList)
  local self = MainStatus
  local currentRenderMode = {
    Defines.RenderMode.eRenderMode_Default,
    Defines.RenderMode.eRenderMode_WorldMap
  }
  if CheckRenderModebyGameMode(nextRenderModeList) or CheckRenderMode(prevRenderModeList, currentRenderMode) then
    self:updateHP()
    self:updateMP()
  end
  PaGlobalFunc_MainStatus_SetShow(true)
end
function FromClient_MainStatus_OnResize()
  local self = MainStatus
  _dangerPanel:ComputePos()
  self._ui.stc_HPAlert:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
  _panel:ComputePos()
  FGlobal_PanelRepostionbyScreenOut(_panel)
  self:addStatusEffect()
  self:setMPBarTexture()
  PaGlobalFunc_MainStatus_SetShow(true)
end
function FromClient_notifyUpdateGrowStep_MainStatus(key, bool)
  if nil == key or nil == bool then
    return
  end
  if __eGrowStep_explorePoint == key then
    MainStatus._ui.txt_ContributePoint:SetShow(bool)
  end
end
function PaGlobalFunc_MainStatus_SetShow(isShow, isAni, isForce)
  local self = MainStatus
  if true == isForce then
    if _panel:GetShow() == isShow then
      return
    end
    if nil == isAni then
      _panel:SetShow(isShow)
    else
      _panel:SetShow(isShow, isAni)
    end
    self:updateAll()
    return
  end
  local isGetUIInfo = false
  if true == _ContentsGroup_UsePadSnapping then
    if true == isShow then
      if 0 == ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_MainStatusRemaster, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow) then
        isGetUIInfo = false
      else
        isGetUIInfo = true
      end
    end
  elseif true == PaGlobalFunc_IsRemasterUIOption() then
    isGetUIInfo = true
    if true == isShow and 0 == ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_MainStatusRemaster, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow) then
      isGetUIInfo = false
    end
  end
  if nil == isAni then
    _panel:SetShow(isGetUIInfo)
  else
    _panel:SetShow(isGetUIInfo, isAni)
  end
  self:updateAll()
end
function FromClient_MainStatus_BlackSpiritLock()
  local self = MainStatus
  self:blackSpiritLock()
end
function PaGlobalFunc_MainStatus_ImmediatelyResurrection(resurrFunc)
  local self = MainStatus
  self._prevHp = resurrFunc
end
function PaGlobalFunc_MainStatus_CharacterInfoWindowUpdate()
  local self = MainStatus
  self:updateHP()
  self:updateMP()
end
function PaGlobalFunc_BubbleText_49Level_Update()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local self = MainStatus
  local player = selfPlayer:get()
  local nowLevel = player:getLevel()
  local levelText
  local temporaryWrapper = getTemporaryInformationWrapper()
  local family50LevelCheck = ToClient_UserHasOverLevelCharacter(50)
  local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
  local newbieUser = 2 == userType
  local returnUser = 1 == userType
  if false == self._levelUpQuestClear and nowLevel >= 49 and nowLevel < 60 then
    if self._oldCharacter then
      levelText = PAGetString(Defines.StringSheet_GAME, "LUA_MAXLEVELUP_YESLIMIT_NOBOSS")
    else
      levelText = PAGetString(Defines.StringSheet_GAME, "LUA_MAXLEVELUP_NOLIMIT_YESBOSS")
    end
  end
  if false == family50LevelCheck and 49 == nowLevel and (newbieUser or returnUser) and levelText ~= nil then
    self._ui.txt_BubbleAlert:SetShow(true)
    self._ui.txt_BubbleAlert:SetText(levelText)
    self._ui.txt_BubbleAlert:SetSize(self._ui.txt_BubbleAlert:GetTextSizeX() + 18, self._ui.txt_BubbleAlert:GetTextSizeY() + 35)
  else
    self._ui.txt_BubbleAlert:SetShow(false)
  end
end
function PaGlobalFunc_MainStatus_ShowPVPButton(isShow)
  local self = MainStatus
  self:showPVPBtn(isShow)
end
function PaGlobalFunc_MainStatus_ShowFromTutorial()
  _panel:SetShow(true)
end
function PaGlobalFunc_MainStatus_GetShow()
  return _panel:GetShow()
end
function PaGlobalFunc_MainStatus_UpdateEnergyEffect()
  if nil == _panel or false == _panel:GetShow() then
    return
  end
  MainStatus._ui.txt_EnergyPoint:EraseAllEffect()
  MainStatus._ui.txt_EnergyPoint:AddEffect("UI_LevelUP_Skill", false, 0, 0)
  MainStatus._ui.txt_EnergyPoint:AddEffect("fUI_LevelUP_Skill02", false, 0, 0)
end
function PaGlobalFunc_MainStatus_UpdateBuffList()
  if nil == _panel or false == _panel:GetShow() then
    return
  end
  if true == MainStatus._ui.stc_ClassResource_Meahwa:GetShow() then
    if nil == MainStatus._resourceTypeMeahwa[3] then
      return
    end
    local BuffKey = 18634
    local appliedBuff = getSelfPlayer():getAppliedBuffBegin(false)
    while nil ~= appliedBuff do
      if appliedBuff:getBuffKey() == BuffKey then
        return
      end
      appliedBuff = getSelfPlayer():getAppliedBuffNext(false)
    end
    if self._isShowBladeMasterWomanEffect == false then
      return
    end
    MainStatus._ui.stc_DummyClassType3Effect:EraseAllEffect()
    MainStatus._ui.stc_DummyClassType3Effect:AddEffect("fUI_PKW_UP_Icon_04B", false, 0, 0)
    Panel_MainStatus_Remaster_PlayMaehwabuffSound()
    self._isShowBladeMasterWomanEffect = false
  end
  if true == MainStatus._ui.stc_ClassResource_Kuno:GetShow() then
    for idx = 1, MainStatus._maxTypeCount_Kuno do
      MainStatus._resourceTypeKuno[idx].element:SetShow(false)
      MainStatus._resourceTypeKuno[idx].bg:SetShow(true)
    end
    local appliedBuff = getSelfPlayer():getAppliedBuffBegin(false)
    while nil ~= appliedBuff do
      if 18679 == appliedBuff:getBuffKey() then
        MainStatus._resourceTypeKuno[1].element:SetShow(true)
        MainStatus._resourceTypeKuno[1].bg:SetShow(false)
      elseif 18680 == appliedBuff:getBuffKey() then
        MainStatus._resourceTypeKuno[2].element:SetShow(true)
        MainStatus._resourceTypeKuno[2].bg:SetShow(false)
      elseif 18681 == appliedBuff:getBuffKey() then
        MainStatus._resourceTypeKuno[3].element:SetShow(true)
        MainStatus._resourceTypeKuno[3].bg:SetShow(false)
      end
      appliedBuff = getSelfPlayer():getAppliedBuffNext(false)
    end
  end
end
function PaGlobal_MainStatus_CanSuccessionIconEnable(classType)
  if PaGlobalFunc_Util_IsSuccessionContentsOpen(classType) == false then
    return false
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return false
  end
  local checkClassType = selfPlayer:getClassType()
  if checkClassType ~= classType then
    return false
  end
  if checkClassType ~= __eClassType_BladeMasterWoman and checkClassType ~= __eClassType_Kunoichi and checkClassType ~= __eClassType_Drakania then
    return false
  end
  local isSuccession = __eSkillTypeParam_Inherit == ToClient_GetSelfPlayerSkillType()
  if isSuccession == true then
    if checkClassType == __eClassType_Kunoichi then
      local successionRoot = ToClient_getSuccessionRootSkillGroupNo(classType)
      local skillKey = ToClient_getSkillKeyBySkillGroupNo(successionRoot, 1)
      isSuccession = ToClient_isLearnedSkill(skillKey:getSkillNo())
    elseif checkClassType == __eClassType_Drakania then
      isSuccession = ToClient_isLearnedSkill(6933)
    end
  end
  if Panel_MainStatus_Remaster ~= nil and Panel_MainStatus_Remaster:GetShow() == true and Panel_MainStatus_Remaster_SetSuccessionResourceShow ~= nil then
    Panel_MainStatus_Remaster_SetSuccessionResourceShow(classType, isSuccession)
  end
  return isAwaken
end
function PaGlobal_MainStatus_CanAwakenIconEnable(classType)
  if PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(classType) == false then
    return false
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return false
  end
  local checkClassType = selfPlayer:getClassType()
  if checkClassType ~= classType then
    return false
  end
  if checkClassType ~= __eClassType_Nova and checkClassType ~= __eClassType_Corsair and checkClassType ~= __eClassType_Drakania then
    return false
  end
  local isAwaken = __eSkillTypeParam_Awaken == ToClient_GetSelfPlayerSkillType()
  if Panel_MainStatus_Remaster ~= nil and Panel_MainStatus_Remaster:GetShow() == true and Panel_MainStatus_Remaster_SetAwakenResourceShow ~= nil then
    Panel_MainStatus_Remaster_SetAwakenResourceShow(classType, isAwaken)
  end
  return isAwaken
end
function PaGlobalFunc_MainStatus_HardCoreSurvivalPoint()
  if _ContentsGroup_HardCoreChannel == false then
    return
  end
  local self = MainStatus
  self:updateHardCorePoint()
end
registerEvent("FromClient_luaLoadComplete", "PaGlobalFunc_MainStatus_Init")
registerEvent("FromClient_UpdateQuestList", "PaGlobalFunc_MainStatus_QuestCheck")
registerEvent("EventEquipmentUpdate", "PaGlobal_MainStatus_AttackStatusUpdate")
registerEvent("ResponseBuff_changeBuffList", "PaGlobalFunc_MainStatus_UpdateBuffList")
