<template>
  <div class="container">
    <div class="text-center my-4">
      <span class="scenario-title">Update Scenario</span>
    </div>
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

    scenarioId() {
      return this.$route.params.scenarioId;
    },
  },

  async mounted() {
    const res = await this.$axios.get(`scenarios/${this.scenarioId}`);
    this.scenario = res.data;
  },

  methods: {
    async save() {
      try {
        await this.$axios.put(`scenarios/${this.scenarioId}`, this.scenario);
        this.$toast.success("Successfully");
      } catch (error) {
        this.$toast.error("Failed");
      }
    },
  },
};
</script>
<style>
.scenario-title {
  font-size: 30px;
  font-weight: bold;
  background: linear-gradient(0deg, #a2eab3 35%, rgba(245, 248, 244, 0) 0);
}
</style>
