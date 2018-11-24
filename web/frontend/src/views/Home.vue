<template>
  <v-layout>
    <v-flex xs12 mt-5 sm6 offset-sm3>
      <v-card>
        <v-img
          class="white--text"
          height="480px"
          src="https://c.slashgear.com/wp-content/uploads/2018/02/google-pixel-2.jpg"
        >
          <v-container fill-height fluid>
            <v-layout fill-height>
              <v-flex xs12 align-end flexbox>
                <span class="headline">Mobile App</span>
              </v-flex>
            </v-layout>
          </v-container>
        </v-img>
        <v-card-title>
          <div>
            <span class="grey--text">FitLocker</span><br>
            <span>Mobile app fro FitLocker</span>
          </div>
        </v-card-title>
        <v-card-actions>
          <v-btn flat color="orange" href="https://play.google.com/store">Check this out</v-btn>
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
export default class Home extends Vue {}
</script>
