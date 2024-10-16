*** Settings ***
Library        SeleniumLibrary
Suite Teardown    Close All Browsers
Resource    ../resource/login.resource
Resource    ../resource/inventory.resource

*** Variables ***
${URL}        https://www.saucedemo.com
${username}    standard_user

*** Test Cases ***
# Get Product By Product Name
Add Product To Cart
    Login User    ${username}
    Add To Cart    Sauce Labs Backpack
    Shopping Cart Count Should Be    1

View Product Detail
    Login User    ${username}
    View Product Detail    product_name=Sauce Labs Backpack    
    ...    product_desc=carry.allTheThings() with the sleek, streamlined Sly Pack that melds uncompromising style with unequaled laptop and tablet protection.    
    ...    product_price=29.99

Add To Cart In Product Detail
    [Documentation]    Product Detail Can Be View and Can add to cart
    Login User    ${username}
    View Product Detail    product_name=Sauce Labs Backpack
    ...        should_click_Add_To_Cart=${True}

Product Detail Can Exit
    [Documentation]    go to product detail then exit
    Login User    ${username}
    View Product Detail    product_name=Sauce Labs Backpack 
    Exit Product Detail
    Wait Until Location Does Not Contain    inventory-item    5s

Add Product & Check Shopping Cart Count
    [Documentation]    Add To Cart In Product Detail & Check Shopping Cart Count
    Login User    ${username}
    View Product Detail    product_name=Sauce Labs Backpack    should_click_Add_To_Cart=${True}
    Shopping Cart Count Should Be    1
    Exit Product Detail
    Shopping Cart Count Should Be    1
    Add To Cart    Sauce Labs Onesie
    Shopping Cart Count Should Be    2

ALl Sort Should Working
    Login User    ${username}
    Sort Product By    az
    Sleep    2s
    Sort Product By    za
    Sleep    2s
    Sort Product By    lohi
    Sleep    2s
    Sort Product By    hilo
    Sleep    2s
    