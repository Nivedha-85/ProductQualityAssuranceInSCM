<template>
<div>
  <GoBack />
<v-row>
<v-col justify="left">
<template>
  <v-card
    class="mx-auto"
    max-width="250"
    height="370"
    style="background-color: rgba(178, 218, 241, 0.967); margin-top:30px"
    elevation="6"
  >
  <v-img
      :src="require('../../../images/manu3.jpg')"
      height="200px"
    ></v-img>

    <v-card-text style="background-color: rgba(178, 218, 241, 0.967); font-size: medium; color: black" >
      Manufacturer can verify the components by clicking the Verify Component Button
    </v-card-text>
    <div class="text-center">
      <v-dialog v-model="dialog" width="500">
        <template v-slot:activator="{ on, attrs }">
          <v-btn class="elevation-6 mt-5" color="primary" light v-bind="attrs" v-on="on">
            Verify Component
          </v-btn>
        </template>
        <v-card>
          <v-card-title class= "text-h5 text-center primary lighten-1" style="color: white; padding-left: 150px">
            Verify Component
          </v-card-title>
          <v-card-text>
            <v-container>
              <v-row>
                <v-col cols="9" >
                  <v-text-field dense outlined v-model="verifyComponent.component_id" :rules="[verifyComp]" label="ID"></v-text-field>
                </v-col>
                <v-col v-if="verification==true">
                  <v-icon class="ml-1" color="green" v-if="verified==true"> mdi-check-circle </v-icon>
                  <v-icon class="ml-1" color="red" v-if="verified==false"> mdi-close-circle </v-icon>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-divider></v-divider>
          <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" @click="dialog = false,reset()">
            CLOSE
            <v-icon
        right
        dark
      >
        mdi-close-circle
      </v-icon>
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    </div>
  </v-card>
</template>
</v-col>
<v-col justify="center">
<template>
  <v-card
    class="mx-auto"
    max-width="250"
    height="370"
    style="background-color: rgba(178, 218, 241, 0.967); margin-top:30px"
    elevation="6"
  >
    <v-img
      :src="require('../../../images/manufacturer.jpg')"
      height="200px"
    ></v-img>
    <v-card-text style="background-color: rgba(178, 218, 241, 0.967); font-size:medium; color: black" >
      Manufacturer can add the details of the products by clicking the New Product Button
    </v-card-text>
    <div class="text-center">
      <v-dialog v-model="dialog2" width="700">
        <template v-slot:activator="{ on, attrs }">
          <v-btn class="elevation-6" color="primary" light v-bind="attrs" v-on="on">
            New Product
          </v-btn>
        </template>
        <v-card v-if="step==1">
          <v-card-title class= "text-h5 text-center primary lighten-1" style="color: white; padding-left: 180px">
            New Product : Product Details
          </v-card-title>
          <v-card-text>
            <v-container>
              <v-row>
                <v-col cols="9" >
                  <v-text-field dense outlined v-model="newProduct.product_id" label="Product ID"></v-text-field>
                </v-col>
                <v-col cols="9" >
                  <v-text-field dense outlined v-model="newProduct.product_name" label="Name"></v-text-field>
                </v-col>
                <v-col cols="9" >
                  <v-text-field dense outlined v-model="newProduct.product_model" label="Model"></v-text-field>
                </v-col>
                <v-col cols="9" >
                  <v-text-field dense outlined v-model="newProduct.product_info" label="Info"></v-text-field>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-divider></v-divider>
          <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" @click="dialog2 = false,resetProduct()">
            CANCEL
            <v-icon
        right
        dark
      >
        mdi-close-circle
      </v-icon>
          </v-btn>
          <v-btn color="primary" @click="resetProduct()">
            CLEAR
            <v-icon
        right
        dark
      >
        mdi-backspace
      </v-icon>
          </v-btn>
          <v-btn color="primary" @click="step=2">
            NEXT
            <v-icon
        right
        dark
      >
        mdi-page-next
      </v-icon>
          </v-btn>
        </v-card-actions>
        </v-card>
        <v-card v-if="step==2">
          <v-card-title class= "text-h5 text-center primary lighten-1" style="color: white; padding-left: 180px">
            New Product : Add Components
          </v-card-title>
          <v-card-text>
            <v-container>
              <v-data-table :headers="headers2" :items="newProduct.Components" class="elevation-9 mt-10 mb-10" style="font-family:Arial, Helvetica, sans-serif" hide-default-footer>
                <template v-slot:[`item.number`]="{ index }">
                  {{index+1}} <!-- SL.NO -->
                </template>
                <template v-slot:[`item.component_id`]={item}>
                  <v-text-field v-model="item.component_id" class="mt-5" dense outlined></v-text-field>
                </template>
                <template v-slot:[`item.componentVerificationReport`]={item}>
                  <v-text-field v-model="item.componentVerificationReport" class="mt-5" dense outlined></v-text-field>
                </template>
                <template v-slot:[`item.actions`]={item}>
                  <v-icon rounded class="mb-1" small color="red" @click="deleteComp(item)">mdi-minus-circle</v-icon> <!-- USED TO DELETED A ROW FROM THE INSERT / EDIT FORM -->
                </template>
                <!-- WHAT TO DISPLAY IF THERE ARE NO PRODUCTS -->
                <template v-slot:no-data>
                  Product contains no components
                </template>
              </v-data-table>
              <template>
                <v-btn absolute right small elevation="2" @click="addComp"><v-icon color="primary"> mdi-plus-circle</v-icon></v-btn>
              </template>
            </v-container>
          </v-card-text>
          <v-divider></v-divider>
          <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" @click="step=1">
            PREVIOUS
            <v-icon
        right
        dark
      >
        mdi-page-previous
      </v-icon>
          </v-btn>
          <v-btn color="primary" @click="dialog2 = false,resetProduct(),step=1">
            CANCEL
            <v-icon
        right
        dark
      >
        mdi-close-circle
      </v-icon>
          </v-btn>
          <v-btn color="primary" @click="save(), dialog2 = false">
            CREATE
            <v-icon
        right
        dark
      >
        mdi-folder-plus
      </v-icon>
          </v-btn>
        </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
</v-card>
</template>
</v-col>
<v-col justify="right">
<template>
  <v-card
    class="mx-auto"
    max-width="250"
    height="370"
    style="background-color: rgba(178, 218, 241, 0.967); margin-top:30px"
    elevation="6"
  >
    <v-img
      :src="require('../../../images/manu2.jpg')"
      height="200px"
    ></v-img>
    <v-card-text style="background-color: rgba(178, 218, 241, 0.967); font-size:medium; color: black" >
      Manufacturer can dispatch the products to the distributor by clicking the Dispatch Product button
    </v-card-text>

    <div class="text-center">
      <v-dialog v-model="dialog3" width="500">
        <template v-slot:activator="{ on, attrs }">
          <v-btn class="elevation-6" color="primary" light v-bind="attrs" v-on="on" >
            Dispatch Product
          </v-btn>
        </template>
        <v-card>
          <v-card-title class= "text-h5 text-center primary lighten-1" style="color: white; padding-left: 190px">
            Dispatch
          </v-card-title>
          <v-card-text>
            <v-container >
              <v-row>
                <v-col cols="9" >
                  <v-text-field dense outlined v-model="dispatchProd.product_id" label="Product ID"></v-text-field>
                </v-col>
                <v-col cols="9" >
                  <v-text-field dense outlined v-model="dispatchProd.product_testReport" label="Product Test Report"></v-text-field>
                </v-col>
                <v-col cols="9" >
                  <v-text-field dense outlined v-model="dispatchProd.distributor_id" :rules="[verifyProd,rules.required]" label="Distributor ID"></v-text-field>
                </v-col>
                <v-col>
                  <v-icon class="ml-1" color="green" v-if="verified==true"> mdi-check-circle </v-icon>
                  <v-icon class="ml-1" color="red" v-if="verified==false"> mdi-close-circle </v-icon>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-divider></v-divider>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary" @click="dialog3 = false,resetDispatchProd()">
            CANCEL
            <v-icon
        right
        dark
      >
        mdi-close-circle
      </v-icon>
          </v-btn>
          <v-btn color="primary" @click="resetDispatchProd()">
            CLEAR
            <v-icon
        right
        dark
      >
        mdi-backspace
      </v-icon>
          </v-btn>
            <v-btn color="primary" @click="dialog3 = false,dispatchProduct()">
              SEND
              <v-icon
        right
        dark
      >
        mdi-send
      </v-icon>
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
</v-card>
</template>
</v-col>
<v-col justify="center">
<template>
<v-card
    class="mx-auto"
    max-width="250"
    height="370"
    style="background-color: rgba(178, 218, 241, 0.967); margin-top:30px"
    elevation="6"
  >
    <v-img
      :src="require('../../../images/manu4.jpg')"
      height="200px"
    ></v-img>
    <v-card-text style="background-color: rgba(178, 218, 241, 0.967); font-size:medium; color: black" >
      Manufacturer can view the details of all the products by clicking the View Details Button
    </v-card-text>
    <div class="text-center">
  <v-dialog v-model="dialogView" width="1000">
      <template v-slot:activator="{ on, attrs }">
        <v-btn class="elevation-6" color="primary" light v-bind="attrs" v-on="on" @click="fetchProductDetails()">
          View Product Details
        </v-btn>
      </template>
      <v-card height="500px" width="1500px">
        <v-card-title class="text-h5 primary lighten-1" style="color:white; font-family: Georgia, 'Times New Roman', Times, serif">
          Products
          <v-spacer></v-spacer>
      <v-text-field
        v-model="search"
        append-icon="mdi-magnify"
        label="Search"
        color="black"
        single-line
        hide-details
      ></v-text-field>
      <v-btn color="primary lighten-1" fab small elevation="0" style="margin-left: 20px" @click="dialogView=false">
            <v-icon
        dark
      >
        mdi-close-circle
      </v-icon>
          </v-btn>
        </v-card-title>
      <v-card-text>
        <v-container>
          <!-- TABLE TO ENTER / EDIT PRODUCT DETAILS REGARDING THE ORDER IN THE FORM -->
          <v-data-table :headers="headers" :items="productDetails" :search="search" class="elevation-9 mt-5" style="font-family:Arial, Helvetica, sans-serif">
            <!-- WHAT TO DISPLAY IF THERE ARE NO PRODUCTS -->
            <template v-slot:no-data>
              No products available
            </template>
          </v-data-table>
        </v-container>
      </v-card-text>
      </v-card>
  </v-dialog>
</div>
</v-card>
</template>
</v-col>
</v-row>
<template>
  <v-footer
    color="primary brighten-5"
    absolute
    padless
  >
    <v-row
      justify="center"
      no-gutters
    >
      <v-col
        class="py-4 text-center white--text"
        color="red"
        cols="12"
      >
        <strong>Product Quality Assurance</strong>
      </v-col>
    </v-row>
  </v-footer>
</template>

  </div>

</template>
<script>
import manufacturerInstance from '../../../supplyChainInstance'
import GoBack from './GoBack'
export default {
  name: 'Manufacturer',
  components: {
    GoBack
  },
  data: () => ({
    dialog: false,
    dialogView: false,
    verification: false,
    verified: false,
    products: [],
    productDetails: [],
    itemstate: '',
    verifyComponent: {
      component_id: ''
    },
    newProduct: {
      product_id: '',
      product_name: '',
      product_model: '',
      product_info: '',
      Components: []
    },
    defaultProduct: {
      product_id: '',
      product_name: '',
      product_model: '',
      product_info: '',
      Components: []
    },
    search: '',
    headers: [
      {
        text: 'Product ID',
        align: 'center',
        // sortable: false,
        value: 'products_id',
        width: '240px'
      },
      { text: 'Product Name', value: 'product_name', sortable: false, filterable: false, align: 'center', width: '240px' },
      { text: 'Product Model', value: 'product_model', filterable: false, align: 'center', width: '240px' },
      // eslint-disable-next-line standard/object-curly-even-spacing
      { text: 'Product Info.', value: 'product_info', sortable: false, filterable: false, align: 'center', width: '240px'},
      // eslint-disable-next-line standard/object-curly-even-spacing
      { text: 'Components Used', value: 'components_used', sortable: false, filterable: false, align: 'center', width: '240px'},
      { text: 'Components Verification Report', value: 'components_verification_report', sortable: false, filterable: false, align: 'center', width: '240px' },
      { text: 'Distributor ID', value: 'distributor_id', sortable: false, filterable: false, align: 'center', width: '240px' },
      { text: 'Customer ID', value: 'customer_id', sortable: false, filterable: false, align: 'center', width: '240px' },
      { text: 'Item State', value: 'item_state', sortable: false, filterable: false, align: 'center', width: '240px' }
    ],
    headers2: [
      {text: 'Sl.no', align: 'center', value: 'number', filterable: false, sortable: false},
      {text: 'Component', align: 'center', value: 'component_id', filterable: false, sortable: false},
      {text: 'Verification Report', align: 'center', value: 'componentVerificationReport', filterable: false, sortable: false},
      { text: 'Actions', value: 'actions', sortable: false, filterable: false, align: 'center' }
    ],
    dialog2: false,
    step: 1,
    dialog3: false,
    dispatchProd: {
      product_id: '',
      product_testReport: '',
      distributor_id: ''
    },
    defaultDispatchProd: {
      product_id: '',
      product_testReport: '',
      distributor_id: ''
    },
    rules: {
      required: v => !!v || 'Distributor ID is required'
    }
  }),
  methods: {
    async IsManufacturer () {
      console.log(window.ethereum.selectedAddress)
      const result2 = await manufacturerInstance.methods.isManufacturer(window.ethereum.selectedAddress).call()
      console.log(result2)
      if (result2) {
        alert('This account is a registered manufacturer')
      } else {
        alert("This account isn't registered manufacturer")
      }
    },
    reset () {
      this.verifyComponent = Object.assign({}, {component_id: ''})
      this.verification = false
    },
    resetProduct () {
      this.newProduct = Object.assign({}, this.defaultProduct)
    },
    async addComponent () {
      console.log(this.newComponent)
      try {
        const result3 = await manufacturerInstance.methods.addManufacturer(window.ethereum.selectedAddress).send({from: '0x4590Af5c29F41Ffe9937CaA7839F9Bf4E912A1AD'})
        console.log(result3)
      } catch (err) {
        console.log('Error' + err)
        alert('This account is already a registered manufacturer')
      }
      this.reset()
    },
    async verifyComp (val) {
      try {
        const component = await manufacturerInstance.methods.fetchComponentDetails(val).call()
        if (window.ethereum.selectedAddress === component.manufacturerID.toLowerCase()) {
          this.verified = true
        } else {
          this.verified = false
        }
      } catch (err) {
        console.log('Error: ' + err)
        this.verified = false
      }
      this.verification = true
    },
    addComp () {
      var comp = {}
      comp.component_id = ''
      comp.componentVerificationReport = ''
      this.newProduct.Components.push(comp)
    },
    deleteComp (item) {
      var index = this.newProduct.Components.indexOf(item)
      this.newProduct.Components.splice(index, 1)
    },
    async createProductInstance () {
      try {
        const result = await manufacturerInstance.methods.productCreation(this.newProduct.product_id).send({from: window.ethereum.selectedAddress, gas: 3000000})
        console.log('Product instance created' + result)
      } catch (err) {
        alert('Error in creating product')
        console.log('Error : ' + err)
      }
    },
    async addProductInfo () {
      try {
        const result2 = await manufacturerInstance.methods.ProductManufacture(this.newProduct.product_id, this.newProduct.product_name, this.newProduct.product_model, this.newProduct.product_info).send({from: window.ethereum.selectedAddress, gas: 3000000})
        console.log('Product info added' + result2)
      } catch (err) {
        alert('Error adding product info')
        console.log('Error : ' + err)
      }
    },
    async integrateComponenets () {
      try {
        for (var i = 0; i < this.newProduct.Components.length; i++) {
          const compInst = this.newProduct.Components[i]
          const result3 = await manufacturerInstance.methods.ProductIntegration(this.newProduct.product_id, compInst.component_id, compInst.componentVerificationReport).send({from: window.ethereum.selectedAddress, gas: 3000000})
          console.log(i + ' ' + result3)
        }
      } catch (err) {
        alert('Error integrating components')
        console.log('Error : ' + err)
      }
    },
    async save () {
      await this.createProductInstance()
      await this.integrateComponenets()
      await this.addProductInfo()
      this.resetProduct()
      this.step = 1
    },
    async verifyProd () {
      try {
        const result2 = await manufacturerInstance.methods.isDistributor(this.dispatchProd.distributor_id).call()
        if (result2) {
          this.verified = true
          console.log(this.verified)
          return true
        } else {
          this.verified = false
          console.log(this.verified)
          return false
        }
      } catch (err) {
        console.log('Error : ' + err)
        this.verified = false
      }
    },
    resetDispatchProd () {
      this.dispatchProd = Object.assign({}, this.defaultDispatchProd)
      this.verified = ''
    },
    async dispatchProduct () {
      console.log(this.dispatchProd)
      try {
        const result3 = await manufacturerInstance.methods.productTestingAndDispatch(this.dispatchProd.product_id, this.dispatchProd.product_testReport, this.dispatchProd.distributor_id).send({from: window.ethereum.selectedAddress, gas: 3000000})
        console.log(result3)
      } catch (err) {
        console.log('Error' + err)
        alert('Invalid entry')
      }
      this.resetDispatchProd()
    },
    async readProducts () {
      this.products = []
      try {
        const result = await manufacturerInstance.methods.fetchProductsOfManufacturer().call({from: window.ethereum.selectedAddress})
        for (var i = 0; i < result.length; i++) {
          this.products.push(result[i])
        }
        console.log(this.products.length)
      } catch (error) {
        console.log('Error' + error)
        alert('Invalid call')
      }
    },
    itemStateToString (state) {
      this.itemstate = ''
      switch (state) {
        case '0': this.itemstate = 'Created'
          break
        case '1': this.itemstate = 'Integrated'
          break
        case '2': this.itemstate = 'Manufactured'
          break
        case '3': this.itemstate = 'Tested and Dispatched'
          break
        case '4': this.itemstate = 'Purchased'
          break
        default: this.itemstate = 'Created'
      }
      console.log(state)
      return this.itemstate
    },
    async fetchProductDetails () {
      this.productDetails = []
      try {
        await this.readProducts()
        console.log(this.products.length)
        for (var i = 0; i < this.products.length; i++) {
          console.log('inside for of fetch product details')
          const details = await manufacturerInstance.methods.fetchProductDetails(this.products[i]).call({from: global.ethereum.selectedAddress})
          // eslint-disable-next-line no-new-object
          var info = Object.assign({}, {products_id: this.products[i], product_name: details.productName, product_model: details.productModel, product_info: details.productInfo, components_used: details.components, components_verification_report: details.componentVerificationReport, distributor_id: details.distributorID, customer_id: details.customerID, item_state: this.itemStateToString(details.itemState)})
          this.productDetails.push(info)
        }
        console.log(this.productDetails)
      } catch (error) {
        console.log('Error' + error)
        alert('Invalid call 2')
      }
    }
  }
}
</script>
<style scoped>
.v-card__text {
  color: white!important;
}
.v-data-table__header{
  background-color: black;
}
footer{
  background-color: primary !important
}
.v-data-table{
  background-color:white ;
}
</style>
