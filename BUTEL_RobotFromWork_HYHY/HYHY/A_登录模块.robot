*** Settings ***
Suite Setup       打开应用
Library           AppiumLibrary
Resource          调用.robot
Library           MyTestLibrary

*** Variables ***
${userid}         18914791123
${passwd}         Test2021
#${userid}        15500010056
#${passwd}        123456
${meetingid}      30211492
${video_id}       40000048    # 视讯号

*** Test Cases ***
欢迎页&&登录
    sleep    8
    #判断异常退出弹框是否存在，存在则点取消判断主页是否存在异常退会弹框
    Abnormal_pop_judgment
    sleep    2
    ${agreement}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/consent_tv
    ${nicktv}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/nube_tv
    Run Keyword If    ${agreement}==False and ${nicktv}==False    run keywords    Wait Until Element Is Visible    id=cn.butel.redmeeting:id/login_btn
    ...    AND    log    无隐私弹框也未登录，需要进行登录
    ...    AND    Login
    ...    ELSE IF    ${agreement}==False and ${nicktv}==True    log    无隐私弹框，已登录，不需要进行登录
    ...    ELSE IF    ${agreement}==True    run keywords    click element    id=cn.butel.redmeeting:id/consent_tv
    ...    AND    log    存在隐私协议，点击同意
    ...    AND    log    有隐私弹框&&未登录，需要进行登录
    ...    AND    Login
    ...    ELSE    log    以上场景都不符合

退出登录
    sleep    8
    ${head_page}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/head_iv
    Run Keyword If    ${head_page}    log    进入主页成功
    ...    ELSE    log    没有进入主页
    sleep    8
    Abnormal_pop_judgment
    click element    id=cn.butel.redmeeting:id/head_iv    #点击头像
    click element    id=cn.butel.redmeeting:id/btn_logout    #点击退出按钮
    click element    id=cn.butel.redmeeting:id/dy_tv    #点击退出登录
    click element    id=cn.butel.redmeeting:id/btn_right    #退出登录弹框
    ${login_btn}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/login_btn
    Run Keyword If    ${login_btn}==True    log    退出登录成功
    ...    ELSE    log    退出登录失败    #点击头像

启动页加入会议
    sleep    8
    click element    id=cn.butel.redmeeting:id/back_btn    #点击右上角返回
    #Wait Until Element Is Visible    xpath=//*[@resource-id='cn.butel.redmeeting:id/join_meeting_btn']    20    #等待加入会议按钮
    #click element    xpath=//*[@resource-id='cn.butel.redmeeting:id/join_meeting_btn']    #点击加入会按钮
    click element    id=cn.butel.redmeeting:id/join_meeting_btn
    sleep    2
    ${joinMeeting}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/title_txt
    Run Keyword If    ${joinMeeting}==True    log    已经在加入会议页面
    ...    ELSE    log    未在加入会议页面    #点击头像
    input text    id=cn.butel.redmeeting:id/meetingid_input_edit    ${meetingid}    #输入会议号
    click element    id=cn.butel.redmeeting:id/join_meeting_btn    #点击加入会议
    Login
    sleep    10
    click A Point    500    400    100    #点击坐标（500,400）
    sleep    1
    click element    id=cn.butel.redmeeting:id/header_tool_view_back_tv
    sleep    1
    #click element    id=cn.butel.redmeeting:id/tv_sure
    click element    id=cn.butel.redmeeting:id/tv_leave_meeting

查看手机网络状态
    ${Attribute}    Get Network Connection Status    #查看网络状态
    log    ${Attribute}

不同意隐私政策，不可使用app
    sleep    8
    click element    id=cn.butel.redmeeting:id/head_iv    #点头像
    click element    id=cn.butel.redmeeting:id/btn_logout    #点退出按钮
    click element    id=cn.butel.redmeeting:id/reset_app_tv
    click element    id=cn.butel.redmeeting:id/btn_right
    sleep    5
    打开应用
    sleep    10
    ${agreement}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/consent_tv
    Run Keyword If    ${agreement}==True    click element    id=cn.butel.redmeeting:id/disagree_tv
    ...    ELSE    Fail    重置应用后，不存在隐私弹框，本条用例视为缺陷
    sleep    5
    打开应用
    sleep    10
    click element    id=cn.butel.redmeeting:id/consent_tv
    #click element    id=cn.butel.redmeeting:id/login_or_register_btn
    Login

*** Keywords ***
Login
    sleep    8
    ${Judge_pop}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/login_or_register_btn
    Run Keyword If    ${Judge_pop}==True    click element    id=cn.butel.redmeeting:id/login_or_register_btn
    ...    ELSE    log    目前不在欢迎页
    clear text    id=cn.butel.redmeeting:id/login_num_ed
    input text    id=cn.butel.redmeeting:id/login_num_ed    ${userid}    #输入账号
    input password    id=cn.butel.redmeeting:id/login_pwd_ed    ${passwd}    #输入密码
    click A Point    500    400    100
    sleep    4
    click element    id=cn.butel.redmeeting:id/login_btn    #点击登录按钮
    sleep    8
    #Wait Until Element Is Visible    id=cn.butel.redmeeting:id/nube_tv    30    #等待用户昵称出现
    ${head_page}    Run Keyword And Return Status    Wait Until Page Contains Element    id=cn.butel.redmeeting:id/speaker_name_tv
    Run Keyword If    ${head_page}    log    登录成功
    ...    ELSE    log    登录失败
    sleep    8

Abnormal_pop_judgment
    #判断异常退出弹框是否存在，存在则点取消
    #sleep    8    #等待启动app，加载到主页
    ${pop_judgment}    Run Keyword And Return Status    Wait Until Page Contains Element    cn.butel.redmeeting:id/tv_content    #判断弹框元素是否存在
    Run Keyword If    ${pop_judgment}    run keywords    log    弹框存在
    ...    AND    click element    id=cn.butel.redmeeting:id/btn_left
    ...    ELSE    log    弹框不存在，继续执行
