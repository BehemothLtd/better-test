<template>
  <div class="container">
    <div class="my-4 text-center">
      <span class="testcase-title">Update Testcase</span>
    </div>
    <ScenarioForm :form="testCase" @save="saveTestCase"></ScenarioForm>
  </div>
</template>

<script>
import ScenarioForm from "@/components/common/ScenarioForm.vue";

export default {
  components: {
    ScenarioForm,
  },

  data() {
    return {
      testCase: {
        steps: [],
        name: "",
        url: "",
      },
    };
  },

  computed: {
    screenId() {
      return this.$route.params.screenId;
    },

    projectId() {
      return this.$route.params.id;
    },

    testCaseId() {
      return this.$route.params.testCaseId;
    },
  },

  async mounted() {
    const res = await this.$axios.get(
      `screens/${this.screenId}/test_cases/${this.testCaseId}`
    );
    this.testCase = res.data;
  },

  methods: {
    async saveTestCase() {
      try {
        await this.$axios.put(
          `screens/${this.screenId}/test_cases/${this.testCaseId}`,
          this.testCase
        );
        this.$toast.success("Successfully");
      } catch (error) {
        this.$toast.error("Failed");
      }
    },
  },
};
</script>
<style>
.testcase-title {
  font-size: 30px;
  font-weight: bold;
  background: linear-gradient(0deg, #a2eab3 35%, rgba(245, 248, 244, 0) 0);
}
</style>
