<template>
  <div class="container">
    <h4 class="my-4 text-center">CREATE TESTCASE</h4>
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
