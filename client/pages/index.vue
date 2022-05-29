<template>
  <div>
    <div class="container">
      <div class="text-center my-4">
        <span class="dashboard-title">Dashboard</span>
      </div>
      <div v-for="(project, id) in projects" :key="id" :project="project">
        <nuxt-link :to="`/projects/${project.id}`">
          <b-alert variant="info" show class="d-flex">
            <div class="project-name">{{ project.name }}</div>
          </b-alert>
        </nuxt-link>
      </div>

      <div>
        <nuxt-link to="/test_histories">
          <b-alert variant="success" show class="d-flex font-weight-bold"> Test Histories </b-alert>
        </nuxt-link>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "IndexPage",
  data() {
    return {
      projects: [],
    };
  },
  async mounted() {
    const res = await this.$axios.get("projects");
    this.projects = res.data;
  },
};
</script>
<style>
.dashboard-title {
  font-size: 30px;
  font-weight: bold;
  background: linear-gradient(0deg, #fdd86d 35%, rgba(245, 248, 244, 0) 0);
}
.project-name {
  font-weight: bold;
}
.alert-success:hover {
  background-color: #b8e2c2;
}
.alert-info:hover {
  background-color: #aedce4;
}
</style>
