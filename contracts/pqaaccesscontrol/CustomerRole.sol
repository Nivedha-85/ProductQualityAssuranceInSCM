// SPDX-License-Identifier: MIT
pragma solidity  >=0.4.22 <0.9.0;

// Based on openzeppelin-solidity@2.5.0:  openzeppelin-solidity\contracts\access\roles\CapperRole.sol
// Import the library 'Roles'
import "./Roles.sol";

contract CustomerRole {
    using Roles for Roles.Role;

    // Define 2 events, one for Adding, and other for Removing
    event CustomerAdded(address indexed account);
    event CustomerRemoved(address indexed account);

    // Define a struct '_Customers' by inheriting from 'Roles' library, struct Role
    Roles.Role private _Customers;

    // In the constructor make the address that deploys this contract the 1st Customer
    constructor () {
        _addCustomer(msg.sender);
    }

    // Define a modifier that checks to see if msg.sender has the appropriate role
    modifier onlyCustomer() {
        require(isCustomer(msg.sender), "CustomerRole: caller does not have the Customer role");
        _;
    }

    // Define a function 'isCustomer' to check this role
    function isCustomer(address account) public view returns (bool) {
        return _Customers.has(account);
    }

    // Define a function 'addCustomer' that adds this role
    function addCustomer(address account) public onlyCustomer {
        _addCustomer(account);
    }

    // Define a function 'removeCustomer' to renounce/remove this role
    function removeCustomer() public {
        _removeCustomer(msg.sender);
    }

    // Define an internal function '_addCustomer' to add this role, called by 'addCustomer'
    function _addCustomer(address account) internal {
        _Customers.add(account);
        emit CustomerAdded(account);
    }

    // Define an internal function '_removeCustomer' to remove this role, called by 'removeCustomer'
    function _removeCustomer(address account) internal {
        _Customers.remove(account);
        emit CustomerRemoved(account);
    }
}