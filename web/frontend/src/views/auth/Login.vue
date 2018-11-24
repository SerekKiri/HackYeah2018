<template>
    <v-content>
        <v-container fluid fill-height>
            <v-layout align-center justify-center>
                <v-flex xs12 sm8 md4>
                    <v-card class="elevation-12">
                        <v-toolbar dark>
                            <v-toolbar-title>Login</v-toolbar-title>
                        </v-toolbar>
                        <v-card-text>
                            <v-form>
                                <v-text-field
                                    prepend-icon="mdi-account"
                                    name="Email"
                                    label="Email"
                                    type="text"
                                    v-model="email"
                                ></v-text-field>
                                <v-text-field
                                    prepend-icon="mdi-key"
                                    id="password"
                                    name="password"
                                    label="Password"
                                    type="password"
                                    v-model="password"
                                ></v-text-field>
                            </v-form>
                        </v-card-text>
                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="black" v-on:click="post()" outline>Login</v-btn>
                        </v-card-actions>
                    </v-card>
                </v-flex>
            </v-layout>
        </v-container>
    </v-content>
</template>

<script lang="ts">
import { Component, Vue , Watch, Prop} from "vue-property-decorator";
import axios from 'axios'

export default class LoginPage extends Vue {
    @Prop()
    email!: string;
    password!: string;
    userToken!: string;
    // data: [];
    // errors: [];
    async post() {
        await axios.post("/auth/login", {
                "email": this.email,
                "password": this.password,
        })
        .then(response => {
            console.log(response)
        })
        .catch(e => {
            console.log(e)
    })
    }
    mounted() {
        if(localStorage.email) {
            this.token = localStorage.token;
        }
    }
    token(newToken) {
      localStorage.token = newToken;
  }
    
}
</script>
