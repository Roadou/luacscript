function PaGlobal_PetList_All:initialize()
  if true == PaGlobal_PetList_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._isConsoleService = ToClient_isConsole()
  if _ContentsGroup_PetPresetExpansion == true then
    self._maxPresetCount = ToClient_GetMaxPetPresetCount()
  end
  self._ui.stc_TitleBG = UI.getChildControl(Panel_Window_PetList_All, "Static_TitleBG")
  self._ui_pc.chk_Popup = UI.getChildControl(self._ui.stc_TitleBG, "CheckButton_PopUp")
  self._ui_pc.btn_Question = UI.getChildControl(self._ui.stc_TitleBG, "Button_Question")
  self._ui_pc.btn_Close = UI.getChildControl(self._ui.stc_TitleBG, "Button_Win_Close")
  self._ui.stc_InsideBG = UI.getChildControl(Panel_Window_PetList_All, "Static_InsideBg")
  self._ui.stc_Line = UI.getChildControl(self._ui.stc_InsideBG, "Static_Line_1")
  self._ui.list2_Pet = UI.getChildControl(Panel_Window_PetList_All, "List2_PetList")
  self._ui_pc.stc_DesBG = UI.getChildControl(Panel_Window_PetList_All, "Static_Bg_Des")
  self._ui_pc.txt_DesL = UI.getChildControl(self._ui_pc.stc_DesBG, "StaticText_Des_MouseL")
  self._ui_pc.txt_DesR = UI.getChildControl(self._ui_pc.stc_DesBG, "StaticText_Des_MouseR")
  self._ui_pc.txt_Des = UI.getChildControl(self._ui_pc.stc_DesBG, "StaticText_Des")
  self._ui_pc.stc_FindGroupBG = UI.getChildControl(Panel_Window_PetList_All, "Static_FindGroupBG")
  self._ui_pc.txt_FindGroupTitle = UI.getChildControl(self._ui_pc.stc_FindGroupBG, "StaticText_GroupTitle")
  self._ui_pc.btn_ResetGroup = UI.getChildControl(self._ui_pc.stc_FindGroupBG, "Button_ClearGroup")
  self._ui.btn_Edit = UI.getChildControl(self._ui_pc.stc_FindGroupBG, "Button_Edit")
  self._ui_pc.stc_BtnGroup = UI.getChildControl(Panel_Window_PetList_All, "Static_ButtonBG_PCUI")
  self._ui_pc.btn_Exchange = UI.getChildControl(self._ui_pc.stc_BtnGroup, "Button_Compose")
  self._ui_pc.btn_AllFeeding = UI.getChildControl(self._ui_pc.stc_BtnGroup, "Button_FeedingAll")
  self._ui_pc.btn_AllSeal = UI.getChildControl(self._ui_pc.stc_BtnGroup, "Button_AllUnSeal")
  self._ui_pc.btn_Market = UI.getChildControl(self._ui_pc.stc_BtnGroup, "Button_Market")
  self._ui_console.stc_Bottom_KeyGuideBG = UI.getChildControl(Panel_Window_PetList_All, "Static_BottomBG_ConsoleUI")
  self._ui_console.stc_Bottom_KeyGuideLTA = UI.getChildControl(self._ui_console.stc_Bottom_KeyGuideBG, "StaticText_Command_ConsoleUI")
  self._ui_console.stc_Bottom_KeyGuideA = UI.getChildControl(self._ui_console.stc_Bottom_KeyGuideBG, "StaticText_Confirm_ConsoleUI")
  self._ui_console.stc_Bottom_KeyGuideB = UI.getChildControl(self._ui_console.stc_Bottom_KeyGuideBG, "StaticText_Close_ConsoleUI")
  self._ui_console.stc_Bottom_KeyGuideX = UI.getChildControl(self._ui_console.stc_Bottom_KeyGuideBG, "StaticText_FeedAll_ConsoleUI")
  self._ui_console.stc_Bottom_KeyGuideY = UI.getChildControl(self._ui_console.stc_Bottom_KeyGuideBG, "StaticText_SealAll_ConsoleUI")
  self._ui_console.stc_Bottom_KeyGuideRSHori = UI.getChildControl(self._ui_console.stc_Bottom_KeyGuideBG, "StaticText_GroupSelect_ConsoleUI")
  self._ui_console.stc_Bottom_KeyGuideRSClick = UI.getChildControl(self._ui_console.stc_Bottom_KeyGuideBG, "StaticText_GroupUnSeal_ConsoleUI")
  self._ui_console.stc_Bottom_KeyGuideLTPressRSClick = UI.getChildControl(self._ui_console.stc_Bottom_KeyGuideBG, "StaticText_CrearGroup_ConsoleUI")
  self._ui_pc.stc_FilterBG = UI.getChildControl(Panel_Window_PetList_All, "Static_FilterBg")
  self._ui_pc.rdo_All = UI.getChildControl(self._ui_pc.stc_FilterBG, "RadioButton_All")
  self._ui_pc.rdo_Normal = UI.getChildControl(self._ui_pc.stc_FilterBG, "RadioButton_Normal")
  self._ui_pc.rdo_PCRoom = UI.getChildControl(self._ui_pc.stc_FilterBG, "RadioButton_PCRoom")
  self._ui_pc.btn_RegistPCRoom = UI.getChildControl(Panel_Window_PetList_All, "Button_RegistPCRoom")
  self._ui.stc_SkillInfoBG = UI.getChildControl(Panel_Window_PetList_All, "Static_SkillInfoBg")
  self._ui.txt_SkillListDesc = UI.getChildControl(self._ui.stc_SkillInfoBG, "StaticText_SkillListDesc")
  self._ui.txt_LeaderSkillListTitle = UI.getChildControl(self._ui.stc_SkillInfoBG, "StaticText_LeaderSkillListTitle")
  self._ui.txt_LeaderSkillList = UI.getChildControl(self._ui.stc_SkillInfoBG, "StaticText_LeaderSkillList")
  self._ui.txt_BaseSkillTitle = UI.getChildControl(self._ui.stc_SkillInfoBG, "StaticText_BaseSkillListTitle")
  self._ui.txt_BaseSkill = UI.getChildControl(self._ui.stc_SkillInfoBG, "StaticText_BaseSkillList")
  self._ui.txt_SkillListTitle = UI.getChildControl(self._ui.stc_SkillInfoBG, "StaticText_SkillList_Title")
  self._ui.txt_SkillList = UI.getChildControl(self._ui.stc_SkillInfoBG, "StaticText_SkillList")
  self._ui.txt_TierSetListTitle = UI.getChildControl(self._ui.stc_SkillInfoBG, "StaticText_TierSet_Title")
  self._ui.txt_TierSetList = UI.getChildControl(self._ui.stc_SkillInfoBG, "StaticText_TierSetList")
  self._ui.stc_FeedingBG = UI.getChildControl(Panel_Window_PetList_All, "Static_FeedingBg")
  self._ui.stc_FeedingTitleBG = UI.getChildControl(self._ui.stc_FeedingBG, "Static_subframetitle")
  self._ui.txt_FeedingBGTitle = UI.getChildControl(self._ui.stc_FeedingBG, "StaticText_Feeding")
  self._ui.stc_FeedingIconSlot = UI.getChildControl(self._ui.stc_FeedingBG, "Static_IconBg")
  self._ui.stc_SelectedFeedingItemIcon = UI.getChildControl(self._ui.stc_FeedingBG, "Static_Selected_Item_Icon")
  self._ui_pc.btn_Feeding_FeedOne = UI.getChildControl(self._ui.stc_FeedingBG, "Button_FeedOne")
  self._ui_pc.btn_Feeding_FeedFull = UI.getChildControl(self._ui.stc_FeedingBG, "Button_FeedFull")
  self._ui_pc.btn_Feeding_Close = UI.getChildControl(self._ui.stc_FeedingBG, "Button_Close")
  self._ui.stc_AcquireBG = UI.getChildControl(Panel_Window_PetList_All, "Static_AcquireBg")
  self._ui.btn_BuyStable = UI.getChildControl(self._ui.stc_AcquireBG, "Button_BuyStable")
  self._ui.btn_BuyMarket = UI.getChildControl(self._ui.stc_AcquireBG, "Button_BuyMarket")
  self._ui_console.stc_FeedBottom_KeyGuideBG = UI.getChildControl(self._ui.stc_AcquireBG, "Static_FeedBottomBG_ConsoleUI")
  self._ui_console.stc_Feeding_KeyGuideBG = UI.getChildControl(self._ui.stc_FeedingBG, "Static_FeedBottomBG_ConsoleUI")
  self._ui_console.stc_Feeding_KeyGuideA = UI.getChildControl(self._ui_console.stc_Feeding_KeyGuideBG, "StaticText_Feed_ConsoleUI")
  self._ui_console.stc_Feeding_KeyGuideX = UI.getChildControl(self._ui_console.stc_Feeding_KeyGuideBG, "StaticText_Detail_ConsoleUI")
  self._ui_console.stc_Feeding_KeyGuideY = UI.getChildControl(self._ui_console.stc_Feeding_KeyGuideBG, "StaticText_FeedAll_ConsoleUI")
  self._ui_console.stc_Feeding_KeyGuideB = UI.getChildControl(self._ui_console.stc_Feeding_KeyGuideBG, "StaticText_Cancel_ConsoleUI")
  self._ui_console.stc_PopupBG = UI.getChildControl(Panel_Window_PetList_All, "Static_FocusBg_ConsoleUI")
  self._ui_console.rdo_Unseals = {
    feed = UI.getChildControl(self._ui_console.stc_PopupBG, "RadioButton_Unseal_Feed"),
    order = UI.getChildControl(self._ui_console.stc_PopupBG, "RadioButton_Unseal_Order"),
    info = UI.getChildControl(self._ui_console.stc_PopupBG, "RadioButton_Unseal_Info"),
    seal = UI.getChildControl(self._ui_console.stc_PopupBG, "RadioButton_Unseal_Seal")
  }
  self._ui_console.rdo_Seals = {
    unseal = UI.getChildControl(self._ui_console.stc_PopupBG, "RadioButton_Seal_Unseal"),
    exchange = UI.getChildControl(self._ui_console.stc_PopupBG, "RadioButton_Seal_Compose"),
    leader = UI.getChildControl(self._ui_console.stc_PopupBG, "RadioButton_Seal_Leader"),
    changeSkill = UI.getChildControl(self._ui_console.stc_PopupBG, "RadioButton_Seal_ChangeSkill"),
    changeName = UI.getChildControl(self._ui_console.stc_PopupBG, "RadioButton_Seal_ChangeName")
  }
  if self._isConsole == true then
    self._ui_console.petGroupingBtnList = {}
    self._ui_console.stc_Popup_KeyGuideA = UI.getChildControl(self._ui_console.stc_PopupBG, "StaticText_Confirm")
    local defaultGroupingBtn = UI.getChildControl(self._ui_console.stc_PopupBG, "RadioButton_Seal_Grouping")
    local defaultUnsealBtn = UI.getChildControl(self._ui_pc.stc_FindGroupBG, "RadioButton_AllSeal_ConsoleUI")
    for index = 1, self._maxPresetCount do
      self._ui_console.petGroupingBtnList[index] = UI.cloneControl(defaultGroupingBtn, self._ui_console.stc_PopupBG, "RadioButton_Seal_Grouping_" .. index)
      self._ui_console._btn_AllSealConsole[index] = UI.cloneControl(defaultUnsealBtn, self._ui_pc.stc_FindGroupBG, "RadioButton_AllSeal_ConsoleUI_" .. index)
      self._ui_console._btn_AllSealConsole[index]:SetShow(true)
    end
    defaultUnsealBtn:SetShow(false)
    defaultGroupingBtn:SetShow(false)
    local currentUnSealBtnPosX = defaultUnsealBtn:GetSpanSize().x
    local unsealBtnSize = defaultUnsealBtn:GetSizeX()
    local textSpanSizeY = defaultUnsealBtn:GetTextSpan().y
    if _ContentsGroup_PetPresetExpansion == true then
      unsealBtnSize = 30
      textSpanSizeY = 4
    end
    for index = 1, self._maxPresetCount do
      self._ui_console._btn_AllSealConsole[index]:SetSize(unsealBtnSize, unsealBtnSize)
      self._ui_console._btn_AllSealConsole[index]:SetEnableArea(0, 0, unsealBtnSize, unsealBtnSize)
      self._ui_console._btn_AllSealConsole[index]:SetSpanSize(currentUnSealBtnPosX, defaultUnsealBtn:GetSpanSize().y)
      self._ui_console._btn_AllSealConsole[index]:SetText(tostring(index))
      self._ui_console._btn_AllSealConsole[index]:SetTextSpan(0, textSpanSizeY)
      currentUnSealBtnPosX = currentUnSealBtnPosX + unsealBtnSize + 3
    end
  end
  self._ui._petLeader.bg = UI.getChildControl(Panel_Window_PetList_All, "Static_PetLeader_BG")
  self._ui._petLeader.unsealBg = UI.getChildControl(self._ui._petLeader.bg, "Template_Static_ListContentUnsealBG")
  self._ui._petLeader.iconBg = UI.getChildControl(self._ui._petLeader.bg, "Template_Static_IconPetBG")
  self._ui._petLeader.gradeLine = UI.getChildControl(self._ui._petLeader.bg, "Template_Static_GradeLine")
  self._ui._petLeader.icon = UI.getChildControl(self._ui._petLeader.bg, "Template_Static_IconPet")
  self._ui._petLeader.gradeMark = UI.getChildControl(self._ui._petLeader.bg, "Template_Static_GradeMark")
  self._ui._petLeader.name = UI.getChildControl(self._ui._petLeader.bg, "Template_StaticText_PetName")
  self._ui._petLeader.level = UI.getChildControl(self._ui._petLeader.bg, "Template_StaticText_Level")
  self._ui._petLeader.tier = UI.getChildControl(self._ui._petLeader.bg, "Template_StaticText_Tier")
  self._ui._petLeader.hungryBg = UI.getChildControl(self._ui._petLeader.bg, "Template_Static_Progress_Hungry_BG")
  self._ui._petLeader.hungryProgress = UI.getChildControl(self._ui._petLeader.bg, "Template_Static_Progress_Hungry")
  self._ui._petLeader.hungryPercentText = UI.getChildControl(self._ui._petLeader.bg, "StaticText_HungryPercent")
  self._ui._petLeader.hungryIcon = UI.getChildControl(self._ui._petLeader.bg, "Template_Static_HungryIcon")
  self._ui._petLeader.btnFeed = UI.getChildControl(self._ui._petLeader.bg, "Button_Feeding")
  self._ui._petLeader.btnInfo = UI.getChildControl(self._ui._petLeader.bg, "Template_Button_Info")
  self._ui._petLeader.btnChangeSkill = UI.getChildControl(self._ui._petLeader.bg, "Button_ChangeSkill")
  self._ui._petLeader.btnSeal = UI.getChildControl(self._ui._petLeader.bg, "Template_Button_Seal")
  self._ui._petLeader.property = UI.getChildControl(self._ui._petLeader.bg, "StaticText_Property")
  self._ui._petLeader.orderFollow = UI.getChildControl(self._ui._petLeader.bg, "CheckButton_Follow")
  self._ui._petLeader.orderWait = UI.getChildControl(self._ui._petLeader.bg, "CheckButton_Wait")
  self._ui._petLeader.orderFind = UI.getChildControl(self._ui._petLeader.bg, "CheckButton_Find")
  self._ui._petLeader.orderGetItem = UI.getChildControl(self._ui._petLeader.bg, "CheckButton_GetItem")
  self._ui._petLeader.orderPlay = UI.getChildControl(self._ui._petLeader.bg, "CheckButton_Play")
  self._ui._petLeader.orderPlayIcon = UI.getChildControl(self._ui._petLeader.orderPlay, "Static_PlayIcon")
  for i = 0, self._contentsSkillIconCount - 1 do
    self._ui._petLeader.skillIcon[i] = UI.getChildControl(self._ui._petLeader.bg, "Static_SkillIcon_" .. tostring(i))
  end
  self._ui._petLeader.bg:SetShow(false)
  self._originListSpanSizeY = self._ui.list2_Pet:GetSpanSize().y
  self._originListSizeY = self._ui.list2_Pet:GetSizeY()
  self._ui.btn_Guide = UI.getChildControl(Panel_Window_PetList_All, "Button_Update")
  self._ui.btn_Guide:SetShow(_ContentsGroup_PetLeader)
  local petContents = UI.getChildControl(self._ui.list2_Pet, "List2_1_Content")
  local defaultGroupBtn = UI.getChildControl(petContents, "Template_Button_GroupIndex")
  local defaultUnSealBtn = UI.getChildControl(self._ui_pc.stc_FindGroupBG, "Button_AllSeal_Group")
  for index = 1, self._maxPresetCount do
    self._ui_pc._btn_AllSeal_Group[index] = UI.cloneControl(defaultUnSealBtn, self._ui_pc.stc_FindGroupBG, "Button_AllSeal_Group" .. tostring(index))
    UI.cloneControl(defaultGroupBtn, petContents, "Template_Button_GroupIndex" .. tostring(index))
  end
  defaultGroupBtn:SetShow(false)
  defaultUnSealBtn:SetShow(false)
  local currentGroupBtnPosX = defaultGroupBtn:GetPosX()
  local currentUnSealBtnPosX = defaultUnSealBtn:GetSpanSize().x
  local groupBtnSize = defaultGroupBtn:GetSizeX()
  local unsealBtnSize = defaultUnSealBtn:GetSizeX()
  local groupBtnTextSpanSizeY = defaultGroupBtn:GetTextSpan().y
  local unsealBtnTextSpanSizeY = defaultUnSealBtn:GetTextSpan().y
  if _ContentsGroup_PetPresetExpansion == true then
    groupBtnSize = 23
    unsealBtnSize = 30
    groupBtnTextSpanSizeY = 1
    unsealBtnTextSpanSizeY = 4
  end
  for index = 1, self._maxPresetCount do
    local btnControl = UI.getChildControl(petContents, "Template_Button_GroupIndex" .. tostring(index))
    btnControl:SetSize(groupBtnSize, groupBtnSize)
    btnControl:SetEnableArea(0, 0, groupBtnSize, groupBtnSize)
    btnControl:SetPosX(currentGroupBtnPosX)
    btnControl:SetText(tostring(index))
    btnControl:SetTextSpan(0, groupBtnTextSpanSizeY)
    currentGroupBtnPosX = currentGroupBtnPosX + groupBtnSize + 2
    local unsealBtnControl = UI.getChildControl(self._ui_pc.stc_FindGroupBG, "Button_AllSeal_Group" .. tostring(index))
    unsealBtnControl:SetSize(unsealBtnSize, unsealBtnSize)
    unsealBtnControl:SetEnableArea(0, 0, unsealBtnSize, unsealBtnSize)
    unsealBtnControl:SetSpanSize(currentUnSealBtnPosX, unsealBtnControl:GetSpanSize().y)
    unsealBtnControl:SetText(tostring(index))
    unsealBtnControl:SetTextSpan(0, unsealBtnTextSpanSizeY)
    currentUnSealBtnPosX = currentUnSealBtnPosX + unsealBtnSize + 3
  end
  if _ContentsGroup_PetPresetExpansion == true then
    self._ui.btn_Edit:SetShow(false)
    self._ui.btn_Edit = UI.getChildControl(self._ui_pc.stc_FindGroupBG, "Button_EditRenew")
    self._ui.btn_Edit:SetShow(true)
    PaGlobal_PetList_All:addPanelSizeX(40)
  end
  PaGlobal_PetList_All:validate()
  PaGlobal_PetList_All:platformSetting()
  self._maxUnsealCount = ToClient_getPetUseMaxCount()
  Panel_Window_PetList_All:setGlassBackground(true)
  Panel_Window_PetList_All:ActiveMouseEventEffect(true)
  self._isPlayOpen = ToClient_IsContentsGroupOpen("256")
  self._UnSealDATACount = ToClient_getPetUnsealedList()
  self._SealDATACount = ToClient_getPetSealedList()
  if self._isConsole == true then
    self._popUpKeyGuideADefaultPosY = self._ui_console.stc_Popup_KeyGuideA:GetPosY()
    self._popUpKeyGuideAGapSizeY = self._ui_console.rdo_Seals.exchange:GetPosY() - self._ui_console.rdo_Seals.unseal:GetPosY()
  end
  self._originPanelSizeY = Panel_Window_PetList_All:GetSizeY()
  self._originInsideBGSizeY = self._ui.stc_InsideBG:GetSizeY()
  self._originPetListSpanY = self._ui.list2_Pet:GetSpanSize().y
  self._originDesBGSpanY = self._ui_pc.stc_DesBG:GetSpanSize().y
  self._originFindGroupBGSpanY = self._ui_pc.stc_FindGroupBG:GetSpanSize().y
  self._originBtnGroupSpanY = self._ui_pc.stc_BtnGroup:GetSpanSize().y
  self._originSkillInfoBGSpanY = self._ui.stc_SkillInfoBG:GetSpanSize().y
  self._originBtnRegistPCRoomSpanY = self._ui_pc.btn_RegistPCRoom:GetSpanSize().y
  self._originLeaderPetSpanY = self._ui._petLeader.bg:GetSpanSize().y
  local temporaryInformation = getTemporaryInformationWrapper()
  if nil ~= temporaryInformation and true == temporaryInformation:isPremiumPcRoom() and true == _ContentsGroup_PcRoomPet then
    self._isPremiumPcRoom = true
    self._maxUnsealCount = self._maxUnsealCount + ToClient_getPetUseMaxCountPcRoom()
    PaGlobal_PetList_All:initPCRoomFilterUi()
  end
  if not self._isConsole then
    Panel_MyHouseNavi_Update(true)
  end
  self._ui.txt_LeaderSkillListTitle:SetShow(false)
  self._ui.txt_LeaderSkillList:SetShow(false)
  self._ui.txt_SkillListDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SkillListDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PETCOMPOSE_SKILLINHERIT_DESC"))
  self._ui.txt_BaseSkill:SetTextMode(__eTextMode_AutoWrap)
  self._originSkillPosY = self._ui.txt_SkillListDesc:GetPosY() + self._ui.txt_SkillListDesc:GetTextSizeY() + 20
  self._ui.txt_LeaderSkillListTitle:SetPosY(self._originSkillPosY)
  self._ui.txt_LeaderSkillList:SetPosY(self._originSkillPosY + 40)
  local desLSizeX = self._ui_pc.txt_DesL:GetSizeX() + self._ui_pc.txt_DesL:GetTextSizeX()
  self._ui_pc.txt_DesL:SetSpanSize(-desLSizeX / 2, self._ui_pc.txt_DesL:GetSpanSize().y)
  local desRSizeX = self._ui_pc.txt_DesR:GetSizeX() + self._ui_pc.txt_DesR:GetTextSizeX()
  self._ui_pc.txt_DesR:SetSpanSize(desRSizeX - 5, self._ui_pc.txt_DesR:GetSpanSize().y)
  if true == ToClient_isConsole() then
    PaGlobalFunc_TopIcon_Pet_Update()
  else
    FGlobal_PetListNew_NoPet()
  end
  PaGlobal_PetList_All:initFeedUi()
  PaGlobal_PetList_All:showFeedUi(-1)
  PaGlobal_PetList_All:skillBGClose()
  PaGlobal_PetList_All:resize()
  PaGlobal_PetList_All:registEventHandler()
  PaGlobal_PetList_All._initialize = true
end
function PaGlobal_PetList_All:savePetGroupList(petNoStr, groupIndex)
  if _ContentsGroup_PetPresetExpansion == true then
    local petNo_s64 = tonumber64(petNoStr)
    ToClient_ChangePetPresetInfo(groupIndex, petNo_s64)
  else
    ToClient_clearPetGroupList()
    for ii = 1, self._GroupCount do
      if self._checkUnSealGroupList[ii] ~= nil then
        for key, value in pairs(self._checkUnSealGroupList[ii]) do
          if value ~= nil and value == true then
            local petNo_s64 = tonumber64(key)
            ToClient_savePetGroupList(ii, petNo_s64)
          end
        end
      end
    end
  end
end
function PaGlobal_PetList_All:addControlSizeX(control, sizeX)
  if control == nil then
    return
  end
  control:SetSize(control:GetSizeX() + sizeX, control:GetSizeY())
end
function PaGlobal_PetList_All:addPanelSizeX(sizeX)
  if Panel_Window_PetList_All == nil then
    return
  end
  local titleBg = UI.getChildControl(Panel_Window_PetList_All, "Static_TitleBG")
  local petContents = UI.getChildControl(self._ui.list2_Pet, "List2_1_Content")
  local sealListBg = UI.getChildControl(petContents, "Template_Static_ListContentBG")
  local unsealListBg = UI.getChildControl(petContents, "Template_Static_ListContentUnsealBG")
  self:addControlSizeX(Panel_Window_PetList_All, sizeX)
  self:addControlSizeX(titleBg, sizeX)
  self:addControlSizeX(petContents, sizeX)
  self:addControlSizeX(sealListBg, sizeX)
  self:addControlSizeX(unsealListBg, sizeX)
  self:addControlSizeX(self._ui.stc_InsideBG, sizeX)
  self:addControlSizeX(self._ui.list2_Pet, sizeX)
  self:addControlSizeX(self._ui_pc.stc_DesBG, sizeX)
  self:addControlSizeX(self._ui_pc.stc_FindGroupBG, sizeX)
  self:addControlSizeX(self._ui_pc.stc_BtnGroup, sizeX)
  self:addControlSizeX(self._ui_pc.btn_Exchange, sizeX / 3)
  self:addControlSizeX(self._ui_pc.btn_AllFeeding, sizeX / 3)
  self:addControlSizeX(self._ui_pc.btn_AllSeal, sizeX / 3)
  self:addControlSizeX(self._ui._petLeader.bg, sizeX)
  self:addControlSizeX(self._ui._petLeader.unsealBg, sizeX)
  self._ui.stc_FeedingBG:SetSpanSize(self._ui.stc_FeedingBG:GetSpanSize().x + sizeX, self._ui.stc_FeedingBG:GetSpanSize().y)
  self._ui.stc_SkillInfoBG:SetSpanSize(self._ui.stc_SkillInfoBG:GetSpanSize().x + sizeX, self._ui.stc_SkillInfoBG:GetSpanSize().y)
  Panel_Window_PetList_All:ComputePosAllChild()
end
function PaGlobal_PetList_All:loadPetGroupList()
  self._checkUnSealGroupList = {}
  if _ContentsGroup_PetPresetExpansion == true then
    local petCount = ToClient_GetPetFusionCount()
    for key = 1, self._maxPresetCount do
      self._checkUnSealGroupList[key] = {}
      if ToClient_IsSetPetNoInPreset(key) == true then
        for index = 0, petCount - 1 do
          local petNo = tostring(ToClient_GetPetNoInPresetByIndex(key, index))
          if petNo ~= "-1" then
            self._checkUnSealGroupList[key][petNo] = true
          end
        end
      end
    end
  else
    for index = 1, self._GroupCount do
      self._checkUnSealGroupList[index] = {}
    end
    local size = ToClient_getSizePetGroupList()
    if size == 0 then
      return
    end
    for ii = 0, size do
      local petNo = ToClient_getPetNoInPetGroupByIndex(ii)
      local groupIdx = ToClient_getPetGroupIndexInPetGroupByIndex(ii)
      self._checkUnSealGroupList[groupIdx][tostring(petNo)] = true
    end
  end
end
function PaGlobal_PetList_All:checkPetGroupList()
  for ii = 1, self._GroupCount do
    for key, value in pairs(self._checkUnSealGroupList[ii]) do
      local isRemain = false
      if true == value then
        for sealPetIndex = 0, ToClient_getPetSealedList() - 1 do
          local petData = ToClient_getPetSealedDataByIndex(sealPetIndex)
          if key == tostring(petData._petNo) then
            isRemain = true
          end
        end
        for sealPetIndex = 0, ToClient_getPetUnsealedList() - 1 do
          local petData = ToClient_getPetUnsealedDataByIndex(sealPetIndex)
          if key == tostring(petData:getPcPetNo()) then
            isRemain = true
          end
        end
      end
      self._checkUnSealGroupList[ii][key] = isRemain
    end
  end
end
function PaGlobal_PetList_All:initFeedUi()
  local originalSlot = self._ui.stc_FeedingIconSlot
  originalSlot:SetShow(false)
  local slotGap = originalSlot:GetSizeX() + 5
  for i = 0, self._feedStaticItemCount - 1 do
    local additionalSlot = UI.createAndCopyBasePropertyControl(self._ui.stc_FeedingBG, "Static_IconBg", self._ui.stc_FeedingBG, "Static_IconBg" .. tostring(i))
    additionalSlot:SetPosX(originalSlot:GetPosX() + slotGap * i)
    additionalSlot:SetShow(false)
    self._feedSlot[i] = {}
    SlotItem.new(self._feedSlot[i], "FeedItem_", i, additionalSlot, self._slotConfig)
    self._feedSlot[i]:createChild()
    self._feedSlot[i].border:SetSize(34, 34)
    self._feedSlot[i].icon:SetSize(34, 34)
    self._feedSlot[i].count:ComputePos()
    if self._isConsole then
      additionalSlot:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "HandleEventDpadRight_PetList_All_FeedBlockSnapGroupMove()")
      self._feedSlot[i].icon:addInputEvent("Mouse_On", "HandleEventLUp_PetList_FeedItem_All(" .. i .. ")")
      if 0 == i then
        self._feedingFirstSlot = additionalSlot
      end
    end
  end
  if self._isConsole then
    self._ui.stc_SelectedFeedingItemIcon:SetIgnore(true)
    self._ui.stc_FeedingBG:SetSize(self._ui.stc_FeedingBG:GetSizeX(), self._ui.stc_FeedingBG:GetSizeY() - self._ui_pc.btn_Feeding_FeedOne:GetSizeY())
    self._ui_console.stc_Feeding_KeyGuideBG:SetPosY(self._ui.stc_FeedingBG:GetSizeY() - 5)
  end
end
function PaGlobal_PetList_All:initPCRoomFilterUi()
  self._ui_pc.btn_RegistPCRoom:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_RegistPCRoomPet_All()")
  self._ui_pc.btn_RegistPCRoom:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_RegistPCRoomPetTooltip_All()")
  self._ui_pc.btn_RegistPCRoom:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  local allPetButton = self._ui_pc.rdo_All
  allPetButton:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_ChangeFilter_All()")
  allPetButton:SetEnableArea(0, 0, allPetButton:GetSizeX() + allPetButton:GetTextSizeX(), allPetButton:GetSizeY())
  local normalPetButton = self._ui_pc.rdo_Normal
  normalPetButton:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_ChangeFilter_All()")
  normalPetButton:SetEnableArea(0, 0, normalPetButton:GetSizeX() + normalPetButton:GetTextSizeX(), normalPetButton:GetSizeY())
  local pcRoomPetButton = self._ui_pc.rdo_PCRoom
  pcRoomPetButton:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_ChangeFilter_All()")
  pcRoomPetButton:SetEnableArea(0, 0, pcRoomPetButton:GetSizeX() + pcRoomPetButton:GetTextSizeX(), pcRoomPetButton:GetSizeY())
  allPetButton:SetCheck(true)
  self._pcFilterInitialize = true
end
function PaGlobal_PetList_All:platformSetting()
  if nil == Panel_Window_PetList_All then
    return
  end
  for _, control in pairs(self._ui_pc) do
    if "table" ~= type(control) then
      control:SetShow(not self._isConsole)
    end
  end
  for _, control in pairs(self._ui_console) do
    if "table" ~= type(control) then
      control:SetShow(self._isConsole)
    end
  end
  if self._isConsole then
    local originSpanSize = Panel_Window_PetList_All:GetSpanSize()
    Panel_Window_PetList_All:SetSpanSize(originSpanSize.x, originSpanSize.y - 50)
    self:closePopUP()
    self._mainKeyGuides = {
      self._ui_console.stc_Bottom_KeyGuideLTPressRSClick,
      self._ui_console.stc_Bottom_KeyGuideRSHori,
      self._ui_console.stc_Bottom_KeyGuideRSClick,
      self._ui_console.stc_Bottom_KeyGuideLTA,
      self._ui_console.stc_Bottom_KeyGuideX,
      self._ui_console.stc_Bottom_KeyGuideY,
      self._ui_console.stc_Bottom_KeyGuideA,
      self._ui_console.stc_Bottom_KeyGuideB
    }
    self._feedKeyGuides = {
      self._ui_console.stc_Feeding_KeyGuideX,
      self._ui_console.stc_Feeding_KeyGuideY,
      self._ui_console.stc_Feeding_KeyGuideA,
      self._ui_console.stc_Feeding_KeyGuideB
    }
    self:updateConsoleKeyGuide(self._keyGuideAlignType.basic)
    local list2SizeY = self._ui.stc_InsideBG:GetSizeY() - 2
    self._ui.list2_Pet:SetSize(self._ui.list2_Pet:GetSizeX(), list2SizeY)
    self._ui_pc.stc_FindGroupBG:SetShow(true)
    self._ui_pc.stc_FindGroupBG:SetSpanSize(self._ui_pc.stc_FindGroupBG:GetSpanSize().x, self._ui_pc.stc_FindGroupBG:GetSpanSize().y + self._ui_pc._btn_AllSeal_Group[1]:GetSizeY() + 10)
    self._ui_pc.txt_FindGroupTitle:SetShow(true)
    for i = 1, self._maxPresetCount do
      self._ui_console._btn_AllSealConsole[i]:SetIgnore(true)
      self._ui_console._btn_AllSealConsole[i]:SetShow(true)
      self._ui_pc._btn_AllSeal_Group[i]:SetShow(false)
    end
  end
  self._ui_pc.btn_Market:SetShow(false)
  self._ui_pc.chk_Popup:SetShow(false)
  self._ui_pc.stc_FilterBG:SetShow(false)
  self._ui_pc.btn_RegistPCRoom:SetShow(false)
end
function PaGlobal_PetList_All:resize()
  if nil == Panel_Window_PetList_All then
    return
  end
end
function PaGlobal_PetList_All:registEventHandler()
  if nil == Panel_Window_PetList_All then
    return
  end
  self._ui.list2_Pet:addInputEvent("Mouse_UpScroll", "HandleEventScroll_PetList_EraseAllEffect()")
  self._ui.list2_Pet:addInputEvent("Mouse_DownScroll", "HandleEventScroll_PetList_EraseAllEffect()")
  registerEvent("FromClient_PetAddSealedList", "FromClient_PetList_SealPetUpdate_All")
  registerEvent("FromClient_PetDelList", "FromClient_PetList_PetUpdate_All")
  registerEvent("FromClient_InputPetName", "FromClient_PetList_PetUpdate_All")
  registerEvent("FromClient_PetInfoChanged", "FromClient_PetList_PetUpdate_All")
  registerEvent("FromClient_PetDelSealedList", "FromClient_PetList_UnsealPetUpdate_All")
  registerEvent("FromClient_InventoryUpdate", "FromClient_PetList_UpdateFeedUi_All")
  registerEvent("FromClient_UpdateControlIconInfo", "PaGlobal_PetList_UpdateControlIconInfo_All")
  registerEvent("FromClient_UpdateControl", "PaGlobal_PetList_UpdateControl_All")
  registerEvent("FromClient_PetSetStaticUpdate", "FromClient_PetList_PetUpdate_All")
  registerEvent("FromClient_RefreshPcRoomState", "FromClient_PetList_All_RefreshPcRoomState")
  registerEvent("FromClient_PetLeaderChangeComplete", "FromClient_PetList_ChangePetLeader")
  registerEvent("FromClient_PetSkillChange", "FromClient_PetList_PetSkillChange")
  registerEvent("FromClient_UsePetSkillChangeItem", "FromClient_UsePetSkillChangeItem")
  registerEvent("FromClient_UpdatePetPreset", "FromClient_PetList_UpdatePetPreset")
  registerEvent("FromClient_UpdatePetPresetAll", "FromClient_PetList_UpdatePetPresetAll")
  ToClient_getPetInitLuaInfo()
  self._ui.list2_Pet:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_PetList_ListCreate_All")
  self._ui.list2_Pet:createChildContent(__ePAUIList2ElementManagerType_List)
  if self._isConsole then
    local unsealBtns = self._ui_console.rdo_Unseals
    local sealBtns = self._ui_console.rdo_Seals
    for _, control in pairs(unsealBtns) do
      control:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "HandleEventDpadRight_PetList_All_PopUPBlockSnapGroupMove()")
    end
    for _, control in pairs(sealBtns) do
      control:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "HandleEventDpadRight_PetList_All_PopUPBlockSnapGroupMove()")
    end
    unsealBtns.feed:addInputEvent("Mouse_On", "HandleEventMOn_PetList_All_SetKeyGuideA(0)")
    unsealBtns.order:addInputEvent("Mouse_On", "HandleEventMOn_PetList_All_SetKeyGuideA(1)")
    unsealBtns.info:addInputEvent("Mouse_On", "HandleEventMOn_PetList_All_SetKeyGuideA(2)")
    unsealBtns.seal:addInputEvent("Mouse_On", "HandleEventMOn_PetList_All_SetKeyGuideA(3)")
    sealBtns.unseal:addInputEvent("Mouse_On", "HandleEventMOn_PetList_All_SetKeyGuideA(0)")
    sealBtns.exchange:addInputEvent("Mouse_On", "HandleEventMOn_PetList_All_SetKeyGuideA(1)")
    sealBtns.changeName:addInputEvent("Mouse_On", "HandleEventMOn_PetList_All_SetKeyGuideA(2)")
    Panel_Window_PetList_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPadX_PetList_All()")
    Panel_Window_PetList_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventPadY_PetList_All()")
    Panel_Window_PetList_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobal_PetCommand_All_Open()")
    Panel_Window_PetList_All:registerPadEvent(__eConsoleUIPadEvent_RSClick, "HandleEventLUp_PetList_GroupUnseal_All()")
    Panel_Window_PetList_All:registerPadEvent(__eConsoleUIPadEvent_RStickLeft, "PaGlobal_PetList_All_SetGroupIndexForConsole(false)")
    Panel_Window_PetList_All:registerPadEvent(__eConsoleUIPadEvent_RStickRight, "PaGlobal_PetList_All_SetGroupIndexForConsole(true)")
    Panel_Window_PetList_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_RSClick, "HandleEventLUp_PetList_GroupClear_All()")
  else
    registerEvent("FromClient_PetAddSealedList", "FGlobal_PetListNew_NoPet")
    registerEvent("FromClient_PetInfoChanged", "FGlobal_PetListNew_NoPet")
    registerEvent("FromClient_PetAddList", "FGlobal_PetListNew_NoPet")
    self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_PetList_Close_All()")
    self._ui_pc.btn_Exchange:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_Exchange_All()")
    self._ui_pc.btn_Exchange:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(true, 2)")
    self._ui_pc.btn_Exchange:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(false)")
    self._ui_pc.btn_AllFeeding:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_FeedToAll_All()")
    self._ui_pc.btn_AllSeal:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_SealAllPet_All()")
    self._ui_pc.btn_AllSeal:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(true, 3)")
    self._ui_pc.btn_AllSeal:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(false)")
    self._ui_pc.btn_AllSeal:setButtonShortcuts("PANEL_SIMPLESHORTCUT_PET_ALLGROUP")
    for i = 1, self._maxPresetCount do
      self._ui_pc._btn_AllSeal_Group[i]:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_GroupUnseal_All(" .. i .. ")")
      self._ui_pc._btn_AllSeal_Group[i]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(true, 1, " .. i .. ")")
      self._ui_pc._btn_AllSeal_Group[i]:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(false)")
      if i >= 6 then
        local stc_ButtonLock = UI.getChildControl(self._ui_pc._btn_AllSeal_Group[i], "Static_IconLock")
        stc_ButtonLock:addInputEvent("Mouse_On", "HandleEventMouseOn_PetListNew_RestrictedPresetTooltip(true, 2, " .. tostring(i) .. ")")
        stc_ButtonLock:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetListNew_RestrictedPresetTooltip(false)")
      end
    end
    self:registerShortCutEvent()
    self._ui_pc.btn_ResetGroup:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_GroupClear_All()")
    self._ui_pc.btn_ResetGroup:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(true, 0)")
    self._ui_pc.btn_ResetGroup:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(false)")
    self._ui_pc.btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Pet\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui_pc.btn_Question, "\"Pet\"")
    self._ui_pc.btn_Feeding_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_FeedUI_Close_All()")
  end
  self._ui.btn_Guide:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(true, 4)")
  self._ui.btn_Guide:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(false)")
  self._ui.btn_Guide:addInputEvent("Mouse_LUp", "HandleEventLup_PetUpgradePopup()")
  self._ui.btn_BuyStable:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_ShowNearStable()")
  self._ui.btn_BuyMarket:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_OpenMarketPlace()")
  self._ui.btn_BuyStable:SetTextMode(__eTextMode_LimitText)
  self._ui.btn_BuyMarket:SetTextMode(__eTextMode_LimitText)
  self._ui.btn_BuyStable:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETLISTNEW_BUYSTABLE"))
  self._ui.btn_BuyMarket:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETLISTNEW_BUYMARKET"))
  self._ui.btn_BuyStable:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_StableTooltip(true)")
  self._ui.btn_BuyStable:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_Show_StableTooltip(false)")
  self._ui.btn_BuyMarket:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_MarketTooltip(true)")
  self._ui.btn_BuyMarket:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_Show_MarketTooltip(false)")
  self._ui.btn_Edit:addInputEvent("Mouse_LUp", "PaGlobalFunc_PetGroupEdit_Open()")
end
function PaGlobal_PetList_All:registerShortCutEvent()
  if _ContentsGroup_RenewUI == true then
    return
  end
  local currentPresetCount = ToClient_GetPetPresetCount()
  for i = 1, currentPresetCount do
    self._ui_pc._btn_AllSeal_Group[i]:setButtonShortcuts("PANEL_SIMPLESHORTCUT_PET_GROUP" .. i)
  end
  PaGlobalFunc_ButtonShorcuts_All_Refresh()
end
function PaGlobal_PetList_All:updateUnsealButton()
  if Panel_Window_PetList_All == nil then
    return
  end
  if _ContentsGroup_PetPresetExpansion == false then
    return
  end
  local currentPresetCount = ToClient_GetPetPresetCount()
  if self._isConsole == true then
    for i = 6, self._maxPresetCount do
      local stc_IconLock = UI.getChildControl(self._ui_console._btn_AllSealConsole[i], "Static_IconLock")
      local stc_IconPlus = UI.getChildControl(self._ui_console._btn_AllSealConsole[i], "Static_IconPlus")
      if i > currentPresetCount then
        local isPlusButton = i == currentPresetCount + 1 and not self._isConsoleService
        stc_IconPlus:SetShow(isPlusButton)
        stc_IconLock:SetShow(not isPlusButton)
        self._ui_console._btn_AllSealConsole[i]:SetText("")
      else
        stc_IconPlus:SetShow(false)
        stc_IconLock:SetShow(false)
        self._ui_console._btn_AllSealConsole[i]:SetText(tostring(i))
      end
    end
  else
    for i = 6, self._maxPresetCount do
      local stc_IconLock = UI.getChildControl(self._ui_pc._btn_AllSeal_Group[i], "Static_IconLock")
      local stc_IconPlus = UI.getChildControl(self._ui_pc._btn_AllSeal_Group[i], "Static_IconPlus")
      if i > currentPresetCount then
        self._ui_pc._btn_AllSeal_Group[i]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetListNew_RestrictedPresetTooltip(true, 2, " .. tostring(i) .. ")")
        self._ui_pc._btn_AllSeal_Group[i]:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetListNew_RestrictedPresetTooltip(false)")
        local isPlusButton = i == currentPresetCount + 1
        stc_IconPlus:SetShow(isPlusButton)
        stc_IconLock:SetShow(not isPlusButton)
        self._ui_pc._btn_AllSeal_Group[i]:SetText("")
      else
        self._ui_pc._btn_AllSeal_Group[i]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(true, 1, " .. i .. ")")
        self._ui_pc._btn_AllSeal_Group[i]:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_Show_SimpleTooltip_All(false)")
        self._ui_pc._btn_AllSeal_Group[i]:SetText(tostring(i))
        stc_IconPlus:SetShow(false)
        stc_IconLock:SetShow(false)
      end
    end
  end
end
function PaGlobal_PetList_All:prepareOpen()
  if nil == Panel_Window_PetList_All then
    return
  end
  local fiveTierPetGuideNeverShowFlag = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUiFiveTierPetGuideNeverShowFlag)
  local isConditionQuestClear = questList_isClearQuest(893, 2)
  if _ContentsGroup_PetLeader == false or isConditionQuestClear == true or fiveTierPetGuideNeverShowFlag == true then
    self._ui.btn_Guide:SetShow(false)
  else
    self._ui.btn_Guide:SetShow(true)
  end
  if true == _ContentsGroup_ForceShowWidgetIcon and (false == getTemporaryInformationWrapper():isPremiumPcRoom() or false == _ContentsGroup_KR_Transfer) then
    local petCount = ToClient_getPetUnsealedList() + ToClient_getPetSealedList()
    if petCount <= 0 then
      Panel_WebHelper_ShowToggle("Pet")
      return
    end
  end
  if false == self._pcFilterInitialize then
    local temporaryInformation = getTemporaryInformationWrapper()
    if nil ~= temporaryInformation and true == temporaryInformation:isPremiumPcRoom() and true == _ContentsGroup_PcRoomPet then
      self._isPremiumPcRoom = true
      self._maxUnsealCount = self._maxUnsealCount + ToClient_getPetUseMaxCountPcRoom()
      PaGlobal_PetList_All:initPCRoomFilterUi()
    end
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoAnythingAfterSolrareStart"))
    return
  end
  Panel_Window_PetList_All:ComputePos()
  self:showFeedUi(-1)
  if PaGlobal_PetFusion_GetShow_All() then
    PaGlobal_PetFusion_Close_All()
  end
  PaGlobal_PetList_All:loadPetGroupList()
  PaGlobal_PetList_All:updatePetList()
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local startPosX = screenSizeX - Panel_Window_PetList_All:GetSizeX()
  Panel_Window_PetList_All:SetPosY(screenSizeY / 2 - Panel_Window_PetList_All:GetSizeY() / 2)
  if self._isConsole == true then
    self._ui.btn_Edit:SetSpanSize(15, 5)
  end
  PaGlobal_PetList_All:open()
end
function PaGlobal_PetList_All:open()
  if nil == Panel_Window_PetList_All then
    return
  end
  Panel_Window_PetList_All:SetShow(true)
  self._ui.list2_Pet:updateContentPos()
  self._ui.list2_Pet:moveTopIndex()
end
function PaGlobal_PetList_All:prepareClose()
  if nil == Panel_Window_PetList_All then
    return
  end
  if self._isConsole then
    if self._ui_console.stc_PopupBG:GetShow() then
      self:closePopUP()
      return
    end
    if self._ui.stc_FeedingBG:GetShow() then
      self:showFeedUi(-1)
      return
    end
    if Panel_Window_PetFusion_All:GetShow() then
      PaGlobal_PetFusion_Close_All()
      return
    end
  end
  PaGlobal_PetList_All._petLeaderNo = nil
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  Panel_Window_PetList_All:CloseUISubApp()
  self._currentPetNo64 = nil
  self:showFeedUi(-1)
  self:setIgnoreAllSealBtns(false)
  self:close()
end
function PaGlobal_PetList_All:close()
  if nil == Panel_Window_PetList_All then
    return
  end
  Panel_Window_PetList_All:SetShow(false)
end
function PaGlobal_PetList_All:validate()
  if nil == Panel_Window_PetList_All then
    return
  end
  self._ui.stc_TitleBG:isValidate()
  self._ui.stc_InsideBG:isValidate()
  self._ui.stc_Line:isValidate()
  self._ui.stc_SkillInfoBG:isValidate()
  self._ui.txt_SkillListDesc:isValidate()
  self._ui.txt_BaseSkillTitle:isValidate()
  self._ui.txt_BaseSkill:isValidate()
  self._ui.txt_SkillListTitle:isValidate()
  self._ui.txt_SkillList:isValidate()
  self._ui.txt_TierSetListTitle:isValidate()
  self._ui.txt_TierSetList:isValidate()
  self._ui.list2_Pet:isValidate()
  self._ui.stc_FeedingBG:isValidate()
  self._ui.stc_FeedingTitleBG:isValidate()
  self._ui.txt_FeedingBGTitle:isValidate()
  self._ui.stc_FeedingIconSlot:isValidate()
  self._ui.stc_SelectedFeedingItemIcon:isValidate()
  self._ui.stc_AcquireBG:isValidate()
  self._ui.btn_BuyStable:isValidate()
  self._ui.btn_BuyMarket:isValidate()
  self._ui_console.stc_FeedBottom_KeyGuideBG:isValidate()
  self._ui.btn_Edit:isValidate()
  self._ui_pc.chk_Popup:isValidate()
  self._ui_pc.btn_Question:isValidate()
  self._ui_pc.btn_Close:isValidate()
  self._ui_pc.stc_DesBG:isValidate()
  self._ui_pc.txt_DesL:isValidate()
  self._ui_pc.txt_DesR:isValidate()
  self._ui_pc.txt_Des:isValidate()
  self._ui_pc.stc_FindGroupBG:isValidate()
  for i = 1, self._maxPresetCount do
    self._ui_pc._btn_AllSeal_Group[i]:isValidate()
  end
  self._ui_pc.btn_ResetGroup:isValidate()
  self._ui_pc.stc_BtnGroup:isValidate()
  self._ui_pc.btn_Exchange:isValidate()
  self._ui_pc.btn_AllFeeding:isValidate()
  self._ui_pc.btn_AllSeal:isValidate()
  self._ui_pc.btn_Market:isValidate()
  self._ui_pc.btn_Feeding_FeedOne:isValidate()
  self._ui_pc.btn_Feeding_FeedFull:isValidate()
  self._ui_pc.btn_Feeding_Close:isValidate()
  self._ui_pc.stc_FilterBG:isValidate()
  self._ui_pc.rdo_All:isValidate()
  self._ui_pc.rdo_Normal:isValidate()
  self._ui_pc.rdo_PCRoom:isValidate()
  self._ui_pc.btn_RegistPCRoom:isValidate()
  if self._isConsole == true then
    for idx = 1, self._maxPresetCount do
      self._ui_console.petGroupingBtnList[idx]:isValidate()
      self._ui_console._btn_AllSealConsole[idx]:isValidate()
    end
    self._ui_console.stc_Popup_KeyGuideA:isValidate()
    self._ui_console.stc_Bottom_KeyGuideBG:isValidate()
    self._ui_console.stc_Bottom_KeyGuideA:isValidate()
    self._ui_console.stc_Bottom_KeyGuideB:isValidate()
    self._ui_console.stc_Bottom_KeyGuideX:isValidate()
    self._ui_console.stc_Bottom_KeyGuideY:isValidate()
    self._ui_console.stc_Bottom_KeyGuideRSHori:isValidate()
    self._ui_console.stc_Bottom_KeyGuideRSClick:isValidate()
    self._ui_console.stc_Bottom_KeyGuideLTPressRSClick:isValidate()
    self._ui_console.stc_Feeding_KeyGuideBG:isValidate()
    self._ui_console.stc_Feeding_KeyGuideA:isValidate()
    self._ui_console.stc_Feeding_KeyGuideX:isValidate()
    self._ui_console.stc_Feeding_KeyGuideY:isValidate()
    self._ui_console.stc_Feeding_KeyGuideB:isValidate()
    self._ui_console.stc_PopupBG:isValidate()
    self._ui_console.rdo_Unseals.feed:isValidate()
    self._ui_console.rdo_Unseals.order:isValidate()
    self._ui_console.rdo_Unseals.info:isValidate()
    self._ui_console.rdo_Unseals.seal:isValidate()
    self._ui_console.rdo_Seals.unseal:isValidate()
    self._ui_console.rdo_Seals.exchange:isValidate()
    self._ui_console.rdo_Seals.leader:isValidate()
    self._ui_console.rdo_Seals.changeSkill:isValidate()
    self._ui_console.rdo_Seals.changeName:isValidate()
  end
end
function PaGlobal_PetList_All:showFeedUi(targetPetIndex)
  if nil == Panel_Window_PetList_All then
    return
  end
  if self._feedingPetIndex == targetPetIndex then
    targetPetIndex = -1
  end
  self:clearSelect()
  local showFlag = targetPetIndex >= 0
  self._ui.stc_FeedingBG:SetShow(showFlag)
  self._feedingPetIndex = targetPetIndex
  if showFlag then
    local petData = ToClient_getPetUnsealedDataByIndex(targetPetIndex)
    if not petData then
      return
    end
    local petNo = petData:getPcPetNo()
    local contents = self._ui.list2_Pet:GetContentByKey(petNo)
    if nil == contents then
      contents = self._ui._petLeader.bg
    end
    local btnFeed = UI.getChildControl(contents, "Button_Feeding")
    self._ui.stc_FeedingBG:SetPosY(contents:GetPosY() + btnFeed:GetPosY())
    self._ui.stc_FeedingBG:SetPosX(contents:GetPosX() + btnFeed:GetPosX() + 50)
    self:updateFeedUi()
    local userFeedItemCount = ToClient_Pet_GetFeedItemCount()
    if userFeedItemCount > 0 then
      HandleEventLUp_PetList_FeedItem_All(0)
    end
  else
    self:updateConsoleKeyGuide(self._keyGuideAlignType.basic)
  end
end
function PaGlobal_PetList_All:showFeedAllUi(showFlag)
  if showFlag == self._ui.stc_FeedingBG:GetShow() then
    showFlag = false
  end
  local unsealPetCount = ToClient_getPetUnsealedList()
  if showFlag and 0 == unsealPetCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETLISTNEW_UNSEALALERT"))
    return
  end
  self._ui.stc_FeedingBG:SetShow(showFlag)
  self:clearSelect()
  if showFlag then
    if self._isConsole then
      self._ui.stc_FeedingBG:SetPosY(Panel_Window_PetList_All:GetSizeY() / 2 - self._ui.stc_FeedingBG:GetSizeY() / 2)
    else
      self._ui.stc_FeedingBG:SetPosX(Panel_Window_PetList_All:GetSizeX() + 10)
      self._ui.stc_FeedingBG:SetPosY(Panel_Window_PetList_All:GetSizeY() - self._ui.stc_FeedingBG:GetSizeY())
    end
    self:updateFeedUi(true)
    local userFeedItemCount = ToClient_Pet_GetFeedItemCount()
    if userFeedItemCount > 0 then
      HandleEventLUp_PetList_FeedItem_All(0)
    end
  else
    self:updateConsoleKeyGuide(self._keyGuideAlignType.basic)
  end
end
function PaGlobal_PetList_All:clearSelect()
  if nil == Panel_Window_PetList_All then
    return
  end
  self._selectItemIndex = -1
  self._ui.stc_SelectedFeedingItemIcon:SetShow(false)
end
function PaGlobal_PetList_All:updateFeedUi(isFeedToAll)
  if not self._ui.stc_FeedingBG:GetShow() then
    return
  end
  if nil == isFeedToAll then
    isFeedToAll = false
  end
  local userFeedItemCount = ToClient_Pet_GetFeedItemCount()
  self:updateUserFeedItemCount(userFeedItemCount)
  for i = 0, self._feedStaticItemCount - 1 do
    local targetSlot = UI.getChildControl(self._ui.stc_FeedingBG, "Static_IconBg" .. tostring(i))
    if i < userFeedItemCount then
      targetSlot:SetShow(true)
      local feedItem = ToClient_Pet_GetFeedItemByIndex(i)
      local feedItemWhereType = ToClient_Pet_GetFeedItemWhereTypeByIndex(i)
      if not feedItem then
        return
      end
      self._feedSlot[i]:setItem(feedItem, nil, nil, nil, CppEnums.ItemWhereType.eFamilyInventory == feedItemWhereType)
      if self._isConsole then
        if isFeedToAll then
          self._feedSlot[i].icon:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_UseFeedItemToAll_All()")
        else
          self._feedSlot[i].icon:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_UseFeedItem_One_All()")
        end
      else
        if isFeedToAll then
          self._feedSlot[i].icon:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_FeedItem_ShowTooltip(" .. i .. " , true )")
        else
          self._feedSlot[i].icon:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_FeedItem_ShowTooltip(" .. i .. " , false )")
        end
        self._feedSlot[i].icon:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_FeedItem_HideTooltip()")
        self._feedSlot[i].icon:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_FeedItem_All(" .. i .. ")")
      end
    else
      targetSlot:SetShow(false)
      targetSlot:removeInputEvent("Mouse_LUp")
    end
  end
  if isFeedToAll then
    self._ui_pc.btn_Feeding_FeedOne:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CONFIRM"))
    self._ui_pc.btn_Feeding_FeedFull:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_KEYGUIDE_CANCEL"))
    self._ui_pc.btn_Feeding_FeedOne:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_UseFeedItemToAll_All()")
    self._ui_pc.btn_Feeding_FeedFull:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_FeedUI_Close_All()")
    self._ui.txt_FeedingBGTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETRESTOREALL_TITLE"))
  else
    self._ui_pc.btn_Feeding_FeedOne:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETLISTNEW_FEEDONEBTN"))
    self._ui_pc.btn_Feeding_FeedFull:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETLISTNEW_FEEDFULLBTN"))
    self._ui_pc.btn_Feeding_FeedOne:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_UseFeedItem_One_All()")
    self._ui_pc.btn_Feeding_FeedFull:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_UseFeedItem_Full_All()")
    self._ui.txt_FeedingBGTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETLISTNEW_SELECTPETFOODTITLE"))
  end
  local minSizeX = self._ui.txt_FeedingBGTitle:GetTextSizeX() + self._ui.txt_FeedingBGTitle:GetPosX() * 2 + self._ui_pc.btn_Feeding_Close:GetSizeX()
  if userFeedItemCount > 5 then
    local targetSlot = UI.getChildControl(self._ui.stc_FeedingBG, "Static_IconBg" .. tostring(userFeedItemCount - 1))
    local sizeX = math.max(targetSlot:GetPosX() + targetSlot:GetSizeX() + 16, minSizeX)
    self._ui.stc_FeedingBG:SetSize(sizeX, self._ui.stc_FeedingBG:GetSizeY())
    self._ui.stc_FeedingTitleBG:SetSize(sizeX, self._ui.stc_FeedingTitleBG:GetSizeY())
  else
    local sizeX = math.max(255, minSizeX)
    self._ui.stc_FeedingBG:SetSize(sizeX, self._ui.stc_FeedingBG:GetSizeY())
    self._ui.stc_FeedingTitleBG:SetSize(sizeX, self._ui.stc_FeedingTitleBG:GetSizeY())
  end
  self._ui_pc.btn_Feeding_FeedOne:ComputePos()
  self._ui_pc.btn_Feeding_FeedFull:ComputePos()
  self._ui_pc.btn_Feeding_Close:ComputePos()
  if self._isConsole then
    self._ui.stc_FeedingBG:SetPosX(-self._ui.stc_FeedingBG:GetSizeX() - 10)
    self._ui_console.stc_Feeding_KeyGuideBG:SetSize(self._ui.stc_FeedingBG:GetSizeX(), self._ui_console.stc_Feeding_KeyGuideBG:GetSizeY())
    if isFeedToAll then
      self:updateConsoleKeyGuide(self._keyGuideAlignType.feedAll)
    else
      self:updateConsoleKeyGuide(self._keyGuideAlignType.feedOne)
    end
    ToClient_padSnapChangeToTarget(self._feedingFirstSlot)
  end
end
function PaGlobal_PetList_All:updateUserFeedItemCount(count)
  if not self._ui.stc_FeedingBG:GetShow() then
    return
  end
  if self._cachedUserFeedItemCount ~= count then
    self:clearSelect()
  end
  self._cachedUserFeedItemCount = count
end
function PaGlobal_PetList_All:setIgnoreAllSealBtns(value)
  if nil == Panel_Window_PetList_All then
    return
  end
  for i = 1, self._GroupCount do
    self._ui_pc._btn_AllSeal_Group[i]:SetIgnore(value)
    self._ui_pc._btn_AllSeal_Group[i]:SetMonoTone(value)
  end
  if _ContentsGroup_PetPresetExpansion == true then
    for i = 6, self._maxPresetCount do
      self._ui_pc._btn_AllSeal_Group[i]:SetIgnore(value)
      self._ui_pc._btn_AllSeal_Group[i]:SetMonoTone(value)
    end
  end
  self._ui_pc.btn_ResetGroup:SetIgnore(value)
  self._ui_pc.btn_ResetGroup:SetMonoTone(value)
  self._ui_pc.btn_Exchange:SetIgnore(value)
  self._ui_pc.btn_Exchange:SetMonoTone(value)
  self._ui_pc.btn_AllFeeding:SetIgnore(value)
  self._ui_pc.btn_AllFeeding:SetMonoTone(value)
  self._ui_pc.btn_AllSeal:SetIgnore(value)
  self._ui_pc.btn_AllSeal:SetMonoTone(value)
  if value then
    self:updateConsoleKeyGuide(self._keyGuideAlignType.popup)
  else
    self:updateConsoleKeyGuide(self._keyGuideAlignType.basic)
  end
end
function PaGlobal_PetList_All:updatePetList()
  if true == ToClient_isButtonOnRegisteredPetForPcRoom() then
    self._ui_pc.btn_RegistPCRoom:SetShow(true)
    self._ui_pc.stc_FilterBG:SetShow(false)
  elseif self._isPremiumPcRoom then
    self._ui_pc.stc_FilterBG:SetShow(true)
    self._ui_pc.btn_RegistPCRoom:SetShow(false)
  end
  self:SetPetList()
end
function PaGlobal_PetList_All:SetPetList(noclearscroll)
  if nil == Panel_Window_PetList_All then
    return
  end
  local toIndex = 0
  local scrollvalue = 0
  local vscroll = self._ui.list2_Pet:GetVScroll()
  if noclearscroll then
    toIndex = self._ui.list2_Pet:getCurrenttoIndex()
    if true == vscroll:GetShow() then
      scrollvalue = vscroll:GetControlPos()
    else
      noclearscroll = false
    end
    if toIndex == self._ui.list2_Pet:getEndIndex() and 0 == self._UnSealDATACount and 4 < self._UnSealDATACount + self._SealDATACount then
      toIndex = toIndex - 1
    end
  end
  PaGlobal_PetList_All:CheckPetLeaderUnseal()
  PaGlobal_PetList_All:updateListSize(self._isUnsealLeaderPet, noclearscroll)
  self._ui.list2_Pet:getElementManager():clearKey()
  self._UnSealDATACount = ToClient_getPetUnsealedList()
  self._SealDATACount = ToClient_getPetSealedList()
  self:skillTypeCountInit()
  self:amountPetSkillAttribute(self._UnSealDATACount)
  self._ui._petLeader.bg:SetShow(false)
  local petCount = self._UnSealDATACount + self._SealDATACount
  for index = 0, petCount do
    local petNo
    local unsealLeaderPet = false
    if 0 == index and 0 == self._UnSealDATACount then
      petNo = toInt64(0, -1)
    elseif index < self._UnSealDATACount then
      local petData = ToClient_getPetUnsealedDataByIndex(index)
      if nil ~= petData then
        if true == ToClient_isFilterOnPetForPcRoom() then
          if true == self._ui_pc.rdo_All:IsChecked() then
            petNo = petData:getPcPetNo()
          elseif true == self._ui_pc.rdo_Normal:IsChecked() then
            if false == petData:getPetStaticStatus():isOnlyPcRoom() then
              petNo = petData:getPcPetNo()
            end
          elseif true == self._ui_pc.rdo_PCRoom:IsChecked() and true == petData:getPetStaticStatus():isOnlyPcRoom() then
            petNo = petData:getPcPetNo()
          end
        elseif false == petData:getPetStaticStatus():isOnlyPcRoom() then
          petNo = petData:getPcPetNo()
        end
        local isLeader = petData:isLeaderPet()
        if isLeader == true then
          unsealLeaderPet = true
        end
      end
    else
      index = index - self._UnSealDATACount
      if 0 == self._UnSealDATACount then
        index = index - 1
      end
      local petData = ToClient_getPetSealedDataByIndex(index)
      if nil ~= petData then
        if true == ToClient_isFilterOnPetForPcRoom() then
          if true == self._ui_pc.rdo_All:IsChecked() then
            petNo = petData._petNo
          elseif true == self._ui_pc.rdo_Normal:IsChecked() then
            if false == petData:getPetStaticStatus():isOnlyPcRoom() then
              petNo = petData._petNo
            end
          elseif true == self._ui_pc.rdo_PCRoom:IsChecked() and true == petData:getPetStaticStatus():isOnlyPcRoom() then
            petNo = petData._petNo
          end
        elseif false == petData:getPetStaticStatus():isOnlyPcRoom() then
          petNo = petData._petNo
        end
      end
    end
    if nil ~= petNo then
      if false == unsealLeaderPet then
        self._ui.list2_Pet:getElementManager():pushKey(petNo)
      elseif self._ui_pc.rdo_PCRoom:IsChecked() == false then
        self:setUnsealLeaderPetContents(petNo, index)
      end
    end
  end
  if noclearscroll then
    if 0 == self._UnSealDATACount and toIndex == self._ui.list2_Pet:getEndIndex() - 1 then
      toIndex = toIndex + 1
    end
    self._ui.list2_Pet:setCurrenttoIndex(toIndex)
    if false == self._ui.list2_Pet:IsIgnoreVerticalScroll() then
      vscroll:SetControlPos(scrollvalue)
    end
  end
  if self._isConsole and 0 >= ToClient_Pet_GetFeedItemCount() then
    self._ui.stc_FeedingBG:SetShow(false)
    self:clearSelect()
    self:updateConsoleKeyGuide(self._keyGuideAlignType.basic)
  end
  PaGlobal_PetList_All:updatePenalSize()
  local button = self._ui_pc.btn_AllFeeding
  self._ui_console.stc_FeedBottom_KeyGuideBG:SetShow(false)
  if ToClient_Pet_GetFeedItemCount() == 0 then
    if PaGlobal_PetFusion_GetShow_All() == true then
      self._ui.stc_AcquireBG:SetShow(false)
    else
      self._ui.stc_AcquireBG:SetShow(true)
      self:resizeAcquireBG()
    end
    if 0 < ToClient_getPetUnsealedList() then
      self._ui.stc_AcquireBG:SetPosXY(self._ui.stc_SkillInfoBG:GetPosX(), self._ui.stc_SkillInfoBG:GetPosY() + self._ui.stc_SkillInfoBG:GetSizeY() + 10)
    else
      self._ui.stc_AcquireBG:SetPosXY(self._ui.stc_SkillInfoBG:GetPosX(), Panel_Window_PetList_All:GetSizeY() - self._ui.stc_AcquireBG:GetSizeY())
    end
    local texturePath = "combine/btn/combine_btn_03.dds"
    button:ChangeTextureInfoNameAsync(texturePath)
    local x1, y1, x2, y2 = setTextureUV_Func(button, 240, 474, 280, 514)
    button:getBaseTexture():setUV(x1, y1, x2, y2)
    button:setRenderTexture(button:getBaseTexture())
    button:ChangeOnTextureInfoNameAsync(texturePath)
    x1, y1, x2, y2 = setTextureUV_Func(button, 281, 474, 321, 514)
    button:getOnTexture():setUV(x1, y1, x2, y2)
    button:ChangeClickTextureInfoNameAsync(texturePath)
    x1, y1, x2, y2 = setTextureUV_Func(button, 322, 474, 362, 514)
    button:getClickTexture():setUV(x1, y1, x2, y2)
  else
    self._ui.stc_AcquireBG:SetShow(false)
    local texturePath = "combine/btn/combine_btn_00.dds"
    button:ChangeTextureInfoNameAsync(texturePath)
    local x1, y1, x2, y2 = setTextureUV_Func(button, 1, 1, 41, 41)
    button:getBaseTexture():setUV(x1, y1, x2, y2)
    button:setRenderTexture(button:getBaseTexture())
    button:ChangeOnTextureInfoNameAsync(texturePath)
    x1, y1, x2, y2 = setTextureUV_Func(button, 42, 1, 82, 41)
    button:getOnTexture():setUV(x1, y1, x2, y2)
    button:ChangeClickTextureInfoNameAsync(texturePath)
    x1, y1, x2, y2 = setTextureUV_Func(button, 83, 1, 123, 41)
    button:getClickTexture():setUV(x1, y1, x2, y2)
  end
  if Panel_Window_PetList_All:GetPosY() + self._ui.stc_AcquireBG:GetPosY() + self._ui.stc_AcquireBG:GetSizeY() >= getScreenSizeY() then
    self._ui.stc_AcquireBG:SetPosXY(self._ui.stc_AcquireBG:GetPosX(), getScreenSizeY() - Panel_Window_PetList_All:GetPosY() - self._ui.stc_AcquireBG:GetSizeY())
    if self._ui.stc_SkillInfoBG:GetShow() == true then
      self._ui.stc_SkillInfoBG:SetPosXY(self._ui.stc_SkillInfoBG:GetPosX(), self._ui.stc_AcquireBG:GetPosY() - self._ui.stc_SkillInfoBG:GetSizeY() - 20)
    end
  end
  self:updateUnsealButton()
end
function PaGlobal_PetList_All:resizeAcquireBG()
  if Panel_Window_PetList_All == nil then
    return
  end
  if self._ui.stc_AcquireBG:GetShow() == false then
    return
  end
  local subFrameTitle = UI.getChildControl(self._ui.stc_AcquireBG, "Static_subframetitle")
  local lackIcon = UI.getChildControl(self._ui.stc_AcquireBG, "Static_LackIcon")
  local feedLack = UI.getChildControl(self._ui.stc_AcquireBG, "StaticText_FeedLack")
  local BGLine = UI.getChildControl(self._ui.stc_AcquireBG, "Static_BGLine")
  local mark = UI.getChildControl(self._ui.stc_AcquireBG, "StaticText_Mark")
  local feedIcon = UI.getChildControl(self._ui.stc_AcquireBG, "Static_FeedIcon")
  local makeFeed = UI.getChildControl(self._ui.stc_AcquireBG, "StaticText_MakeFeed")
  feedLack:SetTextMode(__eTextMode_AutoWrap)
  makeFeed:SetTextMode(__eTextMode_AutoWrap)
  feedLack:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETLISTNEW_FEEDLACK"))
  makeFeed:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETLISTNEW_MAKEFEED"))
  BGLine:SetPosY(feedLack:GetPosY() + feedLack:GetTextSizeY() + 20)
  self._ui.btn_BuyStable:SetPosY(BGLine:GetPosY() + BGLine:GetSizeY() + 15)
  self._ui.btn_BuyMarket:SetPosY(BGLine:GetPosY() + BGLine:GetSizeY() + 15)
  mark:SetPosY(self._ui.btn_BuyStable:GetPosY() + self._ui.btn_BuyStable:GetSizeY() + 15)
  feedIcon:SetPosY(self._ui.btn_BuyStable:GetPosY() + self._ui.btn_BuyStable:GetSizeY() + 15)
  makeFeed:SetPosY(self._ui.btn_BuyStable:GetPosY() + self._ui.btn_BuyStable:GetSizeY() + 15)
  self._ui.stc_AcquireBG:SetSize(self._ui.stc_AcquireBG:GetSizeX(), makeFeed:GetPosY() + makeFeed:GetTextSizeY() + 10)
end
function PaGlobal_PetList_All:skillBGClose()
  if nil == Panel_Window_PetList_All then
    return
  end
  self._ui.stc_SkillInfoBG:SetShow(false)
end
function PaGlobal_PetList_All:skillTypeCountInit()
  if nil == Panel_Window_PetList_All then
    return
  end
  for index = 0, self._maxskillTypeCount - 1 do
    self._skillInfo.plusCount[index] = 0
    self._skillInfo.skillTypeCount[index] = 0
  end
  PaGlobal_PetList_All:skillBGClose()
end
function PaGlobal_PetList_All:amountPetSkillAttribute(count)
  if nil == Panel_Window_PetList_All then
    return
  end
  if 0 == count then
    PaGlobal_PetList_All:skillBGClose()
    return
  end
  self._ui.stc_SkillInfoBG:SetShow(true)
  local unSealLeaderPet = false
  self._ui.txt_LeaderSkillListTitle:SetShow(false)
  self._ui.txt_LeaderSkillList:SetShow(false)
  local baseSkillPoint = {}
  for initIndex = 1, #self._baseSkillTypeString do
    baseSkillPoint[initIndex] = 0
  end
  for index = 0, count - 1 do
    local PcPetData = ToClient_getPetUnsealedDataByIndex(index)
    if nil == PcPetData then
      return
    end
    local baseSkillIndex = PcPetData:getPetBaseSkillIndex()
    local unsealPetSkillStaticStatus = ToClient_getPetBaseSkillStaticStatus(baseSkillIndex)
    local groupNo = ToClient_getBaseSkillGroupNo(baseSkillIndex)
    local petStaticStatus = PcPetData:getPetStaticStatus()
    local petTier = petStaticStatus:getPetTier() + 1
    local isLeader = ToClient_isLeaderPet(PcPetData:getPcPetNo())
    if petTier == self._leaderPetTier and isLeader == false then
      petTier = petTier - 1
    end
    baseSkillPoint[groupNo] = baseSkillPoint[groupNo] + self._baseSkillMultiplePoint[groupNo] * petTier
    if 9 == groupNo then
      baseSkillPoint[groupNo + 1] = baseSkillPoint[groupNo + 1] + self._baseSkillMultiplePoint[groupNo + 1] * petTier
    elseif 12 == groupNo then
      baseSkillPoint[groupNo] = baseSkillPoint[groupNo] + 10
    end
    if isLeader == true then
      self._ui.txt_LeaderSkillListTitle:SetShow(true)
      self._ui.txt_LeaderSkillList:SetShow(true)
      self._ui.txt_LeaderSkillList:SetTextMode(__eTextMode_AutoWrap)
      local leaderBuffPercent = ToClient_getPetLeaderBuff(petStaticStatus:getPetTier())
      self._ui.txt_LeaderSkillList:SetText("- " .. PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PETLEADER_SKILL_DESC", "percent", leaderBuffPercent))
      unSealLeaderPet = true
    end
  end
  local textSizeY = 0
  local infoBgSizeY = textSizeY + 20
  if unSealLeaderPet == true then
    textSizeY = self._ui.txt_LeaderSkillList:GetTextSizeY() + 60
    infoBgSizeY = self._originSkillPosY + textSizeY + 30
    self._ui.txt_LeaderSkillListTitle:SetShow(true)
    self._ui.txt_LeaderSkillList:SetShow(true)
  end
  local baseSkillString = ""
  for groupIndex = 1, #self._baseSkillTypeString do
    if baseSkillPoint[groupIndex] > 0 then
      if "" == baseSkillString then
        baseSkillString = "- " .. self._baseSkillTypeString[groupIndex] .. baseSkillPoint[groupIndex] .. self._baseSkillTypeUnit[groupIndex]
      else
        baseSkillString = baseSkillString .. [[

- ]] .. self._baseSkillTypeString[groupIndex] .. baseSkillPoint[groupIndex] .. self._baseSkillTypeUnit[groupIndex]
      end
    end
  end
  self._ui.txt_BaseSkill:SetText(baseSkillString)
  self._ui.txt_BaseSkillTitle:SetPosY(self._originSkillPosY + textSizeY)
  self._ui.txt_BaseSkill:SetPosY(self._ui.txt_BaseSkillTitle:GetPosY() + 40)
  textSizeY = textSizeY + self._ui.txt_BaseSkill:GetTextSizeY() + 30
  infoBgSizeY = self._originSkillPosY + textSizeY + 30
  local skillMaxCount = ToClient_getPetEquipSkillMax()
  for index = 0, count - 1 do
    local PcPetData = ToClient_getPetUnsealedDataByIndex(index)
    if nil == PcPetData then
      return
    end
    for skill_idx = 0, skillMaxCount - 1 do
      local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
      local isLearn = PcPetData:isPetEquipSkillLearned(skill_idx)
      if true == isLearn and nil ~= skillStaticStatus then
        local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
        if nil ~= skillTypeStaticWrapper then
          self:petSkillTypeCheck(skill_idx)
        end
      end
    end
  end
  local petSkillGrade = ""
  local petSkillGradeText = ""
  local hasSkill = false
  for skillTypeIndex = 0, self._maxskillTypeCount - 1 do
    if 0 < self._skillInfo.plusCount[skillTypeIndex] then
      if skillTypeIndex >= 12 and skillTypeIndex < 15 then
        petSkillGrade = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_VILLAGETENT_GRADE", "index", self._skillInfo.plusCount[skillTypeIndex])
      elseif 16 == skillTypeIndex then
        petSkillGrade = self._skillInfo.plusCount[skillTypeIndex] .. self._baseSkillTypeUnit[12]
      else
        petSkillGrade = self._skillInfo.plusCount[skillTypeIndex] .. "%"
      end
      if "" == petSkillGradeText then
        petSkillGradeText = self._skillTypeString[skillTypeIndex] .. petSkillGrade
      else
        petSkillGradeText = petSkillGradeText .. "\n" .. self._skillTypeString[skillTypeIndex] .. petSkillGrade
      end
      hasSkill = true
    end
  end
  if hasSkill then
    self._ui.txt_SkillListTitle:SetPosY(self._originSkillPosY + textSizeY + 25)
    self._ui.txt_SkillList:SetPosY(self._ui.txt_SkillListTitle:GetPosY() + 40)
    self._ui.txt_SkillList:SetText(petSkillGradeText)
    textSizeY = textSizeY + self._ui.txt_SkillList:GetTextSizeY() + 50
    infoBgSizeY = self._originSkillPosY + textSizeY + 30
    self._ui.txt_SkillListTitle:SetShow(true)
    self._ui.txt_SkillList:SetShow(true)
  else
    self._ui.txt_SkillListTitle:SetShow(false)
    self._ui.txt_SkillList:SetShow(false)
  end
  if true == _ContentsGroup_PetSetStats then
    local tierSetString = ""
    if true == ToClient_isPetSetApplied() then
      local petSetParamMaxCount = ToClient_getPetSetMaxParamCount()
      for ii = 0, petSetParamMaxCount - 1 do
        local skillStaticStatus = ToClient_getPetSetSkill(ii)
        if nil ~= skillStaticStatus then
          local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
          if nil ~= skillTypeStaticWrapper then
            if "" == tierSetString then
              tierSetString = "- " .. skillTypeStaticWrapper:getName()
            else
              tierSetString = tierSetString .. [[

- ]] .. skillTypeStaticWrapper:getName()
            end
          end
        end
      end
    end
    if "" ~= tierSetString then
      self._ui.txt_TierSetListTitle:SetPosY(self._originSkillPosY + textSizeY + 25)
      self._ui.txt_TierSetList:SetPosY(self._ui.txt_TierSetListTitle:GetPosY() + 40)
      self._ui.txt_TierSetList:SetText(tierSetString)
      textSizeY = textSizeY + self._ui.txt_TierSetList:GetTextSizeY() + 30
      infoBgSizeY = self._originSkillPosY + textSizeY + 30
      self._ui.txt_TierSetListTitle:SetShow(true)
      self._ui.txt_TierSetList:SetShow(true)
    else
      self._ui.txt_TierSetListTitle:SetShow(false)
      self._ui.txt_TierSetList:SetShow(false)
    end
  else
    self._ui.txt_TierSetListTitle:SetShow(false)
    self._ui.txt_TierSetList:SetShow(false)
  end
  self._ui.stc_SkillInfoBG:SetSize(self._ui.stc_SkillInfoBG:GetSizeX(), infoBgSizeY + 20)
end
local maxPercentage = ToClient_MaxPetSkillRate() / 10000
local maxGrade = 5
function PaGlobal_PetList_All:petSkillTypeCheck(skillIndex)
  local skillType
  if skillIndex >= 0 and skillIndex < 3 then
    skillType = 0
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[skillIndex], maxPercentage)
  elseif skillIndex >= 3 and skillIndex < 6 then
    skillType = 1
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[skillIndex % 3], maxPercentage)
  elseif skillIndex >= 6 and skillIndex < 9 then
    skillType = 2
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[skillIndex % 3], maxPercentage)
  elseif 12 == skillIndex then
    skillType = 3
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[0], maxPercentage)
  elseif 13 == skillIndex then
    skillType = 3
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[4], maxPercentage)
  elseif skillIndex >= 14 and skillIndex < 17 then
    skillType = 4
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[(skillIndex + 1) % 3], maxPercentage)
  elseif skillIndex >= 17 and skillIndex < 20 then
    skillType = 5
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[(skillIndex + 1) % 3], maxPercentage)
  elseif skillIndex >= 20 and skillIndex < 23 then
    skillType = 6
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[(skillIndex + 1) % 3], maxPercentage)
  elseif skillIndex >= 23 and skillIndex < 26 then
    skillType = 7
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[(skillIndex + 1) % 3], maxPercentage)
  elseif skillIndex >= 26 and skillIndex < 29 then
    skillType = 8
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[(skillIndex + 1) % 3], maxPercentage)
  elseif skillIndex >= 29 and skillIndex < 32 then
    skillType = 9
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[(skillIndex + 1) % 3], maxPercentage)
  elseif skillIndex >= 32 and skillIndex < 35 then
    skillType = 10
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[(skillIndex + 1) % 3], maxPercentage)
  elseif skillIndex >= 35 and skillIndex < 38 then
    skillType = 11
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[(skillIndex + 1) % 3], maxPercentage)
  elseif 9 == skillIndex then
    skillType = 12
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + 1, maxGrade)
  elseif 10 == skillIndex then
    skillType = 13
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + 1, maxGrade)
  elseif 11 == skillIndex then
    skillType = 14
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + 1, maxGrade)
  elseif 38 == skillIndex then
    skillType = 15
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[skillIndex % 3], maxPercentage)
  elseif 39 == skillIndex then
    skillType = 16
    self._skillInfo.plusCount[skillType] = self._skillInfo.plusCount[skillType] + 50
  elseif 40 == skillIndex then
    skillType = 17
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[skillIndex % 3], maxPercentage)
  elseif 41 == skillIndex then
    skillType = 18
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[skillIndex % 3], maxPercentage)
  elseif 42 == skillIndex then
    skillType = 19
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[5], maxPercentage)
    skillType = 20
    self._skillInfo.plusCount[skillType] = math.min(self._skillInfo.plusCount[skillType] + self._plusPoint[4], maxPercentage)
  end
  self._skillInfo.skillTypeCount[skillType] = self._skillInfo.skillTypeCount[skillType] + 1
  return skillType
end
function PaGlobal_PetList_All:initUnsealPetOrderInfo(petNo64)
  for index = 0, ToClient_getPetUnsealedList() - 1 do
    local pcPetData = ToClient_getPetUnsealedDataByIndex(index)
    if nil ~= pcPetData and petNo64 == pcPetData:getPcPetNo() then
      local pcPetOrderOption = ToClient_getPetOrderOptionByPetNo(petNo64)
      if nil == pcPetOrderOption then
        if nil ~= pcPetData:getSkillParam(1) then
          local isCheckTalent = pcPetData:getSkillParam(1):isPassiveSkill()
          self._petOrderList._find[tostring(petNo64)] = isCheckTalent
        else
          self._petOrderList._find[tostring(petNo64)] = false
        end
        self._petOrderList._follow[tostring(petNo64)] = true
        self._petOrderList._getItem[tostring(petNo64)] = true
        ToClient_savePetOrderOptionByPetNo(petNo64, __ePetOrderOptionType_DoFollowAndWait, self._petOrderList._follow[tostring(petNo64)])
        ToClient_savePetOrderOptionByPetNo(petNo64, __ePetOrderOptionType_DoFind, self._petOrderList._find[tostring(petNo64)])
        ToClient_savePetOrderOptionByPetNo(petNo64, __ePetOrderOptionType_DoGetItem, self._petOrderList._getItem[tostring(petNo64)])
      else
        self._petOrderList._find[tostring(petNo64)] = pcPetOrderOption:getDoFind()
        self._petOrderList._follow[tostring(petNo64)] = pcPetOrderOption:getDoFollowAndWait()
        self._petOrderList._getItem[tostring(petNo64)] = pcPetOrderOption:getDoGetItem()
      end
    end
  end
end
function PaGlobal_PetList_All:initSealPetOrderInfo(petNo64)
  for index = 0, ToClient_getPetSealedList() - 1 do
    local pcPetData = ToClient_getPetSealedDataByIndex(index)
    if nil ~= pcPetData and petNo64 == pcPetData._petNo then
      local pcPetOrderOption = ToClient_getPetOrderOptionByPetNo(petNo64)
      if nil == pcPetOrderOption then
        if nil ~= pcPetData:getSkillParam(1) then
          local isCheckTalent = pcPetData:getSkillParam(1):isPassiveSkill()
          self._petOrderList._find[tostring(petNo64)] = isCheckTalent
        else
          self._petOrderList._find[tostring(petNo64)] = false
        end
        self._petOrderList._follow[tostring(petNo64)] = true
        self._petOrderList._getItem[tostring(petNo64)] = true
        ToClient_savePetOrderOptionByPetNo(petNo64, __ePetOrderOptionType_DoFollowAndWait, self._petOrderList._follow[tostring(petNo64)])
        ToClient_savePetOrderOptionByPetNo(petNo64, __ePetOrderOptionType_DoFind, self._petOrderList._find[tostring(petNo64)])
        ToClient_savePetOrderOptionByPetNo(petNo64, __ePetOrderOptionType_DoGetItem, self._petOrderList._getItem[tostring(petNo64)])
      else
        self._petOrderList._find[tostring(petNo64)] = pcPetOrderOption:getDoFind()
        self._petOrderList._follow[tostring(petNo64)] = pcPetOrderOption:getDoFollowAndWait()
        self._petOrderList._getItem[tostring(petNo64)] = pcPetOrderOption:getDoGetItem()
      end
    end
  end
end
function PaGlobal_PetList_All:isCheckGroupBtnByPetNo(petNo_s64, groupIndex)
  if self._checkUnSealGroupList[groupIndex] == nil then
    return false
  end
  local isCheck = self._checkUnSealGroupList[groupIndex][tostring(petNo_s64)]
  if isCheck == nil then
    isCheck = false
  end
  return isCheck
end
function PaGlobal_PetList_All:sealAllPet(noMessageShow, groupIndex)
  if PaGlobal_PetFusion_GetShow_All() then
    return
  end
  local sealCount = 0
  for index = 0, self._maxUnsealCount - 1 do
    local PetUnSealData = ToClient_getPetUnsealedDataByIndex(index)
    if nil ~= PetUnSealData then
      local unsealPetNoStr = tostring(PetUnSealData:getPcPetNo())
      if nil == groupIndex then
        if nil ~= unsealPetNoStr then
          PaGlobal_PetList_All:sealPet(unsealPetNoStr, index)
          sealCount = sealCount + 1
        end
      elseif self._checkUnSealGroupList[groupIndex][unsealPetNoStr] ~= true then
        PaGlobal_PetList_All:sealPet(unsealPetNoStr, index)
        sealCount = sealCount + 1
      end
    end
  end
  if true ~= noMessageShow and 0 ~= sealCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_ALLUNSEAL"))
  end
  if self._isConsole then
    if sealCount > 0 then
      self._ui.list2_Pet:moveTopIndex()
    end
  else
    self._ui.list2_Pet:moveTopIndex()
  end
  self:showFeedUi(-1)
end
function PaGlobal_PetList_All:sealPet(petNoStr, index)
  local petNo_s64 = tonumber64(petNoStr)
  self:showFeedUi(-1)
  TooltipSimple_Hide()
  ToClient_requestPetSeal(petNo_s64)
end
function PaGlobal_PetList_All:orderPet(orderType, index)
  local petCount = ToClient_getPetUnsealedList()
  if petCount == 0 then
    return
  end
  local value
  local pcPetData = ToClient_getPetUnsealedDataByIndex(index)
  if nil == pcPetData then
    return
  end
  local petNo = pcPetData:getPcPetNo()
  local petSSW = pcPetData:getPetStaticStatus()
  if nil == petSSW then
    return
  end
  if __ePetOrderOptionType_DoFollowAndWait == orderType then
    value = not self._petOrderList._follow[tostring(petNo)]
    if value then
      ToClient_callHandlerToPetNo("handlePetFollowMaster", petNo)
    else
      ToClient_callHandlerToPetNo("handlePetWaitMaster", petNo)
    end
    self._petOrderList._follow[tostring(petNo)] = value
    ToClient_savePetOrderOptionByPetNo(petNo, __ePetOrderOptionType_DoFollowAndWait, value)
  elseif __ePetOrderOptionType_DoFind == orderType then
    TooltipSimple_Hide()
    value = not self._petOrderList._find[tostring(petNo)]
    if value then
      ToClient_callHandlerToPetNo("handlePetFindThatOn", petNo)
    else
      ToClient_callHandlerToPetNo("handlePetFindThatOff", petNo)
    end
    self._petOrderList._find[tostring(petNo)] = value
    ToClient_savePetOrderOptionByPetNo(petNo, __ePetOrderOptionType_DoFind, value)
  elseif __ePetOrderOptionType_DoGetItem == orderType then
    TooltipSimple_Hide()
    value = not self._petOrderList._getItem[tostring(petNo)]
    if value then
      ToClient_callHandlerToPetNo("handlePetGetItemOn", petNo)
    else
      ToClient_callHandlerToPetNo("handlePetGetItemOff", petNo)
    end
    self._petOrderList._getItem[tostring(petNo)] = value
    ToClient_savePetOrderOptionByPetNo(petNo, __ePetOrderOptionType_DoGetItem, value)
  end
  local isLeader = ToClient_isLeaderPet(petNo)
  if isLeader == true then
    PaGlobal_PetList_All:setUnsealLeaderPetContents(petNo, index)
  else
    self._ui.list2_Pet:requestUpdateByKey(petNo)
  end
end
function PaGlobal_PetList_All:simpleTooltip(tipType, param)
  local name, desc, control
  local icon = false
  if tipType == self._tipType.ResetGroup then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PETLISTNEW_ALLCLEARSET")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLISTNEW_ALLCLEAR_UNSET")
    control = self._ui_pc.btn_ResetGroup
  elseif tipType == self._tipType.GroupSelect then
    local groupName
    if _ContentsGroup_PetPresetExpansion == true then
      groupName = ToClient_GetPetPresetName(param)
    else
      groupName = ToClient_GetPetGroupName(param - 1)
    end
    if groupName == nil or groupName == "" then
      groupName = "<PAColor0xFFF5BA3A>" .. param .. "<PAOldColor>"
    else
      groupName = "<PAColor0xFFF5BA3A>" .. groupName .. "<PAOldColor>"
    end
    name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_GROUPSEALBTN_TOOLTIPTITLE", "name", groupName)
    desc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_PETLIST_ALLSEAL_GROUP_SEAL", "count", self._maxUnsealCount, "name", groupName) .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    control = self._ui_pc._btn_AllSeal_Group[param]
  elseif tipType == self._tipType.Exchange then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PETLISTNEW_COMPOSE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_FUSION_DESC")
    control = self._ui_pc.btn_Exchange
  elseif tipType == self._tipType.AllSeal then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETCONTROL_BTN_ALLSEAL")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_ALLSEAL_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    control = self._ui_pc.btn_AllSeal
  elseif tipType == self._tipType.UpdateGuide then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UPDATE_POPUP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_UPDATE_SIMPLETOOLTIP_DESC")
    control = self._ui.btn_Guide
  end
  TooltipSimple_Show(control, name, desc, icon)
end
function PaGlobal_PetList_All:orderTooltip(orderType, index)
  local pcPetData = ToClient_getPetUnsealedDataByIndex(index)
  if nil == pcPetData then
    return
  end
  local petSSW = pcPetData:getPetStaticStatus()
  if nil == petSSW then
    return
  end
  local isLeader = ToClient_isLeaderPet(pcPetData:getPcPetNo())
  if isLeader == true then
    local contents = self._ui._petLeader.bg
    local orderFollow = UI.getChildControl(contents, "CheckButton_Follow")
    local orderWait = UI.getChildControl(contents, "CheckButton_Wait")
    local orderFind = UI.getChildControl(contents, "CheckButton_Find")
    local orderGetItem = UI.getChildControl(contents, "CheckButton_GetItem")
    local orderPlay = UI.getChildControl(contents, "CheckButton_Play")
    local hungryProgress = UI.getChildControl(contents, "Template_Static_Progress_Hungry")
    local hungryPercentText = UI.getChildControl(contents, "StaticText_HungryPercent")
    local hungryIcon = UI.getChildControl(contents, "Template_Static_HungryIcon")
    local btnInfo = UI.getChildControl(contents, "Template_Button_Info")
    local btnSeal = UI.getChildControl(contents, "Template_Button_Seal")
    local btnFeed = UI.getChildControl(contents, "Button_Feeding")
    local btnChangeSkill = UI.getChildControl(contents, "Button_ChangeSkill")
    local uiControl, name, desc
    local icon = false
    if 0 == orderType then
      uiControl = orderFollow
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_FOLLOW_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_FOLLOW_DESC")
    elseif 1 == orderType then
      uiControl = orderWait
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_WAIT_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_WAIT_DESC")
    elseif 2 == orderType then
      uiControl = orderGetItem
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_FIND_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_FIND_DESC")
    elseif 3 == orderType then
      uiControl = orderFind
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_GETITEM_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_GETITEM_DESC")
    elseif 4 == orderType then
      local petLootingType = pcPetData:getPetLootingType()
      local lootingTypeString = ""
      if 0 == petLootingType then
        lootingTypeString = PAGetString(Defines.StringSheet_GAME, "LUA_IPETCONTROL_TOOLTIP_LOOTINGTYPE_0")
      elseif 1 == petLootingType then
        lootingTypeString = PAGetString(Defines.StringSheet_GAME, "LUA_IPETCONTROL_TOOLTIP_LOOTINGTYPE_1")
      elseif 2 == petLootingType then
        lootingTypeString = PAGetString(Defines.StringSheet_GAME, "LUA_IPETCONTROL_TOOLTIP_LOOTINGTYPE_2")
      end
      uiControl = orderPlay
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_PLAY_NAME") .. lootingTypeString
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_PLAY_DESC")
    elseif 5 == orderType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_DESC")
      uiControl = hungryProgress
    elseif 6 == orderType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_DESC")
      uiControl = hungryPercentText
    elseif 7 == orderType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_DESC")
      uiControl = hungryIcon
    elseif 8 == orderType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_INFO_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_INFO_DESC")
      uiControl = btnInfo
    elseif 9 == orderType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_SEAL_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_SEAL_DESC")
      uiControl = btnSeal
    elseif 11 == orderType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_FEED_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_FEED_DESC")
      uiControl = btnFeed
    elseif 12 == orderType then
      name = "\237\142\171\236\138\164\237\130\172\235\179\128\234\178\189(\236\158\145\236\151\133\237\149\132\236\154\148)"
      desc = "\236\132\164\235\170\133(\236\158\145\236\151\133\237\149\132\236\154\148)"
      uiControl = btnChangeSkill
    end
    TooltipSimple_Show(uiControl, name, desc, icon)
    return
  end
  local key = pcPetData:getPcPetNo()
  local control = self._ui.list2_Pet
  local contents = control:GetContentByKey(key)
  local orderFollow = UI.getChildControl(contents, "CheckButton_Follow")
  local orderWait = UI.getChildControl(contents, "CheckButton_Wait")
  local orderFind = UI.getChildControl(contents, "CheckButton_Find")
  local orderGetItem = UI.getChildControl(contents, "CheckButton_GetItem")
  local orderPlay = UI.getChildControl(contents, "CheckButton_Play")
  local hungryProgress = UI.getChildControl(contents, "Template_Static_Progress_Hungry")
  local hungryPercentText = UI.getChildControl(contents, "StaticText_HungryPercent")
  local hungryIcon = UI.getChildControl(contents, "Template_Static_HungryIcon")
  local btnInfo = UI.getChildControl(contents, "Template_Button_Info")
  local btnChangeSkill = UI.getChildControl(contents, "Button_ChangeSkill")
  local btnSeal = UI.getChildControl(contents, "Template_Button_Seal")
  local btnFusion = UI.getChildControl(contents, "Template_Button_Fusion")
  local btnFeed = UI.getChildControl(contents, "Button_Feeding")
  local uiControl, name, desc
  local icon = false
  if 0 == orderType then
    uiControl = orderFollow
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_FOLLOW_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_FOLLOW_DESC")
  elseif 1 == orderType then
    uiControl = orderWait
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_WAIT_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_WAIT_DESC")
  elseif 2 == orderType then
    uiControl = orderGetItem
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_FIND_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_FIND_DESC")
  elseif 3 == orderType then
    uiControl = orderFind
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_GETITEM_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_GETITEM_DESC")
  elseif 4 == orderType then
    local petLootingType = pcPetData:getPetLootingType()
    local lootingTypeString = ""
    if 0 == petLootingType then
      lootingTypeString = PAGetString(Defines.StringSheet_GAME, "LUA_IPETCONTROL_TOOLTIP_LOOTINGTYPE_0")
    elseif 1 == petLootingType then
      lootingTypeString = PAGetString(Defines.StringSheet_GAME, "LUA_IPETCONTROL_TOOLTIP_LOOTINGTYPE_1")
    elseif 2 == petLootingType then
      lootingTypeString = PAGetString(Defines.StringSheet_GAME, "LUA_IPETCONTROL_TOOLTIP_LOOTINGTYPE_2")
    end
    uiControl = orderPlay
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_PLAY_NAME") .. lootingTypeString
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_TOOLTIP_PLAY_DESC")
  elseif 5 == orderType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_DESC")
    uiControl = hungryProgress
  elseif 6 == orderType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_DESC")
    uiControl = hungryPercentText
  elseif 7 == orderType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_DESC")
    uiControl = hungryIcon
  elseif 8 == orderType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_INFO_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_INFO_DESC")
    uiControl = btnInfo
  elseif 9 == orderType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_SEAL_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_SEAL_DESC")
    uiControl = btnSeal
  elseif 10 == orderType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_FUSION_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_FUSION_DESC")
    uiControl = btnFusion
  elseif 11 == orderType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_FEED_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_FEED_DESC")
    uiControl = btnFeed
  elseif 12 == orderType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_FEED_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_FEED_DESC")
    uiControl = btnChangeSkill
  end
  TooltipSimple_Show(uiControl, name, desc, icon)
end
function PaGlobal_PetList_All:nameTooltip(isShow, index, isSealed)
  local name, desc, control, pcPetData, key
  if isSealed then
    pcPetData = ToClient_getPetUnsealedDataByIndex(index)
    key = pcPetData:getPcPetNo()
  else
    pcPetData = ToClient_getPetSealedDataByIndex(index)
    key = pcPetData._petNo
  end
  local petName = pcPetData:getName()
  local contents = self._ui.list2_Pet:GetContentByKey(key)
  local nameControl = UI.getChildControl(contents, "Template_StaticText_PetName")
  name = petName
  control = nameControl
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_PetList_All:simpleTooltipBTN(index, tipType, param)
  local name, desc, control
  local icon = false
  local pcPetData = ToClient_getPetSealedDataByIndex(index)
  if nil == pcPetData then
    return
  end
  local key = pcPetData._petNo
  local contents = self._ui.list2_Pet:GetContentByKey(key)
  local btn_Unseal = UI.getChildControl(contents, "Template_Button_Unseal")
  local hungryProgress = UI.getChildControl(contents, "Template_Static_Progress_Hungry")
  local hungryPercentText = UI.getChildControl(contents, "StaticText_HungryPercent")
  local hungryIcon = UI.getChildControl(contents, "Template_Static_HungryIcon")
  local btnUp = UI.getChildControl(contents, "Button_Up")
  local btnDown = UI.getChildControl(contents, "Button_Down")
  local btnFusion = UI.getChildControl(contents, "Template_Button_Fusion")
  local btnChangeSkill = UI.getChildControl(contents, "Button_ChangeSkill")
  local btnChangeName = UI.getChildControl(contents, "Template_Button_NameChange")
  if tipType == 0 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_UNSEAL_NAME")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_UNSEAL_DESC", "count", self._maxUnsealCount)
    control = btn_Unseal
  elseif tipType == 1 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_DESC")
    control = hungryProgress
  elseif tipType == 2 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_DESC")
    control = hungryPercentText
  elseif tipType == 3 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_HUNGRY_DESC")
    control = hungryIcon
  elseif tipType == 4 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_CHANGEORDER_UP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_CHANGEORDER_UP_DESC")
    control = btnUp
  elseif tipType == 5 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_CHANGEORDER_DOWN_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_CHANGEORDER_DOWN_DESC")
    control = btnDown
  elseif tipType == 6 then
    local groupName
    if _ContentsGroup_PetPresetExpansion == true then
      groupName = ToClient_GetPetPresetName(param)
    else
      groupName = ToClient_GetPetGroupName(param - 1)
    end
    if groupName == nil or groupName == "" then
      groupName = "<PAColor0xFFF5BA3A>" .. param .. "<PAOldColor>"
    else
      groupName = "<PAColor0xFFF5BA3A>" .. groupName .. "<PAOldColor>"
    end
    name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP_NAME", "name", groupName)
    desc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP_DESC", "name", groupName, "count", self._maxUnsealCount, "name2", groupName)
    control = UI.getChildControl(contents, "Template_Button_GroupIndex" .. tostring(param))
  elseif tipType == 7 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PETLISTNEW_COMPOSE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_FUSION_DESC")
    control = btnFusion
  elseif tipType == 8 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_CHANGESKILL_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_CHANGESKILL_DESC")
    control = btnChangeSkill
  elseif tipType == 9 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_CHANGEPETNAME_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_CHANGEPETNAME_DESC")
    control = btnChangeName
  end
  TooltipSimple_Show(control, name, desc, icon)
end
function PaGlobal_PetList_All:showRestrictedPresetTooltip(tipType, param, index)
  if _ContentsGroup_PetPresetExpansion == false then
    return
  end
  local name, control
  local icon = false
  local groupName = "<PAColor0xFFF5BA3A>" .. param .. "<PAOldColor>"
  local desc = PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUsePreset")
  if tipType == 1 then
    local pcPetData = ToClient_getPetSealedDataByIndex(index)
    if nil == pcPetData then
      return
    end
    local key = pcPetData._petNo
    local contents = self._ui.list2_Pet:GetContentByKey(key)
    name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP_NAME", "name", groupName)
    control = UI.getChildControl(contents, "Template_Button_GroupIndex" .. tostring(param))
  elseif tipType == 2 then
    name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_GROUPSEALBTN_TOOLTIPTITLE", "name", groupName)
    control = self._ui_pc._btn_AllSeal_Group[param]
  end
  TooltipSimple_Show(control, name, desc, icon)
end
function PaGlobal_PetList_All:unsealPet(petNoStr, isGroup)
  local petNo_s64 = tonumber64(petNoStr)
  if self._maxUnsealCount <= self._UnSealDATACount and false == isGroup then
    Proc_ShowMessage_Ack_WithOut_ChattingMessage(PAGetString(Defines.StringSheet_GAME, "LUA_UNABLE_SUMMON_PET"))
    return
  end
  ToClient_requestPetUnseal(petNo_s64)
  self:showFeedUi(-1)
end
function PaGlobal_PetList_All:unsealPetGroup(groupIndex)
  if nil == groupIndex or groupIndex <= 0 then
    return
  end
  if _ContentsGroup_PetPresetExpansion == true then
    ToClient_UnSealPetPreset(groupIndex)
  else
    ToClient_unSealPetGroupList(groupIndex)
  end
  PaGlobal_PetList_All:showFeedUi(-1)
end
function PaGlobal_PetList_All:fusionButtonShowCheck(petNo_s64, petTier, petRace)
  if false == PaGlobal_PetFusion_GetShow_All() then
    return false
  end
  if true == PaGlobal_PetFusion_IsExist_All(petNo_s64) then
    return false
  end
  if false == PaGlobal_PetList_CheckFusionButtonPcRoomPet_All(petNo_s64) then
    return false
  end
  if petTier == self._leaderPetTier then
    return false
  end
  return true
end
function PaGlobal_PetList_All:unFusionButtonCheck(petNo_s64)
  if true == PaGlobal_PetFusion_IsExist_All(petNo_s64) then
    return true
  end
  return false
end
function PaGlobal_PetList_All:fusionButtonMonoToneCheck(petNo_s64, petTier, petRace)
  if false == PaGlobal_PetFusion_GetShow_All() then
    return false
  end
  if 100 <= PaGlobal_PetFusion_GetRate_All() then
    return true
  end
  if false == PaGlobal_PetFusion_IsMainPetSet_All() and 99 == petRace then
    return true
  end
  if 99 ~= petRace and false == PaGlobal_PetFusion_SetAbleByGrade_All(petNo_s64) then
    return true
  end
  if false == PaGlobal_PetFusion_SetAbleByTier_All(petTier) then
    return true
  end
  if true == PaGlobal_PetFusion_IsMainPetSet_All() and 99 == petRace and false == PaGlobal_PetFusion_GetIsJokerPetUse_All() then
    return true
  end
  if false == PaGlobal_PetList_CheckFusionButtonPcRoomPet_All(petNo_s64) then
    return true
  end
  if petTier == self._leaderPetTier then
    return true
  end
  return false
end
function PaGlobal_PetList_All:closePopUP()
  self._ui_console.stc_PopupBG:SetShow(false)
end
function PaGlobal_PetList_All:showPopUP(isUnseal, index)
  if isPadPressed(__eJoyPadInputType_LeftTrigger) then
    return
  end
  local pcPetData, petNo_s64
  if isUnseal then
    pcPetData = ToClient_getPetUnsealedDataByIndex(index)
    petNo_s64 = pcPetData:getPcPetNo()
  else
    pcPetData = ToClient_getPetSealedDataByIndex(index)
    petNo_s64 = pcPetData._petNo
  end
  self._ui_console.stc_PopupBG:SetPosY(self._ui._petLeader.bg:GetPosY())
  self._ui_console.stc_PopupBG:SetShow(true)
  self:updatePopUP(isUnseal, index, pcPetData, petNo_s64)
  ToClient_padSnapResetControl()
  ToClient_padSnapSetTargetGroup(self._ui_console.stc_PopupBG)
  ToClient_padSnapIgnoreGroupMove()
end
function PaGlobal_PetList_All:updatePopUP(isUnseal, index, pcPetData, petNo_s64)
  local unsealBtns = self._ui_console.rdo_Unseals
  local sealBtns = self._ui_console.rdo_Seals
  for _, control in pairs(unsealBtns) do
    control:SetShow(isUnseal)
  end
  for _, control in pairs(sealBtns) do
    control:SetShow(not isUnseal)
  end
  local currentPresetCount = self._GroupCount
  for idx = 1, self._maxPresetCount do
    self._ui_console.petGroupingBtnList[idx]:SetShow(not isUnseal)
  end
  if _ContentsGroup_PetPresetExpansion == true then
    currentPresetCount = ToClient_GetPetPresetCount()
    if isUnseal == false then
      for idx = 1, self._maxPresetCount do
        self._ui_console.petGroupingBtnList[idx]:SetShow(idx <= currentPresetCount)
      end
    end
  end
  if isUnseal then
    local endPosY = unsealBtns.seal:GetPosY() + unsealBtns.seal:GetSizeY()
    self._ui_console.stc_PopupBG:SetSize(self._ui_console.stc_PopupBG:GetSizeX(), endPosY)
    unsealBtns.feed:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_FeedUI_Show_All(" .. index .. ")")
    unsealBtns.order:addInputEvent("Mouse_LUp", "PaGlobal_PetCommand_All_Open(" .. index .. ")")
    unsealBtns.info:addInputEvent("Mouse_LUp", "HandleEventLUp_PetInfo_Open_All( \"" .. tostring(petNo_s64) .. "\" )")
    unsealBtns.seal:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_Seal_All( \"" .. tostring(petNo_s64) .. "\")")
  else
    local gapY = 10
    local keyGuideIndex = 3
    local iconPath = pcPetData:getIconPath()
    local endPosY = sealBtns.changeName:GetPosY() + sealBtns.changeName:GetSizeY() + gapY
    sealBtns.unseal:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_Unseal_All( \"" .. tostring(petNo_s64) .. "\" , false )")
    sealBtns.exchange:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_All_ExchangeOpen_ForConsole()")
    sealBtns.changeName:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_ChangeName( \"" .. tostring(petNo_s64) .. "\",\"" .. tostring(iconPath:gsub("\\", "\\\\")) .. "\")")
    local petStaticStatus = pcPetData:getPetStaticStatus()
    if petStaticStatus ~= nil then
      local petTier = petStaticStatus:getPetTier() + 1
      if _ContenstGroup_PetSkillChange == true then
        if self._changeSkillTierLimit <= petTier - 1 and pcPetData:getPetStaticStatus():isOnlyPcRoom() == false then
          sealBtns.changeSkill:SetShow(true)
          sealBtns.changeSkill:addInputEvent("Mouse_On", "HandleEventMOn_PetList_All_SetKeyGuideA(" .. keyGuideIndex .. ")")
          sealBtns.changeSkill:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_ChangeSkillUI_Show_All( \"" .. tostring(petNo_s64) .. "\")")
          keyGuideIndex = keyGuideIndex + 1
          endPosY = endPosY + sealBtns.changeSkill:GetSizeY() + gapY
        else
          sealBtns.changeSkill:SetShow(false)
        end
      else
        sealBtns.changeSkill:SetShow(false)
      end
      local isPetLeader = ToClient_isLeaderPet(pcPetData._petNo)
      if petTier == self._leaderPetTier and isPetLeader == false then
        sealBtns.leader:SetSpanSize(sealBtns.leader:GetSpanSize().x, endPosY)
        sealBtns.leader:addInputEvent("Mouse_On", "HandleEventMOn_PetList_All_SetKeyGuideA(" .. keyGuideIndex .. ")")
        sealBtns.leader:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_ChangeLeader( \"" .. tostring(petNo_s64) .. "\")")
        keyGuideIndex = keyGuideIndex + 1
        endPosY = endPosY + sealBtns.leader:GetSizeY() + gapY
      else
        sealBtns.leader:SetShow(false)
      end
    end
    local groupBtnSizeY = 40
    for idx = 1, currentPresetCount do
      self._ui_console.petGroupingBtnList[idx]:SetSpanSize(self._ui_console.petGroupingBtnList[idx]:GetSpanSize().x, endPosY)
      self._ui_console.petGroupingBtnList[idx]:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "HandleEventDpadRight_PetList_All_PopUPBlockSnapGroupMove()")
      self._ui_console.petGroupingBtnList[idx]:addInputEvent("Mouse_On", "HandleEventMOn_PetList_All_SetKeyGuideA(" .. keyGuideIndex .. ")")
      self._ui_console.petGroupingBtnList[idx]:addInputEvent("Mouse_LUp", "PaGlobal_PetList_GroupSealCheck_All(\"" .. tostring(petNo_s64) .. "\", " .. tostring(idx) .. " )")
      keyGuideIndex = keyGuideIndex + 1
      endPosY = endPosY + groupBtnSizeY + gapY
    end
    self._ui_console.stc_PopupBG:SetSize(self._ui_console.stc_PopupBG:GetSizeX(), endPosY)
    PaGlobal_PetList_All:updatePetGroupStateConsole(petNo_s64)
  end
end
function PaGlobal_PetList_All:updateConsoleKeyGuide(keyGuideAlignType)
  if false == self._isConsole then
    return
  end
  self._ui_console.stc_Bottom_KeyGuideRSHori:SetShow(false)
  self._ui_console.stc_Bottom_KeyGuideRSClick:SetShow(false)
  self._ui_console.stc_Bottom_KeyGuideLTPressRSClick:SetShow(false)
  self._ui_console.stc_Bottom_KeyGuideLTA:SetShow(false)
  self._ui_console.stc_Bottom_KeyGuideX:SetShow(false)
  self._ui_console.stc_Bottom_KeyGuideY:SetShow(false)
  self._ui_console.stc_Bottom_KeyGuideA:SetShow(false)
  self._ui_console.stc_Bottom_KeyGuideB:SetShow(false)
  self._ui_console.stc_Feeding_KeyGuideX:SetShow(false)
  self._ui_console.stc_Feeding_KeyGuideY:SetShow(false)
  self._ui_console.stc_Feeding_KeyGuideA:SetShow(false)
  self._ui_console.stc_Feeding_KeyGuideB:SetShow(false)
  self._ui_console.stc_Bottom_KeyGuideBG:SetShow(false)
  self._ui_console.stc_Feeding_KeyGuideBG:SetShow(false)
  local isGroupBtnAble = self._keyGuideAlignType.basic == keyGuideAlignType
  self._ui_pc.txt_FindGroupTitle:SetShow(isGroupBtnAble)
  for i = 1, self._maxPresetCount do
    self._ui_console._btn_AllSealConsole[i]:SetShow(isGroupBtnAble)
  end
  if self._keyGuideAlignType.none == keyGuideAlignType then
    return
  elseif self._keyGuideAlignType.basic == keyGuideAlignType then
    self._ui_console.stc_Bottom_KeyGuideBG:SetShow(true)
    self._ui_console.stc_Bottom_KeyGuideLTPressRSClick:SetShow(true)
    self._ui_console.stc_Bottom_KeyGuideLTA:SetShow(true)
    self._ui_console.stc_Bottom_KeyGuideX:SetShow(true)
    self._ui_console.stc_Bottom_KeyGuideY:SetShow(true)
    self._ui_console.stc_Bottom_KeyGuideA:SetShow(true)
    self._ui_console.stc_Bottom_KeyGuideB:SetShow(true)
    self._ui_console.stc_Bottom_KeyGuideRSHori:SetShow(true)
    self._ui_console.stc_Bottom_KeyGuideRSClick:SetShow(true)
  elseif self._keyGuideAlignType.popup == keyGuideAlignType then
    self._ui_console.stc_Bottom_KeyGuideBG:SetShow(true)
    self._ui_console.stc_Bottom_KeyGuideA:SetShow(true)
    self._ui_console.stc_Bottom_KeyGuideB:SetShow(true)
  elseif self._keyGuideAlignType.feedOne == keyGuideAlignType then
    self._ui_console.stc_Feeding_KeyGuideBG:SetShow(true)
    self._ui_console.stc_Feeding_KeyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETLISTNEW_FEEDONEBTN"))
    self._ui_console.stc_Feeding_KeyGuideX:SetShow(true)
    self._ui_console.stc_Feeding_KeyGuideY:SetShow(true)
    self._ui_console.stc_Feeding_KeyGuideA:SetShow(true)
    self._ui_console.stc_Feeding_KeyGuideB:SetShow(true)
  elseif self._keyGuideAlignType.feedAll == keyGuideAlignType then
    self._ui_console.stc_Feeding_KeyGuideBG:SetShow(true)
    self._ui_console.stc_Feeding_KeyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETRESTOREALL_TITLE"))
    self._ui_console.stc_Feeding_KeyGuideX:SetShow(true)
    self._ui_console.stc_Feeding_KeyGuideA:SetShow(true)
    self._ui_console.stc_Feeding_KeyGuideB:SetShow(true)
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._mainKeyGuides, self._ui_console.stc_Bottom_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_AUTO_WRAP_LEFT)
  self._ui_console.stc_Bottom_KeyGuideBG:SetSize(self._ui_console.stc_Bottom_KeyGuideBG:GetSizeX(), self._ui_console.stc_Bottom_KeyGuideB:GetPosY() + self._ui_console.stc_Bottom_KeyGuideB:GetSizeY() + 10)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._feedKeyGuides, self._ui_console.stc_Feeding_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_AUTO_WRAP_LEFT)
  self._ui_console.stc_Feeding_KeyGuideBG:SetSize(self._ui_console.stc_Feeding_KeyGuideBG:GetSizeX(), self._ui_console.stc_Feeding_KeyGuideB:GetPosY() + self._ui_console.stc_Feeding_KeyGuideB:GetSizeY() + 10)
end
function PaGlobal_PetList_All:UpdateUIByChangedPcRoomState(isPcRoom)
  if true == isPcRoom then
    self._isPremiumPcRoom = true
    self._maxUnsealCount = ToClient_getPetUseMaxCount() + ToClient_getPetUseMaxCountPcRoom()
    self:initPCRoomFilterUi()
  else
    self._isPremiumPcRoom = false
    self._maxUnsealCount = ToClient_getPetUseMaxCount()
    Panel_Window_PetList_All:SetSize(Panel_Window_PetList_All:GetSizeX(), self._originPanelSizeY)
    self._ui.stc_InsideBG:SetSize(self._ui.stc_InsideBG:GetSizeX(), self._originInsideBGSizeY)
    self._ui.list2_Pet:SetSpanSize(self._ui.list2_Pet:GetSpanSize().x, self._originPetListSpanY)
    self._ui_pc.stc_DesBG:SetSpanSize(self._ui_pc.stc_DesBG:GetSpanSize().x, self._originDesBGSpanY)
    self._ui_pc.stc_FindGroupBG:SetSpanSize(self._ui_pc.stc_FindGroupBG:GetSpanSize().x, self._originFindGroupBGSpanY)
    self._ui_pc.stc_BtnGroup:SetSpanSize(self._ui_pc.stc_BtnGroup:GetSpanSize().x, self._originBtnGroupSpanY)
    self._ui.stc_SkillInfoBG:SetSpanSize(self._ui.stc_SkillInfoBG:GetSpanSize().x, self._originSkillInfoBGSpanY)
    self._ui_pc.btn_RegistPCRoom:SetPosY(self._originBtnRegistPCRoomSpanY)
  end
  self:updatePetList()
end
function PaGlobal_PetList_All:updatePetGroupStateConsole(petNo_s64)
  if nil == petNo_s64 then
    return
  end
  local maxPresetCount = self._GroupCount
  if _ContentsGroup_PetPresetExpansion == true then
    maxPresetCount = ToClient_GetPetPresetCount()
  end
  for idx = 1, maxPresetCount do
    local isGroup = self:isCheckGroupBtnByPetNo(petNo_s64, idx)
    if isGroup == true then
      self._ui_console.petGroupingBtnList[idx]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_GROUPCLEAR", "index", idx))
    else
      self._ui_console.petGroupingBtnList[idx]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_GROUPSET", "index", idx))
    end
  end
end
function PaGlobal_PetList_All:changePetLeader(petNoStr)
  local petNo_s64 = tonumber64(petNoStr)
  ToClient_requestChangeLeaderPet(petNo_s64)
end
function PaGlobal_PetList_All:showChangeSkillUi(targetPetIndex)
  if nil == Panel_Window_PetList_All then
    return
  end
  if self._feedingPetIndex == targetPetIndex then
    targetPetIndex = -1
  end
  self:clearSelect()
  local showFlag = targetPetIndex >= 0
  self._feedingPetIndex = targetPetIndex
  if showFlag then
    local petData = ToClient_getPetUnsealedDataByIndex(targetPetIndex)
    if not petData then
      return
    end
    local petNo = petData:getPcPetNo()
    local contents = self._ui.list2_Pet:GetContentByKey(petNo)
    if nil == contents then
      contents = self._ui._petLeader.bg
    end
    local btnFeed = UI.getChildControl(contents, "Button_Feeding")
    self._ui.stc_FeedingBG:SetPosY(contents:GetPosY() + btnFeed:GetPosY())
    self._ui.stc_FeedingBG:SetPosX(contents:GetPosX() + btnFeed:GetPosX() + 50)
    self:updateFeedUi()
    local userFeedItemCount = ToClient_Pet_GetFeedItemCount()
    if userFeedItemCount > 0 then
      HandleEventLUp_PetList_FeedItem_All(0)
    end
  else
    self:updateConsoleKeyGuide(self._keyGuideAlignType.basic)
  end
end
function PaGlobal_PetList_All:changeSkill(petNoStr)
  local petNo_s64 = tonumber64(petNoStr)
end
function PaGlobal_PetList_All:updatePetPreset(presetKey)
  if _ContentsGroup_PetPresetExpansion == false or Panel_Window_PetList_All:GetShow() == false then
    return
  end
  self._checkUnSealGroupList[presetKey] = {}
  local petCount = ToClient_GetPetFusionCount()
  for index = 0, petCount - 1 do
    local petNo = tostring(ToClient_GetPetNoInPresetByIndex(presetKey, index))
    if petNo ~= "-1" then
      self._checkUnSealGroupList[presetKey][petNo] = true
    end
  end
  PaGlobal_PetList_All:SetPetList(true)
end
function PaGlobal_PetList_All:updatePetPresetAll()
  if _ContentsGroup_PetPresetExpansion == false or Panel_Window_PetList_All:GetShow() == false then
    return
  end
  PaGlobal_PetList_All:loadPetGroupList()
  PaGlobal_PetList_All:SetPetList(true)
end
