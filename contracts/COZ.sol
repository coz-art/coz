// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./NonFungibleToken.sol";
import "./interfaces/ICOZ.sol";

contract COZ is Ownable, NonFungibleToken, ICOZ {

    uint256 public mintFee = 0.03 ether;
    
    struct COZData {
        uint256[] parents;
        string code;
    }
    COZData[] public cozz;

    constructor() NonFungibleToken("COZ", "COZ", "1") {}

    function setMintFee(uint256 fee) onlyOwner external {
        mintFee = fee;
    }

    function mint(uint256[] memory parents, string memory code) payable external override returns (uint256 id) {
        
        id = cozz.length;

        uint256 length = parents.length;
        for (uint256 i = 0; i < length; i += 1) {
            uint256 parent = parents[i];
            require(parent < id && _exists(parent) == true);
        }

        cozz.push(
            COZData({
                parents: parents,
                code: code
            })
        );

        _mint(msg.sender, id);

        payable(owner()).transfer(mintFee);
    }
}
