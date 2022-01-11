//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

interface IYDAI {
    function deposit(uint256 _amount) external;

    function withdraw(uint256 _shares) external;

    function balanceOf(address account) external view returns (uint256);

    function getPricePerFullShare() external view returns (uint256);
}

contract Wallet is Ownable {
    address admin;
    IERC20 dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    IYDAI yDai = IYDAI(0xdA816459F1AB5631232FE5e97a05BBBb94970c95);

    function save(uint256 amount) external {
        dai.transferFrom(msg.sender, address(this), amount);
        _save(amount);
    }

    function withdraw(uint256 amount, address recipient) external onlyOwner {
        uint256 balanceShares = yDai.balanceOf(address(this));
        yDai.withdraw(balanceShares);
        dai.transfer(recipient, amount);
        uint256 balanceDai = dai.balanceOf(address(this));
        if (balanceDai > 0) {
            _save(balanceDai);
        }
    }

    function _save(uint256 amount) internal {
        dai.approve(address(yDai), amount);
        yDai.deposit(amount);
    }

    function balance() external view returns (uint256) {
        uint256 price = yDai.getPricePerFullShare();
        uint256 balanceShares = yDai.balanceOf(address(this));
        return balanceShares * price;
    }
}
