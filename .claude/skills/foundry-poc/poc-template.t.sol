// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // match the project's pragma

import {Test, console} from "forge-std/Test.sol";
// Import the contracts under test, reusing the project's remappings.

/// @title PoC for <ID>: <short title>
/// @notice Hypothesis: <one sentence from notes/threat-model.md>
contract IDX_PoC is Test {
    address attacker = makeAddr("attacker");

    function setUp() public {
        // Reuse the project's existing setup when possible.
        // Give the attacker ONLY the resources the preconditions allow.
    }

    function test_PoC_IDX() public {
        // 1. Baseline: expected behavior before the attack.

        // 2. Attack: permissionless calls with the attacker's own resources.
        vm.startPrank(attacker);
        vm.stopPrank();

        // 3. Impact: assertions that prove the hypothesis.
    }
}
