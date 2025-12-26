Panel_QuickSlot:SetShow(false, false)
Panel_QuickSlot:SetPosX((getScreenSizeX() - Panel_QuickSlot:GetSizeX()) / 2)
Panel_QuickSlot:SetPosY(getScreenSizeY() - Panel_QuickSlot:GetSizeY())
local EmergencySkillKey = 6029313
function isUseNewQuickSlot()
  if true == ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eNewQuickSlot) then
    if false == _ContentsGroup_Tutorial_Renewal and true == PaGlobal_TutorialManager:isDoingTutorial() and false == PaGlobal_TutorialManager:isAllowNewQuickSlot() then
      return false
    end
    return true
  end
  return false
end
local isItemSlot = function(slotType)
  return __eQuickSlotDataType_Item == slotType or __eQuickSlotDataType_CashItem == slotType or __eQuickSlotDataType_InstanceItem == slotType or __eQuickSlotDataType_FamilyItem == slotType
end
local isSkillSlot = function(slotType)
  return __eQuickSlotDataType_Skill == slotType
end
local isSocialActionSlot = function(slotType)
  return __eQuickSlotDataType_SocialAction == slotType
end
Panel_QuickSlot:RegisterShowEventFunc(true, "QuickSlot_ShowAni()")
Panel_QuickSlot:RegisterShowEventFunc(false, "QuickSlot_HideAni()")
Panel_CoolTime_Effect_Item_Slot:RegisterShowEventFunc(true, "QuickSlot_ItemCoolTimeEffect_HideAni()")
Panel_CoolTime_Effect_Slot:RegisterShowEventFunc(true, "QuickSlot_SkillCoolTimeEffect_HideAni()")
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_PSFT = CppEnums.PAUI_SHOW_FADE_TYPE
local UI_color = Defines.Color
local quickSlotBg = UI.getChildControl(Panel_QuickSlot, "Static_Main_BG")
local quickSlotText = UI.getChildControl(Panel_QuickSlot, "StaticText_quickSlot")
local quickSlot = {
  slotConfig_Item = {
    createIcon = true,
    createBorder = false,
    createCount = true,
    createCooltime = true,
    createCooltimeText = true,
    createCash = true,
    createMaidActorOnly = true,
    createEnchant = true,
    createQuickslotBagIcon = true,
    createFamilyInvenotry = true
  },
  slotConfig_Skill = {
    createIcon = true,
    createEffect = true,
    createFG = false,
    createFGDisabled = false,
    createLevel = false,
    createLearnButton = false,
    createCooltime = true,
    createCooltimeText = true,
    template = {effect}
  },
  config = {
    slotCount = 10,
    slotInitStartX = -5,
    slotInitStartY = 13,
    slotInitGapX = 55,
    slotInitGapY = 0
  },
  template = {
    slotBackground = UI.getChildControl(Panel_QuickSlot, "StaticText_Slot_BG_Txt")
  },
  slots = {},
  numberNames = {
    "Static_No_1",
    "Static_No_2",
    "Static_No_3",
    "Static_No_4",
    "Static_No_5",
    "Static_No_6",
    "Static_No_7",
    "Static_No_8",
    "Static_No_9",
    "Static_No_10"
  },
  skillToggle = {
    "Static_SkillToggle_1",
    "Static_SkillToggle_2",
    "Static_SkillToggle_3",
    "Static_SkillToggle_4",
    "Static_SkillToggle_5",
    "Static_SkillToggle_6",
    "Static_SkillToggle_7",
    "Static_SkillToggle_8",
    "Static_SkillToggle_9",
    "Static_SkillToggle_10"
  },
  slotMemo = {
    "Editable_Memo_1",
    "Editable_Memo_2",
    "Editable_Memo_3",
    "Editable_Memo_4",
    "Editable_Memo_5",
    "Editable_Memo_6",
    "Editable_Memo_7",
    "Editable_Memo_8",
    "Editable_Memo_9",
    "Editable_Memo_10"
  },
  slotMemoBG = {
    "Static_MemoBg_1",
    "Static_MemoBg_2",
    "Static_MemoBg_3",
    "Static_MemoBg_4",
    "Static_MemoBg_5",
    "Static_MemoBg_6",
    "Static_MemoBg_7",
    "Static_MemoBg_8",
    "Static_MemoBg_9",
    "Static_MemoBg_10"
  },
  slotPencil = {
    "Static_Pencil_1",
    "Static_Pencil_2",
    "Static_Pencil_3",
    "Static_Pencil_4",
    "Static_Pencil_5",
    "Static_Pencil_6",
    "Static_Pencil_7",
    "Static_Pencil_8",
    "Static_Pencil_9",
    "Static_Pencil_10"
  },
  quickSlotInit = false,
  initPosX = Panel_QuickSlot:GetPosX(),
  initPosY = Panel_QuickSlot:GetPosY(),
  isRemoteInstallMode = false
}
PaGlobal_QuickSlot = {}
function PaGlobal_QuickSlot:addSlotEffectForTutorial(itemSlot, effectString, isLoop, posX, posY)
  itemSlot.item.icon:AddEffect(effectString, isLoop, posX, posY)
  PaGlobal_TutorialUiManager:getUiMasking():showQuickSlotMasking(itemSlot.item.icon:GetPosX(), itemSlot.item.icon:GetPosY())
end
function PaGlobal_QuickSlot:eraseSlotEffectForTutorial(itemSlot)
  if nil ~= itemSlot and nil ~= itemSlot.item then
    itemSlot.item.icon:EraseAllEffect()
    PaGlobal_TutorialUiManager:getUiMasking():hideQuestMasking()
  end
end
function PaGlobal_QuickSlot:getSlotByIndex(slotIndex)
  if slotIndex <= #quickSlot.slots then
    _PA_LOG("\234\179\189\235\175\188\236\154\176", "getSlotByIndex : " .. tostring("\236\138\172\235\161\175 \236\132\177\234\179\181!"))
    return quickSlot.slots[slotIndex]
  end
  _PA_ASSERT(false, "\234\184\176\235\179\184\237\128\181\236\138\172\235\161\175\236\157\152 \235\178\148\236\156\132\235\165\188 \236\180\136\234\179\188\237\150\136\236\138\181\235\139\136\235\139\164.")
end
function quickSlot:init()
  if true == _ContentsGroup_UsePadSnapping then
    Panel_QuickSlot:SetRenderAndEventHide(true)
  else
    Panel_QuickSlot:SetRenderAndEventHide(false)
  end
  if true == ToClient_IsRemoteInstallMode() then
    Panel_QuickSlot:SetRenderAndEventHide(true)
    self.isRemoteInstallMode = true
  end
  if true == _ContentsGroup_UISkillGroupTreeLayOut then
    quickSlot.slotConfig_Skill.createEffect = false
  elseif ToClient_isConsole() == false then
    quickSlot.slotConfig_Skill.template.effect = UI.getChildControl(Panel_Window_Skill, "Static_Icon_Skill_Effect")
  else
    quickSlot.slotConfig_Skill.template.effect = PaGlobalFunc_Skill_GetEffectControl()
  end
  for idx, slot in ipairs(self.slots) do
    slot.background:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/BlackPanel_Series.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(slot.background, 5, 5, 50, 50)
    slot.background:geOnTexture():setUV(x1, y1, x2, y2)
    slot.background:setRenderTexture(slot.background:geOnTexture())
    slot.background:SetAlpha(0.7)
  end
end
function QuickSlot_ShowAni()
  Panel_QuickSlot:SetShowWithFade(UI_PSFT.PAUI_ANI_TYPE_FADE_IN)
  local QuickSlotOpen_Alpha = Panel_QuickSlot:addColorAnimation(0, 0.35, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  QuickSlotOpen_Alpha:SetStartColor(UI_color.C_00FFFFFF)
  QuickSlotOpen_Alpha:SetEndColor(UI_color.C_FFFFFFFF)
  QuickSlotOpen_Alpha.IsChangeChild = true
end
function QuickSlot_HideAni()
  Panel_QuickSlot:SetShowWithFade(UI_PSFT.PAUI_ANI_TYPE_FADE_OUT)
  local QuickSlotClose_Alpha = Panel_QuickSlot:addColorAnimation(0, 0.25, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  QuickSlotClose_Alpha:SetStartColor(UI_color.C_FFFFFFFF)
  QuickSlotClose_Alpha:SetEndColor(UI_color.C_00FFFFFF)
  QuickSlotClose_Alpha.IsChangeChild = true
  QuickSlotClose_Alpha:SetHideAtEnd(true)
  QuickSlotClose_Alpha:SetDisableWhileAni(true)
end
function QuickSlot_ItemCoolTimeEffect_HideAni()
  audioPostEvent_SystemUi(2, 4)
  _AudioPostEvent_SystemUiForXBOX(2, 4)
  Panel_CoolTime_Effect_Item_Slot:SetShowWithFade(UI_PSFT.PAUI_ANI_TYPE_FADE_OUT)
  local coolTime_Item_Slot = Panel_CoolTime_Effect_Item_Slot:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  coolTime_Item_Slot:SetStartColor(UI_color.C_FFFFFFFF)
  coolTime_Item_Slot:SetEndColor(UI_color.C_00FFFFFF)
  coolTime_Item_Slot:SetStartIntensity(3)
  coolTime_Item_Slot:SetEndIntensity(1)
  coolTime_Item_Slot.IsChangeChild = true
  coolTime_Item_Slot:SetHideAtEnd(true)
  coolTime_Item_Slot:SetDisableWhileAni(true)
end
function QuickSlot_SkillCoolTimeEffect_HideAni()
  audioPostEvent_SystemUi(2, 0)
  _AudioPostEvent_SystemUiForXBOX(2, 0)
  Panel_CoolTime_Effect_Slot:SetShowWithFade(UI_PSFT.PAUI_ANI_TYPE_FADE_OUT)
  local coolTime_Slot = Panel_CoolTime_Effect_Slot:addColorAnimation(0, 3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  coolTime_Slot:SetStartColor(UI_color.C_FFFFFFFF)
  coolTime_Slot:SetEndColor(UI_color.C_00FFFFFF)
  coolTime_Slot:SetStartIntensity(3)
  coolTime_Slot:SetEndIntensity(1)
  coolTime_Slot.IsChangeChild = true
  coolTime_Slot:SetHideAtEnd(true)
  coolTime_Slot:SetDisableWhileAni(true)
end
function quickSlot:createSlot()
  for ii = 1, self.config.slotCount do
    do
      local slot = {
        index = ii,
        slotType = __eQuickSlotDataType_Empty,
        keyValue = nil,
        posX = self.config.slotInitStartX + (ii - 0.73) * self.config.slotInitGapX,
        posY = self.config.slotInitStartY + (ii - 1) * self.config.slotInitGapY,
        item = nil,
        skill = nil,
        socialAction = nil,
        background = UI.createControl(__ePAUIControl_StaticText, Panel_QuickSlot, "Static_Slot_BG_" .. ii),
        memo = UI.getChildControl(Panel_QuickSlot, self.slotMemo[ii]),
        memoBG = UI.getChildControl(Panel_QuickSlot, self.slotMemoBG[ii]),
        pencil = UI.getChildControl(Panel_QuickSlot, self.slotPencil[ii]),
        number = UI.getChildControl(Panel_QuickSlot, self.numberNames[ii]),
        toggle = UI.getChildControl(Panel_QuickSlot, self.skillToggle[ii])
      }
      CopyBaseProperty(self.template.slotBackground, slot.background)
      slot.background:SetShow(true)
      slot.background:SetAlpha(1)
      slot.background:addInputEvent("Mouse_On", "QuickSlot_ShowBackGroundToggle(true," .. ii .. ")")
      slot.background:addInputEvent("Mouse_Out", "QuickSlot_ShowBackGroundToggle(false," .. ii .. ")")
      slot.memo:RegistReturnKeyEvent("QuickSlot_SaveMemoInNormalQuickSlot(" .. ii .. ")")
      function slot:rearrangeControl()
        local list = Array.new()
        if isItemSlot(self.slotType) then
          UI.ASSERT(slot.item, "Item is Null!!!")
          list:push_back(self.background)
          list:push_back(self.item.icon)
          list:push_back(self.number)
        elseif isSkillSlot(self.slotType) then
          UI.ASSERT(nil ~= slot.skill)
          list:push_back(self.background)
          list:push_back(self.skill.icon)
          list:push_back(self.skill.effect)
          list:push_back(self.number)
          list:push_back(self.toggle)
        elseif isSocialActionSlot(self.slotType) then
          UI.ASSERT(nil ~= slot.socialAction)
          list:push_back(self.background)
          list:push_back(self.socialAction)
          list:push_back(self.number)
        else
          list:push_back(self.background)
          list:push_back(self.number)
        end
        for ii = 1, list:length() - 1 do
          for jj = ii + 1, list:length() do
            local first = list[ii]
            local second = list[jj]
            UI.ASSERT(nil ~= first and nil ~= second and first ~= second)
            Panel_QuickSlot:SetChildOrder(list[ii]:GetKey(), list[jj]:GetKey())
          end
        end
      end
      function slot:setPos(posX, posY)
        local tmp
        tmp = self.background
        tmp:SetSize(50, 50)
        tmp:SetPosX(posX)
        tmp:SetPosY(posY)
        local bgSizeX = tmp:GetSizeX()
        local bgSizeY = tmp:GetSizeY()
        if isItemSlot(self.slotType) then
          tmp = self.item.icon
          tmp:SetSize(42, 42)
          local iconPosX = posX + (bgSizeX - tmp:GetSizeX()) / 2
          local iconPosY = posY + (bgSizeY - tmp:GetSizeY()) / 2
          tmp:SetPosX(iconPosX)
          tmp:SetPosY(iconPosY)
        elseif isSkillSlot(self.slotType) then
          tmp = self.skill.icon
          tmp:SetSize(42, 42)
          local iconPosX = posX + (bgSizeX - tmp:GetSizeX()) / 2
          local iconPosY = posY + (bgSizeY - tmp:GetSizeY()) / 2
          tmp:SetPosX(iconPosX)
          tmp:SetPosY(iconPosY)
          tmp = self.skill.cooltime
          tmp:SetPosX(iconPosX)
          tmp:SetPosY(iconPosY)
          tmp = self.skill.cooltimeText
          tmp:SetPosX(iconPosX)
          tmp:SetPosY(iconPosY)
          tmp = self.skill.effect
          if nil ~= tmp then
            tmp:SetPosX(posX + (bgSizeX - tmp:GetSizeX()) / 2)
            tmp:SetPosY(posY + (bgSizeY - tmp:GetSizeY()) / 2)
          end
          tmp = self.toggle
          tmp:SetPosX(posX + (bgSizeX - tmp:GetSizeX()) / 2)
          tmp:SetPosY(posY + (bgSizeY - tmp:GetSizeY()) / 2)
        elseif isSocialActionSlot(self.slotType) then
          tmp = self.socialAction
          tmp:SetSize(42, 42)
          local iconPosX = posX + (bgSizeX - tmp:GetSizeX()) / 2
          local iconPosY = posY + (bgSizeY - tmp:GetSizeY()) / 2
          tmp:SetPosX(iconPosX)
          tmp:SetPosY(iconPosY)
        end
        tmp = self.number
        tmp:SetPosX(posX + (bgSizeX - tmp:GetSizeX()) / 2)
        tmp:SetPosY(posY - tmp:GetSizeY() / 2 + bgSizeX)
        tmp = self.memo
        tmp:SetPosX(posX - 75)
        tmp:SetPosY(posY - 20)
        tmp = self.memoBG
        tmp:SetPosX(posX)
        tmp:SetPosY(posY - 20)
        tmp = self.pencil
        tmp:SetPosX(posX + 10)
        tmp:SetPosY(posY - 25)
      end
      function slot:setItem(slotNo, quickSlotInfo)
        if false == isItemSlot(self.slotType) then
          if isSkillSlot(self.slotType) then
            self.skill:destroyChild()
            Panel_SkillTooltip_Hide()
            self.skill = nil
          elseif isSocialActionSlot(self.slotType) then
            UI.ASSERT(nil ~= self.socialAction)
            UI.deleteControl(self.socialAction)
            self.socialAction = nil
          end
          self.slotType = quickSlotInfo._type
          if _ContentsGroup_QuickSlotMemo == true then
            self.memo:SetShow(true)
          else
            self.memo:SetShow(false)
          end
          self.memo:addInputEvent("Mouse_On", "HandleOnOut_QuickSlot_SkillTooltip(" .. slotNo .. ", \"QuickSlot\", true)")
          self.memo:addInputEvent("Mouse_Out", "HandleOnOut_QuickSlot_SkillTooltip(" .. slotNo .. ", \"QuickSlot\", false)")
          local itemSlot = {}
          SlotItem.new(itemSlot, "QuickSlot_" .. slotNo, slotNo, Panel_QuickSlot, quickSlot.slotConfig_Item)
          itemSlot:createChild()
          itemSlot.icon:addInputEvent("Mouse_LUp", "QuickSlot_Click(" .. self.index - 1 .. ")")
          itemSlot.icon:addInputEvent("Mouse_PressMove", "QuickSlot_DragStart(" .. self.index - 1 .. ")")
          itemSlot.icon:SetEnableDragAndDrop(true)
          self.background:SetIgnore(true)
          self.number:AddEffect("UI_SkillButton01", false, 0, 0)
          self.number:AddEffect("fUI_Repair01", false, 0, 0)
          self.background:AddEffect("fUI_Light", false, 0, 0)
          local actionKeyIndex = CppEnums.ActionInputType.ActionInputType_QuickSlot1 + slotNo
          self.number:SetText(keyCustom_GetString_ActionKey(actionKeyIndex))
          self.number:SetFontColor(UI_color.C_FFA2D51F)
          self.item = itemSlot
          self:rearrangeControl()
          self:setPos(self.background:GetPosX(), self.background:GetPosY())
        end
        self.slotType = quickSlotInfo._type
        local selfPlayer = getSelfPlayer():get()
        local inventoryType = QuickSlot_GetInventoryTypeFrom(self.slotType)
        local inventory = selfPlayer:getInventoryByType(inventoryType)
        local invenSlotNo = inventory:getSlot(quickSlotInfo._itemKey)
        local itemStaticWrapper = getItemEnchantStaticStatus(quickSlotInfo._itemKey)
        local _const = Defines.s64_const
        local s64_stackCount = _const.s64_0
        local targetItemNotFound = false
        if __eTInventorySlotNoUndefined ~= invenSlotNo then
          s64_stackCount = getInventoryItemByType(inventoryType, invenSlotNo):get():getCount_s64()
        else
          targetItemNotFound = true
        end
        slot.background:SetTextMode(__eTextMode_AutoWrap)
        if CppEnums.ContentsEventType.ContentsType_InventoryBag == itemStaticWrapper:get():getContentsEventType() and itemStaticWrapper:get():isCollectTool() == false then
          invenSlotNo = ToClient_GetItemNoByInventory(inventoryType, quickSlotInfo._itemNo_s64)
          local itemWrapper = getInventoryItemByType(inventoryType, invenSlotNo)
          if nil ~= itemWrapper then
            itemStaticWrapper = itemWrapper:getStaticStatus()
            self.item:setItem(itemWrapper, invenSlotNo)
          else
            targetItemNotFound = true
          end
        else
          self.item:setItemByStaticStatus(itemStaticWrapper, s64_stackCount, -1, false, false, false, 0, 0, false, false, false, __eQuickSlotDataType_FamilyItem == quickSlotInfo._type)
        end
        self.keyValue = invenSlotNo
        self.item.icon:SetMonoTone(targetItemNotFound or _const.s64_0 == s64_stackCount)
        local itemSlot = self.item
        self.item.icon:addInputEvent("Mouse_On", "HandleOnOut_QuickSlot_ItemTooltip(" .. slotNo .. ", \"QuickSlot\", true)")
        self.item.icon:addInputEvent("Mouse_Out", "HandleOnOut_QuickSlot_ItemTooltip(" .. slotNo .. ", \"QuickSlot\", false)")
        Panel_Tooltip_Item_SetPosition(slotNo, self.item, "QuickSlot")
        self.toggle:SetShow(false)
      end
      function slot:setSkill(slotNo, quickSlotInfo)
        if false == isSkillSlot(self.slotType) then
          if isItemSlot(self.slotType) then
            UI.ASSERT(nil ~= self.item)
            UI.deleteControl(self.item.icon)
            Panel_Tooltip_Item_hideTooltip()
            self.item = nil
          elseif isSocialActionSlot(self.slotType) then
            UI.ASSERT(nil ~= self.socialAction)
            UI.deleteControl(self.socialAction)
            self.socialAction = nil
          end
          self.slotType = __eQuickSlotDataType_Skill
          if _ContentsGroup_QuickSlotMemo == true then
            self.memo:SetShow(true)
          else
            self.memo:SetShow(false)
          end
          self.memo:addInputEvent("Mouse_On", "HandleOnOut_QuickSlot_SkillTooltip(" .. slotNo .. ", \"QuickSlot\", true)")
          self.memo:addInputEvent("Mouse_Out", "HandleOnOut_QuickSlot_SkillTooltip(" .. slotNo .. ", \"QuickSlot\", false)")
          local skillSlot = {}
          SlotSkill.new(skillSlot, slotNo, Panel_QuickSlot, quickSlot.slotConfig_Skill)
          skillSlot.icon:addInputEvent("Mouse_LUp", "QuickSlot_Click(" .. self.index - 1 .. ")")
          skillSlot.icon:addInputEvent("Mouse_PressMove", "QuickSlot_DragStart(" .. self.index - 1 .. ")")
          skillSlot.icon:SetEnableDragAndDrop(true)
          self.number:AddEffect("UI_SkillButton01", false, 0, 0)
          self.number:AddEffect("fUI_Repair01", false, 0, 0)
          self.background:AddEffect("fUI_Light", false, 0, 0)
          local actionKeyIndex = CppEnums.ActionInputType.ActionInputType_QuickSlot1 + slotNo
          self.number:SetText(keyCustom_GetString_ActionKey(actionKeyIndex))
          self.number:SetFontColor(UI_color.C_FFA2D51F)
          self.skill = skillSlot
          self:rearrangeControl()
          self.background:SetIgnore(true)
          self:setPos(self.background:GetPosX(), self.background:GetPosY())
        end
        local skillNo = quickSlotInfo._skillKey:getSkillNo()
        local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
        self.skill.skillNo = skillNo
        slot.background:SetTextMode(__eTextMode_AutoWrap)
        UI.ASSERT(skillTypeStaticWrapper, "get Fail - Skill Type Static Status ")
        self.keyValue = quickSlotInfo._skillKey
        self.skill:setSkillTypeStatic(skillTypeStaticWrapper)
        self.skill.icon:addInputEvent("Mouse_LUp", "QuickSlot_Click(" .. self.index - 1 .. ")")
        self.skill.icon:addInputEvent("Mouse_PressMove", "QuickSlot_DragStart(" .. self.index - 1 .. ")")
        self.skill.icon:addInputEvent("Mouse_On", "HandleOnOut_QuickSlot_SkillTooltip(" .. slotNo .. ", \"QuickSlot\", true)")
        self.skill.icon:addInputEvent("Mouse_Out", "HandleOnOut_QuickSlot_SkillTooltip(" .. slotNo .. ", \"QuickSlot\", false)")
        Panel_SkillTooltip_SetPosition(slotNo, self.skill.icon, "QuickSlot")
      end
      function slot:setSocialAction(slotNo, quickSlotInfo)
        if false == isSocialActionSlot(self.slotType) then
          if isItemSlot(self.slotType) then
            UI.ASSERT(nil ~= self.item)
            UI.deleteControl(self.item.icon)
            Panel_Tooltip_Item_hideTooltip()
            self.item = nil
          elseif isSkillSlot(self.slotType) then
            self.skill:destroyChild()
            Panel_SkillTooltip_Hide()
            self.skill = nil
          end
          self.slotType = __eQuickSlotDataType_SocialAction
          if _ContentsGroup_QuickSlotMemo == true then
            self.memo:SetShow(true)
          else
            self.memo:SetShow(false)
          end
          self.memo:addInputEvent("Mouse_On", "HandleOnOut_QuickSlot_SkillTooltip(" .. slotNo .. ", \"QuickSlot\", true)")
          self.memo:addInputEvent("Mouse_Out", "HandleOnOut_QuickSlot_SkillTooltip(" .. slotNo .. ", \"QuickSlot\", false)")
          local socialActionSlot = UI.createControl(__ePAUIControl_Static, Panel_QuickSlot, "Static_SocialIconQuickSlot_" .. slotNo)
          local socialIconSlot = UI.getChildControl(Panel_Chat_SocialMenu, "Static_C_SocialIcon")
          CopyBaseProperty(socialIconSlot, socialActionSlot)
          socialActionSlot:SetSize(42, 42)
          socialActionSlot:ActiveMouseEventEffect(true)
          socialActionSlot:SetIgnore(false)
          socialActionSlot:SetShow(true)
          socialActionSlot:addInputEvent("Mouse_LUp", "QuickSlot_Click(" .. self.index - 1 .. ")")
          socialActionSlot:addInputEvent("Mouse_PressMove", "QuickSlot_DragStart(" .. self.index - 1 .. ")")
          socialActionSlot:SetEnableDragAndDrop(true)
          self.number:AddEffect("UI_SkillButton01", false, 0, 0)
          self.number:AddEffect("fUI_Repair01", false, 0, 0)
          self.background:AddEffect("fUI_Light", false, 0, 0)
          local actionKeyIndex = CppEnums.ActionInputType.ActionInputType_QuickSlot1 + slotNo
          self.number:SetText(keyCustom_GetString_ActionKey(actionKeyIndex))
          self.number:SetFontColor(UI_color.C_FFA2D51F)
          self.socialAction = socialActionSlot
          self:rearrangeControl()
          self.background:SetIgnore(true)
          self:setPos(self.background:GetPosX(), self.background:GetPosY())
        end
        local socialActionKeyFromCpp = quickSlotInfo._socialActionKey:get()
        local sASS = ToClient_getSocialActionStaticStatusByKey(socialActionKeyFromCpp)
        if nil == sASS then
          _PA_ASSERT_NAME(false, "socialActionInfo\236\157\152 StaticStatus\235\165\188 \234\176\128\236\160\184\236\152\164\235\138\148\235\141\176 \236\139\164\237\140\168\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164.", "\236\160\149\236\152\129\236\164\128")
          return
        end
        local iconPath = sASS:getIconPath()
        if nil ~= iconPath then
          self.socialAction:ChangeTextureInfoNameAsync("Icon/" .. iconPath)
        end
        self.socialAction:SetAlpha(1)
        slot.background:SetTextMode(__eTextMode_AutoWrap)
        self.socialAction:addInputEvent("Mouse_LUp", "QuickSlot_Click(" .. self.index - 1 .. ")")
        self.socialAction:addInputEvent("Mouse_PressMove", "QuickSlot_DragStart(" .. self.index - 1 .. ")")
        self.socialAction:addInputEvent("Mouse_On", "HandleOnOut_QuickSlot_SocialActionTooltip(" .. slotNo .. ", \"QuickSlot\", true)")
        self.socialAction:addInputEvent("Mouse_Out", "HandleOnOut_QuickSlot_SocialActionTooltip(" .. slotNo .. ", \"QuickSlot\", false)")
      end
      function slot:setEmpty()
        if isItemSlot(self.slotType) then
          UI.ASSERT(nil ~= self.item)
          UI.deleteControl(self.item.icon)
          Panel_Tooltip_Item_hideTooltip()
          self.item = nil
          audioPostEvent_SystemUi(0, 2)
          _AudioPostEvent_SystemUiForXBOX(0, 2)
        elseif isSkillSlot(self.slotType) then
          UI.ASSERT(nil ~= self.skill)
          self.skill:destroyChild()
          Panel_SkillTooltip_Hide()
          Panel_Tooltip_Item_hideTooltip()
          self.skill = nil
          audioPostEvent_SystemUi(0, 9)
          _AudioPostEvent_SystemUiForXBOX(0, 9)
        elseif isSocialActionSlot(self.slotType) then
          UI.ASSERT(nil ~= self.socialAction)
          UI.deleteControl(self.socialAction)
          self.socialAction = nil
          audioPostEvent_SystemUi(0, 9)
          _AudioPostEvent_SystemUiForXBOX(0, 9)
        end
        self.memo:SetEditText("")
        self.memo:SetShow(false)
        local index = self.index - 1
        local actionKeyIndex = CppEnums.ActionInputType.ActionInputType_QuickSlot1 + index
        self.number:SetText(keyCustom_GetString_ActionKey(actionKeyIndex))
        self.number:SetFontColor(UI_color.C_FF988D83)
        self.toggle:SetShow(false)
        slot.background:SetText("")
        self.background:SetIgnore(false)
        self.background:addInputEvent("Mouse_LUp", "QuickSlot_DropHandler(" .. self.index - 1 .. ")")
        self.slotType = __eQuickSlotDataType_Empty
        self.keyValue = nil
      end
      function slot:GetMemoSlotText()
        return (self.memo:GetEditText())
      end
      slot:setPos(slot.posX, slot.posY)
      slot:rearrangeControl()
      self.slots[ii] = slot
    end
  end
end
function QuickSlot_DropHandler(slotIndex)
  if nil == DragManager.dragStartPanel then
    return false
  end
  local inventoryPanel
  if true == _ContentsGroup_NewUI_Inventory_All then
    inventoryPanel = Panel_Window_Inventory_All
  else
    inventoryPanel = Panel_Window_Inventory
  end
  if DragManager.dragStartPanel == inventoryPanel or DragManager.dragStartPanel == Panel_Window_FamilyInventory_All then
    local itemWrapper = getInventoryItemByType(DragManager.dragWhereTypeInfo, DragManager.dragSlotInfo)
    if nil ~= itemWrapper and (itemWrapper:getStaticStatus():get():isContentsEvent() or itemWrapper:getStaticStatus():get():isItemSkill() or itemWrapper:getStaticStatus():get():isItemInterAction() or itemWrapper:getStaticStatus():get():isUseToVehicle() or itemWrapper:getStaticStatus():get():isEquipable() or itemWrapper:getStaticStatus():get():isItemTent()) then
      quickSlot_RegistItem(slotIndex, DragManager.dragWhereTypeInfo, DragManager.dragSlotInfo)
      PaGlobal_TutorialManager:handleQuickSlotRegistItem(slotIndex, DragManager.dragWhereTypeInfo, DragManager.dragSlotInfo)
    end
  elseif DragManager.dragStartPanel == Panel_Window_Skill then
    quickSlot_RegistSkill(slotIndex, DragManager.dragSlotInfo)
  elseif DragManager.dragStartPanel == Panel_QuickSlot then
    if slotIndex ~= DragManager.dragSlotInfo then
      PaGlobalFunc_QuickSlot_Swap(slotIndex, DragManager.dragSlotInfo)
    end
  elseif Panel_Window_SkillGroup ~= nil and DragManager.dragStartPanel == Panel_Window_SkillGroup or Panel_Window_SkillGroup_All ~= nil and DragManager.dragStartPanel == Panel_Window_SkillGroup_All then
    quickSlot_RegistSkill(slotIndex, DragManager.dragSlotInfo)
    PaGlobal_SkillGroup_QuickSlot:update()
  elseif DragManager.dragStartPanel == Panel_Window_SkillGroup_QuickSlot then
    if slotIndex ~= DragManager.dragSlotInfo then
      PaGlobalFunc_QuickSlot_Swap(slotIndex, DragManager.dragSlotInfo)
      PaGlobal_SkillGroup_QuickSlot:update()
    end
  elseif DragManager.dragStartPanel == Panel_GuildSkill_All then
    quickSlot_RegistSkill(slotIndex, DragManager.dragSlotInfo)
  elseif DragManager.dragStartPanel == Panel_Chat_SocialMenu then
    quickSlot_RegistSocialAction(slotIndex, DragManager.dragSlotInfo)
  end
  audioPostEvent_SystemUi(0, 8)
  _AudioPostEvent_SystemUiForXBOX(0, 8)
  DragManager:clearInfo()
  return true
end
function QuickSlot_GroundClick(whereType, slotIndex)
  local itemSlot = quickSlot.slots[slotIndex + 1]
  quickSlot_Clear(slotIndex)
  local actionKeyIndex = CppEnums.ActionInputType.ActionInputType_QuickSlot1 + slotIndex
  if nil ~= itemSlot.number then
    itemSlot.number:SetText(keyCustom_GetString_ActionKey(actionKeyIndex))
  end
end
function QuickSlot_Click(slotIndex)
  if nil == slotIndex then
    return
  end
  local quickSlotInfo = getQuickSlotItem(slotIndex)
  if nil == quickSlotInfo then
    return
  end
  local itemKey = quickSlotInfo._itemKey:getItemKey()
  local itemSlot = quickSlot.slots[slotIndex + 1]
  PaGlobal_TutorialManager:handleQuickSlotClick(itemKey)
  if nil ~= itemSlot then
    if nil ~= itemSlot.item and not itemSlot.item.cooltime:GetShow() then
      audioPostEvent_SystemUi(8, 2)
      _AudioPostEvent_SystemUiForXBOX(8, 2)
      itemSlot.item.icon:AddEffect("fUI_SkillButton01", false, 0, 0)
      itemSlot.item.icon:AddEffect("UI_SkillButton01", false, 0, 0)
    end
    if nil ~= itemSlot.skill and not itemSlot.skill.cooltime:GetShow() then
      audioPostEvent_SystemUi(8, 2)
      _AudioPostEvent_SystemUiForXBOX(8, 2)
      itemSlot.skill.icon:AddEffect("fUI_SkillButton01", false, 0, 0)
      itemSlot.skill.icon:AddEffect("UI_SkillButton01", false, 0, 0)
      local skillStaticWrapper = getSkillTypeStaticStatus(itemSlot.skill.skillNo)
      if skillStaticWrapper:getUiDisplayType() then
        SpiritGuide_Show()
      end
    end
  end
  if not QuickSlot_DropHandler(slotIndex) then
    if true == _ContentsGroup_UISkillGroupTreeLayOut and true == Panel_Window_SkillGroup_Controller:GetShow() then
      if nil ~= itemSlot.skill then
        PaGlobalFunc_SkillGroup_SkillAction(itemSlot.skill.skillNo)
      end
    elseif nil ~= itemSlot.item then
      local quickSlotInfo = getQuickSlotItem(slotIndex)
      local whereType = QuickSlot_GetInventoryTypeFrom(quickSlotInfo._type)
      if isNearFusionCore() and isFusionItem(whereType, itemSlot.keyValue) then
        burnItemToActor(whereType, itemSlot.keyValue, 1)
        return
      end
      local whereType = QuickSlot_GetInventoryTypeFrom(quickSlotInfo._type)
      local inventory = getSelfPlayer():get():getInventoryByType(whereType)
      local invenSlotNo = inventory:getSlot(quickSlotInfo._itemKey)
      if invenSlotNo >= inventory:sizeXXX() then
        return
      end
      local itemWrapper = getInventoryItemByType(whereType, invenSlotNo)
      local itemEnchantWrapper = itemWrapper:getStaticStatus()
      if 2 == itemEnchantWrapper:get()._vestedType:getItemKey() and false == itemWrapper:get():isVested() then
        local function bindingItemUse()
          quickSlot_UseSlot(slotIndex)
        end
        local messageContent
        if itemEnchantWrapper:isUserVested() then
          messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT_USERVESTED")
        else
          messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT")
        end
        local messageboxData = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_TITLE"),
          content = messageContent,
          functionYes = bindingItemUse,
          functionNo = MessageBox_Empty_function,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageboxData)
      elseif true == _ContentsGroup_HopeGauge and true == itemEnchantWrapper:get():isItemCollectionScroll() then
        PaGlobalFunc_HopeGaugeOnOff_ItemCollectionScrollUse(whereType, invenSlotNo, itemEnchantWrapper:getGradeType())
      elseif itemEnchantWrapper:isPopupItem() then
        PaGlobal_UseItem_All_PopupItem(itemEnchantWrapper, whereType, invenSlotNo)
      elseif eConnectUiType.eConnectUi_Undefined ~= itemWrapper:getStaticStatus():getConnectUi() then
        ConnectUI(itemWrapper:getStaticStatus():getConnectUi(), itemWrapper:get():getKey():getItemKey())
      else
        quickSlot_UseSlot(slotIndex)
      end
    else
      quickSlot_UseSlot(slotIndex)
    end
  end
end
function SpiritGuide_Show()
  local isShow = FGlobal_SpiritGuide_IsShow()
  if false == isShow then
    return
  end
  Panel_MovieTheater320_ShowToggle()
end
function QuickSlot_DragStart(slotIndex)
  local currentUIMode = GetUIMode()
  if currentUIMode == Defines.UIMode.eUIMode_Sequence or currentUIMode == Defines.UIMode.eUIMode_SequencePlayerControl then
    return
  end
  local self = quickSlot
  local quickSlotInfo = getQuickSlotItem(slotIndex)
  if true == PaGlobal_TutorialManager:isDoingTutorial() and 502 == quickSlotInfo._itemKey:get() and 0 == slotIndex then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
    return
  end
  if isItemSlot(quickSlotInfo._type) then
    local itemStaticWrapper = getItemEnchantStaticStatus(quickSlotInfo._itemKey)
    DragManager:setDragInfo(Panel_QuickSlot, nil, slotIndex, "Icon/" .. itemStaticWrapper:getIconPath(), QuickSlot_GroundClick, nil)
  elseif isSkillSlot(quickSlotInfo._type) then
    local skillTypeStaticWrapper = getSkillTypeStaticStatus(quickSlotInfo._skillKey:getSkillNo())
    DragManager:setDragInfo(Panel_QuickSlot, nil, slotIndex, "Icon/" .. skillTypeStaticWrapper:getIconPath(), QuickSlot_GroundClick, nil)
  elseif isSocialActionSlot(quickSlotInfo._type) then
    local socialActionKeyFromCpp = quickSlotInfo._socialActionKey:get()
    local sASS = ToClient_getSocialActionStaticStatusByKey(socialActionKeyFromCpp)
    if nil == sASS then
      _PA_ASSERT_NAME(false, "socialActionInfo\236\157\152 StaticStatus\235\165\188 \234\176\128\236\160\184\236\152\164\235\138\148\235\141\176 \236\139\164\237\140\168\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164.", "\236\160\149\236\152\129\236\164\128")
      return
    end
    local iconPath = sASS:getIconPath()
    if nil ~= iconPath then
      iconPath = "Icon/" .. iconPath
    end
    DragManager:setDragInfo(Panel_QuickSlot, nil, slotIndex, iconPath, QuickSlot_GroundClick, nil)
  end
end
function QuickSlot_OnceUpdateByGameOption()
  local self = quickSlot
  if not self.quickSlotInit then
    return
  end
  QuickSlot_UpdateData()
  FGlobal_NewQuickSlot_Update()
end
local onEffectTime = 0
function QuickSlot_UpdatePerFrame(fDeltaTime)
  if fDeltaTime <= 0 then
    return
  end
  if false == FGlobal_QuickSlot_CheckDefaultQuickSlotShowAble() then
    PaGlobalFunc_QuickSlot_SetShow(false, false)
    return
  end
  onEffectTime = onEffectTime + fDeltaTime
  local self = quickSlot
  if not self.quickSlotInit then
    return
  end
  for idx, slot in ipairs(self.slots) do
    local quickSlotKey = idx - 1
    local quickSlotInfo = getQuickSlotItem(quickSlotKey)
    if true == PaGlobal_TutorialManager:isDoingTutorial() and false == PaGlobal_TutorialManager:isCheckHpPotionSetting() and 1 == idx and 517 ~= quickSlotInfo._itemKey:getItemKey() then
      if true == _ContentsGroup_NewUI_Inventory_All then
        PaGlobalFunc_Inventory_All_SetCheckNormalInventory(true)
      else
        Inventory_SetCheckRadioButtonNormalInventory(true)
      end
      Inventory_updateSlotData()
      PaGlobal_TutorialManager:setHpPotion()
    end
    if nil == quickSlotInfo then
      return
    end
    if isItemSlot(quickSlotInfo._type) then
      if nil == slot.item then
        break
      end
      local remainTime = 0
      local itemReuseTime = 0
      local realRemainTime = 0
      local intRemainTime = 0
      local whereType = QuickSlot_GetInventoryTypeFrom(quickSlotInfo._type)
      if __eTInventorySlotNoUndefined ~= slot.keyValue then
        remainTime = getItemCooltime(whereType, slot.keyValue)
        itemReuseTime = getItemReuseCycle(whereType, slot.keyValue)
        realRemainTime = remainTime * itemReuseTime
        intRemainTime = realRemainTime - realRemainTime % 1 + 1
      end
      if isNearFusionCore() and isFusionItem(whereType, slot.keyValue) and onEffectTime > 3 then
        slot.item.icon:EraseAllEffect()
        slot.item.icon:AddEffect("UI_ItemInstall_Gold", false, 0, 0)
      end
      if remainTime > 0 then
        slot.item.cooltime:UpdateCoolTime(remainTime)
        slot.item.cooltime:SetShow(true)
        slot.item.cooltimeText:SetText(Time_Formatting_ShowTop(intRemainTime))
        if itemReuseTime >= intRemainTime then
          slot.item.cooltimeText:SetShow(true)
        else
          slot.item.cooltimeText:SetShow(false)
        end
      elseif slot.item.cooltime:GetShow() then
        slot.item.cooltime:SetShow(false)
        slot.item.cooltimeText:SetShow(false)
        local skillSlotItemPosX = slot.item.cooltime:GetParentPosX()
        local skillSlotItemPosY = slot.item.cooltime:GetParentPosY()
        Panel_CoolTime_Effect_Item_Slot:SetShow(true, true)
        Panel_CoolTime_Effect_Item_Slot:SetIgnore(true)
        Panel_CoolTime_Effect_Item_Slot:AddEffect("fUI_Skill_Cooltime01", false, 2.5, 7)
        Panel_CoolTime_Effect_Item_Slot:SetPosX(skillSlotItemPosX - 7)
        Panel_CoolTime_Effect_Item_Slot:SetPosY(skillSlotItemPosY - 10)
      end
      PaGlobal_TutorialManager:handleUpdateQuickSlotPerFrame(slot, quickSlotInfo._itemKey:getItemKey())
    elseif isSkillSlot(quickSlotInfo._type) then
      if nil == slot.skill then
        break
      end
      local skillStaticWrapper = getSkillStaticStatus(quickSlotInfo._skillKey:getSkillNo(), quickSlotInfo._skillKey:getLevel())
      local isLearned = ToClient_isLearnedSkill(quickSlotInfo._skillKey:getSkillNo())
      if nil ~= skillStaticWrapper then
        if skillStaticWrapper:isUsableSkill() and true == isLearned then
          slot.skill.icon:SetMonoTone(false)
        else
          slot.skill.icon:SetMonoTone(true)
        end
        slot.toggle:SetShow(false)
        if isToggleSkillbySkillKey(quickSlotInfo._skillKey:get()) then
          if checkToggleSkillState(quickSlotInfo._skillKey:get()) then
            slot.toggle:SetShow(true)
          else
            slot.toggle:SetShow(false)
          end
        end
      end
      local remainTime = getSkillCooltime(slot.keyValue:get())
      local skillReuseTime = skillStaticWrapper:get()._reuseCycle / 1000
      local realRemainTime = remainTime * skillReuseTime
      local intRemainTime = realRemainTime - realRemainTime % 1 + 1
      if remainTime > 0 then
        slot.skill.cooltime:UpdateCoolTime(remainTime)
        slot.skill.cooltime:SetShow(true)
        slot.skill.cooltimeText:SetText(Time_Formatting_ShowTop(intRemainTime))
        if skillReuseTime >= intRemainTime then
          slot.skill.cooltimeText:SetShow(true)
        else
          slot.skill.cooltimeText:SetShow(false)
        end
      elseif slot.skill.cooltime:GetShow() then
        slot.skill.cooltime:SetShow(false)
        slot.skill.cooltimeText:SetShow(false)
        local skillSlotPosX = slot.skill.cooltime:GetParentPosX()
        local skillSlotPosY = slot.skill.cooltime:GetParentPosY()
        Panel_CoolTime_Effect_Slot:SetShow(true, true)
        Panel_CoolTime_Effect_Slot:SetIgnore(true)
        Panel_CoolTime_Effect_Slot:AddEffect("fUI_Skill_Cooltime01", false, 2.5, 7)
        Panel_CoolTime_Effect_Slot:SetPosX(skillSlotPosX - 7)
        Panel_CoolTime_Effect_Slot:SetPosY(skillSlotPosY - 8)
      end
    end
  end
  if onEffectTime > 3 then
    onEffectTime = 0
  end
end
function quickSlot:registEventHandler()
  Panel_QuickSlot:RegisterUpdateFunc("QuickSlot_UpdatePerFrame")
end
function quickSlot:updateMemo()
  if _ContentsGroup_QuickSlotMemo == false then
    return
  end
  for idx = 1, self.config.slotCount do
    local slotMemo = ToClient_GetSlotMemoData(idx - 1)
    local filteringMemo = ToClient_FilteringMemoText(slotMemo)
    if filteringMemo ~= nil then
      self.slots[idx].memo:SetEditText(filteringMemo)
    end
  end
end
function FGlobal_Potion_InvenToQuickSlot(inventoryType, slotNo, itemType)
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if nil ~= itemWrapper and (itemWrapper:getStaticStatus():get():isItemSkill() or itemWrapper:getStaticStatus():get():isUseToVehicle()) then
    if itemType == 0 then
      if isUseNewQuickSlot() then
        local hasPotion = FGlobal_NewQuickSlot_CheckAndSetPotion(slotNo, itemType)
        if hasPotion then
          return
        end
      else
        for index = quickSlot.config.slotCount - 1, 0, -1 do
          local quickSlotInfo = getQuickSlotItem(index)
          local quickType = quickSlotInfo._type
          if isItemSlot(quickType) then
            local itemKey = quickSlotInfo._itemKey:get()
            if 502 == itemKey or 513 == itemKey or 514 == itemKey or 517 == itemKey or 518 == itemKey or 519 == itemKey or 524 == itemKey or 525 == itemKey or 528 == itemKey or 529 == itemKey or 530 == itemKey or 538 == itemKey or 551 == itemKey or 552 == itemKey or 553 == itemKey or 554 == itemKey or 555 == itemKey or 17568 == itemKey or 17569 == itemKey or 17679 == itemKey or 17681 == itemKey or 17682 == itemKey or 17683 == itemKey or 17684 == itemKey or 19932 == itemKey or 19933 == itemKey or 19934 == itemKey or 19935 == itemKey then
              return
            end
          end
        end
        if PaGlobal_TutorialManager:isDoingTutorial() then
          HP_Push_NextSlot(0)
          quickSlot_RegistItem(0, 0, slotNo)
        else
          local emptySlotIndex = EmptySlot_Check()
          if nil ~= emptySlotIndex then
            quickSlot_RegistItem(emptySlotIndex, 0, slotNo)
          end
        end
      end
    elseif itemType == 1 then
      if isUseNewQuickSlot() then
        local hasPotion = FGlobal_NewQuickSlot_CheckAndSetPotion(slotNo, itemType)
        if not hasPotion then
          return
        end
      else
        for index = quickSlot.config.slotCount - 1, 0, -1 do
          local quickSlotInfo = getQuickSlotItem(index)
          local quickType = quickSlotInfo._type
          if isItemSlot(quickType) then
            local itemKey = quickSlotInfo._itemKey:get()
            if 503 == itemKey or 520 == itemKey or 521 == itemKey or 522 == itemKey or 526 == itemKey or 527 == itemKey or 515 == itemKey or 516 == itemKey or 531 == itemKey or 532 == itemKey or 533 == itemKey then
              return
            end
          end
        end
        local emptySlotIndex = EmptySlot_Check()
        if nil ~= emptySlotIndex then
          quickSlot_RegistItem(emptySlotIndex, 0, slotNo)
        end
      end
    end
  end
  if isUseNewQuickSlot() then
    FGlobal_NewQuickSlot_Update()
  else
    QuickSlot_UpdateData()
  end
end
function EmptySlot_Check()
  local emptySlot
  for index = quickSlot.config.slotCount - 1, 0, -1 do
    local quickSlotInfo = getQuickSlotItem(index)
    if __eQuickSlotDataType_Empty == quickSlotInfo._type then
      emptySlot = index
    end
  end
  return emptySlot
end
function HP_Push_NextSlot(slotNo)
  local quickSlotInfo = getQuickSlotItem(slotNo)
  if __eQuickSlotDataType_Empty == quickSlotInfo._type then
    return
  end
  if quickSlot.config.slotCount - 1 == slotNo then
    return
  end
  local quickSlotInfo2 = getQuickSlotItem(slotNo + 1)
  if __eQuickSlotDataType_Empty == quickSlotInfo2._type then
    quickSlot_Swap(slotNo, slotNo + 1)
    if 0 == slotNo then
      return
    end
    HP_Push_NextSlot(slotNo - 1)
  else
    HP_Push_NextSlot(slotNo + 1)
  end
end
function MP_Push_NextSlot(slotNo)
  local quickSlotInfo = getQuickSlotItem(slotNo)
  if __eQuickSlotDataType_Empty == quickSlotInfo._type then
    return
  end
  if quickSlot.config.slotCount - 1 == slotNo then
    return
  end
  local quickSlotInfo2 = getQuickSlotItem(slotNo + 1)
  if __eQuickSlotDataType_Empty == quickSlotInfo2._type then
    quickSlot_Swap(slotNo, slotNo + 1)
    if 1 == slotNo then
      return
    end
    MP_Push_NextSlot(slotNo - 1)
  else
    MP_Push_NextSlot(slotNo + 1)
  end
end
function FGlobal_QuickSlot_CheckDefaultQuickSlotShowAble()
  if true == isUseNewQuickSlot() then
    return false
  elseif false == _ContentsGroup_Tutorial_Renewal and false == PaGlobal_TutorialManager:isAllowShowQuickSlot() then
    return false
  end
  return true
end
function QuickSlot_UpdateData()
  if true == _ContentsGroup_UsePadSnapping then
    Panel_QuickSlot:SetRenderAndEventHide(true)
    return
  else
    Panel_QuickSlot:SetRenderAndEventHide(false)
  end
  if true == quickSlot.isRemoteInstallMode then
    Panel_QuickSlot:SetRenderAndEventHide(true)
  end
  if false == FGlobal_QuickSlot_CheckDefaultQuickSlotShowAble() then
    PaGlobalFunc_QuickSlot_SetShow(false, false)
    return
  end
  local relativePosX = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_QuickSlot, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
  local relativePosY = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_QuickSlot, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
  if relativePosX == -1 and relativePosY == -1 then
    local initPosX = (getScreenSizeX() - Panel_QuickSlot:GetSizeX()) / 2
    local initPosY = getScreenSizeY() - Panel_QuickSlot:GetSizeY()
    changePositionBySever(Panel_QuickSlot, CppEnums.PAGameUIType.PAGameUIPanel_QuickSlot, false, true, false)
    FGlobal_InitPanelRelativePos(Panel_QuickSlot, initPosX, initPosY)
  elseif relativePosX == 0 and relativePosY == 0 then
    Panel_QuickSlot:SetPosX((getScreenSizeX() - Panel_QuickSlot:GetSizeX()) / 2)
    Panel_QuickSlot:SetPosY(getScreenSizeY() - Panel_QuickSlot:GetSizeY())
  else
    Panel_QuickSlot:SetRelativePosX(relativePosX)
    Panel_QuickSlot:SetRelativePosY(relativePosY)
    Panel_QuickSlot:SetPosX(getScreenSizeX() * relativePosX - Panel_QuickSlot:GetSizeX() / 2)
    Panel_QuickSlot:SetPosY(getScreenSizeY() * relativePosY - Panel_QuickSlot:GetSizeY() / 2)
  end
  if not Panel_QuickSlot:GetShow() then
    PaGlobalFunc_QuickSlot_SetShow(true, true)
  end
  local self = quickSlot
  for idx, slot in ipairs(self.slots) do
    local quickSlotKey = idx - 1
    local quickSlotInfo = getQuickSlotItem(quickSlotKey)
    if isItemSlot(quickSlotInfo._type) then
      slot:setItem(quickSlotKey, quickSlotInfo)
      if nil ~= slot.icon then
        slot.icon:SetEnable(true)
      end
    elseif isSkillSlot(quickSlotInfo._type) then
      slot:setSkill(quickSlotKey, quickSlotInfo)
      if nil ~= slot.icon then
        slot.icon:SetEnable(true)
      end
    elseif isSocialActionSlot(quickSlotInfo._type) then
      slot:setSocialAction(quickSlotKey, quickSlotInfo)
      if nil ~= slot.socialAction then
        slot.socialAction:SetEnable(true)
      end
    else
      slot:setEmpty()
      if nil ~= slot.icon then
        slot.icon:SetEnable(false)
      end
    end
  end
  if "QuickSlot" == Panel_Tooltip_Item_GetCurrentSlotType() then
    Panel_Tooltip_Item_Refresh()
  end
  if "QuickSlot" == Panel_SkillTooltip_GetCurrentSlotType() then
    Panel_SkillTooltip_Refresh()
  end
  self.quickSlotInit = true
  if true == _ContentsGroup_UISkillGroupTreeLayOut then
    PaGlobal_SkillGroup_QuickSlot:update()
  end
end
function quickSlot:registMessageHandler()
  registerEvent("refreshQuickSlot_ack", "QuickSlot_UpdateData")
  registerEvent("FromClient_InventoryUpdate", "QuickSlot_UpdateData")
  registerEvent("QuickSlotUpdateAfterToCleanupDialog", "QuickSlot_UpdateAfter_cleanupDialog")
  registerEvent("FromClient_StartSequencePlayerControlable", "FromClient_StartSequencePlayerControlable_QuickSlot")
end
function FromClient_StartSequencePlayerControlable_QuickSlot()
  Panel_QuickSlot:SetAlpha(0)
  local aniInfo = UIAni.AlphaAnimation(1, Panel_QuickSlot, 0, 0.8)
  aniInfo:SetDisableWhileAni(true)
end
local closeNpcTalkDialog = function()
  if nil ~= Panel_Dialog_Trade_Function_All and true == Panel_Dialog_Trade_Function_All:GetShow() then
    HandleEventLUp_TradePriceRate_All_Close()
    HandleEventLUp_TradeFunction_All_Close()
    return true
  end
  if nil ~= Panel_Dialog_Repair_Function_All and true == Panel_Dialog_Repair_Function_All:GetShow() then
    if true == _ContentsGroup_NewUI_Equipment_All then
      PaGlobalFunc_Equipment_All_SetShow(false)
    else
      FGlobal_Equipment_SetHide(false)
    end
    return true
  end
  if true == Panel_Dialog_ServantFunction_All:GetShow() and nil ~= Panel_Dialog_ServantFunction_All then
    PaGlobalFunc_ServantFunction_All_Close()
    return true
  end
  if Panel_Window_ItemMarket_Function:GetShow() then
    FGolbal_ItemMarket_Function_Close()
    return true
  end
  return false
end
function QuickSlot_UpdateAfter_cleanupDialog()
  if nil == dialog_getTalker() then
    return
  end
  if Panel_QuickSlot:IsUse() and nil ~= Panel_Npc_Dialog_All and true == Panel_Npc_Dialog_All:GetShow() then
    PaGlobalFunc_DialogMain_All_Close()
  end
end
Panel_QuickSlot:addInputEvent("Mouse_On", "QuickSlot_ChangeTexture_On()")
Panel_QuickSlot:addInputEvent("Mouse_Out", "QuickSlot_ChangeTexture_Off()")
Panel_QuickSlot:addInputEvent("Mouse_LUp", "ResetPos_WidgetButton()")
function QuickSlot_ChangeTexture_On()
  if Panel_UIControl:IsShow() then
    Panel_QuickSlot:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/window_sample_drag.dds")
    quickSlotText:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_QUICKSLOT_QUICKSLOT") .. "-" .. PAGetString(Defines.StringSheet_GAME, "PANEL_QUICKSLOT_MOVE_DRAG"))
  end
end
function QuickSlot_ChangeTexture_Off()
  if Panel_UIControl:IsShow() then
    Panel_QuickSlot:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/window_sample_isWidget.dds")
    quickSlotText:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_QUICKSLOT_QUICKSLOT"))
  else
    Panel_QuickSlot:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/window_sample_empty.dds")
  end
end
function Panel_QuickSlot_ShowToggle()
  if getSelfPlayer():get():getLevel() < 4 then
    return
  end
  if isUseNewQuickSlot() then
    return
  end
  local isShow = Panel_QuickSlot:IsShow()
  if isShow then
    PaGlobalFunc_QuickSlot_SetShow(false, false)
  else
    PaGlobalFunc_QuickSlot_SetShow(true, true)
  end
end
function FGlobal_QuickSlot_Show()
  if false == FGlobal_QuickSlot_CheckDefaultQuickSlotShowAble() then
    return
  end
  PaGlobalFunc_QuickSlot_SetShow(true, true)
  local itemSlot = quickSlot.slots[1]
  if nil ~= itemSlot then
    if nil ~= itemSlot.item then
      itemSlot.item.icon:AddEffect("fUI_Tuto_Skill_01A", false, 250, 0)
    end
    if nil ~= itemSlot.skill then
      itemSlot.skill.icon:AddEffect("fUI_Tuto_Skill_01A", false, 250, 0)
    end
  end
end
function QuickSlot_ShowBackGround()
  local self = quickSlot
  for idx, slot in ipairs(self.slots) do
    slot.background:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/BlackPanel_Series.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(slot.background, 5, 5, 50, 50)
    slot.background:getBaseTexture():setUV(x1, y1, x2, y2)
    slot.background:setRenderTexture(slot.background:getBaseTexture())
    slot.background:SetAlpha(0.7)
  end
end
function QuickSlot_ShowBackGroundToggle(isShow, index)
  local self = quickSlot
  if true == isShow then
    self.slots[index].background:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/BlackPanel_Series.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self.slots[index].background, 5, 5, 50, 50)
    self.slots[index].background:getBaseTexture():setUV(x1, y1, x2, y2)
    self.slots[index].background:setRenderTexture(self.slots[index].background:getBaseTexture())
    self.slots[index].background:SetAlpha(0.7)
  else
    QuickSlot_HideBackGround()
  end
end
function QuickSlot_HideBackGround()
  local self = quickSlot
  for idx, slot in ipairs(self.slots) do
    slot.background:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/BlackPanel_Series.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(slot.background, 200, 200, 230, 230)
    slot.background:getBaseTexture():setUV(x1, y1, x2, y2)
    slot.background:setRenderTexture(slot.background:getBaseTexture())
  end
end
function QuickSlot_Empty()
  local self = quickSlot
  for idx, slot in ipairs(self.slots) do
    if __eQuickSlotDataType_Empty == slot.slotType then
      slot.background:ChangeOnTextureInfoNameAsync("New_UI_Common_forLua/Default/BlackPanel_Series.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(slot.background, 70, 130, 120, 180)
      slot.background:getOnTexture():setUV(x1, y1, x2, y2)
      slot.background:setRenderTexture(slot.background:getBaseTexture())
      slot.background:SetAlpha(0.5)
    end
  end
end
local halfScreenSize = getScreenSizeX() / 2 - Panel_QuickSlot:GetPosX()
local potionAlert = true
local potionPosInit = false
local potionRefill = false
local potion_bubble = UI.getChildControl(Panel_QuickSlot, "StaticText_Bubble")
local potion_bubble2 = UI.getChildControl(Panel_QuickSlot, "StaticText_Bubble2")
potion_bubble:SetShow(false)
potion_bubble2:SetShow(false)
potion_bubble2:SetPosX(-85)
potion_bubble2:SetPosY(-50)
potion_bubble:SetPosY(-50)
function NoPotion_Alert()
  local invenSize = getSelfPlayer():get():getInventory():size() - 1
  Potion_Info_Init()
  for index = 1, invenSize do
    local itemWrapper = getInventoryItem(index)
    if nil ~= itemWrapper then
      local itemKey = itemWrapper:get():getKey():getItemKey()
      if true == PaGlobal_Quickslot_IsPostion(itemKey) then
        potionAlert = true
        if false == potionPosInit then
          potion_bubble2:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_QUICKSLOT_ADD_POTION"))
          Potion_Bubble_Show(false)
        elseif true == potionRefill then
          return
        else
          potion_bubble:SetShow(false)
          potion_bubble2:SetShow(false)
        end
        return
      end
    end
  end
  potion_bubble:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_QUICKSLOT_HAVENT_POTION"))
  potion_bubble2:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_QUICKSLOT_HAVENT_POTION"))
  Potion_Pos_Init()
  potionAlert = false
end
function PaGlobal_Quickslot_IsPostion(itemKey)
  local postionList = {
    502,
    513,
    514,
    517,
    518,
    519,
    524,
    525,
    528,
    529,
    530,
    538,
    551,
    552,
    553,
    554,
    555,
    17568,
    17569,
    17679,
    17681,
    17682,
    17683,
    17684,
    19932,
    19933,
    19934,
    19935
  }
  for _, v in pairs(postionList) do
    if v == itemKey then
      return true
    end
  end
  return false
end
local bubbleChange = false
local bubble2Change = false
function Potion_Info_Init()
  potionPosInit = false
  potionRefill = false
  for index = quickSlot.config.slotCount - 1, 0, -1 do
    local quickType = getQuickSlotItem(index)._type
    if isItemSlot(quickType) then
      local quickSlotInfo = getQuickSlotItem(index)
      local invenSlotNo = getSelfPlayer():get():getInventory():getSlot(quickSlotInfo._itemKey)
      local itemStaticWrapper = getItemEnchantStaticStatus(quickSlotInfo._itemKey)
      local itemKey = quickSlotInfo._itemKey:getItemKey()
      if true == PaGlobal_Quickslot_IsPostion(itemKey) then
        potionPosInit = true
        if 255 == invenSlotNo then
          Potion_Alert(index)
          potionRefill = true
        end
      end
    end
  end
  if false == potionRefill then
    potion_bubble:SetShow(false)
    potion_bubble2:SetShow(false)
  end
  if false == potionPosInit then
    potion_bubble2:SetPosX(-85)
    Potion_Bubble_Show(false)
  end
end
function Potion_Pos_Init()
  if 30 < potion_bubble2:GetTextSizeY() then
    potion_bubble2:SetSize(potion_bubble2:GetTextSizeX() + 10, potion_bubble2:GetTextSizeY() + 28)
    potion_bubble2:SetPosX(potion_bubble2:GetPosX() - (potion_bubble2:GetTextSizeX() - 160))
    if not bubble2Change then
      potion_bubble2:SetPosY(potion_bubble2:GetPosY() - (potion_bubble2:GetTextSizeY() - 26))
    end
    bubble2Change = true
  else
    potion_bubble2:SetSize(potion_bubble2:GetTextSizeX() + 10, 55)
  end
  if 30 < potion_bubble:GetTextSizeY() then
    potion_bubble:SetSize(potion_bubble:GetTextSizeX() + 10, potion_bubble:GetTextSizeY() + 28)
    potion_bubble:SetPosX(potion_bubble:GetPosX() - (potion_bubble:GetTextSizeX() - 160))
    if not bubbleChange then
      potion_bubble:SetPosY(potion_bubble:GetPosY() - (potion_bubble:GetTextSizeY() - 26))
    end
    bubbleChange = true
  else
    potion_bubble:SetSize(potion_bubble:GetTextSizeX() + 10, 55)
  end
end
function Potion_Alert(slotNo)
  local quickSlotInfo = getQuickSlotItem(slotNo)
  local invenSlotNo = getSelfPlayer():get():getInventory():getSlot(quickSlotInfo._itemKey)
  local itemStaticWrapper = getItemEnchantStaticStatus(quickSlotInfo._itemKey)
  local itemName = itemStaticWrapper:getName()
  local hp_potion = string.sub(itemName, 1, 2)
  potion_bubble:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_QUICKSLOT_HAVENT_POTION_2", "itemName", itemName))
  potion_bubble2:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_QUICKSLOT_HAVENT_POTION_2", "itemName", itemName))
  Potion_Bubble_Locate(slotNo)
  if false == potionAlert then
    return
  end
end
function Potion_Bubble_Locate(slotNo)
  local posX = slotNo * 55 + 10
  if posX < halfScreenSize then
    potion_bubble2:SetPosX(posX - 95)
    Potion_Bubble_Show(false)
  else
    potion_bubble:SetPosX(posX)
    Potion_Bubble_Show(true)
  end
end
function Potion_Bubble_Show(bool)
  if true == bool then
    potion_bubble:SetShow(true)
    potion_bubble2:SetShow(false)
  else
    potion_bubble:SetShow(false)
    potion_bubble2:SetShow(true)
  end
end
function Time_Formatting_ShowTop(second)
  if second > 3600 then
    local recalc_time = second / 3600
    local strHour = string.format("%d", Int64toInt32(recalc_time))
    return PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_HOUR", "time_hour", strHour)
  elseif second > 60 then
    local recalc_time = second / 60
    local strMinute = string.format("%d", Int64toInt32(recalc_time))
    return PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_MINUTE", "time_minute", strMinute)
  else
    local recalc_time = second
    local strSecond = string.format("%d", Int64toInt32(recalc_time))
    return PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_SECOND", "time_second", strSecond)
  end
end
function QuickSlot_GetInventoryTypeFrom(quickType)
  if __eQuickSlotDataType_Item == quickType then
    return CppEnums.ItemWhereType.eInventory
  elseif __eQuickSlotDataType_InstanceItem == quickType then
    return CppEnums.ItemWhereType.eInstanceInventory
  elseif true == _ContentsGroup_FamilyInventory and __eQuickSlotDataType_FamilyItem == quickType then
    return CppEnums.ItemWhereType.eFamilyInventory
  end
  return CppEnums.ItemWhereType.eCashInventory
end
function QuickSlot_OnscreenResize()
  if Panel_QuickSlot:GetRelativePosX() == -1 and Panel_QuickSlot:GetRelativePosY() == -1 then
    local initPosX = (getScreenSizeX() - Panel_QuickSlot:GetSizeX()) / 2
    local initPosY = getScreenSizeY() - Panel_QuickSlot:GetSizeY()
    Panel_QuickSlot:SetPosX((getScreenSizeX() - Panel_QuickSlot:GetSizeX()) / 2)
    Panel_QuickSlot:SetPosY(getScreenSizeY() - Panel_QuickSlot:GetSizeY())
    changePositionBySever(Panel_QuickSlot, CppEnums.PAGameUIType.PAGameUIPanel_QuickSlot, false, true, false)
    FGlobal_InitPanelRelativePos(Panel_QuickSlot, initPosX, initPosY)
  elseif Panel_QuickSlot:GetRelativePosX() == 0 and Panel_QuickSlot:GetRelativePosY() == 0 then
    Panel_QuickSlot:SetPosX((getScreenSizeX() - Panel_QuickSlot:GetSizeX()) / 2)
    Panel_QuickSlot:SetPosY(getScreenSizeY() - Panel_QuickSlot:GetSizeY())
  else
    Panel_QuickSlot:SetPosX(getScreenSizeX() * Panel_QuickSlot:GetRelativePosX() - Panel_QuickSlot:GetSizeX() / 2)
    Panel_QuickSlot:SetPosY(getScreenSizeY() * Panel_QuickSlot:GetRelativePosY() - Panel_QuickSlot:GetSizeY() / 2)
  end
  FGlobal_PanelRepostionbyScreenOut(Panel_QuickSlot)
end
function FromClient_QuickSlot_DecreaseSkillCooltime(skillNo)
  for idx, slot in ipairs(quickSlot.slots) do
    local quickSlotKey = idx - 1
    local quickSlotInfo = getQuickSlotItem(quickSlotKey)
    if nil ~= quickSlotInfo then
      local slotSkillNo = quickSlotInfo._skillKey:getSkillNo()
      if skillNo == slotSkillNo and nil ~= slot and nil ~= slot.skill and nil ~= slot.skill.cooltimeText then
        slot.skill.cooltimeText:EraseAllEffect()
        slot.skill.cooltimeText:AddEffect("fUI_SkillCoolTime_01A", false, 0, 0)
        break
      end
    end
  end
end
function FromClient_QuickSlot_DecreaseAllSkillCooltime(exceptSkillNo)
  for idx, slot in ipairs(quickSlot.slots) do
    local quickSlotKey = idx - 1
    local quickSlotInfo = getQuickSlotItem(quickSlotKey)
    if nil ~= quickSlotInfo and exceptSkillNo ~= quickSlotInfo._skillKey:getSkillNo() and nil ~= slot and nil ~= slot.skill and true == slot.skill.cooltime:GetShow() and nil ~= slot.skill.cooltimeText then
      local skillStaticWrapper = getSkillStaticStatus(quickSlotInfo._skillKey:getSkillNo(), quickSlotInfo._skillKey:getLevel())
      if nil ~= skillStaticWrapper and false == skillStaticWrapper:isExceptCoolTime() and EmergencySkillKey ~= skillStaticWrapper:getKey() then
        slot.skill.cooltimeText:EraseAllEffect()
        slot.skill.cooltimeText:AddEffect("fUI_SkillCoolTime_01A", false, 0, 0)
      end
    end
  end
end
registerEvent("onScreenResize", "QuickSlot_OnscreenResize")
registerEvent("FromClient_ApplyUISettingPanelInfo", "QuickSlot_OnscreenResize")
registerEvent("FromClient_DecreaseSkillCooltime", "FromClient_QuickSlot_DecreaseSkillCooltime")
registerEvent("FromClient_DecreaseAllSkillCooltime", "FromClient_QuickSlot_DecreaseAllSkillCooltime")
function HandleOnOut_QuickSlot_ItemTooltip(slotNo, slotType, isShow)
  Panel_Tooltip_Item_Show_GeneralNormal(slotNo, slotType, isShow)
  HandleOnOut_QuickSlot_ShowMemoBG(isShow, slotNo + 1)
end
function HandleOnOut_QuickSlot_SkillTooltip(slotNo, slotType, isShow)
  if isShow == true then
    Panel_SkillTooltip_Show(slotNo, isShow, slotType)
  else
    Panel_SkillTooltip_Hide()
  end
  HandleOnOut_QuickSlot_ShowMemoBG(isShow, slotNo + 1)
end
function HandleOnOut_QuickSlot_SocialActionTooltip(slotNo, slotType, isShow)
  local quickSlotInfo = getQuickSlotItem(slotNo)
  if nil == quickSlotInfo then
    return
  end
  if true == isShow then
    local socialActionKeyFromCpp = quickSlotInfo._socialActionKey:get()
    Show_Condition_SocialIcon(nil, isShow, slotType, slotNo, socialActionKeyFromCpp)
  else
    Show_Condition_SocialIcon()
  end
  HandleOnOut_QuickSlot_ShowMemoBG(isShow, slotNo + 1)
end
function HandleOnOut_QuickSlot_ShowMemoBG(isShow, slotNo)
  if _ContentsGroup_QuickSlotMemo == false then
    return
  end
  local slot = quickSlot.slots[slotNo]
  if slot == nil then
    return
  end
  local memoBG = slot.memoBG
  if memoBG == nil then
    return
  end
  local pencil = slot.pencil
  if pencil == nil then
    return
  end
  if isShow == false then
    memoBG:SetShow(false)
    pencil:SetShow(false)
    return
  end
  local memo = slot.memo:GetEditText()
  if memo ~= "" then
    return
  end
  if slot.memo:GetFocusEdit() == true then
    return
  end
  memoBG:SetShow(isShow)
  pencil:SetShow(isShow)
end
function PaGlobalFunc_QuickSlot_Swap(toSlotIndex, fromSlotIndex)
  quickSlot_Swap(fromSlotIndex, toSlotIndex)
  local fromSlot = quickSlot.slots[fromSlotIndex + 1]
  local toSlot = quickSlot.slots[toSlotIndex + 1]
  if fromSlot == nil or toSlot == nil then
    return
  end
  local fromSlotMemo = fromSlot.memo
  local toSlotMemo = toSlot.memo
  if fromSlotMemo == nil or toSlotMemo == nil then
    return
  end
  fromSlotMemo:SetEditText(ToClient_GetSlotMemoData(fromSlotIndex))
  toSlotMemo:SetEditText(ToClient_GetSlotMemoData(toSlotIndex))
  fromSlot.memoBG:SetShow(false)
  toSlot.memoBG:SetShow(false)
  fromSlot.pencil:SetShow(false)
  toSlot.pencil:SetShow(false)
  if PaGlobalFunc_NewQuickSlot_PostSwap ~= nil then
    PaGlobalFunc_NewQuickSlot_PostSwap(toSlotIndex, fromSlotIndex)
  end
end
function PaGlobalFunc_QuickSlot_PostSwap(toSlotIndex, fromSlotIndex)
  local fromSlot = quickSlot.slots[fromSlotIndex + 1]
  local toSlot = quickSlot.slots[toSlotIndex + 1]
  if fromSlot ~= nil then
    local fromSlotMemo = fromSlot.memo
    if fromSlotMemo ~= nil then
      fromSlotMemo:SetEditText(ToClient_GetSlotMemoData(fromSlotIndex))
    end
  end
  if toSlot ~= nil then
    local toSlotMemo = toSlot.memo
    if toSlotMemo ~= nil then
      toSlotMemo:SetEditText(ToClient_GetSlotMemoData(toSlotIndex))
    end
  end
end
function QuickSlot_SaveMemoInNormalQuickSlot(slotNo)
  if _ContentsGroup_QuickSlotMemo == false then
    return
  end
  local slotIdx = slotNo - 1
  local slotMemo = quickSlot.slots[slotNo].memo:GetEditText()
  ClearFocusEdit()
  local filteringMemo = ToClient_FilteringMemoText(slotMemo)
  if filteringMemo == nil then
    quickSlot.slots[slotNo].memo:SetEditText("")
    return
  end
  quickSlot.slots[slotNo].memo:SetEditText(filteringMemo)
  ToClient_SaveSlotMemoData(slotIdx, filteringMemo)
end
function renderModeChange_QuickSlot_OnscreenResize(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  QuickSlot_OnscreenResize()
end
function PaGlobalFunc_QuickSlot_SetShow(isShow, isAni)
  if false == _ContentsGroup_RenewUI then
    Panel_QuickSlot:SetShow(isShow, isAni)
  else
    Panel_QuickSlot:SetShow(false, false)
  end
end
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_QuickSlot")
function FromClient_luaLoadComplete_QuickSlot()
  quickSlot:init()
  quickSlot:createSlot()
  quickSlot:registEventHandler()
  quickSlot:registMessageHandler()
  quickSlot:updateMemo()
  if not isUseNewQuickSlot() then
    changePositionBySever(Panel_QuickSlot, CppEnums.PAGameUIType.PAGameUIPanel_QuickSlot, false, true, false)
  end
  registerEvent("FromClient_RenderModeChangeState", "renderModeChange_QuickSlot_OnscreenResize")
end
