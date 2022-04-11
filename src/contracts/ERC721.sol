//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import './ERC165.sol';
import './interfaces/IERC721.sol';
import './libraries/Counters.sol';
/*a nft to point to address
b:keep track of token id
c:keep track of token owner address to token ids
d:keep track of how many tokens an owner address has
e:create event that emits transfer log-contract address,where it is minting to
*/
contract ERC721 is ERC165,IERC721
{
    using SafeMath for uint;
    using Counters for Counters.Counter;

  //  event Transfer(address indexed from,address indexed to,uint indexed tokenId);
    event Approval(address indexed owner,address indexed approved,uint indexed tokenId);

    
    //mapping in solidity creates a hash table of key pair value
    //mapping from token id to owner
    mapping(uint=>address) private tokenOwner;
    //mapping from owner to number of token ids
    mapping(address=>Counters.Counter) private ownedTokensCount;
    //mapping from token id to approved addresses
    mapping(uint=>address) private tokenapproved;
    function _exists(uint tokenId) internal view returns(bool)
    {
        //setting the adress of the nft owner to check the mapping of the adress from token id
        address owner=tokenOwner[tokenId];
        //returns truthiness ofthe adress is not zero
        return owner != address(0);
    }

    function _mint(address to,uint tokenId)  internal virtual{
        //requires that the addressis not zero
        require(to != address(0),'ERC721:minting to the zero address is not allowed');
        //the token does not already exists
        require(!_exists(tokenId),'ERC721:token already minted');
        //we are adding a new address with a new id for minting
        tokenOwner[tokenId]=to;
        //keeping track of each address thatis minting and adding one
        ownedTokensCount[to].increment();



        emit Transfer(address(0),to,tokenId);
    }
    constructor()
   {
       register(bytes4(keccak256('balanceOf(bytes4')^(keccak256('ownerOf(bytes4)'))^(keccak256('transferFrom(bytes4)'))));
   }

    function balanceOf(address owner) public override view returns(uint)
    {
        require(owner != address(0),'ERC721:address does not exist');
        return ownedTokensCount[owner].current();
    }

    function ownerOf(uint token) public override view returns(address)
    {
        address owner=tokenOwner[token];
        require(owner != address(0),'owner address does not exist');
        return owner;
    }
      function _transferFrom(address from,address to,uint tokenId) internal{
        require(to != address(0),'invalid address');
        require(ownerOf(tokenId) == from,'token does not belong to this address');
        tokenOwner[tokenId]=to;
        ownedTokensCount[from].decrement();
        ownedTokensCount[to].increment();
               

        emit Transfer(from,to,tokenId);
    }
    function transferFrom(address from,address to,uint tokenId) public  override{
        require(isapprovedorowner(msg.sender,tokenId));
        _transferFrom(from,to,tokenId);
    }
    function getApproved(uint tokenId) public view returns(address)
    {
        require(_exists(tokenId));
        return tokenapproved[tokenId];
    }

    //require that the person approving is the owner
    //we are approving an address to a token
    //require that we can approve sending tokens of the owner to the current caller
    //update the map of the approval addresses
    function approve(address to,uint tokenId) public{
        require(ownerOf(tokenId) != to);
        require(msg.sender == ownerOf(tokenId));
        tokenapproved[tokenId]=to;
        getApproved(tokenId);

        emit Approval(ownerOf(tokenId),to,tokenId);
    }

    function isapprovedorowner(address spender,uint tokenId) internal view returns(bool)
    {
        require(_exists(tokenId));
        address owner=ownerOf(tokenId);
        return (spender==owner || getApproved(tokenId)==spender) ;
    }
}