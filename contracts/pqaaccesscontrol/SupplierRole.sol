// SPDX-License-Identifier: MIT
pragma solidity  >=0.4.22 <0.9.0;

// Based on openzeppelin-solidity@2.5.0:  openzeppelin-solidity\contracts\access\roles\CapperRole.sol
// Import the library 'Roles'
import "./Roles.sol";

contract SupplierRole {
    using Roles for Roles.Role;

    // Define 2 events, one for Adding, and other for Removing
    event SupplierAdded(address indexed account);
    event SupplierRemoved(address indexed account);

    // Define a struct '_Suppliers' by inheriting from 'Roles' library, struct Role
    Roles.Role private _Suppliers;

    // In the constructor make the address that deploys this contract the 1st Supplier
    constructor() {
      _addSupplier(msg.sender);
    }

    // Define a modifier that checks to see if msg.sender has the appropriate role
    modifier onlySupplier() {
      require(isSupplier(msg.sender),"SupplierRole: caller does not have the Supplier role");
      _;
    }

    // Define a function 'isSupplier' to check this role
    function isSupplier(address account) public view returns (bool) {
      return _Suppliers.has(account);
    }

    // Define a function 'addSupplier' that adds this role
    function addSupplier(address account) public onlySupplier {
      _addSupplier(account);
    }

    // Define a function 'removeSupplier' to renounce/remove this role
    function removeSupplier(address account) public onlySupplier{
      _removeSupplier(account);
    }

    // Define an internal function '_addSupplier' to add this role, called by 'addSupplier'
    function _addSupplier(address account) internal {
      _Suppliers.add(account);
      emit SupplierAdded(account);
    }

    // Define an internal function '_removeSupplier' to remove this role, called by 'removeSupplier'
    function _removeSupplier(address account) internal {
      _Suppliers.remove(account);
      emit SupplierRemoved(account);
    }
}