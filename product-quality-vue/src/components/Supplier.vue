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
    style="background-color: #d6eaff; margin-top:20px"
    elevation="6"
  >
    <v-img
      :src="require('../../../images/sup3.jpg')"
      height="200"
    ></v-img>

    <v-card-text style="background-color: #d6eaff; font-size: medium;">
      Supplier can add the details of the components by clicking the Add Component button
    </v-card-text>
    <div class="text-center">
    <v-dialog v-model="dialog" width="500">
      <template v-slot:activator="{ on, attrs }">
        <v-btn class="elevation-6 white--text" color="primary" v-bind="attrs" v-on="on">
          Add Component
        </v-btn>
      </template>
      <v-card>
        <v-card-title class= "text-h5 text-center primary lighten-1" style="color: white; padding-left: 150px">
          New Component
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-col cols="9" >
              <v-text-field dense outlined v-model="newComponent.component_id" label="ID"></v-text-field>
            </v-col>
            <v-col cols="9" >
              <v-text-field dense outlined v-model="newComponent.component_name" label="Name"></v-text-field>
            </v-col>
            <v-col cols="9" >
              <v-text-field dense outlined v-model="newComponent.component_model" label="Model"></v-text-field>
            </v-col>
            <v-col cols="9" >
              <v-text-field dense outlined v-model="newComponent.component_info" label="Information"></v-text-field>
            </v-col>
            <v-col cols="9" >
              <v-text-field dense outlined v-model="newComponent.component_price" label="Price"></v-text-field>
            </v-col>
          </v-container>
        </v-card-text>
        <v-divider></v-divider>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" @click="dialog = false,reset()">
            CANCEL
            <v-icon
        right
        dark
      >
        mdi-close-circle
      </v-icon>
          </v-btn>
          <v-btn color="primary" @click="reset()">
            CLEAR
            <v-icon
        right
        dark
      >
        mdi-backspace
      </v-icon>
          </v-btn>
          <v-btn color="primary" @click="dialog = false,addComponent()">
            SAVE
            <v-icon
        right
        light
      >
        mdi-content-save
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
    style="background-color: #d6eaff; margin-top:20px"
    elevation="6"
  >
    <v-img
      :src="require('../../../images/sup1.jpg')"
      height="200px"
    ></v-img>

    <v-card-text style="background-color: #d6eaff; font-size:medium" >
      Supplier can dispatch the components to the Manufacturer by clicking the Dispatch Component button
    </v-card-text>
    <div class="text-center">
    <v-dialog v-model="dialog2" width="500">
      <template v-slot:activator="{ on, attrs }">
        <v-btn class="elevation-6 white--text" color="primary" light v-bind="attrs" v-on="on" @click="readComponents()">
          Dispatch Component
        </v-btn>
      </template>
      <v-card>
        <v-card-title class= "text-h5 text-center primary lighten-1" style="color: white; padding-left: 200px" >
          Dispatch
        </v-card-title>
        <v-card-text>
          <v-container >
            <v-row>
              <v-col cols="9" >
                <v-combobox outlined v-model="dispatchComp.component_ids" :items="components" label="Component ID" multiple chips ></v-combobox>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="9" >
                <v-text-field dense outlined v-model="dispatchComp.manufacturer_id" :rules="[verify,rules.required]" label="Manufacturer ID"></v-text-field>
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
          <v-btn color="primary" @click="dialog2 = false,resetDispatchComp()">
            CANCEL
            <v-icon
        right
        dark
      >
        mdi-close-circle
      </v-icon>
          </v-btn>
          <v-btn color="primary" @click="resetDispatchComp()">
            CLEAR
            <v-icon
        right
        dark
      >
        mdi-backspace
      </v-icon>
          </v-btn>
          <v-btn color="primary" @click="dialog2 = false,dispatchComponent()">
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
    style="background-color: #d6eaff; margin-top:20px"
    elevation="6"
  >
    <v-img
      :src="require('../../../images/manu4.jpg')"
      height="200px"></v-img>
    <v-card-text style="background-color: #d6eaff; font-size:medium; color: black" >
      Supplier can view the details of the components by clicking the View Component Details Button
    </v-card-text>
    <div class="text-center">
  <v-dialog v-model="dialogView" width="1000">
      <template v-slot:activator="{ on, attrs }">
        <v-btn class="elevation-6 white--text" color="primary" v-bind="attrs" v-on="on" @click="fetchComponentDetails()">
          View  Component Details
        </v-btn>
      </template>
      <v-card height="505" width="1000px">
        <v-card-title class="text-h5 primary lighten-1" style="color:white; font-family: Georgia, 'Times New Roman', Times, serif">
          Components
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
            <v-icon dark>
        mdi-close-circle
      </v-icon>
          </v-btn>
        </v-card-title>
        <v-card-text>
          <v-container>
            <!-- TABLE TO ENTER / EDIT PRODUCT DETAILS REGARDING THE ORDER IN THE FORM -->
            <v-data-table :headers="headers" :items="componentDetails" :search="search" :items-per-page="5" class="elevation-9 mt-5" style="font-family:Arial, Helvetica, sans-serif">
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
                No components available
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
