<template>
<v-container class="main">
<span class="bg"></span>
  <div id="signIn">
    <v-dialog v-model="dialog" persistent width="800px" height="200px">
      <div>
        <v-card width="800px" height="380px">
          <v-card-title class="primary lighten-1 white--text">
              <span class="headline" style="padding-left: 350px">LOGIN</span>
              <GoBack1 />
          </v-card-title>
          <v-spacer></v-spacer>
          <v-card-text>
            <v-form ref="loginForm" v-model="valid" lazy-validation>
              <v-row>
                <v-col class="ml-9" style="padding-left: 140px; font-size: 15px" cols="9">
                  What role do you play?
                </v-col>
              </v-row>
              <v-row style="padding-bottom: 10px">
                <v-col class="ml-7" cols="2">
                  <v-btn color="primary" @click="IsSupplier()" > SUPPLIER </v-btn>
                </v-col>
                <v-col class="ml-10" cols="2">
                  <v-btn color="primary" @click="IsManufacturer()" > MANUFACTURER </v-btn>
                </v-col>
                <v-col class="ml-16" style="padding-left: 38px" cols="2">
                  <v-btn color="primary" @click="IsDistributor()" > DISTRIBUTOR </v-btn>
                </v-col>
                <v-col class="ml-16" style="padding-left: 40px" cols="2">
                  <v-btn color="primary" @click="IsCustomer()" > CUSTOMER </v-btn>
                </v-col>
              </v-row>
            </v-form>
          </v-card-text>
          <v-spacer></v-spacer>
          <v-card-title class="primary lighten-1 white--text">
              <span class="headline" style="padding-left: 280px">SIGNUP/REGISTER</span>
          </v-card-title>
          <v-row>
                <v-col class="ml-9" style="padding-left: 140px; padding-top: 30px; font-size: 15px; color: rgba(0,0,0,.6)" cols="9">
                  Click here to SignUp!
                </v-col>
              </v-row>
              <v-row>
              <v-col class="ml-1" style="padding-left: 360px; padding-bottom: 20px" cols="2">
                  <v-btn color="primary" @click="dialog2 = true,dialog = false"> SIGNUP </v-btn>
              </v-col>
              </v-row>

        </v-card>
      </div>
  </v-dialog>
  <div id="signUp">
    <v-dialog v-model="dialog2" persistent width="800px" height="250px">
      <div>
        <v-card width="800px" height="250px">
          <v-card-title class="primary lighten-1 white--text">
              <span class="headline" style="padding-left: 345px">SIGNUP</span>
              <v-btn color="primary lighten-1" fab small elevation="0" style="margin-left: 290px" @click="goBack()">
            <v-icon
        dark
      >
        mdi-close-circle
      </v-icon>
          </v-btn>
          </v-card-title>
          <v-spacer></v-spacer>
          <v-card-text>
            <v-form ref="loginForm" v-model="valid" lazy-validation>
              <v-row>
                <v-col class="ml-9"  style="padding-left: 140px; font-size: 15px;" cols="9">
                  What role do you play?
                </v-col>
              </v-row>
              <v-row class="mt-7">
                <v-col class="ml-9" cols="2">
                  <v-btn color="primary" @click="dialog = true,AddSupplier()"> SUPPLIER </v-btn>
                </v-col>
                <v-col class="ml-8" cols="2">
                  <v-btn color="primary" @click="dialog = true,AddManufacturer()"> MANUFACTURER </v-btn>
                </v-col>
                <v-col class="ml-16" style="padding-left: 32px" cols="2">
                  <v-btn color="primary" @click="dialog = true,AddDistributor()"> DISTRIBUTOR </v-btn>
                </v-col>
                <v-col class="ml-16" style="padding-left: 30px" cols="2">
                  <v-btn color="primary" @click="dialog = true,AddCustomer()"> CUSTOMER </v-btn>
                </v-col>
              </v-row>
            </v-form>
            </v-card-text>
             </v-card>
      </div>
  </v-dialog>
  </div>
 </div>
</v-container>
</template>

<script>
import contractInstance from '../../../supplyChainInstance'
import GoBack1 from './GoBack1'
export default {
  name: 'SignIn',
  components: {
    GoBack1
  },
  data: () => ({
    valid: true,
    dialog: true,
    dialog2: false,
    mainAddress: '0xA12b16d8aCDc921787bE89488F2eaF02b748F32C'
  }),
  methods: {
    async goBack () {
      this.$router.go('/SignIn')
    },
    async IsSupplier () {
      const result2 = await contractInstance.methods.isSupplier(global.ethereum.selectedAddress).call()
      console.log(result2)
      if (result2) {
        this.dialog = false
        alert('This account is a registered supplier')
        this.$router.push('/SignIn/Supplier')
      } else {
        alert("This account isn't registered supplier")
      }
    },
    async IsManufacturer () {
      console.log(window.ethereum.selectedAddress)
      const result2 = await contractInstance.methods.isManufacturer(window.ethereum.selectedAddress).call()
      console.log(result2)
      if (result2) {
        this.dialog = false
        alert('This account is a registered manufacturer')
        this.$router.push('/SignIn/Manufacturer')
      } else {
        alert("This account isn't registered manufacturer")
      }
    },
    async IsDistributor () {
      console.log(window.ethereum.selectedAddress)
      const result2 = await contractInstance.methods.isDistributor(window.ethereum.selectedAddress).call()
      console.log(result2)
      if (result2) {
        this.dialog = false
        alert('This account is a registered distributor')
        this.$router.push('/SignIn/Distributor')
      } else {
        alert("This account isn't a registered distributor")
      }
    },
    async IsCustomer () {
      console.log(window.ethereum.selectedAddress)
      const result2 = await contractInstance.methods.isCustomer(window.ethereum.selectedAddress).call()
      console.log(result2)
      if (result2) {
        this.dialog = false
        alert('This account is a registered customer')
        this.$router.push('/SignIn/Customer')
      } else {
        alert("This account isn't registered customer")
      }
    },
    async AddSupplier () {
      console.log(global.ethereum.selectedAddress)
      try {
        const result3 = await contractInstance.methods.addSupplier(global.ethereum.selectedAddress).send({from: this.mainAddress})
        console.log(result3)
        alert('Successful sign up')
      } catch (err) {
        console.log(err)
        alert('This account is already a registered supplier')
      }
    },
    async AddManufacturer () {
      console.log(global.ethereum.selectedAddress)
      try {
        const result3 = await contractInstance.methods.addManufacturer(global.ethereum.selectedAddress).send({from: this.mainAddress})
        console.log(result3)
        alert('Successful sign up')
      } catch (err) {
        console.log(err)
        alert('This account is already a registered manufacturer')
      }
    },
    async AddDistributor () {
      console.log(global.ethereum.selectedAddress)
      try {
        const result3 = await contractInstance.methods.addDistributor(global.ethereum.selectedAddress).send({from: this.mainAddress})
        console.log(result3)
        alert('Successful sign up')
      } catch (err) {
        console.log(err)
        alert('This account is already a registered distributor')
      }
    },
    async AddCustomer () {
      console.log(global.ethereum.selectedAddress)
      try {
        const result3 = await contractInstance.methods.addCustomer(global.ethereum.selectedAddress).send({from: this.mainAddress})
        console.log(result3)
        alert('Successful sign up')
      } catch (err) {
        console.log(err)
        alert('This account is already a registered customer')
      }
    }
  }
}
</script>
<style scoped>
.bg{
  width: 100%;
    height: 95%;
    position: absolute;
    top: 0;
    left: 0;
    background: url('../../../images/delivery5.jpg') no-repeat center center;
    background-size: cover;
    transform: scale(1.1);
}
</style>
