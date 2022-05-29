<template>
  <div class="container">
    <h4 class="text-center my-4">Project Detail</h4>
    <div class="table-screen">
      <div class="d-flex justify-content-between mb-2">
        <h5>Screen</h5>
        <b-button v-b-modal.modal-step variant="dark">New</b-button>
      </div>
      <table class="table table-centered table-nowrap">
        <tbody>
          <tr v-for="(screen, index) in screens" :key="index">
            <td>{{ screen.name }}</td>
            <td class="text-right">
              <nuxt-link
                :to="`/projects/${projectId}/screens/${detail.id}`"
                class="mr-3 text-primary"
              >
                <i class="mdi mdi-magnify font-size-20"></i>
              </nuxt-link>
              <nuxt-link
                :to="`/projects/${projectId}/screens/${detail.id}/edit`"
                class="mr-3 text-primary"
              >
                <i class="mdi mdi-pencil font-size-20"></i>
              </nuxt-link>
              <nuxt-link to="/" class="mr-3 text-danger">
                <i class="mdi mdi-trash-can-outline font-size-20"></i>
              </nuxt-link>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="table-scenarios mt-4">
      <div class="d-flex justify-content-between mb-2">
        <h5>Scenarios</h5>
        <b-button v-b-modal.modal-step variant="dark">New</b-button>
      </div>
      <table class="table table-centered table-nowrap">
        <tbody>
          <tr v-for="(scenario, index) in scenarios" :key="index">
            <td>{{ scenario.name }}</td>
            <td class="text-right">
              <nuxt-link to="/" class="mr-3 text-danger">
                <i class="mdi mdi-trash-can-outline font-size-20"></i>
              </nuxt-link>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      details: [],
      projectId: "",
      screens: [],
      scenarios: [],
    };
  },
  computed: {},
  async mounted() {
    console.log(this.$route.params.id);
    const res = await this.$axios.get("/projects/" + this.$route.params.id);
    this.details = res.data.screens;
    this.projectId = this.$route.params.id;
    this.screens = res.data.screens;
    this.scenarios = res.data.scenarios;
  },
};
</script>
<style>
.font-size-20 {
  font-size: 20px;
}
tr:nth-child(even) {
  background-color: #f2f2f2;
}
.cursor-pointer {
  cursor: pointer;
}
</style>
