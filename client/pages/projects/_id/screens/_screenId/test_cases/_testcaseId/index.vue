<template>
  <div class="container">
    <h4 class="my-4 text-center">CREATE/UPDATE TESTCASE</h4>
    <b-row class="align-items-center">
      <b-col sm="2">
        <label>Name</label>
      </b-col>
      <b-col sm="10">
        <b-input-group class="v-group mt-2 mb-1">
          <b-input placeholder="Tên testcase"></b-input>
        </b-input-group>
      </b-col>
    </b-row>

    <b-row class="align-items-center mb-2">
      <b-col sm="2">
        <label>URL</label>
      </b-col>
      <b-col sm="10">
        <b-input-group class="v-group mt-2 mb-1">
          <b-input placeholder="https://"></b-input>
        </b-input-group>
      </b-col>
    </b-row>

    <b-row class="align-items-center mt-2">
      <b-col sm="2">
        <label>Step</label>
      </b-col>
      <b-col sm="10">
        <b-button v-b-modal.modal-step-testcase variant="dark"
          >+ Add Step</b-button
        >
      </b-col>
    </b-row>

    <b-row class="align-items-center mt-2 text-right">
      <b-col sm="12">
        <b-button variant="outline-secondary">Preview</b-button>
        <b-button variant="success">Save</b-button>
      </b-col>
    </b-row>

    <b-modal id="modal-step-testcase" modal-class="modal-type" hide-header>
      <ModalStepTestcase></ModalStepTestcase>
    </b-modal>
  </div>
</template>
<script>
import ModalStepTestcase from "~/components/common/ModalStepTestcase";
export default {
  data() {
    return {
      selected_action: "click",
      selected_wait: "element",
      actions: [
        { value: "click", text: "Click" },
        { value: "open", text: "Open" },
        { value: "input", text: "Input" },
        { value: "wait", text: "Wait" },
        { value: "scenario", text: "Scenario" },
        { value: "assert", text: "Assert" },
      ],
      waits: [
        { value: "element", text: "Element" },
        { value: "seconds", text: "Seconds" },
      ],
    };
  },
  components: { ModalStepTestcase },
  methods: {
    showModal() {
      this.$refs.modal - type.show();
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
