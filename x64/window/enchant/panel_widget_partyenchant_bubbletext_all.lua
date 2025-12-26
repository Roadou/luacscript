PaGlobal_BubbleText = {
  _stc_To = nil,
  _stc_TextTo = nil,
  _bubbleTextShowTime = 6,
  _bubbleTextDeltaTime = 0,
  _isShowBubbleText = true,
  _stcToSizeX = 0,
  _stcToSizeY = 0,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_PartyEnchantBubbleText_Init")
function FromClient_PartyEnchantBubbleText_Init()
  PaGlobal_BubbleText:initialize()
end
function PaGlobal_BubbleText:initialize()
  if true == PaGlobal_BubbleText._initialize or nil == Panel_Widget_PartyEnchant_BubbleText_All then
    return
  end
  self._stc_To = UI.getChildControl(Panel_Widget_PartyEnchant_BubbleText_All, "Static_To")
  self._stc_TextTo = UI.getChildControl(self._stc_To, "StaticText_To")
  self._stcToSizeX = self._stc_To:GetSizeX()
  self._stcToSizeY = self._stc_To:GetSizeY()
  self._stc_To:ComputePosAllChild()
  self._stc_To:SetShow(false)
  self._stc_TextTo:SetShow(false)
  PaGlobal_BubbleText:registEventHandler()
  PaGlobal_BubbleText._initialize = true
end
function PaGlobal_BubbleText:registEventHandler()
  Panel_Widget_PartyEnchant_BubbleText_All:RegisterUpdateFunc("PaGlobalFunc_PartyEnchantBubbleText_Update")
end
function PaGlobal_BubbleText:SetShowBubbleText(isShow)
  self._stc_To:SetShow(isShow)
  self._stc_TextTo:SetShow(isShow)
  Panel_Widget_PartyEnchant_BubbleText_All:SetShow(isShow)
  if false == isShow then
    self._stc_TextTo:SetText("")
  else
    self._stc_To:ResetVertexAni()
    self._stc_To:SetVertexAniRun("Ani_Move_Pos_New", true)
    self._stc_To:SetVertexAniRun("Ani_Scale_New", true)
  end
end
function PaGlobal_BubbleText:SetBubbleText(text)
  UI.ASSERT_NAME(nil ~= text, "bubbleText\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\236\181\156\237\149\156\236\167\132")
  self._stc_TextTo:SetTextMode(__eTextMode_AutoWrap)
  self._stc_TextTo:SetText(text)
  self._stc_To:SetSize(self._stcToSizeX, self._stcToSizeY)
  if self._stc_TextTo:GetTextSizeX() > self._stc_To:GetSizeX() then
    self._stc_To:SetSize(self._stc_TextTo:GetTextSizeX() + 20, self._stc_To:GetSizeY())
  end
  if self._stc_TextTo:GetTextSizeY() > self._stc_To:GetSizeY() then
    self._stc_To:SetSize(self._stc_To:GetSizeX(), self._stc_TextTo:GetTextSizeY() + 20)
  end
  self._stc_To:ComputePosAllChild()
  self._bubbleTextDeltaTime = 0
  self._isShowBubbleText = true
end
function PaGlobalFunc_PartyEnchantBubbleText_Update(deltaTime)
  if _ContentsGroup_SpiritGroupEnchant == false then
    return
  end
  if Panel_Window_StackExtraction_All:GetShow() == false then
    return
  end
  local self = PaGlobal_BubbleText
  self:updateAutoBubbleText(deltaTime)
end
function PaGlobal_BubbleText:updateAutoBubbleText(deltaTime)
  if true == self._isShowBubbleText then
    self._bubbleTextDeltaTime = self._bubbleTextDeltaTime + deltaTime
    if self._bubbleTextShowTime < self._bubbleTextDeltaTime then
      self:SetShowBubbleText(self, false)
      self._isShowBubbleText = false
      self._bubbleTextDeltaTime = 0
    end
  end
end
