<template>
<div>
    <span class="bg"></span>
    <div>
        <v-btn color="blue dark"  fab elevation="12" style= "margin-left: 1100px; margin-top: 500px;" @click="nextPage()">
            <v-icon color="white">
                mdi-chevron-right-circle
            </v-icon>
        </v-btn>
    </div>
</div>
</template>

<script>
export default {
  name: 'Home',
  data: () => ({
  }),
  methods: {
    async nextPage () {
      this.$router.push('./SignIn')
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
