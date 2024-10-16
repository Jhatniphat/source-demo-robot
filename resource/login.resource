*** Settings ***
Documentation     This is a resource file, that can contain variables and keywords.
...               Keywords defined here can be used where this Keywords.resource in loaded.
Library           SeleniumLibrary


*** Variables ***
${URL}    https://www.saucedemo.com

*** Keywords ***
Open Website
    Open Browser    ${URL}    browser=chrome
    Maximize Browser Window

Login User
    [Arguments]    ${username}    ${password}=secret_sauce
    [Documentation]    Login with user
    Open Browser    ${URL}    browser=ff
    Input Text    id:user-name    ${username}
    Input Password    id:password    ${password}
    Click Button    id:login-button

Error Text Contain
    [Arguments]    ${error_text}
    Element Should Contain    xpath://*[@data-test="error"]    ${error_text}