<template>
  <b-card>
    <template #header class="py-0 pr-0">
      <div class="d-flex justify-content-between align-items-center">
        <div class="h6 text-truncate mb-0">TEST HISTORY</div>
      </div>
    </template>
    <form class="d-flex">
      <b-form-select
        class="mb-3 select-option"
        v-model="projectId"
        :options="options"
        value-field="id"
        text-field="name"
        @change="onOption(projectId)"
      ></b-form-select>

      <b-form-select
        class="mb-3 select-option"
        v-model="screenId"
        :options="screenOptions"
        value-field="id"
        text-field="name"
      ></b-form-select>

      <b-button
        class="mb-3 ml-4"
        type="submit"
        variant="primary"
        @click.prevent="submitSearch"
        >Search</b-button
      >
    </form>

    <b-table responsive small :items="test_sessions" :fields="testSessions">
      <template #cell(index)="data">{{ data.index + 1 }} </template>
      <template #cell(name)="data">
        <a :href="`/test_histories/${data.item.id}`">{{ data.item.name }}</a>
      </template>
    </b-table>
  </b-card>
</template>

<script>
export default {
  name: "TestHistories",

  data() {
    return {
      testSessions: [
        { key: "index", label: "#" },
        { key: "name", label: "Name" },
        { key: "status", label: "Status" },
        { key: "total", label: "Total" },
        { key: "passed_total", label: "Passed" },
        { key: "failled_total", label: "Failled" },
        { key: "created_at", label: "Time" },
      ],
      options: [],
      screenOptions: [],
      projectId: "",
      screenId: "",
      test_sessions: [],
    };
  },

  async mounted() {
    const res = await this.$axios.get("test_sessions");
    this.test_sessions = res.data;
    const projects = await this.$axios.get("projects");
    const screens = await this.$axios.get("screens");
    this.options = projects.data;
    this.screenOptions = screens.data;
  },

  methods: {
    async onOption(id) {
      try {
        const screens = await this.$axios.get(`projects/${id}`);
        this.screenOptions = screens.data;
        this.screenId = "";
      } catch (error) {}
    },

    async submitSearch() {
      const params = { screen_id: this.screenId, project_id: this.projectId };

      const res = await this.$axios.get("test_sessions", { params });
      this.test_sessions = res.data;
    },
  },
};
</script>
<style lang="scss">
.select-option {
  width: 30%;
  margin-left: 10px;
}
</style>
