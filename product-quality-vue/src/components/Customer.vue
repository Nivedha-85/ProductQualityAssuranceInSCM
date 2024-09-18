<template>
  <div class="page">
    <span class="bg"></span>
    <GoBack />
    <v-card class="mx-auto" max-width="360" height="500" style="background-color: white" elevation="6">
      <v-card-title class= "text-h5 text-center primary lighten-1" style="color: white; padding-left: 100px">
        Check QR Code
      </v-card-title>
      <v-img
      :src="require('../../../images/Qr-code.gif')"
      v-if="!stream"
      height="100"
      width="100"
      style="margin-left: 130px; margin-top: 20px"
    ></v-img>
      <div style="background-color: transparent; margin-top: 40px; margin-bottom: 63px;" height="550" v-if = "checkQR == true">
        <v-btn v-if="!stream" class="primary" @click="stream=true">SCANNER</v-btn>
        <qrcode-stream v-if="stream" elevation="6" @init="onInit" @decode="onDecode"></qrcode-stream>
        <div style="margin-top: 12px; margin-bottom: 5px" class="black--text"><strong>OR</strong></div>
        <qrcode-capture @init="onInit" @decode="onDecode" ></qrcode-capture>
        <div v-if="!stream" style="margin-bottom: 98px">
        </div>
      </div>
      <div v-else style="margin-top: 30px; margin-bottom: 190px;">
      <v-img
      :src="require('../../../images/Qr-code.gif')"
      v-if="stream"
      height="100"
      width="100"
      style="margin-left: 130px; margin-top: 20px; margin-bottom: 20px"
    ></v-img>
       <div v-if="verified==true" class="green--text"><v-icon dark medium class="ml-1" color="green"> mdi-check-circle </v-icon><strong>VERIFIED PRODUCT</strong></div>
       <div v-else class="red--text" ><v-icon medium class="ml-1" color="red" v-if="verified==false"> mdi-close-circle </v-icon><strong>FAKE PRODUCT</strong></div>
      </div>
      <v-divider></v-divider>
      <v-card-actions>
      <v-btn color="primary" style="margin-top: 10px; margin-left: 10px" v-if="verified==true" @click="detailsPage"> SEE MORE DETAILS </v-btn>
      <v-spacer></v-spacer>
      <v-btn color="primary" style="margin-top: 10px; margin-right: 10px" @click="resetQR()">
        RESET
      <v-icon right dark>
        mdi-replay
      </v-icon>
      </v-btn>
      </v-card-actions>
      </v-card>
  </div>
</template>

<script>
</script>
<style scoped>
.qrcode-stream-wrapper{
    width: 70%;
    height: 50%;
    margin: auto;
}
.button,capture {
  background-color: blue;
}
.bg{
  width: 100%;
    height: 92%;
    position: absolute;
    top: 0;
    left: 0;
    background: url('../../../images/Qr-code-bg.gif') no-repeat center;
    transform: scale(1);
    background-size: 750px 600px;
    background-repeat: no-repeat;
    margin-left: 400px;
    margin-top: 50px;
}
.page{
  background-color: #d6eaff;
  height: 100%;
}
</style>
