*** Settings ***
Library           AppiumLibrary

*** Keywords ***
打开应用
    #Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=华为    automationName=Uiautomator1    appPackage=cn.butel.redmeeting    appActivity=cn.butel.redmeeting.boot.SplashActivity    unicodeKeyboard=true    resetKeyboard=true    app=D:/ftp/redmeeting.apk    udid=192.168.1.100:5005    newCommandTimeout=600    noReset=true
    #Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=华为    automationName=UiAutomator1    appPackage=cn.butel.redmeeting    appActivity=cn.butel.redmeeting.boot.SplashActivity    noReset=true    resetKeyboard=false    unicodeKeyboard=false    skipServerInstallation=true    skipDeviceInitialization=true    udid=10.134.101.190:5000    newCommandTimeout=600
    #Devices_huawei9A
    #Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=华为9A    automationName=UiAutomator1    appPackage=cn.butel.redmeeting    appActivity=cn.butel.redmeeting.boot.SplashActivity    noReset=true    resetKeyboard=false    unicodeKeyboard=false    skipServerInstallation=true    skipDeviceInitialization=true    udid=10.134.101.184:5001    newCommandTimeout=600
    Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=华为    automationName=Uiautomator1    appPackage=cn.butel.redmeeting    appActivity=cn.butel.redmeeting.boot.SplashActivity    unicodeKeyboard=true    resetKeyboard=true    app=D:/ftp/redmeeting.apk    udid=10.134.101.169:5000    newCommandTimeout=600    noReset=true
