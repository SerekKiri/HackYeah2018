<template>
    <v-layout>
    <v-flex xs12 mt-3 sm6 offset-sm3>
      <v-card>
        <v-card-title>
           <h3 class="headline mb-0">Time:</h3>
        </v-card-title>
        <v-card-text class="ml-4 title">
          <v-list>
              <v-list-subheader class="ma-2">
                21:37
              </v-list-subheader>
          </v-list>
        </v-card-text>
        <v-card-actions>
          <v-btn flat color="orange">Extension</v-btn>
        </v-card-actions>
      </v-card>
      <v-spacer></v-spacer>
      <v-card class="mt-3">
        <v-card-title>
           <h3 class="headline mb-0">Points</h3>
        </v-card-title>
        <v-card-text class="ml-4 title">

        </v-card-text>
        <v-card-actions>
          <v-btn 
            flat
            disabled
            color="orange"
          >
            Buy points
          </v-btn>
        </v-card-actions>
      </v-card> 
      <v-spacer></v-spacer>
      <v-card class="mt-3">
        <v-card-title>
           <h3 class="headline mb-0">History</h3>
        </v-card-title>
        <v-card-text class="ml-4 title">

        </v-card-text>
        <v-card-actions>
          <v-btn 
            flat
            color="orange"
            to="/history"
          >
          Check History</v-btn>
        </v-card-actions>
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
export default class Dashboard extends Vue {
  data () {
      return {
        datacollection: null
      }
    }
}
</script>