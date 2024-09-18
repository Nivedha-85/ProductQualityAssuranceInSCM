<template>
  <div>
    <v-card class="mx-auto" max-width="360" height="550" style="background-color: rgba(178, 218, 241, 0.967); margin-top:30px" elevation="6">
      <v-card-title class= "text-h5 text-center primary lighten-1" style="color: white; padding-left: 150px">
        Check QR Code
      </v-card-title>
      <div style="background-color: transparent;" height="550" v-if = "checkQR == true">
        <v-btn v-if="!stream" @click="stream=true">SCANNER</v-btn>
        <qrcode-stream v-if="stream" elevation="6" @init="onInit" @decode="onDecode"></qrcode-stream>
        <div>OR</div>
        <qrcode-capture @init="onInit" @decode="onDecode" ></qrcode-capture>
      </div>
      <div v-else>
       <div v-if="verified==true"><v-icon dark x-large class="ml-1" color="primary"> mdi-check-circle </v-icon> VERIFIED </div>
       <div v-else><v-icon x-large class="ml-1" color="red" v-if="verified==false"> mdi-close-circle </v-icon> FAKE PRODUCT</div>
      </div>
      <v-divider></v-divider>
      <v-card-actions>
      <v-spacer></v-spacer>
      <v-btn color="primary" @click="resetQR()">
        RESET
      <v-icon right dark>
        mdi-replay
      </v-icon>
      </v-btn>
      </v-card-actions>
      </v-card>
      <v-btn color="primary" v-if="verified==true"> SEE MORE DETAILS </v-btn>
  </div>
</template>

<script>
import customerInstance from '../../../supplyChainInstance'
import { QrcodeStream, QrcodeCapture } from 'vue-qrcode-reader'
/* eslint-disable */
export default {
  name: 'Customer',
  components: {
    QrcodeStream,
    QrcodeCapture
  },
  data: () => ({
    decodedString: '',
    stream: false,
    checkQR: true,
    verified: false
  }),
  methods: {
    resetQR(){
      this.decodedString= ''
      this.stream= false
      this.checkQR= true
      this.verified= false
    },
    async onInit (promise) {
      try {
      const { capabilities } = await promise

      // successfully initialized
    } catch (error) {
      if (error.name === 'NotAllowedError') {
        this.error="user denied camera access permisson"
      } else if (error.name === 'NotFoundError') {
        this.error="no suitable camera device installed"
      } else if (error.name === 'NotSupportedError') {
        this.error="page is not served over HTTPS (or localhost)"
      } else if (error.name === 'NotReadableError') {
        this.error="maybe camera is already in use"
      } else if (error.name === 'OverconstrainedError') {
        this.error="did you requested the front camera although there is none?"
      } else if (error.name === 'StreamApiNotSupportedError') {
        this.error="browser seems to be lacking features"
      }
      alert(error)
    } finally {
      // hide loading indicator
    }
    },
    async onDecode (decodedString) {
      this.decodedString=decodedString
      this.verifyQR()
    },
    async verifyQR(){
      try {
        const product = await customerInstance.methods.fetchProductDetails(this.decodedString).call()
        if (window.ethereum.selectedAddress === product.customerID.toLowerCase()) {
          this.verified = true
        } else {
          this.verified = false
        }
      } catch (err) {
        console.log('Error: ' + err)
        this.verified = false
      }
      this.checkQR = false
    }
}
}
</script>
<style scoped>
.qrcode-stream-wrapper{
    width: 70%;
    height: 50%;
    margin: auto;
}
.button,capture {
  background-color:blue;
}
</style>