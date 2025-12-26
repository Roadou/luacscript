local _panel = Panel_MainStatus_Remaster
local _dangerPanel = Panel_Danger
local MainStatus = {
  _ui = {
    stc_ExpBG = UI.getChildControl(_panel, "Static_ExpBG"),
    progress_Exp = UI.getChildControl(_panel, "CircularProgress_EXP"),
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
    stc_ClassResourceBG = UI.getChildControl(_panel, "Static_ClassResourceBG"),
    stc_DummyClassType3Effect = nil,
    stc_HPAlert = UI.getChildControl(_dangerPanel, "Static_Alert")
  },
  _statusTooltipType = {
    resource0 = 0,
    resource1 = 1,
    blackSpirit = 2,
    injury = 3,
    resource2 = 4,
    resource3 = 5,
    resource4 = 6,
    resourceCorsairBomb = 7,
    resourceCorsairBazooka = 8,
    resourceCorsairCannon = 9,
    kuno = 10,
    drakaniaSuccession = 11,
    drakaniaAwaken = 12
  },
  _lastLevel = 0,
  _isSixteenLV = false,
  _lastExplorePoint = 0,
  _lastRemainExplorePoint = 0,
  _lastContRate = 0,
  _isFirstExplore = false,
  _lastWP = -1,
  _prevHpAlertTime = 0,
  _prevHP = 0,
  _prevMaxHP = 0,
  _prevInjuryHP = 0,
  _alertHpValue = 40,
  _strongMonsterAlert = false,
  _prevMP = 0,
  _prevMaxMP = 0,
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
  _isDrakaniaDragonForm = nil
}
function MainStatus:initialize()
  if true == _ContentsGroup_UsePadSnapping then
    _dangerPanel:SetOffsetIgnorePanel(true)
    _dangerPanel:ComputePos()
  end
  self._ui.txt_LV = UI.getChildControl(self._ui.stc_ExpBG, "StaticText_Lv")
  self._ui.txt_EXP = UI.getChildControl(self._ui.stc_ExpBG, "StaticText_EXP")
  self._ui.progress_HPInjury = UI.getChildControl(self._ui.stc_injury, "Progress2_HP_Injury")
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
  PaGlobalFunc_MainStatus_QuestCheck()
  self:updateAll()
  PaGlobalFunc_MainStatus_SetShow(true)
end
function MainStatus:registEventHandler()
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
  registerEvent("FromClient_UpdateAdrenalin", "PaGlobalFunc_MainStatus_UpdateRage")
  registerEvent("FromClient_ChangeAdrenalinMode", "PaGlobalFunc_MainStatus_UpdateRage")
  registerEvent("FromClient_UseableBlackSpritSkill", "FromClient_MainStatus_BlackSpiritLock")
  registerEvent("FromClient_RenderModeChangeState", "FromClient_MainStatus_CheckHpAlertPostEvent")
  registerEvent("onScreenResize", "FromClient_MainStatus_OnResize")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "FromClient_MainStatus_OnResize")
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
  self:updateInjuryHP()
  PaGlobalFunc_MainStatus_UpdateBuffList()
end
function MainStatus:updateLV()
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
end
function MainStatus:updateInjuryHP()
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
  local self = MainStatus
  if 0 ~= maxMp and (mp ~= self._prevMP or maxMp ~= self._prevMaxMP) then
    local effectSizeX = 185
    self._ui.progress_MP:SetProgressRate(percent)
    self._ui.progress_MPLater:SetProgressRate(percent)
    self._prevMP = mp
    self._prevMaxMP = maxMp
    local effectPosX = self._ui.stc_MPBG:GetSizeX() * mp / maxMp - effectSizeX
  end
  self._ui.mpValue:SetText(mp .. " / " .. maxMp)
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
function PaGlobalFunc_MainStatus_SetShow(isShow, isAni, isForce)
  local self = MainStatus
  if _panel:GetShow() == isShow then
    return
  end
  if isAni == nil then
    _panel:SetShow(isShow)
  else
    _panel:SetShow(isShow, isAni)
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
function PaGlobalFunc_MainStatus_GetShow()
  return _panel:GetShow()
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
registerEvent("FromClient_luaLoadComplete", "PaGlobalFunc_MainStatus_Init")
registerEvent("FromClient_UpdateQuestList", "PaGlobalFunc_MainStatus_QuestCheck")
registerEvent("ResponseBuff_changeBuffList", "PaGlobalFunc_MainStatus_UpdateBuffList")
