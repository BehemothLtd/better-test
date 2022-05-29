<template>
  <div class="container">
    <h4 class="my-4 text-center">CREATE TESTCASE</h4>
    <b-row class="align-items-center">
      <b-col sm="2">
        <label>Name</label>
      </b-col>
      <b-col sm="10">
        <b-input-group class="v-group mt-2 mb-1">
          <b-input v-model="testCase.name" placeholder="Tên testcase"></b-input>
        </b-input-group>
      </b-col>
    </b-row>

    <b-row class="align-items-center mb-2">
      <b-col sm="2">
        <label>URL</label>
      </b-col>
      <b-col sm="10">
        <b-input-group class="v-group mt-2 mb-1">
          <b-input v-model="testCase.url" placeholder="https://"></b-input>
        </b-input-group>
      </b-col>
    </b-row>

    <b-row class="align-items-center mt-2">
      <b-col sm="2">
        <label>Step</label>
      </b-col>
      <b-col sm="10">
        <b-button @click="show" variant="dark">+ Add Step</b-button>
      </b-col>
    </b-row>

    <b-row class="align-items-center mt-2 text-right">
      <b-col sm="12">
        <!-- <b-button variant="outline-secondary">Preview</b-button> -->
        <b-button variant="success" @click="saveTestCase">Save</b-button>
      </b-col>
    </b-row>

    <b-table
      v-if="testCase && testCase.steps.length"
      class="mt-2"
      responsive
      small
      :items="testCase.steps"
      :fields="fields"
      outlined
    >
    </b-table>
    <ModalStepTestcase
      id="modal-step-testcase"
      modal-class="modal-type"
      ref="stepTestCaseModal"
      @submit="onSubmit"
    ></ModalStepTestcase>
  </div>
</template>
<script>
import ModalStepTestcase from "~/components/common/ModalStepTestcase";
export default {
  components: { ModalStepTestcase },

  data() {
    return {
      testCase: {
        steps: [],
        name: "",
        url: "",
      },

      fields: ["command", "value"],
    };
  },
  computed: {
    screenId() {
      this.$route.params.screenId;
    },
  },

  methods: {
    show() {
      this.$refs.stepTestCaseModal.show();
    },

    onSubmit(value) {
      this.testCase.steps = [...this.testCase.steps, value];
    },
    async saveTestCase() {
      const screenId = this.$route.params.screenId;
      try {
        const res = await this.$axios.post(
          `screens/${screenId}/test_cases`,
          this.testCase
        );
        if (res) {
          this.$toast.success("Successfully");
        }
      } catch (error) {}
    },
  },
  mounted() {},
};
</script>
<style>
.unit {
  position: absolute;
  top: 5px;
  right: 20px;
}
</style>
