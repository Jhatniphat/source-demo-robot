*** Settings ***
Library        SeleniumLibrary
Suite Teardown    Close All Browsers
Test Teardown    Close All Browsers
Resource    ../resource/login.resource
Resource    ../resource/inventory.resource
Resource    ../resource/shopping.resource
Resource    ../resource/checkout.resource
Documentation    This testing made 

*** Variables ***
# ? Common Variable
${URL}        https://www.saucedemo.com
${username}    standard_user
# ? List Variable
@{product_list}    Sauce Labs Backpack    Sauce Labs Bike Light    Sauce Labs Bolt T-Shirt    Sauce Labs Fleece Jacket    Sauce Labs Onesie    Test.allTheThings() T-Shirt (Red)

*** Test Cases ***
Checkout View Should Have item 
    Login User    ${username}
    Add To Cart    Sauce Labs Backpack
    Enter Shoping Cart
    Shopping Cart Should Have    Sauce Labs Backpack
    Shopping Cart Count Should Be    1
    Go To Checkout
    Enter Checkout Information    Somchai    Jaidee    99999
    Checkout Overview Should Have    Sauce Labs Backpack  
    ...    carry.allTheThings() with the sleek, streamlined Sly Pack that melds uncompromising style with unequaled laptop and tablet protection.
    ...    29.99
    Finish Checkout
    
Every Product Can Order
    FOR  ${product}  IN  @{product_list}
        Login User    ${username}
        Add To Cart    ${product}
        Enter Shoping Cart
        Shopping Cart Should Have    Sauce Labs Backpack
        Shopping Cart Count Should Be    1
        Go To Checkout
        Enter Checkout Information    Somchai    Jaidee    99999
        Checkout Overview Should Have    Sauce Labs Backpack  
        Finish Checkout
        Close Browser
    END
    