#SingleInstance Force

#Include Voicemeeter.ahk
#Include VolumeOverlay.ahk

VoicemeeterInstance := Voicemeeter()
VolumeOverlayInstance := VolumeOverlay()

VolumeOverlayStrip := 1
VolumeOverlayTimeout := 2000

GainMod(aValue)
{
    gain := VoicemeeterInstance.GetStripGain(VolumeOverlayStrip)
    gain := VoicemeeterInstance.ParamGain(gain + aValue)

    VoicemeeterInstance.SetStripGain(VolumeOverlayStrip, gain)

    VolumeOverlayInstance.SetValue(gain)
    VolumeOverlayInstance.Play(VolumeOverlayTimeout)
}

ToggleMute()
{
    value := VoicemeeterInstance.GetStripMute(VolumeOverlayStrip)
    value := value ? 0 : 1 ; Toggle

    VoicemeeterInstance.SetStripMute(VolumeOverlayStrip, value)

    if value
        VolumeOverlayInstance.SetValue("Mute")
    else
    {
        gain := VoicemeeterInstance.GetStripGain(VolumeOverlayStrip)
        VolumeOverlayInstance.SetValue(gain)
    }
    
    VolumeOverlayInstance.Play(VolumeOverlayTimeout)
}


RCtrl & Up::GainMod(5)
RCtrl & Down::GainMod(-5)
RCtrl & m::ToggleMute()

RCtrl & Space::Send	"{Media_Play_Pause}"
RCtrl & Left::Send	"{Media_Prev}"
RCtrl & Right::Send	"{Media_Next}"


#HotIf WinActive("Apex Legends")
LWin::Send ""
#HotIf

#HotIf WinActive("ahk_exe WindowsTerminal.exe") or WinActive("ahk_exe Code.exe")
CapsLock::Esc
Esc::CapsLock
#HotIf
