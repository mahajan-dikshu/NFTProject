//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import './interfaces/IERC165.sol';
contract ERC165 is IERC165{
    mapping(bytes4=>bool) private _supportedInterfaces;
   function supportsInterface(bytes4 interfaceId) external override view returns(bool)
   {
       return _supportedInterfaces[interfaceId];
   }
   constructor()
   {
       register(bytes4(keccak256('supportInterface(bytes4')));
   }

   function register(bytes4 interfaceId) internal{
       require(interfaceId != 0xffffffff);
       _supportedInterfaces[interfaceId]=true;
   }

}