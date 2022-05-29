<template>
  <div class="container">
    <h4 class="text-center my-4">Project Detail</h4>
    <div class="table-screen">
      <div class="d-flex justify-content-between mb-2">
        <h5>Screen</h5>
        <b-button :to="`/projects/${projectId}/screens/new`" variant="dark"
          >New</b-button
        >
      </div>
      <table class="table table-centered table-nowrap">
        <tbody>
          <tr v-for="(screen, index) in screens" :key="index">
            <td>{{ screen.name }}</td>
            <td class="text-right">
              <nuxt-link
                :to="`/projects/${projectId}/screens/${screen.id}`"
                class="mr-3 text-primary"
              >
                <i class="mdi mdi-magnify font-size-20"></i>
              </nuxt-link>
              <nuxt-link
                :to="`/projects/${projectId}/screens/${screen.id}/edit`"
                class="mr-3 text-primary"
              >
                <i class="mdi mdi-pencil font-size-20"></i>
              </nuxt-link>
              <span
                role="button"
                class="mr-3 text-danger"
                @click="deleteScreen(screen.id)"
              >
                <i class="mdi mdi-trash-can-outline font-size-20"></i>
              </span>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="table-scenarios mt-4">
      <div class="d-flex justify-content-between mb-2">
        <h5>Scenarios</h5>
        <b-button
          :to="`/projects/${projectId}/scenarios/new`"
          variant="dark"
          >New</b-button
        >
      </div>
      <table class="table table-centered table-nowrap">
        <tbody>
          <tr v-for="(scenario, index) in scenarios" :key="index">
            <td>{{ scenario.name }}</td>
            <td class="text-right">
              <nuxt-link
                :to="`/projects/${projectId}/scenarios/${scenario.id}`"
                class="mr-3 text-primary"
              >
                <i class="mdi mdi-pencil font-size-20"></i>
              </nuxt-link>
              <span
                role="button"
                class="mr-3 text-danger"
                @click="deleteScenario(scenario.id)"
              >
                <i class="mdi mdi-trash-can-outline font-size-20"></i>
              </span>
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
      projectId: "",
      screens: [],
      scenarios: [],
    };
  },
  mounted() {
    this.fetchProject();
  },
  methods: {
    async fetchProject() {
      const res = await this.$axios.get("/projects/" + this.$route.params.id);
      this.projectId = this.$route.params.id;
      this.screens = res.data.screens;
      this.scenarios = res.data.scenarios;
    },
    async deleteScreen(screenId) {
      if (window.confirm("Delete this?")) {
        await this.$axios.delete("/screens/" + screenId);
        this.fetchProject();
      }
    },
    async deleteScenario(scenarioId) {
      if (window.confirm("Delete this?")) {
        await this.$axios.delete("/scenarios/" + scenarioId);
        this.fetchProject();
      }
    },
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
