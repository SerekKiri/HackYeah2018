<template>
  <v-app>
    <v-toolbar app>
      <v-toolbar-title class="headline text-uppercase">
        <span>FitLocker</span>
        <span class="font-weight-light">.club</span>
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
      <v-btn
        flat
        disabled
        v-if="['dashboard'].indexOf($route.name) > -1"
      >
        <span class="mr-2">GO PRO</span>
        <v-icon>mdi-professional-hexagon</v-icon>
      </v-btn>

      <v-btn
        class="mr-0"
        flat
        v-if="['dashboard'].indexOf($route.name) > -1"
        to="/settings"
      >
        <span class="mr-2">Settings</span>
        <v-icon>mdi-settings</v-icon>
      </v-btn>

      <v-btn
        class="ml-0"
        flat
        v-if="['dashboard'].indexOf($route.name) > -1"
        v-on:click="logOut()"
        to="/"
      >
        <span class="mr-2 ml-0">Log out</span>
        <v-icon>mdi-exit-to-app</v-icon>
      </v-btn>
      <v-btn
        class="ml-0"
        flat
        v-if="['settings', 'history'].indexOf($route.name) > -1"
        to="/dashboard"
      >
        <span class="mr-2 ml-0">Go back</span>
        <v-icon>mdi-chevron-right</v-icon>
      </v-btn>
    </v-toolbar>

    <v-content>
      <router-view />
    </v-content>
    <v-footer
    >
      <span
        class="ml-2"
      >
        ChatPlug &copy; 2018
      </span>
    </v-footer>
  </v-app>
</template>


<script lang="ts">
import { Component, Vue } from "vue-property-decorator";

@Component({
  components: {
  },
  methods: {
    logOut() {
      localStorage.clear();
    }
  }
})
export default class Home extends Vue {}
</script>