# Dapp_Marketplace Deployed on Remix IDE

This is my ABCD/Emurgo Project. A marketplace smart contract.
This decentralized marketplace, anyone can add a product and get paid when someone else buys the product. This marketplace has its own unique token that is required to pay for products.

## Developement Features
1. Develop a unique token
2. You can check the account balance
3. Buyers must own the token to be able to pay for the product
4. Sellers can add products and receive payment when their product is purchased
5. You can get a particular product full details and see how many times the product have been sold
6. Buyers can check a particular product owner
7. You can see the total product in the market

## Product Details
Each product that would be added to the market place must have;
1. The address of the owner (seller)
2. A name of the product
3. A description for the product
4. Price of the product
5. Quantity of the product

---

## Deploying the Smart Contract
- First, Copy and paste the code into the Remix IDE
- Compile with **solidity version 0.8.7** and if the compilation is succesful
- Deploy the **MyToken contract** using the JVM Enviroment and add the inital amount of the token you want to mint
- Then deploy the **Marketplace contract** and copy the MyToken Contract Address and replace the `address internal MTPtoken`

---

## Interacting with the Smart Contract
- After deploying the **MyToken Contract** with the first address
  - Transfer some of the token to another address `probably the second account`
  - If you minted 1000 tokens for instance, you can transfer 300 to the second account
- Go to the Deployed Marketplace contract
  - Use another different account that do not have any token `probably the 5th account`
  - Add a new product, with the required fields and click transact
  - Switch the accout to the second account *That is, the account you transfered 300 token to*
  - Then, go back to the Marketplace contract. Add the product ID that you want to buy and click **BuyProduct**
- If you recieve an error - ERC20 Token allowance exceeded
  - copy the marketplace contract address
  - Go back to the MyToken contract, in the approval function....
  - Paste the Marketplace contract address and allocate like 800 of the token into the amount and click approve.
  - Go back to the Marketplace contract after the approval has been successful and now click `buyProduct`
  - If successful, go back to the *MyToken contract* in the balance function paste the address of the *5th account* which is the account we used to add the product
  - Click balance, you will see the price of the product will be added.
  - It will be transfered from the *2nd account that has the initial 300* to the *5th account that added the product*
  - Now, check the balance of the *2nd account* the amount of the product would be deducted if you followed the steps successfully.

---

## Marketplace Functions
- You can add a new product with the `addProduct`
  - Fill in the required data
- You can `buyProduct` by adding the index/id of the product
  - If the index/id you entered is not available, you will recieve a `custom error` telling you that the product is not available
- You can get a single product details with the `getProduct`
  - Enter the index/id of the product to get more details about the product
  - If the index/id you entered is not available, you will recieve a `custom error` telling you the product is not available
- You can also see the **Owner** of a particular product with the `getProductOwner`
  - Enter the index/id of the product and the `address` of the ownwe will be returned
- You can also see how many products is in the **Marketplace** with the `productLength`
  - When you click on the `productLength` the total number of products in the marketplace is returned

---

### Notice
Any confusion, feel free to let me know
