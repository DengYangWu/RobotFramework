*** Settings ***
Suite Setup       打开应用
Library           AppiumLibrary
Resource          调用.robot

*** Variables ***
${video_id}       40000048    # 视讯号(用于我的设备用例)
${Encrypt_meeting}    30218183    #加密会议
${Lock_meeting}    10210740    #加锁会议
${Long_meeting}    20218419
${userid}         18914791123
${passwd}         Test2021

*** Test Cases ***
预约会议
    sleep    8
    click element    id=cn.butel.redmeeting:id/order_metting_ly    #点击预约会议
    clear text    id=cn.butel.redmeeting:id/reserve_title_Ed
    input text    id=cn.butel.redmeeting:id/reserve_title_Ed    测试会议
    click element    id=cn.butel.redmeeting:id/encryption_Switch    #开启会议加密
    click element    id=cn.butel.redmeeting:id/title_right_tv    #点击完成
    ${head_page}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/head_iv
    ${appointmentMeeting}    Get Matching Xpath Count    xpath=//android.widget.LinearLayout[@resource-id='cn.butel.redmeeting:id/meeting_info_ly']
    Run Keyword If    ${head_page}==True and ${appointmentMeeting}>0    log    进入主页面,并且预约会议成功
    ...    ELSE    log    预约会议失败

加入预约会议
    sleep    8
    click element    id=cn.butel.redmeeting:id/order_metting_ly    #点击预约会议
    clear text    id=cn.butel.redmeeting:id/reserve_title_Ed
    input text    id=cn.butel.redmeeting:id/reserve_title_Ed    测试预约会议，再加入预约会议
    click element    id=cn.butel.redmeeting:id/encryption_Switch    #开启会议加密
    ${meetingName}    Get Text    xpath=//*[@resource-id='cn.butel.redmeeting:id/reserve_title_Ed']
    should contain    ${meetingName}    测试预约会议，再加入预约会议
    log    没有预约会议成功~~
    ${meetingName_save}    Set variable    ${meetingName}
    click element    id=cn.butel.redmeeting:id/title_right_tv    #点击完成
    ${head_page}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/head_iv
    ${appointmentMeeting}    Get Matching Xpath Count    xpath=//android.widget.LinearLayout[@resource-id='cn.butel.redmeeting:id/meeting_info_ly']
    Run Keyword If    ${head_page}==True and ${appointmentMeeting}>0    log    进入主页面,并且预约会议成功
    ...    ELSE    log    预约会议失败
    sleep    2
    Swipe    500    1800    400    500    200
    Swipe    500    1800    400    500    200
    sleep    8
    Run Keyword If    $meetingName=='测试预约会议，再加入预约会议'    run keywords    log    预约会议成功
    ...    AND    click element    xpath=//*[@text='测试预约会议，再加入预约会议']
    ...    AND    click element    id=cn.butel.redmeeting:id/comein_meeting_ly
    ...    AND    sleep    8
    ...    AND    click A Point    500    400    100
    ...    AND    sleep    2
    ...    AND    click element    id=cn.butel.redmeeting:id/header_tool_view_back_tv
    ...    AND    log    加入预约会议成功
    ...    AND    click element    id=cn.butel.redmeeting:id/tv_close_meeting
    ...    AND    log    退出预约会议成功
    ...    ELSE    Fail    没有找到该会议，预约会议失败

修改头像
    sleep    8
    click element    id=cn.butel.redmeeting:id/head_iv    #点击头像
    click element    id=cn.butel.redmeeting:id/gotomyfilecard_rl    #点击名称
    click element    id=cn.butel.redmeeting:id/image_rl    #点击头像
    click element    id=cn.butel.redmeeting:id/carema_rl    #点击拍照    # ${huaweiCamera}    Run Keyword And Return Status    Wait Until Page Contains Element    id=com.huawei.camera:id/shutter_button    # Run Keyword If    ${huaweiCamera}==False    log    手机未设置允许访问照片权限，或手机不是华为手机，暂不支持上传头像    #...    # ELSE    log    进入华为快门
    click element    id=com.huawei.camera:id/shutter_button    #点击快门
    sleep    3
    click element    id=com.huawei.camera:id/done_button    #点击勾选
    #click element    id=cn.butel.redmeeting:id/photo_rl    #从相册选择
    #click element    id=android:id/title    #点击图片
    click element    id=cn.butel.redmeeting:id/right_btn    #点击完成
    sleep    5
    click element    id=cn.butel.redmeeting:id/back_btn
    click element    id=cn.butel.redmeeting:id/back_btn

修改昵称
    sleep    8
    click element    id=cn.butel.redmeeting:id/head_iv    #点击头像
    click element    id=cn.butel.redmeeting:id/gotomyfilecard_rl    #点击名称
    click element    id=cn.butel.redmeeting:id/name_rl    #点击修改名字
    input text    id=cn.butel.redmeeting:id/change_name_ed    ABC    #修改名称
    click A Point    500    400    100    #点击坐标（500,400）    #收起软键盘
    click element    id=cn.butel.redmeeting:id/save_btn    #点击保存
    sleep    3
    Wait Until Element Is Visible    xpath=//*[@resource-id='cn.butel.redmeeting:id/my_name']    30    #等待用户昵称出现
    ${text}    Get Text    xpath=//*[@resource-id='cn.butel.redmeeting:id/my_name']    #获取用户昵称
    #Should Be Equal As Strings    ${text}    ABC    #检查用户昵称是否正确
    Run Keyword If    $text=='ABC'    log    修改昵称正常！
    ...    ELSE    Fail    修改昵称失败！
    sleep    5
    click element    id=cn.butel.redmeeting:id/back_btn
    click element    id=cn.butel.redmeeting:id/back_btn

修改密码
    sleep    8
    Back_homepage
    click element    id=cn.butel.redmeeting:id/head_iv    #点击头像
    click element    id=cn.butel.redmeeting:id/modify_password_rl    #点击修改密码
    input text    id=cn.butel.redmeeting:id/get_pwd_ed    Test2021    #输入当前密码
    input text    id=cn.butel.redmeeting:id/reset_pwd_ed    Test2022    #输入重置密码
    click element    id=cn.butel.redmeeting:id/change_pwd_accomplish_btn    #点击完成
    sleep    3
    Wait Until Element Is Visible    xpath=//*[@resource-id='cn.butel.redmeeting:id/login_title']    30    #等待回到登录页面
    input text    id=cn.butel.redmeeting:id/login_pwd_ed    Test2022    #输入新密码
    click element    id=cn.butel.redmeeting:id/check_rember_img    #点击记住密码
    click element    id=cn.butel.redmeeting:id/login_btn    #点击登录按钮
    sleep    3
    Wait Until Element Is Visible    xpath=//*[@resource-id='cn.butel.redmeeting:id/nube_tv']    30    #等待头像
    click element    id=cn.butel.redmeeting:id/head_iv    #点击头像
    click element    id=cn.butel.redmeeting:id/modify_password_rl    #点击修改密码
    input text    id=cn.butel.redmeeting:id/get_pwd_ed    Test2022    #输入当前密码
    input text    id=cn.butel.redmeeting:id/reset_pwd_ed    Test2021    #输入重置密码
    click element    id=cn.butel.redmeeting:id/change_pwd_accomplish_btn    #点击完成
    sleep    3
    Wait Until Element Is Visible    xpath=//*[@resource-id='cn.butel.redmeeting:id/login_title']    30    #等待回到登录页面
    input text    id=cn.butel.redmeeting:id/login_pwd_ed    Test2021    #输入新密码
    click element    id=cn.butel.redmeeting:id/check_rember_img    #点击记住密码
    click element    id=cn.butel.redmeeting:id/login_btn    #点击登录按钮
    sleep    3
    #Wait Until Element Is Visible    xpath=//*[@resource-id='cn.butel.redmeeting:id/nube_tv']    30    #等待头像
    ${element_exist}    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[@resource-id='cn.butel.redmeeting:id/nube_tv']    #获取用户名元素id
    Run Keyword If    ${element_exist}==True    log    修改成功已进入到登录页面
    ...    ELSE    log    修改密码失败

会议外设置（修改摄像头状态）
    #设置：摄像头打开
    sleep    8
    click element    id=cn.butel.redmeeting:id/head_iv    #点击头像
    click element    id=cn.butel.redmeeting:id/gotosetting_rl    #点击设置
    click element    id=cn.butel.redmeeting:id/carema_setting_switch    #点击入会开启摄像头
    click element    id=cn.butel.redmeeting:id/back_btn    #点击返回
    click element    id=cn.butel.redmeeting:id/back_btn    #点击返回
    click element    id=cn.butel.redmeeting:id/join_meeting_ly    #点加入会议
    input text    id=cn.butel.redmeeting:id/meetingid_input_edit    ${Long_meeting}    #输入会议号
    click element    id=cn.butel.redmeeting:id/join_meeting_btn    #点加入会议按钮
    sleep    8
    #Wait Until Element Is Visible    id=cn.butel.redmeeting:id/speaker_name_tv    30    #加入会议顶部昵称元素
    click A Point    500    400    100    #点击坐标（500,400）
    sleep    2
    ${Carmen_exist}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/header_tool_view_change_camera    #判断摄像头切换按钮是否存在
    Run Keyword If    ${Carmen_exist}==True    log    设置中修改开启摄像头成功
    ...    ELSE    log    设置中修改开启摄像头失败
    sleep    5
    click A Point    500    400    100    #点击坐标（500,400）
    sleep    2
    click element    id=cn.butel.redmeeting:id/header_tool_view_back_tv    #点击退出按钮
    #click element    id=cn.butel.redmeeting:id/tv_sure    #点退出二次确认弹框
    click element    id=cn.butel.redmeeting:id/tv_leave_meeting    #点退出二次确认弹框
    ${element_exist}    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[@resource-id='cn.butel.redmeeting:id/nube_tv']    #获取用户名元素id
    Run Keyword If    ${element_exist}==True    log    修改摄像头状态为：打开，设置后，退出会议
    ...    ELSE    log    修改摄像头状态：打开，设置后，退出会议失败
    #设置：摄像头关闭
    Wait Until Element Is Visible    xpath=//*[@resource-id='cn.butel.redmeeting:id/nube_tv']    30    #等待用户名
    click element    id=cn.butel.redmeeting:id/head_iv    #点击头像
    click element    id=cn.butel.redmeeting:id/gotosetting_rl    #点击设置
    click element    id=cn.butel.redmeeting:id/carema_setting_switch    #点击入会关闭摄像头（方便后续重装后依然是关闭的）
    click element    id=cn.butel.redmeeting:id/back_btn    #点击返回
    click element    id=cn.butel.redmeeting:id/back_btn    #点击返回
    click element    id=cn.butel.redmeeting:id/join_meeting_ly    #点加入会议
    input text    id=cn.butel.redmeeting:id/meetingid_input_edit    ${Long_meeting}    #输入会议号
    click element    id=cn.butel.redmeeting:id/join_meeting_btn    #点加入会议按钮
    Wait Until Element Is Visible    id=cn.butel.redmeeting:id/speaker_name_tv    30    #加入会议顶部昵称元素
    click A Point    500    400    100    #点击坐标（500,400）
    sleep    2
    ${Carmen_exist}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/header_tool_view_change_camera    #判断摄像头切换按钮是否存在
    Run Keyword If    ${Carmen_exist}==False    log    设置中修改关闭摄像头成功
    ...    ELSE    log    设置中修改关闭摄像头失败
    sleep    5
    click A Point    500    400    100    #点击坐标（500,400）
    sleep    2
    click element    id=cn.butel.redmeeting:id/header_tool_view_back_tv    #点击退出按钮
    #click element    id=cn.butel.redmeeting:id/tv_sure    #点退出二次确认弹框
    click element    id=cn.butel.redmeeting:id/tv_leave_meeting    #点退出二次确认弹框
    ${element_exist}    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[@resource-id='cn.butel.redmeeting:id/nube_tv']    #获取用户名元素id
    Run Keyword If    ${element_exist}==True    log    修改摄像头状态为：关闭，设置后，退出会议
    ...    ELSE    log    修改摄像头状态：关闭，设置后，退出会议失败

网络检测
    sleep    8
    click element    id=cn.butel.redmeeting:id/head_iv    #点击头像
    click element    id=cn.butel.redmeeting:id/gotosetting_rl    #点击设置
    click element    id=cn.butel.redmeeting:id/gotonetworkdetection_rl    #点击网络检测
    Wait Until Element Is Visible    id=cn.butel.redmeeting:id/text3    30    #网络状态元素
    ${text_state}    Get Text    id=cn.butel.redmeeting:id/detection_type_tv    #网络状态字段
    ${text_authority}    Get Text    id=cn.butel.redmeeting:id/network_permiss    #网络权限字段
    ${text_connection}    Get Text    id=cn.butel.redmeeting:id/network_connect    #网连接情况
    ${text_server}    Get Text    id=cn.butel.redmeeting:id/sercer_connect    #服务器连接情况
    Run Keyword If    $text_state=='正常'    log    网络状态，正常
    ...    ELSE    Fail    网络检测，异常
    Run Keyword If    $text_authority=='正常'    log    网络权限，正常
    ...    ELSE    Fail    网络权限，异常
    Run Keyword If    $text_connection=='正常'    log    网络连接情况，正常
    ...    ELSE    Fail    网络连接情况，异常
    Run Keyword If    $text_server=='正常'    log    服务器连接情况，正常
    ...    ELSE    Fail    服务器连接情况，异常
    click element    id=cn.butel.redmeeting:id/back_btn    #点击返回
    click element    id=cn.butel.redmeeting:id/back_btn    #点击返回
    click element    id=cn.butel.redmeeting:id/back_btn    #点击返回

OEM设置
    sleep    8
    click element    id=cn.butel.redmeeting:id/head_iv    #点击头像
    click element    id=cn.butel.redmeeting:id/gotosetting_rl    #点击我的页面中的设置
    click element    id=cn.butel.redmeeting:id/title_txt    #点击设置
    click element    id=cn.butel.redmeeting:id/title_txt    #点击设置
    click element    id=cn.butel.redmeeting:id/gotooem_ly    #点击oem设置
    click element    xpath=//*[@text='红云远程医疗']    #点击“红云远程医疗”
    sleep    6    #加载oem
    click element    id=cn.butel.redmeeting:id/login_or_register_btn    #点注册/登录
    click element    id=cn.butel.redmeeting:id/login_btn    #点击登录
    sleep    6    #登录加载
    ${medical_consultant}    get text    id=cn.butel.redmeeting:id/join_meeting_tv
    Run Keyword If    $medical_consultant=='加入会诊'    log    切换到红云远程医疗oem成功
    ...    ELSE    Fail    切换到红云远程医疗oem失败
    click element    id=cn.butel.redmeeting:id/head_iv    #点击头像
    click element    id=cn.butel.redmeeting:id/gotosetting_rl    #点击我的页面中的设置
    click element    id=cn.butel.redmeeting:id/title_txt    #点击设置
    click element    id=cn.butel.redmeeting:id/title_txt    #点击设置
    click element    id=cn.butel.redmeeting:id/gotooem_ly    #点击oem设置
    click element    xpath=//*[@text='红云会议']    #点击“红云会议疗”
    sleep    6    #加载oem
    click element    id=cn.butel.redmeeting:id/login_or_register_btn    #点注册/登录
    click element    id=cn.butel.redmeeting:id/login_btn    #点击登录
    sleep    6    #登录加载
    ${Butel_meeting}    get text    id=cn.butel.redmeeting:id/join_meeting_tv
    Run Keyword If    $Butel_meeting=='加入会议'    log    切换到红云会议oem成功
    ...    ELSE    Fail    切换到红云会议oem失败

我的设备
    sleep    8
    Back_homepage_once
    click element    id=cn.butel.redmeeting:id/head_iv    #点击头像
    click element    id=cn.butel.redmeeting:id/gotomyfacility_rl    #点我的设备
    click element    id=cn.butel.redmeeting:id/right_btn    #点击添加
    input text    id=cn.butel.redmeeting:id/edt_nube    ${video_id}    #输入设备视讯号(修改本条用例视讯号即可)
    clear text    id=cn.butel.redmeeting:id/edt_name
    input text    id=cn.butel.redmeeting:id/edt_name    M5Z    #输入设备名称
    click element    id=cn.butel.redmeeting:id/right_btn    #点击完成
    ${my_device}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/goto_facility_rl    #我的设备
    Run Keyword If    ${my_device}==True    log    我的设备添加成功
    ...    ELSE    log    我的设备添加失败
    ${deviceName}    Get Text    id=cn.butel.redmeeting:id/item_nube    #设备名称
    Run Keyword If    $deviceName=='M5Z'    log    设备名称为：M5Z
    ...    ELSE    log    设备名称不是：M5Z

连接我的设备
    click element    id=cn.butel.redmeeting:id/goto_facility_rl    #点击我的设备
    click element    id=cn.butel.redmeeting:id/txt_link_facility    #点击连接设备
    sleep    5
    #Wait Until Element Is Visible    id=cn.butel.redmeeting:id/speaker_name_tv    30    #等待会内昵称出现
    ${devices_meeting}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/speaker_name_tv
    Run Keyword If    ${devices_meeting}==True    run keywords    log    连接设备成功，并且进入会议，开始执行退会操作
    ...    AND    sleep    5
    ...    AND    click A Point    500    400    100
    ...    AND    sleep    2
    ...    AND    click element    id=cn.butel.redmeeting:id/header_tool_view_back_tv
    ...    AND    click element    id=cn.butel.redmeeting:id/tv_sure
    ...    AND    Exit_Meeting_Judge
    ...    ELSE    log    连接设备失败，没有进入会议，可能设备不在线
    sleep    5
    click element    id=cn.butel.redmeeting:id/right_btn    #点击右上角按钮
    click element    id=cn.butel.redmeeting:id/delete_tv    #点击删除设备
    ${deleteDevice}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/item_nube    #设备名称
    Run Keyword If    ${deleteDevice}==True    log    删除设备失败
    ...    ELSE    log    删除设备成功
    click element    id=cn.butel.redmeeting:id/back_btn    #点击返回
    click element    id=cn.butel.redmeeting:id/back_btn    #点击返回

加入加密会议
    sleep    8
    click element    id=cn.butel.redmeeting:id/join_meeting_ly    #点击加入会议
    input text    id=cn.butel.redmeeting:id/meetingid_input_edit    ${Encrypt_meeting}    #输入会议号
    click element    id=cn.butel.redmeeting:id/join_meeting_btn    #点击加入会议
    sleep    2
    input text    id=cn.butel.redmeeting:id/et_input_meeting_password_content    939260    #输入会议密码
    click element    id=cn.butel.redmeeting:id/input_meeting_password_dialog_right_button    #点击确定
    Wait Until Element Is Visible    id=cn.butel.redmeeting:id/speaker_name_tv    30    #等待会内昵称出现
    ${into_meeting}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/speaker_name_tv
    Run Keyword If    ${into_meeting}==True    log    进入加密会议成功
    ...    ELSE    log    进入加密会议失败
    sleep    5
    click A Point    500    400    100    #点击坐标（500,400）
    sleep    2
    click element    id=cn.butel.redmeeting:id/header_tool_view_back_tv    #点击退出按钮
    click element    id=cn.butel.redmeeting:id/tv_sure    #点退出二次确认弹框
    ${element_exist}    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[@resource-id='cn.butel.redmeeting:id/nube_tv']    #获取用户名元素id
    Run Keyword If    ${element_exist}==True    log    退出会议成功
    ...    ELSE    log    退出会议失败

输入错误会议密码
    sleep    6
    click element    id=cn.butel.redmeeting:id/join_meeting_ly    #点击加入会议
    input text    id=cn.butel.redmeeting:id/meetingid_input_edit    ${Encrypt_meeting}    #输入会议号
    click element    id=cn.butel.redmeeting:id/join_meeting_btn    #点击加入会议
    input text    id=cn.butel.redmeeting:id/et_input_meeting_password_content    111112    #输入会议密码
    click element    id=cn.butel.redmeeting:id/input_meeting_password_dialog_right_button    #点击确定
    ${PopUp}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/tv_input_meeting_password_title
    Run Keyword If    ${PopUp}==True    log    会议密码输入错误，进入会议失败
    ...    ELSE    log    会议密码输入正确，进入会议成功
    click element    id=cn.butel.redmeeting:id/input_meeting_password_dialog_left_button    #点取消输入密码弹框
    click element    id=cn.butel.redmeeting:id/back_str    #点击取消，回到主页

加入加锁会议
    sleep    6
    click element    id=cn.butel.redmeeting:id/join_meeting_ly    #点击加入会议
    input text    id=cn.butel.redmeeting:id/meetingid_input_edit    ${Lock_meeting}    #输入会议号
    click element    id=cn.butel.redmeeting:id/join_meeting_btn    #点击加入会议
    #Wait Until Element Is Visible    id=cn.butel.redmeeting:id/title_txt    30    #等待加会页面title字段出现
    sleep    8
    ${lock_meeting}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/title_txt    #获取加入会议字段
    ${pop_btn_center}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/btn_center
    Run Keyword If    ${lock_meeting}==False    run keywords    log    会议不为加锁会议，或主持人不在会议中，会议将自动退出
    ...    AND    sleep    5
    ...    AND    click A Point    500    400    100
    ...    AND    sleep    2
    ...    AND    click element    id=cn.butel.redmeeting:id/header_tool_view_back_tv
    ...    AND    click element    id=cn.butel.redmeeting:id/tv_sure
    ...    ELSE IF    ${lock_meeting}==True    run keywords    log    该会议为加锁会议，无法加入
    ...    AND    click element    id=cn.butel.redmeeting:id/back_str
    ...    ELSE IF    ${pop_btn_center}==True    run keywords    log    该会议为加锁会议，无法加入
    ...    AND    click element    id=cn.butel.redmeeting:id/btn_center
    ...    ELSE    log    该加锁会议已结束！！！
    #click element    id=cn.butel.redmeeting:id/back_str    #点击取消，回到主页
    #click element    id=cn.butel.redmeeting:id/btn_center    #点击确定会议已加锁弹框

关闭应用在启动
    sleep    8
    click element    id=cn.butel.redmeeting:id/head_iv    #点头像
    click element    id=cn.butel.redmeeting:id/btn_logout    #点退出按钮
    click element    id=cn.butel.redmeeting:id/cancle_tv    #点关闭应用
    click element    id=cn.butel.redmeeting:id/btn_right    #点击关闭应用弹框按钮
    打开应用
    sleep    10

重置应用
    sleep    8
    click element    id=cn.butel.redmeeting:id/head_iv    #点头像
    click element    id=cn.butel.redmeeting:id/btn_logout    #点退出按钮
    click element    id=cn.butel.redmeeting:id/reset_app_tv
    click element    id=cn.butel.redmeeting:id/btn_right
    sleep    5
    打开应用
    sleep    10
    ${agreement}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/consent_tv
    Run Keyword If    ${agreement}==True    click element    id=cn.butel.redmeeting:id/consent_tv
    ...    ELSE    Fail    重置应用后，不存在隐私弹框，本条用例视为缺陷
    click element    id=cn.butel.redmeeting:id/login_or_register_btn
    input text    id=cn.butel.redmeeting:id/login_num_ed    ${userid}    #输入账号
    input password    id=cn.butel.redmeeting:id/login_pwd_ed    ${passwd}    #输入密码
    click A Point    500    400    100
    sleep    4
    click element    id=cn.butel.redmeeting:id/login_remember_pwd
    click element    id=cn.butel.redmeeting:id/login_btn    #点击登录按钮
    sleep    8
    #Wait Until Element Is Visible    id=cn.butel.redmeeting:id/nube_tv    30    #等待用户昵称出现
    ${head_page}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/speaker_name_tv
    Run Keyword If    ${head_page}    log    登录成功
    ...    ELSE    log    登录失败
    sleep    8

*** Keywords ***
Exit_Meeting_Judge
    #退出会议判断
    sleep    5
    ${devices_meeting_exit}    Get Text    id=cn.butel.redmeeting:id/title_txt    #设备信息页
    Run Keyword If    $devices_meeting_exit=='设备信息'    log    退会成功
    ...    ELSE    log    退会失败

Back_homepage
    #从我的页面回到主页
    ${hear_img}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/head_iv
    Run Keyword If    ${hear_img}==False    run keywords    log    返回到主页
    ...    AND    sleep    2
    ...    AND    click element    id=cn.butel.redmeeting:id/back_btn
    ...    AND    click element    id=cn.butel.redmeeting:id/back_btn
    ...    ELSE    log    无需返回到主页，已经在主页了！

Back_homepage_once
    #从网络检测回到主页
    ${hear_img}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/head_iv
    Run Keyword If    ${hear_img}==False    run keywords    log    返回到主页
    ...    AND    sleep    2
    ...    AND    click element    id=cn.butel.redmeeting:id/back_btn
    ...    AND    click element    id=cn.butel.redmeeting:id/back_btn
    ...    AND    click element    id=cn.butel.redmeeting:id/back_btn
    ...    ELSE    log    无需返回到主页，已经在主页了！
    #反馈
    #sleep    8
    #click element    id=cn.butel.redmeeting:id/head_iv    #点击头像
    #click element    id=cn.butel.redmeeting:id/feedback_rl    #点击我要反馈
    #Wait Until Element Is Visible    id=cn.butel.redmeeting:id/title_txt    30    #反馈
    #input text    xpath=//*[resource-id='content']    测试    #输入测试
    #click element    id=cn.butel.redmeeting:id/addFeedback    #点击发送反馈
    #${text}    Get Text    xpath=//android.view.View    #文字内容
    #log    ${text}
    #发送日志
    #sleep    6
    #click element    id=cn.butel.redmeeting:id/head_iv    #点击头像
    #click element    id=cn.butel.redmeeting:id/gotoabout_rl    #点击关于
    #click element    id=cn.butel.redmeeting:id/iv_logo    #点击log
    #click element    id=cn.butel.redmeeting:id/iv_logo
    #click element    id=cn.butel.redmeeting:id/iv_logo
    #click element    id=cn.butel.redmeeting:id/share_log_btn    #点击分享日志
    #wait until page contains element    id=android:id/text1    20    error
    #click element    id=android:id/text1
    #click element    id=com.tencent.mobileqq:id/text1    #我的电脑
    #click element    id=com.tencent.mobileqq:id/dialogRightBtn    #点击发送日志

judge_element_text
    Page Should Contain Text    测试预约会议，再加入预约会议
