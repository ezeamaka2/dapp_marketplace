// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("Marketplace Token", "MPT")  {
        super._mint(msg.sender, initialSupply);
    }
}


contract Marketplace{
    
    struct Product{
        address payable owner;
        string name;
        string description;
        uint price;
        uint quantity;
        uint sold;
    }
    
    
    mapping(uint => Product) internal products;
    
    // Events
    event AddProduct(address prodOwner, string name, uint amount, uint quantity, uint totalProductsAvail);
    event BuyProduct(address buyers, address seller, uint price, bool success);
    
    
    // MyToken Contract address
    address internal MTPtoken = 0x3643b7a9F6338115159a4D3a2cc678C99aD657aa;
    
    uint totalProducts;
    
    
    // Add a new product function
    function addProduct(string memory _name, string memory _desc, uint _price, uint _qty) public {
        uint sold = 0;
        totalProducts = totalProducts + 1;
        products[totalProducts] = Product(payable(msg.sender), _name, _desc, _price, _qty, sold);
        
        emit AddProduct(msg.sender, _name, _price, _qty, totalProducts);
    }
    
    // Custom error
    error productNotAvailable (uint requested, uint total);
    
    // Get a partivular product details
    function getProduct(uint _index) public view returns(string memory, string memory, uint, uint, uint) {
        if(_index > totalProducts){
            revert productNotAvailable ({
                requested: _index,
                total: totalProducts
            });
        }
        
        return (
            products[_index].name,
            products[_index].description,
            products[_index].price,
            products[_index].quantity,
            products[_index].sold
            );
    }

   
//   Buy a product function
    function buyProduct(uint _index) public payable  {
        MyToken testToken = MyToken(MTPtoken);
        uint price = products[_index].price;
        
        if(_index > totalProducts){
            revert productNotAvailable ({
                requested: _index,
                total: totalProducts
            });
        }
        
        require(testToken.balanceOf(msg.sender) > price, "You have insufficient balance");
        require(
          testToken.transferFrom(
            msg.sender,
            products[_index].owner,
            price
          ),
          "Transfer failed."
        );
        
        // if succesful, emit the event with bool:true
        emit BuyProduct(msg.sender, products[_index].owner, price, true);
        products[_index].sold++;
        products[_index].quantity--;
    }
    
    
    // Function to get a particular product owner
    function getProductOwner(uint _index) public view returns(address){
        return products[_index].owner;
    }
    
    
    // Function to get the total product available in the store
    function productLength() public view returns(uint){
        return totalProducts;
    }
    
}
