// SPDX-License-Identifier: MIT
pragma solidity >=0.7.6;
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router01.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";

contract RouterInteraction {
    using SafeERC20 for IERC20;
    address private constant UNISWAP_ROUTER_ADDRESS = 0xf164fC0Ec4E93095b804a4795bBe1e041497b92a;

    //  amountIn ,tokenIn,tokenOut and amountOutMin
    function swapV2Router(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        uint256 deadline
    ) external {
        require(path.length >= 2, "RouterInteraction:: Invalid Path length");
        require(
            path[0] != address(0) || path[path.length - 1] != address(0),
            "RouterInteraction:: Invalid token address"
        );

        address sender = msg.sender;

        IERC20(path[0]).safeTransferFrom(sender, address(this), amountIn);

        IUniswapV2Router01(UNISWAP_ROUTER_ADDRESS).swapExactTokensForTokens(
            amountIn,
            amountOutMin,
            path,
            sender,
            deadline
        );
    }
}
