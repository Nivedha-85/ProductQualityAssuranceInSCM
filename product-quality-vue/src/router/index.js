import Vue from 'vue'
import Router from 'vue-router'
import Customer from '@/components/Customer'
import Manufacturer from '@/components/Manufacturer'
import Distributor from '@/components/Distributor'
import Supplier from '@/components/Supplier'
import SignIn from '@/components/SignIn'
import Home from '@/components/Home'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
    },
    {
      path: '/SignIn',
      name: 'SignIn',
      component: SignIn
    },
    {
      path: '/SignIn/Manufacturer',
      name: 'Manufacturer',
      component: Manufacturer
    },
    {
      path: '/SignIn/Distributor',
      name: 'Distributor',
      component: Distributor
    },
    {
      path: '/SignIn/Supplier',
      name: 'Supplier',
      component: Supplier
    },
    {
      path: '/SignIn/Customer',
      name: 'Customer',
      component: Customer
    }
  ]
})
