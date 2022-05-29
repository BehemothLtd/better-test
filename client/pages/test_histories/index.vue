<template>
  <div>
    <div class="container">
      <div class="text-center my-4">
        <span class="history-title">Test History</span>
      </div>
      <form class="d-flex py-4">
        <b-form-select
          class="select-option"
          v-model="projectId"
          :options="options"
          value-field="id"
          text-field="name"
          @change="onOption(projectId)"
        ></b-form-select>

        <b-form-select
          class="select-option"
          v-model="screenId"
          :options="screenOptions"
          value-field="id"
          text-field="name"
        ></b-form-select>

        <b-button
          class="ml-4 w-100px"
          type="submit"
          variant="success"
          @click.prevent="submitSearch"
          >Search</b-button
        >
      </form>
      <b-table responsive small :items="test_sessions" :fields="testSessions" class="history-table">
        <template #cell(index)="data">{{ data.index + 1 }} </template>
        <template #cell(name)="data">
          <a :href="`/test_histories/${data.item.id}`">{{ data.item.name }}</a>
        </template>
      </b-table>
    </div>
  </div>
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
        { key: "failed_total", label: "Failed" },
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
        const screens = await this.$axios.get(`screens?project_id=${id}`);
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
.history-title {
  font-size: 30px;
  font-weight: bold;
  background: linear-gradient(0deg, #a2eab3 35%, rgba(245, 248, 244, 0) 0);
}
.w-100px {
  width: 100px;
}
.history-table th {
  background-color: #d4edda;
}
</style>
