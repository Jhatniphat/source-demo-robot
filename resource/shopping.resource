*** Settings ***
Documentation     This is a resource file, that can contain variables and keywords.
...               Keywords defined here can be used where this Keywords.resource in loaded.
Library           SeleniumLibrary


*** Variables ***
${URL}    https://www.saucedemo.com

*** Keywords ***
Enter Shoping Cart
    Click Element    xpath=//a[@data-test='shopping-cart-link']

Shopping Cart Should Have
    [Arguments]    ${product_name}    ${product_desc}=null    ${product_price}=null
    Element Should Be Visible    xpath=//div[@data-test='inventory-item-name' and text()='${product_name}']
    ${product_item}=    Set Variable    //div[@class='inventory_item_name' and text()='${product_name}']/ancestor::div[@class='cart_item']
    IF    $product_desc != "null"
        Element Should Contain    xpath=${product_item}//div[@class='inventory_item_desc']    ${product_desc}
    END
    IF    $product_price != "null"
        Element Should Contain    xpath=${product_item}//div[@data-test='inventory-item-price']    ${product_price}
    END

Remove Product From Shopping Cart
    [Arguments]    ${product_name}
    Click Button    xpath=//div[@data-test='inventory-item-name' and text()='${product_name}']/ancestor::div[@class='cart_item']//button

Continue Shopping
    Click Button    id=continue-shopping

