<template>
  <div class="container">
    <div class="text-center my-4">
      <span class="scenario-title">Create/Update Scenario</span>
    </div>
    <b-row class="align-items-center">
      <b-col sm="2">
        <label class="font-weight-bold">Name: </label>
      </b-col>
      <b-col sm="10">
        <b-input-group class="v-group mt-2 mb-1">
          <b-input placeholder="Tên scenario"></b-input>
        </b-input-group>
      </b-col>
    </b-row>

    <b-row class="align-items-center mb-2">
      <b-col sm="2">
        <label class="font-weight-bold">URL: </label>
      </b-col>
      <b-col sm="10">
        <b-input-group class="v-group mt-2 mb-1">
          <b-input placeholder="https://"></b-input>
        </b-input-group>
      </b-col>
    </b-row>

    <b-row class="align-items-center mt-2">
      <b-col sm="2">
        <label class="font-weight-bold">Step</label>
      </b-col>
      <b-col sm="10">
        <b-button v-b-modal.modal-step-scenarios variant="outline-info" class="px-3"
          >+ Add Step</b-button
        >
      </b-col>
    </b-row>

    <b-row class="align-items-center mt-2 text-right">
      <b-col sm="12">
        <b-button variant="outline-info" class="w-100px">Preview</b-button>
        <b-button variant="info" class="w-100px">Save</b-button>
      </b-col>
    </b-row>

    <b-modal id="modal-step-scenarios" modal-class="modal-type" hide-header>
      <b-row class="align-items-center">
        <b-col sm="3">
          <label>Element</label>
        </b-col>
        <b-col sm="9">
          <b-form-select></b-form-select>
        </b-col>
      </b-row>
      <ModalStepScenarios></ModalStepScenarios>
    </b-modal>
  </div>
</template>
<script>
import ModalStepScenarios from "~/components/common/ModalStepScenarios";
export default {
  components: { ModalStepScenarios },
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
.scenario-title {
  font-size: 30px;
  font-weight: bold;
  background: linear-gradient(0deg, #79d8e8 35%, rgba(245, 248, 244, 0) 0);
} 
.w-100px {
  width: 100px;
}
</style>
