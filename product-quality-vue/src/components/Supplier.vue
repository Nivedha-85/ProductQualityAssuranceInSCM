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
      :src="require('../../../images/sup3.jpg')"
      height="200"
    ></v-img>

    <v-card-text style="background-color: rgba(178, 218, 241, 0.967); font-size: medium; color: black" >
      Supplier can add the details of all the components by clicking the Add Components button
    </v-card-text>
    <div class="text-center">
    <v-dialog v-model="dialog" width="500">
      <template v-slot:activator="{ on, attrs }">
        <v-btn class="elevation-6" color="primary" light  v-bind="attrs" v-on="on">
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
    style="background-color: rgba(178, 218, 241, 0.967); margin-top:30px"
    elevation="6"
  >
    <v-img
      :src="require('../../../images/sup1.jpg')"
      height="200px"
    ></v-img>

    <v-card-text style="background-color: rgba(178, 218, 241, 0.967); font-size:medium" >
      Supplier can dispatch the components to the manufacturer by clicking the Dispatch Component button
    </v-card-text>
    <div class="text-center">
    <v-dialog v-model="dialog2" width="500">
      <template v-slot:activator="{ on, attrs }">
        <v-btn class="elevation-6" color="primary" light v-bind="attrs" v-on="on" @click="readComponents()">
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
    style="background-color: rgba(178, 218, 241, 0.967); margin-top:30px"
    elevation="6"
  >
    <v-img
      :src="require('../../../images/supplier3.jpg')"
      height="200px"></v-img>
    <v-card-text style="background-color: rgba(178, 218, 241, 0.967); font-size:medium; color: black" >
      Supplier can view the details of all the components by clicking the View Details Button
    </v-card-text>
    <div class="text-center">
  <v-dialog v-model="dialogView" width="1000">
      <template v-slot:activator="{ on, attrs }">
        <v-btn class="elevation-6" color="primary" light v-bind="attrs" v-on="on" @click="fetchComponentDetails()">
          View  Component Details
        </v-btn>
      </template>
      <v-card height="500" width="1000px">
        <v-card-title class="text-h5 primary lighten-1" style="color:white; font-family: Georgia, 'Times New Roman', Times, serif">
          Components
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
            <v-data-table :headers="headers" :items="componentDetails" :search="search" class="elevation-9 mt-5" style="font-family:Arial, Helvetica, sans-serif">
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
import supplierInstance from '../../../supplyChainInstance'
import GoBack from './GoBack'
export default {
  components: {
    GoBack
  },
  name: 'Supplier',
  data: () => ({
    dialog: false,
    dialog2: false,
    dialogView: false,
    components: [],
    componentDetails: [],
    itemstate: '',
    newComponent: {
      component_id: '',
      component_name: '',
      component_model: '',
      component_info: '',
      component_price: ''
    },
    defaultComponent: {
      component_id: '',
      component_name: '',
      component_model: '',
      component_info: '',
      component_price: ''
    },
    search: '',
    headers: [
      {
        text: 'Components ID',
        align: 'center',
        // sortable: false,
        value: 'components_id',
        width: '240px'
      },

      { text: 'Components Name', value: 'components_name', sortable: false, filterable: false, align: 'center', width: '240px' },
      { text: 'Component Model', value: 'components_model', filterable: false, align: 'center', width: '240px' },
      // eslint-disable-next-line standard/object-curly-even-spacing
      { text: 'Component Info.', value: 'components_info', sortable: false, filterable: false, align: 'center', width: '240px'},
      // eslint-disable-next-line standard/object-curly-even-spacing
      { text: 'Component price', value: 'components_price', sortable: false, filterable: false, align: 'center', width: '240px'},
      // eslint-disable-next-line standard/object-curly-even-spacing
      { text: 'Manufacturer ID', value: 'manufacturer_id', sortable: false, filterable: false, align: 'center', width: '240px'},
      { text: 'Items State', value: 'item_state', sortable: false, filterable: false, align: 'center', width: '240px' }
    ],
    dispatchComp: {
      component_ids: [],
      manufacturer_id: ''
    },
    defaultDispatchComp: {
      component_ids: [],
      manufacturer_id: ''
    },
    verified: false,
    rules: {
      required: v => !!v || 'Manufacturer ID is required'
    }
  }),
  methods: {
    resetValidation () {
      this.$refs.form.resetValidation()
    },
    async IsSupplier () {
      console.log(window.ethereum.selectedAddress)
      const result2 = await supplierInstance.methods.isSupplier(window.ethereum.selectedAddress).call()
      return result2
    },
    async AddSupplier () {
      console.log(window.ethereum.selectedAddress)
      try {
        const result3 = await supplierInstance.methods.addSupplier(window.ethereum.selectedAddress).send({from: '0x4590Af5c29F41Ffe9937CaA7839F9Bf4E912A1AD'})
        console.log(result3)
      } catch (err) {
        console.log(err)
        alert('This account is already a registered supplier')
      }
    },
    async RenounceSupplier () {
      console.log(window.ethereum.selectedAddress)
      const result3 = await supplierInstance.methods.removeSupplier().send({from: window.ethereum.selectedAddress})
      console.log(result3)
    },
    reset () {
      this.newComponent = Object.assign({}, this.defaultComponent)
    },
    async verify () {
      try {
        const result2 = await supplierInstance.methods.isManufacturer(this.dispatchComp.manufacturer_id).call()
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
        console.log('Error: ' + err)
        this.verified = false
      }
    },
    async addComponent () {
      console.log(this.newComponent)
      try {
        const result3 = await supplierInstance.methods.componentProduced(this.newComponent.component_id, this.newComponent.component_name, this.newComponent.component_model, this.newComponent.component_info, this.newComponent.component_price).send({from: window.ethereum.selectedAddress, gas: 3000000})
        console.log(result3)
      } catch (err) {
        console.log('Error' + err)
        alert('Invalid entry')
      }
      this.reset()
    },
    resetDispatchComp () {
      this.dispatchComp = Object.assign({}, this.defaultDispatchComp)
      this.verified = ''
    },
    async dispatchComponent () {
      console.log(this.dispatchComp)
      try {
        for (var i = 0; i < this.dispatchComp.component_ids.length; i++) {
          const result3 = await supplierInstance.methods.componentDispatch(this.dispatchComp.component_ids[i], this.dispatchComp.manufacturer_id).send({from: window.ethereum.selectedAddress, gas: 3000000})
          console.log(result3)
        }
      } catch (err) {
        console.log('Error' + err)
        alert('Invalid entry')
      }
      this.resetDispatchComp()
    },
    async readComponents () {
      this.components = []
      try {
        const result = await supplierInstance.methods.fetchComponentsOfSupplier().call({from: window.ethereum.selectedAddress})
        for (var i = 0; i < result.length; i++) {
          this.components.push(result[i])
        }
        console.log(this.components.length)
      } catch (error) {
        console.log('Error' + error)
        alert('Invalid call')
      }
    },
    itemStateToString (state) {
      this.itemstate = ''
      switch (state) {
        case '0': this.itemstate = 'Produced'
          break
        case '1': this.itemstate = 'Dispatched'
          break
        default: this.itemstate = 'Produced'
      }
      console.log(state)
      return this.itemstate
    },
    async fetchComponentDetails () {
      this.componentDetails = []
      try {
        await this.readComponents()
        console.log(this.components.length)
        for (var i = 0; i < this.components.length; i++) {
          console.log('inside for')
          const details = await supplierInstance.methods.fetchComponentDetails(this.components[i]).call({from: global.ethereum.selectedAddress})
          // eslint-disable-next-line no-new-object
          var info = Object.assign({}, {components_id: details.componentID, components_name: details.componentName, components_model: details.componentModel, components_info: details.componentInfo, components_price: details.componentPrice, manufacturer_id: details.manufacturerID, item_state: this.itemStateToString(details.itemState)})
          this.componentDetails.push(info)
        }
        console.log(this.componentDetails)
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
