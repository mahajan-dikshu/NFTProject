//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;
import './SafeMath.sol';
library Counters{
    using SafeMath for uint;
    //keep track of values of arithmetic changes
    struct Counter{
        uint _value;
    }
    function current(Counter storage counter) internal view returns(uint)
    {
        return counter._value;
    }
    function decrement (Counter storage counter) internal{
        counter._value=counter._value.sub(1);
    }
    function increment (Counter storage counter) internal{
        counter._value=counter._value.add(1);
    }

}
