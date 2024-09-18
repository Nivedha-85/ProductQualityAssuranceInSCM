import Web3 from 'web3/dist/web3.min.js';

const web3 = new Web3(new Web3.providers.HttpProvider('HTTP://127.0.0.1:7545'));

const contract = new web3.eth.Contract([
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "componentID",
				"type": "uint256"
			}
		],
		"name": "ComponentDispatched",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "componentID",
				"type": "uint256"
			}
		],
		"name": "ComponentProduced",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "CustomerAdded",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "CustomerRemoved",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "DistributorAdded",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "DistributorRemoved",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "ManufacturerAdded",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "ManufacturerRemoved",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "productID",
				"type": "uint256"
			}
		],
		"name": "ProductCreated",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "productID",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "componentID",
				"type": "uint256"
			}
		],
		"name": "ProductIntegrated",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "productID",
				"type": "uint256"
			}
		],
		"name": "ProductManufactured",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "productID",
				"type": "uint256"
			}
		],
		"name": "ProductPurchased",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "productID",
				"type": "uint256"
			}
		],
		"name": "ProductTestedAndDispatched",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "SupplierAdded",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "SupplierRemoved",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "oldOwner",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "TransferOwnership",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_productID",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_componentID",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_componentVerificationReport",
				"type": "string"
			}
		],
		"name": "ProductIntegration",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_productID",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_productName",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_productModel",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_productInfo",
				"type": "string"
			}
		],
		"name": "ProductManufacture",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "addCustomer",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "addDistributor",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "addManufacturer",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "addSupplier",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_componentID",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "_manufacturerID",
				"type": "address"
			}
		],
		"name": "componentDispatch",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_componentID",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_componentName",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_componentModel",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_componentInfo",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "_componentPrice",
				"type": "uint256"
			}
		],
		"name": "componentProduced",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_componentID",
				"type": "uint256"
			}
		],
		"name": "fetchComponentDetails",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "componentID",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "supplierID",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "manufacturerID",
				"type": "address"
			},
			{
				"internalType": "string",
				"name": "componentName",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "componentModel",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "componentInfo",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "componentPrice",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "itemState",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "fetchComponentsOfSupplier",
		"outputs": [
			{
				"internalType": "uint256[]",
				"name": "components",
				"type": "uint256[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_productID",
				"type": "uint256"
			}
		],
		"name": "fetchProductDetails",
		"outputs": [
			{
				"internalType": "address",
				"name": "manufacturerID",
				"type": "address"
			},
			{
				"internalType": "string",
				"name": "productName",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "productModel",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "productInfo",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "componentVerificationReport",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "productTestReport",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "distributorVerificationReport",
				"type": "string"
			},
			{
				"internalType": "address",
				"name": "distributorID",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "customerID",
				"type": "address"
			},
			{
				"internalType": "uint256[]",
				"name": "components",
				"type": "uint256[]"
			},
			{
				"internalType": "uint256",
				"name": "itemState",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "fetchProductsOfDistributor",
		"outputs": [
			{
				"internalType": "uint256[]",
				"name": "products",
				"type": "uint256[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "fetchProductsOfManufacturer",
		"outputs": [
			{
				"internalType": "uint256[]",
				"name": "products",
				"type": "uint256[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256[]",
				"name": "components",
				"type": "uint256[]"
			},
			{
				"internalType": "uint256",
				"name": "componentID",
				"type": "uint256"
			}
		],
		"name": "hasComponent",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "isCustomer",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "isDistributor",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "isManufacturer",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "isOwner",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "isSupplier",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "ownerLookup",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_productID",
				"type": "uint256"
			}
		],
		"name": "productCreation",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_productID",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_distributorVerificationReport",
				"type": "string"
			},
			{
				"internalType": "address",
				"name": "_customerID",
				"type": "address"
			}
		],
		"name": "productTestAndDelivery",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_productID",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_productTestReport",
				"type": "string"
			},
			{
				"internalType": "address",
				"name": "_distributorID",
				"type": "address"
			}
		],
		"name": "productTestingAndDispatch",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "removeCustomer",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "removeDistributor",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "removeManufacturer",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "removeSupplier",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "renounceOwnership",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "transferOwnership",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
],"0xFc29a568f5c953A57b0FaE8456D11a411b07aDD1");


export default contract;