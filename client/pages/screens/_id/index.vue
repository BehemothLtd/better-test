<template>
  <div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center">
      <div class="h6 text-truncate mb-0">SCREEN DETAIL</div>
      <nuxt-link
        to="/screens/1"
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

        <label class="mb-2">Pre-script Scenario: {Scenario} </label>
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
        <template #cell(index)="data">{{ data.index + 1 }}</template>
      </b-table>
    </b-card>

    <b-card>
      <template #header class="py-0 pr-0">
        <div class="d-flex justify-content-between align-items-center">
          <div class="h6 text-truncate mb-0">Test cases</div>
          <div>
            <b-button variant="white" class="p-2 cursor-pointer text-muted">
              <i class="mdi mdi-24px mdi mdi-plus-circle line-height-1"></i>
            </b-button>
            <b-button variant="white" class="p-2 cursor-pointer text-muted">
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
        <template #cell(index)="data">{{ data.index + 1 }}</template>
        <template #cell(actions)="data">
          <b-button class="btnAction" variant="white">
            <i class="mdi mdi-pencil"></i>
          </b-button>
          <b-button class="btnAction" variant="white">
            <i class="mdi mdi-delete"></i>
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
        { key: "index", label: "Num" },
        { key: "image", label: "Element Image" },
        { key: "name", label: "Element Name" },
      ],
      testCaseFields: [
        { key: "index", label: "Num" },
        { key: "name", label: "Test case" },
        { key: "actions", label: "Actions", thStyle: { width: "100px" } },
      ],
    };
  },

  mounted() {
    this.getScreen();
    this.getTestCases();
  },
  computed: {
    ...mapState(["screen", "test_cases"]),
  },
  methods: {
    ...mapActions(["getScreen", "getTestCases"]),
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
</style>
