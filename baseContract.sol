// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract projectContract {
    //make itemIDs a seperate file that map to different items based on addresses?
    //assume we have an array of itemIds consisting

    address[16] public owners;
    address[] public itemIds;
    
    function buyItem(uint itemId) public payable returns (uint) {
        require(itemId >= 0 && itemId <= 15);
        owners[itemId] = msg.sender;
        return itemId;
    }

    // Retrieving the adopters
    function getOwners() public view returns (address[16] memory) {
        return owners;
    }

    function setListing(address newItemId) public { //add the newest itemId to the itemId list
        
    }

    function getListing() public returns (int){
        return 0;
    }

    function setAvailability() public {

    }

    function getAvailability() public {

    }

    function setBuyer() public {
        
    }

    function getBuyer() public {
        
    }

    function setBid() public {

    }
    
    function getBid() public {

    }

    function startAuction() public {

    }

    function endAuction() public {

    }

    function verifyListing() public {

    }

    function verifyBuyer() public {

    }

    function verifySeller() public {

    }
}