//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;
library SafeMath
{
    //build functions to perform safe math operations that would replace intutitive preventive mesures
    function add(uint a,uint b) internal pure returns(uint)
    {
        uint r=a+b;
        require(r>= a,'Safe Math condition overflow');
        return r;
    }
    function sub(uint a,uint b) internal pure returns(uint)
    {
        uint r=a-b;
        require(b<=a,'Safe math condition overflow');
        return r;
    }
      function mul(uint a,uint b) internal pure returns(uint)
    {
        if(a==0 || b==0)
        {
            return 0;
        }
        uint r=a*b;
        require(r/a == b,'Safe math condition overflow');
        return r;
    }
      function div(uint a,uint b) internal pure returns(uint)
    {
        uint r=a/b;
        require(b>0,'Safe math condition overflow');
        return r;
    }
      function mod(uint a,uint b) internal pure returns(uint)
    {
        uint r=a%b;
        require(b!=0,'Safe math condition overflow');
        return r;
    }
}