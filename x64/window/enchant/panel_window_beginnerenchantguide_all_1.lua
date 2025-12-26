function PaGlobal_BeginnerEnchantGuide_All:initialize()
  if PaGlobal_BeginnerEnchantGuide_All._initialize == true then
    return
  end
  self._ui._stc_TitleBar = UI.getChildControl(Panel_Window_BeginnerEnchantGuide_All, "Static_TitleBar")
  self._ui._txt_TitleIcon = UI.getChildControl(self._ui._stc_TitleBar, "StaticText_TitleIcon")
  self._ui._stc_CloseIcon = UI.getChildControl(self._ui._stc_TitleBar, "Static_CloseIcon")
  self._ui._stc_QuestionIcon = UI.getChildControl(self._ui._stc_TitleBar, "Static_Question")
  self._ui._stc_ImageBox = UI.getChildControl(Panel_Window_BeginnerEnchantGuide_All, "Static_ImageBox")
  self._ui._stc_Image_1 = UI.getChildControl(self._ui._stc_ImageBox, "Static_Image_1")
  self._ui._stc_Image_2 = UI.getChildControl(self._ui._stc_ImageBox, "Static_Image_2")
  self._ui._stc_Image_3 = UI.getChildControl(self._ui._stc_ImageBox, "Static_Image_3")
  self._ui._stc_Image_4 = UI.getChildControl(self._ui._stc_ImageBox, "Static_Image_4")
  self._ui._stc_Image_5 = UI.getChildControl(self._ui._stc_ImageBox, "Static_Image_5")
  self._ui._stc_Image_6 = UI.getChildControl(self._ui._stc_ImageBox, "Static_Image_6")
  self._ui._txt_1 = UI.getChildControl(self._ui._stc_Image_6, "StaticText_1")
  self._ui._txt_2 = UI.getChildControl(self._ui._stc_Image_6, "StaticText_2")
  self._ui._txt_3 = UI.getChildControl(self._ui._stc_Image_6, "StaticText_3")
  self._ui._btn_Left = UI.getChildControl(self._ui._stc_ImageBox, "Button_Left")
  self._ui._btn_Right = UI.getChildControl(self._ui._stc_ImageBox, "Button_Right")
  if _ContentsGroup_UsePadSnapping == true then
    self._ui._txt_KeyGuide_LB_ConsoleUI = UI.getChildControl(self._ui._btn_Left, "Static_KeyGuide_LB_ConsoleUI")
    self._ui._txt_KeyGuide_RB_ConsoleUI = UI.getChildControl(self._ui._btn_Right, "Static_KeyGuide_RB_ConsoleUI")
  end
  self._ui._stc_DescBox = UI.getChildControl(Panel_Window_BeginnerEnchantGuide_All, "Static_DescBox")
  self._ui._txt_Title = UI.getChildControl(self._ui._stc_DescBox, "StaticText_Title")
  self._ui._multxt_Desc = UI.getChildControl(self._ui._stc_DescBox, "MultilineText_Desc")
  self._ui._stc_TitleDeco = UI.getChildControl(self._ui._stc_DescBox, "Static_TitleDeco")
  self._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_BEGINNERENCHANTGUIDE_TITLE_1"))
  self._ui._multxt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_BEGINNERENCHANTGUIDE_DESC_1"))
  self._ui._stc_PageBar = UI.getChildControl(Panel_Window_BeginnerEnchantGuide_All, "Static_PageBar")
  self._ui._stc_Dot_1 = UI.getChildControl(self._ui._stc_PageBar, "Static_Dot_1")
  self._ui._stc_Dot_2 = UI.getChildControl(self._ui._stc_PageBar, "Static_Dot_2")
  self._ui._stc_Dot_3 = UI.getChildControl(self._ui._stc_PageBar, "Static_Dot_3")
  self._ui._stc_Dot_4 = UI.getChildControl(self._ui._stc_PageBar, "Static_Dot_4")
  self._ui._stc_Dot_5 = UI.getChildControl(self._ui._stc_PageBar, "Static_Dot_5")
  self._ui._stc_Dot_6 = UI.getChildControl(self._ui._stc_PageBar, "Static_Dot_6")
  PaGlobal_BeginnerEnchantGuide_All:registEventHandler()
  PaGlobal_BeginnerEnchantGuide_All:validate()
  PaGlobal_BeginnerEnchantGuide_All._initialize = true
end
function PaGlobal_BeginnerEnchantGuide_All:registEventHandler()
  if Panel_Window_BeginnerEnchantGuide_All == nil then
    return
  end
  self._ui._stc_CloseIcon:addInputEvent("Mouse_LUp", "PaGlobal_BeginnerEnchantGuide_All:close()")
  self._ui._stc_QuestionIcon:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"SpecUpGuide\" )")
  if _ContentsGroup_UsePadSnapping == true then
    Panel_Window_BeginnerEnchantGuide_All:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "HandleEventLUp_PaGlobal_BeginnerEnchantGuide_All_ChangePage(" .. tostring(self._DIR._LEFT) .. ")")
    Panel_Window_BeginnerEnchantGuide_All:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "HandleEventLUp_PaGlobal_BeginnerEnchantGuide_All_ChangePage(" .. tostring(self._DIR._RIGHT) .. ")")
  end
  self._ui._stc_Image_1:addInputEvent("Mouse_UpScroll", "HandleEventLUp_PaGlobal_BeginnerEnchantGuide_All_ChangePage(" .. tostring(self._DIR._LEFT) .. ")")
  self._ui._stc_Image_1:addInputEvent("Mouse_DownScroll", "HandleEventLUp_PaGlobal_BeginnerEnchantGuide_All_ChangePage(" .. tostring(self._DIR._RIGHT) .. ")")
  self._ui._stc_Image_2:addInputEvent("Mouse_UpScroll", "HandleEventLUp_PaGlobal_BeginnerEnchantGuide_All_ChangePage(" .. tostring(self._DIR._LEFT) .. ")")
  self._ui._stc_Image_2:addInputEvent("Mouse_DownScroll", "HandleEventLUp_PaGlobal_BeginnerEnchantGuide_All_ChangePage(" .. tostring(self._DIR._RIGHT) .. ")")
  self._ui._stc_Image_3:addInputEvent("Mouse_UpScroll", "HandleEventLUp_PaGlobal_BeginnerEnchantGuide_All_ChangePage(" .. tostring(self._DIR._LEFT) .. ")")
  self._ui._stc_Image_3:addInputEvent("Mouse_DownScroll", "HandleEventLUp_PaGlobal_BeginnerEnchantGuide_All_ChangePage(" .. tostring(self._DIR._RIGHT) .. ")")
  self._ui._stc_Image_4:addInputEvent("Mouse_UpScroll", "HandleEventLUp_PaGlobal_BeginnerEnchantGuide_All_ChangePage(" .. tostring(self._DIR._LEFT) .. ")")
  self._ui._stc_Image_4:addInputEvent("Mouse_DownScroll", "HandleEventLUp_PaGlobal_BeginnerEnchantGuide_All_ChangePage(" .. tostring(self._DIR._RIGHT) .. ")")
  self._ui._stc_Image_5:addInputEvent("Mouse_UpScroll", "HandleEventLUp_PaGlobal_BeginnerEnchantGuide_All_ChangePage(" .. tostring(self._DIR._LEFT) .. ")")
  self._ui._stc_Image_5:addInputEvent("Mouse_DownScroll", "HandleEventLUp_PaGlobal_BeginnerEnchantGuide_All_ChangePage(" .. tostring(self._DIR._RIGHT) .. ")")
  self._ui._stc_Image_6:addInputEvent("Mouse_UpScroll", "HandleEventLUp_PaGlobal_BeginnerEnchantGuide_All_ChangePage(" .. tostring(self._DIR._LEFT) .. ")")
  self._ui._stc_Image_6:addInputEvent("Mouse_DownScroll", "HandleEventLUp_PaGlobal_BeginnerEnchantGuide_All_ChangePage(" .. tostring(self._DIR._RIGHT) .. ")")
  self._ui._btn_Left:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_BeginnerEnchantGuide_All_ChangePage(" .. tostring(self._DIR._LEFT) .. ")")
  self._ui._btn_Right:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_BeginnerEnchantGuide_All_ChangePage(" .. tostring(self._DIR._RIGHT) .. ")")
end
function PaGlobal_BeginnerEnchantGuide_All:prepareOpen()
  if Panel_Window_BeginnerEnchantGuide_All == nil then
    return
  end
  self._ui._stc_TitleBar:SetShow(true)
  self._ui._txt_TitleIcon:SetShow(true)
  self._ui._stc_CloseIcon:SetShow(true)
  self._ui._stc_ImageBox:SetShow(true)
  if _ContentsGroup_UsePadSnapping == true then
    self._ui._txt_KeyGuide_LB_ConsoleUI:SetShow(true)
    self._ui._txt_KeyGuide_RB_ConsoleUI:SetShow(true)
  end
  self._ui._stc_Image_1:SetShow(true)
  self._ui._stc_Image_2:SetShow(false)
  self._ui._stc_Image_3:SetShow(false)
  self._ui._stc_Image_4:SetShow(false)
  self._ui._stc_Image_5:SetShow(false)
  self._ui._stc_Image_6:SetShow(false)
  self._ui._txt_1:SetShow(true)
  self._ui._txt_2:SetShow(true)
  self._ui._txt_3:SetShow(true)
  self._ui._btn_Left:SetShow(true)
  self._ui._btn_Right:SetShow(true)
  self._ui._stc_DescBox:SetShow(true)
  self._ui._txt_Title:SetShow(true)
  self._ui._multxt_Desc:SetShow(true)
  self._ui._stc_TitleDeco:SetShow(true)
  self._ui._stc_PageBar:SetShow(true)
  self._ui._stc_Dot_1:SetShow(true)
  self._ui._stc_Dot_2:SetShow(false)
  self._ui._stc_Dot_3:SetShow(false)
  self._ui._stc_Dot_4:SetShow(false)
  self._ui._stc_Dot_5:SetShow(false)
  self._ui._stc_Dot_6:SetShow(false)
  self._curPageNum = 1
  self._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_BEGINNERENCHANTGUIDE_TITLE_1"))
  self._ui._multxt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_BEGINNERENCHANTGUIDE_DESC_1"))
  if Panel_Window_DeadMessage_All ~= nil then
    if Panel_Window_DeadMessage_All:GetShow() == true then
      self._ui._txt_TitleIcon:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DEADMESSAGE_BTN_STRONGER"))
      Panel_Window_BeginnerEnchantGuide_All:SetDragEnable(false)
    else
      self._ui._txt_TitleIcon:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BEGINNER_ENCHANTGUITE_TITLE"))
      Panel_Window_BeginnerEnchantGuide_All:SetDragEnable(true)
    end
  end
  PaGlobal_BeginnerEnchantGuide_All:open()
end
function PaGlobal_BeginnerEnchantGuide_All:open()
  if Panel_Window_BeginnerEnchantGuide_All == nil then
    return
  end
  Panel_Window_BeginnerEnchantGuide_All:SetShow(true)
end
function PaGlobal_BeginnerEnchantGuide_All:prepareClose()
  if Panel_Window_BeginnerEnchantGuide_All == nil then
    return
  end
  PaGlobal_BeginnerEnchantGuide_All:close()
end
function PaGlobal_BeginnerEnchantGuide_All:close()
  if Panel_Window_BeginnerEnchantGuide_All == nil then
    return
  end
  Panel_Window_BeginnerEnchantGuide_All:SetShow(false)
end
function PaGlobal_BeginnerEnchantGuide_All:update()
  if Panel_Window_BeginnerEnchantGuide_All == nil then
    return
  end
end
function PaGlobal_BeginnerEnchantGuide_All:validate()
  if Panel_Window_BeginnerEnchantGuide_All == nil then
    return
  end
  self._ui._stc_TitleBar:isValidate()
  self._ui._txt_TitleIcon:isValidate()
  self._ui._stc_CloseIcon:isValidate()
  self._ui._stc_ImageBox:isValidate()
  if _ContentsGroup_UsePadSnapping == true then
    self._ui._txt_KeyGuide_LB_ConsoleUI:isValidate()
    self._ui._txt_KeyGuide_RB_ConsoleUI:isValidate()
  end
  self._ui._stc_Image_1:isValidate()
  self._ui._stc_Image_2:isValidate()
  self._ui._stc_Image_3:isValidate()
  self._ui._stc_Image_4:isValidate()
  self._ui._stc_Image_5:isValidate()
  self._ui._stc_Image_6:isValidate()
  self._ui._txt_1:isValidate()
  self._ui._txt_2:isValidate()
  self._ui._txt_3:isValidate()
  self._ui._btn_Left:isValidate()
  self._ui._btn_Right:isValidate()
  self._ui._stc_DescBox:isValidate()
  self._ui._txt_Title:isValidate()
  self._ui._multxt_Desc:isValidate()
  self._ui._stc_TitleDeco:isValidate()
  self._ui._stc_PageBar:isValidate()
  self._ui._stc_Dot_1:isValidate()
  self._ui._stc_Dot_2:isValidate()
  self._ui._stc_Dot_3:isValidate()
  self._ui._stc_Dot_4:isValidate()
  self._ui._stc_Dot_5:isValidate()
  self._ui._stc_Dot_6:isValidate()
end
