// SPDX-License-Identifier: MIT
pragma solidity  >=0.4.22 <0.9.0;

// Based on openzeppelin-solidity@2.5.0:  openzeppelin-solidity\contracts\access\Roles.sol
// Import the library 'Roles'
import "./Roles.sol";

contract DistributorRole {
    using Roles for Roles.Role;

    // Define 2 events, one for Adding, and other for Removing
    event DistributorAdded(address indexed account);
    event DistributorRemoved(address indexed account);
    
    // Define a struct '_Distributors' by inheriting from 'Roles' library, struct Role
    Roles.Role private _Distributors;

    // In the constructor make the address that deploys this contract the 1st Distributor
    constructor () {
        _addDistributor(msg.sender);
    }

    // Define a modifier that checks to see if msg.sender has the appropriate role
    modifier onlyDistributor() {
        require(isDistributor(msg.sender), "DistributorRole: caller does not have the Distributor role");
        _;
    }

    // Define a function 'isDistributor' to check this role
    function isDistributor(address account) public view returns (bool) {
       // emit isdistributor(account);
        return _Distributors.has(account);
    }

    // Define a function 'addDistributor' that adds this role
    function addDistributor(address account) public onlyDistributor {
        _addDistributor(account);
    }

    // Define a function 'removeDistributor' to renounce/remove this role
    function removeDistributor() public {
        _removeDistributor(msg.sender);
    }

    // Define an internal function '_addDistributor' to add this role, called by 'addDistributor'
    function _addDistributor(address account) internal {
        _Distributors.add(account);
        emit DistributorAdded(account);
    }

    // Define an internal function '_removeDistributor' to remove this role, called by 'removeDistributor'
    function _removeDistributor(address account) internal {
        _Distributors.remove(account);
        emit DistributorRemoved(account);
    }
}