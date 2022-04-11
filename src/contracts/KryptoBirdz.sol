//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import './ERC721Connector.sol';
contract KryptoBirdz is ERC721Connector
{
    //array to store our nfts
    string [] public KryptoBird;
    mapping(string => bool) kryptobirdexist;

    function mint(string memory kryptobird) public{
       // uint _id=KryptoBird.push(kryptobird);
       require(!kryptobirdexist[kryptobird],'Error kryptobird already exists');
       //.push does not return length but reference to the added element
       KryptoBird.push(kryptobird);
       uint _id=KryptoBird.length-1;

        _mint(msg.sender,_id);

        kryptobirdexist[kryptobird]=true;
    }


    constructor() ERC721Connector('KryptoBird','KBIRDZ')
    {

    }
}