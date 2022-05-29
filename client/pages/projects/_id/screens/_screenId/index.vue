<template>
  <div class="container screen-detail">
    <div class="d-flex justify-content-between align-items-center">
      <div class="mx-auto my-4">
        <span class="screen-title">Screen Detail</span>
      </div>
      <nuxt-link
        :to="`/projects/${projectId}/screens/${screenId}/edit`"
        variant="white"
        class="p-2 cursor-pointer text-danger"
      >
        <i class="mdi mdi-24px mdi mdi-pencil line-height-1"></i>
      </nuxt-link>
    </div>
    <b-card class="mb-3">
      <template #header class="py-0 pr-0">
        <div class="h6 text-truncate mb-0 font-weight-bold">Screen detail</div>
      </template>

      <div>
        <div class="mb-2"> <span class="font-weight-bold">Name: </span>{{ screen.name }}</div>

        <div class="mb-2"><span class="font-weight-bold">Url:</span> {{ screen.url }}</div>

        <label v-if="screen.pre_script" class="mb-2">
          <span class="font-weight-bold">Pre-script Scenario:</span>
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
        <div class="d-flex h6 text-truncate mb-0 bg-table font-weight-bold">Element in screen</div>
      </template>
      <b-table
        responsive
        small
        :items="screen.elements"
        :fields="elementFields"
        outlined
        class="screen-table"
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
          <div class="h6 text-truncate mb-0 font-weight-bold">Test cases</div>
          <div class="d-flex align-items-center">
            <nuxt-link
              :to="`/projects/${projectId}/screens/${screenId}/test_cases/new`"
              variant="white"
              class="p-2 cursor-pointer text-muted"
            >
              <i class="mdi mdi-24px mdi mdi-plus-circle line-height-1 text-danger"></i>
            </nuxt-link>
            <b-button
              variant="white"
              class="p-2 cursor-pointer text-muted"
              @click="runTestCases"
            >
              <i class="mdi mdi-24px mdi mdi-play-circle line-height-1 text-danger"></i>
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
        class="screen-table"
      >
        <template #cell(actions)="data" class="text-right">
          <b-button class="btnAction" variant="white">
            <i class="mdi mdi-pencil text-danger font-size-18"></i>
          </b-button>
          <b-button class="btnAction" variant="white">
            <i class="mdi mdi-delete text-danger font-size-18"></i>
          </b-button>
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
    this.getScreen(this.$route.params.screenId);
    this.getTestCases();
    this.projectId = this.$route.params.id;
    this.screenId = this.$route.params.screenId;
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
.screen-title {
  font-size: 30px;
  font-weight: bold;
  background: linear-gradient(0deg, #ffbbc1 35%, rgba(245, 248, 244, 0) 0);
}
.screen-detail .card-header {
  background-color: #f8d7da;
}
.font-size-18 {
  font-size: 18px;
}
</style>
