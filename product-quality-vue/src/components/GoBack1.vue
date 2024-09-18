<template>
<v-row class="go-back align-left">
  <v-btn color="primary lighten-1"  fab small elevation="0" style= "margin-left: 320px" @click="goBack1">
      <v-icon>mdi-close-circle</v-icon>
  </v-btn>
</v-row>
</template>

<script>
export default {
  methods: {
    async goBack1 () {
      this.$router.go(-1)
    }
  }
}
</script>
