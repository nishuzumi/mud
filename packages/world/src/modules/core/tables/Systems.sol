// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

// Import schema type
import { SchemaType } from "@latticexyz/schema-type/src/solidity/SchemaType.sol";

// Import store internals
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { StoreCore } from "@latticexyz/store/src/StoreCore.sol";
import { Bytes } from "@latticexyz/store/src/Bytes.sol";
import { Memory } from "@latticexyz/store/src/Memory.sol";
import { SliceLib } from "@latticexyz/store/src/Slice.sol";
import { EncodeArray } from "@latticexyz/store/src/tightcoder/EncodeArray.sol";
import { Schema, SchemaLib } from "@latticexyz/store/src/Schema.sol";
import { PackedCounter, PackedCounterLib } from "@latticexyz/store/src/PackedCounter.sol";

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("Systems")));
bytes32 constant SystemsTableId = _tableId;

library Systems {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](2);
    _schema[0] = SchemaType.ADDRESS;
    _schema[1] = SchemaType.BOOL;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.BYTES32;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](2);
    _fieldNames[0] = "system";
    _fieldNames[1] = "publicAccess";
    return ("Systems", _fieldNames);
  }

  /** Register the table's schema */
  function registerSchema() internal {
    StoreSwitch.registerSchema(_tableId, getSchema(), getKeySchema());
  }

  /** Register the table's schema (using the specified store) */
  function registerSchema(IStore _store) internal {
    _store.registerSchema(_tableId, getSchema(), getKeySchema());
  }

  /** Set the table's metadata */
  function setMetadata() internal {
    (string memory _tableName, string[] memory _fieldNames) = getMetadata();
    StoreSwitch.setMetadata(_tableId, _tableName, _fieldNames);
  }

  /** Set the table's metadata (using the specified store) */
  function setMetadata(IStore _store) internal {
    (string memory _tableName, string[] memory _fieldNames) = getMetadata();
    _store.setMetadata(_tableId, _tableName, _fieldNames);
  }

  /** Get system */
  function getSystem(bytes32 resourceSelector) internal view returns (address system) {
    bytes32[] memory _keyTuple;
    /// @solidity memory-safe-assembly
    assembly {
      // Allocate memory
      _keyTuple := mload(0x40)
      mstore(0x40, add(_keyTuple, 64))
      // Store length
      mstore(_keyTuple, 1)
    }

    // Store keys
    bytes32 _keyTupleItem;

    /// @solidity memory-safe-assembly
    _keyTupleItem = resourceSelector;
    assembly {
      mstore(add(_keyTuple, 32), _keyTupleItem)
    }

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 0);
    return (address(Bytes.slice20(_blob, 0)));
  }

  /** Get system (using the specified store) */
  function getSystem(IStore _store, bytes32 resourceSelector) internal view returns (address system) {
    bytes32[] memory _keyTuple;
    /// @solidity memory-safe-assembly
    assembly {
      // Allocate memory
      _keyTuple := mload(0x40)
      mstore(0x40, add(_keyTuple, 64))
      // Store length
      mstore(_keyTuple, 1)
    }

    // Store keys
    bytes32 _keyTupleItem;

    /// @solidity memory-safe-assembly
    _keyTupleItem = resourceSelector;
    assembly {
      mstore(add(_keyTuple, 32), _keyTupleItem)
    }

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 0);
    return (address(Bytes.slice20(_blob, 0)));
  }

  /** Set system */
  function setSystem(bytes32 resourceSelector, address system) internal {
    bytes32[] memory _keyTuple;
    /// @solidity memory-safe-assembly
    assembly {
      // Allocate memory
      _keyTuple := mload(0x40)
      mstore(0x40, add(_keyTuple, 64))
      // Store length
      mstore(_keyTuple, 1)
    }

    // Store keys
    bytes32 _keyTupleItem;

    /// @solidity memory-safe-assembly
    _keyTupleItem = resourceSelector;
    assembly {
      mstore(add(_keyTuple, 32), _keyTupleItem)
    }

    StoreSwitch.setField(_tableId, _keyTuple, 0, abi.encodePacked((system)));
  }

  /** Set system (using the specified store) */
  function setSystem(IStore _store, bytes32 resourceSelector, address system) internal {
    bytes32[] memory _keyTuple;
    /// @solidity memory-safe-assembly
    assembly {
      // Allocate memory
      _keyTuple := mload(0x40)
      mstore(0x40, add(_keyTuple, 64))
      // Store length
      mstore(_keyTuple, 1)
    }

    // Store keys
    bytes32 _keyTupleItem;

    /// @solidity memory-safe-assembly
    _keyTupleItem = resourceSelector;
    assembly {
      mstore(add(_keyTuple, 32), _keyTupleItem)
    }

    _store.setField(_tableId, _keyTuple, 0, abi.encodePacked((system)));
  }

  /** Get publicAccess */
  function getPublicAccess(bytes32 resourceSelector) internal view returns (bool publicAccess) {
    bytes32[] memory _keyTuple;
    /// @solidity memory-safe-assembly
    assembly {
      // Allocate memory
      _keyTuple := mload(0x40)
      mstore(0x40, add(_keyTuple, 64))
      // Store length
      mstore(_keyTuple, 1)
    }

    // Store keys
    bytes32 _keyTupleItem;

    /// @solidity memory-safe-assembly
    _keyTupleItem = resourceSelector;
    assembly {
      mstore(add(_keyTuple, 32), _keyTupleItem)
    }

    bytes memory _blob = StoreSwitch.getField(_tableId, _keyTuple, 1);
    return (_toBool(uint8(Bytes.slice1(_blob, 0))));
  }

  /** Get publicAccess (using the specified store) */
  function getPublicAccess(IStore _store, bytes32 resourceSelector) internal view returns (bool publicAccess) {
    bytes32[] memory _keyTuple;
    /// @solidity memory-safe-assembly
    assembly {
      // Allocate memory
      _keyTuple := mload(0x40)
      mstore(0x40, add(_keyTuple, 64))
      // Store length
      mstore(_keyTuple, 1)
    }

    // Store keys
    bytes32 _keyTupleItem;

    /// @solidity memory-safe-assembly
    _keyTupleItem = resourceSelector;
    assembly {
      mstore(add(_keyTuple, 32), _keyTupleItem)
    }

    bytes memory _blob = _store.getField(_tableId, _keyTuple, 1);
    return (_toBool(uint8(Bytes.slice1(_blob, 0))));
  }

  /** Set publicAccess */
  function setPublicAccess(bytes32 resourceSelector, bool publicAccess) internal {
    bytes32[] memory _keyTuple;
    /// @solidity memory-safe-assembly
    assembly {
      // Allocate memory
      _keyTuple := mload(0x40)
      mstore(0x40, add(_keyTuple, 64))
      // Store length
      mstore(_keyTuple, 1)
    }

    // Store keys
    bytes32 _keyTupleItem;

    /// @solidity memory-safe-assembly
    _keyTupleItem = resourceSelector;
    assembly {
      mstore(add(_keyTuple, 32), _keyTupleItem)
    }

    StoreSwitch.setField(_tableId, _keyTuple, 1, abi.encodePacked((publicAccess)));
  }

  /** Set publicAccess (using the specified store) */
  function setPublicAccess(IStore _store, bytes32 resourceSelector, bool publicAccess) internal {
    bytes32[] memory _keyTuple;
    /// @solidity memory-safe-assembly
    assembly {
      // Allocate memory
      _keyTuple := mload(0x40)
      mstore(0x40, add(_keyTuple, 64))
      // Store length
      mstore(_keyTuple, 1)
    }

    // Store keys
    bytes32 _keyTupleItem;

    /// @solidity memory-safe-assembly
    _keyTupleItem = resourceSelector;
    assembly {
      mstore(add(_keyTuple, 32), _keyTupleItem)
    }

    _store.setField(_tableId, _keyTuple, 1, abi.encodePacked((publicAccess)));
  }

  /** Get the full data */
  function get(bytes32 resourceSelector) internal view returns (address system, bool publicAccess) {
    bytes32[] memory _keyTuple;
    /// @solidity memory-safe-assembly
    assembly {
      // Allocate memory
      _keyTuple := mload(0x40)
      mstore(0x40, add(_keyTuple, 64))
      // Store length
      mstore(_keyTuple, 1)
    }

    // Store keys
    bytes32 _keyTupleItem;

    /// @solidity memory-safe-assembly
    _keyTupleItem = resourceSelector;
    assembly {
      mstore(add(_keyTuple, 32), _keyTupleItem)
    }

    bytes memory _blob = StoreSwitch.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Get the full data (using the specified store) */
  function get(IStore _store, bytes32 resourceSelector) internal view returns (address system, bool publicAccess) {
    bytes32[] memory _keyTuple;
    /// @solidity memory-safe-assembly
    assembly {
      // Allocate memory
      _keyTuple := mload(0x40)
      mstore(0x40, add(_keyTuple, 64))
      // Store length
      mstore(_keyTuple, 1)
    }

    // Store keys
    bytes32 _keyTupleItem;

    /// @solidity memory-safe-assembly
    _keyTupleItem = resourceSelector;
    assembly {
      mstore(add(_keyTuple, 32), _keyTupleItem)
    }

    bytes memory _blob = _store.getRecord(_tableId, _keyTuple, getSchema());
    return decode(_blob);
  }

  /** Set the full data using individual values */
  function set(bytes32 resourceSelector, address system, bool publicAccess) internal {
    bytes memory _data = encode(system, publicAccess);

    bytes32[] memory _keyTuple;
    /// @solidity memory-safe-assembly
    assembly {
      // Allocate memory
      _keyTuple := mload(0x40)
      mstore(0x40, add(_keyTuple, 64))
      // Store length
      mstore(_keyTuple, 1)
    }

    // Store keys
    bytes32 _keyTupleItem;

    /// @solidity memory-safe-assembly
    _keyTupleItem = resourceSelector;
    assembly {
      mstore(add(_keyTuple, 32), _keyTupleItem)
    }

    StoreSwitch.setRecord(_tableId, _keyTuple, _data);
  }

  /** Set the full data using individual values (using the specified store) */
  function set(IStore _store, bytes32 resourceSelector, address system, bool publicAccess) internal {
    bytes memory _data = encode(system, publicAccess);

    bytes32[] memory _keyTuple;
    /// @solidity memory-safe-assembly
    assembly {
      // Allocate memory
      _keyTuple := mload(0x40)
      mstore(0x40, add(_keyTuple, 64))
      // Store length
      mstore(_keyTuple, 1)
    }

    // Store keys
    bytes32 _keyTupleItem;

    /// @solidity memory-safe-assembly
    _keyTupleItem = resourceSelector;
    assembly {
      mstore(add(_keyTuple, 32), _keyTupleItem)
    }

    _store.setRecord(_tableId, _keyTuple, _data);
  }

  /** Decode the tightly packed blob using this table's schema */
  function decode(bytes memory _blob) internal pure returns (address system, bool publicAccess) {
    system = (address(Bytes.slice20(_blob, 0)));

    publicAccess = (_toBool(uint8(Bytes.slice1(_blob, 20))));
  }

  /** Tightly pack full data using this table's schema */
  function encode(address system, bool publicAccess) internal pure returns (bytes memory) {
    return abi.encodePacked(system, publicAccess);
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(bytes32 resourceSelector) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple;
    /// @solidity memory-safe-assembly
    assembly {
      // Allocate memory
      _keyTuple := mload(0x40)
      mstore(0x40, add(_keyTuple, 64))
      // Store length
      mstore(_keyTuple, 1)
    }

    // Store keys
    bytes32 _keyTupleItem;

    /// @solidity memory-safe-assembly
    _keyTupleItem = resourceSelector;
    assembly {
      mstore(add(_keyTuple, 32), _keyTupleItem)
    }

    return _keyTuple;
  }

  /* Delete all data for given keys */
  function deleteRecord(bytes32 resourceSelector) internal {
    bytes32[] memory _keyTuple;
    /// @solidity memory-safe-assembly
    assembly {
      // Allocate memory
      _keyTuple := mload(0x40)
      mstore(0x40, add(_keyTuple, 64))
      // Store length
      mstore(_keyTuple, 1)
    }

    // Store keys
    bytes32 _keyTupleItem;

    /// @solidity memory-safe-assembly
    _keyTupleItem = resourceSelector;
    assembly {
      mstore(add(_keyTuple, 32), _keyTupleItem)
    }

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, bytes32 resourceSelector) internal {
    bytes32[] memory _keyTuple;
    /// @solidity memory-safe-assembly
    assembly {
      // Allocate memory
      _keyTuple := mload(0x40)
      mstore(0x40, add(_keyTuple, 64))
      // Store length
      mstore(_keyTuple, 1)
    }

    // Store keys
    bytes32 _keyTupleItem;

    /// @solidity memory-safe-assembly
    _keyTupleItem = resourceSelector;
    assembly {
      mstore(add(_keyTuple, 32), _keyTupleItem)
    }

    _store.deleteRecord(_tableId, _keyTuple);
  }
}

function _toBool(uint8 value) pure returns (bool result) {
  assembly {
    result := value
  }
}
