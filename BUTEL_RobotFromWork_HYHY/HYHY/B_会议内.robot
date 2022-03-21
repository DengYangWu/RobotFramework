*** Settings ***
Library           AppiumLibrary    #Suite Setup    打开应用
Resource          调用.robot

*** Variables ***
${Long_meeting}    30211492    # 主持人的会议
#${Long_meeting}    20218419    # 主持人的会议
${Long_meeting_compere}    20219045    # 参会者的会议
${Multi-humen}    30238149    #多人会议（PC在会）
${Multi-humen-M5Z}    39240431    #多人会议(M5Z)
#{Long_meeting}    30255642    # 常驻会议号

*** Test Cases ***
加入会议
    sleep    8
    click element    id=cn.butel.redmeeting:id/join_meeting_ly    #点击加入会议按钮
    sleep    2
    clear text    id=cn.butel.redmeeting:id/meetingid_input_edit    #点击输入框
    input text    id=cn.butel.redmeeting:id/meetingid_input_edit    ${Long_meeting}    #输入会议号
    #input text    id=cn.butel.redmeeting:id/meetingid_input_edit    30255642    #输入会议号
    click element    id=cn.butel.redmeeting:id/join_meeting_btn    #点击加入会议按钮
    Wait Until Element Is Visible    id=cn.butel.redmeeting:id/speaker_name_tv    30    #等待会内昵称出现
    ${into_meeting}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/speaker_name_tv
    Run Keyword If    ${into_meeting}==True    log    加入会议成功
    ...    ELSE    log    加入会议失败

打开摄像头
    sleep    8
    click A Point    500    400    100    #点击坐标（500,400）
    sleep    2
    click element    id=cn.butel.redmeeting:id/camera_hint    #点击打开摄像头
    ${isMessage}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/header_tool_view_change_camera
    Run Keyword If    ${isMessage}    log    摄像头已打开
    ...    ELSE    log    摄像头已关闭
    sleep    5
    click A Point    500    400    100    #点击坐标（500,400）
    sleep    2
    click element    id=cn.butel.redmeeting:id/camera_hint    #点击关闭摄像头
    ${isMessage}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/header_tool_view_change_camera
    Run Keyword If    ${isMessage}    log    摄像头已打开
    ...    ELSE    log    摄像头已关闭

关闭麦克风
    sleep    8
    click A Point    500    400    100    #点击坐标（500,400）
    sleep    2
    click element    id=cn.butel.redmeeting:id/mic_hint    #点击关闭麦克风
    sleep    5
    click A Point    500    400    100    #点击坐标（500,400）
    sleep    2
    click element    id=cn.butel.redmeeting:id/mic_hint    #点击打开麦克风

切换画面模式
    sleep    8
    #click A Point    500    400    100    #点击坐标（500,400）
    sleep    2
    click element    id=cn.butel.redmeeting:id/first_dot    #点击驾驶模式分页圆点
    ${DrivingModel}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/header_tool_view_meetingmode_tv
    Run Keyword If    ${DrivingModel}    log    已切换到驾驶模式
    ...    ELSE    log    未切换到驾驶模式
    sleep    3
    click element    id=cn.butel.redmeeting:id/second_dot    #点击演讲者分页圆点
    ${SpeakerModel}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/speaker_name_tv
    Run Keyword If    ${SpeakerModel}    log    已切换演讲者模式
    ...    ELSE    log    未切换到演讲者模式
    sleep    3
    ${page_exist}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/seek_bar_rl
    ${GalleryModel}    Get Matching Xpath Count    xpath=//android.widget.FrameLayout[@resource-id='cn.butel.redmeeting:id/meeting_mode_gallery_mode_view']/*
    Run Keyword If    ${page_exist}==True    run keywords    log    当前有画廊模式
    ...    AND    click element    id=cn.butel.redmeeting:id/seek_bar_rl
    ...    ELSE    log    当前没有画廊模式
    Run Keyword If    ${GalleryModel}>0    log    已切换到画廊模式
    ...    ELSE    log    未切换到画廊模式，因为会议中只有1个人

驾驶模式操作自己麦克风
    sleep    6
    click A Point    500    400    100    #点击坐标（500,400）
    sleep    1
    click element    id=cn.butel.redmeeting:id/mic_hint    #点击关闭麦克风
    sleep    6
    click element    id=cn.butel.redmeeting:id/first_dot    #点击驾驶模式分页圆点
    ${DrivingModel}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/header_tool_view_meetingmode_tv
    Run Keyword If    ${DrivingModel}    log    已切换到驾驶模式
    ...    ELSE    log    未切换到驾驶模式
    sleep    3
    ${mac_state}    Get Text    id=cn.butel.redmeeting:id/clickBtn_text    #获取驾驶模式麦克风按钮状态
    Run Keyword If    $mac_state=='我要说话'    log    麦克风状态为：关闭
    ...    ELSE    Should Be Equal As Strings    ${mac_state}    我要说话
    click element    id=cn.butel.redmeeting:id/clickBtn_text    #点击关闭麦克风
    ${mac_state}    Get Text    id=cn.butel.redmeeting:id/clickBtn_text    #获取驾驶模式麦克风按钮状态
    Run Keyword If    $mac_state=='结束说话'    log    麦克风状态为：打开
    ...    ELSE    Should Be Equal As Strings    ${mac_state}    结束说话
    click element    id=cn.butel.redmeeting:id/clickBtn_text    #点击打开麦克风
    ${mac_state}    Get Text    id=cn.butel.redmeeting:id/clickBtn_text    #获取驾驶模式麦克风按钮状态
    Run Keyword If    $mac_state=='我要说话'    log    麦克风状态为：关闭
    ...    ELSE    Should Be Equal As Strings    ${mac_state}    我要说话
    click element    id=cn.butel.redmeeting:id/second_dot    #点击演讲者分页圆点

切换会议模式
    sleep    8
    click A Point    500    400    100    #点击坐标（500,400）
    sleep    2
    click element    id=cn.butel.redmeeting:id/tv_more    #更多
    sleep    2
    click A Point    500    400    100    #点击坐标（500,400），显示菜单栏
    sleep    2
    ${Model}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/meeting_room_menu_main_view_host_icon
    Run Keyword If    ${Model}==True    log    当前设置主持模式成功
    ...    ELSE    log    当前设置主持模式失败

会议加锁
    sleep    8
    click A Point    500    400    100    #点击坐标（500,400）
    sleep    2
    click element    id=cn.butel.redmeeting:id/tv_more    #更多
    sleep    1
    click element    id=cn.butel.redmeeting:id/meeting_setting_tv    #设置
    click element    id=cn.butel.redmeeting:id/meeting_room_menu_main_view_set_lock_icon
    #判断设置左上角是否有退出按钮
    ${exit_exist}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/iv_back
    Run Keyword If    ${exit_exist}    run keywords    log    退出箭头存在
    ...    AND    click element    id=cn.butel.redmeeting:id/iv_back
    ...    ELSE    log    没有箭头    #点击退出箭头，收起设置页
    click A Point    500    400    100    #点击坐标（500,400），收起设置页

会议加密
    sleep    8
    click A Point    500    400    100    #点击坐标（500,400）
    sleep    2
    click element    id=cn.butel.redmeeting:id/tv_more    #更多
    click element    id=cn.butel.redmeeting:id/meeting_setting_tv    #设置
    click element    id=cn.butel.redmeeting:id/meeting_room_menu_main_view_encrypt_iv    #会议加密
    input text    id=cn.butel.redmeeting:id/meeting_set_pwd_ed    666666    #设置会议密码
    #click A Point    1668    521    #收起软键盘
    click element    id=cn.butel.redmeeting:id/qn_operae_dialog_right_button    #确认保存密码
    sleep    5
    click A Point    500    400    100    #点击坐标（500,400）
    sleep    2
    click element    id=cn.butel.redmeeting:id/tv_more    #更多
    click element    id=cn.butel.redmeeting:id/meeting_setting_tv    #设置
    click element    id=cn.butel.redmeeting:id/meeting_room_menu_main_view_encrypt_iv    #会议加密
    click A Point    500    400    100    #点击坐标（500,400）

发送消息
    sleep    8
    click A Point    500    400    100    #点击坐标（500,400）
    sleep    2
    click element    id=cn.butel.redmeeting:id/tv_more    #更多
    click element    id=cn.butel.redmeeting:id/meeting_im_chat_rl    #点击聊天
    click element    id=cn.butel.redmeeting:id/tv_send_msg_tip    #输入消息
    input text    id=cn.butel.redmeeting:id/msg_input_edit    helloworld!    #输入消息
    click element    id=cn.butel.redmeeting:id/send_msg_btn    #点击发送消息
    #click A Point    200    200    10
    #click A Point    100    400    10
    #要区分手机横竖屏，判断设置左上角是否有退出按钮
    ${exit_exist}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/iv_back
    Run Keyword If    ${exit_exist}    run keywords    log    退出箭头存在
    ...    AND    click element    id=cn.butel.redmeeting:id/iv_back
    ...    ELSE    run keywords    log    没有箭头
    ...    AND    click A Point    300    300    10
    ...    AND    click A Point    300    300    10    #点击空白，收起聊天界面

开启/结束白板共享
    sleep    8
    click A Point    500    400    100
    sleep    2
    click element    id=cn.butel.redmeeting:id/share_img    #点击共享按钮
    click element    id=cn.butel.redmeeting:id/white_share_tv    #选择白板
    sleep    5
    Wait Until Element Is Visible    id=cn.butel.redmeeting:id/speaker_mic_iv    20    #进入白板页面
    click element    id=cn.butel.redmeeting:id/brush_btn    #点击画笔
    Swipe By Percent    20    20    50    50    1000    #拖动
    sleep    5
    click element    id=cn.butel.redmeeting:id/close_paint_btn
    click A Point    500    400    100
    sleep    2
    click element    id=cn.butel.redmeeting:id/share_hint    #点击结束共享
    click element    id=cn.butel.redmeeting:id/btn_right    #点击确认结束共享

屏幕共享（不予设置共享权限）
    sleep    8
    click A Point    500    400    100
    sleep    1
    click element    id=cn.butel.redmeeting:id/share_img    #点击共享按钮
    sleep    2
    click element    id=cn.butel.redmeeting:id/screen_share_tv    #选择屏幕
    sleep    3
    click element    id=android:id/button2    #点击允许
    ${titleName_exist}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/speaker_name_tv
    Run Keyword If    ${titleName_exist}    log    不予共享权限，不显示共享屏幕（成功）
    ...    ELSE    log    不予共享权限，显示共享（失败）

开启/结束屏幕共享
    sleep    8
    click A Point    500    400    100
    sleep    1
    click element    id=cn.butel.redmeeting:id/share_img    #点击共享按钮
    sleep    2
    click element    id=cn.butel.redmeeting:id/screen_share_tv    #选择屏幕
    sleep    3
    click element    id=android:id/button1    #点击允许
    Wait Until Element Is Visible    id=cn.butel.redmeeting:id/screen_share_img    10    #等待“您正在共享手机屏幕”
    Background App    10    #会议内切到后台10s后再切回前台
    sleep    5
    click A Point    500    400    100
    sleep    2
    click element    id=cn.butel.redmeeting:id/share_img    #点击结束共享
    click element    id=cn.butel.redmeeting:id/btn_right    #点击确认结束共享

切到后台
    sleep    6
    Background App    10    #会议内切到后台10s后再切回前台
    sleep    5
    click A Point    500    400    100
    sleep    1
    Wait Until Element Is Visible    id=cn.butel.redmeeting:id/header_tool_view_back_tv
    log    切换到前台成功

全体静音（主持人身份）
    #*******************    参会列表主持人操作    *********************
    sleep    8
    click A Point    500    400    100    #点击坐标（500,400）打开菜单栏
    sleep    2
    click element    id=cn.butel.redmeeting:id/member_img    #点击菜单栏主持会议按钮
    click element    id=cn.butel.redmeeting:id/btn_all_mute    #点击全体静音按钮
    click element    id=cn.butel.redmeeting:id/tv_all_mute    #点击弹框全体静音按钮
    click A Point    500    400    100    #点击坐标（500,400） 收起参会方列表
    ${text_mute}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/speaker_mic_iv
    Run Keyword If    ${text_mute} == True    log    设置全体静音成功
    ...    ELSE    log    设置全体静音失败    #判断大窗口麦克风有没有麦克风图标

解除全体静音（主持人身份）
    sleep    2
    click A Point    500    400    100    #点击坐标（500,400）打开菜单栏
    sleep    2
    click element    id=cn.butel.redmeeting:id/member_img    #点击菜单栏主持会议按钮
    click element    id=cn.butel.redmeeting:id/iv_more    #点击“...”
    click element    id=cn.butel.redmeeting:id/tv_cancel_all_mute    #点击解除全体静音按钮
    click A Point    500    400    100    #点击坐标（500,400） 收起参会方列表
    ${text_mute}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/speaker_mic_iv
    Run Keyword If    ${text_mute} == False    log    解除全体静音成功
    ...    ELSE    log    解除全体静音失败    #判断大窗口麦克风有没有麦克风图标
    sleep    2
    #点击打开麦克风，避免执行参会列表操作麦克风出错
    click A Point    500    400    100    #点击坐标（500,400）打开菜单栏
    sleep    2
    click element    id=cn.butel.redmeeting:id/member_img    #点击菜单栏主持会议按钮
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点击主持人参会者
    click element    id=cn.butel.redmeeting:id/tv_mute_operation    #点击打开麦克风
    click A Point    500    400    100    #点击坐标（500,400）收起参会列表

判断身份
    anchorOrhearer

查看会议中人数
    Look_meeting_NumPeople

参会列表操作自己开关麦克风（主持人身份）
    click A Point    500    400    100    #点击坐标（500,400）打开菜单栏
    sleep    8
    click A Point    500    400    100    #点击坐标（500,400）打开菜单栏
    sleep    2
    #关闭麦克风
    click element    id=cn.butel.redmeeting:id/member_img    #点击菜单栏主持会议按钮
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点击主持人参会者
    click element    id=cn.butel.redmeeting:id/tv_mute_operation    #点击静音
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点击主持人参会者
    ${mic_mute}    Get Text    id=cn.butel.redmeeting:id/tv_mute_operation    #获取麦克风按钮字段的值
    Run Keyword If    $mic_mute=='取消静音'    log    关闭麦克风成功
    ...    ELSE    Fail    关闭麦克风失败，该用例停止执行
    click element    id=cn.butel.redmeeting:id/tv_cancel    #点击取消按钮
    #打开麦克风
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点击主持人参会者
    click element    id=cn.butel.redmeeting:id/tv_mute_operation    #点击静音
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点击主持人参会者
    ${mic_open}    Get Text    id=cn.butel.redmeeting:id/tv_mute_operation    #判断静音按钮字段是否改变
    Run Keyword If    $mic_open == '静音'    log    打开麦克风成功
    ...    ELSE    Fail    打开麦克风失败，该用例停止执行
    click element    id=cn.butel.redmeeting:id/tv_cancel    #点击取消按钮

参会列表操作自己开关摄像头（主持人身份）
    Judge_bounced    #判断取消按钮是否存
    sleep    2
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点击主持人参会者
    click element    id=cn.butel.redmeeting:id/tv_video_operation    #点击打开摄像头
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点击主持人参会者
    ${camera_open}    Get Text    id=cn.butel.redmeeting:id/tv_video_operation    #获取摄像头按钮字段的值
    Run Keyword If    $camera_open == '关闭摄像头'    log    打开摄像头成功
    ...    ELSE    Fail    打开摄像头失败，该用例停在执行
    click element    id=cn.butel.redmeeting:id/tv_cancel    #点击取消按钮
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点击主持人参会者
    click element    id=cn.butel.redmeeting:id/tv_video_operation    #点击打开摄像头
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点击主持人参会者
    ${camera_close}    Get Text    id=cn.butel.redmeeting:id/tv_video_operation    #获取摄像头按钮字段的值
    Run Keyword If    $camera_close == '打开摄像头'    log    关闭摄像头成功
    ...    ELSE    Fail    关闭摄像头失败，该用例停在执行
    click element    id=cn.butel.redmeeting:id/tv_cancel    #点击取消按钮

参会列表操作自己为主讲视频（主持人身份）
    Judge_bounced    #判断取消按钮是否存
    sleep    2
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点击主持人参会者
    click element    id=cn.butel.redmeeting:id/tv_master_video_operation    #设置主讲视频
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点击主持人参会者
    ${speaker_set}    Get Text    id=cn.butel.redmeeting:id/tv_master_video_operation    #获取主讲视频按钮字段
    Run Keyword If    $speaker_set == '取消主讲视频'    log    设置主讲视频成功
    ...    ELSE    Fail    设置主讲视频失败，该用例停在执行
    click element    id=cn.butel.redmeeting:id/tv_cancel    #点击取消按钮
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点击主持人参会者
    click element    id=cn.butel.redmeeting:id/tv_master_video_operation    #设置主讲视频
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点击主持人参会者
    ${speaker_off}    Get Text    id=cn.butel.redmeeting:id/tv_master_video_operation    #获取主讲视频按钮字段
    Run Keyword If    $speaker_off == '设置主讲视频'    log    取消主讲视频成功
    ...    ELSE    Fail    取消主讲视频失败，该用例停在执行
    click element    id=cn.butel.redmeeting:id/tv_cancel    #点击取消按钮
    click A Point    500    400    100    #点击坐标（500,400）打开菜单栏

参会者列表操作其他人调节摄像头（主持人身份）
    Judge_bounced    #判断取消按钮是否存
    click A Point    500    400    100    #点击坐标（500,400）打开菜单栏
    sleep    2
    click element    id=cn.butel.redmeeting:id/member_img    #点击菜单栏主持会议按钮
    sleep    4
    #click element    xpath=//android.widget.TextView[@recource-id='cn.butel.redmeeting:id/tv_participator_name']1    #${name_speaker}    Get text    id=cn.butel.redmeeting:id/tv_participator_name    #Run Keyword If    $name_speaker == 'testnj'    click element    ${name_speaker}    #...    # ELSE    Fail    取消主讲视频失败，该用例停在执行
    ${t}    get Webelements    id=cn.butel.redmeeting:id/tv_participator_name
    click element    ${t}[1]
    click element    id=cn.butel.redmeeting:id/tv_camera_operation
    sleep    4
    ${Adjusting_camera}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/tv_adjust_camera
    Run Keyword If    ${Adjusting_camera} == True    log    已经进入摄像头调节页面
    ...    ELSE    log    进入摄像头调节页面失败
    click element    id=cn.butel.redmeeting:id/iv_back
    ${meeting}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/btn_all_mute
    Run Keyword If    ${meeting} == True    log    已回到会议内
    ...    ELSE    log    回到会议内失败
    #click A Point    500    400    100    #点击坐标（500,400）打开菜单栏

参会者列表操作其他人麦克风（主持人身份）
    Judge_bounced    #判断取消按钮是否存
    sleep    2
    ${t}    get Webelements    id=cn.butel.redmeeting:id/tv_participator_name
    click element    ${t}[1]
    click element    id=cn.butel.redmeeting:id/tv_mute_operation
    click element    ${t}[1]
    ${mic_mute}    Get Text    id=cn.butel.redmeeting:id/tv_mute_operation    #获取麦克风按钮字段的值
    Run Keyword If    $mic_mute=='取消静音'    log    关闭麦克风成功
    ...    ELSE    Fail    关闭麦克风失败，该用例停止执行
    click element    id=cn.butel.redmeeting:id/tv_mute_operation
    click element    ${t}[1]
    ${mic_mute}    Get Text    id=cn.butel.redmeeting:id/tv_mute_operation    #获取麦克风按钮字段的值
    Run Keyword If    $mic_mute=='静音'    log    打开麦克风成功
    ...    ELSE    Fail    打开麦克风失败，该用例停止执行
    click element    id=cn.butel.redmeeting:id/tv_cancel    #点击取消按钮
    #click A Point    500    400    100    #点击坐标（500,400）打开菜单栏

参会者列表操作其他人摄像头（主持人身份）
    Judge_bounced    #判断取消按钮是否存
    sleep    2
    ${t}    get Webelements    id=cn.butel.redmeeting:id/tv_participator_name
    click element    ${t}[1]
    click element    id=cn.butel.redmeeting:id/tv_video_operation
    click element    ${t}[1]
    ${camera_open}    Get Text    id=cn.butel.redmeeting:id/tv_video_operation    #获取摄像头按钮字段的值
    Run Keyword If    $camera_open == '打开摄像头'    log    关闭摄像头成功
    ...    ELSE    Fail    关闭摄像头失败，该用例停在执行
    click element    id=cn.butel.redmeeting:id/tv_video_operation
    click element    ${t}[1]
    ${camera_close}    Get Text    id=cn.butel.redmeeting:id/tv_video_operation    #获取摄像头按钮字段的值
    Run Keyword If    $camera_close == '关闭摄像头'    log    打开摄像头成功
    ...    ELSE    Fail    打开摄像头失败，该用例停在执行
    click element    id=cn.butel.redmeeting:id/tv_cancel    #点击取消按钮
    #click A Point    500    400    100    #点击坐标（500,400）打开菜单栏

参会者列表操作其他人主讲视频（主持人身份）
    Judge_bounced    #判断取消按钮是否存
    sleep    2
    ${t}    get Webelements    id=cn.butel.redmeeting:id/tv_participator_name
    click element    ${t}[1]
    click element    id=cn.butel.redmeeting:id/tv_master_video_operation
    click element    ${t}[1]
    ${speaker_set}    Get Text    id=cn.butel.redmeeting:id/tv_master_video_operation    #获取主讲视频按钮字段
    Run Keyword If    $speaker_set == '取消主讲视频'    log    设置主讲视频成功
    ...    ELSE    Fail    设置主讲视频失败，该用例停在执行
    click element    id=cn.butel.redmeeting:id/tv_master_video_operation
    click element    ${t}[1]
    ${speaker_set}    Get Text    id=cn.butel.redmeeting:id/tv_master_video_operation    #获取主讲视频按钮字段
    Run Keyword If    $speaker_set == '设置主讲视频'    log    取消主讲视频成功
    ...    ELSE    Fail    取消主讲视频失败，该用例停在执行
    click element    id=cn.butel.redmeeting:id/tv_cancel    #点击取消按钮
    click A Point    500    400    100    #点击坐标（500,400）打开菜单栏

屏幕上按钮取消自己为主讲视频（主持人身份）
    Judge_bounced    #判断取消按钮是否存
    sleep    2
    click A Point    500    400    100    #点击坐标（500,400）打开菜单栏
    click element    id=cn.butel.redmeeting:id/member_img    #点击菜单栏主持会议按钮
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点击主持人参会者
    click element    id=cn.butel.redmeeting:id/tv_master_video_operation    #设置主讲视频
    click A Point    500    400    100    #点击坐标（500,400）打开菜单栏
    click A Point    500    400    100    #点击坐标（500,400）打开菜单栏
    sleep    2
    ${speaker_video}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/header_tool_view_cancel_video_tv
    Run Keyword If    ${speaker_video}==True    log    设置主讲视频成功
    ...    ELSE    log    设置主讲视频失败
    click element    id=cn.butel.redmeeting:id/header_tool_view_cancel_video_tv    #点击取消主讲视频
    sleep    6
    click A Point    500    400    100    #点击坐标（500,400）打开菜单栏
    ${cancel_speaker_video}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/header_tool_view_cancel_video_tv
    Run Keyword If    ${cancel_speaker_video}==False    log    取消主讲视频成功
    ...    ELSE    log    取消主讲视频失败

主持模式切换到驾驶模式操作
    sleep    8
    click element    id=cn.butel.redmeeting:id/first_dot    #点击驾驶模式分页圆点
    click element    id=cn.butel.redmeeting:id/clickBtn_text    #点击结束说话
    ${shutUp}    get text    id=cn.butel.redmeeting:id/clickBtn_text
    Run Keyword If    $shutUp=='我要说话'    log    关闭麦克风成功
    ...    ELSE    Fail    关闭麦克风失败
    click element    id=cn.butel.redmeeting:id/clickBtn_text    #点击我要说话
    ${Speak}    get text    id=cn.butel.redmeeting:id/clickBtn_text
    Run Keyword If    $Speak=='结束说话'    log    打开麦克风成功
    ...    ELSE    Fail    打开麦克风失败

邀请加会界面校验
    Judge_drivingPattern
    sleep    8
    click element    id=cn.butel.redmeeting:id/speaker_name_tv    #点击参会名称
    sleep    2
    click element    id=cn.butel.redmeeting:id/tv_more    #更多
    click element    id=cn.butel.redmeeting:id/meeting_invite_tv    #点击邀请加会
    Page Should Contain Element    id=cn.butel.redmeeting:id/share_title_tv    #校验标题元素
    Page Should Contain Element    id=cn.butel.redmeeting:id/meeting_invite_topic_tv    #校验是否有会议主题元素
    Page Should Contain Element    id=cn.butel.redmeeting:id/meeting_invite_begin_time_tv    #校验开始时间元素
    Page Should Contain Element    id=cn.butel.redmeeting:id/meeting_invite_meeting_num_tv    #校验会议号元素
    Page Should Contain Element    id=cn.butel.redmeeting:id/share_wx_ly    #校验微信邀请元素
    Page Should Contain Element    id=cn.butel.redmeeting:id/share_sm_ly    #校验短信邀请元素
    #click element    id=cn.butel.redmeeting:id/speaker_name_tv    #点击参会名称
    click A Point    500    400    100    #点击坐标（500,400）打开菜单栏

退出会议
    sleep    8
    click A Point    500    400    100
    sleep    2
    click element    id=cn.butel.redmeeting:id/header_tool_view_back_tv
    Wait Until Element Is Visible    id=cn.butel.redmeeting:id/tv_leave_meeting    30
    click element    id=cn.butel.redmeeting:id/tv_leave_meeting

从历史记录加入会议
    sleep    8
    click element    id=cn.butel.redmeeting:id/join_meeting_ly    #点击加入会议按钮
    sleep    2
    click element    id=cn.butel.redmeeting:id/show_meeting_list_lin    #点击历史记录
    click element    xpath=//*[@text='30211492']
    ${meetingId}    should contain    ${Long_meeting}    30211492
    log    ${meetingId}
    click element    id=cn.butel.redmeeting:id/join_meeting_btn
    sleep    8
    click A Point    500    400    100
    sleep    2
    click element    id=cn.butel.redmeeting:id/header_tool_view_back_tv
    #Wait Until Element Is Visible    id=cn.butel.redmeeting:id/tv_leave_meeting    30
    click element    id=cn.butel.redmeeting:id/tv_leave_meeting

召开会议
    sleep    8
    Wait Until Element Is Visible    id=cn.butel.redmeeting:id/convole_metting_ly    30    #等待召开会议按钮出现
    click element    id=cn.butel.redmeeting:id/convole_metting_ly    #点击召开会议按钮
    Wait Until Element Is Visible    id=cn.butel.redmeeting:id/convene_meeting_btn    30    #等待立即召开按钮出现
    click element    id=cn.butel.redmeeting:id/convene_meeting_btn
    sleep    10
    click A Point    500    400    100
    sleep    2
    Wait Until Element Is Visible    id=cn.butel.redmeeting:id/header_tool_view_back_tv
    log    召开会议成功
    sleep    10
    click A Point    500    400    100
    sleep    2
    click element    id=cn.butel.redmeeting:id/header_tool_view_back_tv
    Wait Until Element Is Visible    id=cn.butel.redmeeting:id/tv_leave_meeting    30
    click element    id=cn.butel.redmeeting:id/tv_leave_meeting

参会者身份加入会议
    #*******************    参会列表参会者操作    *********************
    sleep    8
    click element    id=cn.butel.redmeeting:id/join_meeting_ly    #点击加入会议按钮
    sleep    2
    input text    id=cn.butel.redmeeting:id/meetingid_input_edit    ${Multi-humen}    #输入会议号
    click element    id=cn.butel.redmeeting:id/join_meeting_btn    #点击加入会议按钮
    sleep    8
    #input text    id=cn.butel.redmeeting:id/et_input_meeting_password_content    123456    #输入会议密码
    #click element    id=cn.butel.redmeeting:id/input_meeting_password_dialog_right_button    #点击确定
    #Wait Until Page Contains Element    id=cn.butel.redmeeting:id/speaker_name_tv    #登录元素是否存在，如果不存在，报错继续执行
    ${into_meeting}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/speaker_name_tv
    Run Keyword If    ${into_meeting}==True    log    进入会议成功
    ...    ELSE    log    进入会议成功
    sleep    5

参会者操作自己举手（参会者身份）
    click A Point    500    400    100    #点击屏幕
    sleep    2
    click element    id=cn.butel.redmeeting:id/meeting_room_participatorcount    #点击参会列表按钮
    sleep    4
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点击自己参会列表按钮
    click element    id=cn.butel.redmeeting:id/tv_hands_operation    #点击举手按钮
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点击自己参会列表按钮
    #Wait Until Page Contains Element    id=cn.butel.redmeeting:id/tv_hands_operation    #登录元素是否存在，如果不存在，报错继续执行
    ${PushHandsUp}    Get Text    id=cn.butel.redmeeting:id/tv_hands_operation    #获取举手按钮text
    Run Keyword If    $PushHandsUp=='手放下'    log    举手成功
    ...    ELSE    Fail    举手失败，该用例停在执行
    click element    id=cn.butel.redmeeting:id/tv_cancel    #点击取消按钮
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点击自己参会列表按钮
    click element    id=cn.butel.redmeeting:id/tv_hands_operation    #点击举手按钮
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点击自己参会列表按钮
    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/tv_hands_operation    #登录元素是否存在，如果不存在，报错继续执行
    ${PushHandsDown}    Get Text    id=cn.butel.redmeeting:id/tv_hands_operation    #获取举手按钮text
    Run Keyword If    $PushHandsDown=='举手'    log    放下手成功
    ...    ELSE    Fail    放下手失败，该用例停在执行
    click element    id=cn.butel.redmeeting:id/tv_cancel    #点击取消按钮

参会者操作自己麦克风（参会者身份）
    Judge_bounced
    sleep    2
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点自己
    click element    id=cn.butel.redmeeting:id/tv_mute_operation    #点击静音
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点自己
    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/tv_mute_operation    #登录元素是否存在，如果不存在，报错继续执行
    ${mic_mute}    Get Text    id=cn.butel.redmeeting:id/tv_mute_operation    #获取麦克风按钮字段的值
    Run Keyword If    $mic_mute == '取消静音'    log    取消静音成功
    ...    ELSE    Fail    取消静音失败
    click element    id=cn.butel.redmeeting:id/tv_cancel    #点击取消按钮
    #打开麦克风
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点自己
    click element    id=cn.butel.redmeeting:id/tv_mute_operation    #点击静音
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点自己
    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/tv_mute_operation    #登录元素是否存在，如果不存在，报错继续执行
    ${mic_open}    Get Text    id=cn.butel.redmeeting:id/tv_mute_operation    #判断静音按钮字段是否改变
    Run Keyword If    $mic_open == '静音'    log    打开麦克风成功
    ...    ELSE    Fail    打开麦克风失败
    click element    id=cn.butel.redmeeting:id/tv_cancel    #点击取消按钮

参会者操作自己摄像头（参会者身份）
    Judge_bounced
    sleep    2
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点自己
    click element    id=cn.butel.redmeeting:id/tv_video_operation    #点击打开摄像头
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点自己
    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/tv_video_operation
    ${camera_open}    Get Text    id=cn.butel.redmeeting:id/tv_video_operation    #获取摄像头按钮字段的值
    Run Keyword If    $camera_open == '关闭摄像头'    log    打开摄像头成功
    ...    ELSE    Fail    打开摄像头失败
    click element    id=cn.butel.redmeeting:id/tv_cancel    #点击取消按钮
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点自己
    click element    id=cn.butel.redmeeting:id/tv_video_operation    #点击打开摄像头
    click element    id=cn.butel.redmeeting:id/tv_master_brief    #点自己
    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/tv_video_operation
    ${camera_close}    Get Text    id=cn.butel.redmeeting:id/tv_video_operation    #获取摄像头按钮字段的值
    Run Keyword If    $camera_close == '打开摄像头'    log    关闭摄像头成功
    ...    ELSE    Fail    关闭摄像头失败
    click element    id=cn.butel.redmeeting:id/tv_cancel    #点击取消按钮
    # A Point    500    400    100

参会者操作其他人锁定视频（参会者身份）
    Judge_bounced
    sleep    2
    #click element    i=cn.butel.redmeeting:id/tv_participator_name
    click element    xpath=//*[@text='(主持人)']    #点其他参会者
    click element    id=cn.butel.redmeeting:id/tv_lock_video_operation    #点击锁定视频
    click A Point    500    400    100
    sleep    2
    click A Point    500    400    100
    ${element_exist}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/header_tool_view_cancel_video_tv
    Run Keyword If    ${element_exist}==True    log    锁定视频成功
    ...    ELSE    log    锁定视频失败
    sleep    5
    click A Point    500    400    100
    sleep    2
    click element    id=cn.butel.redmeeting:id/meeting_room_participatorcount    #点击参会列表按钮
    click element    xpath=//*[@text='(主持人)']    #点其他参会者
    click element    id=cn.butel.redmeeting:id/tv_lock_video_operation    #点击取消锁定视频
    click element    xpath=//*[@text='(主持人)']    #点其他参会者
    ${lock}    get text    id=cn.butel.redmeeting:id/tv_lock_video_operation
    Run Keyword If    $lock == '锁定视频'    log    取消锁定视频成功
    ...    ELSE    Fail    取消锁定视频失败
    click element    id=cn.butel.redmeeting:id/tv_cancel    #点击取消按钮
    click A Point    500    400    100
    exitMeeting    #退出会议

*** Keywords ***
Look_meeting_NumPeople
    #查看会议人数
    sleep    6
    click A Point    500    400    100    #点击坐标（500,400）打开菜单栏
    sleep    2
    ${meeting_NumPeople_menu}    Get Text    id=cn.butel.redmeeting:id/meeting_room_participatorcount    #获取底部菜单人数
    ${human_count_menu}    evaluate    int(${meeting_NumPeople_menu})
    click element    id=cn.butel.redmeeting:id/member_img    #点击菜单栏主持会议按钮
    ${meeting_NumPeople_list}    Get Text    id=cn.butel.redmeeting:id/tv_participator_number    #获取参会列表人数
    ${human_count_list}    evaluate    int(${meeting_NumPeople_list})
    Run Keyword If    ${human_count_menu}==${human_count_list}    log    菜单栏和参会列表人数一致，会议中真实存在有：${human_count_list}人
    ...    ELSE    log    菜单栏和参会者人数不一致，用例停止运行
    ...    AND    Fail    菜单栏参会按钮与参会列表人数不一致
    click A Point    500    400    100    #点击坐标（500,400）打开菜单栏

anchorOrhearer
    #判断是否是主持人还是参会人
    click A Point    500    400    100    #点击坐标（500,400）打开菜单栏
    sleep    6
    click A Point    500    400    100    #点击坐标（500,400）打开菜单栏
    ${meeting_list_button}    Get Text    id=cn.butel.redmeeting:id/member_hint    #获取参会列表按钮字段值
    Run Keyword If    $meeting_list_button == '主持会议'    log    你的身份为：主持人
    ...    ELSE    log    你的身份为：参会者

exitMeeting
    #退出会议
    sleep    4
    click A Point    500    400    100
    sleep    2
    click element    id=cn.butel.redmeeting:id/header_tool_view_back_tv
    click element    id=cn.butel.redmeeting:id/tv_sure    #点退出二次确认弹框
    ${element_exist}    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[@resource-id='cn.butel.redmeeting:id/nube_tv']    #获取用户名元素id
    Run Keyword If    ${element_exist}==True    log    退出会议成功
    ...    ELSE    log    退出会议失败

send_message
    #发送消息
    sleep    8
    click element    id=cn.butel.redmeeting:id/tv_send_msg_tip    #输入消息
    input text    id=cn.butel.redmeeting:id/msg_input_edit    helloworld!    #输入消息
    click element    id=cn.butel.redmeeting:id/send_msg_btn    #点击发送消息

join_meeting
    #加入会议
    sleep    8
    click element    id=cn.butel.redmeeting:id/join_meeting_ly    #点击加入会议按钮
    sleep    2
    ${joinMeeting}    Get Text    id=cn.butel.redmeeting:id/title_txt
    Should Be Equal As Strings    ${joinMeeting}    加入会议    #判断title是否是加入会议字样
    clear text    id=cn.butel.redmeeting:id/meetingid_input_edit    #点击输入框
    input text    id=cn.butel.redmeeting:id/meetingid_input_edit    30255665    #输入会议号
    click element    id=cn.butel.redmeeting:id/join_meeting_btn    #点击加入会议按钮加入会议

Judge_bounced
    #判断参会列表取消按钮是否存在
    ${Judge_bounced}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/tv_cancel
    Run Keyword If    ${Judge_bounced}==True    click element    id=cn.butel.redmeeting:id/tv_cancel
    ...    ELSE    log    参会列表没有取消按钮，继续执行

Judge_drivingPattern
    ${Judge_drivingPattern}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/bottomTV
    Run Keyword If    ${Judge_drivingPattern}==True    click element    id=cn.butel.redmeeting:id/second_dot
    ...    ELSE    log    驾驶模式操作麦克风通过，继续执行下一条用例
