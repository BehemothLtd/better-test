<template>
  <div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center">
      <div class="h6 text-truncate mb-0">SCREEN DETAIL</div>
      <nuxt-link
        :to="`/projects/${projectId}/screens/${screenId}/edit`"
        variant="white"
        class="p-2 cursor-pointer text-muted"
      >
        <i class="mdi mdi-24px mdi mdi-pencil line-height-1"></i>
      </nuxt-link>
    </div>
    <b-card class="mb-3">
      <template #header class="py-0 pr-0">
        <div class="h6 text-truncate mb-0">Screen detail</div>
      </template>

      <div>
        <div class="mb-2">Name: {{ screen.name }}</div>

        <div class="mb-2">Url: {{ screen.url }}</div>

        <label v-if="screen.pre_script" class="mb-2">
          Pre-script Scenario:
          <nuxt-link
            :to="`/projects/${projectId}/scenarios/${screen.pre_script_id}`"
          >
            {{ screen.pre_script.name }}
          </nuxt-link>
        </label>
      </div>
    </b-card>

    <b-card class="mb-3">
      <template #header class="py-0 pr-0">
        <div class="d-flex h6 text-truncate mb-0">Element in screen</div>
      </template>
      <b-table
        responsive
        small
        :items="screen.elements"
        :fields="elementFields"
        outlined
      >
        <template #cell(image)="data">
          <img
            v-if="data.item.image"
            :src="data.item.image"
            style="max-width: 100px; max-height: 100px"
          />
        </template>
      </b-table>
    </b-card>

    <b-card>
      <template #header class="py-0 pr-0">
        <div class="d-flex justify-content-between align-items-center">
          <div class="h6 text-truncate mb-0">Test cases</div>
          <div class="d-flex align-items-center">
            <nuxt-link
              :to="`/projects/${projectId}/screens/${screenId}/test_cases/new`"
              variant="white"
              class="p-2 cursor-pointer text-muted"
            >
              <i class="mdi mdi-24px mdi mdi-plus-circle line-height-1"></i>
            </nuxt-link>
            <b-button
              variant="white"
              class="p-2 cursor-pointer text-muted"
              @click="runTestCases"
            >
              <i class="mdi mdi-24px mdi mdi-play-circle line-height-1"></i>
            </b-button>
          </div>
        </div>
      </template>

      <b-table
        responsive
        small
        :items="test_cases"
        :fields="testCaseFields"
        outlined
      >
        <template #cell(actions)="data">
          <div class="d-flex align-items-center">
            <nuxt-link
              :to="`/projects/${projectId}/screens/${screenId}/test_cases/${data.item.id}`"
              class="btnAction"
              variant="white"
            >
              <i class="mdi mdi-pencil"></i>
            </nuxt-link>
            <b-button
              class="btnAction"
              variant="white ml-2"
              @click="deleteTestCase(data.item.id)"
            >
              <i class="mdi mdi-delete"></i>
            </b-button>
            <span
              role="button"
              class="ml-2"
              @click="runTestCase(data.item.id, data.item.name)"
            >
              <i class="mdi mdi-play-circle"></i>
            </span>
          </div>
        </template>
      </b-table>
    </b-card>
  </div>
</template>

<script>
import { createNamespacedHelpers } from "vuex";
const { mapState, mapActions } = createNamespacedHelpers("screens");

export default {
  name: "ScreenDetails",
  data() {
    return {
      elementFields: [
        { key: "image", label: "Element Image" },
        { key: "name", label: "Element Name" },
      ],
      testCaseFields: [
        { key: "name", label: "Test case" },
        { key: "actions", label: "Actions", thStyle: { width: "100px" } },
      ],
      projectId: "",
      screenId: "",
    };
  },

  mounted() {
    this.screenId = this.$route.params.screenId;
    this.getScreen(this.$route.params.screenId);
    this.getTestCases(this.$route.params.screenId);
    this.projectId = this.$route.params.id;
  },
  computed: {
    ...mapState(["screen", "test_cases"]),
  },
  methods: {
    ...mapActions(["getScreen", "getTestCases"]),

    async runTestCases() {
      const name = window.prompt("Please enter a name:");
      if (name) {
        try {
          await this.$axios.post(`/screens/${this.screenId}/run_test_cases`, {
            name,
          });
          this.$toast.success("Successfully");
          this.$router.push("/test_histories");
        } catch {
          this.$toast.error("Failed");
        }
      }
    },

    async deleteTestCase(id) {
      try {
        await this.$axios.delete(`/screens/${this.screenId}/test_cases/${id}`);
        this.getTestCases(this.screenId);
        this.$toast.success("Successfully");
      } catch {
        this.$toast.error("Failed");
      }
    },

    async runTestCase(id, name) {
      try {
        await this.$axios.post(`/test_cases/${id}/run`, {
          name: `Run ${name}`,
        });
        this.$toast.success("Successfully");
        this.$router.push("/test_histories");
      } catch {
        this.$toast.error("Failed");
      }
    },
  },
};
</script>
<style lang="scss">
.btnAction {
  padding: 0;
}
::v-deep.card-header {
  padding-top: 0 !important;
  padding-bottom: 0 !important;
}
a {
  color: black;
}
</style>
