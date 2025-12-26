function PaGlobal_ScreenShotSNS_Open(productNoRaw)
  PaGlobal_ScreenShot_SNS:prepareOpen(productNoRaw)
end
function PaGlobal_ScreenShotSNS_Close()
  PaGlobal_ScreenShot_SNS:prepareClose()
end
function FromClient_OpenWebAlbumUI()
  InGameShop_Close()
  PaGlobal_ScreenShotSNS_Close()
  ScreenshotAlbum_CustumeOpen()
end
