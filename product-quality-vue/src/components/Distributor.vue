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
    style="background-color: #d6eaff; margin-top:20px"
    elevation="6"
  >
    <v-img
      :src="require('../../../images/distributor2.jpg')"
      height="200"
    ></v-img>

    <v-card-text style="background-color: #d6eaff; font-size: medium; color: black" >
      Distributor can verify the products by clicking the Verify Product button
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
    max-width="250"
    height="370"
    style="background-color: #d6eaff; margin-top:20px"
    elevation="6"
  >
    <v-img
      :src="require('../../../images/manu.jpg')"
      height="200"
    ></v-img>

    <v-card-text style="background-color: #d6eaff; font-size: medium; color: black" >
      Distributor can test and dispatch the products by clicking the Test & Dispatch Button
    </v-card-text>
    <div class="text-center">
      <v-dialog v-model="dialog3" width="500">
        <template v-slot:activator="{ on, attrs }">
          <v-btn class="elevation-6" color="primary" light v-bind="attrs" v-on="on" >
            Test & Delivery
          </v-btn>
        </template>
        <v-card>
          <v-card-title class= "text-h5 text-center primary lighten-1" style="color: white; padding-left: 150px">
            Test & Delivery
          </v-card-title>
          <v-card-text>
            <v-container >
              <v-row>
                <v-col cols="9" >
                  <v-text-field dense outlined v-model="dispatchProd.product_id" label="Product ID"></v-text-field>
                </v-col>
                <v-col cols="9" >
                  <v-text-field dense outlined v-model="dispatchProd.distributor_verification_report" label="Verification Report"></v-text-field>
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
    max-width="250"
    height="370"
    style="background-color: #d6eaff; margin-top:20px"
    elevation="6"
  >
    <v-img
      :src="require('../../../images/manu4.jpg')"
      height="200"
    ></v-img>

    <v-card-text style="background-color: #d6eaff; font-size: medium; color: black" >
      Distributor can view the details of the products by clicking the View Product Details Button
    </v-card-text>
    <div class="text-center">
      <v-dialog v-model="dialogView" width="1000">
      <template v-slot:activator="{ on, attrs }">
        <v-btn class="elevation-6" color="primary" light v-bind="attrs" v-on="on" @click="fetchProductDetails()">
          View Product Details
        </v-btn>
      </template>
      <v-card height="505" width="1000px">
        <v-card-title class="text-h5 primary lighten-1" style="color:white; font-family: Georgia, 'Times New Roman', Times, serif">
          Products
          <v-spacer></v-spacer>
      <v-text-field
        v-model="search"
        append-icon="mdi-magnify"
        label="Search"
        color="white"
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
          <v-data-table :headers="headers" :items="productDetails" :search="search" :items-per-page="5" class="elevation-9 mt-5" style="font-family:Arial, Helvetica, sans-serif">
          <template v-slot:item.item_state="{ item }">
            <v-chip
              :color="getColor(item.item_state)"
              dark
            >
            {{ item.item_state }}
            </v-chip>
            </template>
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
    max-width="250"
    height="370"
    style="background-color: #d6eaff; margin-top:20px"
    elevation="6">
    <v-img
      :src="require('../../../images/qr.jpg')"
      height="200"
    ></v-img>

    <v-card-text style="background-color: #d6eaff; font-size: medium; color: black" >
      Distributor can generate the QR Code for the products by clicking the QR Code Generator Button
    </v-card-text>
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
                <v-col cols="5" style="margin-top: 10px">
                  <v-text-field dense outlined v-model="QRValue" label="Product ID"></v-text-field>
                </v-col>
                <v-col style="margin-top: 10px">
                  <v-btn v-if="QRValue" color="primary" fab small elevation="0" style="margin-left: 20px" @click="downloadQRCode()">
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
</script>
<style scoped>
.v-card__text {
  color: rgba(0, 0, 0, 0.71)!important;
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
