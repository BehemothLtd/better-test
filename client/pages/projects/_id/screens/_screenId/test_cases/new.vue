<template>
  <div class="container">
    <div class="my-4 text-center">
      <span class="create-title">Create Testcase</span>
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
  },

  methods: {
    async saveTestCase() {
      try {
        await this.$axios.post(
          `screens/${this.screenId}/test_cases`,
          this.testCase
        );
        this.$router.push(
          `/projects/${this.projectId}/screens/${this.screenId}`
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
.create-title {
  font-size: 30px;
  font-weight: bold;
  background: linear-gradient(0deg, #a2eab3 35%, rgba(245, 248, 244, 0) 0);
}
</style>