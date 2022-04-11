//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
import './ERC721.sol';
import './interfaces/IERC721Enumerable.sol';
contract ERC721Enumerable is ERC721,IERC721Enumerable
{
    uint [] private allTokens;
    //mapping from tokenid to position in all token array
    mapping(uint => uint) private alltokensindex; 
    //mapping of owner to list of all owner token id
    mapping(address=>uint[]) private ownedtokens;
    //mapping from token id to index of the owner token list
    mapping(uint=>uint) private ownedtokensindex;
    constructor()
    {
        register(bytes4(keccak256('totalSupply(bytes4)')^(keccak256('tokenByIndex(bytes4)'))^(keccak256('tokenOfOwnerByIndex(bytes4)'))));
    }

      //return the total supply of the all tokens array
    function totalSupply() public override view returns(uint)
    {
        return allTokens.length;
    }

    //add tokens to the all tokens array and set the position of the token indexes
    function addtokenstoalltokensenumerations(uint tokenId) private{
        alltokensindex[tokenId]=allTokens.length;
        allTokens.push(tokenId);

    }
    //functions-one that returns token by index
    //function-token by owner index
  function tokenByIndex(uint index) public override view returns(uint)
    {
        //make sure then index is not out of bound 
        require(index <= totalSupply(),'index out of bound');
        return alltokensindex[index];
    }

  
    function tokenOfOwnerByIndex(address owner,uint index) public override view returns(uint)
    {
        require(index < balanceOf(owner),'index out of bound');
        return ownedtokens[owner][index];
    }


    function addtokenstoownerenumerations(uint tokenId,address to) private{
        // add adress and token id to owner token ids
        ownedtokensindex[tokenId]=ownedtokens[to].length;
        ownedtokens[to].push(tokenId);
        //owned token index token id set to address of owned tokens position
        
        //we want to excecute this function with minting
    }
    function _mint(address to,uint tokenId) internal override(ERC721)
    {
        super._mint(to,tokenId);
        //1 we add tokens to the owner
        addtokenstoalltokensenumerations(tokenId);
        addtokenstoownerenumerations(tokenId, to);
        //2 add tokens to total supply
    }
  
    //function that will clear our nfts
}