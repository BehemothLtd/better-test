<template>
  <div class="container">
    <div class="text-center my-4">
      <span class="project-title">Project Detail</span>
    </div>
    <div class="table-screen">
      <table class="table table-centered table-nowrap">
        <thead>
          <tr>
            <th class="align-middle">Screen</th>
            <th class="text-right">
              <b-button
                :to="`/projects/${projectId}/screens/new`"
                variant="info"
                class="w-100px"
                >New</b-button
              >
            </th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(screen, index) in screens" :key="index">
            <td>{{ screen.name }}</td>
            <td class="text-right">
              <nuxt-link
                :to="`/projects/${projectId}/screens/${screen.id}`"
                class="mr-3 text-dark"
              >
                <i class="mdi mdi-magnify font-size-20"></i>
              </nuxt-link>
              <nuxt-link
                :to="`/projects/${projectId}/screens/${screen.id}/edit`"
                class="mr-3 text-dark"
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
    <div class="table-scenarios mt-5">
      <table class="table table-centered table-nowrap">
        <thead>
          <tr>
            <th class="align-middle">Scenarios</th>
            <th class="text-right">
              <b-button
                v-b-modal.modal-step
                variant="info"
                class="w-100px"
                :to="`/projects/${projectId}/scenarios/new`"
                >New</b-button
              >
            </th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(scenario, index) in scenarios" :key="index">
            <td>{{ scenario.name }}</td>
            <td class="text-right">
              <nuxt-link
                :to="`/projects/${projectId}/scenarios/${scenario.id}`"
                class="mr-3 text-dark"
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
.project-title {
  font-size: 30px;
  font-weight: bold;
  background: linear-gradient(0deg, #79d8e8 35%, rgba(245, 248, 244, 0) 0);
}

.font-size-20 {
  font-size: 20px;
}
.table-screen tr th {
  /* background-color: #f8d7da; */
  background-color: #d1ecf1;
}
tr td {
  background-color: #f9f9f9;
}
.cursor-pointer {
  cursor: pointer;
}
.w-100px {
  width: 100px;
}
</style>
