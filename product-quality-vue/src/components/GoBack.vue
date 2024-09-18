/* eslint-disable vue/no-parsing-error */
<template>
<v-row class="go-back align-left">
  <v-col class="text-left">
  <v-btn color="primary"  fab elevation="12" style= "margin-left: 15px; margin-top: 15px" @click="goBack">
      <v-icon>mdi-arrow-left-circle</v-icon>
  </v-btn>
  </v-col>
  <div class="text-center">
  <v-dialog v-model="dialog1" width="700">
  <template v-slot:activator="{ on, attrs }">
  <v-col class="text-right primary--text" style= "margin-right: 20px; margin-top: 20px; font-family:Arial, Helvetica, sans-serif">
  <v-span>
    <v-btn color="primary"  light v-bind="attrs" v-on="on" > <v-icon> mdi-account-circle </v-icon> </v-btn>
  </v-span>
    <strong>{{selectedAddress}}</strong>
  </v-col>
  </template>
  <v-card>
          <v-card-title class= "text-h6 text-center primary lighten-1" style="color: white; padding-right: 150px">
            SIGN OUT?
          </v-card-title>
          <v-card-text>
              <v-container>
              <v-row>
                <v-col cols="9" >
                    <v-card-text>
                        Are you sure you want to sign out?
                    </v-card-text>
                </v-col>
                </v-row>
                <v-btn color="primary" @click="removeAccount(),goBack">
                    YES</v-btn>
                <v-btn color="primary" @click="dialog1=false"> NO</v-btn>
                </v-container>
          </v-card-text>
    </v-card>
  </v-dialog>
  </div>
</v-row>
</template>

<script>
import supplyInstance from '../../../supplyChainInstance'
export default {
  data: () => ({
    dialog1: false,
    selectedAddress: window.ethereum.selectedAddress
  }),
  methods: {
    async goBack () {
      this.$router.go(-1)
    },
    async removeAccount () {
      try {
        if (await supplyInstance.methods.isSupplier(this.selectedAddress).call()) {
          supplyInstance.methods.removeSupplier().send({from: this.selectedAddress})
        } else if (await supplyInstance.methods.isManufacturer(this.selectedAddress).call()) {
          supplyInstance.methods.removeManufacturer().send({from: this.selectedAddress})
        } else if (await supplyInstance.methods.isDistributor(this.selectedAddress).call()) {
          supplyInstance.methods.removeDistributor().send({from: this.selectedAddress})
        } else {
          supplyInstance.methods.removeCustomer().send({from: this.selectedAddress})
        }
      } catch (error) {
        alert(error)
        alert('invalid remove')
      }
    }
  }
}
</script>
