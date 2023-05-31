// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0;

interface IBeraV3Factory {
    struct TickSpacingExtraInfo {
        bool whitelistRequested;
        bool enabled;
    }

    event OwnerChanged(address indexed oldOwner, address indexed newOwner);

    event PoolCreated(
        address indexed token0,
        address indexed token1,
        uint24 indexed fee,
        int24 tickSpacing,
        address pool
    );

    event FeeAmountEnabled(uint24 indexed fee, int24 indexed tickSpacing);

    event FeeAmountExtraInfoUpdated(uint24 indexed fee, bool whitelistRequested, bool enabled);

    event WhiteListAdded(address indexed user, bool verified);

    /// @notice Emitted when LM pool deployer is set
    event SetLmPoolDeployer(address indexed lmPoolDeployer);

    /// @notice Returns the current owner of the factory
    /// @dev Can be changed by the current owner via setOwner
    /// @return The address of the factory owner
    function owner() external view returns (address);

    function feeAmountTickSpacing(uint24 fee) external view returns (int24);

    function feeAmountTickSpacingExtraInfo(uint24 fee) external view returns (bool whitelistRequested, bool enabled);

    function getPool(
        address tokenA,
        address tokenB,
        uint24 fee
    ) external view returns (address pool);

    function createPool(
        address tokenA,
        address tokenB,
        uint24 fee
    ) external returns (address pool);

    function setOwner(address _owner) external;

    function enableFeeAmount(uint24 fee, int24 tickSpacing) external;

    function setWhiteListAddress(address user, bool verified) external;

    function setFeeAmountExtraInfo(
        uint24 fee,
        bool whitelistRequested,
        bool enabled
    ) external;

    function setLmPoolDeployer(address _lmPoolDeployer) external;

    function setFeeProtocol(address pool, uint32 feeProtocol0, uint32 feeProtocol1) external;

    function collectProtocol(
        address pool,
        address recipient,
        uint128 amount0Requested,
        uint128 amount1Requested
    ) external returns (uint128 amount0, uint128 amount1);

    function setLmPool(address pool, address lmPool) external;
}
