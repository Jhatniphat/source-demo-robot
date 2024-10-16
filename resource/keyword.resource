*** Settings ***
Library    SeleniumLibrary
Library    Collections


*** Keywords ***
Get List Of Elements Texts
    [Arguments]    ${xpath}
    ${elements}=    Get WebElements    ${xpath}
    ${texts}=    Create List
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        Append To List    ${texts}    ${text}
    END
    Return From Keyword    ${texts}

Convert Texts To Integers
    [Arguments]    ${texts}
    ${int_list}=    Create List
    FOR    ${text}    IN    @{texts}
        ${int}=    Evaluate    int(${text})
        Append To List    ${int_list}    ${int}
    END
    Return From Keyword    ${int_list}