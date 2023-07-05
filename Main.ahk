#SingleInstance Force

#Include Voicemeeter.ahk
#Include VolumeOverlay.ahk

VoicemeeterInstance := Voicemeeter()
VolumeOverlayInstance := VolumeOverlay()

VolumeOverlayStrip := 1
VolumeOverlayTimeout := 2000

VolumeUp()
{
    ; Send "{Volume_Up}"

    gain := VoicemeeterInstance.GetStripGain(VolumeOverlayStrip) + 1
    VoicemeeterInstance.SetStripGain(VolumeOverlayStrip, gain)
    VolumeOverlayInstance.SetValue(gain)
    VolumeOverlayInstance.Play(VolumeOverlayTimeout)
}

VolumeDown()
{
    ; Send "{Volume_Down}"

    gain := VoicemeeterInstance.GetStripGain(VolumeOverlayStrip) - 1
    VoicemeeterInstance.SetStripGain(VolumeOverlayStrip, gain)
    VolumeOverlayInstance.SetValue(gain)
    VolumeOverlayInstance.Play(VolumeOverlayTimeout)
}

Mute()
{
    ; Send "{Volume_Mute}"

    value := VoicemeeterInstance.GetStripMute(VolumeOverlayStrip) ? 0 : 1 ; Toggle
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


RCtrl & Up::VolumeUp
RCtrl & Down::VolumeDown
RCtrl & m::Mute

RCtrl & Space::Send	"{Media_Play_Pause}"
RCtrl & Left::Send	"{Media_Prev}"
RCtrl & Right::Send	"{Media_Next}"


#HotIf WinActive("Apex Legends")
LWin::Send ""
#HotIf

CapsLock::Esc
