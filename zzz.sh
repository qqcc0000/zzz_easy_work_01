#!/bin/sh
#version 	Descriptioni 	zzz 		Description
# 0.1 		2020-04-15	qiancheng	add cod & root
# 0.2 		2020-04-28	qiancheng	add cafl


# ============================================================================
function root() {
  echo "============================"
  echo "root device"
  echo "============================"
  adb wait-for-device
  adb shell setprop service.adb.root 1 
  adb wait-for-device
  adb root
  adb wait-for-device
  adb shell setenforce 0 
  adb remount
  adb shell getenforce
  #for fastboot flash new image
  adb disable-verity
}

# ============================================================================
# camera otp/eeprom dump
# another way
# adb shell mkdir vendor/etc/camera
# adb shell "echo reprocessDump=TRUE >> /vendor/etc/camera/camxoverridesettings.txt"
# adb shell "echo autoImageDump=TRUE >> /vendor/etc/camera/camxoverridesettings.txt"
# adb shell "echo autoImageDumpMask=0x07 >> /vendor/etc/camera/camxoverridesettings.txt"
# adb shell "echo logVerboseMask=0x50082 >> /vendor/etc/camera/camxoverridesettings.txt"
# adb shell "echo logInfoMask=0x50082 >> /vendor/etc/camera/camxoverridesettings.txt"
# adb shell "echo overrideLogLevels=31 >> /vendor/etc/camera/camxoverridesettings.txt"
# adb shell "echo logVerboseMask=0x50082 >> /vendor/etc/camera/camxoverridesettings.txt"
# adb shell "echo logInfoMask=0x50082 >> /vendor/etc/camera/camxoverridesettings.txt"
# adb shell "echo overrideLogLevels=31 >> /vendor/etc/camera/camxoverridesettings.txt"
# adb shell "echo logVerboseMask=0x50082 >> /vendor/etc/camera/camxoverridesettings.txt"
# adb shell "echo logInfoMask=0x50082 >> /vendor/etc/camera/camxoverridesettings.txt"
# adb shell "echo overrideLogLevels=31 >> /vendor/etc/camera/camxoverridesettings.txt"
# adb pull /data/vendor/camera .
function camera_otp_dump() {
  echo "============================"
  echo "camera otp/eeprom dump "
  echo "============================"
  adb shell setprop vendor.debug.camera.dumpSensorEEPROMData 1
  adb shell setprop persist.vendor.camera.cal.dump 1
  adb shell setprop persist.camera.cal.dump 1
  echo "vendor.debug.camera.dumpSensorEEPROMData:"
  adb shell getprop vendor.debug.camera.dumpSensorEEPROMData
  echo "persist.vendor.camera.cal.dump:"
  adb shell getprop persist.vendor.camera.cal.dump
  echo "persist.camera.cal.dump:"
  adb shell getprop persist.camera.cal.dump

  echo "dump 文件在 data/vendor/camera/ 或者 /data/misc/camera/"
}

# ============================================================================
function camera_af_log() {
  echo "============================"
  echo "open camera af logs"
  echo "============================"
  adb shell mkdir vendor/etc/camera
  adb shell "echo logVerboseMask=0x08000000 >> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo logEntryExitMask=0x08000000 >> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo logInfoMask=0x08000000 >> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "cat /vendor/etc/camera/camxoverridesettings.txt"
  echo "please reboot"
}

# ============================================================================
function camera_af_fullsweep() {
  echo "============================"
  echo "camera af fullsweep enable"
  echo "============================"
  adb shell mkdir vendor/etc/camera
  #1st way
  adb shell "echo afFullsweep=1 >> /vendor/etc/camera/camxoverridesettings.txt" 
  #AF+AE+sensordebug
  adb shell "echo logVerboseMask= 0x0A000002>> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo logEntryExitMask= 0x0A000002>> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo logInfoMask= 0x0A000002>> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "cat /vendor/etc/camera/camxoverridesettings.txt"
  
  #2nd way
  adb shell setprop vendor.debug.camera.af.fullsweep 1
  adb shell getprop vendor.debug.camera.af.fullsweep
  echo "please reboot"
}

# ============================================================================
function camera_qcfa() {
  echo "============================"
  echo "camera qcfa enable"
  echo "============================"
  adb shell mkdir vendor/etc/camera
  # There is an example for enable ZSL + QCFA :
  adb shell " echo advanceFeatureMask=0x21 >> /vendor/etc/camera/camxoverridesettings.txt "
  adb shell " echo exposeFullSizeForQCFA=TRUE >> /vendor/etc/camera/camxoverridesettings.txt "
  adb shell " echo useFeatureForQCFA=1 >> /vendor/etc/camera/camxoverridesettings.txt "
  # After verifying the feature , disable this propriety:
  #adb shell " echo exposeFullSizeForQCFA=FALSE >> /vendor/etc/camera/camxoverridesettings.txt "
  
  adb shell "cat /vendor/etc/camera/camxoverridesettings.txt"
  
  echo ""
  echo "please reboot"
}

# ============================================================================
function camera_raw() {
  echo "============================"
  echo "camera raw dump"
  echo "============================"
  adb shell mkdir vendor/etc/camera
  adb shell "echo reprocessDump=TRUE >> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo autoImageDump=TRUE >> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo autoImageDumpMask=0x07 >> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo logVerboseMask=0x50082 >> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo logInfoMask=0x50082 >> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo overrideLogLevels=31 >> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo logVerboseMask=0x50082 >> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo logInfoMask=0x50082 >> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo overrideLogLevels=31 >> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo logVerboseMask=0x50082 >> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo logInfoMask=0x50082 >> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo overrideLogLevels=31 >> /vendor/etc/camera/camxoverridesettings.txt"

  echo ""
  echo "please reboot"
}

# ============================================================================
function script_info() {
  echo "============================"
  echo "script info"
  echo "============================"
  #path=`pwd`
  echo $(dirname $(readlink -f ${BASH_SOURCE[0]}))
  path=$(dirname $(readlink -f ${BASH_SOURCE[0]}))"/zzz.sh"
  echo $path
  cat $path | grep "adb shell"
}


# ============================================================================
function camera_logs() {
  echo "============================"
  echo "camera logs"
  echo "============================"
  adb shell mkdir vendor/etc/camera
  adb shell "echo logVerboseMask= 0x02000002>> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo logEntryExitMask= 0x02000002>> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo logInfoMask= 0x02000002>> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo logWarningMask= 0x02000002>> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "echo logPerfInfoMask= 0x02000002>> /vendor/etc/camera/camxoverridesettings.txt"
  adb shell "cat /vendor/etc/camera/camxoverridesettings.txt"

}

echo -e "\033[32m
zzz script for easy work
Version 0.2 by Simcom for Qcom Android
\033[0m"

EEE='echo -e \033[32m'
OOO='\033[0m'
function usage() {
  $EEE===============================================================$OOO
  $EEE# Easy specific $OOO
  $EEE# -------------------------------------------------------------$OOO
  $EEE# \"cod\" 	- camera otp/eeprom dump $OOO
  $EEE# \"cafl\" 	- open camera af log $OOO
  $EEE# \"caff\" 	- open camera af fullsweep $OOO
  $EEE# \"cqc\" 	- open camera QCFA enable $OOO
  $EEE# \"cr\" 		- open camera raw dump $OOO
  $EEE# \"cl\" 		- open camera logs $OOO
  $EEE# \"si\"   	- open script info $OOO
  $EEE# \"root\" 	- root$OOO
  $EEE# $OOO
  $EEE===============================================================$OOO
  sleep 1
}

echo ""
echo "See more press \"Enter\" key"
echo "Please input command"
read level1
case $level1 in
  cod)
    camera_otp_dump
    ;;
  cafl)
    camera_af_log
    ;;
  caff)
    camera_af_fullsweep
    ;;
  cqc)
    camera_qcfa
    ;;
  cr)
    camera_raw
    ;;
  cl)
    camera_logs
    ;;
  si)
    script_info
    ;;
  root)
    root
    ;;
  *)
    usage
    ;;
esac


