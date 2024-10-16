*** Settings ***
Library        SeleniumLibrary
Suite Teardown    Close All Browsers
Resource    ../resource/login.resource
Test Teardown    Close All Browsers


*** Variables ***
${URL}        https://www.saucedemo.com

*** Test Cases ***
Valid Login
    Login User    standard_user    secret_sauce
    Location Should Contain    inventory
    Wait Until Element Is Visible    class:inventory_item    5s

locked_out User Login
    Login User    locked_out_user    secret_sauce
    Error Text Contain    Sorry, this user has been locked out.

Ploblem User Login
    Login User    problem_user    secret_sauce
    Location Should Contain    inventory
    Wait Until Element Is Visible    class:inventory_item    5s

performance_glitch_user Login
    Login User    performance_glitch_user    secret_sauce
    Location Should Contain    inventory
    Wait Until Element Is Visible    class:inventory_item    5s

invalid password Login
    [Documentation]    try with standard_user
    Login User    standard_user    blablabla
    Error Text Contain    Username and password do not match any user in this service

Invalid username Login
    [Documentation]    try with blabla user
    Login User    blablabla    secret_sauce
    Error Text Contain    Username and password do not match any user in this service

Invalid uername and password Login
    [Documentation]    try with blabla , asda;sld
    Login User     blabla    asda;sld
    Error Text Contain    Username and password do not match any user in this service

Username is Empty
    [Documentation]    not fill username then submit form
    Login User    username=    password=secret_sauce
    Error Text Contain    Username is required

Password is Empty
    [Documentation]    not fill password then submit form
    Login User    username=standard_user    password=
    Error Text Contain    Password is required

Username & Password is Empty
    [Documentation]    not fil username & password then sunmit form
    Login User    username=    password=
    Error Text Contain    is required
