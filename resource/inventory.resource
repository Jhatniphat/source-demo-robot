*** Settings ***
Documentation     This is a resource file, that can contain variables and keywords.
...               Keywords defined here can be used where this Keywords.resource in loaded.
Library           SeleniumLibrary
Resource          keyword.resource

*** Variables ***
${URL}    https://www.saucedemo.com
${product_name_xpath}    xpath=//div[@data-test='inventory_item_name']
${price_name_xpath}    xpath=//div[@data-test='inventory-item-price']

*** Keywords ***
Add To Cart
    [Arguments]    ${product_name}
    Click Button    xpath=//div[.//div[@data-test='inventory-item-name' and text()='${product_name}']]//button[text()='Add to cart']

Shopping Cart Count Should Be
    [Arguments]    ${count}
    IF  $count == "0"
        Element Should Not Be Visible    class:shopping_cart_badge
    ELSE
        Wait Until Element Is Visible    class:shopping_cart_badge    5s
        Element Text Should Be    class:shopping_cart_badge    ${count}
    END

View Product Detail
    [Arguments]    ${product_name}    ${product_desc}=null    ${product_price}=null    ${should_click_Add_To_Cart}=${False}
    Click Element    xpath=//div[@data-test='inventory-item-name' and text()='${product_name}']
    Element Text Should Be    class:inventory_details_name    ${product_name}
    IF    $product_desc != "null"
        Element Text Should Be    class:inventory_details_desc    ${product_desc}
    END
    IF    $product_price != "null"
        Element Should Contain    class:inventory_details_price    ${product_price}
    END
    Element Should Be Visible    xpath=//button[text()='Add to cart']
    IF  $should_click_Add_To_Cart == $True
        Click Button    xpath=//button[text()='Add to cart']
    END
    
Exit Product Detail
    Click Button    xpath=//button[@data-test='back-to-products']
    
Sort Product By
    [Arguments]    ${sort_by}=az
    [Documentation]    Name (A to Z) = az , 
    ...    Name (Z to A) = za , 
    ...    Price (low to high) = lohi , 
    ...    Price (high to low) = hilo
    
    Click Element    xpath=//select[@data-test='product-sort-container']
    Click Element    xpath=//select[@data-test='product-sort-container']//option[@value='${sort_by}']

    # ? check sort by NAME 
    IF  $sort_by == "az" or $sort_by == "za"
        ${names}=    Get List Of Elements Texts    ${product_name_xpath}
        IF  $sort_by == 'az'
            ${sorted_names}=    Evaluate    sorted(${names})
        ELSE
            ${sorted_names}=    Evaluate    sorted(${names} , reverse=True)
        END
        Should Be Equal    ${names}    ${sorted_names}
    END
    
    # ? check sort by PRICE
    IF  $sort_by == "lohi" or $sort_by == "hilo"
        ${prices}=    Get List Of Elements Texts    ${product_name_xpath}
        ${prices}=    Convert Texts To Integers    ${prices}
        IF  $sort_by == 'lohi'
            ${sorted_prices}=    Evaluate    sorted(${prices})
        ELSE
            ${sorted_prices}=    Evaluate    sorted(${prices} , reverse=True)
        END
        Should Be Equal    ${prices}    ${sorted_prices}
    END
    
