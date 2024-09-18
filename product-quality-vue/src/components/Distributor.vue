<template>
<div>
  <GoBack />
<v-row>
<v-col justify="left">
<template>
  <v-card
    class="mx-auto"
    max-width="344"
    height="350"
    style="background-color: rgba(178, 218, 241, 0.967); margin-top:30px"
    elevation="6"
  >
    <v-img
      :src="require('../../../images/distributor2.jpg')"
      height="200"
    ></v-img>

    <v-card-text style="background-color: rgba(178, 218, 241, 0.967); font-size: medium; color: black" >
      Distributor can verify the products by clicking the Verify Component button
    </v-card-text>
    <div class="text-center">
      <v-dialog v-model="dialog" width="500">
        <template v-slot:activator="{ on, attrs }">
          <v-btn class="elevation-6 mt-5"  color="primary" light v-bind="attrs" v-on="on" >
            Verify Product
          </v-btn>
        </template>
        <v-card>
          <v-card-title class= "text-h5 text-center primary lighten-1" style="color: white; padding-left: 170px">
            Verify Product
          </v-card-title>
          <v-card-text>
            <v-container>
              <v-row>
                <v-col cols="9" >
                  <v-text-field dense outlined v-model="verifyProduct.product_id" :rules="[verifyProd]" label="ID"></v-text-field>
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
    max-width="344"
    height="350"
    style="background-color: rgba(178, 218, 241, 0.967); margin-top:30px"
    elevation="6"
  >
    <v-img
      :src="require('../../../images/distributor.jpg')"
      height="200"
    ></v-img>

    <v-card-text style="background-color: rgba(178, 218, 241, 0.967); font-size: medium; color: black" >
      Distributor can verify and dispatch the products by clicking the Test and Dispatch Button
    </v-card-text>
    <div class="text-center">
      <v-dialog v-model="dialog3" width="500">
        <template v-slot:activator="{ on, attrs }">
          <v-btn class="elevation-6" color="primary" light v-bind="attrs" v-on="on" >
            Test and Dispatch Product
          </v-btn>
        </template>
        <v-card>
          <v-card-title class= "text-h5 text-center primary lighten-1" style="color: white; padding-left: 150px">
            Test and Dispatch
          </v-card-title>
          <v-card-text>
            <v-container >
              <v-row>
                <v-col cols="9" >
                  <v-text-field dense outlined v-model="dispatchProd.product_id" label="Product ID"></v-text-field>
                </v-col>
                <v-col cols="9" >
                  <v-text-field dense outlined v-model="dispatchProd.distributor_verification_report" label="Product Test Report"></v-text-field>
                </v-col>
                <v-col cols="9" >
                  <v-text-field dense outlined v-model="dispatchProd.customer_id" :rules="[verifyProductFunc,rules.required]" label="Customer ID"></v-text-field>
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
<v-col justify="right">
<template>
  <v-card
    class="mx-auto"
    max-width="344"
    height="350"
    style="background-color: rgba(178, 218, 241, 0.967); margin-top:30px"
    elevation="6"
  >
    <v-img
      :src="require('../../../images/distributor1.jpg')"
      height="200"
    ></v-img>

    <v-card-text style="background-color: rgba(178, 218, 241, 0.967); font-size: medium; color: black" >
      Distributor can view the details of the products by clicking the View Product Details Button
    </v-card-text>
    <div class="text-center">
      <v-dialog v-model="dialogView" width="1000">
      <template v-slot:activator="{ on, attrs }">
        <v-btn class="elevation-6" color="primary" light v-bind="attrs" v-on="on" @click="fetchProductDetails()">
          View Product Details
        </v-btn>
      </template>
      <v-card height="500" width="1000px">
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
              No Products available
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
<v-col>
<template>
  <v-card class="mx-auto"
    max-width="344"
    height="350"
    style="background-color: rgba(178, 218, 241, 0.967); margin-top:30px"
    elevation="6">
    <v-dialog v-model="dialog4" width="500">
      <template v-slot:activator="{ on, attrs }">
        <v-btn class="elevation-6" color="primary" light v-bind="attrs" v-on="on" >
            QR CODE GENERATOR
          </v-btn>
      </template>
      <v-card>
          <v-card-title class= "text-h5 text-center primary lighten-1" style="color: white; padding-left: 150px">
            QR Code Generator
          </v-card-title>
          <v-card-text>
            <v-container >
              <v-row>
                <v-col cols="12" style="height: 200px">
                  <qrcode-vue id="capture" v-if="QRValue" :value="QRValue" :size="120" level="H" />
                </v-col>
                <v-col cols="3.5"></v-col>
                <v-col cols="5">
                  <v-text-field dense outlined v-model="QRValue" label="Product ID"></v-text-field>
                </v-col>
                <v-col >
                  <v-btn v-if="QRValue" color="primary lighten-1" fab small elevation="0" style="margin-left: 20px" @click="downloadQRCode()">
                  <v-icon dark> mdi-tray-arrow-down </v-icon>
                  </v-btn>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-divider></v-divider>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary" @click="dialog4 = false,resetQR()">
            CANCEL
            <v-icon
        right
        dark
      >
        mdi-close-circle
      </v-icon>
          </v-btn>
          <v-btn color="primary" @click="resetQR()">
            RESET
            <v-icon
        right
        dark
      >
        mdi-replay
      </v-icon>
          </v-btn>
          </v-card-actions>
        </v-card>
    </v-dialog>
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
import distributorInstance from '../../../supplyChainInstance'
import GoBack from './GoBack'
import QrcodeVue from 'qrcode.vue'
/* eslint-disable */ 
export default {
  name: 'Distributor',
  components: {
    QrcodeVue,
    GoBack
  },
  data: () => ({
    QRValue : null,
    dialog: false,
    dialogView: false,
    dialog4: false,
    verification: false,
    verified: false,
    products: [],
    productDetails: [],
    itemstate: '',
    verifyProduct: {
      product_id: ''
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
      { text: 'Manufacturer ID', value: 'manufacturer_id', sortable: false, filterable: false, align: 'center', width: '240px' },
      { text: 'Distributor Verification Report', value: 'distributor_verification_report', sortable: false, filterable: false, align: 'center', width: '240px' },
      { text: 'Customer ID', value: 'customer_id', sortable: false, filterable: false, align: 'center', width: '240px' },
      { text: 'Item State', value: 'item_state', sortable: false, filterable: false, align: 'center', width: '240px' }
    ],
    dialog2: false,
    step: 1,
    dialog3: false,
    dispatchProd: {
      product_id: '',
      distributor_verification_report: '',
      customer_id: ''
    },
    defaultDispatchProd: {
      product_id: '',
      distributor_verification_report: '',
      customer_id: ''
    },
    rules: {
      required: v => !!v || 'Customer ID is required'
    }
  }),
  methods: {
    resetQR(){
      this.QRValue=''
    },
    downloadQRCode () {
     var canvas1 = document.getElementsByTagName("canvas")[0];    
     var link = document.createElement('a');           
     link.href = canvas1.toDataURL("image/png");   
     link.download = this.QRValue+".png"; /// change item
     link.click();   
    },
    async IsDistributor () {
      console.log(window.ethereum.selectedAddress)
      const result2 = await distributorInstance.methods.isDistributor(window.ethereum.selectedAddress).call()
      console.log(result2)
      if (result2) {
        alert('This account is a registered distributor')
      } else {
        alert("This account isn't registered distributor")
      }
    },
    reset () {
      this.verifyProduct = Object.assign({}, {product_id: ''})
      this.verification = false
    },
    resetProduct () {
      this.newProduct = Object.assign({}, this.defaultProduct)
    },
    async verifyProductFunc () {
      try {
        const result2 = await distributorInstance.methods.isCustomer(this.dispatchProd.customer_id).call()
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
    async verifyProd (val) {
      try {
        const product = await distributorInstance.methods.fetchProductDetails(val).call()
        if (window.ethereum.selectedAddress === product.distributorID.toLowerCase()) {
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
    resetDispatchProd () {
      this.dispatchProd = Object.assign({}, this.defaultDispatchProd)
      this.verified = ''
    },
    async dispatchProduct () {
      console.log(this.dispatchProd)
      try {
        const result3 = await distributorInstance.methods.productTestAndDelivery(this.dispatchProd.product_id, this.dispatchProd.distributor_verification_report, this.dispatchProd.customer_id).send({from: window.ethereum.selectedAddress, gas: 3000000})
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
        const result = await distributorInstance.methods.fetchProductsOfDistributor().call({from: window.ethereum.selectedAddress})
        for (var i = 0; i < result.length; i++) {
          this.products.push(result[i])
        }
        console.log('inside read products of distributor')
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
          const details = await distributorInstance.methods.fetchProductDetails(this.products[i]).call({from: global.ethereum.selectedAddress})
          console.log(details.distributorID)
          // eslint-disable-next-line no-new-object
          var info = Object.assign({}, {products_id: this.products[i], product_name: details.productName, product_model: details.productModel, product_info: details.productInfo, manufacturer_id: details.manufacturerID, distributor_verification_report: details.distributorVerificationReport, customer_id: details.customerID, item_state: this.itemStateToString(details.itemState)})
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
