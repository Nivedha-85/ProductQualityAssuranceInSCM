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
      :src="require('../../../images/manu3.jpg')"
      height="200px"
    ></v-img>

    <v-card-text style="background-color: #d6eaff; font-size: medium; color: black" >
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
    style="background-color: #d6eaff; margin-top:20px"
    elevation="6"
  >
    <v-img
      :src="require('../../../images/manufacturer.jpg')"
      height="200px"
    ></v-img>
    <v-card-text style="background-color: #d6eaff; font-size:medium; color: black" >
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
                  <v-text-field dense outlined v-model="newProduct.product_info" label="Information"></v-text-field>
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
    style="background-color: #d6eaff; margin-top:20px"
    elevation="6"
  >
    <v-img
      :src="require('../../../images/manu2.jpg')"
      height="200px"
    ></v-img>
    <v-card-text style="background-color: #d6eaff; font-size:medium; color: black" >
      Manufacturer can dispatch the products to the Distributor by clicking the Dispatch Product button
    </v-card-text>

    <div class="text-center">
      <v-dialog v-model="dialog3" width="500">
        <template v-slot:activator="{ on, attrs }">
          <v-btn class="elevation-6" color="primary" light v-bind="attrs" v-on="on" >
            Test & Dispatch
          </v-btn>
        </template>
        <v-card>
          <v-card-title class= "text-h5 text-center primary lighten-1" style="color: white; padding-left: 190px">
            Test & Dispatch
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
    style="background-color: #d6eaff; margin-top:20px"
    elevation="6"
  >
    <v-img
      :src="require('../../../images/manu4.jpg')"
      height="200px"
    ></v-img>
    <v-card-text style="background-color: #d6eaff; font-size:medium; color: black" >
      Manufacturer can view the details of the products by clicking the View Product Details Button
    </v-card-text>
    <div class="text-center">
  <v-dialog v-model="dialogView" width="1000">
      <template v-slot:activator="{ on, attrs }">
        <v-btn class="elevation-6" color="primary" light v-bind="attrs" v-on="on" @click="fetchProductDetails()">
          View Product Details
        </v-btn>
      </template>
      <v-card height="505px" width="1500px">
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
          <v-data-table :headers="headers" :items="productDetails" :search="search"  :items-per-page="5" class="elevation-9 mt-5" style="font-family:Arial, Helvetica, sans-serif">
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
</script>
<style scoped>
.v-card__text {
  color: rgba(0, 0, 0, 0.71) !important;
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
