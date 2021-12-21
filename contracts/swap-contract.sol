// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

contract Swap {
    address private owner;

    constructor() {
        owner = msg.sender;
    }

    function swap(
        address _pairAddr,
        address _from,
        address _to,
        uint256 _fromAmt,
        uint256 _toAmt
    ) public {
        require(msg.sender == owner);
        require(_fromAmt >= address(this).balance);

        ISwap(_pairAddr).swap(
            _fromAmt,
            _toAmt,
            address(this),
            abi.encodeWithSignature(
                "transfer(address,address,uint256)",
                _fromAmt,
                _toAmt,
                address(this)
            )
        );
    }

    function withdraw() public payable {
        require(msg.sender == owner);
        payable(owner).transfer(address(this).balance);
    }

    function deposit(address _token, uint256 _amt) public {
        IERC20(_token).transferFrom(msg.sender, address(this), _amt);
    }
}
