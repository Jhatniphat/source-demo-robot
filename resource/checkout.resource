*** Settings ***
Documentation     This is a resource file, that can contain variables and keywords.
...               Keywords defined here can be used where this Keywords.resource in loaded.
Library    SeleniumLibrary
Library    Collections


*** Keywords ***
Enter Checkout Information
    [Documentation]    use in checkout-step-one
    ...    enter form by using 3 argument
    ...    `first_name` , `last_name` , `postal_code`
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Input Text    id=first-name    ${first_name}
    Input Text    id=last-name    ${last_name}
    Input Text    id=postal-code    ${postal_code}
    Click Button    id:continue

Go To Checkout
    [Documentation]    use in shopping cart page
    ...    Go to checkout page
    Click Button    id=checkout

Checkout Overview Should Have
    [Arguments]    ${product_name}    ${product_desc}=null    ${product_price}=null
    Element Should Be Visible    xpath=//div[@data-test='inventory-item-name' and text()='${product_name}']
    ${product_item}=    Set Variable    //div[@class='inventory_item_name' and text()='${product_name}']/ancestor::div[@class='cart_item']
    IF    $product_desc != "null"
        Element Should Contain    xpath=${product_item}//div[@class='inventory_item_desc']    ${product_desc}
    END
    IF    $product_price != "null"
        Element Should Contain    xpath=${product_item}//div[@data-test='inventory-item-price']    ${product_price}
    END

Finish Checkout
    Click Button    id=finish
    Page Should Contain    Thank you for your order!
    Page Should Contain    Your order has been dispatched, and will arrive just as fast as the pony can get there!
    
    
    