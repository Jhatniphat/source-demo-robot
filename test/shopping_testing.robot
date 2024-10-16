*** Settings ***
Library        SeleniumLibrary
Suite Teardown    Close All Browsers
Resource    ../resource/login.resource
Resource    ../resource/inventory.resource
Resource    ../resource/shopping.resource
Test Teardown    Close All Browsers


*** Variables ***
${URL}        https://www.saucedemo.com
${username}    standard_user

*** Test Cases ***
Add All Product And Check Shopping Cart
    Login User    ${username}
    Add To Cart    Sauce Labs Backpack
    Add To Cart    Sauce Labs Bike Light
    Add To Cart    Sauce Labs Bolt T-Shirt
    Add To Cart    Sauce Labs Fleece Jacket
    Add To Cart    Sauce Labs Onesie
    Add To Cart    Test.allTheThings() T-Shirt (Red)
    Enter Shoping Cart
    Shopping Cart Count Should Be    6
    Shopping Cart Should Have    Sauce Labs Backpack  
    ...    carry.allTheThings() with the sleek, streamlined Sly Pack that melds uncompromising style with unequaled laptop and tablet protection.
    ...    29.99
    Shopping Cart Should Have    Sauce Labs Bike Light
    ...    A red light isn't the desired state in testing but it sure helps when riding your bike at night. Water-resistant with 3 lighting modes, 1 AAA battery included.
    ...    9.99
    Shopping Cart Should Have    Sauce Labs Bolt T-Shirt
    ...    Get your testing superhero on with the Sauce Labs bolt T-shirt. From American Apparel, 100% ringspun combed cotton, heather gray with red bolt.
    ...    15.99
    Shopping Cart Should Have    Sauce Labs Fleece Jacket
    ...    It's not every day that you come across a midweight quarter-zip fleece jacket capable of handling everything from a relaxing day outdoors to a busy day at the office.
    ...    49.99
    Shopping Cart Should Have    Sauce Labs Onesie
    ...    Rib snap infant onesie for the junior automation engineer in development. Reinforced 3-snap bottom closure, two-needle hemmed sleeved and bottom won't unravel.
    ...    7.99
    Shopping Cart Should Have    Test.allTheThings() T-Shirt (Red)
    ...    This classic Sauce Labs t-shirt is perfect to wear when cozying up to your keyboard to automate a few tests. Super-soft and comfy ringspun combed cotton.
    ...    15.99

Visit Shopping Cart and return to inventory
    Login User    ${username}
    Enter Shoping Cart
    Continue Shopping

Delete Product in Shopping Cart
    Login User    ${username}
    Add To Cart    Sauce Labs Backpack
    Add To Cart    Sauce Labs Bike Light
    Add To Cart    Sauce Labs Bolt T-Shirt
    Add To Cart    Sauce Labs Fleece Jacket
    Add To Cart    Sauce Labs Onesie
    Add To Cart    Test.allTheThings() T-Shirt (Red)
    Enter Shoping Cart
    Shopping Cart Count Should Be    6
    Remove Product From Shopping Cart    Sauce Labs Backpack
    Shopping Cart Count Should Be    5
    Remove Product From Shopping Cart    Sauce Labs Bike Light
    Shopping Cart Count Should Be    4
    Remove Product From Shopping Cart    Sauce Labs Bolt T-Shirt
    Shopping Cart Count Should Be    3
    Remove Product From Shopping Cart    Sauce Labs Fleece Jacket
    Shopping Cart Count Should Be    2
    Remove Product From Shopping Cart    Sauce Labs Onesie
    Shopping Cart Count Should Be    1
    Remove Product From Shopping Cart    Test.allTheThings() T-Shirt (Red)
    Shopping Cart Count Should Be    0
    