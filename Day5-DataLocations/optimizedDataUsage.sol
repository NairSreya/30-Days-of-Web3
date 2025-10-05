// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OptimizedDataUsage {
    struct Product {
        string name;
        uint256 price;
        uint256 stock;
    }
    
    mapping(uint256 => Product) public products;
    uint256 public productCount;
    
    function addProductUnoptimized(string memory name, uint256 price, uint256 stock) public {
        products[productCount] = Product(name, price, stock);
        productCount++;
    }
    
    function addProductOptimized(string calldata name, uint256 price, uint256 stock) public {
        products[productCount] = Product(name, price, stock);
        productCount++;
    }
    
    function updatePriceUnoptimized(uint256 id, uint256 newPrice) public {
        Product memory product = products[id];
        product.price = newPrice;
        products[id] = product;
    }
    
    function updatePriceOptimized(uint256 id, uint256 newPrice) public {
        products[id].price = newPrice;
    }
    
    function calculateTotalUnoptimized(uint256[] memory ids) public view returns (uint256) {
        uint256 total = 0;
        for (uint256 i = 0; i < ids.length; i++) {
            Product memory product = products[ids[i]];
            total += product.price * product.stock;
        }
        return total;
    }
    
    function calculateTotalOptimized(uint256[] calldata ids) public view returns (uint256) {
        uint256 total = 0;
        for (uint256 i = 0; i < ids.length; i++) {
            Product storage product = products[ids[i]];
            total += product.price * product.stock;
        }
        return total;
    }
    
    function processOrderUnoptimized(uint256[] memory productIds, uint256[] memory quantities) 
        public 
        pure 
        returns (uint256) 
    {
        uint256 total = 0;
        for (uint256 i = 0; i < productIds.length; i++) {
            total += productIds[i] * quantities[i];
        }
        return total;
    }
    
    function processOrderOptimized(uint256[] calldata productIds, uint256[] calldata quantities) 
        public 
        pure 
        returns (uint256) 
    {
        uint256 total = 0;
        uint256 length = productIds.length;
        for (uint256 i = 0; i < length; i++) {
            total += productIds[i] * quantities[i];
        }
        return total;
    }
    
    function batchUpdateUnoptimized(uint256[] memory ids, uint256[] memory prices) public {
        for (uint256 i = 0; i < ids.length; i++) {
            Product memory product = products[ids[i]];
            product.price = prices[i];
            products[ids[i]] = product;
        }
    }
    
    function batchUpdateOptimized(uint256[] calldata ids, uint256[] calldata prices) public {
        uint256 length = ids.length;
        for (uint256 i = 0; i < length; i++) {
            products[ids[i]].price = prices[i];
        }
    }
    
    function getProductInfo(uint256 id) public view returns (string memory, uint256, uint256) {
        Product storage product = products[id];
        return (product.name, product.price, product.stock);
    }
}