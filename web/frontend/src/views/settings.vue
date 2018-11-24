<template>
    <v-layout>
        <v-flex xs10 mt-4 sm8 ml-5>
            <v-card>
                <v-card-title>
                    <span 
                        class="mr-2 title"
                    >
                        Account
                    </span>
                    <v-icon>mdi-account-circle</v-icon>
                </v-card-title>
                <v-card-text>
                    <div>
                        <span
                            class="mr-2 body-2"
                        >
                            Nick
                        </span>
                        <br>
                        <span
                            class="ml-2 mr-5"
                        >
                            Your nick here
                        </span>
                        <v-btn
                            flat
                            class="mx-0 ml-5"
                        >
                        Edit
                        </v-btn>
                    </div>
                    <div>
                         <span
                            class="mr-2 body-2"
                        >
                            Email
                        </span>
                        <br>
                        <span
                            class="ml-2 mr-1"
                        >
                            example@email.com
                        </span>
                        <v-btn
                            flat
                            class="mx-0 ml-5"
                        >
                        Edit
                        </v-btn>
                    </div>
                     <div>
                         <span
                            class="mr-2 body-2"
                        >
                            Password
                        </span>
                        <br>
                        <span
                            class="ml-2 mr-3"
                        >
                            Password here ddd
                        </span>
                        <v-btn
                            flat
                            class="mx-0 ml-5"
                        >
                        Edit
                        </v-btn>
                    </div>
                </v-card-text>
            </v-card>
        </v-flex>
        <v-flex xs10 mt-4 mr-5 offset-sm1>
            <v-card>
                <v-card-title>
                    <span 
                        class="mr-2 title"
                    >
                        Other
                    </span>
                    <v-icon>mdi-earth</v-icon>
                </v-card-title>
                <v-card-text>
                    <div>
                        <v-icon>mdi-brightness-6</v-icon>
                        <span
                            class="ml-2 body-2"
                        >
                         Theme
                        </span>
                        <v-switch
                        :label="`Dark Theme`"
                        color="black"
                        v-model="goDark"
                        ></v-switch>
                    </div>
                </v-card-text>
            </v-card>
        </v-flex>
    </v-layout>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
@Component({
  components: {
  },
})
export default class Settings extends Vue {
    data() {
    return {
      goDark: false
    }
  }
  watch: {
      
  }
}
</script>