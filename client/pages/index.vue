<template>
  <div>
    <div class="dashboard container">
      <h4 class="text-center my-4">Dashboard</h4>
      <div v-for="(project, id) in projects" :key="id" :project="project">
        <nuxt-link :to="`/projects/${project.id}`">
          <b-alert variant="success" show class="d-flex">
            <div class="project-name">{{ project.name }}</div>
          </b-alert>
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
