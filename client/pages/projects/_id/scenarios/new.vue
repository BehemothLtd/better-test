<template>
  <div class="container">
    <h4 class="my-4 text-center">CREATE SCENARIO</h4>
    <ScenarioForm :form="scenario" is-scenario @save="save"></ScenarioForm>
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
      scenario: {
        steps: [],
        name: "",
        url: "",
      },
    };
  },

  computed: {
    projectId() {
      return this.$route.params.id;
    },
  },

  methods: {
    async save() {
      try {
        this.scenario.project_id = this.projectId;
        await this.$axios.post("scenarios", this.scenario);
        this.$router.push(`/projects/${this.projectId}`);
        this.$toast.success("Successfully");
      } catch (error) {
        this.$toast.error("Failed");
      }
    },
  },
};
</script>
