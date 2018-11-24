<template>
    <v-layout>
    <v-flex xs12 mt-3 sm6 offset-sm3>
      <v-card>
        <v-card-title>
          <div>
            <span>Time:</span><br>
            <span>15:12</span>
          </div>
        </v-card-title>
        <v-card-actions>
          <v-btn flat color="orange">Extension</v-btn>
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
}
</script>