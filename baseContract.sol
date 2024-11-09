// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProjectContract {
    struct Item {
        uint itemId;
        address owner;
        uint price;
        bool available;
        uint highestBid;
        address highestBidder;
    }

    address[16] public owners;
    uint[] public itemIds;
    mapping(uint => Item) public items;

    event ItemListed(uint itemId, address owner, uint price);
    event ItemBought(uint itemId, address buyer, uint price);
    event BidPlaced(uint itemId, address bidder, uint amount);
    event AuctionStarted(uint itemId);
    event AuctionEnded(uint itemId, address winner, uint highestBid);

    function setListing(uint itemId, uint price) public {
        require(price > 0, "Price must be greater than zero");
        items[itemId] = Item({
            itemId: itemId,
            owner: msg.sender,
            price: price,
            available: true,
            highestBid: 0,
            highestBidder: address(0)
        });
        itemIds.push(itemId);
        owners[itemId] = msg.sender;
        emit ItemListed(itemId, msg.sender, price);
    }

    function buyItem(uint itemId) public payable {
        require(items[itemId].available, "Item not available for sale");
        require(msg.value >= items[itemId].price, "Insufficient funds");

        // Transfer ownership of the item and update state
        payable(items[itemId].owner).transfer(msg.value);
        items[itemId].owner = msg.sender;
        items[itemId].available = false;
        owners[itemId] = msg.sender;

        emit ItemBought(itemId, msg.sender, msg.value);
    }

    function setBid(uint itemId) public payable {
        require(items[itemId].available, "Item not available for bidding");
        require(msg.value > items[itemId].highestBid, "Bid must be higher than the current highest bid");

        // Refund the previous highest bidder
        if (items[itemId].highestBid != 0) {
            payable(items[itemId].highestBidder).transfer(items[itemId].highestBid);
        }

        items[itemId].highestBid = msg.value;
        items[itemId].highestBidder = msg.sender;

        emit BidPlaced(itemId, msg.sender, msg.value);
    }

    function startAuction(uint itemId) public {
        require(items[itemId].owner == msg.sender, "Only the owner can start the auction");
        items[itemId].available = true;
        emit AuctionStarted(itemId);
    }

    function endAuction(uint itemId) public {
        require(items[itemId].owner == msg.sender, "Only the owner can end the auction");
        require(items[itemId].highestBidder != address(0), "No bids received");

        // Transfer ownership to highest bidder
        items[itemId].owner = items[itemId].highestBidder;
        items[itemId].available = false;
        owners[itemId] = items[itemId].highestBidder;

        // Pay the seller
        payable(msg.sender).transfer(items[itemId].highestBid);

        emit AuctionEnded(itemId, items[itemId].highestBidder, items[itemId].highestBid);
    }

    function getOwners() public view returns (address[16] memory) {
        return owners;
    }

    function getListing(uint itemId) public view returns (Item memory) {
        require(items[itemId].owner != address(0), "Item does not exist");
        return items[itemId];
    }

    function getAvailability(uint itemId) public view returns (bool) {
        return items[itemId].available;
    }

    function setAvailability(uint itemId, bool status) public {
        require(items[itemId].owner == msg.sender, "Only the owner can change availability");
        items[itemId].available = status;
    }

    function getBuyer(uint itemId) public view returns (address) {
        return items[itemId].highestBidder;
    }

    function setBuyer(uint itemId, address newBuyer) public {
        require(items[itemId].owner == msg.sender, "Only the owner can set a buyer");
        items[itemId].highestBidder = newBuyer;
    }

    function getBid(uint itemId) public view returns (uint) {
        return items[itemId].highestBid;
    }

    function verifyListing(uint itemId) public view returns (bool) {
        return items[itemId].owner != address(0);
    }

    function verifyBuyer(uint itemId, address buyer) public view returns (bool) {
        return items[itemId].highestBidder == buyer;
    }

    function verifySeller(uint itemId, address seller) public view returns (bool) {
        return items[itemId].owner == seller;
    }
}
