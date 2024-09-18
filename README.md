# ProductQuality

## To run this as a whole


<br />

### Step 1 : Download as a zip file

![image](https://user-images.githubusercontent.com/57282344/163674322-1a1e44eb-0df3-4195-aab4-b95d3d977fac.png)

<br />

---

<br />

### Step 2 : Extract all the files in the zip folder

![image](https://user-images.githubusercontent.com/57282344/163674404-1b25554e-9aa5-460f-a7e6-412c53f89583.png)

![image](https://user-images.githubusercontent.com/57282344/163674422-8a440f6a-4ff7-4cda-a45e-ac4566babdff.png)

<br />

---

<br />

### Step 3 : Open this folder in VS Code

![image](https://user-images.githubusercontent.com/57282344/163674447-7ae08e10-49a6-43f7-bb6b-efb6a11ae60e.png)

![image](https://user-images.githubusercontent.com/57282344/163674475-c5435f88-51c2-4a3b-8095-1d48aab0aa92.png)

<br />

---

<br />

### Step 4 : Move to the directory ProductQuality-master

![image](https://user-images.githubusercontent.com/57282344/163674511-af300e95-36dd-4ba0-9c53-88344d60f5f6.png)

It has the following contents

![image](https://user-images.githubusercontent.com/57282344/163674543-dd2e9b81-e02a-4ccd-956f-62f4f6574d01.png)

<br />

---

<br />

### Step 5 : Initialize npm here using this command (keep pressing the enter key when it asks questions)

        npm init

<br />

---
![image](https://user-images.githubusercontent.com/57282344/163674585-ad234bfb-3cb3-4623-bdf0-f3c54cb4b8c5.png)

<br />

---

<br />

### Step 6 : Install all the dependencies using this command

        npm install

![image](https://user-images.githubusercontent.com/57282344/163674655-3951f47c-be65-4446-ad6c-70c15f6325ad.png)

<br />

---

<br />

### Step 7 : Move to src folder in the folder product-quality

        cd product-quality-vue

        cd src

![image](https://user-images.githubusercontent.com/57282344/163674726-2f45ca3f-1e2c-439a-a88e-51a46b34dd94.png)

<br />

---

<br />

### Step 8 : Run the application

        npm run dev

![image](https://user-images.githubusercontent.com/57282344/163674778-4c3d094a-9e78-421b-a52d-5d1e6101c7ed.png)

<br />

It will prompt you to install webpack-cli

![image](https://user-images.githubusercontent.com/57282344/163674808-b544b5a7-b93f-48db-9d94-8e5182acfab1.png)

<br />

For the question,
        'Do you want to install 'webpack-cli' (yes/no):' type, 'yes'

![image](https://user-images.githubusercontent.com/57282344/163674888-d6fac6d7-443c-44ea-8dd5-ddf6c4c0bb4a.png)

<br />

![image](https://user-images.githubusercontent.com/57282344/163674829-2e7a49cc-e158-465e-8649-22b3880b4f18.png)

<br />

![image](https://user-images.githubusercontent.com/57282344/163686931-dafab82e-32c8-430e-83b7-90d00c04529a.png)

<br />

It will also give an error

![image](https://user-images.githubusercontent.com/57282344/163686969-6b854fe9-db81-42de-99ca-236191cb1dfa.png)

<br />

---

<br />

### Step 9 : To get rid of the error, use this command (in src folder itself)

        npm install -g webpack-dev-server
        
![image](https://user-images.githubusercontent.com/57282344/163687070-1672676a-6dd7-4bd2-8c65-e404083f0f04.png)

<br />

---

<br />

### Step 10 : Now run the application using the command

        npm run dev
        
![image](https://user-images.githubusercontent.com/57282344/163687142-e3010686-e0c6-4069-b720-8a25ed43740f.png)

Your application is now running!

<br />

---

<br />

### Output 

![image](https://user-images.githubusercontent.com/57282344/163687291-c36e25e1-7bac-47bf-9f2e-ead8d6115afd.png)

<br />

---

<br />

## How to make your transactions work

<br />

### abi

Click here to copy it from here after compiling the required Solidity file

![image](https://user-images.githubusercontent.com/57282344/163687230-37720e29-2715-4e76-b6e2-560da61240b0.png)

<br />

Copy this in your manuFacturerInstance.js file like this

![image](https://user-images.githubusercontent.com/57282344/163687364-82a91f6e-4679-4503-a8c2-ab776e04ef46.png)

<br />

Paste your abi at the place where the arrow originated

<br />

---

<br />

### deployed address

Click and copy from here

![image](https://user-images.githubusercontent.com/57282344/163687396-705da4a4-2902-4a40-86fb-b48dbcc0e22f.png)

<br />

Insert it here, at the highlighted place(after abi)

![image](https://user-images.githubusercontent.com/57282344/163687429-6e190bab-3764-4afa-9233-842f587da18e.png)

<br />

---

### owner account

It can be seen here

![image](https://user-images.githubusercontent.com/57282344/163687476-95ee95d5-8c5e-4df5-b071-5559e93883bb.png)

<br />

This is used in the from part while callling methods

![image](https://user-images.githubusercontent.com/57282344/163687520-c97d1261-9c74-49d6-a0f9-627b3977a65d.png)

<br />

---

## Adding Vuetify

### Step 1 : Go to the product-quality-vue folder and install vuetify using this command

        npm install vuetify

![image](https://user-images.githubusercontent.com/57282344/167879063-ba6fa5e4-bed5-4503-bd2d-0dcb8590547d.png)

Note : Make sure your version of Vue within the product-quality-vue is less than 3 as Vuetify is not compatible with Vue 3
       You can check this by using the following command within the product-quality-vue folder
       
![image](https://user-images.githubusercontent.com/57282344/167879824-6f5f3def-9601-44ad-8c7c-20f62eeb146b.png)

---

### Step 2 : Now install sass in the same folder

        npm install sass@~1.32 sass-loader deepmerge -D
        
![image](https://user-images.githubusercontent.com/57282344/167880571-4fccb86a-f06e-4c4f-8ea5-140fcce16f6b.png)

---

### Step 3 : Paste the following snippet in the rules part of web.base.config.js (product-quality-vue -> build -> web.base.config.js)

        {
        test: /\.s(c|a)ss$/,
        use: [
          'vue-style-loader',
          'css-loader',
          {
            loader: 'sass-loader',
            // Requires sass-loader@^7.0.0
            options: {
              implementation: require('sass'),
              indentedSyntax: true // optional
            },
            // Requires >= sass-loader@^8.0.0
            options: {
              implementation: require('sass'),
              sassOptions: {
                indentedSyntax: true // optional
              },
            },
          },
        ],
      },
      
 ![image](https://user-images.githubusercontent.com/57282344/167882179-07953799-5912-42e4-aa61-9416ad747cda.png)

This should be within    module.exports -> module -> rules

![image](https://user-images.githubusercontent.com/57282344/167882867-f6fdefe4-f0b8-4854-91a9-b1ebd44f3dd5.png)

---

### Step 4 : Create a plugins folder and create a file with the name vuetify.js ( product-quality-vue -> src -> plugins)

![image](https://user-images.githubusercontent.com/57282344/167883429-6fc8166a-edf1-4b17-9ae4-8426daba0bd1.png)

Now add the following code there

        import Vue from 'vue'
        import Vuetify from 'vuetify'
        import 'vuetify/dist/vuetify.min.css'

        Vue.use(Vuetify)

        const opts = {}

        export default new Vuetify(opts)

![image](https://user-images.githubusercontent.com/57282344/167883734-a5398a1e-d79a-40f8-bfaf-2949fd5aa7e6.png)

---

### Step 5 : Add this in the main.js file in src folder

        import Vue from 'vue'
        import App from './App'
        import router from './router'
        import vuetify from '@/plugins/vuetify'

        Vue.config.productionTip = false

        /* eslint-disable no-new */
        new Vue({
        el: '#app',
        router,
        vuetify,
        components: { App },
        template: '<App/>'
        })

---

### Step 6 : Substitute the template part of App.vue with the following

        <template>
         <div id="app">
           <v-app>
              <router-view/>
           </v-app>
        </div>
      </template>

---

### Step 7 : Move to the src folder

        cd src

![image](https://user-images.githubusercontent.com/57282344/167880855-e042bb7b-6f42-44a0-b25c-93c877d6825c.png)

---

### Step 8 : Run the application using the command

        npm run dev
        
---

## Adding QR code components

### Step 1 : Go to the product-quality-vue folder and install qrcode.vue

        npm install --save qrcode.vue@1.0.0
        
![qr-code](https://user-images.githubusercontent.com/57282344/172558104-dc9d8cc1-d43d-4cc5-bb8d-84192912e600.PNG)

NOTE : qrcode.vue@1.0.0 is used for Vue version 2 (which has been used so far in this project). If it is Vue version 3 (can check this by doing npm list vue), use this command instead

        npm install --save qrcode.vue

---

### Step 2 : Remain in the product-quality-vue folder and install vue-qrcode-reader

        npm install vue-qrcode-reader
        
 ![image](https://user-images.githubusercontent.com/57282344/172559051-2e8893e1-eee0-468e-9af6-6df70420a045.png)

NOTE : This is used for Vue version 2 (which has been used so far in this project). If it is Vue version 3 (can check this by doing npm list vue), use this command instead
        
        npm install vue3-qrcode-reader

---

## Possible errors






