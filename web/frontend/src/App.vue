<template>
  <v-app>
    <v-toolbar app>
      <v-toolbar-title class="headline text-uppercase">
        <span>FitLocker</span>
        <span class="font-weight-light">.IO</span>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn
        v-if="['login', 'home'].indexOf($route.name) > -1"
        flat
        to="/auth/register"
      >
        <span class="mr-2">Register</span>
        <v-icon>mdi-account-circle</v-icon>
      </v-btn>

      <v-btn
         v-if="['home', 'register'].indexOf($route.name) > -1"
        flat
        to="/auth/login"
      >
        <span class="mr-2">Log in</span>
        <v-icon>mdi-account</v-icon>
      </v-btn>
    </v-toolbar>

    <v-content>
      <router-view />
    </v-content>
  </v-app>
</template>


<script lang="ts">
import { Component, Vue } from "vue-property-decorator";

@Component({
  components: {
  },
})
export default class Home extends Vue {}
</script>