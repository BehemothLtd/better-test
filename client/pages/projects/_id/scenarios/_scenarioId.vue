<template>
  <div class="container">
    <h4 class="my-4 text-center">UPDATE SCENARIO</h4>
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
