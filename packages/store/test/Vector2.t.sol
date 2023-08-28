// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { Test } from "forge-std/Test.sol";
import { GasReporter } from "@latticexyz/gas-report/src/GasReporter.sol";
import { Vector2, Vector2Data, Vector2TableId } from "../src/codegen/Tables.sol";
import { StoreCore } from "../src/StoreCore.sol";
import { StoreReadWithStubs } from "../src/StoreReadWithStubs.sol";
import { FieldLayout } from "../src/FieldLayout.sol";

contract Vector2Test is Test, GasReporter, StoreReadWithStubs {
  function testRegisterAndGetFieldLayout() public {
    startGasReport("register Vector2 schema");
    Vector2.register();
    endGasReport();

    FieldLayout registeredFieldLayout = StoreCore.getValueFieldLayout(Vector2TableId);
    FieldLayout declaredFieldLayout = Vector2.getValueFieldLayout();

    assertEq(FieldLayout.unwrap(registeredFieldLayout), FieldLayout.unwrap(declaredFieldLayout));
  }

  function testSetAndGet() public {
    Vector2.register();
    bytes32 key = keccak256("somekey");

    startGasReport("set Vector2 record");
    Vector2.set({ key: key, x: 1, y: 2 });
    endGasReport();

    startGasReport("get Vector2 record");
    Vector2Data memory vector = Vector2.get(key);
    endGasReport();

    assertEq(vector.x, 1);
    assertEq(vector.y, 2);
  }
}
