// SPDX-License-Identifier: MIT
pragma solidity  >=0.4.22 <0.9.0;

// Inherited contracts
import '../pqacore/Ownable.sol';
import '../pqaaccesscontrol/SupplierRole.sol';
import '../pqaaccesscontrol/ManufacturerRole.sol';
import '../pqaaccesscontrol/DistributorRole.sol';
import '../pqaaccesscontrol/CustomerRole.sol';

// Define a contract 'Supplychain'
contract SupplyChain is
    Ownable,
    SupplierRole,
    ManufacturerRole,
    DistributorRole,
    CustomerRole
{

    // ID -> struct
    mapping(uint256 => ComponentItem) componentItems;
    mapping(uint256 => ProductItem) productItems;
    // productID -> ComponentID[]   (ID->ID1,ID2,ID3,..)
    mapping(uint256 => uint256[]) productComponents;
    mapping(address=> uint256[]) supplierComponents;
    mapping(address=> uint256[]) manufacturerProducts;
    mapping(address=> uint256[]) distributorProducts;

    // Define enum 'ComponentState' with the following values:
    enum ComponentState {
		Produced,       //0
		Dispatched      //1
	}
    ComponentState constant defaultComponentState = ComponentState.Produced;

    // Define enum 'ProductState' with the following values:
    enum ProductState {
        Created,                //0
        Integrated,             //1
        Manufactured,           //2
        TestedAndDispatched,    //3
        Purchased               //4
    }
    ProductState constant defaultProductState = ProductState.Created;

    // Define a struct 'ComponentItem' with the following fields:
    struct ComponentItem {
        uint256 componentID; 
        address supplierID; 
        string componentName; 
        string componentModel; 
        string componentInfo; 
        uint256 componentPrice;
        address manufacturerID;
        ComponentState itemState; 
    }

    // Define a struct 'ProductItem' with the following fields:
    struct ProductItem {
        uint256 productID; 
        address manufacturerID; 
        string productName;
        string productModel; 
        string productInfo;
        string componentVerificationReport;
        string productTestReport;
        string distributorVerificationReport;
        address distributorID; 
        address customerID; 
        ProductState itemState; 
    }

    // Define events of Components
    event ComponentProduced(uint256 componentID);
    event ComponentDispatched(uint256 componentID);

    // Define events of Products
    event ProductCreated(uint256 productID);
    event ProductIntegrated(uint256 productID, uint256 componentID);
    event ProductManufactured(uint256 productID);
    event ProductTestedAndDispatched(uint256 productID);
    event ProductPurchased(uint256 productID);

    // Define a modifer that verifies the Caller
    modifier verifyCaller(address _address) {
        require(msg.sender == _address, "verifyCaller: unexpected caller");
        _;
    }

    //Item State Modifiers
    modifier isProduced(uint256 _componentID) {
        require(componentItems[_componentID].itemState == ComponentState.Produced, "Not Produced");
        _;
    }

    modifier notProduced(uint256 _componentID) {
        require(componentItems[_componentID].componentID==0, "Already Produced");
        _;
    }

    modifier notCreated(uint256 _productID) {
        require(productItems[_productID].productID==0, "Already Created");
        _;
    }

    modifier isIntegrated(uint256 _productID) {
        require(productItems[_productID].itemState == ProductState.Integrated, "Not Integrated");
        _;
    }

    modifier isComponentAdded(uint256 _productID,uint256 _componentID) {
        require(!hasComponent(productComponents[_productID],_componentID), "Component Already Added");
        _;
    }

    modifier isManufactured(uint256 _productID) {
        require(productItems[_productID].itemState == ProductState.Manufactured, "Not Manufactured");
        _;
    }

    modifier isTestedAndDispatched(uint256 _productID) {
        require(productItems[_productID].itemState == ProductState.TestedAndDispatched, "Not Dispatched");
        _;
    }

    modifier isPurchased(uint256 _productID) {
        require(productItems[_productID].itemState == ProductState.Purchased, "Not Purchased");
        _;
    }

    function hasComponent(
        uint256[] memory components, 
        uint256 componentID
    ) 
    public 
    view 
    returns (bool) 
    {
        for(uint256 i=0;i<components.length;i++)
        {
            if(components[i]==componentID)
                return true;
        }
        return false;
    }

    function   componentProduced(
        uint256 _componentID,
        string calldata _componentName,
        string calldata _componentModel,
        string calldata _componentInfo,
        uint256 _componentPrice
    ) 
    public 
    onlySupplier
    notProduced(_componentID)
    {
        componentItems[_componentID].componentID = _componentID;
        componentItems[_componentID].supplierID = msg.sender;
        componentItems[_componentID].componentName = _componentName;
        componentItems[_componentID].componentModel = _componentModel;
        componentItems[_componentID].componentInfo = _componentInfo;
        componentItems[_componentID].componentPrice = _componentPrice;
        componentItems[_componentID].itemState = ComponentState.Produced;
        supplierComponents[msg.sender].push(_componentID);
        emit ComponentProduced(_componentID);
    }

    function componentDispatch(
        uint256 _componentID, 
        address _manufacturerID
    )
    public
    onlySupplier
    isProduced(_componentID)
    verifyCaller(componentItems[_componentID].supplierID)
    {

        componentItems[_componentID].manufacturerID = _manufacturerID;
        componentItems[_componentID].itemState = ComponentState.Dispatched;
        emit ComponentDispatched(_componentID);
    }
   
    function productCreation(
        uint256 _productID
    ) 
    public 
    onlyManufacturer
    notCreated(_productID)
    {

        productItems[_productID].productID = _productID;
        productItems[_productID].manufacturerID = msg.sender;
        productItems[_productID].itemState = ProductState.Created;
        manufacturerProducts[msg.sender].push(_productID);
        emit ProductCreated(_productID);
    }

    function ProductIntegration(
        uint256 _productID, 
        uint256 _componentID,
        string calldata _componentVerificationReport
    )
        public
        onlyManufacturer
        verifyCaller(componentItems[_componentID].manufacturerID)
		verifyCaller(productItems[_productID].manufacturerID)
        isComponentAdded(_productID,_componentID)
    {
		productComponents[_productID].push(_componentID);
        productItems[_productID].itemState = ProductState.Integrated;
        productItems[_productID].componentVerificationReport = string(bytes.concat(bytes(productItems[_productID].componentVerificationReport),"\n",bytes(_componentVerificationReport)));
        emit ProductIntegrated(_productID, _componentID);
    }

	function ProductManufacture(
        uint256 _productID, 
        string calldata _productName,
        string calldata _productModel,
        string calldata _productInfo
    )
    public
    onlyManufacturer
	verifyCaller(productItems[_productID].manufacturerID)
	isIntegrated(_productID)
    {
        productItems[_productID].productName = _productName;
        productItems[_productID].productModel = _productModel;
        productItems[_productID].productInfo = _productInfo;
        productItems[_productID].itemState = ProductState.Manufactured;
        emit ProductManufactured(_productID);
    }

	function productTestingAndDispatch(
        uint256 _productID, 
        string calldata _productTestReport,
        address _distributorID
    )
    public
    onlyManufacturer
    verifyCaller(productItems[_productID].manufacturerID)
	isManufactured(_productID)
    {
		productItems[_productID].productTestReport = _productTestReport;
        productItems[_productID].distributorID = _distributorID;
        distributorProducts[_distributorID].push(_productID);
        productItems[_productID].itemState = ProductState.TestedAndDispatched;  
        emit ProductTestedAndDispatched(_productID);
    }

	function productTestAndDelivery(
        uint256 _productID, 
        string calldata _distributorVerificationReport,
        address _customerID
    )
    public
    onlyDistributor
    verifyCaller(productItems[_productID].distributorID)
	isTestedAndDispatched(_productID)
    {
        productItems[_productID].distributorVerificationReport = _distributorVerificationReport;
        productItems[_productID].customerID = _customerID;
        productItems[_productID].itemState = ProductState.Purchased;
        emit ProductPurchased(_productID);
    }

    function fetchComponentDetails(uint256 _componentID)
        public
        view
        returns (
			uint256 componentID,
			address supplierID,
            address manufacturerID,
			string memory componentName,
			string memory componentModel,
			string memory componentInfo,
			uint256 componentPrice,
            uint256 itemState
        )
    {

			componentID = componentItems[_componentID].componentID;
			supplierID = componentItems[_componentID].supplierID;
            manufacturerID = componentItems[_componentID].manufacturerID;
			componentName = componentItems[_componentID].componentName;
			componentModel = componentItems[_componentID].componentModel;
			componentInfo = componentItems[_componentID].componentInfo;
			componentPrice = componentItems[_componentID].componentPrice;
            itemState = uint256(componentItems[_componentID].itemState);
        return (
			componentID,
			supplierID,
            manufacturerID,
			componentName,
			componentModel,
			componentInfo,
			componentPrice,
            itemState
        );
    }

    function fetchProductDetails(uint256 _productID)
        external
        view
        returns (
            address manufacturerID,
			string memory productName,
            string memory productModel,
            string memory productInfo,
            string memory componentVerificationReport,
            string memory productTestReport,
            string memory distributorVerificationReport,
			address distributorID,
			address customerID,			
			uint256[] memory components,
			uint256 itemState
        )
    {
            manufacturerID = productItems[_productID].manufacturerID;
			productName	= productItems[_productID].productName;
            productModel = productItems[_productID].productModel;
            productInfo	= productItems[_productID].productInfo;
			componentVerificationReport	= productItems[_productID].componentVerificationReport;
			productTestReport = productItems[_productID].productTestReport;
            distributorVerificationReport = productItems[_productID].distributorVerificationReport;
            distributorID = productItems[_productID].distributorID;
            customerID = productItems[_productID].customerID;
			components = productComponents[_productID];
			itemState = uint256(productItems[_productID].itemState);
        return (
            manufacturerID,
            productName,
			productModel,
            productInfo,
            componentVerificationReport,
            productTestReport,
            distributorVerificationReport,
			distributorID,
			customerID,
			components,
			itemState
        );
    }

    function fetchComponentsOfSupplier()
        external
        view
        returns(uint256[] memory components)
    {
        components=supplierComponents[msg.sender];
        return (
            components
        );
    }

    function fetchProductsOfManufacturer()
        external
        view
        returns(uint256[] memory products)
    {
        products=manufacturerProducts[msg.sender];
        return (
            products
        );
    }

    function fetchProductsOfDistributor()
        external
        view
        returns(uint256[] memory products)
    {
        products=distributorProducts[msg.sender];
        return (
            products
        );
    } 
}