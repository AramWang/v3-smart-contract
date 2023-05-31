// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0;

import './pool/IBeraV3PoolImmutables.sol';
import './pool/IBeraV3PoolState.sol';
import './pool/IBeraV3PoolDerivedState.sol';
import './pool/IBeraV3PoolActions.sol';
import './pool/IBeraV3PoolOwnerActions.sol';
import './pool/IBeraV3PoolEvents.sol';

interface IBeraV3Pool is
    IBeraV3PoolImmutables,
    IBeraV3PoolState,
    IBeraV3PoolDerivedState,
    IBeraV3PoolActions,
    IBeraV3PoolOwnerActions,
    IBeraV3PoolEvents
{

}
